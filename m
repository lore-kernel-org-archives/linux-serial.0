Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792509810;
	b=o1XrZ5UzNo53JeU0rR5Dv+botRHQJTNGakakE8O40HqIW6b7W28R/+IEHsz2+UinghLT
	 zx6+FaLjOQXB0jVUyL33LRAMYNfydXFgmh5qK4gq+VcKzNh5GJBcaQ7k9Q6pnU1Ylx4eq
	 4LSx6U4jJVb69zkO27A0nmE01dPCRsFzbEIg3upFKJJb6uzf1SRS0Z4MvhZRLLMWlZ93Z
	 tDPXAlaLea1Q841POqDJXvuqhqnhMbaKkv8Qek4r1/LzRri7+Llc3Iwg2/7v36JwHIiHe
	 TO0yzZAFm8Z8Dptsj47Kmnw9iuuqZxgl+Y0ER9kNnS6JUn9RryjYcccGQx9+7U4mXUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509810;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2TMQEKRinvD4BgkADzQKnpKRCxg8EJd5D0iYYgMwZ0s=;
	b=gzcBsd1m2LU/CiH8lX7/PZKgmdHex7Q9aQsYA9iYvxbvBV/2nd/SMHGG0TX3C9fM2ysV
	 hrad0rOPpCoQ4BLgJRt8J7pAIzdrA9Rh8LZAE6SFbO4ee/KjdcYHaTVTmjKDXHt2is4UM
	 s6jO065aJo6/OnirW92CqSqnClWYWM4PHt8pN2Ew1xO5Y37RymhirqOGBEn8AC2an+8wj
	 K6JowUMh4XbUbuA/8+UMDq+BQxf0DwYsx4Va2rDVlwkDQRh2hVMmqwtxdaYoF5AR5HJJP
	 vk7IaYFecAeR2t5F2XuCrsfXXKvXt/z3Nd+EUJlzblgQHjl8Adf21gnzFCDI7pBYXcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dyGEh6VC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FC606A33B
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 15:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC7FC606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dyGEh6VC
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53512cd2f85so37920031cf.1
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 08:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792509809; cv=none;
        d=google.com; s=arc-20260327;
        b=lPcPVYcxNsIquVPguZBF6afIIrhx8lgOrKmeQiGUEqKK8tYN3HgaOWT4CtfpKf0kGE
         4AVTfR62SYeCR9Ve+XlIIZ/Rg7XxrfugCnJl0wzGzmUEuBLH9IHRWqyjnnL+P1s8jtfi
         CMtmp2FCwvwVUZ9PalBz2mIaP9acuXWeK+yO2QsMi7WtspIzRzuCaEWgsIWo0XJBGI0V
         96j3pMumP5heGZWCJa02nOZuaK41MshggSGPrGYon2MTz/vmX/iR4ut0XJ7r67wUdZi8
         jr/eR8mCTe+zHslbDgWAoEtOt2PRCDbcG1L0fiqQ132/etvBm8KWGDQnhTX8OhwQ4guy
         et5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2TMQEKRinvD4BgkADzQKnpKRCxg8EJd5D0iYYgMwZ0s=;
        fh=K09mVAA5iDE1tu8qBsamFJCsxPTUs6BoV/KXWdgAULA=;
        b=NTQd0LK3gWnzsy7DT6DAxvmJMpRi6622xuCCQCnIaK3t2TkQb258DD5s/3QyB8lNw1
         k8ENgVQ2suxdk0ivRDsWeVhQcKkc0K3Y/1GimpYr4mBhqVaXZy2H6AJCd/5U5Vonl+Rt
         Oso28hcywLbYPUoMICK7kTGpGpwnKqU8IuvqZlkr2M0ItIz6+8wF1r9jPMRWzVP23Cpe
         xQ6kgYakMRKm2EB33IPu0YoaKPD6v7GlNY8CDYpNfF+9nL/hyOJvzB1KN+03T6ZSYugd
         HYKTZZnY5WszkIDa/7LWsWc/DiTq/Efraz0ufncAcGp8eCfBGkNUzTX+VaR9dn5rKvl6
         kQEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509809; x=1793114609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2TMQEKRinvD4BgkADzQKnpKRCxg8EJd5D0iYYgMwZ0s=;
        b=dyGEh6VCJFk+HsGLTxQl7EXSbIioSPwRIlFy6rgU7vOPMpwZEWZQPAHj/NtACudUJY
         b6HhWehdvSzrfT8laJ95BuWzJ/l3mWtRH9H3Y0Di+8WqprzzaRwkAAtJwHqOe5QwdQgM
         FUk6ChDSP7o5iZkGQCrquBuYfbVwOEx1TIegoD5X+gMhSCkZx7SDWjUEKqwBkrGG0oKa
         q8DrGIEaizuxz9tBMPYbXr7ERKLZAkor3nfRDvuIFpRUb83kVkpZI2tLm5AgQdBKRULW
         Ajn2y2ll/iVCqioGwt6C4X/zXK8qKsy29SEvJ1kA8K+6izDf5KOw3vSajegQDbSXB4eg
         2biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509809; x=1793114609;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TMQEKRinvD4BgkADzQKnpKRCxg8EJd5D0iYYgMwZ0s=;
        b=MVTd9MgDUV8hn3/wfswhKSpiOafedm1ARjmaqHSURSrnQRzlP5EevCw4WtukzdvS30
         krnU377FowktVmHCEkWsgwfx33u9RwzpsFep3OdCVdc1Y3A3WfcSPjPQEDsKrOxG+FV1
         XlSbzTA/UdrKZ8bsUcbgx2qXNXFKuzopIPf45erogNgpa2aNJdceG6+3efvGM3EzUFt+
         jSfLmCdg0WZgbYnJFmCTpIoKxoKhxmbCVghtFZE+4ItelspTkQjwyg/bvdRvZ/l0MBL7
         QqchcaFqUWi3dKm/prIWkV4if79plhjEcCYFNUDLmwIWnnHhX3Kni0R2g02awxUAHu99
         z/sw==
