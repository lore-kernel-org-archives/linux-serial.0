Return-Path: <SRS0=t3pX=6F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAFCC54FC9
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 08:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A8E2084D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 08:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="tSH83ct9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgDUI3t (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728324AbgDUI3r (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Apr 2020 04:29:47 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3699C061A41
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 01:29:46 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i16so7768093ils.12
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHq4yI7KJKiPi/JRkXnQ9jY3dBOOzSiKaVvaM4v+vwg=;
        b=tSH83ct91Gxcx0UTKFhSBY614BfEuUYaihtr01Utn1jE1hgDxS14/eNsXdeO/T3yVn
         8VXoP9phyAAV7uBu9zPUY8RUcmA5OdktwriFyUM04o86Erqsg3ZlWVc0BXRInZpVJ/xh
         SOxw7DheN0Bq9SvYCHodaWgJZ/fvUnwAfeZ5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHq4yI7KJKiPi/JRkXnQ9jY3dBOOzSiKaVvaM4v+vwg=;
        b=KOBqhDxXXfUEQILSAlDz7s75hsA7pDSteuAmsgLZBoiM1PjvjLAO0P/4C7/hYZZXLt
         DrkCyNa/XQSglVYnnZujRG9XIze/u/paARk1urIXHbAf9wLhNIJ+DZsqyuzRIsikmq88
         Hk9l62xipxKUrpfJM7pCAcMABbrPbI6pvti+SArd7Vgrpga/BXcm9FNaM1hzZsGKfJFo
         oZdCibC6Fwaa1USs1tCX9E4bcc2p1QsqqfUxYWpnKG1niYLmwWWxeSohqdeDnUMlThmh
         zkBPkgfJ9v0EVNlNEzWZAT7iRpm55b5UrwOG8DjpZ4mLKwLcLYDdsUVtNgctSPDaiOyf
         1HxA==
X-Gm-Message-State: AGi0PuYHsEonQBlYH1I4r1F9FWHNVe1TDiLwaGF0leMl4BBQ/mr1jzLB
        KeOlOgHdfMadM4Kcz/HQ0yLWYiX+p2AYj2iWCjgE4Q==
X-Google-Smtp-Source: APiQypJniLEs64MzSv6BnWptM1LdzyopJLyo4bs9EJ7nZYzIeWa3MurTAX1CxE+KfCum+PpvPbFWka3n86XDHJoaB4Y=
X-Received: by 2002:a92:2910:: with SMTP id l16mr17616761ilg.256.1587457785698;
 Tue, 21 Apr 2020 01:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200402084513.4173306-0-mholenko@antmicro.com>
 <20200402084513.4173306-3-mholenko@antmicro.com> <CAPk366QLHbR9cnLs244VbOXOLAg56yhG7O-DEAc1x1ZTvthiig@mail.gmail.com>
 <20200402074259.GC2755501@kroah.com> <CAPk366Qm62TtwM7xNUSUT4L+7MwWDSPXyGCWXrXHYPjLeVf9OA@mail.gmail.com>
 <20200416141832.GA1356374@kroah.com>
