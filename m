From: Paul Osmialowski <pawelo@king.net.pl>
Subject: Re: [PATCH 6/9] arm: twr-k70f120m: clock source drivers for Kinetis
 SoC
Date: Wed, 24 Jun 2015 07:09:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506240703440.24366@localhost.localdomain>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl> <1435094387-20146-7-git-send-email-pawelo@king.net.pl> <5589DCB9.2000908@codeaurora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5589DCB9.2000908@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Paul Osmialowski <pawelo@king.net.pl>, Andrew Morton <akpm@linux-foundation.org>, Anson Huang <b20788@freescale.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Frank Li <Frank.Li@freescale.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingchang Lu <jingchang.lu@freescale.com>, Jiri Slaby <jslaby@suse.cz>, Kees Cook <keescook@chromium.org>, Kumar Gala <galak@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm+renesas@opensource.se>, Michael Turquette <mturquette@baylibre.com>, Nathan
List-Id: linux-serial@vger.kernel.org

Hi Stephen,

Thanks for the valuable input - all of those points are now on my 
checklist for the work on the second iteration of this patchset.

On Tue, 23 Jun 2015, Stephen Boyd wrote:

> On 06/23/2015 02:19 PM, Paul Osmialowski wrote:
>>
>> diff --git a/drivers/clk/clk-kinetis.c b/drivers/clk/clk-kinetis.c
>> new file mode 100644
>> index 0000000..dea1054
>> --- /dev/null
>> +++ b/drivers/clk/clk-kinetis.c
>> @@ -0,0 +1,226 @@
>> +/*
>> + * clk-kinetis.c - Clock driver for Kinetis K70 MCG
>> + *
>> + * Based on legacy pre-OF code by Alexander Potashev <aspotashev@emcraft.com>
>> + *
>> + * Copyright (C) 2015 Paul Osmialowski <pawelo@king.net.pl>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it under
>> + * the terms of the GNU General Public License version 2 as published by the
>> + * Free Software Foundation.
>> + */
>> +
>> +#include <linux/clk.h>
>
> Is this using the consumer API? Please remove this include.
>
>> +#include <linux/io.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/err.h>
>> +#include <mach/kinetis.h>
>> +#include <mach/power.h>
>
> It would be nice if we didn't need these mach includes so that this
> driver can be easily build tested.
>
>> +
>> +#include <dt-bindings/clock/kinetis-mcg.h>
> [..]
>> +}
>> +
>> +CLK_OF_DECLARE(kinetis_mcg, "fsl,kinetis-cmu", kinetis_mcg_init);
>
> A clocksource isn't the same as a clk provider. Please split this patch
> into two, one for the clk provider (drivers/clk) and one for the
> clocksource driver (drivers/clocksource).
>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 0f1c77e..1d2ecde 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -106,6 +106,11 @@ config CLKSRC_EFM32
>>  	  Support to use the timers of EFM32 SoCs as clock source and clock
>>  	  event device.
>>
>> +config CLKSRC_KINETIS
>> +	bool "Clocksource for Kinetis SoCs"
>> +	depends on OF && ARM && ARCH_KINETIS
>
> Doesn't ARCH_KINETIS imply ARM? Seems that we can drop the ARM
> dependency here.
>
>> +	select CLKSRC_OF
>>
>>
>> diff --git a/drivers/clocksource/timer-kinetis.c b/drivers/clocksource/timer-kinetis.c
>> new file mode 100644
>> index 0000000..634f365
>> --- /dev/null
>> +++ b/drivers/clocksource/timer-kinetis.c
> [..]
>> +
>> +/*
>> + * Clock event device set mode function
>> + */
>> +static void kinetis_clockevent_tmr_set_mode(
>> +	enum clock_event_mode mode, struct clock_event_device *clk)
>
> s/clk/evt/ ?
>
>> +{
>> +	struct kinetis_clock_event_ddata *pit =
>> +		container_of(clk, struct kinetis_clock_event_ddata, evtdev);
>> +
>> +	switch (mode) {
>> +	case CLOCK_EVT_MODE_PERIODIC:
>> +		kinetis_pit_enable(pit->base, 1);
>> +		break;
>> +	case CLOCK_EVT_MODE_ONESHOT:
>> +	case CLOCK_EVT_MODE_UNUSED:
>> +	case CLOCK_EVT_MODE_SHUTDOWN:
>> +	default:
>> +		kinetis_pit_enable(pit->base, 0);
>> +	}
>> +}
>> +
>> +/*
>> + * Configure the timer to generate an interrupt in the specified amount of ticks
>> + */
>> +static int kinetis_clockevent_tmr_set_next_event(
>> +	unsigned long delta, struct clock_event_device *c)
>> +{
>> +	struct kinetis_clock_event_ddata *pit =
>> +		container_of(c, struct kinetis_clock_event_ddata, evtdev);
>> +	unsigned long flags;
>> +
>> +	raw_local_irq_save(flags);
>
> What is this protecting against?
>
>> +	kinetis_pit_init(pit->base, delta);
>> +	kinetis_pit_enable(pit->base, 1);
>> +	raw_local_irq_restore(flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct kinetis_clock_event_ddata
>> +		kinetis_clockevent_tmrs[KINETIS_PIT_CHANNELS] = {
>> +	{
>> +		.evtdev = {
>> +			.name		= "fsl,kinetis-pit-timer0",
>> +			.rating		= 200,
>> +			.features	=
>> +			    CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
>> +			.set_mode	= kinetis_clockevent_tmr_set_mode,
>> +			.set_next_event	= kinetis_clockevent_tmr_set_next_event,
>> +		},
>> +	},
>> +	{
>> +		.evtdev = {
>> +			.name		= "fsl,kinetis-pit-timer1",
>> +		},
>> +	},
>> +	{
>> +		.evtdev = {
>> +			.name		= "fsl,kinetis-pit-timer2",
>> +		},
>> +	},
>> +	{
>> +		.evtdev = {
>> +			.name		= "fsl,kinetis-pit-timer3",
>> +		},
>> +	},
>> +};
>> +
>> +/*
>> + * Timer IRQ handler
>> + */
>> +static irqreturn_t kinetis_clockevent_tmr_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct kinetis_clock_event_ddata *tmr = dev_id;
>> +
>> +	KINETIS_PIT_WR(tmr->base, tflg, KINETIS_PIT_TFLG_TIF_MSK);
>> +
>> +	tmr->evtdev.event_handler(&(tmr->evtdev));
>
> Unnecessary parentheses, please remove them.
>
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +/*
>> + * System timer IRQ action
>> + */
>> +static struct irqaction kinetis_clockevent_irqaction[KINETIS_PIT_CHANNELS] = {
>> +	{
>> +		.name = "Kinetis Kernel Time Tick (pit0)",
>> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
>> +		.dev_id = &kinetis_clockevent_tmrs[0],
>> +		.handler = kinetis_clockevent_tmr_irq_handler,
>> +	}, {
>> +		.name = "Kinetis Kernel Time Tick (pit1)",
>> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
>> +		.dev_id = &kinetis_clockevent_tmrs[1],
>> +		.handler = kinetis_clockevent_tmr_irq_handler,
>> +	}, {
>> +		.name = "Kinetis Kernel Time Tick (pit2)",
>> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
>> +		.dev_id = &kinetis_clockevent_tmrs[2],
>> +		.handler = kinetis_clockevent_tmr_irq_handler,
>> +	}, {
>> +		.name = "Kinetis Kernel Time Tick (pit3)",
>> +		.flags = IRQF_TIMER | IRQF_IRQPOLL,
>> +		.dev_id = &kinetis_clockevent_tmrs[3],
>> +		.handler = kinetis_clockevent_tmr_irq_handler,
>> +	},
>> +};
>
> Any reason we can't just use request_irq() instead of having a set of
> static irq actions?
>
>> +
>> +static void __init kinetis_clockevent_init(struct device_node *np)
>> +{
> [..]
>> irq;
>> +	}
>> +
>> +	chan = of_alias_get_id(np, "pit");
>> +	if ((chan < 0) || (chan >= KINETIS_PIT_CHANNELS)) {
>
> Unnecessary parentheses, please remove them.
>
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
