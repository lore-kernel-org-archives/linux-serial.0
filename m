From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 10/13] ARM: dts: Add initial device tree support for Exynos5420
Date: Sat, 08 Jun 2013 04:38:03 -0700 (PDT)
Message-ID: <5641151.psa9JbBo0O@flatron>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org> <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:62968 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab3FHLiF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 8 Jun 2013 07:38:05 -0400
In-Reply-To: <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com

On Thursday 06 of June 2013 16:31:24 Chander Kashyap wrote:
> Add initial device tree nodes for Exynos5420 SoC and SMDK5420 board.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile                |    1 +
>  arch/arm/boot/dts/exynos5420-smdk5420.dts |   40 ++++++++++++
>  arch/arm/boot/dts/exynos5420.dtsi         |  101
> +++++++++++++++++++++++++++++ 3 files changed, 142 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos5420-smdk5420.dts
>  create mode 100644 arch/arm/boot/dts/exynos5420.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index cb31259..304ba4d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -56,6 +56,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>  	exynos5250-arndale.dtb \
>  	exynos5440-sd5v1.dtb \
>  	exynos5250-smdk5250.dtb \
> +	exynos5420-smdk5420.dtb \

Please keep the sorting order.

>  	exynos5250-snow.dtb \

Here is the correct place for exynos5440-*.

>  	exynos5440-ssdk5440.dtb
>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> b/arch/arm/boot/dts/exynos5420-smdk5420.dts new file mode 100644
> index 0000000..b14e775
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -0,0 +1,40 @@
> +/*
> + * SAMSUNG SMDK5420 board device tree source
> + *
> + * Copyright (c) 2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as +
> * published by the Free Software Foundation.
> +*/
> +
> +/dts-v1/;
> +/include/ "exynos5420.dtsi"

#include "exynos5420.dtsi"

> +
> +/ {
> +	model = "Samsung SMDK5420 board based on EXYNOS5420";
> +	compatible = "samsung,smdk5420", "samsung,exynos5420";
> +
> +	memory {
> +		reg =	<0x20000000 0x10000000
> +			 0x30000000 0x10000000
> +			 0x40000000 0x10000000
> +			 0x50000000 0x10000000
> +			 0x60000000 0x10000000
> +			 0x70000000 0x10000000
> +			 0x80000000 0x10000000
> +			 0x90000000 0x10000000>;
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
> index 0000000..577dfe5
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -0,0 +1,101 @@
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
> + * it under the terms of the GNU General Public License version 2 as +
> * published by the Free Software Foundation.
> +*/

nitpick: missing space to keep the alignment of stars

> +
> +/include/ "skeleton.dtsi"
> +/include/ "exynos5.dtsi"

#include and IMHO skeleton.dtsi should be already included from 
exynos5.dtsi.

> +/ {
> +	compatible = "samsung,exynos5420";
> +
> +	clock: clock-controller@0x10010000 {
> +		compatible = "samsung,exynos5420-clock";
> +		reg = <0x10010000 0x30000>;
> +		#clock-cells = <1>;
> +	};
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

Hmm. I don't remember seeing this property in CPU bindings, but maybe I'm 
missing something. Anyway this makes little sense, since on every board 
this frequency may be different. Not even saying about CPU frequency 
scaling that would change it.

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
> +	mct@101C0000 {
> +		compatible = "samsung,exynos4210-mct";
> +		reg = <0x101C0000 0x800>;
> +		interrupt-controller;
> +		#interrups-cells = <2>;
> +		interrupt-parent = <&mct_map>;
> +		interrupts =	<0 0>, <1 0>, <2 0>, <3 0>,
> +				<4 0>, <5 0>, <6 0>, <7 0>;
> +		clocks = <&clock 1>, <&clock 315>;
> +		clock-names = "fin_pll", "mct";
> +
> +		mct_map: mct-map {
> +			#interrupt-cells = <2>;

Why do you need 2 cells here, if second one is unused in the map and kept 
as 0?

> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map = <0x0 0 &combiner 23 3>,
> +					<0x1 0 &combiner 23 4>,
> +					<0x2 0 &combiner 25 2>,
> +					<0x3 0 &combiner 25 3>,
> +					<0x4 0 &gic 0 120 0>,
> +					<0x5 0 &gic 0 121 0>,
> +					<0x6 0 &gic 0 122 0>,
> +					<0x7 0 &gic 0 123 0>;

Having #interrupt-cells = <1> would allow to simplify the map to:

	interrupt-map = <0 &combiner 23 3>,
			<1 &combiner 23 4>,
			<2 &combiner 25 2>,
			<3 &combiner 25 3>,
			<4 &gic 0 120 0>,
			<5 &gic 0 121 0>,
			<6 &gic 0 122 0>,
			<7 &gic 0 123 0>;

and interrupt specifiers in mct node to:

	interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>;

> +		};
> +	};
> +
> +	serial@12C00000 {
> +		clocks = <&clock 257>, <&clock 128>;

This looks a bit awkward without the clock-names property here. See my 
comments to patch 03/13.

Best regards,
Tomasz

> +	};
> +
> +	serial@12C10000 {
> +		clocks = <&clock 258>, <&clock 129>;
> +	};
> +
> +	serial@12C20000 {
> +		clocks = <&clock 259>, <&clock 130>;
> +	};
> +
> +	serial@12C30000 {
> +		clocks = <&clock 260>, <&clock 131>;
> +	};
> +};
