Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792589930;
	b=ox56cq0hQ/uTE9rJlMIs52oyDIDb4enMZIwW7rOiFq+U3iT9caxFtiJcBg7OQgGaK/mX
	 M/W4CFMg6Cxk3/LDn3AQxfQWBCFap4XqnvfofnGm2ubqx3dr7iqZbj5aW/LHn3PhG2B/Q
	 bW7v5SLSClLuta9s9F1faNW0+WGd1+Mrhw5rutk7GIIbZjD7+IOQ/S/nvI1/GUj49YzWX
	 akXiqjZFItFgHeVSFQm5UULv8+uJ5nn6o6BCV0Oy1/GRj7KqiOsig/+udj3h4VA9uafws
	 VYvykOa5WIAcy3Rf4OOeiZaP71Ao6T9Jo4jHkj0OIhalZb8MJZddNtDJiyOIVaixmuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792589930;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fDVvKfg2ub2hAV/eEdld50ff/0GEJ03wTotnDkrbyaM=;
	b=Fm863Rsz5Hq4o1FOhi/EziF09OAk2g3XdOTSqC5P5Ao36nwypbL6/31QxbNlftI5QWBn
	 JMB87Dfkm/si8fv2A/3xCYboPSvbhkreI314aA5oTv1n0foPin56JWGnlzyHTYLiBwvPu
	 icYeRvud3E5ZhhYRD8qJxzMOw5X4+Jve6FR1bguzMarJ0846Bhgf2lWGCyxdP6UgoWVtQ
	 n+3BzYU9gyhKM7mgYG6eMSeATn5A4TYcO+RCIDlni2ZnYOoo76/HuIJFFPKE2LA9Dd9Jt
	 de0ElYKavCL2ARY8hrY6CViu28EhkkEWxcfSrDNgxePqmqv1AVb45+Cjw2goelfhHjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTFtWBQ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2F606A319;
	Wed, 21 Oct 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTFtWBQ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5C51F000C4;
	Wed, 21 Oct 2026 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792589929;
	bh=fDVvKfg2ub2hAV/eEdld50ff/0GEJ03wTotnDkrbyaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTFtWBQ2QNpW4moHHaaLI3h6X3oVseScMm7ZKzj4jR2OH8YH2dW0nFTVJP+LFdPBZ
	 IozVCtnhvP3SldNKStcgNmSx+DJDdrydrCmmwcPC1mTmO2RSoHsZPARAHKe1xS1nE+
	 l2EiyxbSkQ3ehsgxpqjex/lWsL6XmNDOkbsWdTlB3EUgFK8cByfCo/oPV/67SDlGX0
	 fZey/1sUA5pOdag734h1SvMgqr8DSXmhFHSYAStnpePJSAnwEda73Q+qrbNSTbQw2N
	 AGie2xKcqbz2YtzR+1QyMgrw3jC8D+Y6jr+u8zA9Em7Uf/xZfHPo3GyPjQImdudAZO
	 0z+YnVXmi+bOA==
Message-ID: <sashiko-outbox-180317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] serial: sh-sci: Keep TX enabled on TEI while
 data is pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Biju Das" <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org, kvm@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261021-g2ul_sci-v2-2-b4e038220018@bp.renesas.com>
References: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
 <20261021-g2ul_sci-v2-2-b4e038220018@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:38:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] serial: sh-sci: TX stall in sci_tx_end_interrupt() on x_char when =
stopped
- [High] serial: sh-sci: lock drop race in sci_tx_end_interrupt() before TX=
 handoff
- [Medium] serial: sh-sci: sci_tx_end_interrupt() clears TE without checkin=
g TEND
--

commit 24fb279b2944cfab75c45c919854637a4575564b
Author: Biju Das <biju.das.jz@bp.renesas.com>

serial: sh-sci: Keep TX enabled on TEI while data is pending

This commit updates sci_tx_end_interrupt() to check for pending transmit da=
ta
under the port lock before disabling the transmitter, handing over to
sci_tx_interrupt() when data is waiting. It also adds tie and teie bit masks
to struct sci_port_params_bits for the supported port variants.

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 9eb297dbc9010..58120b523ca1e 100644
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
> @@ -2020,8 +2025,17 @@ static irqreturn_t sci_tx_end_interrupt(int irq, v=
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

[Severity: High]
What happens here when port->x_char is non-zero while uart_tx_stopped(port)
is true and tport->xmit_fifo is not empty?

In that case, sci_tx_end_interrupt() clears param_bits->teie, sets
param_bits->tie, and calls sci_tx_interrupt() -> s->ops->transmit_chars(por=
t).
In both drivers/tty/serial/sh-sci.c:sci_transmit_chars() and
drivers/tty/serial/rsci.c:rsci_transmit_chars(), the loop sends port->x_cha=
r,
clears port->x_char =3D 0, and breaks out on the next iteration because sto=
pped
is true:

	do {
		unsigned char c;

		if (port->x_char) {
			c =3D port->x_char;
			port->x_char =3D 0;
		} else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) {
			break;
		}

However, at the end of sci_transmit_chars() and rsci_transmit_chars(),
param_bits->tie is only cleared and param_bits->teie is only re-enabled when
tport->xmit_fifo is empty:

drivers/tty/serial/sh-sci.c:sci_transmit_chars() {
	...
	if (kfifo_is_empty(&tport->xmit_fifo)) {
		if (s->type =3D=3D PORT_SCI) {
			ctrl =3D sci_serial_in(port, SCSCR);
			ctrl &=3D ~SCSCR_TIE;
			ctrl |=3D SCSCR_TEIE;
			sci_serial_out(port, SCSCR, ctrl);
		}

		sci_stop_tx(port);
	}
}

drivers/tty/serial/rsci.c:rsci_transmit_chars() {
	...
	if (kfifo_is_empty(&tport->xmit_fifo)) {
		ctrl =3D rsci_serial_in(port, CCR0);
		ctrl &=3D ~CCR0_TIE;
		ctrl |=3D CCR0_TEIE;
		rsci_serial_out(port, CCR0, ctrl);
	}
}

Because tport->xmit_fifo is still non-empty while the port is stopped,
param_bits->tie remains set and param_bits->teie remains cleared after
port->x_char has been written:

1. On sci ports without hardware status auto-clear, when the transmit data
   register empties and triggers sci_tx_interrupt() again with
   port->x_char =3D=3D 0 and stopped =3D=3D 1, sci_transmit_chars() breaks =
out of the
   loop without writing a new byte and calls s->ops->clear_SCxSR(), causing
   the hardware to repeatedly re-transmit the stale byte in the data regist=
er
   in an interrupt loop.

2. On both sci and rsci ports, because param_bits->teie is cleared,
   sci_tx_end_interrupt() never fires after port->x_char finishes shifting
   out, so transmit-enable is never cleared. When the port is later unstopp=
ed
   and uart_start() calls sci_start_tx() or rsci_start_tx(), transmit-enable
   and param_bits->tie are already set in regs->control, producing no rising
   edge to trigger the transmit interrupt and stalling the remaining data in
   tport->xmit_fifo.

Could sci_transmit_chars() and rsci_transmit_chars() also switch back from
param_bits->tie to param_bits->teie when stopped is true?

> +		uart_port_unlock_irqrestore(port, flags);
> +		return sci_tx_interrupt(irq, ptr);
> +	}