X-Gm-Message-State: AFq9FYLSSvDoKR+7D6JswpXxP873kfk5LERJTY4C+ZPLgWX9cQsy599e
	xY+qG1AJ+2Y6wwqoTdkO7mnbcxxhTqH+0p5BHMZMbRlTeaAL/IWyVpU3IR1QKWy5M437c/4Qbt6
	eOq6dDv/6FiYZndUdiJPzZt94djWFuK2gKY5e
X-Gm-Gg: AYBFou25p+nNezbDc0XAoM1bIN6C/cdZi6OaXeGHoiCcLwaqBLlWrSs8K+955iEEsVX
	ep6qa6cR7l5Re8AOfJB+Gub0x6RHJhoqnAUeSEAeQYGddYXf6uMOKggnCvmI2w68k+ulTvpLX3U
	yYaSwh3PUSOSyBiwPjRPoFweRqbQKi5gwDZuDphSw9rA3lT92mVdqQqBEICUkaZTh6yx8ivo0PJ
	aQkvvaFcL2okdGmBd/v+QO6c34+2sU3nNdAyI5duOV26cdB+OleDmfWtLi+/3tI7mZBWUMEr25a
	ePcrIZiKzrf+SWKhZCQYF5aRnYfI14en93Fygs2FC0GltjuLOZ4GLbWstsIfR5+Wtc+WVfApaPE
	ny5CQMtAW4UktPg==
X-Received: by 2002:a05:622a:612:b0:536:8ff4:2c2b with SMTP id
 d75a77b69052e-536934ef26fmr17840221cf.57.1792509808675; Tue, 20 Oct 2026
 08:23:28 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019170139.473808-1-biju.das.jz@bp.renesas.com>
 <20261019170139.473808-3-biju.das.jz@bp.renesas.com> <sashiko-outbox-178003@kernel.org>
