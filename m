Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B8C18E5B
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 09:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2EE20719
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="ZaaXhi6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgCQJpI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:45:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33779 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgCQJpG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 05:45:06 -0400
Received: by mail-io1-f67.google.com with SMTP id o127so7797765iof.0
        for <linux-serial@vger.kernel.org>; Tue, 17 Mar 2020 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPG4tiucRhyy9eM2j5MJougb058vrTu50sOAlBuGuHo=;
        b=ZaaXhi6g5f+YEkZ/eG7Urb046TacNHptAUUsqXBCCK++8vK/F+i1UJiQZDmy8SeN36
         DuuI3FZMBLKpi5Nyzbm4UqhDc9415GT0ZVTRpxY8qQCrKx2/Nku9um0Hu8HywylHIZqZ
         iQ9ulYLlmYCguFYKqBlF8aGQ5bhgEHI40+oLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPG4tiucRhyy9eM2j5MJougb058vrTu50sOAlBuGuHo=;
        b=CxxNZbM/RxM0POmaQDNMOuoxHMa6/hATu0BMjRV6f9JVG+QtB80jkhfhM3pEAzAXad
         htbqz/nPQlODX9owX9XtM9eMvYCamsi1mtG/reiLB8lYA6nSirn3S8Vl+7F3xOohRvAC
         6SLBNAATLrm/Qxoiw15ixLR42LYw6iIhgKbA4RKu0vHgVxbjVltVN1WoCzFHg+/0cki/
         Do0m4rbBlaSgv6nL0JZ5hn0CbCkeNkBByNgYn8T2vwyoJ2BYhq3bYQq+u4FCcOlBmimb
         NGbl/43T0ju0DeuxgY9HBy8+FUaUdYK4/n/5FgMi8lbNXtz8ZOzJPsOHCUziowbi6AkV
         r69w==
X-Gm-Message-State: ANhLgQ20BmrEWxSS6gDsrF/wZQDYAje7kjGBIPrbnGftVNRhYLwWxdn8
        6fXsfIueYoxMZeWAKg77LlZ0cjJwJCESC6AxoP1N1k8xfq6Ecg==
X-Google-Smtp-Source: ADFU+vvtbE29PjK8YFA+C/bJM9jPH+mgxivDBrXH1B0o1h0WqgrgtyBz9VmfaK+70f82VY1bcyGLcor9R+CEVrhW52o=
X-Received: by 2002:a02:1d44:: with SMTP id 65mr4457563jaj.6.1584438302600;
 Tue, 17 Mar 2020 02:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200225094437.4170502-0-mholenko@antmicro.com>
 <20200225094437.4170502-3-mholenko@antmicro.com> <20200225092551.6htlplwf23qbgm3n@gilmour.lan>
In-Reply-To: <20200225092551.6htlplwf23qbgm3n@gilmour.lan>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 17 Mar 2020 10:44:51 +0100
Message-ID: <CAPk366Sxjfa0gqh2kzbTC7C-t=s36dHiGjVK0Zjs7jTJsQcQ+A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drivers/soc/litex: add LiteX SoC Controller driver
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Hi Maxime,

