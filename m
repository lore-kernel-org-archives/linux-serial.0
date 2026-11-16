Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825267;
	b=yB3Lia365LU4zShgf8Y/6TQ6EoZ3ByhVZqI04OnAU7maNpb5XpxFkSzSP9R09MByQd8T
	 S3GfBfDkYTb6LUnF8DrUWisPBoOiOp3fRRH0T9LgQrKyGpcjrcy349M47v9cNlBdXpceH
	 /+1Io/P5jfmhOgVfgFm3cSaft3Nd4hyyyQ21nrXLgsEj38tv31PRyXizaSRM22NaHIVSm
	 3a2tokV+ZGN7CkDRdkCT1nr0RBXlaM2dZCFBOaql9ahxTkjWo4jV2/jkFyz29hmh6SZwp
	 V0rgv9t6CHxZMidiY5K0hvrtvG5DVQsqCPFy7XLf9QnW9TrJF++LzM9e2ob13b/+xNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825267;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ivOJ/aMA3wCpE3xokYeQ5ULRLoVe7Mb6sOtXZEpNaXE=;
	b=RAok3dtCkSiX/n6hylvcPBk+TkXFuENBjNGy5mjT6lnJAYP+6Wy+IOq2ysKX0V7akmae
	 cEfExmt8iN319bsIlZuMfgc6d37vwxIPW8MDF2z6N2UsYPpOSXPA5iQ3ldJLjlkjXUzMQ
	 n0cymF3JktwinmtCY0toZfeSJsq9fkF7SZ6vO6fTbU+eM0nNWV9WxTAzw6m4DVjsA6jre
	 awZIYPGuCtqCAFhqht+s1eci/acIi2pv2pvOK0QpO0dJrZj89CYb+BHJkzybEOuiVxYsf
	 o8kzy3UaAwpVypVOO0xSveDQV0iHf7vNtLDYLjnlZUg8Pvzao8i5RfthXldbc6sNxtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1fWsX77;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED73606A31C
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1fWsX77
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1FA1F000C4;
	Mon, 16 Nov 2026 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794825267;
	bh=ivOJ/aMA3wCpE3xokYeQ5ULRLoVe7Mb6sOtXZEpNaXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M1fWsX77CLBpLsHHnx76PcFI7iVUadWwp42U2QVYAkac2KwXKnB8YJuKcupNWi1xi
	 50O6zcQcSbN3wOJEMbmC6OuK9I0in8hNFmM0fb5D84S4Qgd5Ze6fQ7KUThAVAb5a8e
	 V9U0jXKT6uWu+eCR3BCws/93zY53/mSaUXU+8PwZCXAwfAi0l9XpwZNWZV6Pwg81my
	 a5p8UCO6iC3vQ7Hs9KVxfXLkWjyxcIM0pUjZNKocAdX1i51/70tC0qKEne05SQtDBf
	 5OFHGruedx8P8cubGRLZ9XcE0uH9OS8JqZ8vkfvOEOQ4yng+Ob7z7WoWlhDZtXe+4J
	 B/irwZaqFWJ+g==
Message-ID: <sashiko-outbox-216745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] serial: max310x: hold TX data until the software
 RTS send phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261116-max310x-tx-fixes-v1-3-61c01f180911@vaisala.com>
References: <20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com>
 <20261116-max310x-tx-fixes-v1-3-61c01f180911@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:34:26 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] serial: max310x: max310x_adopt_hw_tx() bypasses send-phase
  hold on empty FIFO
- [Medium] serial: max310x: x_char sent before software RTS send-phase
  check
- [Medium] serial: max310x: early return in max310x_restart_tx() strands
  TX_SEND state
It also noticed 2 related pre-existing issues this patch does not
introduce:
- [High] serial: max310x: missing port lock in max310x_port_irq() [1]
- [Medium] serial: max310x: unprotected port->status modification in
  max310x_set_termios() [2]
--

commit c6e5f39e8c525f49645d0ceb47c724d2102f907b
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: hold TX data until the software RTS send phase

This commit holds queued TX data in max310x_handle_tx() until the
software-timed RS-485 RTS envelope reaches MAX310X_TX_SEND, and adds
max310x_restart_tx() to restart pending transmissions after set_termios()
and RS-485 reconfiguration.

> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 7ddfe8773faf9..d92bf24155886 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -942,6 +942,16 @@ static void max310x_handle_tx(struct uart_port *port)
>  		return;
>  	}
> =20
> +	/*
> +	 * Outside the send phase of a software envelope RTS is down, still
> +	 * in its setup delay, or about to drop: a late TX-empty interrupt
> +	 * must not push the data out now. start_tx() opens an envelope and
> +	 * tmr_tx() reschedules us at MAX310X_TX_SEND.
> +	 */
> +	if (READ_ONCE(one->sw_rts_during_tx) &&
> +	    READ_ONCE(one->tx_state) !=3D MAX310X_TX_SEND)
> +		return;
> +
>  	while (!kfifo_is_empty(&tport->xmit_fifo)) {
>  		unsigned int txlen, to_send;
>  		unsigned long flags;

[Severity: Medium]
Can port->x_char still be sent before the software RTS envelope reaches
MAX310X_TX_SEND?

At the top of max310x_handle_tx(), port->x_char is written to
MAX310X_THR_REG and cleared before this send-phase check:

drivers/tty/serial/max310x.c:max310x_handle_tx() {
	if (unlikely(port->x_char)) {
		max310x_port_write(port, MAX310X_THR_REG, port->x_char);
		port->icount.tx++;
		port->x_char =3D 0;
		return;
	}

When uart_send_xchar() calls max310x_start_tx() on the software RTS path,
it opens an envelope in MAX310X_TX_WAIT_BEFORE_SEND.  If a late TX-empty
interrupt from the previous envelope schedules tx_work before the
before-send timer expires, max310x_handle_tx() transmits port->x_char while
RTS is still deasserted or in its setup delay, losing or misframing the
flow-control byte.

> @@ -1077,8 +1087,8 @@ static irqreturn_t max310x_port_irq(struct max310x_=
port *s, int portno)
>  		if (rxlen)
>  			max310x_handle_rx(port, rxlen);
>  		/*
> -		 * TXEMPTY latches on the FIFO becoming empty, so a stale
> -		 * interrupt cannot pump data during an RTS setup delay.
> +		 * A TX-empty read late can belong to the previous envelope;
> +		 * max310x_handle_tx() holds the data until the send phase.
>  		 */
>  		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
>  			schedule_work(&s->p[portno].tx_work);

[Severity: High]
This problem wasn't introduced by this patch, but max310x_port_irq() calls
uart_handle_cts_change() without holding port->lock [1]:

drivers/tty/serial/max310x.c:max310x_port_irq() {
		if (ists & MAX310X_IRQ_CTS_BIT) {
			lsr =3D max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
			uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
		}

uart_handle_cts_change() requires the caller to hold port->lock (checked via
lockdep_assert_held_once(&uport->lock)), so a CTS interrupt triggers a
lockdep warning and races on port->hw_stopped, port->icount.cts, and TX
start/stop state.

> @@ -1314,6 +1324,28 @@ static void max310x_set_rts_ctl_params(struct max3=
10x_one *one)
>  			    MAX310X_IRDA_RTSINVERT_BIT, irda);
>  }
> =20
> +/*
> + * A reconfigure is applied: restart a transmission that it left queued,=
 on
> + * the path that is now configured. A send state without chip data has
> + * nothing in flight: restart it as a fresh envelope so the before-send =
delay
> + * is honoured. start_tx() can drop and retake the lock through the uart=
_port
> + * API - callers must take it with uart_port_lock*(), not a spinlock gua=
rd.
> + */
> +static void max310x_restart_tx(struct max310x_one *one, bool chip_tx_emp=
ty)
> +{
> +	struct uart_port *port =3D &one->port;
> +
> +	lockdep_assert_held(&port->lock);
> +
> +	if (!port->x_char && (kfifo_is_empty(&port->state->port.xmit_fifo) ||
> +			      uart_tx_stopped(port)))
> +		return;
> +
> +	if (chip_tx_empty && READ_ONCE(one->tx_state) =3D=3D MAX310X_TX_SEND)
> +		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
> +	max310x_start_tx(port);
> +}

[Severity: Medium]
Can returning early in max310x_restart_tx() when xmit_fifo is empty or
uart_tx_stopped(port) is true leave one->tx_state stranded in
MAX310X_TX_SEND with RTS asserted?

When max310x_set_rts_ctl_params() adopts a transfer with an empty chip FIFO
and queued data in xmit_fifo, max310x_adopt_hw_tx() sets one->tx_state to
MAX310X_TX_SEND, asserts RTS, and calls max310x_delayed_stop_tx(), which
returns early without arming tx_delay_tmr because xmit_fifo is non-empty
and unstopped:

CPU0                                  CPU1
max310x_set_termios()
  max310x_set_rts_ctl_params()
    max310x_adopt_hw_tx()
      one->tx_state =3D MAX310X_TX_SEND
    max310x_rts_ctl(..., true)
    max310x_delayed_stop_tx()
      /* xmit_fifo not empty: returns */
  /* unlocked SPI/I2C writes */
                                      uart_flush_buffer()
                                        kfifo_reset(&tport->xmit_fifo)
  max310x_restart_tx(one, true)
    if (kfifo_is_empty(...))
      return;  <-- tx_state stuck at MAX310X_TX_SEND

Because the chip TX FIFO is already empty, no TXEMPTY interrupt will fire
to arm the after-send timer, leaving RTS permanently asserted on the RS-485
bus until a later write or port close.  In addition, max310x_adopt_hw_tx()
does not check uart_tx_stopped(port), so reconfiguring while TX is stopped
with bytes in xmit_fifo adopts the stopped queue and asserts RTS on an idle
bus.

> @@ -1363,7 +1395,10 @@ static void max310x_set_termios(struct uart_port *=
port,
>  				const struct ktermios *old)
>  {
>  	unsigned int frame_bits =3D tty_get_frame_size(termios->c_cflag);
> +	struct max310x_one *one =3D to_max310x_port(port);
>  	unsigned int lcr =3D 0, flow =3D 0;
> +	unsigned long flags;
> +	bool chip_tx_empty;
>  	int baud;

[Severity: Medium]
This problem wasn't introduced by this patch, but max310x_set_termios()
modifies port->status without holding port->lock [2]:

drivers/tty/serial/max310x.c:max310x_set_termios() {
	port->status &=3D ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);

	if (termios->c_cflag & CRTSCTS) {
		/* Enable AUTORTS and AUTOCTS */
		port->status |=3D UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
    ...
	if (termios->c_iflag & IXOFF) {
		port->status |=3D UPSTAT_AUTOXOFF;

serial_core requires holding port->lock (along with termios_rwsem and the
port mutex) when modifying port->status so updates do not race with
concurrent serial core and interrupt handlers.

> @@ -1482,10 +1517,19 @@ static void max310x_set_termios(struct uart_port =
*port,
>  	 * taking over an in-flight transfer arms the after-send hold from
>  	 * the character time.
>  	 */
> -	to_max310x_port(port)->baud =3D baud;
> -	to_max310x_port(port)->char_time_us =3D
> -		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
> -	max310x_set_rts_ctl_params(to_max310x_port(port));
> +	one->baud =3D baud;
> +	one->char_time_us =3D DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
> +	max310x_set_rts_ctl_params(one);
> +
> +	/*
> +	 * A tx_work that ran while the RTS path was switched above has
> +	 * returned without sending, and nothing else pushes the data it left.
> +	 */
> +	chip_tx_empty =3D !max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
> +
> +	uart_port_lock_irqsave(port, &flags);
> +	max310x_restart_tx(one, chip_tx_empty);
> +	uart_port_unlock_irqrestore(port, flags);
>  }

[Severity: Medium]
Can tx_work run between max310x_adopt_hw_tx() and max310x_restart_tx() when
the chip FIFO is empty, bypassing the send-phase hold?

In max310x_adopt_hw_tx(), a non-empty xmit_fifo causes one->tx_state to be
set to MAX310X_TX_SEND even when MAX310X_TXFIFOLVL_REG is 0:

drivers/tty/serial/max310x.c:max310x_adopt_hw_tx() {
	if (!max310x_port_read(port, MAX310X_TXFIFOLVL_REG) &&
	    kfifo_is_empty(&port->state->port.xmit_fifo))
		return false;

	scoped_guard(spinlock_irqsave, &port->lock) {
		if (one->tx_teardown)
			return false;
		if (READ_ONCE(one->tx_state) !=3D MAX310X_TX_OFF)
			return true;
		WRITE_ONCE(one->tx_state, MAX310X_TX_SEND);
		one->cancel_tx_delay_tmr =3D false;
	}

Between that store and max310x_restart_tx() rewinding one->tx_state back to
MAX310X_TX_OFF, the driver performs several sleeping SPI/I2C register
accesses:

CPU0                                  CPU1 (kworker)
max310x_set_termios()
  max310x_set_rts_ctl_params()
    max310x_adopt_hw_tx()
      /* TXFIFOLVL =3D=3D 0, xmit_fifo !=3D empty */
      one->tx_state =3D MAX310X_TX_SEND
                                      max310x_handle_tx()
                                        /* sees tx_state =3D=3D MAX310X_TX_=
SEND */
                                        max310x_batch_write()  <-- no setup=
 delay
    max310x_rts_ctl(..., true)
    ...
  max310x_restart_tx()

Any tx_work running in that window (or scheduled by a concurrent
max310x_start_tx() that sees MAX310X_TX_SEND) passes the new check in
max310x_handle_tx() and pushes bytes into the chip FIFO before RTS is
asserted and before delay_rts_before_send has elapsed.

[1] https://sashiko.dev/#/bug/linux-f1129200-a607-415f-a0e8-4690c614c508
[2] https://sashiko.dev/#/bug/linux-9474384d-0d83-420d-ac64-f26b48f8e734

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-max310x-tx=
-fixes-v1-0-61c01f180911@vaisala.com?part=3D3
