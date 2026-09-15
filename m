Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968D493D2B
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471216; cv=none; b=n/fWw8ZQtr1+wfj/JWLNcwXmg6e+pJp6W4WtwHpByeHEHHnCo1LRMH9TGhAMPmls1QemuHkQq+Ui6wv3PHiO/BUrergiX8n9VX+cdY3xeScVMI/mCUla3EjMYnJj6Flw+rmiCoijGNUqUsCqui7w2oSHhOs8JYyCMtbitoCRsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471216; c=relaxed/simple;
	bh=XVHehvFqoY9jfqSXdULevJOkuovRaTmjR8D8LQf83ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ALMZkweMex6dJDaPr5TaLuyAjbxzOsaBfkbPDEW5yziWXxwAyl16uD91Pxwb/jPFgqF5TycuouxR5y2jHVMRCtehX1ezrpFHJp+Snjcdz3kvB3sh35AEBh9dP8Y9AP6PAsPXKI4hxrHe8gM7Sb/EzaA4xiWg4M8UQMyqPk4lNQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXYtGhlF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXYtGhlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84B51F000FF;
	Tue, 15 Sep 2026 11:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789471212;
	bh=qCM+vTJ0iKBQ6uz8q2ZJd8MMTqVfIIhxSwHXjBrj4Q8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RXYtGhlFKGmu4QUrSfOCgVYUtKN3b/c/8L3ITnHYM8TqHe+dOlg9GCdquxtMQn2rn
	 5q2yqc6vt4ENAH0DAFNSx0LpHWxBu+kErD02y5ixKGNX57+heXK5orIbKE0gNVU5Sz
	 ZXOsBk7LtF3famz9hiP4FED+DvM2PItVlWy5n+BXY0ip4TpNj4ovE0bRRFRAPgDa5J
	 lZcSUpSM4FScNzJMwuEwKeFm8BZYE38fNthhkThV/yurbxRKeH3a4r7cEN5BZ/S1wI
	 L7xRG8yT9H8dWzC880mIUlXPuEULy6qGKtobXr5VtdTsQWz4tpTKpmUwFJpvDEfWQj
	 UCN4ZWPyRHy1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] serial: max310x: drive RTS in software when hardware
 delays are too short
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260915-max310x-rs485-sw-delay-v3-1-7d20a4a4ab52@vaisala.com>
References: <20260915-max310x-rs485-sw-delay-v3-1-7d20a4a4ab52@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:20:12 +0000
Message-Id: <20260915112012.A84B51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] serial: max310x: port lock dropped in serial core callbacks breaks=
 atomicity
- [High] serial: max310x: lockless 64-bit ktime and state updates cause tor=
n reads
- [High] serial: max310x: TOCTOU race in delayed_stop_tx resurrects cancell=
ed timer
- [High] serial: max310x: race in rts_work_proc transmits data with RTS dis=
abled
- [High] serial: max310x: shutdown bypasses timer cancellation if sw_rts to=
ggles
--

commit 986ae4ab53cd9aa2d0384870cb8594193bc9e13d
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: drive RTS in software when hardware delays are too short

