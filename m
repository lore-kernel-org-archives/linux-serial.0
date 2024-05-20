Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6F1CA81
	for <linux-serial@vger.kernel.org>; Mon, 20 May 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197434; cv=none; b=p0jjtjgXmANSWzAOPj1cbsVf6AUdjXYXLN82ZZzgQZCJvXrv8VB34u8AsLT+iN0/szWH8+7NyirZfNw7mWr3jvA7lLUGN2G5Z2FQ1/h3zDEWO8rZeKia/dvTfglF3pjBCrXpyEj7fra1OcNuTiYrpbk9B0eSMFFoHItvMKd/NME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197434; c=relaxed/simple;
	bh=WlltdmOqEj9nfbnajbYQYSLXiTh257hojeLA7qO20io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfRkscr3L34u8WXkPuJ6a8Jkmu3q7GLmsfsDmG47Lur2p3k89BYZEIK4CueCrO7F+FI5TwJCj/ezrznvyZH+znDb+Xs3Ehm+RDLLY94RORIhfX9Ur0qhCkuM4n9yszf0OenVVJ/PNRPict7rxfyw25Viqb/9WIgawt8G5LH4OWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESjXGBra; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESjXGBra"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee0132a6f3so69466385ad.0
        for <linux-serial@vger.kernel.org>; Mon, 20 May 2024 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716197432; x=1716802232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lZej+SqY5aESetzqcyOnwLoHBkTzImD/3FnpWCBaMIM=;
        b=ESjXGBrahMlXjhMbjFWts5dTGYOvPA3ZCax8LZ+nMhb8Mb028+LUGeCh4DEQB4P7Ds
         CRwgiGbDHO8VMHGDv3UYXSDTL2i1hC6YWY0QDRdYILnNlyVoVMm8eQJt3LbRH6l5mu0h
         VL9jo/SX+9AQJzZfzFSVyfP1tFmflWU97XuUbzV/1GYx6D9tmFkvcSyzcUy7vNsVyc7w
         lSqFAN3bsNRIEDJ+bQLEsscif/epyx8AiY23wNRbOiUZam531h/jCTclCAXA/y8cx+4S
         CR20maqdfE9DT9qUbrv9tPOd0WhM/ZgQZFlwqQTsPcySDO3yL/9rhWzut3bBY9hJEOi6
         5wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716197432; x=1716802232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZej+SqY5aESetzqcyOnwLoHBkTzImD/3FnpWCBaMIM=;
        b=I4uixZZU8Q+EtCMdlqpRnG3GLLH+CGV2KF0h3D7sspUSS6gpBU/GaOdSzmWoDMUPlm
         IqmbW/xDRND95zJ4g0Zm+oqP7gDck0B/9rI3z5FuBuHfUo/0o512KWwNnWYSvfdc4llw
         d8bZ19DG3CrUvpgUZYiUUbXSORnq1OGgdxh7dVjj83auFRE4mPWpls9+oVTyRv1wcHKI
         9gJkToX/cguKBogLnn2/R/gmmlv+kHxL+i6C8stcFPBtCl5/soT6kDsuLtLsj4f7teS5
         gAzRNf5jyYszq9Q3XCCn0ORBESMDmCr/5yZVXxeUqnN2iHu/XT9BNGcvTQ2SqyqPAJXt
         1S8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhrEcL1fJ479fAa2pU87omRMSHIUhPERlchHZSOtmqYsHn/n11KyCwir2W9Oxle0/8Jgs887a6DaP9ui86v/GEkkVx37ux4BWJFBAN
X-Gm-Message-State: AOJu0YxM+d61VEKQG3cLqIGlpbAjVGpyYMM7gcvQOvzp/6brAoLjw40l
	e/nmyCVRy/V2bAqeSeF7+vlz16kEO9J/nVf+tQ1cHuyDnUoNp2HgLUldIaW3NTXQ/rJlr3YWjdz
	012l7LxByRDSZ+1B2Hucb+775aOY=
X-Google-Smtp-Source: AGHT+IF/h3zuayLKzJFygKDEHkN3Wr79ViB0rDsIcbB4I16m4wwjuQB2SXS+/lEcZ7M7kYruHBgiSr74fmJRNsT0GyU=
X-Received: by 2002:a17:90b:37c4:b0:2b6:24bf:8222 with SMTP id
 98e67ed59e1d1-2b6cc780371mr23838755a91.22.1716197431776; Mon, 20 May 2024
 02:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519193109.122466-1-doug@schmorgal.com> <207771fc-294a-4810-a3a2-52ea0e27360f@kernel.org>
