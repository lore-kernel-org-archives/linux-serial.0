From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 04/13] ARM: dts: list the CPU nodes for Exynos5250
Date: Sat, 08 Jun 2013 13:16:15 +0200
Message-ID: <16514785.Efj3frXj0r@flatron>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org> <1370516488-25860-4-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1370516488-25860-4-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com
List-Id: linux-serial@vger.kernel.org

On Thursday 06 of June 2013 16:31:18 Chander Kashyap wrote:
> Instead of having to specify the number for CPUs in Exynos5250 in
> platsmp.c file, let the number of CPUs be determined by having this
> information listed in Exynos5250 device tree file.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |   14 ++++++++++++++
>  arch/arm/mach-exynos/platsmp.c    |   10 +++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi index e571d3b..7f6b1c7 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -50,6 +50,20 @@
>  		pinctrl3 = &pinctrl_3;
>  	};
> 
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a15";
> +			reg = <0>;
> +		};
> +		cpu@1 {
> +			compatible = "arm,cortex-a15";
> +			reg = <1>;
> +		};
> +	};
> +
>  	pd_gsc: gsc-power-domain@0x10044000 {
>  		compatible = "samsung,exynos4210-pd";
>  		reg = <0x10044000 0x20>;
> diff --git a/arch/arm/mach-exynos/platsmp.c
> b/arch/arm/mach-exynos/platsmp.c index 1a4e4e5..85ea4ca 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -180,10 +180,14 @@ static void __init exynos_smp_init_cpus(void)
>  	void __iomem *scu_base = scu_base_addr();
>  	unsigned int i, ncores;
> 
> -	if (soc_is_exynos5250())
> -		ncores = 2;
> -	else
> +	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>  		ncores = scu_base ? scu_get_core_count(scu_base) : 1;
> +	else
> +		/*
> +		 * CPU Nodes are passed thru DT and set_cpu_possible
> +		 * is set by "arm_dt_init_cpu_maps".
> +		 */
> +		return;
> 
>  	/* sanity check */
>  	if (ncores > nr_cpu_ids) {

Looks good. Same thing should be done for remaining Exynos SoCs as well.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
