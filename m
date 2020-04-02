Return-Path: <SRS0=sjTb=5S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A4BC43331
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 07:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7CF208E4
	for <linux-serial@archiver.kernel.org>; Thu,  2 Apr 2020 07:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585813385;
	bh=bpiHU8A0oDRpgD0tmxFxrO99WqdpU6KRQOYxoldTLEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MyN1x2fCmIyNpQjAkRHEvlbFlS/HzWsKAzchNnPn3F/4bkj5DHXI0Z02YWlmeJ2hd
	 50Mwyt7RRXSINdhuuJreL7mQhrrLlFYPhog9AgSxY2oz51VAG6tzpA8AY44ebfDgtF
	 TC4qaogY4e0yll/1A8aSaiTNvIuQtiELmAe4Z3HU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgDBHnE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgDBHnE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Apr 2020 03:43:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3E720678;
        Thu,  2 Apr 2020 07:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585813382;
        bh=bpiHU8A0oDRpgD0tmxFxrO99WqdpU6KRQOYxoldTLEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2xnXA4c0EcNCIPyRwMbzkTF3nO830kNGtiIiKTQSdXIyITEyR6FFydvjD3dkcetm
         MEqjVOI2/3Xrch+EKiO3UaUWGmdSXmnj8qtRuH4GNBTPWQZ1o/JFc+Lu54yepJ/yKx
         WROB7+wewfkcy/JmtFVpQmeVOnwWDOkuiitaxE0M=
Date:   Thu, 2 Apr 2020 09:42:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mateusz Holenko <mholenko@antmicro.com>
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
Subject: Re: [PATCH v4 3/5] drivers/soc/litex: add LiteX SoC Controller driver
Message-ID: <20200402074259.GC2755501@kroah.com>
References: <20200402084513.4173306-0-mholenko@antmicro.com>
 <20200402084513.4173306-3-mholenko@antmicro.com>
 <CAPk366QLHbR9cnLs244VbOXOLAg56yhG7O-DEAc1x1ZTvthiig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPk366QLHbR9cnLs244VbOXOLAg56yhG7O-DEAc1x1ZTvthiig@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 02, 2020 at 08:50:40AM +0200, Mateusz Holenko wrote:
> On Thu, Apr 2, 2020 at 8:46 AM Mateusz Holenko <mholenko@antmicro.com> wrote:
> >
> > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> >
> > This commit adds driver for the FPGA-based LiteX SoC
> > Controller from LiteX SoC builder.
> >
> > Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> > ---
> >
> > Notes:
> >     Changes in v4:
> >     - fixed indent in Kconfig's help section
> >     - fixed copyright header
> >     - changed compatible to "litex,soc-controller"
> >     - simplified litex_soc_ctrl_probe
> >     - removed unnecessary litex_soc_ctrl_remove
> >
> >     This commit has been introduced in v3 of the patchset.
> >
> >     It includes a simplified version of common 'litex.h'
> >     header introduced in v2 of the patchset.
> >
> >  MAINTAINERS                        |   2 +
> >  drivers/soc/Kconfig                |   1 +
> >  drivers/soc/Makefile               |   1 +
> >  drivers/soc/litex/Kconfig          |  14 ++
> >  drivers/soc/litex/Makefile         |   3 +
> >  drivers/soc/litex/litex_soc_ctrl.c | 217 +++++++++++++++++++++++++++++
> >  include/linux/litex.h              |  45 ++++++
> >  7 files changed, 283 insertions(+)
> >  create mode 100644 drivers/soc/litex/Kconfig
> >  create mode 100644 drivers/soc/litex/Makefile
> >  create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
> >  create mode 100644 include/linux/litex.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2f5ede8a08aa..a35be1be90d5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9729,6 +9729,8 @@ M:        Karol Gugala <kgugala@antmicro.com>
> >  M:     Mateusz Holenko <mholenko@antmicro.com>
> >  S:     Maintained
> >  F:     Documentation/devicetree/bindings/*/litex,*.yaml
> > +F:     drivers/soc/litex/litex_soc_ctrl.c
> > +F:     include/linux/litex.h
> >
> >  LIVE PATCHING
> >  M:     Josh Poimboeuf <jpoimboe@redhat.com>
> > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > index 1778f8c62861..78add2a163be 100644
> > --- a/drivers/soc/Kconfig
> > +++ b/drivers/soc/Kconfig
> > @@ -9,6 +9,7 @@ source "drivers/soc/bcm/Kconfig"
> >  source "drivers/soc/fsl/Kconfig"
> >  source "drivers/soc/imx/Kconfig"
> >  source "drivers/soc/ixp4xx/Kconfig"
> > +source "drivers/soc/litex/Kconfig"
> >  source "drivers/soc/mediatek/Kconfig"
> >  source "drivers/soc/qcom/Kconfig"
> >  source "drivers/soc/renesas/Kconfig"
> > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > index 8b49d782a1ab..fd016b51cddd 100644
> > --- a/drivers/soc/Makefile
> > +++ b/drivers/soc/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_GEMINI)     += gemini/
> >  obj-$(CONFIG_ARCH_MXC)         += imx/
> >  obj-$(CONFIG_ARCH_IXP4XX)      += ixp4xx/
> >  obj-$(CONFIG_SOC_XWAY)         += lantiq/
> > +obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
> >  obj-y                          += mediatek/
> >  obj-y                          += amlogic/
> >  obj-y                          += qcom/
> > diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> > new file mode 100644
> > index 000000000000..71264c0e1d6c
> > --- /dev/null
> > +++ b/drivers/soc/litex/Kconfig
> > @@ -0,0 +1,14 @@
> > +# SPDX-License_Identifier: GPL-2.0
> > +
> > +menu "Enable LiteX SoC Builder specific drivers"
> > +
> > +config LITEX_SOC_CONTROLLER
> > +       tristate "Enable LiteX SoC Controller driver"
> > +       help
> > +         This option enables the SoC Controller Driver which verifies
> > +         LiteX CSR access and provides common litex_get_reg/litex_set_reg
> > +         accessors.
> > +         All drivers that use functions from litex.h must depend on
> > +         LITEX_SOC_CONTROLLER.
> > +
> > +endmenu
> > diff --git a/drivers/soc/litex/Makefile b/drivers/soc/litex/Makefile
> > new file mode 100644
> > index 000000000000..98ff7325b1c0
> > --- /dev/null
> > +++ b/drivers/soc/litex/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License_Identifier: GPL-2.0
> > +
> > +obj-$(CONFIG_LITEX_SOC_CONTROLLER)     += litex_soc_ctrl.o
> > diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> > new file mode 100644
> > index 000000000000..5defba000fd4
> > --- /dev/null
> > +++ b/drivers/soc/litex/litex_soc_ctrl.c
> > @@ -0,0 +1,217 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * LiteX SoC Controller Driver
> > + *
> > + * Copyright (C) 2020 Antmicro <www.antmicro.com>
> > + *
> > + */
> > +
> > +#include <linux/litex.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/printk.h>
> > +#include <linux/module.h>
> > +#include <linux/errno.h>
> > +#include <linux/io.h>
> > +
> > +/*
> > + * The parameters below are true for LiteX SoC
> > + * configured for 8-bit CSR Bus, 32-bit aligned.
> > + *
> > + * Supporting other configurations will require
> > + * extending the logic in this header.
> > + */
> > +#define LITEX_REG_SIZE             0x4
> > +#define LITEX_SUBREG_SIZE          0x1
> > +#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
> > +
> > +static DEFINE_SPINLOCK(csr_lock);
> > +
> > +static inline unsigned long read_pointer_with_barrier(
> > +       const volatile void __iomem *addr)
> > +{
> > +       unsigned long val;
> > +
> > +       __io_br();
> > +       val = *(const volatile unsigned long __force *)addr;
> > +       __io_ar();
> > +       return val;
> > +}
> > +
> > +static inline void write_pointer_with_barrier(
> > +       volatile void __iomem *addr, unsigned long val)
> > +{
> > +       __io_br();
> > +       *(volatile unsigned long __force *)addr = val;
> > +       __io_ar();
> > +}
> > +
> 
> I'm defining read_pointer_with_barrier/write_pointer_with_barrier in
> order to make sure that a series of reads/writes to a single CSR
> register will not be reordered by the compiler.

Please do not do this, there are core kernel calls for this, otherwise
this would be required by every individual driver, which would be crazy.

> Does __raw_readl/__raw_writel guarantee this property? If so, I could
> drop my functions and use the system ones instead.

Try it and see.  What's wrong with the normal iomem read/write
functions?

Also, just writing to a pointer like you did above is not how to do
this, please use the normal function calls, that way your driver will
work properly.

thanks,

greg k-h
