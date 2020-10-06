Return-Path: <SRS0=BKBA=DN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FD1C46466
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 08:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5FB2080A
	for <linux-serial@archiver.kernel.org>; Tue,  6 Oct 2020 08:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="AvrDyVVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgJFIC4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 6 Oct 2020 04:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFICy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Oct 2020 04:02:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47452C0613D2
        for <linux-serial@vger.kernel.org>; Tue,  6 Oct 2020 01:02:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so1238155pjb.2
        for <linux-serial@vger.kernel.org>; Tue, 06 Oct 2020 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nA5v3XqDBF0oR7AC0TT6+GK1ULFanZeE+mXZZxCdFKI=;
        b=AvrDyVVj84zGt577GC6gwDYQ+U+68kKu/2RMZi0AiAxTLiKSBofM42ohz2yfGewgbS
         5Iu+DgYUppolGhzRiFZl7/cBMW9apKRpZs1v4PICdKKrxZvrxACJMwYmCLc0YRZ2G3br
         Ue6cGHn0zWE5Mdu+GgarOQohQkoFrda4nt0Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nA5v3XqDBF0oR7AC0TT6+GK1ULFanZeE+mXZZxCdFKI=;
        b=E0z18Wk+A2+5/fInHZdsu3qmJT4CVHZo6E678rbEgkx8aFcRg1djJqwjifCnBxNqaE
         REzb+xIFI4F7hOEiIYKFWO4X7sp+RkLwawvtNlMWegHAHhYNb8N6mC1vbNyTMsAg3RTv
         o5HuE56Ngs434VkUWWqyi5GXtG6xo90duEYE3xSYa5+j8VDd8hiOpVac7Q/e1uu3l5lK
         VCCN9eTTQNDFrvMwV6NElLAG2sdGMYSOMuXguB0gjvmZpC3GnZGOXMNfsDNK2XvScUJj
         PV+dK5l8VTGVv5A1lhwJhbLt+YzebufRfO5a//CxGUvVkragfgBl2RXZziSZPSTc3hru
         S8cQ==
X-Gm-Message-State: AOAM531FFHgzqXPodyXkkZKgvpAqpjDmg6JRVK+qB0lG9XZLMwVlj54V
        /9MmlM8qYfkzzWrucsl5aIqZ1PmyD3U8sW0MmG+yOQ==
X-Google-Smtp-Source: ABdhPJw+O7QwYg+m5/cssJUq3HMAo0HP796C+33bcfhaF91Uc016e8UTxuepDfT+coundaEkLRncgOVZ2G1urRzrwLo=
X-Received: by 2002:a17:902:9347:b029:d3:b2c6:1500 with SMTP id
 g7-20020a1709029347b02900d3b2c61500mr2237720plp.5.1601971373459; Tue, 06 Oct
 2020 01:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200923120817.1667149-0-mholenko@antmicro.com>
 <20200923120817.1667149-3-mholenko@antmicro.com> <CAMuHMdUBCf8DsRBvXxxrfrQsab3kOwy95u-KwkdvaSY0vXQnXQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUBCf8DsRBvXxxrfrQsab3kOwy95u-KwkdvaSY0vXQnXQ@mail.gmail.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Tue, 6 Oct 2020 10:02:40 +0200
Message-ID: <CAPk366TxFJa-rqY6eFoGuMoc_r_=CFQgDMC-j2Pv0=dUR06b9A@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] drivers/soc/litex: add LiteX SoC Controller driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

On Fri, Sep 25, 2020 at 3:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Mateusz,
>
> On Wed, Sep 23, 2020 at 12:10 PM Mateusz Holenko <mholenko@antmicro.com> wrote:
> > From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> >
> > This commit adds driver for the FPGA-based LiteX SoC
> > Controller from LiteX SoC builder.
> >
> > Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
>
> Thanks for your patch!

Thanks for your review!

