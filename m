Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5915223EA8B
	for <linux-serial@vger.kernel.org>; Sun,  4 Oct 2026 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791117099; cv=none; b=MpdJPSxNkuMpUtM1L3JeGEy56IQEoKNxePdwz3it0qiGajbxG0zMAxAr8Q7MqgfnOeMkvvxI+YgqEwQtN7osm36tF2rJUnXyAsAs93s8f77m1SSxD8iIvURErsyugscdD0+IcUHs9qQ2g2mjs+zs+7d2ZSbBhZv0xB58h5JzCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791117099; c=relaxed/simple;
	bh=YczrNmu2V5j97H0prCtTyVtc/LFvS4df0M9g6vyzcEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lfbm+ZJvNDDzHL+AhcTTmoOklT/wfEsICk/oBI4qE/4JQiogJ53TDZAFP/kCLoAK9dg4/1YTZyGfSaTzAsZEpvqcPdWsep6tbMnqpAIFOS5FSJ4pSsk8xBo3g/FjV6zQgp1ZIMf0Z1kw8E+hIITZSYmYiHPxSvv2qbKjH2ok4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B75aHJ8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B75aHJ8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B826B1F000FF;
	Sun,  4 Oct 2026 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791117097;
	bh=UeFRCefWmuUS9udQMir2cN3hCC0pcUJ4Sxcx97FRB/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B75aHJ8NgLdaZzybQqXQb/TgNgG4/A/gafZ5V6bYZ2yxqpPYBWrVIJpo2s4bQiA1q
	 eiw0L3OstC4kHWu33sIb1TP+YTRufCaBPVWr5DuwkYNErOu7mQcZAuwW66vJ5iyYH2
	 fhP7sj2LrrFE0KZWRYVTfFS+v9bso318CgKcR1YDlNnX6IJw7ZLvCrm918BHjesBgI
	 strVnFu7/q7oAKgpco7K2bcFYBhPZnJGDQuqXVpzHQV/b1YtF0BCRDzIAvnkqcXP1U
	 ikA7Po6ZhBSz63Tkt8NR+3M1Bu6qhxf85kXVMygCnSY8aL3+iBoVlAfpyBiK4Thl4q
	 nmAvbaPF8BoZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] serial: max310x: drive RTS in software when
 hardware delays are too short
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-8-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
 <20261004-max310x-rs485-sw-delay-v6-8-3a0ef13ed9e3@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:31:37 +0000
Message-Id: <20261004123137.B826B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] serial: max310x: start_tx() unconditionally rewinds active RTS env=
elope
- [High] serial: max310x: UAF due to timer resurrection bypassing tx_teardo=
wn interlock
- [Medium] serial: max310x: TOCTOU race in RTS control leaves pin permanent=
ly asserted
--

commit 0a0721a468435345830de47dd7875adbf5a41cb4
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: drive RTS in software when hardware delays are too short

