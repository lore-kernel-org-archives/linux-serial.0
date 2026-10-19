Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430272;
	b=YF4P8jBFcmHqL6wwbrIW6XA6Y/cfnPWr/Dbe29u7vRzXHjWWlzjIETVg/66DY5xN4fIa
	 NcEB0L8SST3DYeLY4/6Q6UXkXYNSogEiyQyQef5bT01LyCouWDeasiFPmmud8rYieoYjg
	 0MasHktpzNszKmz5gtzfFX8fSv04bQqOQ1juhphlS3J3ZKCZjoeNt4nWriA7tAbKMbAG0
	 jsC6tuAUptpr576Dxqw6bgVNaZ/dFw1+rHeQsQsUjUrsCmCyQlMbXPFNuqHB8TtKEMoMs
	 qe1zlzn0InsIb89UThNwWvECnOqpnMVy+rp7+P/WRD/GLM2yVBrs67kVwwL2wxLHMQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430272;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QTiIr9/S7mq6J6FT10MqxUIo0pHU6ZjCvzkBLEK8D2o=;
	b=BN7z0KCkb7SpUMrgsgwswePYc14/GXdzl52M64ujR6QKw+yFGchzHkmla6zfKnCk48rb
	 HgvG8I74L/fwEuIAsQn3QRJcpW9DHDTNJTNgjcfmu0wOFnyp54OZfCLcnqBo3qWy5/67q
	 HNOWTuqEi/K7kPJtfl8lhxg6YobT46uyf3przoYOTbfcX0QDmnc6OD8fvKuW7geGVOhbn
	 ZBz0Pd9Qxlzg74tcVhqeDuQxjZAs3D5jvQMtmSZ3I7Jc38DcRXIgwVkFWz6CObxIdfVM8
	 4MfGhWMrScGLSWDXfHfLHikZf4TIpRYZUH8bj7FxahnA1tA+/18JZ2H4SogUlosJrkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFVn7y3I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661E606A319
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFVn7y3I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BB21F000C4;
	Mon, 19 Oct 2026 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430272;
	bh=QTiIr9/S7mq6J6FT10MqxUIo0pHU6ZjCvzkBLEK8D2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fFVn7y3Ia8q2qZofT9sI7SeKk8xoijsWF5TUfH/DQpBS/KRkk/nuMT+FtlDcl+aaK
	 zhN0iIjllfd9mg/p4Zs2A4JQFyua/Hj2N+d4UB65RpqfwX2KFWAJ9/N9aDXOZx82ol
	 kgZzKwo6PWgvX8AEcE7uMm6ZHOzRMxl2NCEjlV9BdcXPzI0wmHd+z5pyS34vWs3dKD
	 Qpcd+xmzT8Zf5JEBbag4TuOaurDk4/r8p//5m8oNRi14ubWPW+bY+LEpzmfL30EPPF
	 em0tbTRi95lanZnxq9Z6ofzLQmrj8fvlvglnNK7YX6sGstS5IUHfwCn8y3i3AtXPju
	 fJ06rPp2CjhCw==
Message-ID: <sashiko-outbox-178003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] serial: sh-sci: =?utf-8?b?RG9u4oCZdA==?= disable TX
 on TEI while the xmit kfifo still holds data
Reply-To: sashiko-reviews@lists.linux.dev
To: Biju <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261019170139.473808-3-biju.das.jz@bp.renesas.com>
References: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
 <20261019170139.473808-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 17:17:51 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] serial: sh-sci: race on control reg and xmit_fifo in sci_tx_end_in=
terrupt()
- [Medium] serial: sh-sci: sci_tx_end_interrupt() ignores x_char and uart_t=
x_stopped()
--

commit c11148ecd71f7b39ea459c7c652a2f9e70cefdac
Author: Biju Das <biju.das.jz@bp.renesas.com>

serial: sh-sci: Don=E2=80=99t disable TX on TEI while the xmit kfifo still =
holds data

This commit checks whether the transmit kfifo is empty in
sci_tx_end_interrupt() before clearing TE and TEIE on SCI and RSCI ports. If
data remains queued, it clears TEIE, sets TIE, and hands over to
sci_tx_interrupt() so transmission can continue.

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 9eb297dbc9010..d577f9de62595 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c

[ ... ]

