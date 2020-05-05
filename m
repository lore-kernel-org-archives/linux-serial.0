Return-Path: <SRS0=jHyV=6T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492D8C47247
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 14:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C40F20757
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 14:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr75qpnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgEEOCO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 May 2020 10:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728135AbgEEOCO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 10:02:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F056FC061A0F;
        Tue,  5 May 2020 07:02:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so1158167pjb.3;
        Tue, 05 May 2020 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKlq8O3c5copcC32HAW1rjhWIMxme3uga6U+C7OGHJ0=;
        b=nr75qpnbNkPUaCzRZXdBcogDFrvnmc2gSoGUQLRIWPcHDRFpqgOUQiyXUIAI4VQBGA
         fxBEVZm80tAQexmeaLuN3K/ZjE0jRWJlBvE/T9LluVyhXbFILCyLa3ElLczTstkf4qdq
         FW2QwsqjOuV6aKl8VfhURQSYuP5iFEx3alG3IlA9LV9hqWkxGpECOjppWlhgLREwMTL8
         qPzfErRdmyrJRVIk8IhYGP5V3jZ8mqP9zXhUfJ/jFi34sQ59h4O95x0PT0mfkZvTEQk6
         WQilx5P7R6GDv1OWidyHE+QOMviQwoGyX51kvDIZlm5TNhyAqsg31TIKFJO3j+hnjoxz
         zgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKlq8O3c5copcC32HAW1rjhWIMxme3uga6U+C7OGHJ0=;
        b=TKAlm4dQZ1AYiBlvxAZeONRAYRL+7IbcYim1QYNgVRzbDrtlm22uBSxHVdb2098jHu
         vNFIStEu/HJiVqmetbrRii+4NSpmTKDFxOh0Fa/LxeI2Gcsa2dvTZCUsQP49Kza7iGT6
         0ey/EXX0ZR9Vemx1YTNNte0TN0K5OE04IflqJmz0/ct6dFtueyLib8ycEs5o8GPnSNCE
         5diWkXVtsznhUFTKHgFabChTusvSwlwc6CTYAFHQA9wsr3QTq40YQ84/eWOOSxTIkpp/
         MwzH0OCqJcYAsP5OdzyDVjlLHwokvasn4YtKk9YOvsURo6WdF2FLVUg3c14YAc6MmD8p
         RYLg==
X-Gm-Message-State: AGi0PubK7jbWV1zmm/QVsZv4fIV6Lr5pvw5Rcou41v2dq96JKFUG3LSt
        gPv0Gv+GpSyw67cn8ELhPWoTkeUbiU/pd0Mr+2A=
X-Google-Smtp-Source: APiQypKPV25wPEZiONVtHiRM7MahgM9v51nz1yL9Frz3wKlrqfbdtZcP4Z7e/ybhH8pb45Ec99hS4Ho9FQh/pG3xLF8=
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr3291971pjb.25.1588687333205;
 Tue, 05 May 2020 07:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200425133939.3508912-0-mholenko@antmicro.com>
 <20200425133939.3508912-5-mholenko@antmicro.com> <CAHp75VfsiAaZez7nv7Z7E-5NL0_xObzi_LZsiWbms54jNcyv6A@mail.gmail.com>
 <CAPk366R7ty-KAtnaTyqOH6rUewRd7Wvt6GSoB3bYpS+X_xT1CQ@mail.gmail.com>
In-Reply-To: <CAPk366R7ty-KAtnaTyqOH6rUewRd7Wvt6GSoB3bYpS+X_xT1CQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 17:02:06 +0300
Message-ID: <CAHp75Ve+dJWMH722vsTQG92Y7nW8Ap+HKc2v_DV9JWquExp61Q@mail.gmail.com>
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

On Mon, May 4, 2020 at 4:44 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> On Tue, Apr 28, 2020 at 5:50 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Apr 25, 2020 at 2:45 PM Mateusz Holenko <mholenko@antmicro.com> wrote:

...

> > > Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
> > > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> >
> > Co-developed-by?
>
> Most of the coding here is done by Filip Kokosinski - I'm responsible
> for managing the patches and sending to LKML so I don't think I
> qualify as a co-developer :)

I see.

...