In-Reply-To: <sashiko-outbox-178003@kernel.org>
From: Biju Das <biju.das.au@gmail.com>
Date: Tue, 20 Oct 2026 16:23:17 +0100
X-Gm-Features: AclHuK-08MCveBmgHFgwb756o8UH5wjdRHYCUP4_tJ97eovoqUfsB4H9A5wNi-8
Message-ID: <CADT+UeCK0n8cxm-fuJt_fGPnH4mbnZQ1PWmwjMu6_vJcQkPnzA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_2=2F4=5D_serial=3A_sh=2Dsci=3A_Don=E2=80=99t_disable_TX_o?=
	=?UTF-8?Q?n_TEI_while_the_xmit_kfifo_still_holds_data?=
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 6:17=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] serial: sh-sci: race on control reg and xmit_fifo in sci_tx_end_=
interrupt()
> - [Medium] serial: sh-sci: sci_tx_end_interrupt() ignores x_char and uart=
_tx_stopped()
> --
>
> commit c11148ecd71f7b39ea459c7c652a2f9e70cefdac
> Author: Biju Das <biju.das.jz@bp.renesas.com>
>
> serial: sh-sci: Don=E2=80=99t disable TX on TEI while the xmit kfifo stil=
l holds data
>
> This commit checks whether the transmit kfifo is empty in
> sci_tx_end_interrupt() before clearing TE and TEIE on SCI and RSCI ports.=
 If
> data remains queued, it clears TEIE, sets TIE, and hands over to
> sci_tx_interrupt() so transmission can continue.
>
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index 9eb297dbc9010..d577f9de62595 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
>
> [ ... ]
>
> > @@ -2012,6 +2016,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, =
void *ptr)
> >  {
> >       struct uart_port *port =3D ptr;
> >       struct sci_port *s =3D to_sci_port(port);
> > +     struct tty_port *tport =3D &port->state->port;
> >       const struct sci_common_regs *regs =3D s->params->common_regs;
> >       unsigned long flags;
> >       u32 ctrl;
> > @@ -2019,9 +2024,18 @@ static irqreturn_t sci_tx_end_interrupt(int irq,=
 void *ptr)
> >       if (s->type !=3D PORT_SCI && !sci_is_rsci_type(s->type))
> >               return sci_tx_interrupt(irq, ptr);
> >
> > +     ctrl =3D s->ops->read_reg(port, regs->control);
> > +     if (!kfifo_is_empty(&tport->xmit_fifo)) {
>
> [Severity: Medium]
> What happens if transmission is stopped via flow control or if a high-pri=
ority
> XON/XOFF character is pending in port->x_char when sci_tx_end_interrupt()
> runs?
>
> In sci_transmit_chars() and rsci_transmit_chars(), the transmit loop chec=
ks
> both port->x_char and uart_tx_stopped(port):
>
>         if (port->x_char) {
>                 c =3D port->x_char;
>                 port->x_char =3D 0;
>         } else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) {
>                 break;
>         }
>
> If uart_tx_stopped(port) is true while tport->xmit_fifo is non-empty,
> sci_tx_end_interrupt() will clear TEIE, set TIE (leaving TE set), and cal=
l
> sci_tx_interrupt() -> transmit_chars(). Because stopped is true,
> transmit_chars() breaks out of the loop without writing to the transmit d=
ata
> register and without clearing TE or re-enabling TEIE.
>
> On SCI and RSCI, starting transmission from an idle state requires a 0-to=
-1
> transition on TE alongside TIE. Leaving the transmitter idle with TE and =
TIE
> already set means a later uart_start() -> sci_start_tx() or rsci_start_tx=
()
> sees TE already set and cannot trigger a TXI interrupt, wedging transmiss=
ion.
>
> Conversely, if tport->xmit_fifo is empty but port->x_char is non-zero (qu=
eued
> via uart_send_xchar()), checking only !kfifo_is_empty(&tport->xmit_fifo) =
will
> shut down TE and TEIE without transmitting port->x_char.
>
> Should sci_tx_end_interrupt() check port->x_char ||
> (!kfifo_is_empty(&tport->xmit_fifo) && !uart_tx_stopped(port)) while hold=
ing
> the port lock?
>
> > +             uart_port_lock_irqsave(port, &flags);
> > +             ctrl &=3D ~(s->params->param_bits->teie);
> > +             ctrl |=3D s->params->param_bits->tie;
> > +             s->ops->write_reg(port, regs->control, ctrl);
> > +             uart_port_unlock_irqrestore(port, flags);
> > +             return sci_tx_interrupt(irq, ptr);
> > +     }
> > +
> >       uart_port_lock_irqsave(port, &flags);
> > -     ctrl =3D s->ops->read_reg(port, regs->control) &
> > -             ~(s->params->param_bits->te_clear);
> > +     ctrl &=3D ~(s->params->param_bits->te_clear);
> >       s->ops->write_reg(port, regs->control, ctrl);
> >       uart_port_unlock_irqrestore(port, flags);
>
> [Severity: High]
> Can reading regs->control and checking kfifo_is_empty(&tport->xmit_fifo)
> before acquiring port->lock race with concurrent updates to the control
> register and xmit_fifo?
>
> In the serial core, uart_write() holds port->lock while queuing data into
> tport->xmit_fifo and calling __uart_start() -> sci_start_tx() or
> rsci_start_tx():
>
> drivers/tty/serial/sh-sci.c:sci_start_tx()
>         ctrl =3D sci_serial_in(port, SCSCR);
>         if (s->type =3D=3D PORT_SCI)
>                 ctrl |=3D SCSCR_TE;
>         sci_serial_out(port, SCSCR, ctrl | SCSCR_TIE);
>
> drivers/tty/serial/rsci.c:rsci_start_tx()
>         ctrl =3D rsci_serial_in(port, CCR0);
>         ctrl |=3D CCR0_TIE | CCR0_TE;
>         rsci_serial_out(port, CCR0, ctrl);
>
> If sci_tx_end_interrupt() on CPU 0 reads regs->control (with TE=3D1, TEIE=
=3D1,
> TIE=3D0) and sees kfifo_is_empty(&tport->xmit_fifo) as true before acquir=
ing
> port->lock, CPU 1 can concurrently run uart_write(), enqueue bytes into
> tport->xmit_fifo, and call start_tx() to set TE and TIE in regs->control.=
 When
