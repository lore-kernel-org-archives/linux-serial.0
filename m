Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9DFC2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 11:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AB8221F0
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 11:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIWL63 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:58:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2913 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbgIWL62 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 07:58:28 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D0C0AEB5D77E86CC8281;
        Wed, 23 Sep 2020 12:58:26 +0100 (IST)
Received: from localhost (10.52.124.240) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 23 Sep
 2020 12:58:25 +0100
Date:   Wed, 23 Sep 2020 12:56:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mateusz Holenko <mholenko@antmicro.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Stafford Horne <shorne@gmail.com>,
        "Karol Gugala" <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: Re: [PATCH v11 3/5] drivers/soc/litex: add LiteX SoC Controller
 driver
Message-ID: <20200923125645.00004846@Huawei.com>
In-Reply-To: <20200923120817.1667149-3-mholenko@antmicro.com>
References: <20200923120817.1667149-0-mholenko@antmicro.com>
        <20200923120817.1667149-3-mholenko@antmicro.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.240]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 23 Sep 2020 12:09:06 +0200
Mateusz Holenko <mholenko@antmicro.com> wrote:

> From: Pawel Czarnecki <pczarnecki@internships.antmicro.com>
> 
> This commit adds driver for the FPGA-based LiteX SoC
> Controller from LiteX SoC builder.
> 
> Co-developed-by: Mateusz Holenko <mholenko@antmicro.com>
> Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> Signed-off-by: Pawel Czarnecki <pczarnecki@internships.antmicro.com>

A few little things inline, but looks fine in general to me.

Main request is for more formal documentation of parameters to the read
and write functions.

Jonathan
 
> ---
> 
> Notes:
>     Changes in v11:
>     - removed an unnecessary comment left over from previous version
>     - changed a multi-line comment to comply with the formatting rules
>     - use WARN instad of BUG on a failed CSR validation
> 
>     Changes in v10:
>     - added casting to avoid sparse warnings in the SoC Controller's driver
>     
>     Changes in v9:
>     - added exporting of the `litex_set_reg`/`litex_get_reg` symbols
> 
>     Changes in v8:
>     - removed `litex_check_accessors()` helper function
>     - added crashing (BUG) on the failed LiteX CSR access test
> 
>     No changes in v7.
> 
>     Changes in v6:
>     - added dependency on OF || COMPILE_TEST
>     - used le32_to_cpu(readl(addr)) instead of __raw_readl
>       and writel(cpu_to_le32(value), addr) instead of __raw_writel
>       to take advantage of memory barriers provided by readl/writel
> 
>     Changes in v5:
>     - removed helper accessors and used __raw_readl/__raw_writel instead
>     - fixed checking for errors in litex_soc_ctrl_probe
> 
>     Changes in v4:
>     - fixed indent in Kconfig's help section
>     - fixed copyright header
>     - changed compatible to "litex,soc-controller"
>     - simplified litex_soc_ctrl_probe
>     - removed unnecessary litex_soc_ctrl_remove
>    
>     This commit has been introduced in v3 of the patchset.
>     
>     It includes a simplified version of common 'litex.h'
>     header introduced in v2 of the patchset.
> 
>  MAINTAINERS                        |   2 +
>  drivers/soc/Kconfig                |   1 +
>  drivers/soc/Makefile               |   1 +
>  drivers/soc/litex/Kconfig          |  15 +++
>  drivers/soc/litex/Makefile         |   3 +
>  drivers/soc/litex/litex_soc_ctrl.c | 194 +++++++++++++++++++++++++++++
>  include/linux/litex.h              |  24 ++++
>  7 files changed, 240 insertions(+)
>  create mode 100644 drivers/soc/litex/Kconfig
>  create mode 100644 drivers/soc/litex/Makefile
>  create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
>  create mode 100644 include/linux/litex.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39be98db7418..4d70a1b22a87 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9840,6 +9840,8 @@ M:	Karol Gugala <kgugala@antmicro.com>
>  M:	Mateusz Holenko <mholenko@antmicro.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/*/litex,*.yaml
> +F:	drivers/soc/litex/litex_soc_ctrl.c
> +F:	include/linux/litex.h
>  
>  LIVE PATCHING
>  M:	Josh Poimboeuf <jpoimboe@redhat.com>
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 425ab6f7e375..d097d070f579 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -9,6 +9,7 @@ source "drivers/soc/bcm/Kconfig"
>  source "drivers/soc/fsl/Kconfig"
>  source "drivers/soc/imx/Kconfig"
>  source "drivers/soc/ixp4xx/Kconfig"
> +source "drivers/soc/litex/Kconfig"
>  source "drivers/soc/mediatek/Kconfig"
>  source "drivers/soc/qcom/Kconfig"
>  source "drivers/soc/renesas/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 36452bed86ef..0b16108823ef 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
>  obj-y				+= imx/
>  obj-$(CONFIG_ARCH_IXP4XX)	+= ixp4xx/
>  obj-$(CONFIG_SOC_XWAY)		+= lantiq/
> +obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
>  obj-y				+= mediatek/
>  obj-y				+= amlogic/
>  obj-y				+= qcom/
> diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
> new file mode 100644
> index 000000000000..c974ec3846bc
> --- /dev/null
> +++ b/drivers/soc/litex/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License_Identifier: GPL-2.0
> +
> +menu "Enable LiteX SoC Builder specific drivers"
> +
> +config LITEX_SOC_CONTROLLER
> +	tristate "Enable LiteX SoC Controller driver"
> +	depends on OF || COMPILE_TEST
> +	help
> +	  This option enables the SoC Controller Driver which verifies
> +	  LiteX CSR access and provides common litex_get_reg/litex_set_reg
> +	  accessors.
> +	  All drivers that use functions from litex.h must depend on
> +	  LITEX_SOC_CONTROLLER.
> +
> +endmenu
> diff --git a/drivers/soc/litex/Makefile b/drivers/soc/litex/Makefile
> new file mode 100644
> index 000000000000..98ff7325b1c0
> --- /dev/null
> +++ b/drivers/soc/litex/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License_Identifier: GPL-2.0
> +
> +obj-$(CONFIG_LITEX_SOC_CONTROLLER)	+= litex_soc_ctrl.o
> diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> new file mode 100644
> index 000000000000..08330c9872b0
> --- /dev/null
> +++ b/drivers/soc/litex/litex_soc_ctrl.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LiteX SoC Controller Driver
> + *
> + * Copyright (C) 2020 Antmicro <www.antmicro.com>
> + *
> + */
> +
> +#include <linux/litex.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>

