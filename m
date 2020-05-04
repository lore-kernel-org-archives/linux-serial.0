Return-Path: <SRS0=QloM=6S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6267C3A5A9
	for <linux-serial@archiver.kernel.org>; Mon,  4 May 2020 13:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4AC2075B
	for <linux-serial@archiver.kernel.org>; Mon,  4 May 2020 13:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="cr7Ja9/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEDNoi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 May 2020 09:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728181AbgEDNoh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 May 2020 09:44:37 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50219C061A0E
        for <linux-serial@vger.kernel.org>; Mon,  4 May 2020 06:44:37 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e8so11256537ilm.7
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2020 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YiKnWtOgcX4d6/1epbmpUfGmDFGrCbeypzkpKzeVrds=;
        b=cr7Ja9/WRgMiwRfDa/XjnyXjX+jzxDckxjUFre8+JFmlsh4gFnFYYzm9be1kaR9+xL
         QsHmhFlDlEvRuooxON67qa/ps6IyB5QRXYmIUA1MIXFwveyQ8uhU5U/IoFzkrzRYQdSK
         P9UPAG/6jM9E3/bJtU/QqjOOtcvPvllD85Ymg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YiKnWtOgcX4d6/1epbmpUfGmDFGrCbeypzkpKzeVrds=;
        b=dZZcfrRjhHVLvuSmfwI4wDbzxITvIi7ffThA9sTIyOAZk1ga2GbdeUCCfLd3Fi7mgs
         h+JVElk779SSs6qG6phE+FRT6Grnnep/KgyvsUgZ3T17nZMZUHtErB29eo1CuqgWOUuX
         P8SBfFMSCGwRcmJFOalbN05y5ZfyF4XpQxkkY7G92yqqiSPkAY/gRIpVI8l01YHwPmpW
         6dJMHrMuMxQmowukqTfp5eyDANaADDwe4kycxSY6NXFiz4W9BOEd5yyMcwvOC2J0Cv5S
         c9dlOx6FLFBfNYr8jFTZ9Tow46nwLTfuKwI5xjqC5JuhYygaBNnIvquf1rT+F1mVn+Ps
         qBcA==
X-Gm-Message-State: AGi0PuYpfsBO44ep9CSWW3ZgJG5aK/8u1xYKj89tO0sMz2+jAmS73Sr5
        e3AkrgGM0G1+y3FNrpj6C3Dod2ACs9bZiJjoTYqYSQ==
X-Google-Smtp-Source: APiQypKTBaTlYMo8+eC12IIkd8T/1jhkPCaKJOZPNrBKCvbb82kPAYYpg5jPBch/+CSrG4a1Op54kP6+5xC4z65Pg7U=
X-Received: by 2002:a92:b710:: with SMTP id k16mr15879307ili.270.1588599876503;
 Mon, 04 May 2020 06:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200425133939.3508912-0-mholenko@antmicro.com>
 <20200425133939.3508912-5-mholenko@antmicro.com> <CAHp75VfsiAaZez7nv7Z7E-5NL0_xObzi_LZsiWbms54jNcyv6A@mail.gmail.com>
In-Reply-To: <CAHp75VfsiAaZez7nv7Z7E-5NL0_xObzi_LZsiWbms54jNcyv6A@mail.gmail.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Mon, 4 May 2020 15:44:24 +0200
Message-ID: <CAPk366R7ty-KAtnaTyqOH6rUewRd7Wvt6GSoB3bYpS+X_xT1CQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] drivers/tty/serial: add LiteUART driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 28, 2020 at 5:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Apr 25, 2020 at 2:45 PM Mateusz Holenko <mholenko@antmicro.com> w=
rote:
> >
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
> Co-developed-by?

Most of the coding here is done by Filip Kokosinski - I'm responsible
for managing the patches and sending to LKML so I don't think I
qualify as a co-developer :)

> ...
>
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9731,6 +9731,7 @@ S:        Maintained
> >  F:     Documentation/devicetree/bindings/*/litex,*.yaml
> >  F:     drivers/soc/litex/litex_soc_ctrl.c
> >  F:     include/linux/litex.h
> > +F:     drivers/tty/serial/liteuart.c
>
> Ordering issue, run latest checkpatch.pl and parse-maintaners.pl to fix.

We'll check that.

> ...
>
> > +config SERIAL_LITEUART
> > +       tristate "LiteUART serial port support"
> > +       depends on HAS_IOMEM
>
> > +       depends on OF
>
> || COMPILE_TEST ?

Sure, we'll add that.

> > +       depends on LITEX_SOC_CONTROLLER
> > +       select SERIAL_CORE
>
> ...
>
> > +/*
> > + * CSRs definitions
> > + * (base address offsets + width)
> > + *
> > + * The definitions below are true for
> > + * LiteX SoC configured for
> > + * 8-bit CSR Bus, 32-bit aligned.
> > + *
> > + * Supporting other configurations
> > + * might require new definitions
> > + * or a more generic way of indexing
> > + * the LiteX CSRs.
> > + *
> > + * For more details on how CSRs
> > + * are defined and handled in LiteX,
> > + * see comments in the LiteX SoC Driver:
> > + * drivers/soc/litex/litex_soc_ctrl.c
> > + */
>
> Can you use some like 76 characters per line?
>

We'll reformat the code to match 76 chars.

