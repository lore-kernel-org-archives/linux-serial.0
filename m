Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB422C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839E661288
	for <linux-serial@archiver.kernel.org>; Mon, 12 Apr 2021 10:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbhDLKNA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 12 Apr 2021 06:13:00 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:47043 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbhDLKMZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Apr 2021 06:12:25 -0400
Received: by mail-ua1-f42.google.com with SMTP id v23so4027508uaq.13;
        Mon, 12 Apr 2021 03:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TcrBhd9h32jAOg0+eioQtPRmXf1Id+px4TRLySLpr0Y=;
        b=pojU7zt7914JZDCznhNuquyo1zXZGtAXEmm1SAqVBfndHFK3NveHs4nCNXL18P0xx1
         +R5jB3Rv23iByFHYeI41ms2jQvuocNRLfNFAsRKxY8gkRsS/JmIaeymlebi0Qn3HmIMT
         L1YFlB1c/wZEwCEDihye5A9TDbvq0rZlyHq1ikTHpSvGSSs/5fMO6Dt91XpMBV6hSmJ2
         uHVb1/jGynAji/4KC5oo4MBA6fuGC1LFJgj+Db6UPNiwxNnOWyHHSailqItVYl6PHhbc
         pmStVSnfw0hFRUKONJKpQWdSl8aaBhXxEUcvh/1USl2bONKeJroAxB8IyjXkhnE++bYK
         k2tA==
X-Gm-Message-State: AOAM532BXk9mYDP013AwCn+kK9/44yX9h2luVhVAjJbVS8Ox/Ef+wSr9
        G5MXxMYcfDvRJ6OrUUDarxpgfNDjAc3Gs++6vKWLyTmu
X-Google-Smtp-Source: ABdhPJzo4bMyzVFzOTYUA2kaSWmVgOZ+indu4zQzUNFSHbGo3OWNB5ifZpkI3aqeFzmWU2/xZdpemxACoc1DmfTZhdc=
X-Received: by 2002:ab0:6306:: with SMTP id a6mr18164841uap.2.1618222326855;
 Mon, 12 Apr 2021 03:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210407101713.8694-1-andriy.shevchenko@linux.intel.com> <33a5ee25-d4c9-b5c2-b5f9-05316b1139c0@roeck-us.net>
In-Reply-To: <33a5ee25-d4c9-b5c2-b5f9-05316b1139c0@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Apr 2021 12:11:55 +0200
Message-ID: <CAMuHMdW4-DfkDg6txJNfLi2PYVzh-3aPLYE_7tUEZ6WzHEeG9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] serial: sh-sci: Respect deferred probe when
 getting IRQ
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Günter,

On Wed, Apr 7, 2021 at 10:58 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 4/7/21 3:17 AM, Andy Shevchenko wrote:
> > With platform_get_irq() and its optional variant it's possible to get
> > a deferred probe error code. Since the commit ed7027fdf4ec ("driver core:
> > platform: Make platform_get_irq_optional() optional") the error code
> > can be distinguished from no IRQ case. With this, rewrite IRQ resource
> > handling in sh-sci driver to follow above and allow to respect deferred
> > probe.
> >
> > Fixes: ed7027fdf4ec ("driver core: platform: Make platform_get_irq_optional() optional")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> This patch alone causes a hard hang early during boot. It works if applied
> together with ed7027fdf4ec. Ultimately that means that ed7027fdf4ec introduces
> a functional change, and will need to be applied very carefully. A cursory
> glance through callers of platform_get_irq_optional() shows that many
> do not handle this correctly: various drivers handle a return value of 0
> as valid interrupt, and others treat errors other than -ENXIO as fatal.
>
> Also, each patch on its own causes failures on sh, which is problematic
> when applying them even as series. See below for an idea how to
> address that.
>
> > ---
> > v2: fixed a typo: i -> 0
> >  drivers/tty/serial/sh-sci.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index ad2c189e8fc8..574f68ba50ff 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -2899,13 +2899,6 @@ static int sci_init_single(struct platform_device *dev,
> >       port->mapbase = res->start;
> >       sci_port->reg_size = resource_size(res);
> >
> > -     for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i) {
> > -             if (i)
> > -                     sci_port->irqs[i] = platform_get_irq_optional(dev, i);
> > -             else
> > -                     sci_port->irqs[i] = platform_get_irq(dev, i);
> > -     }
> > -
> >       /* The SCI generates several interrupts. They can be muxed together or
> >        * connected to different interrupt lines. In the muxed case only one
> >        * interrupt resource is specified as there is only one interrupt ID.
> > @@ -2913,12 +2906,17 @@ static int sci_init_single(struct platform_device *dev,
> >        * from the SCI, however those signals might have their own individual
> >        * interrupt ID numbers, or muxed together with another interrupt.
> >        */
> > +     sci_port->irqs[0] = platform_get_irq(dev, 0);
> >       if (sci_port->irqs[0] < 0)
> > -             return -ENXIO;
> > +             return sci_port->irqs[0];
> >
> > -     if (sci_port->irqs[1] < 0)
> > -             for (i = 1; i < ARRAY_SIZE(sci_port->irqs); i++)
> > +     for (i = 1; i < ARRAY_SIZE(sci_port->irqs); ++i) {
> > +             sci_port->irqs[i] = platform_get_irq_optional(dev, i);
> > +             if (sci_port->irqs[i] < 0)
> > +                     return sci_port->irqs[i];
> > +             if (sci_port->irqs[i] == 0)
> >                       sci_port->irqs[i] = sci_port->irqs[0];
>
> Since sh never gets -EPROBE_DEFER, the following code can be applied
> on its own and does not depend on ed7027fdf4ec.

Note that the sh-sci driver is also used on ARM32/64 and H8/300.
On ARM, I don't expect GIC interrupts causing -EPROBE_DEFER, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