This patch adds a software-driven RTS path for the max310x driver to handle
RS485 delays that exceed what the hardware can natively represent. It uses
an hrtimer and workqueue to assert and deassert RTS according to the reques=
ted
before-send and after-send delays.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 022502986c5fc..e8612c5c95550 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
[ ... ]
> @@ -680,6 +703,42 @@ static void max310x_batch_read(struct uart_port *por=
t, u8 *rxbuf, unsigned int l
[ ... ]
> +static void max310x_rts_work_proc(struct work_struct *ws)
> +{
> +	struct max310x_one *one =3D container_of(ws, struct max310x_one, rts_wo=
rk);
> +	struct uart_port *port =3D &one->port;
> +	bool rts_on =3D READ_ONCE(one->tx_state) !=3D MAX310X_TX_OFF;
> +
> +	max310x_rts_ctl(port, max310x_rts_level(port, rts_on));
> +
> +	guard(spinlock_irqsave)(&port->lock);
> +	if (READ_ONCE(one->tx_state) =3D=3D MAX310X_TX_WAIT_BEFORE_SEND &&
> +	    !one->cancel_tx_delay_tmr && !hrtimer_active(&one->tx_delay_tmr))
> +		hrtimer_start(&one->tx_delay_tmr,
> +			      ms_to_ktime(port->rs485.delay_rts_before_send),
> +			      HRTIMER_MODE_REL);

[Severity: High]
Does this code arm the timer based on the current state rather than the sta=
te
that was just applied to the hardware?

If max310x_rts_work_proc() locklessly reads tx_state =3D=3D OFF and command=
s the
hardware to drop RTS, it could race with max310x_start_tx() which takes the
lock and sets tx_state =3D WAIT_BEFORE_SEND.=20

When rts_work_proc acquires the lock, it would see the new WAIT_BEFORE_SEND
state and arm the TX timer, even though it explicitly disabled the hardware
RTS. The timer would fire and data would be shifted out while the transceiv=
er
is off, potentially leading to RS485 data loss.

> +}
> +
[ ... ]
> @@ -776,6 +835,71 @@ static void max310x_handle_rx(struct uart_port *port=
, unsigned int rxlen)
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
> +	 * Runs from the tx_work worker, which does not hold port->lock. Take it
> +	 * here so cancel_tx_delay_tmr, tx_state and the timer are updated
> +	 * atomically against start_tx() and the timer callback.
> +	 */
> +	guard(spinlock_irqsave)(&one->port.lock);
> +	one->cancel_tx_delay_tmr =3D false;
> +	/*
> +	 * Do not arm the after-send hold if a before-send phase is pending: a
> +	 * new burst's start_tx() may have set WAIT_BEFORE_SEND while its timer=
 is
> +	 * not yet armed (max310x_rts_work_proc() arms it after the RTS edge).
> +	 * That burst owns the line and runs its own envelope.
> +	 */
> +	if (READ_ONCE(one->tx_state) !=3D MAX310X_TX_WAIT_BEFORE_SEND &&
> +	    !hrtimer_active(&one->tx_delay_tmr)) {
> +		/*
> +		 * Add one character for the byte still in the shift register -
> +		 * TX-empty fires as it enters, not as it leaves.
> +		 */
> +		ktime_t delay =3D ktime_add_ms(one->one_character_duration,
> +					     port->rs485.delay_rts_after_send);

[Severity: High]
Does this unconditionally clear the cancellation flag after a lockless
hardware read?

If max310x_delayed_stop_tx() reads tx_state locklessly, then performs a
slow SPI read, it could race with max310x_shutdown() which acquires the loc=
k,
cancels the timer, sets tx_state =3D MAX310X_TX_OFF, and powers down the po=
rt.

After the SPI read, this code acquires the lock, clears cancel_tx_delay_tmr,
and re-arms the timer because it checks if tx_state is not
MAX310X_TX_WAIT_BEFORE_SEND instead of re-verifying it is not OFF. This cou=
ld
cause the timer to be armed on a powered-off port.

Also, is it safe to read one->one_character_duration locklessly here?
A torn read of this 64-bit ktime_t on 32-bit systems could result in massive
timer delays.

> +
> +		WRITE_ONCE(one->tx_state, MAX310X_TX_WAIT_AFTER_SEND);
> +		hrtimer_start(&one->tx_delay_tmr, delay, HRTIMER_MODE_REL);
> +	}
> +}
> +
>  static void max310x_handle_tx(struct uart_port *port)
>  {
>  	struct tty_port *tport =3D &port->state->port;
> @@ -787,8 +911,13 @@ static void max310x_handle_tx(struct uart_port *port)
>  		return;
>  	}
> =20
> -	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
> +	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
> +		struct max310x_one *one =3D to_max310x_port(port);
> +
> +		if (one->sw_rts_during_tx)
> +			max310x_delayed_stop_tx(port);

[Severity: High]
Can a lockless read of sw_rts_during_tx strand the RS485 state machine here?

