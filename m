Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794898117;
	b=oJd1rXjtiWLFMDezMs6MS9BeSqFd/vI2cr9c/8mi812sk7CUgquh2kvAxkuUfx4jfjuU
	 zs1r24zA6iIJGnwZo1OFcJMCFsV0WlaoW6aoiwcKqa+vB9NiFt5u4l5y1Divmqqlw6CjA
	 /Zq1B2dJDXmMZyk2VMb/oXwuNpO9gQv5bx2saRXCMCRGheKt/l2KyIGFvWtAK5Xb/M6Pe
	 Sk7ZvtKjg3zU/QqmSNj2wauszDo+GRmrw0JGanY6QMU359s3pTtbOuq4nniygjTikoHvE
	 I5jav/42oPm/1+2pPvtg/OmSExDfLO+pwxsu7fjaqUY0Ex10XTT0LCuRflaxYr9ZimA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794898117;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HdJc9sqLo3n8bi393tAXsDaqqnGVBhD2gj+ODefd4EA=;
	b=GbTCwaQLKXYW7AUOPmqJnc3Vct7iletr9Vyg3MJ60EKsJ3K7KcLJAWzlN92DBPFLjImt
	 L2uHuRA6B/Xq95cbFELH6ImTKJcSQCUTSys7wxwpaT+DC/MqJeu+9HkD77HUKkHyGCnWj
	 3RnlEAR0dEfAKwWPsPKIHXIusVNygVseJOqZQcOxHp6huOXmBTXR/LRG1kFaEOd/paPrc
	 mVmk+MGLh4Zb4l953YRl2nFcuOlzYvy6iae4kRHdaEVaofE2srYItm1Hb0KfR56vYEuI8
	 cnmSGYGEl6WpfG/mGL8tH7Rj4Fy6vEBzhd5tXNw5+EgK53EUMzPKKeJS1jAy6/3NlVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zv5//48T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FC606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv5//48T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CC41F000C4;
	Tue, 17 Nov 2026 06:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794898116;
	bh=HdJc9sqLo3n8bi393tAXsDaqqnGVBhD2gj+ODefd4EA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zv5//48TLlb9NuzKlH6oElYFMgJaV5GR2ZmnJh1diT3BplYEiTfOd8ZRvp0JXFC6k
	 VeQOkHPZz5AmPCfMEYKjRupay/eqRMqGQbTdnvvjrM0rsA12u5tNvsVtNLaecOCnGn
	 anyc2S8eRbnwbm76Nbmqq8/F5xBe9KiD7vLOJIjH3PniQ2S1TRLfaCx1vk1MepuRaZ
	 OS9UrT+wcAeGT7ocXJGv84ZySjkMIHoW6q1dTwkOqieWC5InaW1d8cITAq6bZJxhnS
	 p2x8T/Z+rta2wbp35MwXdLZuAJ6pNR4oeyXI1R4HbBJbfyAzphoVG+Q/2Ty22UD7LG
	 F0jiRumrNdtDw==
Message-ID: <sashiko-outbox-218280@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] serial: max310x: hold TX data until the software
 RTS send phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tapio Reijonen" <tapio.reijonen@vaisala.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-max310x-tx-fixes-v2-3-b395126fd23d@vaisala.com>
References: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
 <20261117-max310x-tx-fixes-v2-3-b395126fd23d@vaisala.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 06:48:36 +0000
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
- [Medium] serial: max310x: x_char sent before software RTS send-phase
  check
- [Medium] serial: max310x: max310x_adopt_hw_tx() bypasses send-phase
  hold on empty FIFO
- [Medium] serial: max310x: early return in max310x_restart_tx() strands
  TX_SEND state
--

commit 4da682996f111cc76f553602be970865e015bb7f
Author: Tapio Reijonen <tapio.reijonen@vaisala.com>

serial: max310x: hold TX data until the software RTS send phase

This commit holds TX FIFO writes in max310x_handle_tx() until a
software-timed RS-485 RTS envelope reaches MAX310X_TX_SEND, and adds
max310x_restart_tx() to restart pending transmissions after termios or
RS-485 reconfigurations.

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

