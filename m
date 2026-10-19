Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430369;
	b=LK/v1X9O5OOVmwc6p2FMe3Zxs9K9yOVVm+tZX7PRiY8E3TrEB2C76D7ABLHjxbMOtW0X
	 Ct85SrmRW42LE8Gt0hD6u/GAApQNv0EvZm2oMhrxZITVOEHi9v5L43WTwHZV/ucGi2rPO
	 DgJjVOPb5dAZUskZr7vxPdIiuoEV4yuGR8kAIZ8sATSEkYbJVXFQDTKG1CsxwbM3lVcmK
	 Zn7q3Lr29MZ77o03ccf5qu170pNoJzZOCEVdQ8SCI82B5LRfSCw9D0lJvKEntLMOr/Iz3
	 uN5pi3Dm4sWheSznSLOg8oJNjjd6vUJqbk5wClXFsUzqgkE/E4NZ7vznaAQ1QTs/yrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430369;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6lOMYk4POAG+Z5ZG50C62CD1oMCjH0i85uU/EZzqWXQ=;
	b=m1iUYAhcU2+KZF6cK0ZeqjfWEEUsZ9l1huz2eYSUOgeIZ/zaP8EZSp9rvYkzj1H5F+m7
	 +oiWgcTwPH/rusHds3boCM7GpEGeQ+9hyVkHveeXqdS4HwAdO1D7ec+PSWYmd3M36IQox
	 hVCV9FEQ1ORRdLuiM0l1pzjTWv0n1ParT9G/WcLnosO4NWCGR4zTQGp3or4kPStrrK2Yy
	 3DJWkiILsp/rICyiSWSfHqlCouY/yzaTAe4a/4c/oAkOVor5UybYZH5mITN703vlDfFB2
	 uvtpMatRq+yNJCYopE4hZ3SD8XEzqbhfOzNEemm1OVubgQG+cBpV2kez0xDjzKrvU2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL9sStip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987A606A31A
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL9sStip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C76C1F000C4;
	Mon, 19 Oct 2026 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430368;
	bh=6lOMYk4POAG+Z5ZG50C62CD1oMCjH0i85uU/EZzqWXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EL9sStippNEdUIX40nDuc//2LyiFuzGe0NW9Cix8EqUwveYnzllThT4Yl2wq6py8d
	 Xc4BQjSY8redpnI7fbKxfPFQ+495vl64+0GZ5iQmaa5TcushefXOcVpjZqyB9oXe8o
	 BjaUz9VqwpWVMQmMAfcoaWC6L4TxTo0KG8L86066rlQVjUqkCKah0FHLW/2SdjP+RN
	 wMT5Mcdqb8iB0egrtk+8tjCeW3syG4rsrYFtpOMRpMlCI26ije4OQ4yILZqCgc1wbv
	 56OW/snDKS/6KDbECzJ8nifpmsy21timzHevid73wNHWBLZYGL5NEjYg0KbIOHT6bU
	 CN3KYn0xOUSHg==
Message-ID: <sashiko-outbox-178011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] serial: sh-sci: Skip TDxE status clear for PORT_SCI
Reply-To: sashiko-reviews@lists.linux.dev
To: Biju <biju.das.au@gmail.com>
Cc: linux-serial@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261019170139.473808-4-biju.das.jz@bp.renesas.com>
References: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
 <20261019170139.473808-4-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 17:19:28 +0000
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
- [High] serial: sh-sci: broken TX on SuperH PORT_SCI from skipping clear_S=
CxSR()
- [Medium] serial: sh-sci: unlocked control register RMW in sci_tx_end_inte=
rrupt()
--

commit c9eeab42d1c45b13adb330fd8baab03f6ddbfeb6
Author: Au Dang <au.dang.jx@renesas.com>

serial: sh-sci: Skip TDxE status clear for PORT_SCI

This commit skips calling clear_SCxSR() to clear the TDxE status bit for
PORT_SCI in sci_poll_put_char() and sci_transmit_chars(), relying on hardwa=
re
to automatically clear the bit when data is written to TDR.

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index d577f9de62595..e4c7a3e146884 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -913,7 +913,8 @@ static void sci_poll_put_char(struct uart_port *port,=
 unsigned char c)
>  	} while (!(status & SCxSR_TDxE(port)));
> =20
>  	sci_serial_out(port, SCxTDR, c);
> -	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
> +	if (s->type !=3D PORT_SCI)
> +		s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
>  }
>  #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
>  	  CONFIG_SERIAL_SH_SCI_EARLYCON */

[Severity: High]
Will skipping clear_SCxSR() for all PORT_SCI ports break transmission on
classic SuperH SCI hardware?

