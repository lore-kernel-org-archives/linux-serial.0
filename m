Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814804477FD
	for <linux-serial@vger.kernel.org>; Thu,  8 Oct 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453800; cv=none; b=gJgvewV++JGRfgGtEm+OPrGziKoJGSRfDPSSvDlrDZjWdkKcjz1ko6U3Ja/v13vhzShSwvq5ciwy+M/LRxM07R4kii2eevfK/IYWFl4cSJ880xvkSjkEy8vVuEhakk7gUIvwdxaQUzzzoh4HTEqB4PYuOOEr9mGuPdXTPMDpfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453800; c=relaxed/simple;
	bh=UAhefse1I5mZweTcMyuY0aKh2XdjRzvDRqY/3PAhKCU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WPPrMYQMWm0DFahYn/gs/WLlhKyDakBZNCZ54sJh7y5ntUsIm1R7tnTFOb3ZIyouFGqDqscfj5djpo05wz3YyAy1fD2M69AlzyOLv7E3QbDrPVzP2SQro43EDgDjGUlFPz8pyAyQNGBNazIczX2tDZaw/XhmSIxAQMx5PmEORNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwfUtS/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwfUtS/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D495A1F000FF;
	Thu,  8 Oct 2026 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453796;
	bh=yqU90KBa5m3LcLTYXHVy7TeM6vD9bHsqMar1pGa9zIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DwfUtS/5v1v1nFleZX2fcAk0FkSQ8cUuFHXyifI9Vir2gKT3eHplOqDrQgvqJ+wj5
	 vupTrBnA/U2N2t0C7YFXw+W58FE5Z4A1TnZmzJJxGEswIXb2aU4j7IjCQWlEF+4brH
	 bH4LjgR4C3e7YHx47kP4wisl42+FHmM6ClCkI3F9tbPkiRgE1u8d4DzwG8Jx+pgtpc
	 rqiKnvM6keVRuF2/7yLhEpiuyBaaWWQzfMKBwWXEAzuOcVfQEkFH/EUl8QdLyuKKG5
	 gJ9XULi9b8m0J7Loe6ysTpsgNfzLDHxqYvJ1vgImEobYPUnYthQI0D6FqhPMmMXsOj
	 D7g5yrPpfUYGw==
Message-ID: <sashiko-outbox-163982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/9] serial: max310x: drive RTS in software when
 hardware delays are too short
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-8-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
 <20261008-max310x-rs485-sw-delay-v8-8-6ba881f81e1f@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:03:15 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] tty: use-after-free in max310x_remove due to premature workque=
ue cancellation
- [High] tty: lockless kfifo check in max310x_delayed_stop_tx truncates RS4=
85 transmission
- [High] tty: TOCTOU race in max310x_rts_work_proc decouples timer arming f=
rom RTS assertion
- [High] tty: unprotected tx_state read in max310x_set_rts_ctl_params drops=
 RTS mid-transmission
- [Medium] tty: trailing hrtimer running state in max310x_delayed_stop_tx s=
trands RTS
- [Medium] tty: TOCTOU in max310x_rts_work_proc clobbers break_ctl RTS asse=
rtion
--

commit 05eccd91a3e45c1a75cc25465960c12d3c83b68c
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: drive RTS in software when hardware delays are too short
   =20
The commit adds a software-driven RTS path for max310x when requested RS485
delays exceed the hardware's 15 bit-time limit. It uses an hrtimer and a
workqueue to track before-send and after-send RTS envelope phases and
handle teardown interlocking.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index c1fe4ad887839..5fdb9dfca6027 100644
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
Can this sequence clobber a concurrent break_ctl() RTS assertion?

A concurrent max310x_break_ctl() sets tx_break and manually asserts the RTS
pin. If this function evaluates tx_break as false locklessly, gets preempted
while break_ctl() asserts RTS, and then resumes, it could write its stale
'false' evaluation to the hardware and drop the RTS pin prematurely.

> +
> +	guard(spinlock_irqsave)(&port->lock);
> +	if (READ_ONCE(one->tx_state) =3D=3D MAX310X_TX_WAIT_BEFORE_SEND &&
> +	    !one->cancel_tx_delay_tmr && !hrtimer_active(&one->tx_delay_tmr))
> +		hrtimer_start(&one->tx_delay_tmr,
> +			      ms_to_ktime(port->rs485.delay_rts_before_send),
> +			      HRTIMER_MODE_REL);
> +}

[Severity: High]
Does this lockless read decouple the timer arming from the physical RTS pin
assertion?

If a concurrent start_tx() sets tx_state to MAX310X_TX_WAIT_BEFORE_SEND and
queues a new rts_work after the lockless evaluation of rts_on but before
taking port->lock, the timer could be armed while the pin is still
deasserted, shortening the setup delay.

[ ... ]

