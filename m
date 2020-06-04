Return-Path: <SRS0=SSon=7R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5A5C433E2
	for <linux-serial@archiver.kernel.org>; Thu,  4 Jun 2020 08:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E9B205CB
	for <linux-serial@archiver.kernel.org>; Thu,  4 Jun 2020 08:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="K6ZtQpeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgFDIZq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgFDIZq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Jun 2020 04:25:46 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE26C05BD1E
        for <linux-serial@vger.kernel.org>; Thu,  4 Jun 2020 01:25:45 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id l6so5268872ilo.2
        for <linux-serial@vger.kernel.org>; Thu, 04 Jun 2020 01:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pYTZrpSKlWCZUeqd3ax0K9GSnrfHbHtF3YVJtTd8P+o=;
        b=K6ZtQpeA/zQnn8J3gX+PNc1yI1bFeCE+1P458t4Ym1FDFiUe+2EPOQO6wVFD3IqJ13
         rpydnvh5hcCjSNneskf4+dUoIHd66wJmJuwLLl2BUGqfmB2HRxhlIo6JiY2gO9bqjwSW
         F804EhlS9vEMkkZ4I88yB61a8drL/w5ihSeME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pYTZrpSKlWCZUeqd3ax0K9GSnrfHbHtF3YVJtTd8P+o=;
        b=hytMYuaS+itye14e6+LoKG941RUQSPRkU9yrEkmcLcwYtLE4kA/6XbtVmq2fDdRoZ7
         TF/Y4skvALicQikdgzq23uBR7uHPxIqQENaVG5+MjV0koL7ZA4Us6pSoJvookqn62eIa
         b0/e2lf3Ko6cTha3wt/XACxiwjFNcbwg4NYjovm6pA/bRJWGtnIhYla5CFww0J2nVQ6i
         3y9UKsAaezvehnHgj2D9i9enKxb3CPFfDq4gw9CAemzykbqZ147SPOSdRoOeyLn8Yc6n
         v95Vw1zZ8Gma0JEcK/nkrl8AsFFU0HY1E2zxieQ84dO91coVDlKrBiUmNwcsNUDsUkO5
         XkWQ==
X-Gm-Message-State: AOAM531OGmBOe3wrh3tVsvnJYfpQN+fPtkooHe1EYepGGJciQMm+cOeI
        1YJwLmfOmwXUfb6ehu9p4ZeqUDpRuoTKTuNMKC/N/g==
X-Google-Smtp-Source: ABdhPJy0GM4pMzZ+MACjE8TaKCx8RxW5rMNL2jOetcGVz6m34HluiBrK++u4C5BQy9VmWVJWYvkuJzEJgQ8DT/2NQio=
X-Received: by 2002:a92:280b:: with SMTP id l11mr2866348ilf.179.1591259144636;
 Thu, 04 Jun 2020 01:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200527182545.3859622-0-mholenko@antmicro.com>
 <20200527182545.3859622-5-mholenko@antmicro.com> <CAPk366TMTGR7cchQa9YYWviQ04-Xko4D8mG+mywyThGVMQ+3dQ@mail.gmail.com>
 <20200604075716.GA358281@kroah.com>
In-Reply-To: <20200604075716.GA358281@kroah.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Thu, 4 Jun 2020 10:25:34 +0200
Message-ID: <CAPk366Tjp156Rtz6YFoQGxp=-s=Q_b3sLj+khqooEBFN0Yo5Aw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] drivers/tty/serial: add LiteUART driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jun 4, 2020 at 9:57 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 04, 2020 at 09:16:25AM +0200, Mateusz Holenko wrote:
> > On Wed, May 27, 2020 at 6:27 PM Mateusz Holenko <mholenko@antmicro.com>=
 wrote:
