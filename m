Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A981EC43331
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 13:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFDA2073B
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 13:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="TOQs9DQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgDBNus (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:50:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46473 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732430AbgDBNur (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 09:50:47 -0400
Received: by mail-io1-f65.google.com with SMTP id i3so3582107ioo.13
        for <linux-serial@vger.kernel.org>; Thu, 02 Apr 2020 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cBz5hkl7c5dEMdKpbLhwnxrBoxqXmCZ2qRoqWIGfXw=;
        b=TOQs9DQcOzYglDoqsyjwITIxSkxfp6B83nGMgBfxD1hUaj5GEO9NFmDV3G78Pj8d1Y
         PQvWnY7xMqBEQN9ZGWPrU8byIsMO9aaeFQKTep/CSQeZtnwX3EQmPxK5dw/dYvAhf0Ew
         4zTOelzvZtbyDdbbkkjaaL6Pwe/Am/DKJRnfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cBz5hkl7c5dEMdKpbLhwnxrBoxqXmCZ2qRoqWIGfXw=;
        b=ONFz464A5T9YepUS9PvHpwrgqm8QNH8T19SQPBdAwTduYHYyxQWXm7waWyYbBSvtU0
         kky0NsqfpAbOGXkELbjUPqvAmT2WimC9q6RvKJYt2IKv/f5Yk4TNbBeYVGjj+QHdVW3z
         8493CawwMuuG5PF00obZUtyPAYw8Lx6+M+VduMn/mwKclskM7Owxe+FNNk4AcfQtb0D8
         oHTSEOduiHcY1sz9361BrS0cMsSSDNsSA58//4FLjS7xPZmBzKoaKQguQVtaLmVoJwOs
         msAe739oOOIDiO9t2X/EbS8uiHgiy/oaEmuemnGJTFdlvkXYQODVXunFh2j8vLbi6Eri
         G5yA==
X-Gm-Message-State: AGi0PubXls+StM2grxODZ3AQecup2s9gUizeyvErfMp+z13ft55kpt1S
        veFHihnMHnYb5is7S0x7XUMquFkYPw1laa+lr9Pf9Q==
X-Google-Smtp-Source: APiQypLm9tJETNNKcGiWxK9FwSJGhdgVWdVf/91kroGdAcGjcoTAzBg3pzj9QNRzPYgRZAVp/4hE5voCGiqqSEoVzyI=
X-Received: by 2002:a02:5ec7:: with SMTP id h190mr3466434jab.47.1585835445695;
 Thu, 02 Apr 2020 06:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200402084513.4173306-0-mholenko@antmicro.com>
 <20200402084513.4173306-3-mholenko@antmicro.com> <CAPk366QLHbR9cnLs244VbOXOLAg56yhG7O-DEAc1x1ZTvthiig@mail.gmail.com>
 <20200402074259.GC2755501@kroah.com>
In-Reply-To: <20200402074259.GC2755501@kroah.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Thu, 2 Apr 2020 15:50:34 +0200
Message-ID: <CAPk366Qm62TtwM7xNUSUT4L+7MwWDSPXyGCWXrXHYPjLeVf9OA@mail.gmail.com>
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

