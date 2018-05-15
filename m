From: Erin Lo <erin.lo@mediatek.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
Date: Tue, 15 May 2018 16:39:31 +0800
Message-ID: <1526373571.3345.3.camel@mtksdaap41>
References: <1526293351-32794-1-git-send-email-erin.lo@mediatek.com>
         <1526293351-32794-5-git-send-email-erin.lo@mediatek.com>
         <efa91778-e81f-9ba4-22a6-43ff0f94af4f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <efa91778-e81f-9ba4-22a6-43ff0f94af4f@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, mars.cheng@mediatek.com, Ben Ho <Ben.Ho@mediatek.com>, Hailong Fan <Hailong.Fan@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On Mon, 2018-05-14 at 11:35 +0100, Marc Zyngier wrote:
> On 14/05/18 11:22, Erin Lo wrote:
> > From: Ben Ho <Ben.Ho@mediatek.com>
> > 
> > Add basic chip support for Mediatek 8183
> > 
> > Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
> >  arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  31 +++++
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 178 ++++++++++++++++++++++++++++
> >  3 files changed, 210 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > 
> 
> [...]
> 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > new file mode 100644
> > index 0000000..8564a26
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> 
> [...]
> 
> > +	gic: interrupt-controller@0c000000 {
> > +		compatible = "arm,gic-v3";
> > +		#interrupt-cells = <3>;
> > +		interrupt-parent = <&gic>;
> > +		interrupt-controller;
> > +		reg = <0 0x0c000000 0 0x40000>,  // CID
> > +		      <0 0x0c100000 0 0x200000>; // CIR
> 
> You're missing the GICV and GICH regions that are present on both A53
> and A73 at an offset from PERIPHBASE.
> 
> > +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> 
> Thanks,
> 
> 	M.

I will fill out the GICV and GICH in next round.
Thanks.

Regards,
Erin