In-Reply-To: <207771fc-294a-4810-a3a2-52ea0e27360f@kernel.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 20 May 2024 11:30:20 +0200
Message-ID: <CAOiHx=mnHsZ7U79NkNRyBsqkGhaM3vy9cgaZe=uBUXM7o8=SFg@mail.gmail.com>
Subject: Re: [PATCH] serial: pxa: Disable TX interrupt if there is no more
 data to transmit
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Doug Brown <doug@schmorgal.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, 20 May 2024 at 08:41, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 19. 05. 24, 21:31, Doug Brown wrote:
> > If a TX interrupt occurs and no new data gets loaded into the TX FIFO,
> > the UART will never fire another TX interrupt until the UART_IER_THRI
> > flag is toggled off and back on. If nothing ever calls stop_tx(), this
> > effectively results in transmissions getting hung up until another
> > unrelated UART IRQ occurs, such as an RX interrupt.
> >
> > The driver used to do this correctly until the transition to
> > uart_port_tx_limited(). This didn't matter until the behavior of
> > __uart_port_tx changed in commit 7bfb915a597a ("serial: core: only stop
> > transmit when HW fifo is empty").
> >
> > Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
> > Signed-off-by: Doug Brown <doug@schmorgal.com>
> > ---
> >
> > Note: I based this on v6.9 instead of tty-next since it's a fix; please
> > let me know if that was the wrong move and I would be happy to resubmit
> > it based on tty-next. The patch changes ever so slightly because of the
> > circ_buf -> kfifo transition. The only difference is it needs this
> > condition in the "if" statement instead:
> >
> > kfifo_is_empty(&up->port.state->port.xmit_fifo)
> >
> > This has been tested to work properly on tty-next as well.
> >
> >   drivers/tty/serial/pxa.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> > index e395ff29c1a2..8abb85bee87c 100644
> > --- a/drivers/tty/serial/pxa.c
> > +++ b/drivers/tty/serial/pxa.c
> > @@ -176,6 +176,14 @@ static void transmit_chars(struct uart_pxa_port *up)
> >   {
> >       u8 ch;
> >
> > +     /* If there is nothing left to transmit, disable the TX interrupt.
> > +      * Otherwise we can get stuck waiting for another IRQ that never happens.
> > +      */
> > +     if (uart_circ_empty(&up->port.state->xmit)) {
> > +             serial_pxa_stop_tx(&up->port);
> > +             return;
> > +     }
>
> This does not make sense. If the circ buf is empty,
> uart_port_tx_limited() should stop the TX already. You simply revert to
> the state before 7bfb915a597a, but on a per-driver basis.
>
> IOW all drivers using the helper would have exactly this issue after
> 7bfb915a597a.
>
> What driver was 7bfb915a597a about after all? The commit log of the
> commit is hopeless (it's very vague) in this respect:
> commit 7bfb915a597a301abb892f620fe5c283a9fdbd77
> Author: Jonas Gorski <jonas.gorski@gmail.com>
> Date:   Sun Mar 3 16:08:07 2024 +0100
>
>      serial: core: only stop transmit when HW fifo is empty
>
>      If the circular buffer is empty, it just means we fit all characters to
>      send into the HW fifo, but not that the hardware finished transmitting
>      them.
>
>      So if we immediately call stop_tx() after that, this may abort any
>      pending characters in the HW fifo, and cause dropped characters on the
>      console.
>
>      Fix this by only stopping tx when the tx HW fifo is actually empty.
>
>      Fixes: 8275b48b2780 ("tty: serial: introduce transmit helpers")
>
>
>
> (And it barely fixes 8275b48b2780 per se. 8275b48b2780 only moved the
> processing to a single place, most/all of the drivers already did it
> that way.)
>
> /me confused.
>
> Perhaps, it should be reverted and the affected driver should just pass
> UART_TX_NOSTOP instead?
>
> >       uart_port_tx_limited(&up->port, ch, up->port.fifosize / 2,
> >               true,
> >               serial_out(up, UART_TX, ch),
>
> thanks,

Sorry, I should have added that this is for bcm63xx_uart.c. My
reasoning for doing it this way and not via a flag was:

1. The kernel doc for uart_ops::stop_tx() says "The driver should stop
transmitting characters as soon as possible."
2. bcm63xx_uart.c's stop_tx() does exactly that, by immediately
stopping tx (leading to potentially lost output).
3. Therefore uart_port_tx_limited() is wrong by calling stop_tx()
while the transmitter is still busy, and the core issue is this.

So adding the check for the hw fifo being empty seemed to me as the
"right" fix, fixing it for all drivers that abort tx in stop_tx().

Best Regards,
Jonas