> ...
>
> > +#define OFF_RXTX       0x00
> > +#define SIZE_RXTX      1
> > +#define OFF_TXFULL     0x04
> > +#define SIZE_TXFULL    1
> > +#define OFF_RXEMPTY    0x08
> > +#define SIZE_RXEMPTY   1
> > +#define OFF_EV_STATUS  0x0c
> > +#define SIZE_EV_STATUS 1
> > +#define OFF_EV_PENDING 0x10
> > +#define SIZE_EV_PENDING        1
> > +#define OFF_EV_ENABLE  0x14
> > +#define SIZE_EV_ENABLE 1
>
> Why do you need all those SIZE_*?
>
> ...

This is related to how LiteX peripherals (LiteUART being one of them)
handle register access.
The LiteX HW splits a classic 32-bit register into 4 32-bit registers,
each one containing only 8-bit part of it.

SIZE in this context means how many of those "subregisters" (still
32-bit wide, but with only 8-bit of meaningful data) to read/write.
The "litex.h" header (patch 3 of this patchset) provides common
functions for doing it, but it must know the size for each register.

>
> > +static struct uart_driver liteuart_driver =3D {
> > +       .owner =3D THIS_MODULE,
> > +       .driver_name =3D DRIVER_NAME,
> > +       .dev_name =3D DEV_NAME,
>
> Much easier to see if any name collisions are happen by grepping
> similar struct definitions, but these macros are making life harder.

Do you mean to avoid indirection caused by defines and write e.g.,
`.driver_name =3D "liteuart"`?

OK, but the reason we have defines in the first place is because we
use the same name in many places and we want to avoid inconsistencies
(typos, partial rename, etc.).
What's more, looking at other serial drivers I see the notation is not
consistent - many of them use defines for name/major/minor as well.

> > +       .major =3D DRIVER_MAJOR,
> > +       .minor =3D DRIVER_MINOR,
>
> Ditto.
>
> > +       .nr =3D CONFIG_SERIAL_LITEUART_MAX_PORTS,
>
> > +#ifdef CONFIG_SERIAL_LITEUART_CONSOLE
> > +       .cons =3D &liteuart_console,
> > +#endif
>
> > +};
>
> ...
>
> > +static const char *liteuart_type(struct uart_port *port)
> > +{
> > +       return (port->type =3D=3D PORT_LITEUART) ? DRIVER_NAME : NULL;
> > +}
>
> Do we need this check? Do we need a port type at all?
>
> ...

This is inspired by serial_core.c and other serial drivers.
We don't support any alternative `port->types` values so it's probably
not necessary for us, but it seems that this is how other serial
drivers are written too.

> > +static int liteuart_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *np =3D pdev->dev.of_node;
> > +       struct liteuart_port *uart;
> > +       struct uart_port *port;
> > +       int dev_id;
> > +
> > +       if (!litex_check_accessors())
> > +               return -EPROBE_DEFER;
> > +
>
> > +       /* no device tree */
> > +       if (!np)
> > +               return -ENODEV;
>
> I guess it should go first, otherwise potentially you may end up with
> deferred module above.

You are right. We'll reorder the initialization.

> > +       /* look for aliases; auto-enumerate for free index if not found=
 */
> > +       dev_id =3D of_alias_get_id(np, "serial");
> > +       if (dev_id < 0)
> > +               dev_id =3D find_first_zero_bit(liteuart_ports_in_use,
> > +                                            CONFIG_SERIAL_LITEUART_MAX=
_PORTS);
>
> Racy.

We'll protect it with a mutex to avoid race conditions.

> > +       /* get {map,mem}base */
> > +       port->mapbase =3D platform_get_resource(pdev, IORESOURCE_MEM, 0=
)->start;
> > +       port->membase =3D of_iomap(np, 0);
>
> Can't you use devm_platform_get_and_ioremap_resource() ?

This indeed can be simplified.

> > +       if (!port->membase)
> > +               return -ENXIO;
>
> > +}
>
> ...
>
> > +static struct platform_driver liteuart_platform_driver =3D {
> > +       .probe =3D liteuart_probe,
> > +       .remove =3D liteuart_remove,
> > +       .driver =3D {
> > +               .name =3D DRIVER_NAME,
>
> > +               .of_match_table =3D of_match_ptr(liteuart_of_match),
>
> of_match_ptr() makes no sense (you have depends on OF).

You mean that `of_match_ptr(X)` resolves simply to `X` when
`CONFIG_OF` is defined?
In this context it surely can be simplified.

> > +       },
> > +};
>
> ...
>
>
> > +static int __init liteuart_console_init(void)
> > +{
>
> Missed spin lock initialization.

We'll fix this.

> > +       register_console(&liteuart_console);
> > +
> > +       return 0;
> > +}
>
> > +
>
> Extra blank line.

You mean we should remove an empty line between the definition of
liteuart_console_init() and the call to console_initcall()? It seems
to be inconsistent across different drivers, but sure - no problem.

> > +console_initcall(liteuart_console_init);
>
> ...
>
> > +/* LiteUART */
> > +#define PORT_LITEUART  123
>
> We have holes in the list, use them.
>
> And again why we need this?

This is inspired by other serial drivers that also reserves
identifiers in this file and handles them the same way we do. We
simply followed the convention.

> --
> With Best Regards,
> Andy Shevchenko

Thanks for your time and the comments! We'll address them in the next
version of the patchset.

Best regards,
Mateusz Ho=C5=82enko

--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
