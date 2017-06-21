From: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: Add Mediatek SoC MT2712 and
 evaluation board dts and Makefile
Date: Wed, 21 Jun 2017 19:01:06 +0800
Message-ID: <1498042866.2865.3.camel@mtksdaap41>
References: <1497620721-61444-1-git-send-email-yt.shen@mediatek.com>
         <1497620721-61444-3-git-send-email-yt.shen@mediatek.com>
         <d5509532-7ab6-c9ce-d951-4bcdcc1399ff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d5509532-7ab6-c9ce-d951-4bcdcc1399ff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mars Cheng <mars.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-06-16 at 16:33 +0200, Matthias Brugger wrote:
> 
> On 16/06/17 15:45, YT Shen wrote:
> > This adds basic chip support for Mediatek 2712
> > 
> > Signed-off-by: YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >   arch/arm64/boot/dts/mediatek/Makefile       |   1 +
> >   arch/arm64/boot/dts/mediatek/mt2712-evb.dts |  32 ++++++
> >   arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 166 ++++++++++++++++++++++++++++
> >   3 files changed, 199 insertions(+)
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
> > index 0000000..65cdd4a
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> > @@ -0,0 +1,166 @@
> [...]
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
> > +			clocks = <&uart_clk>;
> 
> uart has two clocks, baud and bus clock. Please refer to the bindings 
> descrption for more information, that's what they are for.
> 
> Please define the two dummy clocks with the correct frequency and use them.
> 
> Regards,
> Matthias
Okay, after checking
Documentation/devicetree/bindings/serial/mtk-uart.txt, I will use baud
and bus clock in the next version.

yt.shen

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