In-Reply-To: <20200416141832.GA1356374@kroah.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 21 Apr 2020 10:29:33 +0200
Message-ID: <CAPk366Rg8CVW=rvL_d9PiA0+uuD3bZoQ6Yqw0Rhndqtw0Ecrbg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] drivers/soc/litex: add LiteX SoC Controller driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
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
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 16, 2020 at 4:18 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 02, 2020 at 03:50:34PM +0200, Mateusz Holenko wrote:
> > On Thu, Apr 2, 2020 at 9:43 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Apr 02, 2020 at 08:50:40AM +0200, Mateusz Holenko wrote:
> > > > On Thu, Apr 2, 2020 at 8:46 AM Mateusz Holenko <mholenko@antmicro.com> wrote:
> > > > >
> > > > > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > > > >
> > > > > This commit adds driver for the FPGA-based LiteX SoC
> > > > > Controller from LiteX SoC builder.
> > > > >
> > > > > Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> > > > > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > > > > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > > > > ---
> > > > >
> > > > > Notes:
> > > > >     Changes in v4:
> > > > >     - fixed indent in Kconfig's help section
> > > > >     - fixed copyright header
> > > > >     - changed compatible to "litex,soc-controller"
> > > > >     - simplified litex_soc_ctrl_probe
> > > > >     - removed unnecessary litex_soc_ctrl_remove
> > > > >
> > > > >     This commit has been introduced in v3 of the patchset.
> > > > >
> > > > >     It includes a simplified version of common 'litex.h'
> > > > >     header introduced in v2 of the patchset.
> > > > >
> > > > >  MAINTAINERS                        |   2 +
> > > > >  drivers/soc/Kconfig                |   1 +
> > > > >  drivers/soc/Makefile               |   1 +
> > > > >  drivers/soc/litex/Kconfig          |  14 ++
> > > > >  drivers/soc/litex/Makefile         |   3 +
> > > > >  drivers/soc/litex/litex_soc_ctrl.c | 217 +++++++++++++++++++++++++++++
> > > > >  include/linux/litex.h              |  45 ++++++
> > > > >  7 files changed, 283 insertions(+)
> > > > >  create mode 100644 drivers/soc/litex/Kconfig
> > > > >  create mode 100644 drivers/soc/litex/Makefile
> > > > >  create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
> > > > >  create mode 100644 include/linux/litex.h
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 2f5ede8a08aa..a35be1be90d5 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -9729,6 +9729,8 @@ M:        Karol Gugala <kgugala@antmicro.com>
> > > > >  M:     Mateusz Holenko <mholenko@antmicro.com>
> > > > >  S:     Maintained
> > > > >  F:     Documentation/devicetree/bindings/*/litex,*.yaml
> > > > > +F:     drivers/soc/litex/litex_soc_ctrl.c
> > > > > +F:     include/linux/litex.h
> > > > >
> > > > >  LIVE PATCHING
> > > > >  M:     Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > > > > index 1778f8c62861..78add2a163be 100644
> > > > > --- a/drivers/soc/Kconfig
> > > > > +++ b/drivers/soc/Kconfig
> > > > > @@ -9,6 +9,7 @@ source "drivers/soc/bcm/Kconfig"
> > > > >  source "drivers/soc/fsl/Kconfig"
> > > > >  source "drivers/soc/imx/Kconfig"
> > > > >  source "drivers/soc/ixp4xx/Kconfig"
> > > > > +source "drivers/soc/litex/Kconfig"
> > > > >  source "drivers/soc/mediatek/Kconfig"
> > > > >  source "drivers/soc/qcom/Kconfig"
> > > > >  source "drivers/soc/renesas/Kconfig"
> > > > > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > > > > index 8b49d782a1ab..fd016b51cddd 100644
> > > > > --- a/drivers/soc/Makefile
> > > > > +++ b/drivers/soc/Makefile
> > > > > @@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_GEMINI)     += gemini/
> > > > >  obj-$(CONFIG_ARCH_MXC)         += imx/
> > > > >  obj-$(CONFIG_ARCH_IXP4XX)      += ixp4xx/
> > > > >  obj-$(CONFIG_SOC_XWAY)         += lantiq/
> > > > > +obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
> > > > >  obj-y                          += mediatek/
> > > > >  obj-y                          += amlogic/
> > > > >  obj-y                          += qcom/
> > > > > diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> > > > > new file mode 100644
> > > > > index 000000000000..71264c0e1d6c
> > > > > --- /dev/null
> > > > > +++ b/drivers/soc/litex/Kconfig
> > > > > @@ -0,0 +1,14 @@
> > > > > +# SPDX-License_Identifier: GPL-2.0
> > > > > +
> > > > > +menu "Enable LiteX SoC Builder specific drivers"
> > > > > +
> > > > > +config LITEX_SOC_CONTROLLER
> > > > > +       tristate "Enable LiteX SoC Controller driver"
> > > > > +       help
> > > > > +         This option enables the SoC Controller Driver which verifies
> > > > > +         LiteX CSR access and provides common litex_get_reg/litex_set_reg
> > > > > +         accessors.
> > > > > +         All drivers that use functions from litex.h must depend on
> > > > > +         LITEX_SOC_CONTROLLER.
> > > > > +
> > > > > +endmenu
> > > > > diff --git a/drivers/soc/litex/Makefile b/drivers/soc/litex/Makefile
> > > > > new file mode 100644
> > > > > index 000000000000..98ff7325b1c0
> > > > > --- /dev/null
> > > > > +++ b/drivers/soc/litex/Makefile
> > > > > @@ -0,0 +1,3 @@
> > > > > +# SPDX-License_Identifier: GPL-2.0
> > > > > +
> > > > > +obj-$(CONFIG_LITEX_SOC_CONTROLLER)     += litex_soc_ctrl.o
> > > > > diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> > > > > new file mode 100644
> > > > > index 000000000000..5defba000fd4
> > > > > --- /dev/null
> > > > > +++ b/drivers/soc/litex/litex_soc_ctrl.c
> > > > > @@ -0,0 +1,217 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * LiteX SoC Controller Driver
> > > > > + *
> > > > > + * Copyright (C) 2020 Antmicro <www.antmicro.com>
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#include <linux/litex.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/errno.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/of_platform.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/printk.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/errno.h>
> > > > > +#include <linux/io.h>
> > > > > +
> > > > > +/*
> > > > > + * The parameters below are true for LiteX SoC
> > > > > + * configured for 8-bit CSR Bus, 32-bit aligned.
> > > > > + *
> > > > > + * Supporting other configurations will require
> > > > > + * extending the logic in this header.
> > > > > + */
> > > > > +#define LITEX_REG_SIZE             0x4
> > > > > +#define LITEX_SUBREG_SIZE          0x1
> > > > > +#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
> > > > > +
> > > > > +static DEFINE_SPINLOCK(csr_lock);
> > > > > +
> > > > > +static inline unsigned long read_pointer_with_barrier(
> > > > > +       const volatile void __iomem *addr)
> > > > > +{
> > > > > +       unsigned long val;
> > > > > +
> > > > > +       __io_br();
> > > > > +       val = *(const volatile unsigned long __force *)addr;
> > > > > +       __io_ar();
> > > > > +       return val;
> > > > > +}
> > > > > +
> > > > > +static inline void write_pointer_with_barrier(
> > > > > +       volatile void __iomem *addr, unsigned long val)
> > > > > +{
> > > > > +       __io_br();
> > > > > +       *(volatile unsigned long __force *)addr = val;
> > > > > +       __io_ar();
> > > > > +}
> > > > > +
> > > >
> > > > I'm defining read_pointer_with_barrier/write_pointer_with_barrier in
> > > > order to make sure that a series of reads/writes to a single CSR
> > > > register will not be reordered by the compiler.
> > >
> > > Please do not do this, there are core kernel calls for this, otherwise
> > > this would be required by every individual driver, which would be crazy.
> > >
> > > > Does __raw_readl/__raw_writel guarantee this property? If so, I could
> > > > drop my functions and use the system ones instead.
> > >
> > > Try it and see.
> >
> > Since I want to avoid read/write reordering caused by the compiler
> > optimizations I don't want to rely on a single manual test.
> > What I mean is that even if it works now for me, it does not guarantee
> > that it will in the future version of the compiler/using different
> > compilation flags/etc, right?
>
> No, if the common functions stop working, then they will be fixed.  If
> you try to roll your own and they stop working in the future, no one
> will notice.

