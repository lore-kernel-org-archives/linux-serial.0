Return-Path: <SRS0=Pw1G=6W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32198C38A2A
	for <linux-serial@archiver.kernel.org>; Fri,  8 May 2020 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0B420A8B
	for <linux-serial@archiver.kernel.org>; Fri,  8 May 2020 10:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="ZCLfulpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEHKQm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 May 2020 06:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgEHKQl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 May 2020 06:16:41 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF93AC05BD0A
        for <linux-serial@vger.kernel.org>; Fri,  8 May 2020 03:16:41 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c18so918055ile.5
        for <linux-serial@vger.kernel.org>; Fri, 08 May 2020 03:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEXsi/2/gcHTicFNwkUKYKOSQzsw2JinoKBtqiEq4Ak=;
        b=ZCLfulpeyngEd4yz2SJvKG3yGrxKwnKhhi5QX4GfJlG5uS0LTTYAlfqjrncV+NJ2/p
         mwJC5c3jyQiDEf8ODHYJIAcLZZAgv9aZsrcPWwsbl8b7T3CX2Os7HixRvqGywrEvNeRb
         k5BA2Xd+AxSS9Z8W8WzZRfRgpQFRdsK4sGlFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEXsi/2/gcHTicFNwkUKYKOSQzsw2JinoKBtqiEq4Ak=;
        b=GIyNVI2pDO0YFdfi0glQlLDEeKrZhxuqiTNsNo1H0Ukqr31i9EodgDkPsIG626tQc3
         JVZZoNQD0h24Tlgouwk9C+bLzJftQ9yrrBIpFWREEh+X4EFfgRIYxutmPC5EzKqLinUE
         sWMZDXASdEBQmdRx8LwtVjgzyi0m77NI/MO/uj8JSHG3tSKB5rGCsdjDaVfIUV9t5eBq
         PeaM+uoqs72ejykyJVG/579qQZFngvjr5b6hqZgg5iyyjSCbrkzmS6QqpfTGWuDvCbLZ
         b4jlMqQxyNTrrG78D2DKJVkgncxa1/a0IcPjbHhe5XOAPYtMAdgxx7Z9Yx/FbmLKvfyA
         4wBg==
X-Gm-Message-State: AGi0Pub55m7KLT2CzvHSVpIvdb2XtuAFDtW3yfORvAy7u2BTreoq/hcc
        2kafHtNCUK+adnm2o1+qQcyB22mhwx4XEsYhiAPgAg==
X-Google-Smtp-Source: APiQypKazcFPsQFZTWLbk5dVJYYnxKXoFx2TOMU6QFmSfvoDPajKFG0aMKZbR9lyDGfTMeNcVcH0A9h+s6Wn0OwTxsA=
X-Received: by 2002:a92:2910:: with SMTP id l16mr2003308ilg.256.1588933000778;
 Fri, 08 May 2020 03:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200425133939.3508912-0-mholenko@antmicro.com>
 <20200425133939.3508912-5-mholenko@antmicro.com> <CAHp75VfsiAaZez7nv7Z7E-5NL0_xObzi_LZsiWbms54jNcyv6A@mail.gmail.com>
 <CAPk366R7ty-KAtnaTyqOH6rUewRd7Wvt6GSoB3bYpS+X_xT1CQ@mail.gmail.com> <CAHp75Ve+dJWMH722vsTQG92Y7nW8Ap+HKc2v_DV9JWquExp61Q@mail.gmail.com>
In-Reply-To: <CAHp75Ve+dJWMH722vsTQG92Y7nW8Ap+HKc2v_DV9JWquExp61Q@mail.gmail.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Fri, 8 May 2020 12:16:28 +0200
Message-ID: <CAPk366T6K3jy7fz+YpWAh9fF=XbBGZceaL=qHEMwaX1L91LxSA@mail.gmail.com>
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
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 5, 2020 at 4:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, May 4, 2020 at 4:44 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> > On Tue, Apr 28, 2020 at 5:50 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sat, Apr 25, 2020 at 2:45 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
>
> ...
>
> > > > Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
> > > > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > >
> > > Co-developed-by?
> >
> > Most of the coding here is done by Filip Kokosinski - I'm responsible
> > for managing the patches and sending to LKML so I don't think I
> > qualify as a co-developer :)
>
> I see.
>
> ...
>
> > > > +#define OFF_RXTX       0x00
> > > > +#define SIZE_RXTX      1
> > > > +#define OFF_TXFULL     0x04
> > > > +#define SIZE_TXFULL    1
> > > > +#define OFF_RXEMPTY    0x08
> > > > +#define SIZE_RXEMPTY   1
> > > > +#define OFF_EV_STATUS  0x0c
> > > > +#define SIZE_EV_STATUS 1
> > > > +#define OFF_EV_PENDING 0x10
> > > > +#define SIZE_EV_PENDING        1
> > > > +#define OFF_EV_ENABLE  0x14
> > > > +#define SIZE_EV_ENABLE 1
> > >
> > > Why do you need all those SIZE_*?
>
> > This is related to how LiteX peripherals (LiteUART being one of them)
> > handle register access.
> > The LiteX HW splits a classic 32-bit register into 4 32-bit registers,
> > each one containing only 8-bit part of it.
> >
> > SIZE in this context means how many of those "subregisters" (still
> > 32-bit wide, but with only 8-bit of meaningful data) to read/write.
> > The "litex.h" header (patch 3 of this patchset) provides common
> > functions for doing it, but it must know the size for each register.
>
> So, can't you simple use them as is? I still didn't get how SIZE helps here.
>
> ...

