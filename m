Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F30BC83000
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 15:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DA4206C0
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuPHn+2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgD1Puj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728038AbgD1Pui (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 11:50:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC64CC03C1AB;
        Tue, 28 Apr 2020 08:50:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so9639450pfv.8;
        Tue, 28 Apr 2020 08:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8VMwMa/Gkvod0gDNKdqy2rSBkuhRwnt0zEU6jozbUM=;
        b=nuPHn+2mMAiEvVJ6j92CR6g7NR1+0jHRX7usvqD0pxd4MPahlykOwRYxzBf5jKZqLg
         H/x1jar3xR4sYXI9IWzYIXAgTbfUOigkOmAVFBc5Y6MwA71L2xMUHiuoGnpbxHfHliJI
         gBSgGdJpIpkk2pt/SMZxANgCqIT1qsT6Pw6Qqayd1P0SYaylBFXCYOh+L+yl+rBCCPHb
         /U5jhnuwknMC12F83TWA8FGvwPWWg0adhjLFlbDQvyUbq8lDfzPnNqIG2mYPLadukmvw
         9g75oMXQX7agNQUody19LmvPGMOmgMbllPQbs6DyyYPhw99rS7iT72DmYNcNtWIVQE2D
         +c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8VMwMa/Gkvod0gDNKdqy2rSBkuhRwnt0zEU6jozbUM=;
        b=b5h3KWjnbARSqXYrprwY/P9n2AubxPEpEfVnprhIIpKpIKQ318Jug/X/csrXlxgbyS
         mFgnjHq3fN0fCo8Pid7NBgK59hbUWRrmbXnZ/sqREXQb22zDYDmtK2IG06UDnTSR2EQC
         HCPgSIm0G6pWsOAdqX76NRvu3Zq0TN43SQnFaF5qI9K9hboRcRj/yt3rntjIJphVYHad
         NWp2CflQm/fxpkL2AvPsqabmxWXXJDdlTcX7FXfPrDTsWrXCe1i3W2eO4i0jqMmIZ9eG
         nYu2H9M/uaoz2MxjMNTNlugalCPmLuEu/1UyzFjXSpTjUDD5Rf1butIFvSgmSlIfSCdV
         I+oA==
X-Gm-Message-State: AGi0PuaBEhluSXw6i8EcCxX98eVRQNrjwJyMo2qLl3SZgXcz1n0FwdHc
        6HeXN9Lc4NHvphxm4haguVFKBkt6iD0SChlGBV6ViLraZRM=
X-Google-Smtp-Source: APiQypJDFXuLdC+7TqGvLdnPTpMpPTC2g/mnXThg/pmw0fH1VkkEZurML7MrdyEpdOhV2yCbQP2yVyZzCI5uCuP3baA=
X-Received: by 2002:a62:f908:: with SMTP id o8mr53813pfh.170.1588089038103;
 Tue, 28 Apr 2020 08:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200425133939.3508912-0-mholenko@antmicro.com> <20200425133939.3508912-5-mholenko@antmicro.com>
In-Reply-To: <20200425133939.3508912-5-mholenko@antmicro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Apr 2020 18:50:31 +0300
Message-ID: <CAHp75VfsiAaZez7nv7Z7E-5NL0_xObzi_LZsiWbms54jNcyv6A@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] drivers/tty/serial: add LiteUART driver
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        devicetree <devicetree@vger.kernel.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Apr 25, 2020 at 2:45 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
>
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

Co-developed-by?

