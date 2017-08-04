From: YT Shen <yt.shen@mediatek.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: Add Mediatek SoC MT2712 and
 evaluation board dts and Makefile
Date: Fri, 4 Aug 2017 19:49:23 +0800
Message-ID: <1501847363.27655.2.camel@mtksdaap41>
References: <1501241835-47849-1-git-send-email-yt.shen@mediatek.com>
         <1501241835-47849-3-git-send-email-yt.shen@mediatek.com>
         <1501577481.32089.3.camel@mtksdaap41>
         <85f5d713-a599-e4cc-f1b4-2e0dedf2797f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <85f5d713-a599-e4cc-f1b4-2e0dedf2797f@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, srv_heupstream@mediatek.com, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Mars Cheng <mars.cheng@mediatek.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mediatek@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2017-08-01 at 14:46 +0200, Matthias Brugger wrote:
> 
> On 08/01/2017 10:51 AM, Yingjoe Chen wrote:
> > On Fri, 2017-07-28 at 19:37 +0800, YT Shen wrote:
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> >> new file mode 100644
> >> index 0000000..1e135af
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> > 
> > <...>
> > 
> >> +	timer {
> >> +		compatible = "arm,armv8-timer";
> >> +		interrupt-parent = <&gic>;
> >> +		interrupts = <GIC_PPI 13
> >> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
> >> +			     <GIC_PPI 14
> >> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
> >> +			     <GIC_PPI 11
> >> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>,
> >> +			     <GIC_PPI 10
> >> +			      (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_LOW)>;
> >> +	};
> >> +
> >> +	soc {
> >> +		#address-cells = <2>;
> >> +		#size-cells = <2>;
> >> +		compatible = "simple-bus";
> >> +		ranges;
> > 
> > Matthias,
> > 
> > I notice this have soc node.
> > Do we need to get rid of it?
> > 
> 
> Good catch. Yes please get rid of it. We should avoid artificial bus nodes. As 
> soc is no real bus, we should get rid of it.

OK, we will remove the soc node and send a new version.
Thanks.

> 
> Thanks,
> Matthias
