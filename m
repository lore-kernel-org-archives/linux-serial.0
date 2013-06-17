From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3 08/10] clocksource: exynos_mct: use (request/free)_irq
 calls for local timer registration
Date: Mon, 17 Jun 2013 20:53:14 +0900
Message-ID: <1a0301ce6b51$4002ee60$c008cb20$%kim@samsung.com>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
 <1371466836-4111-9-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20321 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446Ab3FQLxR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jun 2013 07:53:17 -0400
In-reply-to: <1371466836-4111-9-git-send-email-chander.kashyap@linaro.org>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Chander Kashyap' <chander.kashyap@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com

Chander Kashyap wrote:
> 
> Replace the (setup/remove)_irq calls for local timer registration with
> (request/free)_irq calls. This generalizes the local timer registration
> API.
> Suggested by Mark Rutland.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> 
> Replace the (setup/remove)_irq calls for local timer registration with
> (request/free)_irq calls. This generalises the local timer registration
> API.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>

Duplicated comments and sign-off ?...

- Kukjin

> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  drivers/clocksource/exynos_mct.c |   35
+++++++++-------------------------
> -
>  1 file changed, 9 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c
> b/drivers/clocksource/exynos_mct.c
> index 662fcc0..a704804 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -400,18 +400,6 @@ static irqreturn_t exynos4_mct_tick_isr(int irq, void
> *dev_id)
>  	return IRQ_HANDLED;
>  }
> 
> -static struct irqaction mct_tick0_event_irq = {
> -	.name		= "mct_tick0_irq",
> -	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
> -	.handler	= exynos4_mct_tick_isr,
> -};
> -
> -static struct irqaction mct_tick1_event_irq = {
> -	.name		= "mct_tick1_irq",
> -	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
> -	.handler	= exynos4_mct_tick_isr,
> -};
> -
>  static int __cpuinit exynos4_local_timer_setup(struct clock_event_device
> *evt)
>  {
>  	struct mct_clock_event_device *mevt;
> @@ -435,16 +423,15 @@ static int __cpuinit
> exynos4_local_timer_setup(struct clock_event_device *evt)
>  	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
> 
>  	if (mct_int_type == MCT_INT_SPI) {
> -		if (cpu == 0) {
> -			mct_tick0_event_irq.dev_id = mevt;
> -			evt->irq = mct_irqs[MCT_L0_IRQ];
> -			setup_irq(evt->irq, &mct_tick0_event_irq);
> -		} else {
> -			mct_tick1_event_irq.dev_id = mevt;
> -			evt->irq = mct_irqs[MCT_L1_IRQ];
> -			setup_irq(evt->irq, &mct_tick1_event_irq);
> -			irq_set_affinity(evt->irq, cpumask_of(1));
> +		evt->irq = mct_irqs[MCT_L0_IRQ + cpu];
> +		if (request_irq(evt->irq, exynos4_mct_tick_isr,
> +				IRQF_TIMER | IRQF_NOBALANCING,
> +				evt->name, mevt)) {
> +			pr_err("exynos-mct: cannot register IRQ %d\n",
> +				evt->irq);
> +			return -EIO;
>  		}
> +		irq_set_affinity(evt->irq, cpumask_of(cpu));
>  	} else {
>  		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
>  	}
> @@ -454,13 +441,9 @@ static int __cpuinit exynos4_local_timer_setup(struct
> clock_event_device *evt)
> 
>  static void exynos4_local_timer_stop(struct clock_event_device *evt)
>  {
> -	unsigned int cpu = smp_processor_id();
>  	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
>  	if (mct_int_type == MCT_INT_SPI)
> -		if (cpu == 0)
> -			remove_irq(evt->irq, &mct_tick0_event_irq);
> -		else
> -			remove_irq(evt->irq, &mct_tick1_event_irq);
> +		free_irq(evt->irq, this_cpu_ptr(&percpu_mct_tick));
>  	else
>  		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
>  }
> --
> 1.7.9.5

