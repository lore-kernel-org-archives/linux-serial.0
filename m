From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3 01/10] ARM: dts: fork out common Exynos5 nodes
Date: Mon, 17 Jun 2013 20:38:34 +0900
Message-ID: <1a0001ce6b4f$334cc260$99e64720$%kim@samsung.com>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
 <1371466836-4111-2-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22932 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711Ab3FQLig (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Jun 2013 07:38:36 -0400
In-reply-to: <1371466836-4111-2-git-send-email-chander.kashyap@linaro.org>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Chander Kashyap' <chander.kashyap@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com

Chander Kashyap wrote:
> 
> In preparation of adding support for Exynos5420, which has many
> peripherals
> similar to Exynos5250, a new common Exynos5 device tree source file is
> created out of the exising Exynos5250 device tree source file. Only the
> common nodes required for basic boot up on Exynos5420 based boards are
> moved
> into this new file and the rest of the common nodes would be moved
> subsequently.
> 
Yeah, most of exynos5250 is used in exynos5420. Since created exynos5.dtsi
cannot support exynos5440 so that would be helpful if you could add some
comments in git log and codes about that.

> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5.dtsi    |  111
> +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi |   68 +----------------------
>  2 files changed, 113 insertions(+), 66 deletions(-)
>  create mode 100644 arch/arm/boot/dts/exynos5.dtsi
> 
> diff --git a/arch/arm/boot/dts/exynos5.dtsi
> b/arch/arm/boot/dts/exynos5.dtsi
> new file mode 100644
> index 0000000..5684f89
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -0,0 +1,111 @@
> +/*
> + * Samsung's Exynos5 SoC series common device tree source
> + *
> + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Samsung's Exynos5 SoC series device nodes are listed in this file.
> Particular
> + * SoCs from Exynos5 series can include this file and provide values for
> SoCs
> + * specfic bindings.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "skeleton.dtsi"
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +
> +	chipid@10000000 {
> +		compatible = "samsung,exynos4210-chipid";
> +		reg = <0x10000000 0x100>;
> +	};
> +
> +	watchdog {
> +		compatible = "samsung,s3c2410-wdt";
> +		reg = <0x101D0000 0x100>;
> +		interrupts = <0 42 0>;
> +		status = "disabled";
> +	};

I think, you put them by the address order. But as you know, some of them
are different with exynos5250 and exynos5420. So alphabetical ordering would
be helpful after putting core part.
So, chipid, gic, combiner and alphabetical ordering IPs...

> +
> +	rtc {
> +		compatible = "samsung,s3c6410-rtc";
> +		reg = <0x101E0000 0x100>;
> +		interrupts = <0 43 0>, <0 44 0>;
> +		status = "disabled";
> +	};
> +
> +	combiner:interrupt-controller@10440000 {
> +		compatible = "samsung,exynos4210-combiner";
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		samsung,combiner-nr = <32>;
> +		reg = <0x10440000 0x1000>;
> +		interrupts =	<0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
> +				<0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
> +				<0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
> +				<0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
> +				<0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
> +				<0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
> +				<0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
> +				<0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
> +	};
> +
> +	gic:interrupt-controller@10481000 {
> +		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg =	<0x10481000 0x1000>,
> +			<0x10482000 0x1000>,
> +			<0x10484000 0x2000>,
> +			<0x10486000 0x2000>;
> +		interrupts = <1 9 0xf04>;
> +	};
> +
> +	dwmmc_0: dwmmc0@12200000 {
> +		compatible = "samsung,exynos5250-dw-mshc";
> +		interrupts = <0 75 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	dwmmc_1: dwmmc1@12210000 {
> +		compatible = "samsung,exynos5250-dw-mshc";
> +		interrupts = <0 76 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	dwmmc_2: dwmmc2@12220000 {
> +		compatible = "samsung,exynos5250-dw-mshc";
> +		interrupts = <0 77 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	serial@12C00000 {
> +		compatible = "samsung,exynos4210-uart";
> +		reg = <0x12C00000 0x100>;
> +		interrupts = <0 51 0>;
> +	};
> +
> +	serial@12C10000 {
> +		compatible = "samsung,exynos4210-uart";
> +		reg = <0x12C10000 0x100>;
> +		interrupts = <0 52 0>;
> +	};
> +
> +	serial@12C20000 {
> +		compatible = "samsung,exynos4210-uart";
> +		reg = <0x12C20000 0x100>;
> +		interrupts = <0 53 0>;
> +	};
> +
> +	serial@12C30000 {
> +		compatible = "samsung,exynos4210-uart";
> +		reg = <0x12C30000 0x100>;
> +		interrupts = <0 54 0>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index 0673524..2b59ea3 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -17,12 +17,11 @@
>   * published by the Free Software Foundation.
>  */
> 
> -/include/ "skeleton.dtsi"
> -/include/ "exynos5250-pinctrl.dtsi"
> +#include "exynos5.dtsi"
> +#include "exynos5250-pinctrl.dtsi"
> 
I remember, to use #include is in Padma's patch and I've applied in my
local. So don't change it and just adding inclusion exynos5 is enough.

Others look good to me.

Thanks,
- Kukjin

