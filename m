Return-Path: <SRS0=G31y=A2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BD8C433E1
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jul 2020 05:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D942067D
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jul 2020 05:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d2SmiiK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgGOFng (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgGOFnf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jul 2020 01:43:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E175C061755
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2020 22:43:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so2507370pje.0
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2020 22:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzipDiDAYZY58rqh2kzcXYBD7EF+tctB+0O3KKzLNz4=;
        b=d2SmiiK9RFir0tNVLiwsWneH8WEOVeZ1SBJW+gMYBzXE+LjnQ6p9R6IyK72TJZc/nr
         RQe0LtOvyt7j1XCc6EWFxN1UXLs4CCtGO6FbX+Nj9MTAzMJoid2s0rBvqfagAx5UbhfZ
         rGs7lWy/xi/JHmW8/b5gE9ZqzLzKFeM/1MIDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzipDiDAYZY58rqh2kzcXYBD7EF+tctB+0O3KKzLNz4=;
        b=PMQgJfmEbw2xc4bB73adsJ8lNIKKEwzQKN+1sB3dXZn6+T2ZRIHlIWRcsiEFpjNP6t
         NWqL1FP1Wn9zN8isgHOrlVT2XwBBInElDbCV56tB4GimdoflTa+HE6C+FFgBjjkeVWID
         jF4428fv/4/dsysmUN/l2z+eYFnHi8FUUW89RvZ++8RTKots1IW/5jdOVvijofXTabcB
         OzYoRGmDXyqGj0oYyDK8I0H0SwmMnEUNeSfbwoa5nZSeBofrsvIt0QcJOWcFqXs+46Yd
         nO459bFylsYNj8sq2n2wJc7PNTbP/EBnFr/KVsFc6idJR58hgw5ci88sydlzQ7uQqMQa
         l1Qw==
X-Gm-Message-State: AOAM532Ujw9c2VwJVnIRIPHvR3ghVTaRy9U0S0f0abiypjgs86YDUdzK
        lCNuXke+1jfueLUB08Cjz22V3ifvN6yUUg==
X-Google-Smtp-Source: ABdhPJyVHyBbJLehHNJJ1o68ZncfcRGFdfYhknrM8ro03nFGmsD4b+aR3bYdNLd1nC4ietHgX59zpA==
X-Received: by 2002:a17:90a:1089:: with SMTP id c9mr8465305pja.180.1594791814711;
        Tue, 14 Jul 2020 22:43:34 -0700 (PDT)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id o11sm790106pfp.88.2020.07.14.22.43.34
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 22:43:34 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id p3so2514716pgh.3
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2020 22:43:34 -0700 (PDT)
X-Received: by 2002:a05:6602:2008:: with SMTP id y8mr8441205iod.69.1594791376034;
 Tue, 14 Jul 2020 22:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200714124113.20918-1-Sergey.Semin@baikalelectronics.ru> <CAP2xMbvwxYaGPPCDWY2LWUc2te8kS9t-+A0zieYp3RiGMJR6ng@mail.gmail.com>
In-Reply-To: <CAP2xMbvwxYaGPPCDWY2LWUc2te8kS9t-+A0zieYp3RiGMJR6ng@mail.gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 15 Jul 2020 13:36:04 +0800
X-Gmail-Original-Message-ID: <CALiNf2-mmC1ueeiQ6xh5BPzCH_ratYPpeW1Rq=EHsA7+e6yK0A@mail.gmail.com>
Message-ID: <CALiNf2-mmC1ueeiQ6xh5BPzCH_ratYPpeW1Rq=EHsA7+e6yK0A@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_mtk: Fix high-speed baud rates clamping
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Nicolas Boichat <drinkcat@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        abhishekpandit@chromium.org, stable@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 15, 2020 at 4:45 AM Daniel Winkler <danielwinkler@google.com> wrote:
>
> Thank you Sergey for looking into this. Adding folks working on this
> platform to perform validation of the proposed patch.
>
> Best,
> Daniel
>
> On Tue, Jul 14, 2020 at 5:41 AM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > Commit 7b668c064ec3 ("serial: 8250: Fix max baud limit in generic 8250
> > port") fixed limits of a baud rate setting for a generic 8250 port.
> > In other words since that commit the baud rate has been permitted to be
> > within [uartclk / 16 / UART_DIV_MAX; uartclk / 16], which is absolutely
> > normal for a standard 8250 UART port. But there are custom 8250 ports,
> > which provide extended baud rate limits. In particular the Mediatek 8250
> > port can work with baud rates up to "uartclk" speed.
> >
> > Normally that and any other peculiarity is supposed to be handled in a
> > custom set_termios() callback implemented in the vendor-specific
> > 8250-port glue-driver. Currently that is how it's done for the most of
> > the vendor-specific 8250 ports, but for some reason for Mediatek a
> > solution has been spread out to both the glue-driver and to the generic
> > 8250-port code. Due to that a bug has been introduced, which permitted the
> > extended baud rate limit for all even for standard 8250-ports. The bug
> > has been fixed by the commit 7b668c064ec3 ("serial: 8250: Fix max baud
> > limit in generic 8250 port") by narrowing the baud rates limit back down to
> > the normal bounds. Unfortunately by doing so we also broke the
> > Mediatek-specific extended bauds feature.
> >
> > A fix of the problem described above is twofold. First since we can't get
> > back the extended baud rate limits feature to the generic set_termios()
> > function and that method supports only a standard baud rates range, the
> > requested baud rate must be locally stored before calling it and then
> > restored back to the new termios structure after the generic set_termios()
> > finished its magic business. By doing so we still use the
> > serial8250_do_set_termios() method to set the LCR/MCR/FCR/etc. registers,
> > while the extended baud rate setting procedure will be performed later in
> > the custom Mediatek-specific set_termios() callback. Second since a true
> > baud rate is now fully calculated in the custom set_termios() method we
> > need to locally update the port timeout by calling the
> > uart_update_timeout() function. After the fixes described above are
> > implemented in the 8250_mtk.c driver, the Mediatek 8250-port should
> > get back to normally working with extended baud rates.
> >
> > Link: https://lore.kernel.org/linux-serial/20200701211337.3027448-1-danielwinkler@google.com
> >
> > Fixes: 7b668c064ec3 ("serial: 8250: Fix max baud limit in generic 8250 port")
> > Reported-by: Daniel Winkler <danielwinkler@google.com>
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Tested-by: Claire Chang <tientzu@chromium.org>
> >
> > ---
> >
> > Folks, sorry for a delay with the problem fix. A solution is turned out to
> > be a bit more complicated than I originally thought in my comment to the
> > Daniel revert-patch.
> >
> > Please also note, that I don't have a Mediatek hardware to test the
> > solution suggested in the patch. The code is written as on so called
> > the tip of the pen after digging into the 8250_mtk.c and 8250_port.c
> > drivers code. So please Daniel or someone with Mediatek 8250-port
> > available on a board test this patch first and report about the results in
> > reply to this emailing thread. After that, if your conclusion is positive
> > and there is no objection against the solution design the patch can be
> > merged in.
I tested it with mt8183 + QCA6174.
The UART Bluetooth works fine with this fix.
Thanks!
> >
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Daniel Winkler <danielwinkler@google.com>
> > Cc: Aaron Sierra <asierra@xes-inc.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: BlueZ <linux-bluetooth@vger.kernel.org>
> > Cc: chromeos-bluetooth-upstreaming <chromeos-bluetooth-upstreaming@chromium.org>
> > Cc: abhishekpandit@chromium.org
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/tty/serial/8250/8250_mtk.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> > index f839380c2f4c..98b8a3e30733 100644
> > --- a/drivers/tty/serial/8250/8250_mtk.c
> > +++ b/drivers/tty/serial/8250/8250_mtk.c
> > @@ -306,8 +306,21 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
> >         }
> >  #endif
> >
> > +       /*
> > +        * Store the requested baud rate before calling the generic 8250
> > +        * set_termios method. Standard 8250 port expects bauds to be
> > +        * no higher than (uartclk / 16) so the baud will be clamped if it
> > +        * gets out of that bound. Mediatek 8250 port supports speed
> > +        * higher than that, therefore we'll get original baud rate back
> > +        * after calling the generic set_termios method and recalculate
> > +        * the speed later in this method.
> > +        */
> > +       baud = tty_termios_baud_rate(termios);
> > +
> >         serial8250_do_set_termios(port, termios, old);
> >
> > +       tty_termios_encode_baud_rate(termios, baud, baud);
> > +
> >         /*
> >          * Mediatek UARTs use an extra highspeed register (MTK_UART_HIGHS)
> >          *
> > @@ -339,6 +352,11 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
> >          */
> >         spin_lock_irqsave(&port->lock, flags);
> >
> > +       /*
> > +        * Update the per-port timeout.
> > +        */
> > +       uart_update_timeout(port, termios->c_cflag, baud);
> > +
> >         /* set DLAB we have cval saved in up->lcr from the call to the core */
> >         serial_port_out(port, UART_LCR, up->lcr | UART_LCR_DLAB);
> >         serial_dl_write(up, quot);
> > --
> > 2.26.2
> >