On Tue, Feb 25, 2020 at 10:25 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Tue, Feb 25, 2020 at 09:46:57AM +0100, Mateusz Holenko wrote:
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
> >  drivers/soc/litex/litex_soc_ctrl.c | 233 +++++++++++++++++++++++++++++
> >  include/linux/litex.h              |  45 ++++++
> >  7 files changed, 299 insertions(+)
> >  create mode 100644 drivers/soc/litex/Kconfig
> >  create mode 100644 drivers/soc/litex/Makefile
> >  create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
> >  create mode 100644 include/linux/litex.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ec925c081dd2..22a67514ace3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9730,6 +9730,8 @@ M:      Karol Gugala <kgugala@antmicro.com>
> >  M:   Mateusz Holenko <mholenko@antmicro.com>
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/*/litex,*.yaml
> > +F:   drivers/soc/litex/litex_soc_ctrl.c
> > +F:   include/linux/litex.h
> >
> >  LIVE PATCHING
> >  M:   Josh Poimboeuf <jpoimboe@redhat.com>
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
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_GEMINI)   += gemini/
> >  obj-$(CONFIG_ARCH_MXC)               += imx/
> >  obj-$(CONFIG_ARCH_IXP4XX)    += ixp4xx/
> >  obj-$(CONFIG_SOC_XWAY)               += lantiq/
> > +obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
> >  obj-y                                += mediatek/
> >  obj-y                                += amlogic/
> >  obj-y                                += qcom/
> > diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> > new file mode 100644
> > index 000000000000..22c78cda0b83
> > --- /dev/null
> > +++ b/drivers/soc/litex/Kconfig
> > @@ -0,0 +1,14 @@
> > +# SPDX-License_Identifier: GPL-2.0
> > +
> > +menu "Enable LiteX SoC Builder specific drivers"
> > +
> > +config LITEX_SOC_CONTROLLER
> > +     tristate "Enable LiteX SoC Controller driver"
> > +     help
> > +     This option enables the SoC Controller Driver which verifies
> > +     LiteX CSR access and provides common litex_get_reg/litex_set_reg
> > +     accessors.
> > +     All drivers that use functions from litex.h must depend on
> > +     LITEX_SOC_CONTROLLER
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
> > +obj-$(CONFIG_LITEX_SOC_CONTROLLER)   += litex_soc_ctrl.o
> > diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> > new file mode 100644
> > index 000000000000..b810782da3a5
> > --- /dev/null
> > +++ b/drivers/soc/litex/litex_soc_ctrl.c
> > @@ -0,0 +1,233 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * LiteX SoC Controller Driver
> > + *
> > + * Copyright (C) 2020 Antmicro
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
> > +     const volatile void __iomem *addr)
> > +{
> > +     unsigned long val;
> > +
> > +     __io_br();
> > +     val = *(const volatile unsigned long __force *)addr;
> > +     __io_ar();
> > +     return val;
> > +}
> > +
> > +static inline void write_pointer_with_barrier(
> > +     volatile void __iomem *addr, unsigned long val)
> > +{
> > +     __io_br();
> > +     *(volatile unsigned long __force *)addr = val;
> > +     __io_ar();
> > +}
>
> What's wrong with readl/writel ?
>

readl/writel use a fixed endianness. What I want to do here is
to access bytes in the CPU native ordering - there is a comment
below explaining how CSRs are handled in LiteX.

> > +/*
> > + * LiteX SoC Generator, depending on the configuration,
> > + * can split a single logical CSR (Control & Status Register)
> > + * into a series of consecutive physical registers.
> > + *
> > + * For example, in the configuration with 8-bit CSR Bus,
> > + * 32-bit aligned (the default one for 32-bit CPUs) a 32-bit
> > + * logical CSR will be generated as four 32-bit physical registers,
> > + * each one containing one byte of meaningful data.
> > + *
> > + * For details see: https://github.com/enjoy-digital/litex/issues/314
> > + *
> > + * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
> > + * the logic of writing to/reading from the LiteX CSR in a single
> > + * place that can be then reused by all LiteX drivers.
> > + */
> > +void litex_set_reg(
> > +     void __iomem *reg, unsigned long reg_size, unsigned long val)
> > +{
> > +     unsigned long shifted_data, shift, i;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&csr_lock, flags);
> > +
> > +     for (i = 0; i < reg_size; ++i) {
> > +             shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > +             shifted_data = val >> shift;
> > +             write_pointer_with_barrier(
> > +                     reg + (LITEX_REG_SIZE * i), shifted_data);
> > +     }
> > +
> > +     spin_unlock_irqrestore(&csr_lock, flags);
> > +}
> > +
> > +unsigned long litex_get_reg(
> > +     void __iomem *reg, unsigned long reg_size)
> > +{
> > +     unsigned long shifted_data, shift, i;
> > +     unsigned long result = 0;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&csr_lock, flags);
> > +
> > +     for (i = 0; i < reg_size; ++i) {
> > +             shifted_data = read_pointer_with_barrier(
> > +                     reg + (LITEX_REG_SIZE * i));
> > +             shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > +             result |= (shifted_data << shift);
> > +     }
> > +
> > +     spin_unlock_irqrestore(&csr_lock, flags);
> > +
> > +     return result;
> > +}
>
> I'm not sure what's supposed to be in that register, but usually it
> will either be abstracted away through a framework since letting each
> and every driver poke into the same register is not really ideal, or
> if you really have to do it, using a syscon.

Those litex_set_reg/ltex_get_reg are generic functions allowing to access
any CSR generated by LiteX (addressed with reg argument). Each peripheral
has its own set of CSRs and each driver should access only CSRs from
a single peripheral.

The reason for having a common accessor is to have the logic of doing
a single CSR write (implemented internally as many writes) and a single
CSR read (implemented internally as many reads) just in one place
to avoid code duplication.

