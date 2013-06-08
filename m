From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 01/13] ARM: Exynos: initialize l2x0 cache controller only for cortex-a9 based SoCs
Date: Sat, 08 Jun 2013 12:57:41 +0200
Message-ID: <5595095.zmTGjttZIk@flatron>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:59675 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab3FHK5r (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Jun 2013 06:57:47 -0400
In-Reply-To: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, olof@lixom.net, swarren@wwwdotorg.org, arnd@arndb.de

Hi Chander,

On Thursday 06 of June 2013 16:31:15 Chander Kashyap wrote:
> Only cortex-a9 based Exynos SoCs have l2x0 cache controller. Hence
> instead of checking for every SoC with soc_is_xxx, just check for cpu
> part number and initialize the cache controller for cortex-a9 based
> SoCs.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/mach-exynos/common.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c
> b/arch/arm/mach-exynos/common.c index 8ce2db4..bad000e 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -35,6 +35,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/mach/irq.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cputype.h>
> 
>  #include <mach/regs-irq.h>
>  #include <mach/regs-pmu.h>
> @@ -520,7 +521,7 @@ static int __init exynos4_l2x0_cache_init(void)

I wonder if it shouldn't be done the other way around, i.e. this function 
being called only when running on SoCs for which it's appropriate, instead 
of checking for supported SoC in this function.

Keep in mind that we are going towards multiplatform support, so you would 
end up running this code on any non-Exynos SoC with Cortex A9 as well. 
IMHO we should drop most (if not all) of the initcalls around mach-
exynos/.

CCing people that might have some opinion on this topic as well.

Best regards,
Tomasz

>  {
>  	int ret;
> 
> -	if (soc_is_exynos5250() || soc_is_exynos5440())
> +	if (read_cpuid_part_number() != ARM_CPU_PART_CORTEX_A9)
>  		return 0;
> 
>  	ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
