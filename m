Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B099370ACA
	for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372428; cv=none; b=NaJp10qo3v8oqdZTRb3b+r/EWMRoc1Il6WHMUw5kZhCJj9iAw9kXpU+guUTfEit0WerdLybArsGsJVNEl4BgmR+yuAUOEUslChlw4S4teH2BQbdH6GTz+6fC8qpNTmMU54gQ4fZ2wXECe4sW/DMRw37XHIL6B3qxHIZ4unQqTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372428; c=relaxed/simple;
	bh=2BGOOgQoMewRTfd+YGgxkTAkR/tKQAGjqGhhSvyqotE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lOfLD5WFybtMEEUXbOiO6gY859g55YQAnHk2U5IVZ3X4dXp4459k4QiqX+OB1qQuSZyWalHm1HAHZbYWyFB9ogmXX7MRaxnmtiaTPluO65NKdK1DngxjwRX334pv9ESaok7E2qLrLdmQ6FD1Ju34c5wYpD4Ry9qtUpYaGIS7okA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVnvvf4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVnvvf4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FE01F00893;
	Mon, 14 Sep 2026 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789372426;
	bh=mEzYCWAnPS3Ak9+S/c0mQZmaaGb4zrO6mI9ytHbT4/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fVnvvf4bifOu+5RsSd386eXvyOAFTinfO+1C1Sq43WxFND8rBGPYozV0mRn31Ln02
	 v+JCc1Zv3I707/CYmrjij+BNcURjHLYwCR0wjHebOLR07imjrRqgzxnR6EtypjcjDh
	 rWQcWrVaJ5b+MEjWQqUBfLRSBVVJf4Y+HjYj6YIY4qeSCdrdcwSrsv+V609e8NJ+I/
	 ombeXCtGBdV2Q28l3u0AJVOJrhpFnKz/EaU2yV98TCkJfak8QcUxclon/LI9ddAtcY
	 2jr4Wkr7+K64UHOGzYcTEdA5QA4BGKyocuLX439N4s/dP2gA4M1bn3ttvjKnYdmHux
	 dAQsA84MLUTJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2] serial: max310x: drive RTS in software when
 hardware delays are too short
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260914-max310x-rs485-sw-delay-v2-1-9a7b681e64ce@vaisala.com>
References: <20260914-max310x-rs485-sw-delay-v2-1-9a7b681e64ce@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:53:46 +0000
Message-Id: <20260914075346.87FE01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Unprivileged Denial of Service (Hung Task Panic) via unbounded=
 uninterruptible sleep.
- [High] Use-After-Free due to timer resurrection during teardown.
- [High] Illegal drop of port->lock in UART callbacks, breaking core serial=
ization.
- [High] RS485 data loss via software state machine bypass.
- [High] Software RTS state and TX-break bits are wiped out by absolute LCR=
 write.
- [High] Broken RS485 break signaling ignores transceiver polarity.
- [High] Resource leak and Use-After-Free of timers/workqueues on probe fai=
lure.
- [Medium] Spurious before-send delays corrupt the RS485 timing envelope.
--

commit baf4e55a904a787d7bc6f1d6391ae17076f84296
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: serial: max310x: drive RTS in software when hardware delays are to=
o short

This patch adds a software-driven RTS path for the MAX310X serial driver
when hardware auto-RTS delays cannot accommodate the requested timing or
polarity. It implements an hrtimer and workqueue-based state machine to
handle RTS toggle timings.

Link: https://lore.kernel.org/r/20260709-max310x-rs485-sw-delay-v1-1-454ac1=
0b937a@vaisala.com

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 022502986c5fc..453c4aca2f2d9 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
[ ... ]
> @@ -787,8 +904,13 @@ static void max310x_handle_tx(struct uart_port *port)
[ ... ]
>  	/*
>  	 * It's a circ buffer -- wrap around.
>  	 * We could do that in one SPI transaction, but meh.
>  	 */
>  	while (!kfifo_is_empty(&tport->xmit_fifo)) {
>  		unsigned int txlen, to_send;
>  		unsigned char *tail;
> =20
>  		/* Limit to space available in TX FIFO */
>  		txlen =3D max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
>  		txlen =3D port->fifosize - txlen;
>  		if (!txlen)
>  			break;
> =20
>  		to_send =3D kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
>  		max310x_batch_write(port, tail, to_send);
>  		uart_xmit_advance(port, to_send);
>  	}

[Severity: High]
Could this lead to data loss on the RS485 bus? If a hardware TXEMPTY
interrupt fires and schedules tx_work before rts_work has transitioned the
state machine to MAX310X_TX_SEND and asserted RTS, max310x_handle_tx() might
push data to the hardware FIFO while the transceiver is still in receive mo=
de.

> @@ -813,11 +935,48 @@ static void max310x_handle_tx(struct uart_port *por=
t)
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
> +			spin_unlock(&one->port.lock);
> +			hrtimer_cancel(&one->tx_delay_tmr);
> +			spin_lock(&one->port.lock);
> +		}

[Severity: High]
Is it safe to drop the port lock here? The UART core typically calls the
start_tx callback with the lock held and interrupts disabled. Dropping it
might break UART core serialization and allow concurrent operations to modi=
fy
the port state.

> +
> +		max310x_delayed_start_tx(port);

[Severity: Medium]
If the port is already actively transmitting (tx_state =3D=3D MAX310X_TX_SE=
ND),
does calling max310x_delayed_start_tx() unnecessarily revert the state back
to MAX310X_TX_WAIT_BEFORE_SEND and queue another spurious delay?