Sure, no doubts here. What I wanted to say though was that I want to
protect the code against compiler optimizations (code reordering) that
I might not be able to detect using just a one-time test. It has nothing to
do with bugs in common functions, only with the compiler itself (and again
it's not a bug).
The way optimizations are handled is dependent on the compiler
and the configuration and I'm manually testing just one of many possible
setups.

I also checked that there are explicit memory barriers used in the
code of readl(),
so I assume __raw_readl()/__raw_writel() does not guarantee ordering alone
(as otherwise __io_br() wouldn't be used in readl()).

> Please use the common in-kernel functions for this, it's not ok for
> drivers to try to do it themselves for basic things like this, no matter
> what platform they think they are designed for :)

The only reason I ended up with additional
read_pointer_with_barrier()/write_pointer_with_barrier() is because
I couldn't find an in-kernel function for this:
* ioread32()/readl() modifies endianness,
* __raw_readl() does not provide memory barriers.

I have no intention of duplicating the code just for the sake of
having my own copy
- I know more than well that this leads to problems only ;)

read_pointer_with_barrier()/write_pointer_with_barriers() are not
meant to be used
outside the litex_soc_ctrl.c file (that's why they are static) - they
are merely helper
functions for litex_get_reg()/litex_set_reg().
Since they are called only in one context I can just inline them -
litex_set_reg() will
call __raw_writel() surrounded by memory barriers directly. The same
for litex_get_reg().
Would it be less confusing?

An alternative I see is to call in-kernel ioread32()/ioread32be(), but
that would require ifdefing,
i.e., testing the value of __LITTLE_ENDIAN and calling ioread32() OR
ioread32be().
Do you see other options?

I'm fully open for suggestions.

> thanks,
>
> greg k-h

Thanks again for your time and the comments!

Best,
Mateusz

--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
