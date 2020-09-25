Return-Path: <SRS0=gGpx=DC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638C6C4363D
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 15:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F369F23600
	for <linux-serial@archiver.kernel.org>; Fri, 25 Sep 2020 15:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9KYEttt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgIYPGR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbgIYPGR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Sep 2020 11:06:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE94EC0613CE;
        Fri, 25 Sep 2020 08:06:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n133so3025384qkn.11;
        Fri, 25 Sep 2020 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=vh4QkP5CdDyYcmJhxcW/ArwOfJeOGSnDvTZ8YFjo7/8=;
        b=f9KYEtttZCnPYfPObAbErdDqBGcNKDgPeRcMKAuNbi7kXZ1jP8EnXV+ElMpBwyYTBa
         lcdsK93Or/u5IUJIh4RaP8c4J541pDR7X1p734d7GI51POjaIz9Z9rPbRdOPbxaIliNn
         T1zYE7v0HWGB9Ll+g1tpHFFpCAI1tvgkV0yDkWcV9nT8vamnZEp3BX9WoYjbHRQN8b4K
         3amZy8jf47cFpfBscduxxUCPDi5n8a6mKKbxRDvRD9d/VY1iGN0YgFWm12925Y9Qkj/r
         pATuDzc8QRL+/sskS3mNJIXOU7R3FZwVPvwrlnNl9tGkj9MWicWhRZNj1owxDFJj9BUd
         63rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=vh4QkP5CdDyYcmJhxcW/ArwOfJeOGSnDvTZ8YFjo7/8=;
        b=cZ+YVmZxH53DC0vJw/NKw6BughN/Tiua5jA0ioDLR3lzDJSBYfd+NrGMQRrjKeJg6e
         hVfvG/vAhflSCPMxAfAmwGkQ4q1kyEpdLlx/50GuU7BwinOlac2z5amKlPa4jgiAR8hm
         DiLIrKnYQkr3wkR8fOB/0cpqIe2AOQ12q3ZmNmkcMpfRBFKry3LBy6Sg70vZFxC6RBYd
         SUNxwUFdBHu4HFZtMbPhA3z3j1Xerf70CU1vTfkbSVIISh4hN36wxRgByEDTI2WC3Qmo
         R6IviS7ziLxz99zGjWKRSmpbDsn/06VmrtW3G5SeYgA5S9VP9i27vWDXtfbipguhUMMt
         LGFw==
X-Gm-Message-State: AOAM5328elXxNGv7Wcd5qJP/Nto2Bj9glQQFjt+dN7YqHJahpJ5XtvOj
        0eyK/7P0/DWZM4kg+yT5A/E=
X-Google-Smtp-Source: ABdhPJwT1f7eZkBhzOJA79f34L7MaYe5S2rKJOl+Vz7JhwEkRfMDSvmu71AIr9uTy1wNrBGNShMmqA==
X-Received: by 2002:a37:62d6:: with SMTP id w205mr414662qkb.229.1601046375841;
        Fri, 25 Sep 2020 08:06:15 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-71-112-157-130.pitbpa.fios.verizon.net. [71.112.157.130])
        by smtp.gmail.com with ESMTPSA id y69sm1783342qkb.52.2020.09.25.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 08:06:14 -0700 (PDT)
Date:   Fri, 25 Sep 2020 11:06:07 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mateusz Holenko <mholenko@antmicro.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Florent Kermarrec <f.kermarrec@gmail.com>
Subject: Re: [PATCH v11 3/5] drivers/soc/litex: add LiteX SoC Controller
 driver
Message-ID: <20200925150607.GB470906@errol.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUBCf8DsRBvXxxrfrQsab3kOwy95u-KwkdvaSY0vXQnXQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert, Mateusz,

On Fri, Sep 25, 2020 at 03:16:02PM +0200, Geert Uytterhoeven wrote:
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
> 
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
> 
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
> 
> > + * configured for 8-bit CSR Bus, 32-bit aligned.
> > + *
> > + * Supporting other configurations will require
> > + * extending the logic in this header.
> 
> This is no longer a header file.
> 
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

There's been talk within the LiteX dev community to standardize on a
LITEX_SUBREG_SIZE of 0x4 (i.e., using all 32 bits of a 32-bit
(LITEX_REG_SIZE) aligned MMIO location). Early 32-bit (vexriscv based)
Linux capable LiteX designs started out with only the 8 LSBits used
within a 32-bit MMIO location, but 64-bit (Rocket chip) based LiteX SoCs
use 4-byte aligned, fully populated MMIO registers (i.e., both
LITEX_SUBREG_SIZE *and* LITEX_REG_SIZE are 4). There's also been talk of
deprecating LITEX_SUBREG_SIZE == 0x1 for "linux-capable LiteX builds",
but nothing definitive yet AFAIK.

As long as adding LITEX_SUBREG_SIZE 0x4 (either as a config option, or
as a hard-coded default in a subsequent version) won't break things, we
should be safe going forward afaict.

Geert: note that LiteX has wider-than-32-bit registers spread across
multiple 32-bit aligned, 8- or 32-bit wide "subregisters", so looping
and shifting will still be necessary, even with LITEX_SUBREG_SIZE 0x4.

> The spinlock access will probably become the source of lock contention
> later, especially when considering SMP variants.
> 
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
> 
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
> 
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
> 
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
> 
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

Seconded -- perhaps simply cut'n'paste and/or adapt from
https://github.com/litex-hub/linux/blob/litex-rocket-rebase/include/linux/litex.h#L78
(from the 64-bit port of the LiteX linux patch set)
 
Cheers,
--Gabriel