On Thu, Apr 2, 2020 at 9:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 02, 2020 at 08:50:40AM +0200, Mateusz Holenko wrote:
> > On Thu, Apr 2, 2020 at 8:46 AM Mateusz Holenko <mholenko@antmicro.com> wrote:
> > >
> > > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > >
> > > This commit adds driver for the FPGA-based LiteX SoC
> > > Controller from LiteX SoC builder.
> > >
> > > Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> > > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > > ---
> > >
> > > Notes:
> > >     Changes in v4:
> > >     - fixed indent in Kconfig's help section
> > >     - fixed copyright header
> > >     - changed compatible to "litex,soc-controller"
> > >     - simplified litex_soc_ctrl_probe
> > >     - removed unnecessary litex_soc_ctrl_remove
> > >
> > >     This commit has been introduced in v3 of the patchset.
> > >
> > >     It includes a simplified version of common 'litex.h'
> > >     header introduced in v2 of the patchset.
> > >
> > >  MAINTAINERS                        |   2 +
> > >  drivers/soc/Kconfig                |   1 +
> > >  drivers/soc/Makefile               |   1 +
> > >  drivers/soc/litex/Kconfig          |  14 ++
> > >  drivers/soc/litex/Makefile         |   3 +
> > >  drivers/soc/litex/litex_soc_ctrl.c | 217 +++++++++++++++++++++++++++++
> > >  include/linux/litex.h              |  45 ++++++
> > >  7 files changed, 283 insertions(+)
> > >  create mode 100644 drivers/soc/litex/Kconfig
> > >  create mode 100644 drivers/soc/litex/Makefile
> > >  create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
> > >  create mode 100644 include/linux/litex.h
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 2f5ede8a08aa..a35be1be90d5 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9729,6 +9729,8 @@ M:        Karol Gugala <kgugala@antmicro.com>
> > >  M:     Mateusz Holenko <mholenko@antmicro.com>
> > >  S:     Maintained
> > >  F:     Documentation/devicetree/bindings/*/litex,*.yaml
> > > +F:     drivers/soc/litex/litex_soc_ctrl.c
> > > +F:     include/linux/litex.h
> > >
> > >  LIVE PATCHING
> > >  M:     Josh Poimboeuf <jpoimboe@redhat.com>
> > > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > > index 1778f8c62861..78add2a163be 100644
> > > --- a/drivers/soc/Kconfig
> > > +++ b/drivers/soc/Kconfig
> > > @@ -9,6 +9,7 @@ source "drivers/soc/bcm/Kconfig"
> > >  source "drivers/soc/fsl/Kconfig"
> > >  source "drivers/soc/imx/Kconfig"
> > >  source "drivers/soc/ixp4xx/Kconfig"
> > > +source "drivers/soc/litex/Kconfig"
> > >  source "drivers/soc/mediatek/Kconfig"
> > >  source "drivers/soc/qcom/Kconfig"
> > >  source "drivers/soc/renesas/Kconfig"
> > > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > > index 8b49d782a1ab..fd016b51cddd 100644
> > > --- a/drivers/soc/Makefile
> > > +++ b/drivers/soc/Makefile
> > > @@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_GEMINI)     += gemini/
> > >  obj-$(CONFIG_ARCH_MXC)         += imx/
> > >  obj-$(CONFIG_ARCH_IXP4XX)      += ixp4xx/
> > >  obj-$(CONFIG_SOC_XWAY)         += lantiq/
> > > +obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
> > >  obj-y                          += mediatek/
> > >  obj-y                          += amlogic/
> > >  obj-y                          += qcom/
> > > diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> > > new file mode 100644
> > > index 000000000000..71264c0e1d6c
> > > --- /dev/null
> > > +++ b/drivers/soc/litex/Kconfig
> > > @@ -0,0 +1,14 @@
> > > +# SPDX-License_Identifier: GPL-2.0
> > > +
> > > +menu "Enable LiteX SoC Builder specific drivers"
> > > +
> > > +config LITEX_SOC_CONTROLLER
> > > +       tristate "Enable LiteX SoC Controller driver"
> > > +       help
> > > +         This option enables the SoC Controller Driver which verifies
> > > +         LiteX CSR access and provides common litex_get_reg/litex_set_reg
> > > +         accessors.
> > > +         All drivers that use functions from litex.h must depend on
> > > +         LITEX_SOC_CONTROLLER.
> > > +
> > > +endmenu
> > > diff --git a/drivers/soc/litex/Makefile b/drivers/soc/litex/Makefile
> > > new file mode 100644
> > > index 000000000000..98ff7325b1c0
> > > --- /dev/null
> > > +++ b/drivers/soc/litex/Makefile
> > > @@ -0,0 +1,3 @@
> > > +# SPDX-License_Identifier: GPL-2.0
> > > +
> > > +obj-$(CONFIG_LITEX_SOC_CONTROLLER)     += litex_soc_ctrl.o
> > > diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> > > new file mode 100644
> > > index 000000000000..5defba000fd4
> > > --- /dev/null
> > > +++ b/drivers/soc/litex/litex_soc_ctrl.c
> > > @@ -0,0 +1,217 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * LiteX SoC Controller Driver
> > > + *
> > > + * Copyright (C) 2020 Antmicro <www.antmicro.com>
> > > + *
> > > + */
> > > +
> > > +#include <linux/litex.h>
> > > +#include <linux/device.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/printk.h>
> > > +#include <linux/module.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/io.h>
> > > +
> > > +/*
> > > + * The parameters below are true for LiteX SoC
> > > + * configured for 8-bit CSR Bus, 32-bit aligned.
> > > + *
> > > + * Supporting other configurations will require
> > > + * extending the logic in this header.
> > > + */
> > > +#define LITEX_REG_SIZE             0x4
> > > +#define LITEX_SUBREG_SIZE          0x1
> > > +#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
> > > +
> > > +static DEFINE_SPINLOCK(csr_lock);
> > > +
> > > +static inline unsigned long read_pointer_with_barrier(
> > > +       const volatile void __iomem *addr)
> > > +{
> > > +       unsigned long val;
> > > +
> > > +       __io_br();
> > > +       val = *(const volatile unsigned long __force *)addr;
> > > +       __io_ar();
> > > +       return val;
> > > +}
> > > +
> > > +static inline void write_pointer_with_barrier(
> > > +       volatile void __iomem *addr, unsigned long val)
> > > +{
> > > +       __io_br();
> > > +       *(volatile unsigned long __force *)addr = val;
> > > +       __io_ar();
> > > +}
> > > +
> >
> > I'm defining read_pointer_with_barrier/write_pointer_with_barrier in
> > order to make sure that a series of reads/writes to a single CSR
> > register will not be reordered by the compiler.
>
> Please do not do this, there are core kernel calls for this, otherwise
> this would be required by every individual driver, which would be crazy.
>
> > Does __raw_readl/__raw_writel guarantee this property? If so, I could
> > drop my functions and use the system ones instead.
>
> Try it and see.