This commit adds a software-driven RTS path for the max310x driver to handle
requested RTS delays that exceed what the hardware can natively time. It
uses an hrtimer and workqueues to toggle the RTS line and control transmiss=
ion
timing.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
[ ... ]
> +static void max310x_rts_work_proc(struct work_struct *ws)
> +{
> +	struct max310x_one *one =3D container_of(ws, struct max310x_one, rts_wo=
rk);
> +	struct uart_port *port =3D &one->port;
> +	bool rts_on =3D READ_ONCE(one->tx_state) !=3D MAX310X_TX_OFF ||
> +		      READ_ONCE(one->tx_break);
> +
> +	max310x_rts_ctl(port, max310x_rts_level(port, rts_on));

[Severity: Medium]
Is there a race condition in this lockless state check that could leave the
RTS pin permanently asserted?

If max310x_rts_work_proc executes concurrently with an rs485_config ioctl
that disables RS485, max310x_rs485_config clears tx_state to MAX310X_TX_OFF
but does not cancel any already-queued rts_work.

Could an already-queued rts_work evaluate rts_on based on an older tx_state,
or mistakenly compute an active level because SER_RS485_RTS_AFTER_SEND flags
still linger, and then overwrite the register?

Since RS485 is disabled, this would leave the transceiver permanently drivi=
ng
the bus.

[ ... ]
> +static void max310x_delayed_start_tx(struct uart_port *port)
> +{
> +	struct max310x_one *one =3D to_max310x_port(port);
> +
> +	WRITE_ONCE(one->tx_state, MAX310X_TX_WAIT_BEFORE_SEND);
> +	one->cancel_tx_delay_tmr =3D false;
> +	schedule_work(&one->rts_work);
> +}
> +
> +/* called with port.lock taken and irqs off */
>  static void max310x_start_tx(struct uart_port *port)
>  {
>  	struct max310x_one *one =3D to_max310x_port(port);
[ ... ]
> +		if (unlikely(res =3D=3D -1)) {
> +			one->cancel_tx_delay_tmr =3D true;
> +			uart_port_unlock(port);
> +			hrtimer_cancel(&one->tx_delay_tmr);
> +			uart_port_lock(port);
> +			/*
> +			 * The lock was dropped: a teardown may have run to
> +			 * completion meanwhile. Re-check before starting.
> +			 */
> +			if (one->tx_teardown)
> +				return;
> +		}
> +
> +		max310x_delayed_start_tx(port);
> +	} else {
> -	schedule_work(&one->tx_work);
> +		schedule_work(&one->tx_work);
> +	}
>  }

[Severity: High]
Does this unconditionally rewind an active RTS envelope?

When new data is written to the UART port ring buffer during an active
transmission, max310x_start_tx is called by the serial core while tx_state
is already MAX310X_TX_SEND.

By calling max310x_delayed_start_tx unconditionally, the state is forced
back to MAX310X_TX_WAIT_BEFORE_SEND. The scheduled rts_work will then
incorrectly re-arm tx_delay_tmr with delay_rts_before_send, even though
data is already shifting out.

Because the state is falsely set to MAX310X_TX_WAIT_BEFORE_SEND, the
TX-empty interrupt handler's attempt to arm the after-send hold via
max310x_delayed_stop_tx will abort.

Does start_tx need to check if the envelope is already active in the
MAX310X_TX_SEND phase, and simply schedule tx_work instead of resetting
the envelope?

[ ... ]
> +static bool max310x_adopt_hw_tx(struct max310x_one *one)
> +{
> +	struct uart_port *port =3D &one->port;
> +
> +	if (!max310x_port_read(port, MAX310X_TXFIFOLVL_REG) &&
> +	    kfifo_is_empty(&port->state->port.xmit_fifo))
> +		return false;
> +
> +	scoped_guard(spinlock_irqsave, &port->lock) {
> +		if (READ_ONCE(one->tx_state) !=3D MAX310X_TX_OFF)
> +			return true;
> +		WRITE_ONCE(one->tx_state, MAX310X_TX_SEND);
> +		one->cancel_tx_delay_tmr =3D false;
> +	}
> +
> +	return true;
> +}

[Severity: High]
Does this logic introduce a use-after-free risk by resurrecting the timer
after the port has been shut down?

If a concurrent ioctl queues rs_work right after max310x_remove cancels it:

max310x_remove()
    cancel_work_sync(&s->p[i].rs_work);

Since the UART port is unregistered after these cancellations, a concurrent
TIOCSRS485 operation can still queue rs_work. If this delayed rs_work
executes after max310x_shutdown sets the teardown interlocks, it will call
max310x_adopt_hw_tx.

Here, max310x_adopt_hw_tx unconditionally sets cancel_tx_delay_tmr to false
without checking if tx_teardown is true.

Could this arm tx_delay_tmr on the device structure after it has been shut
down, causing a use-after-free when the timer fires on the freed structure?

This problem wasn't introduced by this patch, as the sub-optimal teardown
ordering in max310x_remove is pre-existing, but this bypass of the teardown
interlock in max310x_adopt_hw_tx appears to create a new crash vector.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-max310x-rs=
485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com?part=3D8