> @@ -927,15 +1086,101 @@ static void max310x_set_mctrl(struct uart_port *p=
ort, unsigned int mctrl)
[ ... ]
>  static void max310x_break_ctl(struct uart_port *port, int break_state)
>  {
> +	struct max310x_one *one =3D to_max310x_port(port);
> +
>  	max310x_port_update(port, MAX310X_LCR_REG,
>  			    MAX310X_LCR_TXBREAK_BIT,
>  			    break_state ? MAX310X_LCR_TXBREAK_BIT : 0);
> +
> +	if (!(port->rs485.flags & SER_RS485_ENABLED))
> +		return;
> +
> +	/*
> +	 * Drive RTS manually for the break duration. HW auto-RTS only asserts
> +	 * the transceiver while FIFO data is shifting out, and a break is not
> +	 * FIFO data, so on the HW path also disable auto-RTS for the break and
> +	 * restore it when the break ends.
> +	 */
> +	if (!one->sw_rts_during_tx)
> +		max310x_port_update(port, MAX310X_MODE1_REG,
> +				    MAX310X_MODE1_TRNSCVCTRL_BIT,
> +				    break_state ? 0 : MAX310X_MODE1_TRNSCVCTRL_BIT);
> +
> +	max310x_rts_ctl(port, break_state);
> +}

[Severity: High]
Does passing break_state directly to max310x_rts_ctl() handle active-low
transceivers correctly? It appears this forces RTS active-high unconditiona=
lly,
bypassing the SER_RS485_RTS_ON_SEND polarity checks used elsewhere in the
driver.

> +static void max310x_set_termios(struct uart_port *port,
>  				struct ktermios *termios,
>  				const struct ktermios *old)
>  {
> +	unsigned int frame_bits =3D tty_get_frame_size(termios->c_cflag);
>  	unsigned int lcr =3D 0, flow =3D 0;
>  	int baud;

[Severity: High]
Just below here, max310x_set_termios() performs an absolute write to update
MAX310X_LCR_REG. Could this inadvertently clear the manual RTS
(MAX310X_LCR_RTS_BIT) or TX break (MAX310X_LCR_TXBREAK_BIT) bits if a
software RS485 envelope is actively transmitting while termios is changed?

> @@ -1042,38 +1287,55 @@ static void max310x_set_termios(struct uart_port =
*port,
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
> +			spin_unlock(&port->lock);
> +			hrtimer_cancel(&one->tx_delay_tmr);
> +			spin_lock(&port->lock);
> +		}

[Severity: High]
Is it safe to drop the port lock here as well? Like in max310x_start_tx(),
dropping the lock could allow concurrent operations to enter the critical
section while the caller expects exclusive access.

> @@ -1134,9 +1396,54 @@ static int max310x_startup(struct uart_port *port)
[ ... ]
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

[Severity: Critical]
Is there a risk of a hung task panic here? If a user configures a very low
baud rate (like 50 baud), this loop could execute an uninterruptible sleep
via fsleep() for a very long time (e.g., several minutes) while the FIFO
drains. Should this be interruptible, or bound by a shorter maximum delay?

> +
> +		one->cancel_tx_delay_tmr =3D true;
> +		hrtimer_cancel(&one->tx_delay_tmr);
> +		cancel_work_sync(&one->rts_work);
> +		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);

[Severity: High]
Since tx_work isn't synchronized during shutdown, could a pending tx_work
execute after max310x_shutdown() completes, call max310x_delayed_stop_tx(),
and unconditionally set one->cancel_tx_delay_tmr =3D false to re-arm the ti=
mer?
If this happens after device memory is freed, could it cause a use-after-fr=
ee
panic when the timer fires?

> +	} else {
> +		/*
> +		 * HW auto-RTS path: the tty layer waits for tx_empty before
> +		 * close(), but tx_empty only reflects the chip TX FIFO - the
> +		 * last character may still be in the transmit shift register.
> +		 * Let the FIFO drain and the final character clock out before
> +		 * the port is powered down, otherwise close() truncates the last
> +		 * byte on the wire as the chip auto-RTS turnaround clips it.
> +		 */
> +		unsigned int loops =3D port->fifosize + 1;
> +
> +		while (!max310x_tx_empty(port) && loops-- > 0)
> +			fsleep(ktime_to_us(one->one_character_duration));

[Severity: Critical]
Similarly, could this fallback hardware auto-RTS path also cause an unbound=
ed
uninterruptible sleep at very low baud rates, potentially exceeding the
hung task limit?

> @@ -1425,6 +1733,11 @@ static int max310x_probe(struct device *dev, const=
 struct max310x_devtype *devty
[ ... ]
>  		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
>  		/* Initialize queue for changing RS485 mode */
>  		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
> +		/* Initialize queue for software-driven RTS toggling */
> +		INIT_WORK(&s->p[i].rts_work, max310x_rts_work_proc);
> +		hrtimer_setup(&s->p[i].tx_delay_tmr, max310x_tmr_tx,
> +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		s->p[i].tx_state =3D MAX310X_TX_OFF;
>  	}

[Severity: High]
If max310x_probe() fails for a subsequent port and jumps to the out_uart
error label, is it possible we leak the newly initialized tx_delay_tmr and
rts_work for already registered ports? It doesn't appear they are cancelled
in the probe error path before freeing memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-max310x-rs=
485-sw-delay-v2-1-9a7b681e64ce@vaisala.com?part=3D1
