From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 02/13] ARM: Exynos: fix secondary cpu power control register address calculation
Date: Sat, 08 Jun 2013 13:05:11 +0200
Message-ID: <3410121.IQM8pcjbaY@flatron>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org> <1370516488-25860-2-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:59816 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab3FHLFR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Jun 2013 07:05:17 -0400
In-Reply-To: <1370516488-25860-2-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com

Hi Chander,

On Thursday 06 of June 2013 16:31:16 Chander Kashyap wrote:
> The CPU power control register address calculation for secondary CPUs is
> generalized by calculating the register address using secondary cpu
> logical number.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/mach-exynos/include/mach/regs-pmu.h |    6 ++++++
>  arch/arm/mach-exynos/platsmp.c               |   10 +++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> b/arch/arm/mach-exynos/include/mach/regs-pmu.h index 3f30aa1..b77f72c
> 100644
> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
> @@ -125,11 +125,17 @@
>  #define S5P_GPS_ALIVE_LOWPWR			S5P_PMUREG(0x13A0)
> 
>  #define S5P_ARM_CORE0_CONFIGURATION		S5P_PMUREG(0x2000)
> +#define S5P_ARM_CORE0_STATUS			S5P_PMUREG(0x2004)
>  #define S5P_ARM_CORE0_OPTION			S5P_PMUREG(0x2008)
>  #define S5P_ARM_CORE1_CONFIGURATION		S5P_PMUREG(0x2080)
>  #define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
>  #define S5P_ARM_CORE1_OPTION			S5P_PMUREG(0x2088)

I would simply drop all those CORE1 definitions. This would have the nice 
side effect of showing all the occurencies of this issue in other files as 
well.

> 
> +#define S5P_ARM_CORE_CONFIGURATION(_nr)		\
> +			(S5P_ARM_CORE0_CONFIGURATION + (_nr) * 0x80)
> +#define S5P_ARM_CORE_STATUS(_nr)			\
> +			(S5P_ARM_CORE0_STATUS + (_nr) * 0x80)
> +
>  #define S5P_ARM_COMMON_OPTION			S5P_PMUREG(0x2408)
>  #define S5P_TOP_PWR_OPTION			S5P_PMUREG(0x2C48)
>  #define S5P_CAM_OPTION				S5P_PMUREG(0x3C08)
> diff --git a/arch/arm/mach-exynos/platsmp.c
> b/arch/arm/mach-exynos/platsmp.c index d9c6d0a..1a4e4e5 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -109,14 +109,14 @@ static int __cpuinit
> exynos_boot_secondary(unsigned int cpu, struct task_struct */
>  	write_pen_release(phys_cpu);
> 
> -	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) 
{
> +	if (!(__raw_readl(S5P_ARM_CORE_STATUS(cpu)) &

Shouldn't phys_cpu be used here, not cpu?

> S5P_CORE_LOCAL_PWR_EN))
> { __raw_writel(S5P_CORE_LOCAL_PWR_EN,
> -			     S5P_ARM_CORE1_CONFIGURATION);
> +			     S5P_ARM_CORE_CONFIGURATION(cpu));

Ditto.

> 
>  		timeout = 10;
> 
> -		/* wait max 10 ms until cpu1 is on */
> -		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
> +		/* wait max 10 ms until secondary cpu is on */
> +		while ((__raw_readl(S5P_ARM_CORE_STATUS(cpu))

Ditto.

>  			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) 
{
>  			if (timeout-- == 0)
>  				break;
> @@ -125,7 +125,7 @@ static int __cpuinit exynos_boot_secondary(unsigned
> int cpu, struct task_struct }
> 
>  		if (timeout == 0) {
> -			printk(KERN_ERR "cpu1 power enable failed");
> +			pr_err("secondary cpu power enable failed\n");

This is not really related to this patch, but I'm not strongly against 
including this fixup in this patch.

>  			spin_unlock(&boot_lock);
>  			return -ETIMEDOUT;
>  		}

By the way, I was just about to send similar patch that we have in our 
internal tree and you were faster :) . Mine also fixes the same problem in 
mach-exynos/hotplug.c where CORE1 registers are used.

Now the question is: Are you going to address all those things or we could 
just drop this patch from the series and apply mine instead, which has all 
the things already done?

Best regards,
Tomasz