In drivers/tty/serial/sh-sci.c, PORT_SCI is shared between DT-based Renesas
RZ/G2L SCIg ports (such as renesas,r9a07g044-sci matching renesas,sci) and
classic non-DT SuperH SCI ports (SH770x, SH7750, and SH7760 registered via
plat_sci_port with .type =3D PORT_SCI).

While RZ/G2L SCIg hardware automatically clears SSR.TDRE when transmit data=
 is
written to TDR, classic SuperH SCI hardware does not clear SCSSR.TDRE (or
TEND) on CPU writes to SCTDR. On classic SuperH SCI, software must read SCS=
SR
with TDRE =3D=3D 1, write the byte to SCTDR, and then explicitly clear TDRE=
 to 0
via clear_SCxSR() before the hardware transfers SCTDR to the transmit shift
register (SCTSR) and begins shifting.

With this check in both sci_poll_put_char() and sci_transmit_chars(),
SCSSR.TDRE is never cleared on classic SuperH PORT_SCI systems, preventing
SCTDR from transferring to SCTSR in interrupt-driven transmission and causi=
ng
sci_poll_put_char() to see TDRE remain 1 and overwrite SCTDR without shifti=
ng
characters out.

Notice also that sci_poll_put_char() and sci_transmit_chars() are the only
callers of SCxSR_TDxE_CLEAR(port):

#define SCxSR_TDxE_CLEAR(port) \
	(((port)->type =3D=3D PORT_SCI) ? SCI_TDxE_CLEAR : SCIF_TDxE_CLEAR)

Skipping both calls when s->type =3D=3D PORT_SCI leaves SCI_TDxE_CLEAR and =
the
PORT_SCI branch in SCxSR_TDxE_CLEAR() completely unreachable.

> @@ -1049,7 +1050,8 @@ static void sci_transmit_chars(struct uart_port *po=
rt)
>  		port->icount.tx++;
>  	} while (--count > 0);
> =20
> -	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
> +	if (s->type !=3D PORT_SCI)
> +		s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
> =20
>  	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
>  		uart_write_wakeup(port);

[Severity: Medium]
Now that PORT_SCI avoids the extra TXI interrupt and transitions directly to
TEIE-driven completion when xmit_fifo becomes empty in sci_transmit_chars():

	if (kfifo_is_empty(&tport->xmit_fifo)) {
		if (s->type =3D=3D PORT_SCI) {
			ctrl =3D sci_serial_in(port, SCSCR);
			ctrl &=3D ~SCSCR_TIE;
			ctrl |=3D SCSCR_TEIE;
			sci_serial_out(port, SCSCR, ctrl);
		}

		sci_stop_tx(port);
	}

can the unlocked control register read in sci_tx_end_interrupt() race with a
concurrent sci_start_tx() and stall transmission?

In drivers/tty/serial/sh-sci.c:sci_tx_end_interrupt(), the control register
and xmit_fifo are read before acquiring port->lock:

	ctrl =3D s->ops->read_reg(port, regs->control);
	if (!kfifo_is_empty(&tport->xmit_fifo)) {
		uart_port_lock_irqsave(port, &flags);
		ctrl &=3D ~(s->params->param_bits->teie);
		ctrl |=3D s->params->param_bits->tie;
		s->ops->write_reg(port, regs->control, ctrl);
		uart_port_unlock_irqrestore(port, flags);
		return sci_tx_interrupt(irq, ptr);
	}

	uart_port_lock_irqsave(port, &flags);
	ctrl &=3D ~(s->params->param_bits->te_clear);
	s->ops->write_reg(port, regs->control, ctrl);
	uart_port_unlock_irqrestore(port, flags);

If CPU A enters sci_tx_end_interrupt(), reads regs->control (with TIE =3D=
=3D 0),
and sees kfifo_is_empty(&tport->xmit_fifo) =3D=3D true before acquiring
port->lock, CPU B can concurrently run uart_write() -> __uart_start() ->
sci_start_tx() under port->lock, queueing new bytes into xmit_fifo and sett=
ing
SCSCR_TE | SCSCR_TIE in regs->control.

When CPU A then acquires port->lock and writes back its stale ctrl value wi=
th
te_clear masked off, it overwrites the TIE and TE bits just enabled by
sci_start_tx(), leaving the newly queued bytes stuck in xmit_fifo. Similarl=
y,
if kfifo_is_empty() is false, reading ctrl outside port->lock can clobber
concurrent control register updates made under port->lock by sci_start_rx()=
 or
sci_stop_rx().

Should sci_tx_end_interrupt() acquire port->lock before reading regs->contr=
ol
and checking kfifo_is_empty(&tport->xmit_fifo)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019170139.4738=
08-1-biju.das.jz@bp.renesas.com?part=3D3