If sw_rts_during_tx is toggled locklessly mid-transmission (e.g. from
max310x_set_rts_ctl_params()), it could prevent the after-send hold from
arming, leaving the transceiver permanently asserted.

>  		return;
> +	}
[ ... ]
> @@ -813,11 +942,48 @@ static void max310x_handle_tx(struct uart_port *por=
t)
>  		uart_write_wakeup(port);
>  }
> =20
[ ... ]
> +/* called with port.lock taken and irqs off */
>  static void max310x_start_tx(struct uart_port *port)
>  {
>  	struct max310x_one *one =3D to_max310x_port(port);
> =20
> -	schedule_work(&one->tx_work);
> +	if (one->sw_rts_during_tx) {
> +		/*
> +		 * The before- and after-send phases share one delay timer. If an
> +		 * after-send release is pending, cancel it before starting a new
> +		 * TX so the just-asserted RTS is not yanked; re-arming the timer
> +		 * for the before-send phase then supersedes the release.
> +		 */
> +		int res =3D 0;
> +
> +		if (READ_ONCE(one->tx_state) =3D=3D MAX310X_TX_WAIT_AFTER_SEND)
> +			res =3D hrtimer_try_to_cancel(&one->tx_delay_tmr);
> +		if (unlikely(res =3D=3D -1)) {
> +			one->cancel_tx_delay_tmr =3D true;
> +			uart_port_unlock(port);
> +			hrtimer_cancel(&one->tx_delay_tmr);
> +			uart_port_lock(port);

[Severity: High]
Does dropping port->lock here break atomicity expectations?

The serial core calls ops->start_tx() with port->lock held, assuming the
port state will remain locked and atomic. Dropping the lock to call
hrtimer_cancel() allows concurrent operations like uart_shutdown() or
another uart_write() to modify port state or free resources. When the
driver reacquires the lock, the caller resumes execution in an invalid stat=
e.

> +		}
> +
> +		max310x_delayed_start_tx(port);
> +	} else {
> +		schedule_work(&one->tx_work);
> +	}
>  }
[ ... ]
> @@ -927,15 +1093,111 @@ static void max310x_set_mctrl(struct uart_port *p=
ort, unsigned int mctrl)
[ ... ]
> +/*
> + * Pick hardware or software RTS timing for the current port. The chip c=
an
> + * deliver up to 15 bit-times of setup/hold delay via HDPIXDELAY; anythi=
ng
> + * longer (or any RTS polarity the chip cannot produce automatically) mu=
st
> + * be driven by software via tx_delay_tmr and rts_work.
> + */
> +static void max310x_set_rts_ctl_params(struct max310x_one *one)
> +{
[ ... ]
> +
> +	if ((u64)port->rs485.delay_rts_before_send * NSEC_PER_MSEC > max_hw_del=
ay_ns ||
> +	    (u64)port->rs485.delay_rts_after_send  * NSEC_PER_MSEC > max_hw_del=
ay_ns ||
> +	    !!(port->rs485.flags & SER_RS485_RTS_ON_SEND) =3D=3D
> +	    !!(port->rs485.flags & SER_RS485_RTS_AFTER_SEND))
> +		one->sw_rts_during_tx =3D true;

[Severity: High]
Can dynamically updating sw_rts_during_tx desync the timer cancellation log=
ic?

If sw_rts_during_tx flips to false while a transmission is active (for
example, due to a concurrent tcsetattr()), a subsequent port close could sk=
ip
timer cancellation in max310x_shutdown(), leaving background tasks running
against a disabled port.

> +
> +	if (one->sw_rts_during_tx) {
> +		setup =3D 0;
> +		hold  =3D 0;
> +		goto out;
> +	}
[ ... ]
> @@ -969,8 +1231,12 @@ static void max310x_set_termios(struct uart_port *p=
ort,
[ ... ]
> +	/*
> +	 * Cache the new baud rate and the time it takes to clock out one
> +	 * character so the RTS-timing decision in max310x_set_rts_ctl_params()
> +	 * and the post-TX delay in max310x_delayed_stop_tx() can use them.
> +	 */
> +	to_max310x_port(port)->baud =3D baud;
> +	to_max310x_port(port)->one_character_duration =3D
> +		us_to_ktime(DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud));

[Severity: High]
Can writing this 64-bit ktime_t locklessly cause torn reads?

Concurrently, the TX fast-path (max310x_handle_tx() and
max310x_delayed_stop_tx()) reads one_character_duration. On 32-bit systems,
a torn read could corrupt the delay timer calculation.

> +	max310x_set_rts_ctl_params(to_max310x_port(port));
>  }
[ ... ]
> +/* called with port.lock taken and irqs off */
>  static int max310x_rs485_config(struct uart_port *port, struct ktermios =
*termios,
>  				struct serial_rs485 *rs485)
>  {
>  	struct max310x_one *one =3D to_max310x_port(port);
> =20
> -	if ((rs485->delay_rts_before_send > 0x0f) ||
> -	    (rs485->delay_rts_after_send > 0x0f))
> -		return -ERANGE;
> +	rs485->delay_rts_before_send =3D min(rs485->delay_rts_before_send, 100U=
);
> +	rs485->delay_rts_after_send  =3D min(rs485->delay_rts_after_send,  100U=
);
> +
> +	/*
> +	 * Make sure no SW-timed RTS toggle survives an RS485 disable, even
> +	 * if the delay timer happens to be running right now.
> +	 */
> +	if (!(rs485->flags & SER_RS485_ENABLED)) {
> +		one->cancel_tx_delay_tmr =3D true;
> +		if (hrtimer_try_to_cancel(&one->tx_delay_tmr) =3D=3D -1) {
> +			uart_port_unlock(port);
> +			hrtimer_cancel(&one->tx_delay_tmr);
> +			uart_port_lock(port);

[Severity: High]
Does dropping port->lock here break atomicity?

The serial core calls ops->rs485_config() with port->lock held. Dropping
the lock temporarily to call hrtimer_cancel() could break atomicity and
corrupt the state transition if there are interleaved operations.

> +		}
> +		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
> +	}
[ ... ]
> @@ -1134,9 +1417,53 @@ static int max310x_startup(struct uart_port *port)
> =20
>  static void max310x_shutdown(struct uart_port *port)
>  {
> +	struct max310x_one *one =3D to_max310x_port(port);
> +
> +	/*
> +	 * Drain any in-flight software-timed RTS envelope before the port is
> +	 * powered down, so the last character and its after-send hold complete
> +	 * - close() can reach shutdown with data still queued and a before-send
> +	 * delay pending. The loop ends when the envelope does (tx_state =3D=3D=
 OFF);
> +	 * the bound is just a worst-case safety cap. Then stop the timer and w=
ork
> +	 * so neither runs against a powered-off port.
> +	 */
> +	if (one->sw_rts_during_tx) {
> +		unsigned int loops =3D port->rs485.delay_rts_before_send +
> +			    port->rs485.delay_rts_after_send +
> +			    DIV_ROUND_UP_ULL((kfifo_len(&port->state->port.xmit_fifo) +
> +					      port->fifosize) *
> +					     ktime_to_us(one->one_character_duration),
> +					     USEC_PER_MSEC);
> +
> +		while (READ_ONCE(one->tx_state) !=3D MAX310X_TX_OFF && loops-- > 0)
> +			fsleep(USEC_PER_MSEC);
> +
> +		one->cancel_tx_delay_tmr =3D true;
> +		hrtimer_cancel(&one->tx_delay_tmr);
> +		cancel_work_sync(&one->rts_work);

[Severity: High]
Does this logic fail to cancel timers if sw_rts_during_tx has been toggled?

If sw_rts_during_tx was dynamically updated to false (e.g. by a tcsetattr()
call) during an active transmission, this check skips the timer and work
cancellation routines. This could leave tx_delay_tmr and rts_work running
against a powered-down hardware port, leading to bus errors.

> +		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
> +	} else {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-max310x-rs=
485-sw-delay-v3-1-7d20a4a4ab52@vaisala.com?part=3D1
