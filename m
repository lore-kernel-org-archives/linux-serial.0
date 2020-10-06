Return-Path: <SRS0=BKBA=DN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30412C41604
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 07:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0BD20760
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 07:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="ZwrABLHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgJFHTM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Oct 2020 03:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgJFHTM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Oct 2020 03:19:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38278C061755
        for <linux-serial@vger.kernel.org>; Tue,  6 Oct 2020 00:11:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h6so6802767pgk.4
        for <linux-serial@vger.kernel.org>; Tue, 06 Oct 2020 00:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKifurvgCDlupSBVDSXNygsVGremkozH6ybHxfaNUA0=;
        b=ZwrABLHenF6wwHJRwu8niGNhGIFaNqqbuvXOuk0NAb+QHEzd94lqtkXYCMfI5Wz0fM
         Bd4NHkSoAU4G2/q0M/LxPyFpL/MU7mKdxFS1SmL7dCdBjtgKsaADEhEvQumR7hwZ7OsD
         k+oeJUaulfyALjYKpPhqt3k4G2BWc6CXJtvbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKifurvgCDlupSBVDSXNygsVGremkozH6ybHxfaNUA0=;
        b=DG5S9PPMqFyO3kOdqz5+CIHK/DaUlgSYyD9hyblHLOyubFVE2qpmJURrgmwIu/0KWS
         rV9t9sX9beroiYv1EdU5DV7N7BWgi9rIseKbxmwnuTfsLe7ZjrD8kmaCn2HIcgGKazrw
         bcjNLUd3WPeDBuZxmbhIXQqgVNsWTw0O2BWv6o1Obin/8R0V4IROsQY49OHBmAgZ01+j
         2lyxpLGTnglFlPdyOaFEZYml8cSPfp8c5DujJrbxaJIRS/Bi1B5X9cnl9fbqWRE+lwd9
         3r/loT/J31ndB1LCrJrYPNjQNPiT7IDyuv3e2Gvdg6zmraFeVHMQtvTd+0XauA2X0xqb
         RhCw==
X-Gm-Message-State: AOAM531kTE7QRZ6BKu7+TGw97qPO/rgKsJ7hxmY+f8iidJAmXX/AUVOE
        GKTd5P+dVjHKy/Y1zA8uvSdJooh5KNhdbGIBMcgl1Q==
X-Google-Smtp-Source: ABdhPJwytlbNR6z3o9Lrf/039egblbOo+pzVjfne9Vp+IJWgLJ+tzfFzaaJDscJV9v8emr55f4V+u7MBatB9pUiWwU8=
X-Received: by 2002:a63:1a21:: with SMTP id a33mr2960031pga.305.1601968315731;
 Tue, 06 Oct 2020 00:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200923120817.1667149-0-mholenko@antmicro.com>
 <20200923120817.1667149-5-mholenko@antmicro.com> <CAMuHMdVzUJwV=E-AssEHHH1GQuXcHHBUGAJZ-+GwNyPFN_KL+A@mail.gmail.com>
In-Reply-To: <CAMuHMdVzUJwV=E-AssEHHH1GQuXcHHBUGAJZ-+GwNyPFN_KL+A@mail.gmail.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 6 Oct 2020 09:11:43 +0200
Message-ID: <CAPk366R-1EAbUJXLNpsvzLPHR66rOb1OWWbd_=gNYqheJYa7Qg@mail.gmail.com>
Subject: Re: [PATCH v11 5/5] drivers/tty/serial: add LiteUART driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,

On Fri, Sep 25, 2020 at 3:41 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Mateusz,
>
> On Wed, Sep 23, 2020 at 12:12 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> > From: Filip Kokosinski <fkokosinski@antmicro.com>
> >
> > This commit adds driver for the FPGA-based LiteUART serial controller
> > from LiteX SoC builder.
> >
> > The current implementation supports LiteUART configured
> > for 32 bit data width and 8 bit CSR bus width.
> >
> > It does not support IRQ.
> >
> > Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
>
> Thanks for your patch!

Thanks for your review!

>
> > --- /dev/null
> > +++ b/drivers/tty/serial/liteuart.c
>
> > +static int liteuart_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *np = pdev->dev.of_node;
> > +       struct liteuart_port *uart;
> > +       struct uart_port *port;
> > +       struct xa_limit limit;
> > +       int dev_id, ret;
> > +
> > +       /* no device tree */
> > +       if (!np)
> > +               return -ENODEV;
> > +
> > +       /* look for aliases; auto-enumerate for free index if not found */
> > +       dev_id = of_alias_get_id(np, "serial");
> > +       if (dev_id < 0)
> > +               limit = XA_LIMIT(0, CONFIG_SERIAL_LITEUART_MAX_PORTS);
> > +       else
> > +               limit = XA_LIMIT(dev_id, dev_id);
> > +
> > +       uart = kzalloc(sizeof(struct liteuart_port), GFP_KERNEL);
>
> Who frees this memory? Use devm_kzalloc()?

You are right - it leaks right now. We'll switch to devm_kzalloc().

> > +       if (!uart)
> > +               return -ENOMEM;
> > +
> > +       ret = xa_alloc(&liteuart_array, &dev_id, uart, limit, GFP_KERNEL);
>
> Who frees this entry?

We'll add a call to xa_erase() when removing the driver.

> > +       if (ret)
> > +               return ret;
> > +
> > +       port = &uart->port;
> > +
> > +       /* get membase */
> > +       port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> > +       if (!port->membase)
> > +               return -ENXIO;
> > +
> > +       /* values not from device tree */
> > +       port->dev = &pdev->dev;
> > +       port->iotype = UPIO_MEM;
> > +       port->flags = UPF_BOOT_AUTOCONF;
> > +       port->ops = &liteuart_ops;
> > +       port->regshift = 2;
> > +       port->fifosize = 16;
> > +       port->iobase = 1;
> > +       port->type = PORT_UNKNOWN;
> > +       port->line = dev_id;
> > +       spin_lock_init(&port->lock);
> > +
> > +       return uart_add_one_port(&liteuart_driver, &uart->port);
> > +}
>
> > +static int __init liteuart_init(void)
> > +{
> > +       int res;
> > +
> > +       res = uart_register_driver(&liteuart_driver);
> > +       if (res)
> > +               return res;
> > +
> > +       res = platform_driver_register(&liteuart_platform_driver);
> > +       if (res) {
> > +               uart_unregister_driver(&liteuart_driver);
> > +               return res;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void __exit liteuart_exit(void)
> > +{
> > +       platform_driver_unregister(&liteuart_platform_driver);
> > +       uart_unregister_driver(&liteuart_driver);
> > +}
> > +
> > +module_init(liteuart_init);
> > +module_exit(liteuart_exit);
>
> Several drivers call uart_{,un}register_driver() from their .probe()
> resp. .remove() callbacks, so they can use module_platform_driver()
> instead of the above boilerplate.  Greg, what's your stance on that?

I don't have much experience here and can't tell which version is the
preferred one.

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Best regards,
Mateusz

--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
