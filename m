From: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: Add Mediatek SoC MT2712 and
 evaluation board dts and Makefile
Date: Wed, 19 Jul 2017 14:48:04 +0800
Message-ID: <1500446884.14021.12.camel@mtksdaap41>
References: <1498123975-9748-1-git-send-email-yt.shen@mediatek.com>
         <1498123975-9748-3-git-send-email-yt.shen@mediatek.com>
         <ddfb5e58-520f-1ef5-2351-d7545e17a429@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ddfb5e58-520f-1ef5-2351-d7545e17a429-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2017-07-18 at 18:29 +0200, Matthias Brugger wrote:
> 
> On 06/22/2017 11:32 AM, YT Shen wrote:
> > This adds basic chip support for Mediatek 2712
> > 
> > Signed-off-by: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
> >   arch/arm64/boot/dts/mediatek/mt2712-evb.dts |  32 ++++++
> >   arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 172 ++++++++++++++++++++++++++++
> >   3 files changed, 205 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> > index 9fbfd32..fcc0604 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -1,3 +1,4 @@
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
> >   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> > diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> > new file mode 100644
> > index 0000000..8c804df
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
> > @@ -0,0 +1,32 @@
> > +/*
> > + * Copyright (c) 2017 MediaTek Inc.
> > + * Author: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt2712e.dtsi"
> > +
> > +/ {
> > +	model = "MediaTek MT2712 evaluation board";
> > +	compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +	};
> > +
> > +	memory@40000000 {
> > +		device_type = "memory";
> > +		reg = <0 0x40000000 0 0x80000000>;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:921600n8";
> > +	};
> > +};
> > +
> > +&uart0 {
> > +	status = "okay";
> > +};
> > +
> > diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> > new file mode 100644
> > index 0000000..461ee0f
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> > @@ -0,0 +1,172 @@
> > +/*
> > + * Copyright (c) 2017 MediaTek Inc.
> > + * Author: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +	compatible = "mediatek,mt2712";
> > +	interrupt-parent = <&sysirq>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu-map {
> > +			cluster0 {
> > +				core0 {
> > +					cpu = <&cpu0>;
> > +				};
> > +				core1 {
> > +					cpu = <&cpu1>;
> > +				};
> > +			};
> > +
> > +			cluster1 {
> > +				core0 {
> > +					cpu = <&cpu2>;
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu0: cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a35";
> > +			reg = <0x000>;
> > +		};
> > +
> > +		cpu1: cpu@1 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a35";
> > +			reg = <0x001>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu2: cpu@200 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a72";
> > +			reg = <0x200>;
> > +			enable-method = "psci";
> > +		};
> > +	};
> > +
> > +	psci {
> > +		compatible = "arm,psci-0.2";
> > +		method = "smc";
> > +	};
> > +
> > +	uart_clk: dummy26m {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <26000000>;
> > +		#clock-cells = <0>;
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <GIC_PPI 13
> > +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 14
> > +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 11
> > +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
> > +			     <GIC_PPI 10
> > +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>;
> > +	};
> > +
> > +	soc {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		compatible = "simple-bus";
> > +		ranges;
> > +
> > +		uart5: serial@1000f000 {
> > +			compatible = "mediatek,mt2712-uart",
> > +				     "mediatek,mt6577-uart";
> > +			reg = <0 0x1000f000 0 0x400>;
> > +			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> > +			clocks = <&uart_clk>, <&uart_clk>;
> > +			clock-names = "baud", "bus";
> > +			status = "disabled";
> > +		};
> 
> So baud and bus clock are both 26 MHz?
We didn't have CCF clock support in this series.
After we have clock source support, we could use the correct clocks to
the UARTs and drop the 26MHz fixed rate UART clock.

The bus clock is 26MHz.  The baud clock could be from another clock
source, using the same 26MHz fixed clock works also.


[1] https://patchwork.kernel.org/patch/9670877/
[2] https://patchwork.kernel.org/patch/6436021/

> Regards,
> Matthias


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