> > +static int accessors_ok;
> > +
> > +/*
> > + * Check if accessors are safe to be used by other drivers
> > + * returns true if yes - false if not
> > + */
> > +int litex_check_accessors(void)
> > +{
> > +     return accessors_ok;
> > +}
> > +
> > +#define SCRATCH_REG_OFF         0x04
> > +#define SCRATCH_REG_SIZE        4
> > +#define SCRATCH_REG_VALUE       0x12345678
> > +#define SCRATCH_TEST_VALUE      0xdeadbeef
> > +
> > +/*
> > + * Check LiteX CSR read/write access
> > + *
> > + * This function reads and writes a scratch register in order
> > + * to verify if CSR access works.
> > + *
> > + * In case any problems are detected, the driver should panic
> > + * and not set `accessors_ok` flag. As a result no other
> > + * LiteX driver should access CSR bus.
> > + *
> > + * Access to the LiteX CSR is, by design, done in CPU native
> > + * endianness. The driver should not dynamically configure
> > + * access functions when the endianness mismatch is detected.
> > + * Such situation indicates problems in the soft SoC design
> > + * and should be solved at the LiteX generator level,
> > + * not in the software.
>
> I guess that's why you don't use readl/writel. Then
> __raw_readl/__raw_writel?

Do __raw_readl/__raw_writel provide memory barriers? I want to make sure
that CSR's subregisters are read in a specific order.

> > + */
> > +static int litex_check_csr_access(void __iomem *reg_addr)
> > +{
> > +     unsigned long reg;
> > +
> > +     reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> > +
> > +     if (reg != SCRATCH_REG_VALUE) {
> > +             panic("Scratch register read error! Expected: 0x%x but got: 0x%lx",
> > +                     SCRATCH_REG_VALUE, reg);
> > +             return -EINVAL;
> > +     }
> > +
> > +     litex_set_reg(reg_addr + SCRATCH_REG_OFF,
> > +             SCRATCH_REG_SIZE, SCRATCH_TEST_VALUE);
> > +     reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> > +
> > +     if (reg != SCRATCH_TEST_VALUE) {
> > +             panic("Scratch register write error! Expected: 0x%x but got: 0x%lx",
> > +                     SCRATCH_TEST_VALUE, reg);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* restore original value of the SCRATCH register */
> > +     litex_set_reg(reg_addr + SCRATCH_REG_OFF,
> > +             SCRATCH_REG_SIZE, SCRATCH_REG_VALUE);
> > +
> > +     /* Set flag for other drivers */
> > +     accessors_ok = 1;
> > +     pr_info("LiteX SoC Controller driver initialized");
> > +
> > +     return 0;
> > +}
> > +
> > +struct litex_soc_ctrl_device {
> > +     void __iomem *base;
> > +};
> > +
> > +static const struct of_device_id litex_soc_ctrl_of_match[] = {
> > +     {.compatible = "litex,soc_controller"},
> > +     {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
> > +
> > +static int litex_soc_ctrl_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev;
> > +     struct device_node *node;
> > +     const struct of_device_id *id;
> > +     struct litex_soc_ctrl_device *soc_ctrl_dev;
> > +     struct resource *res;
> > +
> > +     dev = &pdev->dev;
> > +     node = dev->of_node;
> > +     if (!node)
> > +             return -ENODEV;
> > +
> > +     id = of_match_node(litex_soc_ctrl_of_match, node);
> > +     if (!id)
> > +             return -ENODEV;
>
> That's pretty much guaranteed.

You are right, I'll remove this fragment.

> > +     soc_ctrl_dev = devm_kzalloc(dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
> > +     if (IS_ERR_OR_NULL(soc_ctrl_dev))
> > +             return -ENOMEM;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (IS_ERR_OR_NULL(res))
> > +             return -EBUSY;
> > +
> > +     soc_ctrl_dev->base = devm_of_iomap(dev, node, 0, &res->end);
> > +     if (IS_ERR_OR_NULL(soc_ctrl_dev->base))
> > +             return -EIO;
>
> devm_platform_ioremap_resource ?

I'll simplify this fragment by using devm_platform_ioremap_resource as
suggested.

> > +     return litex_check_csr_access(soc_ctrl_dev->base);
> > +}
> > +
> > +static int litex_soc_ctrl_remove(struct platform_device *pdev)
> > +{
> > +     return 0;
> > +}
>
> You can leave the remove hook out entirely if you don't have anything
> in it.

Right.

> Maxime

Thanks for the comments!

I'll refactor the code to address your suggestions.



--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