> +static void max310x_delayed_stop_tx(struct uart_port *port)
> +{
> +	struct max310x_one *one =3D to_max310x_port(port);
> +	unsigned int txlvl;
> +
> +	if (READ_ONCE(one->tx_state) =3D=3D MAX310X_TX_OFF)
> +		return;
> +
> +	/*
> +	 * Data still queued for transmission defers the hold: a refill is
> +	 * coming and the envelope is not over. Stopped output does not
> +	 * count - it drains nowhere, and the envelope must end.
> +	 */
> +	if (!kfifo_is_empty(&port->state->port.xmit_fifo) &&
> +	    !uart_tx_stopped(port))
> +		return;
> +
> +	/*
> +	 * The kfifo can be empty while the chip TX FIFO is still draining, so =
arm
> +	 * the after-send hold only once the chip FIFO is empty too - the TX-em=
pty
> +	 * interrupt re-invokes us then. Otherwise the hold starts early and RTS
> +	 * drops mid-character, clipping the last byte(s).
> +	 */
> +	txlvl =3D max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
> +	if (txlvl)
> +		return;
> +
> +	/*
> +	 * Runs from tx_work without port->lock, so re-check the state under it:
> +	 * shutdown() may have cancelled the envelope meanwhile. Only
> +	 * MAX310X_TX_SEND may arm the hold.
> +	 */
> +	guard(spinlock_irqsave)(&one->port.lock);
> +	if (one->cancel_tx_delay_tmr ||
> +	    READ_ONCE(one->tx_state) !=3D MAX310X_TX_SEND)
> +		return;

[Severity: High]
Is it possible for the lockless checks performed earlier in this function
to evaluate as empty, but for new data to be queued concurrently before
acquiring port->lock?

If new data is queued by a concurrent start_tx(), the function will observe
tx_state is still MAX310X_TX_SEND without re-evaluating the FIFO, and arm
the after-send timer. This could drop the RTS pin mid-transmission when the
timer expires, truncating the RS485 frame.

> +
> +	if (!hrtimer_active(&one->tx_delay_tmr)) {

[Severity: Medium]
Could this check strand the RTS pin asserted?

The before-send timer callback releases the port lock and returns
HRTIMER_NORESTART, but the hrtimer core retains the running state until the
callback fully returns.

If tx_work executes concurrently, drains the FIFO, and enters this path
before the hrtimer core clears the running state, this check evaluates to
true. This skips starting the after-send hold, leaving tx_state stuck in
MAX310X_TX_SEND and never releasing the RTS pin.

> +		/*
> +		 * Add one character for the byte still in the shift register -
> +		 * TX-empty fires as it enters, not as it leaves.
> +		 */
> +		ktime_t delay =3D us_to_ktime(one->char_time_us +
> +					    port->rs485.delay_rts_after_send *
> +					    USEC_PER_MSEC);
> +
> +		WRITE_ONCE(one->tx_state, MAX310X_TX_WAIT_AFTER_SEND);
> +		hrtimer_start(&one->tx_delay_tmr, delay, HRTIMER_MODE_REL);
> +	}
> +}

[ ... ]

> @@ -957,25 +1165,35 @@ static void max310x_set_rts_ctl_params(struct max3=
10x_one *one)
>  	struct uart_port *port =3D &one->port;
>  	unsigned int setup =3D 0, hold =3D 0;
>  	u8 mode1 =3D 0, irda =3D 0;
> +	bool sw_rts =3D false;

[ ... ]

> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		if (sw_rts) {
> +			/*
> +			 * Only settle RTS at idle when no transmission owns it.
> +			 * A reconfigure while one is in flight - rs_work runs
> +			 * on every TIOCSRS485 - would otherwise release the
> +			 * transceiver mid-character. A transfer the hardware
> +			 * path owns is invisible to tx_state - adopt it
> +			 * instead of settling. The reverse strand also
> +			 * exists: an envelope the hardware path inherited
> +			 * mid-envelope leaves tx_state set with nothing
> +			 * driving the pin.
> +			 */
> +			if (READ_ONCE(one->tx_state) !=3D MAX310X_TX_OFF ||
> +			    max310x_adopt_hw_tx(one)) {
> +				/*
> +				 * The transfer may be running under auto-RTS:
> +				 * assert before auto-RTS is disabled below so
> +				 * the pin is never released under it, and arm
> +				 * the after-send hold - with the chip FIFO
> +				 * already drained no TX-empty interrupt
> +				 * arrives to arm it.
> +				 */
> +				max310x_rts_ctl(port,
> +						max310x_rts_level(port, true));
> +				max310x_delayed_stop_tx(port);
> +			} else {
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
Is there a race that could cause the RTS pin to drop mid-transmission?

Since tx_state is read locklessly, a concurrent start_tx() could initiate a
transmission and assert the RTS pin before this slow hardware write execute=
s.

The mitigation to requeue rts_work only re-asserts the RTS pin after it
was already dropped, which would irreparably corrupt the active RS485 frame.

[ ... ]

> @@ -1676,6 +2058,8 @@ static void max310x_remove(struct device *dev)
>  	int i;
> =20
>  	for (i =3D 0; i < s->devtype->nr; i++) {
> +		hrtimer_cancel(&s->p[i].tx_delay_tmr);
> +		cancel_work_sync(&s->p[i].rts_work);
>  		cancel_work_sync(&s->p[i].tx_work);
>  		cancel_work_sync(&s->p[i].md_work);
>  		cancel_work_sync(&s->p[i].rs_work);
> =20
>  		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
>  			uart_remove_one_port(&max310x_uart, &s->p[i].port);

[Severity: Critical]
Can this sequence cause a use-after-free by cancelling background tasks
too early?

uart_remove_one_port() is called after these workqueues and timers are
cancelled. Because the TTY port is still fully registered and active during
this window, userspace operations or hardware interrupts could re-queue
these works.

Once max310x_remove() returns and the memory is freed, any re-queued
works would execute on freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-max310x-rs=
485-sw-delay-v8-0-6ba881f81e1f@vaisala.com?part=3D8