Since I want to avoid read/write reordering caused by the compiler
optimizations I don't want to rely on a single manual test.
What I mean is that even if it works now for me, it does not guarantee
that it will in the future version of the compiler/using different
compilation flags/etc, right?

> What's wrong with the normal iomem read/write
> functions?

What I want to achieve here is to access the register in the CPU
"native" endianness and make sure that the value I see there is the
same as a predefined pattern.

LiteX is a soft SoC generator - it generates the logic of the whole
SoC (CPU+peripherals) in a form that can be later synthesized and
loaded onto the FPGA/turned into an ASIC/etc. Since it generates the
system as a whole, it gives guarantees on how those elements are
interconnected. It can generate CPUs of different architectures (some
of them being little-, other big-endiann) and I want to have a single
driver to target them all.

In this driver I just want to verify that the interconnection between
CPU and the peripheral is ok - I don't want to adjust dynamically
(i.e., translate endianness in case a mismatch is detected). If what I
see in the register is not what I expect it means that there is
something wrong in the design and the generator should be fixed.

I'm not using ioread32/iowrite32 functions as they reorder bytes
depending on the CPU endianness so the returned value might not
reflect the order of bytes read directly from the peripheral. I could
use ifdefs checking the value of __LITTLE_ENDIAN (and that's in fact
was what we started with), but
(a) it was discouraged in the previous round of the review,
(b) it requires more code - checking __LITTLE_ENDIAN and using
ioread32/ioread32be accordingly.

That's why I ended up with raw pointer access.

>
> Also, just writing to a pointer like you did above is not how to do
> this, please use the normal function calls, that way your driver will
> work properly.

Instead of accessing pointer directly I could call __raw_readl/__raw_writel
- is that what you mean?

>
> thanks,
>
> greg k-h

Thank you very much for the comments!

-- 
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
