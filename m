From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 05/14] clocksource/drivers/timer-milbeaut: Add Milbeaut
 M10V timer
Date: Wed, 21 Nov 2018 11:08:45 +0100
Message-ID: <c6b7ddb0-064a-8f09-bbb4-9754f3d63ecb@linaro.org>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-6-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542589274-13878-6-git-send-email-sugaya.taichi@socionext.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sugaya Taichi <sugaya.taichi@socionext.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-serial@vger.kernel.org


Hi Sugaya,


On 19/11/2018 02:01, Sugaya Taichi wrote:
> Add Milbeaut M10V timer using 32bit timer in peripheral.

Give a better description of the timer as it is new timer introduced.

> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  drivers/clocksource/Kconfig      |   8 +++
>  drivers/clocksource/Makefile     |   1 +
>  drivers/clocksource/timer-m10v.c | 146 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 155 insertions(+)
>  create mode 100644 drivers/clocksource/timer-m10v.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 55c77e4..a278d72 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -638,4 +638,12 @@ config GX6605S_TIMER
>  	help
>  	  This option enables support for gx6605s SOC's timer.
>  
> +config M10V_TIMER
> +	bool "Milbeaut M10V timer driver" if COMPILE_TEST
> +	depends on OF
> +	depends on ARM
> +	select TIMER_OF
> +	help
> +	  Enables the support for Milbeaut M10V timer driver.
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index dd91381..8e908b4 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
>  obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
>  obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
>  obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
> +obj-$(CONFIG_M10V_TIMER)	+= timer-m10v.o
>  obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
>  obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
>  
> diff --git a/drivers/clocksource/timer-m10v.c b/drivers/clocksource/timer-m10v.c
> new file mode 100644
> index 0000000..ff97c23
> --- /dev/null
> +++ b/drivers/clocksource/timer-m10v.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Socionext Inc.
> + */
> +
> +#include <linux/clk.h>

------->

> +#include <linux/clockchips.h>

It is included from timer-of.h

<-------

> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqreturn.h>

------->

> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>

Those are not needed IMO.

<---------