> > --- /dev/null
> > +++ b/drivers/soc/litex/Kconfig
> > @@ -0,0 +1,15 @@
> > +# SPDX-License_Identifier: GPL-2.0
> > +
> > +menu "Enable LiteX SoC Builder specific drivers"
> > +
> > +config LITEX_SOC_CONTROLLER
> > +       tristate "Enable LiteX SoC Controller driver"
> > +       depends on OF || COMPILE_TEST
> > +       help
> > +         This option enables the SoC Controller Driver which verifies
> > +         LiteX CSR access and provides common litex_get_reg/litex_set_reg
> > +         accessors.
> > +         All drivers that use functions from litex.h must depend on
> > +         LITEX_SOC_CONTROLLER.
>
> I'm wondering if it makes sense to have them depend on a "simpler"
> symbol instead, e.g. LITEX?
>
> Currently the SoC controller is limited to I/O accessors and a simple
> register compatibility check, but you may want to extend it with more
> features later, so you probably want to keep the LITEX_SOC_CONTROLLER.
> Hence you could add
>
>     config LITEX
>         bool
>
> and let LITEX_SOC_CONTROLLER select LITEX.

But then if other drivers depend just on LITEX, it would not automatically
mean that the LITEX_SOC_CONTROLLER is selected, right?. And if it's not selected
litex_{g,s}et_reg() are not available and the compilation would fail.

I could move the implementation of those functions directly to the
litex.h header
and avoid this KConfig dependency, but I'm not sure if they are not
too big to become a static inline.
What do you think?

> > --- /dev/null
> > +++ b/drivers/soc/litex/litex_soc_ctrl.c
> > @@ -0,0 +1,194 @@
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
>
> SoCs

Right, I will fix that.

> > + * configured for 8-bit CSR Bus, 32-bit aligned.
> > + *
> > + * Supporting other configurations will require
> > + * extending the logic in this header.
>
> This is no longer a header file.

It's not - you are correct. I will rephrase it to "extending the logic
in this file".

