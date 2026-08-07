Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13B3806CD;
	Fri,  7 Aug 2026 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083113; cv=none; b=apJF4gUfRYEat+XX54XbA8sOjYPqB/nVBth5Gpm1l9BzjWW8V26TUgVIHD25BMIOu9PKhEbUkCm+7VUSsYFKZkjJkFTbXBEBkM+Pe9z9ItcZc78NlgJmKAhGKSm97CkJPn5LKaz2/nmznwBCPJmlR7/D5cDmRFvx2YJCmqddGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083113; c=relaxed/simple;
	bh=b9mBsccD7rOQIONlGmoxPFUFqc54BDYqcnsN6vzrxnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAsi8HkojSBcnsLkOLPOoXCcVlZjwYUnilllg4WQBlbUUCxfvsTzLsGDazcSZch0McPTswRcKlKNdNPBbs6NVbqw1BwJh6vwMMarEJuOAiIDqDDa5q4o6B2B8L6HewpVtGdXkLgEFcjUhAHq/PIC3KuHfWZjObQuoZ33E9+uqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld6kM4EJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld6kM4EJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31941F000E9;
	Fri,  7 Aug 2026 06:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786083111;
	bh=J55er94G0k2ICmgS4qCQzJyyM6SJf2ITEtdKlk7xk1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ld6kM4EJL/jbavAxures/BJEH/xVioaUFTnxOKr2QBej07NnqTV7x3/gPiqzCO7VV
	 kavhQP5qs2uNetzRvXZBKXs1NuDixGoUNvouLE40hyGDGY1CnnNIlGzi1b82irSbw/
	 nKO9yDC6tgbSg4OC0+XAvL49WSGMBpiAZut4dyujhfT83oRtKlms5rRa6OEWE7UHPU
	 QvZoIF/jZRxD8WWXeT9bS0RMKbFkvMw9I0CrIA4DA3xxyD7WN8Nm/G1+RWB7n6Nqw3
	 /px28I0NpOXBT616KSt3pNcQtcR+Oahz7aX1iZXmLlCaPPSHBJ4r/WNFZoee2Ec5aN
	 nqf18OW8Pfjdw==
Date: Fri, 7 Aug 2026 08:11:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Long Zhao <longzhao@ambarella.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, soc@lists.linux.dev
Subject: Re: [PATCH v2 09/10] arm64: ambarella: add ARCH_AMBARELLA and CV75
 EVK DT
Message-ID: <20260807-caped-steady-earwig-adf6d4@quoll>
References: <20260806-longzhao-upstream-cv75-v2-v2-0-6b09707c5fe9@ambarella.com>
 <20260806-longzhao-upstream-cv75-v2-v2-9-6b09707c5fe9@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806-longzhao-upstream-cv75-v2-v2-9-6b09707c5fe9@ambarella.com>

On Thu, Aug 06, 2026 at 05:34:17PM +0800, Long Zhao wrote:
> Enable the Ambarella ARMv8 platform Kconfig, add the CV75 SoC and
> EVK device trees, and select the Ambarella UART in the arm64
> defconfig for console bring-up.

Subject - missing dts prefix. Please do not come with your own style.
It's for example: arm64: dts: ambarella:


> 
> Signed-off-by: Long Zhao <longzhao@ambarella.com>
> ---
>  arch/arm64/Kconfig.platforms               |   9 ++
>  arch/arm64/boot/dts/Makefile               |   1 +
>  arch/arm64/boot/dts/ambarella/Makefile     |   3 +
>  arch/arm64/boot/dts/ambarella/cv75-evk.dts |  30 ++++++
>  arch/arm64/boot/dts/ambarella/cv75.dtsi    | 166 +++++++++++++++++++++++++++++
>  arch/arm64/configs/defconfig               |   3 +
>  6 files changed, 212 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index d2acfac73003..166430ddb3c9 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -26,6 +26,15 @@ config ARCH_SUNXI
>  	help
>  	  This enables support for Allwinner sunxi based SoCs like the A64.
>  
> +config ARCH_AMBARELLA
> +	bool "Ambarella SoC family"
> +	select ARM_PSCI
> +	select HAVE_ARM_ARCH_TIMER
> +	select PINCTRL
> +	select PINCTRL_AMB
> +	help
> +	  This enables support for the ARM64 based Ambarella SoCs like CV75.
> +
>  config ARCH_ALPINE
>  	bool "Annapurna Labs Alpine platform"
>  	select ALPINE_MSI if PCI
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index fc726b215f12..f1709eb5d915 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -4,6 +4,7 @@ subdir-y += airoha
>  subdir-y += allwinner
>  subdir-y += altera
>  subdir-y += amazon
> +subdir-y += ambarella
>  subdir-y += amd
>  subdir-y += amlogic
>  subdir-y += apm
> diff --git a/arch/arm64/boot/dts/ambarella/Makefile b/arch/arm64/boot/dts/ambarella/Makefile
> new file mode 100644
> index 000000000000..ddca3d7b18cc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ambarella/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +dtb-$(CONFIG_ARCH_AMBARELLA) += cv75-evk.dtb
> diff --git a/arch/arm64/boot/dts/ambarella/cv75-evk.dts b/arch/arm64/boot/dts/ambarella/cv75-evk.dts
> new file mode 100644
> index 000000000000..42a0fe24b83b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ambarella/cv75-evk.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Ambarella CV75 EVK board
> + */
> +
> +/dts-v1/;
> +
> +#include "cv75.dtsi"
> +
> +/ {
> +	model = "Ambarella CV75 EVK Board";
> +	compatible = "ambarella,cv75-evk", "ambarella,cv75";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart0;
> +	};
> +
> +	memory@200000 {
> +		device_type = "memory";
> +		reg = <0x0 0x00200000 0x0 0x07e00000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/ambarella/cv75.dtsi b/arch/arm64/boot/dts/ambarella/cv75.dtsi
> new file mode 100644
> index 000000000000..825b773f052f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ambarella/cv75.dtsi
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Ambarella CV75 SoC
> + *
> + * Boot peripheral: UART0 console.
> + * Clocks: a single ambarella,cv75-rct provider.
> + */
> +
> +#include <dt-bindings/clock/ambarella,cv75-clock.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "ambarella,cv75";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	osc: oscillator {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-output-names = "osc";
> +		clock-frequency = <24000000>;
> +	};
> +
> +	psci {

This looks randomly ordered.

Please follow DTS coding style.


> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a76";
> +			device_type = "cpu";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu@1 {
> +			compatible = "arm,cortex-a76";
> +			device_type = "cpu";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	gic: interrupt-controller@fff0101000 {

This cannot be here, it's MMIO node, you have dtbs check warnings
likely. Just look at any other file how it is done.

Please confirm that you have run dtbs_check W=1 and you fixed all the
warnings.

> +		compatible = "arm,gic-400";
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		#size-cells = <1>;
> +		interrupt-controller;
> +		reg = <0xff 0xf0101000 0x0 0x1000>,
> +		      <0xff 0xf0102000 0x0 0x2000>,
> +		      <0xff 0xf0104000 0x0 0x2000>,
> +		      <0xff 0xf0106000 0x0 0x2000>;
> +		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* Clock provider and shared system registers. */
> +		rct: clock-controller@ffed080000 {
> +			compatible = "ambarella,cv75-rct", "syscon";
> +			reg = <0xff 0xed080000 0x0 0x1000>;
> +			clocks = <&osc>;
> +			clock-names = "osc";
> +			#clock-cells = <1>;
> +
> +			assigned-clocks = <&rct CV75_GCLK_UART0>;
> +			assigned-clock-parents = <&osc>;
> +			assigned-clock-rates = <24000000>;
> +		};
> +
> +		apb@ffe4000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0xff 0xe4000000 0x0 0x01000000>;
> +			ranges = <0xe4000000 0xff 0xe4000000 0x01000000>;

You need to read DTS coding style.

Best regards,
Krzysztof

