From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 04/10] dt-bindings: ARM: Mediatek: Document bindings
 for MT8183
Date: Tue, 31 Jul 2018 13:22:12 -0600
Message-ID: <20180731192212.GA6510@rob-hp-laptop>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
 <1533015487-60189-5-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533015487-60189-5-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Erin Lo <erin.lo@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 31, 2018 at 01:38:01PM +0800, Erin Lo wrote:
> From: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> This patch adds the binding documentation for apmixedsys, audiosys,
> camsys, imgsys, infracfg, mfgcfg, mmsys, topckgen, vdecsys, vencsys
> and ipu for Mediatek MT8183.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |  1 +
>  .../bindings/arm/mediatek/mediatek,audsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,camsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,infracfg.txt    |  1 +
>  .../bindings/arm/mediatek/mediatek,ipu.txt         | 43 ++++++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  1 +
>  .../bindings/arm/mediatek/mediatek,topckgen.txt    |  1 +
>  .../bindings/arm/mediatek/mediatek,vdecsys.txt     |  1 +
>  .../bindings/arm/mediatek/mediatek,vencsys.txt     |  1 +
>  11 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt

Reviewed-by: Rob Herring <robh@kernel.org>
