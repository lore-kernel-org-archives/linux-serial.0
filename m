Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1253D647C
	for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676553; cv=none; b=WcURmFNWE8waN2s/rPo6QoZMjZSeuN4hhGm96YkPir2pR8iqc0jOZojXKfMVlT91ntnduY1bl6LljkIaiqCVwMv+7mRgUz9quBLxNkikszS5K2VBFI1eAKFiWwsJvjHSS89F626SALMNuOQHg5Yggmrl3X52RRqOoic4kM0DEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676553; c=relaxed/simple;
	bh=IfDHao9K+avb9gGkQsSJLcpqNYTGm9Lxklt/Oqswwus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fd25x2rLsfYVFUUXYU/GgLiy3WHODXqeK3Fvyz1yQRfbVkPrV/TvM9piXe9B1YgAPzDFagzvsc1I9FhCtKo3OOk0wfP0iFwleSWV1+dRh3DlqSrIDLJUxPIYssvOfT9bvyNAz3V3urmmZR7vMdgc1MZ7ncBfav7VbphvAAuGv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgJClxEa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgJClxEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6557F1F00893;
	Tue, 29 Sep 2026 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790676536;
	bh=ENNmmjr/x4LCgVTRfEvC6yXPeyBkofQFMTqvs7tglWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dgJClxEaLSLq4abg4x13kN3PwqzeCkSXcE5JNw5kntFDgTL94WXh5DFnNqpYWOf0F
	 f/9sst2R9YcuvCMrOPEZHE11byIQyCsIfWW1Pvh2GgfwKCXuCZwM8955IBFjRtZeTi
	 UvxXCSIFattfVxUSQ8r/tN6sjzFJ3rMHbM2RmCak9oKC96XZcwX1LFFPYePqE8db6j
	 OJPbOXyaQh6PdQIaJoPdbYopwThaervnJrBQSH5X8VlsQ/6/B7XDrMpyTCDrfr57vS
	 V2C8TdPxtdQfil9RPPExBvdPP9cmMdQkJdpuwpRbINEKSytFHJ7LswjYy+RuY3dCAQ
	 oj5UnbAXAxe0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] serial: max310x: drive RTS in software when
 hardware delays are too short
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-7-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-7-ae46afa583f2@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:08:55 +0000
Message-Id: <20260929100856.6557F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] serial: max310x: sleeping while atomic in hrtimer on PREEMPT_RT
- [High] serial: max310x: start_tx breaks active software RTS envelope
- [High] serial: max310x: TOCTOU race in RTS idle level settling
--

commit f17935a866e2d71f09696adaa6e429cdd498b4f0
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: drive RTS in software when hardware delays are too short

This commit introduces a software-driven RTS path for the MAX310X serial dr=
iver
to handle RS485 RTS setup and hold delays that exceed the hardware's
capabilities. It uses a high-resolution timer and work queues to manage the
RTS envelope phases.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 8f8817b127c89..6ad27eb8a3258 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c

[ ... ]

> @@ -792,6 +837,68 @@ static void max310x_handle_rx(struct uart_port *port=
, unsigned int rxlen)
>  	tty_flip_buffer_push(&port->state->port);
>  }
> =20
> +static enum hrtimer_restart max310x_tmr_tx(struct hrtimer *timer)
> +{
> +	struct max310x_one *one =3D container_of(timer, struct max310x_one,
> +					       tx_delay_tmr);
> +
> +	guard(spinlock_irqsave)(&one->port.lock);

[Severity: Critical]
Does acquiring this lock cause a panic on PREEMPT_RT kernels?

The timer is set up with HRTIMER_MODE_REL, meaning this callback runs in
hardirq context. However, port->lock is a sleepable spinlock on PREEMPT_RT,
which will lead to a sleeping while atomic BUG.

[ ... ]

> +/* called with port.lock taken and irqs off */
>  static void max310x_start_tx(struct uart_port *port)
>  {
>  	struct max310x_one *one =3D to_max310x_port(port);
> =20
> -	schedule_work(&one->tx_work);
> +	/* A teardown is in progress; nothing may start an envelope or TX. */
> +	if (one->tx_teardown)
> +		return;
> +
> +	if (READ_ONCE(one->sw_rts_during_tx)) {
> +		/*
> +		 * The before- and after-send phases share one delay timer. If an
[ ... ]
> +			if (one->tx_teardown)
> +				return;
> +		}
> +
> +		max310x_delayed_start_tx(port);

[Severity: High]
Does this unconditional call to max310x_delayed_start_tx() overwrite the
active tx_state to MAX310X_TX_WAIT_BEFORE_SEND?

If userspace performs fragmented writes to the UART, uart_write() could
call max310x_start_tx() while the driver is actively transmitting (in the
MAX310X_TX_SEND state).

If the state is overwritten here, the after-send delay timer will not be
armed, potentially causing the RTS line to be held indefinitely or dropped
incorrectly, resulting in bus contention and packet loss.

> +	} else {
> +		schedule_work(&one->tx_work);
> +	}
>  }

[ ... ]

> @@ -983,12 +1156,48 @@ static void max310x_set_rts_ctl_params(struct max3=
10x_one *one)
[ ... ]
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		if (sw_rts) {
> +			/*
> +			 * Only settle RTS at idle when no transmission owns it.
> +			 * A reconfigure while one is in flight - rs_work runs
> +			 * on every TIOCSRS485 - would otherwise release the
> +			 * transceiver mid-character.
> +			 */
> +			if (READ_ONCE(one->tx_state) =3D=3D MAX310X_TX_OFF) {
> +				max310x_rts_ctl(port,
> +						max310x_rts_level(port, false));
> +				/*
> +				 * serial_core calls set_termios() without
> +				 * port->lock, so an envelope may have started
> +				 * while the idle level was written and the
> +				 * settle can land after its RTS assert.
> +				 * rts_work re-derives the level from
> +				 * tx_state; requeue it to converge.
> +				 */
> +				if (READ_ONCE(one->tx_state) !=3D MAX310X_TX_OFF)
> +					schedule_work(&one->rts_work);
> +			}

[Severity: High]
Can this lockless check and write sequence overwrite the RTS level to idle
during an active transmission envelope?

There appears to be a time-of-check to time-of-use race here between settli=
ng
the idle level and max310x_start_tx() starting a new RTS envelope.

If a userspace program changes terminal parameters or triggers an RS485
reconfiguration while data is being written, this could drive the RTS pin to
the idle state while data is actively transmitting, disabling the transceiv=
er
and dropping packets on the wire.

[ ... ]

> @@ -1557,6 +1846,11 @@ static int max310x_probe(struct device *dev, const=
 struct max310x_devtype *devty
>  		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
>  		/* Initialize queue for changing RS485 mode */
>  		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
> +		/* Initialize queue for software-driven RTS toggling */
> +		INIT_WORK(&s->p[i].rts_work, max310x_rts_work_proc);
> +		hrtimer_setup(&s->p[i].tx_delay_tmr, max310x_tmr_tx,
> +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);

[Severity: Critical]
Should this timer be configured to run in softirq context (e.g., using
HRTIMER_MODE_REL_SOFT) since its callback acquires port->lock?

As currently set up, it will run in hardirq context, leading to the PREEMPT=
_RT
sleep-while-atomic regression noted above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-max310x-rs=
485-sw-delay-v5-0-ae46afa583f2@vaisala.com?part=3D7