> +#include "timer-of.h"
> +
> +#define FSL_TMR_TMCSR_OFS	0x0
> +#define FSL_TMR_TMR_OFS		0x4
> +#define FSL_TMR_TMRLR1_OFS	0x8
> +#define FSL_TMR_TMRLR2_OFS	0xc
> +#define FSL_RMT_REGSZPCH	0x10
> +
> +#define FSL_TMR_TMCSR_OUTL	BIT(5)
> +#define FSL_TMR_TMCSR_RELD	BIT(4)
> +#define FSL_TMR_TMCSR_INTE	BIT(3)
> +#define FSL_TMR_TMCSR_UF	BIT(2)
> +#define FSL_TMR_TMCSR_CNTE	BIT(1)
> +#define FSL_TMR_TMCSR_TRG	BIT(0)
> +
> +#define FSL_TMR_TMCSR_CSL_DIV2	0
> +#define FSL_TMR_TMCSR_CSL	BIT(10)
> +
> +#define M10V_TIMER_RATING	500
> +
> +static irqreturn_t m10v_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *clk = dev_id;
> +	struct timer_of *to = to_timer_of(clk);
> +	u32 val;
> +
> +	val = readl_relaxed(timer_of_base(to) + FSL_TMR_TMCSR_OFS);
> +	val &= ~FSL_TMR_TMCSR_UF;
> +	writel_relaxed(val, timer_of_base(to) + FSL_TMR_TMCSR_OFS);
> +
> +	clk->event_handler(clk);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int m10v_set_state_periodic(struct clock_event_device *clk)
> +{
> +	struct timer_of *to = to_timer_of(clk);
> +	u32 val = (FSL_TMR_TMCSR_CSL_DIV2 * FSL_TMR_TMCSR_CSL);

	FSL_TMR_TMCSR_CSL_DIV2 is zero, so val is always zero.
	
> +	writel_relaxed(val, timer_of_base(to) + FSL_TMR_TMCSR_OFS);
> +
> +	writel_relaxed(to->of_clk.period, timer_of_base(to) +
> +				FSL_TMR_TMRLR1_OFS);
> +	val |= FSL_TMR_TMCSR_RELD | FSL_TMR_TMCSR_CNTE |
> +		FSL_TMR_TMCSR_TRG | FSL_TMR_TMCSR_INTE;
> +	writel_relaxed(val, timer_of_base(to) + FSL_TMR_TMCSR_OFS);
> +	return 0;
> +}
> +
> +static int m10v_set_state_oneshot(struct clock_event_device *clk)
> +{
> +	struct timer_of *to = to_timer_of(clk);
> +	u32 val = (FSL_TMR_TMCSR_CSL_DIV2 * FSL_TMR_TMCSR_CSL);
> +
> +	writel_relaxed(val, timer_of_base(to) + FSL_TMR_TMCSR_OFS);
> +	return 0;
> +}
> +
> +static int m10v_clkevt_next_event(unsigned long event,
> +				   struct clock_event_device *clk)
> +{
> +	struct timer_of *to = to_timer_of(clk);
> +
> +	writel_relaxed(event, timer_of_base(to) + FSL_TMR_TMRLR1_OFS);
> +	writel_relaxed((FSL_TMR_TMCSR_CSL_DIV2 * FSL_TMR_TMCSR_CSL) |

Same comment here.

> +			FSL_TMR_TMCSR_CNTE | FSL_TMR_TMCSR_INTE |
> +			FSL_TMR_TMCSR_TRG, timer_of_base(to) +
> +			FSL_TMR_TMCSR_OFS);
> +	return 0;
> +}
> +
> +static int m10v_config_clock_source(struct timer_of *to)
> +{
> +	writel_relaxed(0, timer_of_base(to) + FSL_TMR_TMCSR_OFS);
> +	writel_relaxed(~0, timer_of_base(to) + FSL_TMR_TMR_OFS);
> +	writel_relaxed(~0, timer_of_base(to) + FSL_TMR_TMRLR1_OFS);
> +	writel_relaxed(~0, timer_of_base(to) + FSL_TMR_TMRLR2_OFS);
> +	writel_relaxed(BIT(4) | BIT(1) | BIT(0), timer_of_base(to) +
> +		FSL_TMR_TMCSR_OFS);
> +	return 0;
> +}
> +
> +static int m10v_config_clock_event(struct timer_of *to)
> +{
> +	writel_relaxed(0, timer_of_base(to) + FSL_TMR_TMCSR_OFS);
> +	return 0;
> +}
> +
> +static struct timer_of to = {
> +	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
> +
> +	.clkevt = {
> +		.name = "m10v-clkevt",
> +		.rating = M10V_TIMER_RATING,
> +		.cpumask = cpu_possible_mask,
> +	},
> +
> +	.of_irq = {
> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
> +	},
> +};
> +
> +static int __init m10v_timer_init(struct device_node *node)
> +{
> +	int ret;
> +
> +	to.clkevt.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT;
> +	to.clkevt.set_state_oneshot = m10v_set_state_oneshot;
> +	to.clkevt.set_state_periodic = m10v_set_state_periodic;
> +	to.clkevt.set_next_event = m10v_clkevt_next_event;
> +	to.of_irq.handler = m10v_timer_interrupt;

Move the initialization in the timer_of structure above.

> +	ret = timer_of_init(node, &to);
> +	if (ret)
> +		goto err;

You should return directly, rollback is done in the timer_of_init().

> +
> +	m10v_config_clock_source(&to);
> +	clocksource_mmio_init(timer_of_base(&to) + FSL_TMR_TMR_OFS,
> +		node->name, timer_of_rate(&to), M10V_TIMER_RATING, 32,
> +		clocksource_mmio_readl_down);

May be you can add the sched_clock also ?

> +	m10v_config_clock_event(&to);
> +	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
> +				15, 0xffffffff);
> +
> +	return 0;
> +err:
> +	timer_of_cleanup(&to);
> +	return ret;
> +}
> +TIMER_OF_DECLARE(m10v_peritimer, "socionext,milbeaut-m10v-timer",
> +		m10v_timer_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