...

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9731,6 +9731,7 @@ S:        Maintained
>  F:     Documentation/devicetree/bindings/*/litex,*.yaml
>  F:     drivers/soc/litex/litex_soc_ctrl.c
>  F:     include/linux/litex.h
> +F:     drivers/tty/serial/liteuart.c

Ordering issue, run latest checkpatch.pl and parse-maintaners.pl to fix.

...

> +config SERIAL_LITEUART
> +       tristate "LiteUART serial port support"
> +       depends on HAS_IOMEM

> +       depends on OF

|| COMPILE_TEST ?

> +       depends on LITEX_SOC_CONTROLLER
> +       select SERIAL_CORE

...

> +/*
> + * CSRs definitions
> + * (base address offsets + width)
> + *
> + * The definitions below are true for
> + * LiteX SoC configured for
> + * 8-bit CSR Bus, 32-bit aligned.
> + *
> + * Supporting other configurations
> + * might require new definitions
> + * or a more generic way of indexing
> + * the LiteX CSRs.
> + *
> + * For more details on how CSRs
> + * are defined and handled in LiteX,
> + * see comments in the LiteX SoC Driver:
> + * drivers/soc/litex/litex_soc_ctrl.c
> + */

Can you use some like 76 characters per line?

...

> +#define OFF_RXTX       0x00
> +#define SIZE_RXTX      1
> +#define OFF_TXFULL     0x04
> +#define SIZE_TXFULL    1
> +#define OFF_RXEMPTY    0x08
> +#define SIZE_RXEMPTY   1
> +#define OFF_EV_STATUS  0x0c
> +#define SIZE_EV_STATUS 1
> +#define OFF_EV_PENDING 0x10
> +#define SIZE_EV_PENDING        1
> +#define OFF_EV_ENABLE  0x14
> +#define SIZE_EV_ENABLE 1

Why do you need all those SIZE_*?

...

> +static struct uart_driver liteuart_driver = {
> +       .owner = THIS_MODULE,
> +       .driver_name = DRIVER_NAME,
> +       .dev_name = DEV_NAME,

Much easier to see if any name collisions are happen by grepping
similar struct definitions, but these macros are making life harder.

> +       .major = DRIVER_MAJOR,
> +       .minor = DRIVER_MINOR,

Ditto.

> +       .nr = CONFIG_SERIAL_LITEUART_MAX_PORTS,

> +#ifdef CONFIG_SERIAL_LITEUART_CONSOLE
> +       .cons = &liteuart_console,
> +#endif

> +};

...

> +static const char *liteuart_type(struct uart_port *port)
> +{
> +       return (port->type == PORT_LITEUART) ? DRIVER_NAME : NULL;
> +}

Do we need this check? Do we need a port type at all?

...

> +static int liteuart_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct liteuart_port *uart;
> +       struct uart_port *port;
> +       int dev_id;
> +
> +       if (!litex_check_accessors())
> +               return -EPROBE_DEFER;
> +

> +       /* no device tree */
> +       if (!np)
> +               return -ENODEV;

I guess it should go first, otherwise potentially you may end up with
deferred module above.

> +       /* look for aliases; auto-enumerate for free index if not found */
> +       dev_id = of_alias_get_id(np, "serial");
> +       if (dev_id < 0)
> +               dev_id = find_first_zero_bit(liteuart_ports_in_use,
> +                                            CONFIG_SERIAL_LITEUART_MAX_PORTS);

Racy.

> +       /* get {map,mem}base */
> +       port->mapbase = platform_get_resource(pdev, IORESOURCE_MEM, 0)->start;
> +       port->membase = of_iomap(np, 0);

Can't you use devm_platform_get_and_ioremap_resource() ?

> +       if (!port->membase)
> +               return -ENXIO;

> +}

...

> +static struct platform_driver liteuart_platform_driver = {
> +       .probe = liteuart_probe,
> +       .remove = liteuart_remove,
> +       .driver = {
> +               .name = DRIVER_NAME,

> +               .of_match_table = of_match_ptr(liteuart_of_match),

of_match_ptr() makes no sense (you have depends on OF).

> +       },
> +};

...


> +static int __init liteuart_console_init(void)
> +{

Missed spin lock initialization.

> +       register_console(&liteuart_console);
> +
> +       return 0;
> +}

> +

Extra blank line.

> +console_initcall(liteuart_console_init);

...

> +/* LiteUART */
> +#define PORT_LITEUART  123

We have holes in the list, use them.

And again why we need this?

-- 
With Best Regards,
Andy Shevchenko