> CPU 0 then acquires port->lock and writes back its stale ctrl & ~te_clear=
, it
> overwrites the TIE and TE bits set by CPU 1 and disables the transmitter =
while
> newly queued data remains in tport->xmit_fifo.
>
> Similarly, any other concurrent modification to regs->control under port-=
>lock
> (such as sci_stop_tx(), rsci_stop_tx(), sci_start_rx(), sci_stop_rx(),
> rsci_stop_rx(), sci_break_ctl(), or rsci_break_ctl()) between the unlocke=
d
> read_reg() and write_reg() will be clobbered by the stale ctrl value.
>
> In addition, in the !kfifo_is_empty() branch, port->lock is dropped befor=
e
> calling sci_tx_interrupt(), which immediately re-acquires port->lock to c=
all
> s->ops->transmit_chars(port). Should port->lock be held across the entire
> read_reg(), fifo check, write_reg(), and s->ops->transmit_chars(port) seq=
uence?

Ok, will fix the code as

uart_port_lock_irqsave(port, &flags);
ctrl =3D s->ops->read_reg(port, regs->control);
if (port->x_char || (!kfifo_is_empty(&tport->xmit_fifo) &&
!uart_tx_stopped(port))) {
.....
uart_port_unlock_irqrestore(port, flags);
 return IRQ_HANDLED;
 }
....
 uart_port_unlock_irqrestore(port, flags);
return IRQ_HANDLED;
}

Cheers,
Biju
