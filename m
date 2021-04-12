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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05710C433ED
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 08:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42D66128E
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 08:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbhDLI44 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 04:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbhDLIzt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 04:55:49 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82576C061574;
        Mon, 12 Apr 2021 01:55:31 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id n4so10322801ili.8;
        Mon, 12 Apr 2021 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LVJ7S4AbhmW2SReC6yCWbpFaYmnw9XX646YZrZZaOV4=;
        b=XXv1K4Af5TNvlVNHsnj90rtwt0QnzPrSuI6dVY64A7rbxYfPyLgygUuiqCv8/6BwSm
         QlUNslEIJilecqhOo/ND35gDq/xvLCwgeRRwiXlAYKBgujOnIi1FvUG4DgBt63U/XnAx
         e8ae+YDHN0WOVTHusYIsilwc/pUPZTyb4usURljFnke7HMj3ntJ2MVgk3jVuj0uC/aql
         DIFQNe7IeJLgLrnXhicnVFNZEyAN0iJ9cqsrLEcAulozFjDpdsykjA6yJqZedZpQ+wNV
         q3RMyBO9WsUmowo8yaW51jk43/c3wBjDW3xjHHdcdlNEtbx1uGGRRoV9v4dluN+u6b70
         L9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LVJ7S4AbhmW2SReC6yCWbpFaYmnw9XX646YZrZZaOV4=;
        b=ggSy6P/M0iUJRSqJdK5S02rH+304fiqm7HS7tzQnWolQYIOr7NKRMnfv6+0KqjD41b
         bOquhLQMu0CzvmoaQ2+hEcpwZt9JjnFbLXpskCaHn/DDxDiXfn8m5OU1/lUMLrdkBy5P
         LtkOYiAmmmS0e8X9LhazainiYHIYQU9ZNDlKK7ulS2fAcvVpaYbj6ctR1zTeLo6rHS7g
         kSJnwG72Uguf2hNywNw+YmNKkxDlw8/8iZiAOILKy55N7ezpg5LxCup6Wg6VPE3S7HOq
         Y0/8ZZrTRxaepg2MEStZb7f82T1OhZLhmTK9QUcMiKirg4DDFztRLVI/os9q0TPUsqEI
         6hiQ==
X-Gm-Message-State: AOAM532xDafMPAXrS6BxpoT0k7vVcm5lmunHxTVIopGfhgfyGEUSFpjP
        Bey/s/mEv2n+k3p6tbGzUHkny04p/Q6sqh+nOE0=
X-Google-Smtp-Source: ABdhPJzjvOSunZ3GFXhIDH+A2PRnZqLNajx99SY0l5RG/yhcKdxlkzSHA9lRYJ9e5NtH04cZ5o0zwI0TNaSspvdTwrc=
X-Received: by 2002:a05:6e02:1526:: with SMTP id i6mr18857159ilu.270.1618217730575;
 Mon, 12 Apr 2021 01:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <1618202061-8243-1-git-send-email-dillon.minfei@gmail.com>
 <YHPgGI6EmTzmVH7g@kroah.com> <CAL9mu0Lt-3_O7V5HLxd5Hbt9afx9ryBUzWqmsc+2n3SP7JS6ig@mail.gmail.com>
 <YHQEA9jn5uXQCtrN@kroah.com>
In-Reply-To: <YHQEA9jn5uXQCtrN@kroah.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 12 Apr 2021 16:54:54 +0800
Message-ID: <CAL9mu0+hi5eYEder1Mj2yjUN+eicJ9qG8Kr4GTC2mqfY405Jkg@mail.gmail.com>
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

Hi Greg,

On Mon, Apr 12, 2021 at 4:25 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Apr 12, 2021 at 02:50:20PM +0800, dillon min wrote:
> > Hi Greg=EF=BC=8C
> >
> > Thanks for the quick response, please ignore the last private mail.
> >
> > On Mon, Apr 12, 2021 at 1:52 PM Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> > >
> > > On Mon, Apr 12, 2021 at 12:34:21PM +0800, dillon.minfei@gmail.com wro=
te:
> > > > From: dillon min <dillon.minfei@gmail.com>
> > > >
> > > > To avoid potential deadlock in spin_lock usage, change to use
> > > > spin_lock_irqsave(), spin_unlock_irqrestore() in process(thread_fn)=
 context.
> > > > spin_lock(), spin_unlock() under handler context.
> > > >
> > > > remove unused local_irq_save/restore call.
> > > >
> > > > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > > > ---
> > > > Was verified on stm32f469-disco board. need more test on stm32mp pl=
atform.
> > > >
> > > >  drivers/tty/serial/stm32-usart.c | 27 +++++++++++++++++----------
> > > >  1 file changed, 17 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/=
stm32-usart.c
> > > > index b3675cf25a69..c4c859b34367 100644
> > > > --- a/drivers/tty/serial/stm32-usart.c
> > > > +++ b/drivers/tty/serial/stm32-usart.c
> > > > @@ -214,7 +214,7 @@ static void stm32_usart_receive_chars(struct ua=
rt_port *port, bool threaded)
> > > >       struct tty_port *tport =3D &port->state->port;
> > > >       struct stm32_port *stm32_port =3D to_stm32_port(port);
> > > >       const struct stm32_usart_offsets *ofs =3D &stm32_port->info->=
ofs;
> > > > -     unsigned long c;
> > > > +     unsigned long c, flags;
> > > >       u32 sr;
> > > >       char flag;
> > > >
> > > > @@ -276,9 +276,17 @@ static void stm32_usart_receive_chars(struct u=
art_port *port, bool threaded)
> > > >               uart_insert_char(port, sr, USART_SR_ORE, c, flag);
> > > >       }
> > > >
> > > > -     spin_unlock(&port->lock);
> > > > +     if (threaded)
> > > > +             spin_unlock_irqrestore(&port->lock, flags);
> > > > +     else
> > > > +             spin_unlock(&port->lock);
> > >
> > > You shouldn't have to check for this, see the other patches on the li=
st
> > > recently that fixed this up to not be an issue for irq handlers.
> > Can you help to give more hints, or the commit id of the patch which
> > fixed this. thanks.
> >
> > I'm still confused with this.
> >
> > The stm32_usart_threaded_interrupt() is a kthread context, once
> > port->lock holds by this function, another serial interrupts raised,
> > such as USART_SR_TXE,stm32_usart_interrupt() can't get the lock,
> > there will be a deadlock. isn't it?
> >
> >  So, shouldn't I use spin_lock{_irqsave} according to the caller's cont=
ext ?
>
> Please see 81e2073c175b ("genirq: Disable interrupts for force threaded
> handlers") for when threaded irq handlers have irqs disabled, isn't that
> the case you are trying to "protect" from here?
>
> Why is the "threaded" flag used at all?  The driver should not care.
>
> Also see 9baedb7baeda ("serial: imx: drop workaround for forced irq
> threading") in linux-next for an example of how this was fixed up in a
> serial driver.
>
> does that help?
>
Yes, it's really helpful. and 81e2073c175b should be highlighted in a doc.
In my past knowledge, we should care about hard irq & thread_fn lock confli=
ct.
This patch has totally avoided patching code in the separate driver side.
thanks.

I will just keep the changes in stm32_usart_console_write(), remove
these code in
thread_fn. update version 2 for you.

thanks.

Dillon,
> thanks,
>
> greg k-h
