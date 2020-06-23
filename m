Return-Path: <SRS0=Q4yL=AE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F304C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 07:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574432073E
	for <linux-serial@archiver.kernel.org>; Tue, 23 Jun 2020 07:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I44oZZrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgFWHsj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731245AbgFWHsj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Jun 2020 03:48:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E3AC061573
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2020 00:48:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so22303062ljn.4
        for <linux-serial@vger.kernel.org>; Tue, 23 Jun 2020 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgZbUCewmd3JpSFrxwjakoIwIqrpt2vAjuWM35Dv1Bk=;
        b=I44oZZrXmV9zsIep9z35wn/TfLK8oAFCUs6GPfhkGdU7gZuaQNG9ONyQlpqzqEhD+4
         BJKObFrcqNpCMTIgejakJwOTULOqIcoHVjdEbZPaWC5GBkcAUVO8KO9vXIO4LMEMH8O/
         3TiyvCmKxxQE/6TTM2eT4qHlKaqczdtMCcuYHl8+i64j83hqQOGUCrmRRRq2MKaUUs4/
         oFjgioZIOrNkGX5icvtdDGAURahxgae/fet56fCKX7g6ibosuh5reuQ6LqBd9trq5AeX
         Ukjm7Opyrg9HAskD5QYxEvdR5U4Yxy/vsQv9Sp96gb16+K4RcZBSbUFYiv7M4TRbXS6s
         fCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgZbUCewmd3JpSFrxwjakoIwIqrpt2vAjuWM35Dv1Bk=;
        b=lFpyEHqKaS6ZmnFQl/bCzQh6lRoCyJD8KP6fchhTAOFK0b6x6oLe8iCvEKlNmv4Z2C
         irIaNxvgeBqQLjOrex8toJOpMFLMzVRY0y8x6cJ82r5NMNVAYIegL3k0BupTan942gMy
         0q+Q2AWTxUG2eQpP3dWiXK+WVW8okQDuiaTXDiv2YAhAPe2JpCN/UMLJDMuL60vPKorY
         8gEtYAwcQlxxcavg1WEx6zpc/ZMRB6EenJgMU6Fw+MODicPkdRmi5cVdVx/jkE+2VO3m
         wZuWuZYulyiW6Gba9H67XiiJ4428Uw/muSG+b8SglN3xN+HxCLpDVy2Ahsw9S2aaAV2W
         W3Mg==
X-Gm-Message-State: AOAM5303ml7ItBR30tdHX5SqEf3gWjSHC/mso6TXd1H4lq5wrzM5pWXk
        JKiP5ukHOwDnOYAlzcs179nc3dPVzXgAWX/JJtKzOQ==
X-Google-Smtp-Source: ABdhPJywYH0GGUmp/Ab36r+Py4ZhzCxsujeitfB7FAsBiyyA0FHiDT2hxOmOan5kf5RI57LXgURXuQSSAyxjB8A7Wlw=
X-Received: by 2002:a05:651c:1103:: with SMTP id d3mr11029863ljo.110.1592898517647;
 Tue, 23 Jun 2020 00:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <1592835984-28613-1-git-send-email-sumit.garg@linaro.org>
 <1592835984-28613-3-git-send-email-sumit.garg@linaro.org> <20200622155624.he2vs2r3e5yzf3sl@holly.lan>
In-Reply-To: <20200622155624.he2vs2r3e5yzf3sl@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 23 Jun 2020 13:18:25 +0530
Message-ID: <CAFA6WYPEbLVRSHC0QFcWusUrakmxuEjBMYJQb41htbALeTQRPg@mail.gmail.com>
Subject: Re: [PATCH 2/7] tty: serial: Add poll_get_irq() to the polling interface
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 22 Jun 2020 at 21:26, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jun 22, 2020 at 07:56:19PM +0530, Sumit Garg wrote:
> > From: Daniel Thompson <daniel.thompson@linaro.org>
>
> Sumit, to some extent this mail is me yelling at myself two years ago
> although, in my defence, at the time I choose not to post it because I
> knew it wasn't right.
>
> I'm a bit concerned to see the TODO: comment critiquing this interface
> being removed (from patch 3) without this patch being changed to
> address that comment.
>