[Severity: Medium]
Should this send-phase check also gate the port->x_char write at the top
of max310x_handle_tx()?

drivers/tty/serial/max310x.c:max310x_handle_tx() {
	if (unlikely(port->x_char)) {
		max310x_port_write(port, MAX310X_THR_REG, port->x_char);
		port->icount.tx++;
		port->x_char =3D 0;
		return;
	}
    ...
}

When uart_send_xchar() queues an XON/XOFF byte on the software RTS path,
max310x_start_tx() starts an envelope in MAX310X_TX_WAIT_BEFORE_SEND (and
max310x_restart_tx() likewise routes a deferred port->x_char through
max310x_start_tx()).  If a late TXEMPTY interrupt from the previous
envelope schedules tx_work before tx_delay_tmr enters MAX310X_TX_SEND,
max310x_handle_tx() writes port->x_char to MAX310X_THR_REG and clears it
while RTS is still deasserted or in its setup delay, losing the character
on the wire and leaving the envelope to run empty once the timer expires.

[ ... ]

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
Can returning early here when xmit_fifo is empty or stopped leave
one->tx_state stranded in MAX310X_TX_SEND with RTS permanently asserted?

When max310x_set_rts_ctl_params() adopts a transfer whose data is only in
xmit_fifo (MAX310X_TXFIFOLVL_REG =3D=3D 0), max310x_adopt_hw_tx() sets
one->tx_state to MAX310X_TX_SEND, asserts RTS, and calls
max310x_delayed_stop_tx(), which returns without arming tx_delay_tmr
because xmit_fifo is non-empty and unstopped:

CPU0                                  CPU1
max310x_set_termios()
  max310x_set_rts_ctl_params()
    max310x_adopt_hw_tx()
      one->tx_state =3D MAX310X_TX_SEND
    max310x_rts_ctl(..., true)
    max310x_delayed_stop_tx()
      /* xmit_fifo non-empty: no timer */
                                      uart_flush_buffer()
                                        kfifo_reset(&tport->xmit_fifo)
  max310x_restart_tx()
    if (kfifo_is_empty(...))
      return;  <-- tx_state stuck in MAX310X_TX_SEND

Because the chip TX FIFO is already empty, no TXEMPTY interrupt will fire
to schedule tx_work, and neither uart_flush_buffer() nor stop_tty() runs
max310x_delayed_stop_tx(), leaving RTS driving the bus until a subsequent
write or port close.

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
Can tx_work run between max310x_adopt_hw_tx() and max310x_restart_tx() and
bypass the send-phase hold when the chip TX FIFO is empty?

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
    ...
}

When max310x_set_termios() or max310x_rs_proc() switches to software RTS
with an empty chip FIFO and bytes waiting in xmit_fifo, one->tx_state
stays set to MAX310X_TX_SEND across the unlocked register updates in
max310x_set_rts_ctl_params() and the MAX310X_TXFIFOLVL_REG read before
max310x_restart_tx() rewinds it to MAX310X_TX_OFF:

CPU0                                  kworker
max310x_set_termios()
  max310x_set_rts_ctl_params()
    one->sw_rts_during_tx =3D true
    max310x_adopt_hw_tx()
      /* TXFIFOLVL =3D=3D 0, kfifo !=3D empty */
      one->tx_state =3D MAX310X_TX_SEND
                                      max310x_tx_proc()
                                        max310x_handle_tx()
                                          /* sees MAX310X_TX_SEND */
                                          max310x_batch_write()  <-- no set=
up delay
    max310x_rts_ctl(..., true)
  max310x_restart_tx()

Any tx_work running in that window (or scheduled by a concurrent write()
seeing MAX310X_TX_SEND in max310x_start_tx()) pushes the queued data to
the chip before RTS is asserted or before delay_rts_before_send has
elapsed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-max310x-tx=
-fixes-v2-0-b395126fd23d@vaisala.com?part=3D3
