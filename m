From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 08/15] irqchip: Add RDA8810PL interrupt driver
Date: Wed, 21 Nov 2018 08:41:25 +0000
Message-ID: <83f70f64-79f1-c6e5-0328-09cc567f2686@arm.com>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-9-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121033652.12247-9-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, overseas.sales@unisoc.com
List-Id: linux-serial@vger.kernel.org

On 21/11/2018 03:36, Manivannan Sadhasivam wrote:
> Add interrupt driver for RDA Micro RDA8810PL SoC.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/mach-rda/Kconfig      |   1 +
>  drivers/irqchip/Kconfig        |   4 ++
>  drivers/irqchip/Makefile       |   1 +
>  drivers/irqchip/irq-rda-intc.c | 113 +++++++++++++++++++++++++++++++++
>  4 files changed, 119 insertions(+)
>  create mode 100644 drivers/irqchip/irq-rda-intc.c
> 
> diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
> index dafab78d7aab..29012bc68ca4 100644
> --- a/arch/arm/mach-rda/Kconfig
> +++ b/arch/arm/mach-rda/Kconfig
> @@ -3,5 +3,6 @@ menuconfig ARCH_RDA
>  	depends on ARCH_MULTI_V7
>  	select COMMON_CLK
>  	select GENERIC_IRQ_CHIP
> +	select RDA_INTC
>  	help
>  	  This enables support for the RDA Micro 8810PL SoC family.
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 51a5ef0e96ed..9d54645870ad 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -195,6 +195,10 @@ config JCORE_AIC
>  	help
>  	  Support for the J-Core integrated AIC.
>  
> +config RDA_INTC
> +	bool
> +	select IRQ_DOMAIN
> +
>  config RENESAS_INTC_IRQPIN
>  	bool
>  	select IRQ_DOMAIN
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 794c13d3ac3d..417108027e40 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
>  obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
>  obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
>  obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
> +obj-$(CONFIG_RDA_INTC)			+= irq-rda-intc.o
>  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
>  obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
>  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
> diff --git a/drivers/irqchip/irq-rda-intc.c b/drivers/irqchip/irq-rda-intc.c
> new file mode 100644
> index 000000000000..1b372bdb23bc
> --- /dev/null
> +++ b/drivers/irqchip/irq-rda-intc.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * RDA8810PL SoC irqchip driver
> + *
> + * Copyright RDA Microelectronics Company Limited
> + * Copyright (c) 2017 Andreas Färber
> + * Copyright (c) 2018 Manivannan Sadhasivam
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/irq.h>

You shouldn't need to include this.

> +#include <asm/exception.h>
> +
> +#define RDA_INTC_FINALSTATUS	0x00
> +#define RDA_INTC_STATUS		0x04
> +#define RDA_INTC_MASK_SET	0x08
> +#define RDA_INTC_MASK_CLR	0x0c
> +#define RDA_INTC_WAKEUP_MASK	0x18
> +#define RDA_INTC_CPU_SLEEP	0x1c

Half of these constants are unused. Do we really need them?

> +
> +#define RDA_IRQ_MASK_ALL	0xFFFFFFFF
> +
> +#define RDA_NR_IRQS 32

Surely the mask can be derived from the number of interrupts?

> +
> +static void __iomem *base;

Everything in this driver is prefixed with rda_. It would seem valuable
to  do the same here, as "base" is a bit too generic.

> +
> +static void rda_intc_mask_irq(struct irq_data *d)
> +{
> +	writel_relaxed(BIT(d->hwirq), base + RDA_INTC_MASK_CLR);
> +}
> +
> +static void rda_intc_unmask_irq(struct irq_data *d)
> +{
> +	writel_relaxed(BIT(d->hwirq), base + RDA_INTC_MASK_SET);

Are the names MASK_CLR and MASK_SET from the datasheet? They seem to be
backward (you set the mask to unmask...), and seem to behave like an
enable instead. That's not a big issue, just curious.

> +}
> +
> +static int rda_intc_set_type(struct irq_data *data, unsigned int flow_type)
> +{
> +	/* Hardware supports only level triggered interrupts */
> +	if (flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW))
> +		irq_set_handler(data->irq, handle_level_irq);

Why do you need to do this? You've already configured it at map time,
and it is not changing under your feet. This should be written as:

if ((flow_type & (IRQF_TRIGGER_HIGH | IRQF_TRIGGER_LOW)) == flow_type)
	return 0;

return -EINVAL;

> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static struct irq_domain *rda_irq_domain;

Please move this to the top of the file, next to "base".

> +
> +static void __exception_irq_entry rda_handle_irq(struct pt_regs *regs)
> +{
> +	u32 stat = readl_relaxed(base + RDA_INTC_FINALSTATUS);
> +	u32 hwirq;
> +
> +	while (stat) {
> +		hwirq = __fls(stat);
> +		handle_domain_irq(rda_irq_domain, hwirq, regs);
> +		stat &= ~(1 << hwirq);
> +	}
> +}
> +
> +static struct irq_chip rda_irq_chip = {
> +	.name		= "rda-intc",
> +	.irq_mask	= rda_intc_mask_irq,
> +	.irq_unmask	= rda_intc_unmask_irq,
> +	.irq_set_type	= rda_intc_set_type,
> +};
> +
> +static int rda_irq_map(struct irq_domain *d,
> +		       unsigned int virq, irq_hw_number_t hw)
> +{
> +	irq_set_status_flags(virq, IRQ_LEVEL);
> +	irq_set_chip_and_handler(virq, &rda_irq_chip, handle_level_irq);
> +	irq_set_chip_data(virq, d->host_data);
> +	irq_set_probe(virq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops rda_irq_domain_ops = {
> +	.map = rda_irq_map,
> +	.xlate = irq_domain_xlate_onecell,
> +};
> +
> +static int __init rda8810_intc_init(struct device_node *node,
> +				    struct device_node *parent)
> +{
> +	base = of_io_request_and_map(node, 0, "rda-intc");
> +	if (!base)
> +		return -ENXIO;
> +
> +	/* Mask, and invalidate all interrupt sources */

What does "invalidate" mean here?

> +	writel_relaxed(RDA_IRQ_MASK_ALL, base + RDA_INTC_MASK_CLR);
> +
> +	rda_irq_domain = irq_domain_create_linear(&node->fwnode, RDA_NR_IRQS,
> +						  &rda_irq_domain_ops, base);
> +	if (WARN_ON(!rda_irq_domain)) {
> +		iounmap(base);
> +		return -ENODEV;

Why ENODEV? ENOMEM seems more appropriate. The WARN_ON is a bit
superfluous, as the failing probe should be noisy enough.

> +	}
> +
> +	set_handle_irq(rda_handle_irq);
> +
> +	return 0;
> +}
> +
> +IRQCHIP_DECLARE(rda_intc, "rda,8810pl-intc", rda8810_intc_init);
> 

You've already posted two versions in 3 days, please allow for a week
between versions.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