I did consider that comment but I couldn't think of a normal scenario
where request_irq() should fail. And in case it fails as well, I did
put in "WARN_ON(res);" so that the user is notified of that particular
error scenario.

>
> > Add new API: poll_get_irq() to the polling interface in order for user
> > of polling interface to retrieve allocated IRQ corresponding to
> > underlying serial device.
> >
> > Although, serial interface still works in polling mode but interrupt
> > associated with serial device can be leveraged for special purposes like
> > debugger(kgdb) entry.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tty/serial/serial_core.c | 18 ++++++++++++++++++
> >  include/linux/serial_core.h      |  1 +
> >  include/linux/tty_driver.h       |  1 +
> >  3 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 66a5e2f..1bb033c 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2470,6 +2470,23 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
> >       port->ops->poll_put_char(port, ch);
> >       uart_port_deref(port);
> >  }
> > +
> > +static int uart_poll_get_irq(struct tty_driver *driver, int line)
> > +{
> > +     struct uart_driver *drv = driver->driver_state;
> > +     struct uart_state *state = drv->state + line;
> > +     struct uart_port *port;
> > +     int ret = -ENODEV;
> > +
> > +     port = uart_port_ref(state);
> > +     if (port && port->ops->poll_get_irq) {
> > +             ret = port->ops->poll_get_irq(port);
> > +             uart_port_deref(port);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >  #endif
> >
> >  static const struct tty_operations uart_ops = {
> > @@ -2505,6 +2522,7 @@ static const struct tty_operations uart_ops = {
> >       .poll_init      = uart_poll_init,
> >       .poll_get_char  = uart_poll_get_char,
> >       .poll_put_char  = uart_poll_put_char,
> > +     .poll_get_irq   = uart_poll_get_irq,
>
> The TODO comments claimed this API was bogus because it doesn't permit
> a free and that can cause interoperation problems with the real serial
> driver. I'll cover some of that in a reply to patch 3 but for now.
>
> Anyhow, for this patch, what are the expected semantics for
> uart_poll_get_irq().

Currently, the expected use for this API is to enable uart RX
interrupts and return corresponding IRQ id.

Although, we can make this interface modular as follows:

.poll_get_irq
.poll_enable_rx_int
.poll_disable_rx_int

Your views?

>
> In particular how do they ensure correct interlocking with the real
> serial driver underlying it (if kgdb_nmi is active on a serial port
> then the underlying driver better not be active at the same time).
>

AFAIU kgdb_nmi feature, it registers a new tty driver (ttyNMI0) which
is expected to work alongside underlying tty driver (eg. ttyAMA0 with
amba-pl011). So ttyAMA0 will only become active if user-space tries to
interact with /dev/ttyAMA0 like:

# echo "Hello World!" > /dev/ttyAMA0

So I would like to understand the downsides of having both of them
active at the same time using shared IRQ (although that won't be
possible with NMI as that doesn't support shared mode)?

-Sumit

>
> Daniel.
>
>
> >  #endif
> >  };
> >
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index 92f5eba..8b132e6 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -78,6 +78,7 @@ struct uart_ops {
> >       int             (*poll_init)(struct uart_port *);
> >       void            (*poll_put_char)(struct uart_port *, unsigned char);
> >       int             (*poll_get_char)(struct uart_port *);
> > +     int             (*poll_get_irq)(struct uart_port *);
> >  #endif
> >  };
> >
> > diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
> > index 3584462..d6da5c5 100644
> > --- a/include/linux/tty_driver.h
> > +++ b/include/linux/tty_driver.h
> > @@ -295,6 +295,7 @@ struct tty_operations {
> >       int (*poll_init)(struct tty_driver *driver, int line, char *options);
> >       int (*poll_get_char)(struct tty_driver *driver, int line);
> >       void (*poll_put_char)(struct tty_driver *driver, int line, char ch);
> > +     int (*poll_get_irq)(struct tty_driver *driver, int line);
> >  #endif
> >       int (*proc_show)(struct seq_file *, void *);
> >  } __randomize_layout;
> > --
> > 2.7.4
> >