> > + */
> > +#define LITEX_REG_SIZE             0x4
> > +#define LITEX_SUBREG_SIZE          0x1
> > +#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
> > +
> > +static DEFINE_SPINLOCK(csr_lock);
> > +
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
> > + * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
> > + *
> > + * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
> > + * the logic of writing to/reading from the LiteX CSR in a single
> > + * place that can be then reused by all LiteX drivers.
> > + */
> > +void litex_set_reg(void __iomem *reg, unsigned long reg_size,
> > +                   unsigned long val)
> > +{
> > +       unsigned long shifted_data, shift, i;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&csr_lock, flags);
> > +
> > +       for (i = 0; i < reg_size; ++i) {
> > +               shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > +               shifted_data = val >> shift;
> > +
> > +               writel((u32 __force)cpu_to_le32(shifted_data), reg + (LITEX_REG_SIZE * i));
> > +       }
> > +
> > +       spin_unlock_irqrestore(&csr_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(litex_set_reg);
>
> I'm still wondering about the overhead of loops and multiple accesses,
> and the need for them (see also BenH's earlier comment).
> If e.g. the register widths change for LiteUART (currently they're
> hardcoded to one), would you still consider it using the same
> programming interface, and thus compatible with "litex,liteuart"?

Since the amount of possible `reg_size` is practically limited we could
add explicit 8/32/64/128 accessors to eliminate loops.
As for multiple writel/readl I don't really see an option to avoid
them for the 8-bit bus width.

> The spinlock access will probably become the source of lock contention
> later, especially when considering SMP variants.

Do you have any suggestions on how to handle this?
Dropping locks could lead to the situation when two cores write at the
same time leaving a wrong (mixed) value in the CSR.

> > +/*
> > + * Check LiteX CSR read/write access
> > + *
> > + * This function reads and writes a scratch register in order
> > + * to verify if CSR access works.
> > + *
> > + * In case any problems are detected, the driver should panic.
> > + *
> > + * Access to the LiteX CSR is, by design, done in CPU native
> > + * endianness. The driver should not dynamically configure
> > + * access functions when the endianness mismatch is detected.
> > + * Such situation indicates problems in the soft SoC design
> > + * and should be solved at the LiteX generator level,
> > + * not in the software.
> > + */
> > +static int litex_check_csr_access(void __iomem *reg_addr)
> > +{
> > +       unsigned long reg;
> > +
> > +       reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> > +
> > +       if (reg != SCRATCH_REG_VALUE) {
> > +               panic("Scratch register read error! Expected: 0x%x but got: 0x%lx",
> > +                       SCRATCH_REG_VALUE, reg);
>
> Do you think the user will ever see this panic message? (see below)

On UART most probably not, as broken CSRs mean broken UART driver as well.
But I believe you can retrieve logs from the memory and analyze them
post-mortem, isn't that right?

> > +               return -EINVAL;
>
> Good ;-)  All of BUG()/WARN()/panic() may be compiled out, depending on
> config options, so the system may continue running beyond the panic()
> call.
>
> > +static int litex_soc_ctrl_probe(struct platform_device *pdev)
> > +{
> > +       int result;
> > +       struct device *dev;
> > +       struct device_node *node;
> > +       struct litex_soc_ctrl_device *soc_ctrl_dev;
> > +
> > +       dev = &pdev->dev;
> > +       node = dev->of_node;
> > +       if (!node)
> > +               return -ENODEV;
>
> FYI, this cannot happen.

Right, this check is not necessary - I will remove it.

> > +
> > +       soc_ctrl_dev = devm_kzalloc(dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
> > +       if (!soc_ctrl_dev)
> > +               return -ENOMEM;
> > +
> > +       soc_ctrl_dev->base = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(soc_ctrl_dev->base))
> > +               return PTR_ERR(soc_ctrl_dev->base);
> > +
> > +       result = litex_check_csr_access(soc_ctrl_dev->base);
> > +       if (result) {
> > +               /* LiteX CSRs access is broken which means that
> > +                * none of LiteX drivers will most probably
> > +                * operate correctly
> > +                */
> > +               WARN(1, "Failed to validate CSR registers, the system is probably broken.\n");
>
> WARN(result, ...)
>
> But is this WARN() needed? You have already called panic() before.

You are right - in both cases (read/write) we call panic before
returning a non-0 value from litex_check_csr_access().
In this context additional WARN is probably not necessary. I'll extend
the panic message to indicate that read/write failure means a broken
system and drop this WARN.

> > +       }
> > +
> > +       return result;
> > +}
> > +
> > +static struct platform_driver litex_soc_ctrl_driver = {
> > +       .driver = {
> > +               .name = "litex-soc-controller",
> > +               .of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
> > +       },
> > +       .probe = litex_soc_ctrl_probe,
> > +};
> > +
> > +module_platform_driver(litex_soc_ctrl_driver);
>
> module_platform_driver() means this driver is probed quite late in the
> boot sequence.  Currently the only other LiteX driver is liteuart, which
> is probed at more or less the same time, but I can envision more early
> drivers to be added later (typically interrupt/clock controllers and
> timers not integrated into the main CPU core).
> Note that even liteuart will run earlier, and thus access CSR registers
> before the check has run, when using e.g. earlycon...

Yes, this is an interesting point.
We have already covered it in some previous version of the patchset by testing
if the LiteX SoC Controller driver was probed and returning -EDEFER in
the UART driver otherwise
(to make sure CSR access is verified before UART uses it).
With this approach, however, all future LiteX drivers would have to
follow the pattern and we would require the LiteX SoC Controller
to be part of the system (which is not the case for the Microwatt
platform for example - it uses just an eth core from LiteX).

That's why we finally decided to go with the relaxed version - where
we allow the SoC controller driver not to be the first LiteX driver to
be probed (and possibly detect a problem after other drivers encounter
it).

> > --- /dev/null
> > +++ b/include/linux/litex.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Common LiteX header providing
> > + * helper functions for accessing CSRs.
> > + *
> > + * Implementation of the functions is provided by
> > + * the LiteX SoC Controller driver.
> > + *
> > + * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
> > + */
> > +
> > +#ifndef _LINUX_LITEX_H
> > +#define _LINUX_LITEX_H
> > +
> > +#include <linux/io.h>
> > +#include <linux/types.h>
> > +#include <linux/compiler_types.h>
> > +
> > +void litex_set_reg(void __iomem *reg, unsigned long reg_sz, unsigned long val);
> > +
> > +unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_sz);
>
> Perhaps you can add static inline litex_{read,write}{8,16,32}() wrappers,
> so drivers don't have to pass the reg_sz parameter explicitly,
> and to make it look more like accessors of other bus types?

Yes, this is definitely doable.

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Best regards,
Mateusz

--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
