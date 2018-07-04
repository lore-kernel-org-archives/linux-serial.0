From: Mars Cheng <mars.cheng@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mediatek: Add bindings for mediatek
 MT6765 Platform
Date: Wed, 4 Jul 2018 08:24:01 +0800
Message-ID: <1530663841.28949.0.camel@mtkswgap22>
References: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
         <1529978646-28976-2-git-send-email-mars.cheng@mediatek.com>
         <20180703221101.GA6829@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703221101.GA6829@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, Miles Chen <miles.chen@mediatek.com>, Jades Shih <jades.shih@mediatek.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, My Chuang <my.chuang@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Rob

On Tue, 2018-07-03 at 16:11 -0600, Rob Herring wrote:
> On Tue, Jun 26, 2018 at 10:04:05AM +0800, Mars Cheng wrote:
> > This adds dt-binding documentation for Mediatek MT6765. Only
> > include very basic items, gic, uart timer and cpu.
> > 
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
> >  .../interrupt-controller/mediatek,sysirq.txt       |    1 +
> >  .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
> 
> These can all go thru different trees, so should be split.
> 

Got it, will split them.

> >  3 files changed, 6 insertions(+)
