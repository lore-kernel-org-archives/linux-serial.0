Return-Path: <SRS0=gGpx=DC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA33C4363D
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 13:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C94C2083B
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 13:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgIYNlM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Sep 2020 09:41:12 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:37735 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgIYNlL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Sep 2020 09:41:11 -0400
Received: by mail-oo1-f66.google.com with SMTP id y25so755231oog.4;
        Fri, 25 Sep 2020 06:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttB+wOXeGsBfIwTDAKr7IKOf7HwOyFNG/wkL5Jiz3tU=;
        b=lVggYfvMaIhvODSzA3e7xcNfrnm9bU5/BcXrgReOXh60QEDHadWdefujCUCPmuw+79
         HVXxOKUU6lurRjhYxAFb2SjdRufdwr3DNoNPOyWs0wgBV/fq+8y9z9lNGpqYL3PFLhXh
         pjUcne/kFBu/aZXvmav/dyGsMalw4fBuZFdcJx7Cbw8Q7lutJMGpfvFLMDGG+u7EsVeX
         b2T3c1vFY0yVYP6cSuXA7U0fWA4hxQGfYZ+hTZUk0GaAOKmOozCkB4myVMiCqtgOXJ2E
         54LAKvDH9Q+OBOGGgoVwrz5rCIW9AKUUm3HzWC5BJtTFqFa6T0rimk7Xpzi5Y960yL0K
         tDNA==
X-Gm-Message-State: AOAM530JeecDHsaEljnJ8B/mCY1EvNI5KRmzr74jjVNkz1zl3lM32w1L
        z20zJC/E0CilG55uI2+mD363DCKVOVXncspPY0E=
X-Google-Smtp-Source: ABdhPJzQWsUM0amnsXlqz2X2JE8l+uDmhpaoRUAg7MTmoE3c+aBZzfn8lTyJKbncTychynZCqYy/tobmv0SuUZKn8a4=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr884054ooa.1.1601041270660;
 Fri, 25 Sep 2020 06:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200923120817.1667149-0-mholenko@antmicro.com> <20200923120817.1667149-5-mholenko@antmicro.com>
In-Reply-To: <20200923120817.1667149-5-mholenko@antmicro.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Sep 2020 15:40:59 +0200
Message-ID: <CAMuHMdVzUJwV=E-AssEHHH1GQuXcHHBUGAJZ-+GwNyPFN_KL+A@mail.gmail.com>
Subject: Re: [PATCH v11 5/5] drivers/tty/serial: add LiteUART driver
To:     Mateusz Holenko <mholenko@antmicro.com>
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

Hi Mateusz,

On Wed, Sep 23, 2020 at 12:12 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> From: Filip Kokosinski <fkokosinski@antmicro.com>
>
> This commit adds driver for the FPGA-based LiteUART serial controller
> from LiteX SoC builder.
>
> The current implementation supports LiteUART configured
> for 32 bit data width and 8 bit CSR bus width.
>
> It does not support IRQ.
>
> Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/tty/serial/liteuart.c

> +static int liteuart_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct liteuart_port *uart;
> +       struct uart_port *port;
> +       struct xa_limit limit;
> +       int dev_id, ret;
> +
> +       /* no device tree */
> +       if (!np)
> +               return -ENODEV;
> +
> +       /* look for aliases; auto-enumerate for free index if not found */
> +       dev_id = of_alias_get_id(np, "serial");
> +       if (dev_id < 0)
> +               limit = XA_LIMIT(0, CONFIG_SERIAL_LITEUART_MAX_PORTS);
> +       else
> +               limit = XA_LIMIT(dev_id, dev_id);
> +
> +       uart = kzalloc(sizeof(struct liteuart_port), GFP_KERNEL);

Who frees this memory? Use devm_kzalloc()?

> +       if (!uart)
> +               return -ENOMEM;
> +
> +       ret = xa_alloc(&liteuart_array, &dev_id, uart, limit, GFP_KERNEL);

Who frees this entry?

> +       if (ret)
> +               return ret;
> +
> +       port = &uart->port;
> +
> +       /* get membase */
> +       port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> +       if (!port->membase)
> +               return -ENXIO;
> +
> +       /* values not from device tree */
> +       port->dev = &pdev->dev;
> +       port->iotype = UPIO_MEM;
> +       port->flags = UPF_BOOT_AUTOCONF;
> +       port->ops = &liteuart_ops;
> +       port->regshift = 2;
> +       port->fifosize = 16;
> +       port->iobase = 1;
> +       port->type = PORT_UNKNOWN;
> +       port->line = dev_id;
> +       spin_lock_init(&port->lock);
> +
> +       return uart_add_one_port(&liteuart_driver, &uart->port);
> +}

> +static int __init liteuart_init(void)
> +{
> +       int res;
> +
> +       res = uart_register_driver(&liteuart_driver);
> +       if (res)
> +               return res;
> +
> +       res = platform_driver_register(&liteuart_platform_driver);
> +       if (res) {
> +               uart_unregister_driver(&liteuart_driver);
> +               return res;
> +       }
> +
> +       return 0;
> +}
> +
> +static void __exit liteuart_exit(void)
> +{
> +       platform_driver_unregister(&liteuart_platform_driver);
> +       uart_unregister_driver(&liteuart_driver);
> +}
> +
> +module_init(liteuart_init);
> +module_exit(liteuart_exit);

Several drivers call uart_{,un}register_driver() from their .probe()
resp. .remove() callbacks, so they can use module_platform_driver()
instead of the above boilerplate.  Greg, what's your stance on that?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
