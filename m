Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597489;
	b=EXc7fFdCKM7PBvKcV/B3q4XlWnXiKgV9FkRAkAVh4gTrorDPivDIWspFLqFQiHZYlXq1
	 wY1N1lASeeTH3G9mM6Tv/Et0XYuWIjZBr5avin4iEaU6uoGhjFvzLlPW3zPZn+Ee/a633
	 jZlAY+G2Gu7VfZAcRpfWtiOtLLRA1eRBApDES8sc7ZKC8PMon3QYP7e4qwMrLGpq5J+8O
	 f99xi+BiwAEnZYfV6Ws52dvfQZ829e2BdkPs8F4lxDFaejsUBcmpobaskCcA0xjpk0U1n
	 8LpOEy5DFuXD9eIN3WXt5aUborBKj4XdaEk9wpzPljceuzpJzSSzAe9U/ANqHJcolew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597489;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ycIgkhY3DHzLqWbTzqVC+iLaQ+/xa13OZwa4epgYopw=;
	b=dP3JAw/+LQ1gFOoPDrse8rOC+fdvVEw/IcniFVDYzT0UEkMQdMdTbnJSYwFRdKc2M2mW
	 T9WX+SatBhb308ivwsqA2C1S28qU+VRhTFIPnfvlvsLnh/FGbpTRVcxyLtcJL9HcI5TA1
	 +5lCJea3yr8WxBLOKWkX78vU5ah/aBbsUSe/m+xY74WjSfj3HO8MqA0CUPcLofLJiRTVJ
	 hzNQ6viEz4Mnlb86krIQiTkOpNfNvZ8CrmVLYMxQ/MuAakkf3HYFZPoFCohyyLtPjGdqF
	 x2G9UHpjz+TJYO8E2Ikj/vn+IHkRbWe4Qn05ghK+GiE5rD317PAzJ+sljmILWx0gCvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEPzfawg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B56606A331
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEPzfawg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076961F000CC;
	Fri, 13 Nov 2026 19:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597489;
	bh=ycIgkhY3DHzLqWbTzqVC+iLaQ+/xa13OZwa4epgYopw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEPzfawgcYKELya0sjTEhuusbnLAVEkFd8PJxjL+XxyQCZLozcwcPfFgM1C5Sp7iU
	 oVIDtN5MB6CEjrl1S+Rq9+mUbWCV1wx8PBokyt7sl1eA5Mo+DOZ4wn+2WOHrW0en47
	 NckM3hVc64m4aD3Tq7b2iOE+14orBwQLMZxfNEfEb6LqHoPFFsGPXc9cjgUD9RacvN
	 1blHI8vaMHk4YZXTuuX/pVlXw4vLDGCDoTekam1Yq1yUOsmRX6EExmseVNTylQsxqA
	 UZYT7vVI4+c/OTh7/ESZXKZmmHlFmX5pTw3/g5u8XcBbyGdHAglL0aAHIzFs0nokPA
	 xOQXNtlg5atlA==
Message-ID: <sashiko-outbox-213538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] serial: sh-sci: Keep TX enabled on TEI while
 data is pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261113-g2ul_sci-v4-2-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
 <20261113-g2ul_sci-v4-2-6815e41d90c5@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:18:08 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] serial: sh-sci: missing sci_stop_tx() when stopped in
  sci_transmit_chars()
- [Medium] serial: sh-sci: premature TE disable in
  sci_tx_end_interrupt() during active TX
--

commit 2144acd3ea7e3d82d9a7516af61337ce1de099e8
Author: Biju Das <biju.das.jz@bp.renesas.com>

serial: sh-sci: Keep TX enabled on TEI while data is pending

This commit keeps the transmitter enabled in sci_tx_end_interrupt() when
x_char or unstopped xmit_fifo data is pending, and updates
sci_transmit_chars() and rsci_transmit_chars() to switch from TIE to TEIE
when transmission is stopped.

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 9eb297dbc9010..6df25fef5a5f5 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
[ ... ]
> @@ -1007,6 +1011,20 @@ static int sci_rxfill(struct uart_port *port)
>   *                   the interrupt related routines                     =
  *
