From: Erin Lo <erin.lo@mediatek.com>
Subject: Re: [PATCH 0/2] Add basic support for Mediatek MT8183 SoC
Date: Fri, 11 May 2018 17:38:26 +0800
Message-ID: <1526031506.24653.5.camel@mtksdaap41>
References: <1526019083-20237-1-git-send-email-erin.lo@mediatek.com>
         <782e13c1-057b-164b-9270-d37c151aa9b4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <782e13c1-057b-164b-9270-d37c151aa9b4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2018-05-11 at 10:29 +0200, Matthias Brugger wrote:
> Hi Erin,
> 
> Please include the linux-mediatek and arm-linux-kernel mailinglists in the next
> round.
> 
> Some comments in the patches.
> 
> Regards,
> Matthias

I will add linux-mediatek, linux-arm-kernel, linux-kernel, linux-serial
mailinglists in next round.
Thanks for your reminder.

Regards,
Erin

> 
> On 05/11/2018 08:11 AM, Erin Lo wrote:
> > MT8183 is a SoC based on 64bit ARMv8 architecture.
> > It contains 4 CA53 and 4 CA73 cores.
> > MT8183 share many HW IP with MT65xx series.
> > This patchset was tested on MT8183 evaluation board, and boot to shell ok.
> > 
> > This series contains document bindings, device tree including interrupt, uart.
> > 
> > Ben Ho (1):
> >   arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
> >     Makefile
> > 
> > Erin Lo (1):
> >   dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
> > 
> >  Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
> >  .../interrupt-controller/mediatek,sysirq.txt       |   1 +
> >  .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
> >  arch/arm64/boot/dts/mediatek/Makefile              |   1 +
> >  arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  31 ++++
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 178 +++++++++++++++++++++
> >  6 files changed, 216 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > 
> > --
> > 1.9.1
> > 