> > > +#define OFF_RXTX       0x00
> > > +#define SIZE_RXTX      1
> > > +#define OFF_TXFULL     0x04
> > > +#define SIZE_TXFULL    1
> > > +#define OFF_RXEMPTY    0x08
> > > +#define SIZE_RXEMPTY   1
> > > +#define OFF_EV_STATUS  0x0c
> > > +#define SIZE_EV_STATUS 1
> > > +#define OFF_EV_PENDING 0x10
> > > +#define SIZE_EV_PENDING        1
> > > +#define OFF_EV_ENABLE  0x14
> > > +#define SIZE_EV_ENABLE 1
> >
> > Why do you need all those SIZE_*?

> This is related to how LiteX peripherals (LiteUART being one of them)
> handle register access.
> The LiteX HW splits a classic 32-bit register into 4 32-bit registers,
> each one containing only 8-bit part of it.
>
> SIZE in this context means how many of those "subregisters" (still
> 32-bit wide, but with only 8-bit of meaningful data) to read/write.
> The "litex.h" header (patch 3 of this patchset) provides common
> functions for doing it, but it must know the size for each register.

So, can't you simple use them as is? I still didn't get how SIZE helps here.

...

> > > +static struct uart_driver liteuart_driver = {
> > > +       .owner = THIS_MODULE,
> > > +       .driver_name = DRIVER_NAME,
> > > +       .dev_name = DEV_NAME,
> >
> > Much easier to see if any name collisions are happen by grepping
> > similar struct definitions, but these macros are making life harder.
>
> Do you mean to avoid indirection caused by defines and write e.g.,
> `.driver_name = "liteuart"`?
>
> OK, but the reason we have defines in the first place is because we
> use the same name in many places and we want to avoid inconsistencies
> (typos, partial rename, etc.).
> What's more, looking at other serial drivers I see the notation is not
> consistent - many of them use defines for name/major/minor as well.

The problem here that .driver_name is a part of user visible
interface, so, when you rename it it will affect the module alias.
How DEV_NAME is shared? It should not be, otherwise it will collide
with other drivers.

> > > +       .major = DRIVER_MAJOR,
> > > +       .minor = DRIVER_MINOR,
> >
> > Ditto.

Ditto.

> > > +};

...

> > > +static const char *liteuart_type(struct uart_port *port)
> > > +{
> > > +       return (port->type == PORT_LITEUART) ? DRIVER_NAME : NULL;
> > > +}
> >
> > Do we need this check? Do we need a port type at all?

> This is inspired by serial_core.c and other serial drivers.
> We don't support any alternative `port->types` values so it's probably
> not necessary for us, but it seems that this is how other serial
> drivers are written too.

Legacy drivers are not the best example to take. So, if you can
survive without UART type, please go with it. Otherwise commit message
should point out why it's needed so eagerly.

...

> > > +       /* look for aliases; auto-enumerate for free index if not found */
> > > +       dev_id = of_alias_get_id(np, "serial");
> > > +       if (dev_id < 0)
> > > +               dev_id = find_first_zero_bit(liteuart_ports_in_use,
> > > +                                            CONFIG_SERIAL_LITEUART_MAX_PORTS);
> >
> > Racy.
>
> We'll protect it with a mutex to avoid race conditions.

Rather consider to use xArray API.

...

> > > +               .of_match_table = of_match_ptr(liteuart_of_match),
> >
> > of_match_ptr() makes no sense (you have depends on OF).
>
> You mean that `of_match_ptr(X)` resolves simply to `X` when
> `CONFIG_OF` is defined?
> In this context it surely can be simplified.

Yes.

...

> > > +static int __init liteuart_console_init(void)
> > > +{

> > > +}
> >
> > > +
> >
> > Extra blank line.
>
> You mean we should remove an empty line between the definition of
> liteuart_console_init() and the call to console_initcall()? It seems
> to be inconsistent across different drivers, but sure - no problem.

Less LOCs is good (but keep common sense applied).

...

> > > +/* LiteUART */
> > > +#define PORT_LITEUART  123
> >
> > We have holes in the list, use them.
> >
> > And again why we need this?
>
> This is inspired by other serial drivers that also reserves
> identifiers in this file and handles them the same way we do. We
> simply followed the convention.

See above. This ID is a part of UAPI which is kinda redundant nowadays.
You need to provide a good argument for that. Otherwise, get rid of it.

-- 
With Best Regards,
Andy Shevchenko