I'm not seeing anything from this header in use in here yet.

> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +
> +/*
> + * The parameters below are true for LiteX SoC
> + * configured for 8-bit CSR Bus, 32-bit aligned.
> + *
> + * Supporting other configurations will require
> + * extending the logic in this header.
> + */
> +#define LITEX_REG_SIZE             0x4
> +#define LITEX_SUBREG_SIZE          0x1
> +#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
> +
> +static DEFINE_SPINLOCK(csr_lock);
> +
> +/*
> + * LiteX SoC Generator, depending on the configuration,
> + * can split a single logical CSR (Control & Status Register)
> + * into a series of consecutive physical registers.
> + *
> + * For example, in the configuration with 8-bit CSR Bus,
> + * 32-bit aligned (the default one for 32-bit CPUs) a 32-bit
> + * logical CSR will be generated as four 32-bit physical registers,
> + * each one containing one byte of meaningful data.
> + *
> + * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
> + *
> + * The purpose of `litex_set_reg`/`litex_get_reg` is to implement
> + * the logic of writing to/reading from the LiteX CSR in a single
> + * place that can be then reused by all LiteX drivers.
> + */

I would argue in favor of formal kernel-doc for these.
Even with this explanation the exact meaning of parameters
isn't particularly clear.

> +void litex_set_reg(void __iomem *reg, unsigned long reg_size,
> +		    unsigned long val)
> +{
> +	unsigned long shifted_data, shift, i;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&csr_lock, flags);
> +
> +	for (i = 0; i < reg_size; ++i) {
> +		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> +		shifted_data = val >> shift;
> +
> +		writel((u32 __force)cpu_to_le32(shifted_data), reg + (LITEX_REG_SIZE * i));
> +	}
> +
> +	spin_unlock_irqrestore(&csr_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(litex_set_reg);
> +
> +unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_size)
> +{
> +	unsigned long shifted_data, shift, i;
> +	unsigned long result = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&csr_lock, flags);
> +
> +	for (i = 0; i < reg_size; ++i) {
> +		shifted_data = le32_to_cpu((__le32 __force)readl(reg + (LITEX_REG_SIZE * i)));
> +
> +		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> +		result |= (shifted_data << shift);
> +	}
> +
> +	spin_unlock_irqrestore(&csr_lock, flags);
> +
> +	return result;
> +}
> +EXPORT_SYMBOL_GPL(litex_get_reg);
> +
> +#define SCRATCH_REG_OFF         0x04
> +#define SCRATCH_REG_SIZE        4
> +#define SCRATCH_REG_VALUE       0x12345678
> +#define SCRATCH_TEST_VALUE      0xdeadbeef
> +
> +/*
> + * Check LiteX CSR read/write access
> + *
> + * This function reads and writes a scratch register in order
> + * to verify if CSR access works.
> + *
> + * In case any problems are detected, the driver should panic.
> + *
> + * Access to the LiteX CSR is, by design, done in CPU native
> + * endianness. The driver should not dynamically configure
> + * access functions when the endianness mismatch is detected.
> + * Such situation indicates problems in the soft SoC design
> + * and should be solved at the LiteX generator level,
> + * not in the software.
> + */
> +static int litex_check_csr_access(void __iomem *reg_addr)
> +{
> +	unsigned long reg;
> +
> +	reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> +
> +	if (reg != SCRATCH_REG_VALUE) {
> +		panic("Scratch register read error! Expected: 0x%x but got: 0x%lx",
> +			SCRATCH_REG_VALUE, reg);
> +		return -EINVAL;
> +	}
> +
> +	litex_set_reg(reg_addr + SCRATCH_REG_OFF,
> +		SCRATCH_REG_SIZE, SCRATCH_TEST_VALUE);
> +	reg = litex_get_reg(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_SIZE);
> +
> +	if (reg != SCRATCH_TEST_VALUE) {
> +		panic("Scratch register write error! Expected: 0x%x but got: 0x%lx",
> +			SCRATCH_TEST_VALUE, reg);
> +		return -EINVAL;
> +	}
> +
> +	/* restore original value of the SCRATCH register */
> +	litex_set_reg(reg_addr + SCRATCH_REG_OFF,
> +		SCRATCH_REG_SIZE, SCRATCH_REG_VALUE);
> +
> +	pr_info("LiteX SoC Controller driver initialized");
> +
> +	return 0;
> +}
> +
> +struct litex_soc_ctrl_device {
> +	void __iomem *base;
> +};
> +
> +static const struct of_device_id litex_soc_ctrl_of_match[] = {
> +	{.compatible = "litex,soc-controller"},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
> +
> +static int litex_soc_ctrl_probe(struct platform_device *pdev)
> +{
> +	int result;
> +	struct device *dev;
> +	struct device_node *node;
> +	struct litex_soc_ctrl_device *soc_ctrl_dev;
> +
> +	dev = &pdev->dev;
> +	node = dev->of_node;
> +	if (!node)
> +		return -ENODEV;
> +
> +	soc_ctrl_dev = devm_kzalloc(dev, sizeof(*soc_ctrl_dev), GFP_KERNEL);
> +	if (!soc_ctrl_dev)
> +		return -ENOMEM;
> +
> +	soc_ctrl_dev->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(soc_ctrl_dev->base))
> +		return PTR_ERR(soc_ctrl_dev->base);
> +
> +	result = litex_check_csr_access(soc_ctrl_dev->base);
> +	if (result) {
> +		/* LiteX CSRs access is broken which means that
> +		 * none of LiteX drivers will most probably
> +		 * operate correctly
> +		 */
> +		WARN(1, "Failed to validate CSR registers, the system is probably broken.\n");
> +	}
> +
> +	return result;
> +}
> +
> +static struct platform_driver litex_soc_ctrl_driver = {
> +	.driver = {
> +		.name = "litex-soc-controller",
> +		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
> +	},
> +	.probe = litex_soc_ctrl_probe,
> +};
> +
> +module_platform_driver(litex_soc_ctrl_driver);
> +MODULE_DESCRIPTION("LiteX SoC Controller driver");
> +MODULE_AUTHOR("Antmicro <www.antmicro.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/litex.h b/include/linux/litex.h
> new file mode 100644
> index 000000000000..72061018c172
> --- /dev/null
> +++ b/include/linux/litex.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Common LiteX header providing
> + * helper functions for accessing CSRs.
> + *
> + * Implementation of the functions is provided by
> + * the LiteX SoC Controller driver.
> + *
> + * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
> + */
> +
> +#ifndef _LINUX_LITEX_H
> +#define _LINUX_LITEX_H
> +
> +#include <linux/io.h>
> +#include <linux/types.h>
> +#include <linux/compiler_types.h>
> +
> +void litex_set_reg(void __iomem *reg, unsigned long reg_sz, unsigned long val);
> +
> +unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_sz);
> +

Nitpick. One blank line is almost always enough!

> +
> +#endif /* _LINUX_LITEX_H */