Do you mean to call litex_get_reg() with 1 directly as a second argument instead
of using a defined value (which in the context of uart driver is 1 for
every register anyway)?

Sure, this is doable. We just thought a named define will explain
better what's going on.

In general case, register's offsets and sizes might differ between
LiteX configurations
(LiteX is an SoC generator capable of creating different setups) so
having a dynamic
size in litex_get_reg() is useful.
With this patchset we are targeting a single (default) configuration
(so it's enough for
OFF_ and SIZE_ to be fixed), but this could be extended to be more
dynamic in the future.

> > > > +static struct uart_driver liteuart_driver = {
> > > > +       .owner = THIS_MODULE,
> > > > +       .driver_name = DRIVER_NAME,
> > > > +       .dev_name = DEV_NAME,
> > >
> > > Much easier to see if any name collisions are happen by grepping
> > > similar struct definitions, but these macros are making life harder.
> >
> > Do you mean to avoid indirection caused by defines and write e.g.,
> > `.driver_name = "liteuart"`?
> >
> > OK, but the reason we have defines in the first place is because we
> > use the same name in many places and we want to avoid inconsistencies
> > (typos, partial rename, etc.).
> > What's more, looking at other serial drivers I see the notation is not
> > consistent - many of them use defines for name/major/minor as well.
>
> The problem here that .driver_name is a part of user visible
> interface, so, when you rename it it will affect the module alias.
> How DEV_NAME is shared? It should not be, otherwise it will collide
> with other drivers.

I meant that DRIVER_NAME define is used in the file in many places:
* liteuart_driver.driver_name
* liteuart_type()
* liteuart_platfrom_driver.driver.name
* liteuart_console.name
* MODULE_ALIAS
It's not shared with other drivers, but used multiple times in the
code of this one.

DEV_NAME/DRIVER_MAJOR/DRIVER_MINOR are indeed referenced only once so
it's no problem to write those values directly and get rid of their
defines.

> > > > +       .major = DRIVER_MAJOR,
> > > > +       .minor = DRIVER_MINOR,
> > >
> > > Ditto.
>
> Ditto.
>
> > > > +};
>
> ...

What do you mean by '...' ?

>
> > > > +static const char *liteuart_type(struct uart_port *port)
> > > > +{
> > > > +       return (port->type == PORT_LITEUART) ? DRIVER_NAME : NULL;
> > > > +}
> > >
> > > Do we need this check? Do we need a port type at all?
>
> > This is inspired by serial_core.c and other serial drivers.
> > We don't support any alternative `port->types` values so it's probably
> > not necessary for us, but it seems that this is how other serial
> > drivers are written too.
>
> Legacy drivers are not the best example to take. So, if you can
> survive without UART type, please go with it. Otherwise commit message
> should point out why it's needed so eagerly.
>
> ...

I guess we'll be good without the UART type.

> > > > +       /* look for aliases; auto-enumerate for free index if not found */
> > > > +       dev_id = of_alias_get_id(np, "serial");
> > > > +       if (dev_id < 0)
> > > > +               dev_id = find_first_zero_bit(liteuart_ports_in_use,
> > > > +                                            CONFIG_SERIAL_LITEUART_MAX_PORTS);
> > >
> > > Racy.
> >
> > We'll protect it with a mutex to avoid race conditions.
>
> Rather consider to use xArray API.
>
> ...

We'll check that up.

> > > > +               .of_match_table = of_match_ptr(liteuart_of_match),
> > >
> > > of_match_ptr() makes no sense (you have depends on OF).
> >
> > You mean that `of_match_ptr(X)` resolves simply to `X` when
> > `CONFIG_OF` is defined?
> > In this context it surely can be simplified.
>
> Yes.
>
> ...

OK.

> > > > +static int __init liteuart_console_init(void)
> > > > +{
>
> > > > +}
> > >
> > > > +
> > >
> > > Extra blank line.
> >
> > You mean we should remove an empty line between the definition of
> > liteuart_console_init() and the call to console_initcall()? It seems
> > to be inconsistent across different drivers, but sure - no problem.
>
> Less LOCs is good (but keep common sense applied).
>
> ...

Sure.

> > > > +/* LiteUART */
> > > > +#define PORT_LITEUART  123
> > >
> > > We have holes in the list, use them.
> > >
> > > And again why we need this?
> >
> > This is inspired by other serial drivers that also reserves
> > identifiers in this file and handles them the same way we do. We
> > simply followed the convention.
>
> See above. This ID is a part of UAPI which is kinda redundant nowadays.
> You need to provide a good argument for that. Otherwise, get rid of it.

We'll remove this and see if everything works fine.

> --
> With Best Regards,
> Andy Shevchenko

Thanks for the discussion!


--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
