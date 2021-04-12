Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40801C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 06:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A0F6120B
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 06:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhDLGvO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 02:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbhDLGvO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 02:51:14 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13569C061574;
        Sun, 11 Apr 2021 23:50:57 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id a11so10272802ioo.0;
        Sun, 11 Apr 2021 23:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vTiwfWDOHL0R66lm8M4vbR6GCdZy+DYNlhfLSATExuk=;
        b=GJzbzibedz+7aY9jZN6YF4quPTvBPMyZUx1znx7VsIVcfIcVRzZS/MP/kSXCKKDwx0
         FThm7lqBMMXqBaDIytRbt2QCabN1XcUHOE3ObdJ/Rbk+ROh8JIOUlkDfQDeLseHoNfEu
         SCZOQo2ZWrQFZb7RiIYMbSHQS0Xcg8QDji8/UzZEKfFGCvIuBFwzBZFJM1DBkNl0QEco
         qO3g8hgm+5s0KBDYniLFGJ62I/ryN9VgBLeCEQ9V/aoNEX2dIN3P8LL6xRvaM8QolBGi
         MeK2KdH01VCnnSiA/YaTei4xHpydDlmFyXH7Qjzo8iNjmA843N95RpdaSzKy5NMkSVd9
         LhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vTiwfWDOHL0R66lm8M4vbR6GCdZy+DYNlhfLSATExuk=;
        b=hRBsJkps5R2trehG9IU50sKenVkLA7RMeeuEcGKOrwSW/CuvbNCNmemnmoMwm4PrMx
         JuEw20K5AdcMVu6xpJhZaRaVQ62Vcgzn9IFO9SJ53Og0jC4To+zNqohMwrVYpA0o2Q2e
         ZiZfaymJVM0UAXGr1IC3goLNM1ynlwUhVpmIq88BqccVn9gvQsqp43RZVQwjeNsHKtuV
         WCVMzsAoYHnaSbDjsCMhUDxiQTQwfZF1BeLCFU+pYL4ntGN93Z8PhUfEantPuMAHtDlQ
         e/LWuy3GZXqz7e5hKi4nFp7SKU8Sf3afAF6oZNQthWpZ+csW++sDeIvWNZPlYNASsPN6
         byvQ==
X-Gm-Message-State: AOAM533znl/ejFdnbA51OWLceoz/qpEIE5/weHHGePEyaL2UkVkWsu4P
        hQbaoj5b/irEsJzY/NP0W103nbmlg5gXydjzFSE=
X-Google-Smtp-Source: ABdhPJxlyRnpoW02tNdPtMyBwwWqJdEg+3sjQ9g7WBfcw7TH5Nf8/eBNmWPLcWbE3pzHxE9OzUBoKpiSB+Z47zRnNDk=
X-Received: by 2002:a05:6638:d47:: with SMTP id d7mr26785946jak.2.1618210256515;
 Sun, 11 Apr 2021 23:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <1618202061-8243-1-git-send-email-dillon.minfei@gmail.com> <YHPgGI6EmTzmVH7g@kroah.com>
In-Reply-To: <YHPgGI6EmTzmVH7g@kroah.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 12 Apr 2021 14:50:20 +0800
Message-ID: <CAL9mu0Lt-3_O7V5HLxd5Hbt9afx9ryBUzWqmsc+2n3SP7JS6ig@mail.gmail.com>
Subject: Re: [PATCH] serial: stm32: optimize spin lock usage
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg=EF=BC=8C

Thanks for the quick response, please ignore the last private mail.

On Mon, Apr 12, 2021 at 1:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Apr 12, 2021 at 12:34:21PM +0800, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > To avoid potential deadlock in spin_lock usage, change to use
> > spin_lock_irqsave(), spin_unlock_irqrestore() in process(thread_fn) con=
text.
> > spin_lock(), spin_unlock() under handler context.
> >
> > remove unused local_irq_save/restore call.
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> > Was verified on stm32f469-disco board. need more test on stm32mp platfo=
rm.
> >
> >  drivers/tty/serial/stm32-usart.c | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm3=
2-usart.c
> > index b3675cf25a69..c4c859b34367 100644
> > --- a/drivers/tty/serial/stm32-usart.c
> > +++ b/drivers/tty/serial/stm32-usart.c
> > @@ -214,7 +214,7 @@ static void stm32_usart_receive_chars(struct uart_p=
ort *port, bool threaded)
> >       struct tty_port *tport =3D &port->state->port;
> >       struct stm32_port *stm32_port =3D to_stm32_port(port);
> >       const struct stm32_usart_offsets *ofs =3D &stm32_port->info->ofs;
> > -     unsigned long c;
> > +     unsigned long c, flags;
> >       u32 sr;
> >       char flag;
> >
> > @@ -276,9 +276,17 @@ static void stm32_usart_receive_chars(struct uart_=
port *port, bool threaded)
> >               uart_insert_char(port, sr, USART_SR_ORE, c, flag);
> >       }
> >
> > -     spin_unlock(&port->lock);
> > +     if (threaded)
> > +             spin_unlock_irqrestore(&port->lock, flags);
> > +     else
> > +             spin_unlock(&port->lock);
>
> You shouldn't have to check for this, see the other patches on the list
> recently that fixed this up to not be an issue for irq handlers.
Can you help to give more hints, or the commit id of the patch which
fixed this. thanks.

I'm still confused with this.

The stm32_usart_threaded_interrupt() is a kthread context, once
port->lock holds by this function, another serial interrupts raised,
such as USART_SR_TXE,stm32_usart_interrupt() can't get the lock,
there will be a deadlock. isn't it?

 So, shouldn't I use spin_lock{_irqsave} according to the caller's context =
?

There is a bug in this patch, the variable flags should be a global variabl=
e.

Thanks.

Dillon,
>
> thanks,
>
> greg k-h
