From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: Add Mediatek SoC MT2712 and evaluation
 board dts and Makefile
Date: Wed, 31 May 2017 13:38:26 +0100
Message-ID: <d1be42ad-0b79-8487-1590-711b0e86d2ca@arm.com>
References: <1496230773-22633-1-git-send-email-yt.shen@mediatek.com>
 <1496230773-22633-3-git-send-email-yt.shen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1496230773-22633-3-git-send-email-yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 31/05/17 12:39, YT Shen wrote:
> This adds basic chip support for Mediatek 2712
> 
> Signed-off-by: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt2712-evb.dts |  39 +++++++
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 166 ++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 9fbfd32..fcc0604 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -1,3 +1,4 @@
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> new file mode 100644
> index 0000000..e526c0f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (c) 2017 MediaTek Inc.
> + * Author: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> + *
> + * SPDX-License-Identifier: (GPL-2.0 OR MIT)
> + */
> +
> +/dts-v1/;
> +#include "mt2712e.dtsi"
> +
> +/ {
> +	model = "MediaTek MT2712 evaluation board";
> +	compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +		linux,initrd-start = <0x45000000>;
> +		linux,initrd-end   = <0x4a000000>;
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> new file mode 100644
> index 0000000..6df0da9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -0,0 +1,166 @@
> +/*
> + * Copyright (c) 2017 MediaTek Inc.
> + * Author: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> + *
> + * SPDX-License-Identifier: (GPL-2.0 OR MIT)
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "mediatek,mt2712";
> +	interrupt-parent = <&sysirq>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu2>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x000>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x001>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	uart_clk: dummy26m {
> +		compatible = "fixed-clock";
> +		clock-frequency = <26000000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13
> +			      (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,

Why 6? I only count 3 cores...

> +			     <GIC_PPI 14
> +			      (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11
> +			      (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10
> +			      (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		uart5: serial@1000f000 {
> +			compatible = "mediatek,mt2712-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x1000f000 0 0x400>;
> +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&uart_clk>;
> +			status = "disabled";
> +		};
> +
> +		sysirq: interrupt-controller@10220a80 {
> +			compatible = "mediatek,mt2712-sysirq",
> +				     "mediatek,mt6577-sysirq";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			reg = <0 0x10220a80 0 0x40>;
> +		};
> +
> +		gic: interrupt-controller@10510000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x10510000 0 0x1000>,
> +			      <0 0x10520000 0 0x1000>,

If that's truly a GIC400, then the above is wrong (the CPU interface is
spread over 8kB).

I also suspect that the first 4kB are aliased over
0x10520000:0x1052f000, and the second over 0x10530000:0x1053f000 (in the
true SBSA tradition). If that's the case, then the size is actually 128kB.

> +			      <0 0x10540000 0 0x2000>,
> +			      <0 0x10560000 0 0x2000>;

Please check GICV as well, which probably behaves the same way.

> +			interrupts = <GIC_PPI 9
> +				(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;

Same thing here with 6 CPUs.

> +		};
> +
> +		uart0: serial@11002000 {
> +			compatible = "mediatek,mt2712-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11002000 0 0x400>;
> +			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&uart_clk>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11003000 {
> +			compatible = "mediatek,mt2712-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11003000 0 0x400>;
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&uart_clk>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@11004000 {
> +			compatible = "mediatek,mt2712-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11004000 0 0x400>;
> +			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&uart_clk>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@11005000 {
> +			compatible = "mediatek,mt2712-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11005000 0 0x400>;
> +			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&uart_clk>;
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@11019000 {
> +			compatible = "mediatek,mt2712-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11019000 0 0x400>;
> +			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_LOW>;
> +			clocks = <&uart_clk>;
> +			status = "disabled";
> +		};
> +	};
> +};
> +
> 

No PMU wired on this system?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