> @@ -2012,6 +2016,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, vo=
id *ptr)
>  {
>  	struct uart_port *port =3D ptr;
>  	struct sci_port *s =3D to_sci_port(port);
> +	struct tty_port *tport =3D &port->state->port;
>  	const struct sci_common_regs *regs =3D s->params->common_regs;
>  	unsigned long flags;
>  	u32 ctrl;
> @@ -2019,9 +2024,18 @@ static irqreturn_t sci_tx_end_interrupt(int irq, v=
oid *ptr)
>  	if (s->type !=3D PORT_SCI && !sci_is_rsci_type(s->type))
>  		return sci_tx_interrupt(irq, ptr);
> =20
> +	ctrl =3D s->ops->read_reg(port, regs->control);
> +	if (!kfifo_is_empty(&tport->xmit_fifo)) {

[Severity: Medium]
What happens if transmission is stopped via flow control or if a high-prior=
ity
XON/XOFF character is pending in port->x_char when sci_tx_end_interrupt()
runs?

In sci_transmit_chars() and rsci_transmit_chars(), the transmit loop checks
both port->x_char and uart_tx_stopped(port):

	if (port->x_char) {
		c =3D port->x_char;
		port->x_char =3D 0;
	} else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) {
		break;
	}

If uart_tx_stopped(port) is true while tport->xmit_fifo is non-empty,
sci_tx_end_interrupt() will clear TEIE, set TIE (leaving TE set), and call
sci_tx_interrupt() -> transmit_chars(). Because stopped is true,
transmit_chars() breaks out of the loop without writing to the transmit data
register and without clearing TE or re-enabling TEIE.

On SCI and RSCI, starting transmission from an idle state requires a 0-to-1
transition on TE alongside TIE. Leaving the transmitter idle with TE and TIE
already set means a later uart_start() -> sci_start_tx() or rsci_start_tx()
sees TE already set and cannot trigger a TXI interrupt, wedging transmissio=
n.

Conversely, if tport->xmit_fifo is empty but port->x_char is non-zero (queu=
ed
via uart_send_xchar()), checking only !kfifo_is_empty(&tport->xmit_fifo) wi=
ll
shut down TE and TEIE without transmitting port->x_char.

Should sci_tx_end_interrupt() check port->x_char ||
(!kfifo_is_empty(&tport->xmit_fifo) && !uart_tx_stopped(port)) while holding
the port lock?

> +		uart_port_lock_irqsave(port, &flags);
> +		ctrl &=3D ~(s->params->param_bits->teie);
> +		ctrl |=3D s->params->param_bits->tie;
> +		s->ops->write_reg(port, regs->control, ctrl);
> +		uart_port_unlock_irqrestore(port, flags);
> +		return sci_tx_interrupt(irq, ptr);
> +	}
> +
>  	uart_port_lock_irqsave(port, &flags);
> -	ctrl =3D s->ops->read_reg(port, regs->control) &
> -		~(s->params->param_bits->te_clear);
> +	ctrl &=3D ~(s->params->param_bits->te_clear);
>  	s->ops->write_reg(port, regs->control, ctrl);
>  	uart_port_unlock_irqrestore(port, flags);

[Severity: High]
Can reading regs->control and checking kfifo_is_empty(&tport->xmit_fifo)
before acquiring port->lock race with concurrent updates to the control
register and xmit_fifo?

In the serial core, uart_write() holds port->lock while queuing data into
tport->xmit_fifo and calling __uart_start() -> sci_start_tx() or
rsci_start_tx():

drivers/tty/serial/sh-sci.c:sci_start_tx()
	ctrl =3D sci_serial_in(port, SCSCR);
	if (s->type =3D=3D PORT_SCI)
		ctrl |=3D SCSCR_TE;
	sci_serial_out(port, SCSCR, ctrl | SCSCR_TIE);

drivers/tty/serial/rsci.c:rsci_start_tx()
	ctrl =3D rsci_serial_in(port, CCR0);
	ctrl |=3D CCR0_TIE | CCR0_TE;
	rsci_serial_out(port, CCR0, ctrl);

If sci_tx_end_interrupt() on CPU 0 reads regs->control (with TE=3D1, TEIE=
=3D1,
TIE=3D0) and sees kfifo_is_empty(&tport->xmit_fifo) as true before acquiring
port->lock, CPU 1 can concurrently run uart_write(), enqueue bytes into
tport->xmit_fifo, and call start_tx() to set TE and TIE in regs->control. W=
hen
CPU 0 then acquires port->lock and writes back its stale ctrl & ~te_clear, =
it
overwrites the TIE and TE bits set by CPU 1 and disables the transmitter wh=
ile
newly queued data remains in tport->xmit_fifo.

Similarly, any other concurrent modification to regs->control under port->l=
ock
(such as sci_stop_tx(), rsci_stop_tx(), sci_start_rx(), sci_stop_rx(),
rsci_stop_rx(), sci_break_ctl(), or rsci_break_ctl()) between the unlocked
read_reg() and write_reg() will be clobbered by the stale ctrl value.

In addition, in the !kfifo_is_empty() branch, port->lock is dropped before
calling sci_tx_interrupt(), which immediately re-acquires port->lock to call
s->ops->transmit_chars(port). Should port->lock be held across the entire
read_reg(), fifo check, write_reg(), and s->ops->transmit_chars(port) seque=
nce?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019170139.4738=
08-1-biju.das.jz@bp.renesas.com?part=3D2
