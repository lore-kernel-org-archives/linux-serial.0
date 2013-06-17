From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v3 07/10] ARM: dts: Add initial device tree support for
 Exynos5420
Date: Mon, 17 Jun 2013 13:44:17 +0200
Message-ID: <3228621.2EHTYISgy0@amdc1227>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
 <1371466836-4111-8-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1371466836-4111-8-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com
List-Id: linux-serial@vger.kernel.org

-- 
Tomasz Figa
Linux Kernel Developer
Samsung R&D Institute Poland
Samsung Electronics

On Monday 17 of June 2013 16:30:32 Chander Kashyap wrote:
> Add initial device tree nodes for Exynos5420 SoC and SMDK5420 board.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile                |    1 +
>  arch/arm/boot/dts/exynos5420-smdk5420.dts |   33 +++++++++
>  arch/arm/boot/dts/exynos5420.dtsi         |  103
> +++++++++++++++++++++++++++++ 3 files changed, 137 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos5420-smdk5420.dts
>  create mode 100644 arch/arm/boot/dts/exynos5420.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f0895c5..5efa7e0 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>  	exynos5440-sd5v1.dtb \
>  	exynos5250-smdk5250.dtb \
>  	exynos5250-snow.dtb \
> +	exynos5420-smdk5420.dtb \
>  	exynos5440-ssdk5440.dtb
>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
>  	ecx-2000.dtb
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> b/arch/arm/boot/dts/exynos5420-smdk5420.dts new file mode 100644
> index 0000000..d14ece5
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -0,0 +1,33 @@
> +/*
> + * SAMSUNG SMDK5420 board device tree source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +/dts-v1/;
> +#include "exynos5420.dtsi"
> +
> +/ {
> +	model = "Samsung SMDK5420 board based on EXYNOS5420";
> +	compatible = "samsung,smdk5420", "samsung,exynos5420";
> +
> +	memory {
> +		reg =	<0x20000000 0x80000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttySAC2,115200 init=/linuxrc";
> +	};
> +
> +	fixed-rate-clocks {
> +		oscclk {
> +			compatible = "samsung,exynos5420-oscclk";
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi new file mode 100644
> index 0000000..e865be5
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -0,0 +1,103 @@
> +/*
> + * SAMSUNG EXYNOS5420 SoC device tree source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * SAMSUNG EXYNOS54200 SoC device nodes are listed in this file.
> + * EXYNOS5420 based board files can include this file and provide
> + * values for board specfic bindings.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "exynos5.dtsi"
> +/ {
> +	compatible = "samsung,exynos5420";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <0x0>;
> +			clock-frequency = <800000000>;

It is the only frequency at which this SoC can run? What code does actually 
use this property? Can't this frequency be read by calling clk_get_rate() on 
armclk?

Otherwise looks good:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz

> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <0x1>;
> +			clock-frequency = <800000000>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <0x2>;
> +			clock-frequency = <800000000>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <0x3>;
> +			clock-frequency = <800000000>;
> +		};
> +	};
> +
> +	clock: clock-controller@0x10010000 {
> +		compatible = "samsung,exynos5420-clock";
> +		reg = <0x10010000 0x30000>;
> +		#clock-cells = <1>;
> +	};
> +
> +	mct@101C0000 {
> +		compatible = "samsung,exynos4210-mct";
> +		reg = <0x101C0000 0x800>;
> +		interrupt-controller;
> +		#interrups-cells = <1>;
> +		interrupt-parent = <&mct_map>;
> +		interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>;
> +		clocks = <&clock 1>, <&clock 315>;
> +		clock-names = "fin_pll", "mct";
> +
> +		mct_map: mct-map {
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map = <0 &combiner 23 3>,
> +					<1 &combiner 23 4>,
> +					<2 &combiner 25 2>,
> +					<3 &combiner 25 3>,
> +					<4 &gic 0 120 0>,
> +					<5 &gic 0 121 0>,
> +					<6 &gic 0 122 0>,
> +					<7 &gic 0 123 0>;
> +		};
> +	};
> +
> +	serial@12C00000 {
> +		clocks = <&clock 257>, <&clock 128>;
> +		clock-names = "uart", "clk_uart_baud0";
> +	};
> +
> +	serial@12C10000 {
> +		clocks = <&clock 258>, <&clock 129>;
> +		clock-names = "uart", "clk_uart_baud0";
> +	};
> +
> +	serial@12C20000 {
> +		clocks = <&clock 259>, <&clock 130>;
> +		clock-names = "uart", "clk_uart_baud0";
> +	};
> +
> +	serial@12C30000 {
> +		clocks = <&clock 260>, <&clock 131>;
> +		clock-names = "uart", "clk_uart_baud0";
> +	};
> +};