> > >
> > > From: Filip Kokosinski <fkokosinski@antmicro.com>
> > >
> > > This commit adds driver for the FPGA-based LiteUART serial controller
> > > from LiteX SoC builder.
> > >
> > > The current implementation supports LiteUART configured
> > > for 32 bit data width and 8 bit CSR bus width.
> > >
> > > It does not support IRQ.
> > >
> > > Signed-off-by: Filip Kokosinski <fkokosinski@antmicro.com>
> > > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > > ---
> > >
> > > Notes:
> > >     Changes in v6:
> > >     - LiteUART ports now stored in xArray
> > >     - removed PORT_LITEUART
> > >     - fixed formatting
> > >     - removed some unnecessary defines
> > >
> > >     No changes in v5.
> > >
> > >     Changes in v4:
> > >     - fixed copyright header
> > >     - removed a wrong dependency on UARTLITE from Kconfig
> > >     - added a dependency on LITEX_SOC_CONTROLLER to LITEUART in Kconf=
ig
> > >
> > >     Changes in v3:
> > >     - aliases made optional
> > >     - used litex_get_reg/litex_set_reg functions instead of macros
> > >     - SERIAL_LITEUART_NR_PORTS renamed to SERIAL_LITEUART_MAX_PORTS
> > >     - PORT_LITEUART changed from 122 to 123
> > >     - added dependency on LITEX_SOC_CONTROLLER
> > >     - patch number changed from 4 to 5
> > >
> > >     No changes in v2.
> > >
> > >  MAINTAINERS                   |   1 +
> > >  drivers/tty/serial/Kconfig    |  31 +++
> > >  drivers/tty/serial/Makefile   |   1 +
> > >  drivers/tty/serial/liteuart.c | 404 ++++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 437 insertions(+)
> > >  create mode 100644 drivers/tty/serial/liteuart.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 51d2d6a61fb0..d855fe807833 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9846,6 +9846,7 @@ M:        Mateusz Holenko <mholenko@antmicro.co=
m>
> > >  S:     Maintained
> > >  F:     Documentation/devicetree/bindings/*/litex,*.yaml
> > >  F:     drivers/soc/litex/litex_soc_ctrl.c
> > > +F:     drivers/tty/serial/liteuart.c
> > >  F:     include/linux/litex.h
> > >
> > >  LIVE PATCHING
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index adf9e80e7dc9..17aaf0afb27a 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -1562,6 +1562,37 @@ config SERIAL_MILBEAUT_USIO_CONSOLE
> > >           receives all kernel messages and warnings and which allows =
logins in
> > >           single user mode).
> > >
> > > +config SERIAL_LITEUART
> > > +       tristate "LiteUART serial port support"
> > > +       depends on HAS_IOMEM
> > > +       depends on OF || COMPILE_TEST
> > > +       depends on LITEX_SOC_CONTROLLER
> > > +       select SERIAL_CORE
> > > +       help
> > > +         This driver is for the FPGA-based LiteUART serial controlle=
r from LiteX
> > > +         SoC builder.
> > > +
> > > +         Say 'Y' here if you wish to use the LiteUART serial control=
ler.
> > > +         Otherwise, say 'N'.
> > > +
> > > +config SERIAL_LITEUART_MAX_PORTS
> > > +       int "Maximum number of LiteUART ports"
> > > +       depends on SERIAL_LITEUART
> > > +       default "1"
> > > +       help
> > > +         Set this to the maximum number of serial ports you want the=
 driver
> > > +         to support.
> > > +
> > > +config SERIAL_LITEUART_CONSOLE
> > > +       bool "LiteUART serial port console support"
> > > +       depends on SERIAL_LITEUART=3Dy
> > > +       select SERIAL_CORE_CONSOLE
> > > +       help
> > > +         Say 'Y' here if you wish to use the FPGA-based LiteUART ser=
ial controller
> > > +         from LiteX SoC builder as the system console (the system co=
nsole is the
> > > +         device which receives all kernel messages and warnings and =
which allows
> > > +         logins in single user mode). Otherwise, say 'N'.
> > > +
> > >  endmenu
> > >
> > >  config SERIAL_MCTRL_GPIO
> > > diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefil=
e
> > > index d056ee6cca33..9f8ba419ff3b 100644
> > > --- a/drivers/tty/serial/Makefile
> > > +++ b/drivers/tty/serial/Makefile
> > > @@ -89,6 +89,7 @@ obj-$(CONFIG_SERIAL_OWL)      +=3D owl-uart.o
> > >  obj-$(CONFIG_SERIAL_RDA)       +=3D rda-uart.o
> > >  obj-$(CONFIG_SERIAL_MILBEAUT_USIO) +=3D milbeaut_usio.o
> > >  obj-$(CONFIG_SERIAL_SIFIVE)    +=3D sifive.o
> > > +obj-$(CONFIG_SERIAL_LITEUART) +=3D liteuart.o
> > >
> > >  # GPIOLIB helpers for modem control lines
> > >  obj-$(CONFIG_SERIAL_MCTRL_GPIO)        +=3D serial_mctrl_gpio.o
> > > diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteu=
art.c
> > > new file mode 100644
> > > index 000000000000..22b7612c13ca
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/liteuart.c
> > > @@ -0,0 +1,404 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * LiteUART serial controller (LiteX) Driver
> > > + *
> > > + * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
> > > + */
> > > +
> > > +#include <linux/console.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/serial.h>
> > > +#include <linux/serial_core.h>
> > > +#include <linux/timer.h>
> > > +#include <linux/tty_flip.h>
> > > +#include <linux/litex.h>
> > > +#include <linux/xarray.h>
> >
> > kbuild test robot reported problems with this patch, namely: implicit
> > declaration of function 'kzalloc'
> > This is caused by the missing include directive. When I was testing it
> > I must have missed the warning, but the compilation succeeded and the
> > resulting binary worked fine on HW (LiteX/mor1kx platform).
> > The fix is a simple one-liner, adding a new include:
> >
> > +#include <linux/slab.h>
> >
> > Since this is a very small fix and does not modify the actual code of
> > the driver I want to wait for more feedback on all patches in the
> > series before resubmitting, in order to limit traffic on the list.
> > Or should I generate the next version and resend the whole patchset
> > with this single fix, as otherwise it won't be reviewed at all?
>
> Please fix up and resend.  We can't do anything until after 5.8-rc1 is
> out anyway...
>
> thanks,
>
> greg k-h

Sure, thanks for the prompt response!

Best,
Mateusz Ho=C5=82enko


--=20
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
