Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016795;
	b=ZcfmRBp2+DDWIys1LN6VtkDiTjwvHaL8CygU0tLhDgR+PIKC5x3qMHZ3b+s5vWzA4LLW
	 3FlNyk0u5KqTYnhk47q7wZCjyJrlhD5gABy4F5xB325W24cbtvonXE3yLuPiEncldLpsc
	 1CAL8i0arcMEoob49NbEecy7GnD7HoiuSS36aMdQsQ0K3kZ5FkwgFaEShrkXD7rfsmCew
	 2IrSPlYtQ98GwCPACH/ZvbDZ2EugeUglJeuloLScV/d6NyrkEJyE8sLyFcQXDgPLXzfsA
	 wz1ojAkT3ThZxZQc3Iqe3apReBH09Qy60XJQxvwXSC3mKOB9cMWjV9tEM+LXb110mdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016795;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0YJvT31LJy1H2iPDNa54qCgfKqWuqqQjQxlfgmS2b1c=;
	b=G56dYzlp59kxPKoQy5iS3yQy6990RwKLCa7uc6Pnw/oPKS7e8vjrj3QF09ydiomFNGW3
	 wtOavF+av33L67kpSLTOi//ehVFCN7RwQr5li3NpEjZ0QOhUTCXHekmlTkkgK97WFdG0b
	 LokNmvpcS7kDIg3UeXA6u2XpP2//UhM8XbGglSQTs11wLtoYg+cGCIUd/dnMfOIyTbK9r
	 FFhfZwVkg66EjY8Cm9keGQ8YXdoHDRfSOKFzlZIAOYYIxbQEwSe2e9xLyc5DD6vspCCzD
	 HiO+TJeubRNMbHo6i4LEtMdbCsGiByocSe2rzZvcXs3UODzmMxRIoKHOMhzRqrW/yCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOxhwGcI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4F606A321;
	Mon, 26 Oct 2026 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOxhwGcI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F171F031E0;
	Mon, 26 Oct 2026 12:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016794;
	bh=0YJvT31LJy1H2iPDNa54qCgfKqWuqqQjQxlfgmS2b1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VOxhwGcIlNKbEQxFsxfQcpSMIvmyYsUtO8/cm+ulmEJyMIj1HZU8siKHAlK378+gC
	 XVCJLhDCgohPKxzzNcNVg1V/H/T0O+V3XaHkU4LAwZgVl2hqi2/sTyO31aeOBRZ3UL
	 GVU44aehufhlbQl+T5I3wqc20fzM2t96r2kGUf42gRujbjxwan1haxIxXqpV+0WvTk
	 0fx5NFuqtn6lHVcmrlvGKDktPJOtxXgkEajy+YiPCVKK89hBUG64Qt8CUPSffGPxY6
	 LiCDf107ToM5NAn0iI7WzNQlQndbRUzWim/C0VNZsVX1VAUADGPSKtxHJG5fixVThh
	 lmqwNfUJMx0pw==
Message-ID: <sashiko-outbox-185186@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] serial: sh-sci: Keep TX enabled on TEI while
 data is pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Biju Das" <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org, kvm@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261026-g2ul_sci-v3-2-b3097163edd5@bp.renesas.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
 <20261026-g2ul_sci-v3-2-b3097163edd5@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:13:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] serial: sh-sci: race in sci_tx_end_interrupt() disables TE during =
active TX
--

commit 923e2f6adbb69b5ca02aeee3b6ef0ae02f38d727
Author: Biju Das <biju.das.jz@bp.renesas.com>

serial: sh-sci: Keep TX enabled on TEI while data is pending

This commit keeps the transmitter enabled in sci_tx_end_interrupt() when
pending data exists in the xmit kfifo or x_char, handing over to the port's
transmit_chars() callback instead of unconditionally clearing TE and TEIE. =
It
also swaps TIE for TEIE in sci_transmit_chars() and rsci_transmit_chars() w=
hen
the port is stopped.

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 9eb297dbc9010..6df25fef5a5f5 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
[ ... ]
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

[Severity: High]
Can sci_tx_end_interrupt() clear TE while newly written bytes are still
being transmitted by the hardware?

When the last byte in tport->xmit_fifo is written to the transmit data
register, sci_transmit_chars() and rsci_transmit_chars() clear TIE and set
TEIE. If new data is queued before TEI is serviced, sci_start_tx() in
drivers/tty/serial/sh-sci.c and rsci_start_tx() in drivers/tty/serial/rsci.c
enable TIE without clearing TEIE:

drivers/tty/serial/sh-sci.c:sci_start_tx() {
	...
		if (s->type =3D=3D PORT_SCI)
			ctrl |=3D SCSCR_TE;

		sci_serial_out(port, SCSCR, ctrl | SCSCR_TIE);
	...
}

drivers/tty/serial/rsci.c:rsci_start_tx() {
	...
	ctrl =3D rsci_serial_in(port, CCR0);
	ctrl |=3D CCR0_TIE | CCR0_TE;
	rsci_serial_out(port, CCR0, ctrl);
}

In addition, when sci_tx_end_interrupt() takes the pending-data branch, it
sets s->params->param_bits->tie in regs->control while TDRE is asserted bef=
ore
calling s->ops->transmit_chars(port). Even if transmit_chars() consumes all
pending bytes and clears TIE while setting TEIE, the rising edge on
SCIx_TXI_IRQ is already latched in the interrupt controller.

Because SCIx_TXI_IRQ (sci_tx_interrupt) and SCIx_TEI_IRQ
(sci_tx_end_interrupt) are separate interrupts, sci_tx_interrupt() can acqu=
ire
port->lock before a concurrent or pending sci_tx_end_interrupt() does. If
transmit_chars() drains all newly queued bytes from tport->xmit_fifo or
port->x_char into the hardware transmit data register or FIFO, the software
queues become empty while the hardware is still actively shifting out those
bytes (TEND is 0).

When sci_tx_end_interrupt() subsequently acquires port->lock, it only checks
port->x_char and kfifo_is_empty(&tport->xmit_fifo) without checking
regs->status (such as s->params->param_bits->poll_sent_bits for TEND and TD=
RE)
to verify that hardware transmission has actually finished. Wouldn't it then
clear s->params->param_bits->te_clear, shutting down the transmitter mid-fr=
ame
and corrupting or dropping the in-flight serial data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-g2ul_sci-v=
3-0-b3097163edd5@bp.renesas.com?part=3D2