>   * *********************************************************************=
* */
> =20
> +static void sci_clr_tie_set_teie(struct uart_port *port)
> +{
> +	struct sci_port *s =3D to_sci_port(port);
> +	unsigned short ctrl;
> +
> +	if (s->type !=3D PORT_SCI)
> +		return;
> +
> +	ctrl =3D sci_serial_in(port, SCSCR);
> +	ctrl &=3D ~SCSCR_TIE;
> +	ctrl |=3D SCSCR_TEIE;
> +	sci_serial_out(port, SCSCR, ctrl);
> +}
> +
>  static void sci_transmit_chars(struct uart_port *port)
>  {
>  	struct tty_port *tport =3D &port->state->port;
> @@ -1050,14 +1068,10 @@ static void sci_transmit_chars(struct uart_port *=
port)
>  	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);
>  	if (kfifo_is_empty(&tport->xmit_fifo)) {
> -		if (s->type =3D=3D PORT_SCI) {
> -			ctrl =3D sci_serial_in(port, SCSCR);
> -			ctrl &=3D ~SCSCR_TIE;
> -			ctrl |=3D SCSCR_TEIE;
> -			sci_serial_out(port, SCSCR, ctrl);
> -		}
> -
> +		sci_clr_tie_set_teie(port);
>  		sci_stop_tx(port);
> +	} else if (stopped) {
> +		sci_clr_tie_set_teie(port);
>  	}
>  }

[Severity: High]
Does the "else if (stopped)" branch leave SCSCR_TIE enabled on
non-PORT_SCI ports?

sci_clr_tie_set_teie() returns immediately when s->type !=3D PORT_SCI, and
this branch does not call sci_stop_tx().  If sci_transmit_chars() runs on
a PORT_SCIF, PORT_SCIFA, PORT_SCIFB, PORT_HSCIF, or PORT_IRDA port while
stopped with data still in xmit_fifo (for example, after uart_send_xchar()
calls sci_start_tx()), SCSCR_TIE remains set and triggers a continuous TXI
interrupt storm until transmission is unstopped.

> @@ -2012,6 +2026,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, vo=
id *ptr)
>  {
>  	struct uart_port *port =3D ptr;
>  	struct sci_port *s =3D to_sci_port(port);
> +	struct tty_port *tport =3D &port->state->port;
>  	const struct sci_common_regs *regs =3D s->params->common_regs;
>  	unsigned long flags;
>  	u32 ctrl;
> @@ -2020,8 +2035,18 @@ static irqreturn_t sci_tx_end_interrupt(int irq, v=
oid *ptr)
>  		return sci_tx_interrupt(irq, ptr);
> =20
>  	uart_port_lock_irqsave(port, &flags);
> -	ctrl =3D s->ops->read_reg(port, regs->control) &
> -		~(s->params->param_bits->te_clear);
> +	ctrl =3D s->ops->read_reg(port, regs->control);
> +	if (port->x_char || (!kfifo_is_empty(&tport->xmit_fifo) &&
> +			     !uart_tx_stopped(port))) {
> +		ctrl &=3D ~(s->params->param_bits->teie);
> +		ctrl |=3D s->params->param_bits->tie;
> +		s->ops->write_reg(port, regs->control, ctrl);
> +		s->ops->transmit_chars(port);
> +		uart_port_unlock_irqrestore(port, flags);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ctrl &=3D ~(s->params->param_bits->te_clear);
>  	s->ops->write_reg(port, regs->control, ctrl);
>  	uart_port_unlock_irqrestore(port, flags);

[Severity: Medium]
Can sci_tx_end_interrupt() still clear TE while newly written bytes are
being transmitted?

When transmit_chars() drains xmit_fifo, it clears TIE and sets TEIE while
the last byte is still shifting out.  If uart_write() runs before that
byte finishes, sci_start_tx() or rsci_start_tx() sets TIE without clearing
TEIE, leaving both interrupts enabled:

CPU0                              CPU1
transmit_chars()
  /* drains xmit_fifo */
  ctrl &=3D ~TIE;
  ctrl |=3D TEIE;
uart_write()
  start_tx()
    ctrl |=3D TIE | TE;
    /* TIE and TEIE both set */
                                  /* TDR transfers to shift reg: TXI */
                                  /* shift reg finishes: TEI */
                                  sci_tx_interrupt()
                                    lock(port)
                                    transmit_chars()
                                      /* writes new byte to TDR,
                                         drains xmit_fifo */
                                    unlock(port)
                                  sci_tx_end_interrupt()
                                    lock(port)
                                    /* xmit_fifo is now empty */
                                    ctrl &=3D ~te_clear;
                                      <-- clears TE during active TX
                                    unlock(port)

Because sci_tx_end_interrupt() checks only x_char and xmit_fifo without
verifying in regs->status that poll_sent_bits (TDRE and TEND) are still
set in hardware, it disables the transmitter before the newly written byte
has been sent.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-g2ul_sci-v=
4-0-6815e41d90c5@renesas.com?part=3D2
