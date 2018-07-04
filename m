From: Mars Cheng <mars.cheng@mediatek.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: mediatek: add mt6765 support
Date: Wed, 4 Jul 2018 19:38:09 +0800
Message-ID: <1530704289.16183.6.camel@mtkswgap22>
References: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
         <1530669174-17623-5-git-send-email-mars.cheng@mediatek.com>
         <f482708c-ea5e-5d81-a176-d69be9ccdf63@arm.com>
         <1530690473.16183.3.camel@mtkswgap22>
         <304dc0a7-bcba-961c-40f4-b324ecc2d003@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <304dc0a7-bcba-961c-40f4-b324ecc2d003@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Marc

On Wed, 2018-07-04 at 08:59 +0100, Marc Zyngier wrote:
> On 04/07/18 08:47, Mars Cheng wrote:
> > Hi Marc
> > 
> > On Wed, 2018-07-04 at 08:35 +0100, Marc Zyngier wrote:
> >> On 04/07/18 02:52, Mars Cheng wrote:
> >>> This adds basic chip support for MT6765 SoC.
> >>>
> >>> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> >>> ---
> >>>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
> >>>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
> >>>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  155 +++++++++++++++++++++++++++
> >>>  3 files changed, 189 insertions(+)
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> >>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
> >>>
> >>
> >> [...]
> >>
> >>> +
> >>> +		gic: interrupt-controller@c000000 {
> >>> +			compatible = "arm,gic-v3";
> >>> +			#interrupt-cells = <3>;
> >>> +			#address-cells = <2>;
> >>> +			#size-cells = <2>;
> >>> +			#redistributor-regions = <1>;
> >>> +			interrupt-parent = <&gic>;
> >>> +			interrupt-controller;
> >>> +			reg = <0 0x0c000000 0 0x40000>, // distributor
> >>> +			      <0 0x0c100000 0 0x200000>, // redistributor
> >>> +			      <0 0x0c400000 0 0x40000>; // gicc
> >>
> >> For the second time: please add *all* the GIC CPU interface regions,
> >> described in the Cortex-A53 TRM[1] (GICC, GICH, and GICV).
> >>
> > 
> > MT6765 has no GICH/GICV/ITS in mediatek design. Have confirmed with our
> > designer.  
> 
> The only way *not* to have GICH or GICV is to assert GICCDISABLE on the
> CPU, in which case you don't have GICC either, nor any support for the
> GICv3 at all. So either the designer is wrong or the documentation is
> wrong. Which one is it, do you think?
> 
> As for the ITS, that's a perfectly optional part of the design, and not
> part of the CPU.
> 

Clarified with our designer. It is our misunderstanding for TRM.
GICV/GICH do exist. Will add them in v4 soon. And fix MT6797 in another
patch.

Thanks.

> > MT6797 had similar question from you. Sorry for not mentioned it first.
> > 
> > https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_linux-2Dmediatek_2017-2DFebruary_008074.html&d=DwICaQ&c=X9NHckmGz7LNQmqtvpDCYVnn6eFXNivfZeknqiAo-n0&r=Ph_SbcClVGRWmGxVhfr-5CZF9ffiUOE7TZ47ns4ROh4&m=iACLXUO5vXXZCPSvhbBKZFXy0bXdO8f4kbgy6RLi2QM&s=2N4qyy0aMytzNgObeyU4tvCDREX4U1x4oeNgvZwUxvM&e= 
> 
> Well, that's wrong too.
> 
> 	M.