[Severity: High]
Does dropping port->lock here before calling sci_tx_interrupt() introduce a
race window with concurrent port operations?

sci_tx_interrupt() immediately re-acquires port->lock to invoke
s->ops->transmit_chars(port):

drivers/tty/serial/sh-sci.c:sci_tx_interrupt() {
	...
	uart_port_lock_irqsave(port, &flags);
	s->ops->transmit_chars(port);
	uart_port_unlock_irqrestore(port, flags);
	...
}

Between uart_port_unlock_irqrestore() in sci_tx_end_interrupt() and
uart_port_lock_irqsave() in sci_tx_interrupt(), another processor can acqui=
re
port->lock:

1. In drivers/tty/serial/sh-sci.c:sci_shutdown():

	uart_port_lock_irqsave(port, &flags);
	s->port.ops->stop_rx(port);
	s->port.ops->stop_tx(port);
	s->ops->shutdown_complete(port);
	uart_port_unlock_irqrestore(port, flags);

   If sci_shutdown() runs during the unlock window before sci_free_irq(s),
   sci_tx_interrupt() will subsequently run s->ops->transmit_chars(port)
   after shutdown_complete(), writing to the transmit data register and
   re-arming transmit interrupts on a shut-down port.

2. If uart_stop() runs in the window, it sets tty->flow.stopped and calls
   stop_tx() to clear param_bits->tie. When s->ops->transmit_chars(port)
   then runs with stopped set and a non-empty tport->xmit_fifo, no byte is
   written and param_bits->teie is not set, leaving transmit-enable set with
   both param_bits->tie and param_bits->teie cleared so a later
   sci_start_tx() or rsci_start_tx() sees no rising edge on transmit-enable
   and stalls.

3. If uart_flush_buffer() or a concurrent sci_tx_interrupt() drains
   tport->xmit_fifo during the window, s->ops->transmit_chars(port) runs wi=
th
   an empty fifo and clears status without writing a new byte.

Could sci_tx_end_interrupt() call s->ops->transmit_chars(port) directly whi=
le
still holding port->lock instead of unlocking and calling sci_tx_interrupt(=
)?

> +
> +	ctrl &=3D ~(s->params->param_bits->te_clear);
>  	s->ops->write_reg(port, regs->control, ctrl);
>  	uart_port_unlock_irqrestore(port, flags);

[Severity: Medium]
Can clearing param_bits->te_clear here cut off a byte that was just written
to the transmit register by a concurrent sci_tx_interrupt()?

When sci_transmit_chars() or rsci_transmit_chars() writes the final byte fr=
om
tport->xmit_fifo, it clears param_bits->tie and sets param_bits->teie while
the byte is still draining. If uart_write() queues a new byte before that
transmission finishes, drivers/tty/serial/sh-sci.c:sci_start_tx():

		if (s->type =3D=3D PORT_SCI)
			ctrl |=3D SCSCR_TE;

		sci_serial_out(port, SCSCR, ctrl | SCSCR_TIE);

and drivers/tty/serial/rsci.c:rsci_start_tx():

	ctrl =3D rsci_serial_in(port, CCR0);
	ctrl |=3D CCR0_TIE | CCR0_TE;
	rsci_serial_out(port, CCR0, ctrl);

set param_bits->tie without clearing param_bits->teie.

If the previous byte finishes shifting out and triggers
sci_tx_end_interrupt() while sci_tx_interrupt() runs on another processor a=
nd
moves the newly queued byte from tport->xmit_fifo into the data register
(leaving tport->xmit_fifo empty again), sci_tx_end_interrupt() will see
port->x_char =3D=3D 0 and kfifo_is_empty(&tport->xmit_fifo) and clear
param_bits->te_clear while the new byte is still in the hardware register.

Should sci_tx_end_interrupt() verify that param_bits->poll_sent_bits is sti=
ll
set in regs->status before clearing param_bits->te_clear (or should
sci_start_tx() and rsci_start_tx() clear param_bits->teie)?

> =20

>  	return IRQ_HANDLED;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-g2ul_sci-v=
2-0-b4e038220018@bp.renesas.com?part=3D2
