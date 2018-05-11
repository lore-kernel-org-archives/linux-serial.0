From: Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/2] arm64: dts: Add Mediatek SoC MT8183 and evaluation
 board dts and Makefile
Date: Fri, 11 May 2018 18:41:07 +0800
Message-ID: <1526035267.13828.13.camel@mtksdaap41>
References: <1526019083-20237-1-git-send-email-erin.lo@mediatek.com>
 <1526019083-20237-3-git-send-email-erin.lo@mediatek.com>
 <860cba8a-3af8-31d6-ec3f-81706d2d998b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <860cba8a-3af8-31d6-ec3f-81706d2d998b-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Ben Ho <Ben.Ho-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2018-05-11 at 10:36 +0200, Matthias Brugger wrote:
> 
> On 05/11/2018 08:11 AM, Erin Lo wrote:
> > From: Ben Ho <Ben.Ho-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > Add basic chip support for Mediatek 8183
> > 
> > Signed-off-by: Ben Ho <Ben.Ho-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
> >  arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  31 +++++
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 178 ++++++++++++++++++++++++++++
> >  3 files changed, 210 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> > index ac17f60..2836261 100644
> > --- a/arch/arm64/boot/dts/mediatek/Makefile
> > +++ b/arch/arm64/boot/dts/mediatek/Makefile
> > @@ -5,3 +5,4 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> >  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > new file mode 100644
> > index 0000000..9a3d6b7
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (c) 2017 MediaTek Inc.
> > + * Author: Ben Ho <ben.ho-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > + *	   Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt8183.dtsi"
> > +
> > +/ {
> > +	model = "MediaTek MT8183 evaluation board";
> > +	compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
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
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > new file mode 100644
> > index 0000000..8564a26
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -0,0 +1,178 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +/*
> > + * Copyright (c) 2017 MediaTek Inc.
> > + * Author: Ben Ho <ben.ho-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > + *	   Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > + */
> > +
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/ {
> > +	compatible = "mediatek,mt8183";
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
> > +				core2 {
> > +					cpu = <&cpu2>;
> > +				};
> > +				core3 {
> > +					cpu = <&cpu3>;
> > +				};
> > +			};
> > +
> > +			cluster1 {
> > +				core0 {
> > +					cpu = <&cpu4>;
> > +				};
> > +				core1 {
> > +					cpu = <&cpu5>;
> > +				};
> > +				core2 {
> > +					cpu = <&cpu6>;
> > +				};
> > +				core3 {
> > +					cpu = <&cpu7>;
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu0: cpu@000 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x000>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu1: cpu@001 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x001>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu2: cpu@002 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x002>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu3: cpu@003 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x003>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu4: cpu@100 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a73";
> > +			reg = <0x100>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu5: cpu@101 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a73";
> > +			reg = <0x101>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu6: cpu@102 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a73";
> > +			reg = <0x102>;
> > +			enable-method = "psci";
> > +		};
> > +
> > +		cpu7: cpu@103 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a73";
> > +			reg = <0x103>;
> > +			enable-method = "psci";
> > +		};
> > +	};
> > +
> > +	psci {
> > +		compatible      = "arm,psci-1.0";
> > +		method          = "smc";
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
> > +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +
> > +	gic: interrupt-controller@0c000000 {
> > +		compatible = "arm,gic-v3";
> > +		#interrupt-cells = <3>;
> > +		interrupt-parent = <&gic>;
> > +		interrupt-controller;
> > +		reg = <0 0x0c000000 0 0x40000>,  // CID
> > +		      <0 0x0c100000 0 0x200000>; // CIR
> > +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> > +	sysirq: intpol-controller@0c530a80 {
> > +		compatible = "mediatek,mt8183-sysirq",
> > +			     "mediatek,mt6577-sysirq";
> > +		interrupt-controller;
> > +		#interrupt-cells = <3>;
> > +		interrupt-parent = <&gic>;
> > +		reg = <0 0x0c530a80 0 0x50>;
> > +	};
> > +
> > +	uart0: serial@11002000 {
> > +		compatible = "mediatek,mt8183-uart",
> > +			     "mediatek,mt6577-uart";
> > +		reg = <0 0x11002000 0 0x1000>;
> > +		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&uart_clk>, <&uart_clk>;
> > +		clock-names = "baud", "bus";
> > +		status = "disabled";
> > +	};
> > +
> > +	uart1: serial@11003000 {
> > +		compatible = "mediatek,mt8183-uart",
> > +			     "mediatek,mt6577-uart";
> > +		reg = <0 0x11003000 0 0x1000>;
> > +		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&uart_clk>, <&uart_clk>;
> > +		clock-names = "baud", "bus";
> > +		status = "disabled";
> > +	};
> > +
> > +	uart2: serial@11004000 {
> > +		compatible = "mediatek,mt8183-uart",
> > +			     "mediatek,mt6577-uart";
> > +		reg = <0 0x11004000 0 0x1000>;
> > +		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&uart_clk>, <&uart_clk>;
> > +		clock-names = "baud", "bus";
> > +		status = "disabled";
> > +	};
> > +};
> > 
> 
> I wonder if there aren't any other devices which can be supported out of the box.
> I understand that for now we are missing the clock driver and the pinctrl
> driver. Are you planning to submit them in the near future?
> 
> I'm asking because I don't want to bloat the dts with boards that only can boot
> to an initramfs with a serial console. Especially if there is no HW + datasheet
> available for anyone in the community who wants to work on this.
> 
> Regards,
> Matthias
> 
> Regards,
> Matthias


We have implement clock and pinctrl driver these days, and plan to
submit them maybe next month.
After that we will submit other drivers of MT8183 continuously.

Regards,
Erin
