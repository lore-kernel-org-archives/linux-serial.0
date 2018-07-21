From: Erin Lo <erin.lo@mediatek.com>
Subject: Re: [PATCH v3 0/4] Add basic support for Mediatek MT8183 SoC
Date: Sat, 21 Jul 2018 15:28:54 +0800
Message-ID: <1532158134.16009.10.camel@mtksdaap41>
References: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
 <9ba45353-a6e1-9a6e-f05b-4b1679ae9e52@gmail.com>
 <1532074769.19148.2.camel@mtksdaap41>
 <2ca76468-198b-b764-c974-374e567e0c93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2ca76468-198b-b764-c974-374e567e0c93@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, srv_heupstream <srv_heupstream@mediatek.com>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, mars.cheng@mediatek.com, linux-serial@vger.kernel.org, yingjoe.chen@mediatek.com, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2018-07-20 at 12:44 +0200, Matthias Brugger wrote:
> 
> On 20/07/18 10:19, Erin Lo wrote:
> > On Mon, 2018-07-16 at 11:28 +0200, Matthias Brugger wrote:
> >> Hi Erin,
> >>
> >> On 17/05/18 08:22, Erin Lo wrote:
> >>> MT8183 is a SoC based on 64bit ARMv8 architecture.
> >>> It contains 4 CA53 and 4 CA73 cores.
> >>> MT8183 share many HW IP with MT65xx series.
> >>> This patchset was tested on MT8183 evaluation board, and boot to shell ok.
> >>>
> >>> This series contains document bindings, device tree including interrupt, uart.
> >>>
> >>> Change in v3:
> >>> 1. Fill out GICC, GICH, GICV regions
> >>> 2. Update Copyright to 2018
> >>>
> >>> Change in v2:
> >>> 1. Split dt-bindings into different patches
> >>> 2. Correct bindings for supported SoCs (mtk-uart.txt)
> >>>
> >>> Ben Ho (1):
> >>>   arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
> >>>     Makefile
> >>>
> >>> Erin Lo (3):
> >>>   dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
> >>>   dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183
> >>>   dt-bindings: serial: Add compatible for Mediatek MT8183
> >>>
> >>
> >> I'm a bit reluctant to take this series, as it will only enable the EVB board to
> >> boot into a serial console. Are you planning to add support for other devices of
> >> this SoC?
> >>
> >> Apart please take into account that there is an issue with the dts file, as you
> >> were told by the kbuild test robot.
> >>
> >> Regards,
> >> Matthias
> >>
> > 
> > Hi, Matthias
> > Sorry for missing this letter...since mail proxy server.
> > We plan to add support all the devices of MT8183 in serious.
> > We have implemented the clock and pinctrl driver for upstream and they
> > are in internal review right now.
> > 
> 
> Nice to hear that :)
> 
> > About the dts issue... do you suggest me to send new patch right now or
> > wait for clock and pinctrl driver ready then send them together?
> > 
> 
> I would prefer that you send at least the clock controller together, so that we
> don't have any dummy clocks in the basic device tree.
> 
> Regards,
> Matthias
> 

Got it! Next patch, we will send them with clock controller without
dummy clocks in the basic device tree.
By the way, the clock controller driver of MT8183 is a little bit
different from former ICs, so we need more time to prepare them.
We will send them to public as soon as possible.

Best Regards,
Erin

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
