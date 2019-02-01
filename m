From: Erin Lo <erin.lo@mediatek.com>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
Date: Fri, 1 Feb 2019 13:11:06 +0800
Message-ID: <1548997866.26127.4.camel@mtksdaap41>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
         <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
         <20190130162204.GA1521@bogus> <1548902050.23230.4.camel@mtksdaap41>
         <CAL_JsqL1vQCgbb2yLL2E4KTDZve1vus5bDX75HGiOu14X26q7w@mail.gmail.com>
         <1548992018.11367.8.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548992018.11367.8.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ben Ho <Ben.Ho@mediatek.com>, Mars Cheng <mars.cheng@mediatek.com>, Mengqi Zhang <Mengqi.Zhang@mediatek.com>, linux-clk <linux-clk@vger.kernel.org>, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, Marc Zyngier <marc.zyngier@arm.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Yingjoe Chen <yingjoe.chen@mediatek.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Seiya Wang <seiya.wang@mediatek.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Eddie Huang <eddie.huang@mediatek.com>, moderated list:ARM/FREESCALE IMX / MXC ARM ARC
List-Id: linux-serial@vger.kernel.org

Add back more people since mail server issue

On Fri, 2019-02-01 at 11:33 +0800, Erin Lo wrote:
> On Thu, 2019-01-31 at 15:10 -0600, Rob Herring wrote:
> > On Wed, Jan 30, 2019 at 8:34 PM Erin Lo <erin.lo@mediatek.com> wrote:
> > >
> > > On Wed, 2019-01-30 at 10:22 -0600, Rob Herring wrote:
> > > > On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> > > > > From: Ben Ho <Ben.Ho@mediatek.com>
> > > > >
> > > > > Add basic chip support for Mediatek 8183, include
> > > > > pinctrl file, uart node with correct uart clocks, pwrap device
> > > > >
> > > > > Add clock controller nodes, include topckgen, infracfg,
> > > > > apmixedsys and subsystem.
> > > > >
> > > > > Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> > > > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > > > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > > > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > > > Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> > > > > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > > > > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > > > > ---
> > > >
> > > >
> > > > > +   sysirq: intpol-controller@c530a80 {
> > > >
> > > > interrupt-controller@...
> > >
> > > I will modify it in next version.
> > > >
> > > >
> > > > Place all the MMIO peripherals under one or more simple-bus nodes.
> > > >
> > > > Rob
> > > >
> > >
> > > Do you mean need to add simple-bus like this?
> > 
> > Yes.
> 
> We remove soc because Matthias suggested it in former MTK SoC maybe in
> 2015 year.
> 
> We will add it back by your comment.
> 
> Thank you. 
> 
> Best Regards,
> Erin

Hi, Matthias,
Do you have any comment here?
Thanks

Best Regards,
Erin
> > 
> > >
> > > +   soc: soc {
> > > +                #address-cells = <0x1>;
> > > +                #size-cells = <0x1>;
> > > +                ranges = <0 0 0 0xffffffff>;
> > > +                compatible = "simple-bus";
> > >
> > >                 soc_data: soc_data@08000000 {
> > >                         compatible = "mediatek,mt8183-efuse",
> > >                                      "mediatek,efuse";
> > >                         reg = <0 0x08000000 0 0x0010>;
> > >                         #address-cells = <1>;
> > >                         #size-cells = <1>;
> > >                         status = "disabled";
> > >                 };
> > >
> > >                 gic: interrupt-controller@0c000000 {
> > >                         compatible = "arm,gic-v3";
> > >                         #interrupt-cells = <4>;
> > >
> > > Best Regards,
> > > Erin
> > >
> > > > _______________________________________________
> > > > Linux-mediatek mailing list
> > > > Linux-mediatek@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > >
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
