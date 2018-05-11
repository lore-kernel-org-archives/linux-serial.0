From: Erin Lo <erin.lo@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add bindings for Mediatek MT8183
 SoC Platform
Date: Fri, 11 May 2018 18:35:18 +0800
Message-ID: <1526034918.13828.8.camel@mtksdaap41>
References: <1526019083-20237-1-git-send-email-erin.lo@mediatek.com>
 <1526019083-20237-2-git-send-email-erin.lo@mediatek.com>
 <4a32814b-e905-74e8-ed5c-5e68f38faa28@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4a32814b-e905-74e8-ed5c-5e68f38faa28@gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2018-05-11 at 10:33 +0200, Matthias Brugger wrote:
> 
> On 05/11/2018 08:11 AM, Erin Lo wrote:
> > This adds dt-binding documentation for Mediatek MT8183.
> > Only include very basic items: cpu, gic and uart.
> > 
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek.txt                    | 4 ++++
> >  .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt      | 1 +
> >  Documentation/devicetree/bindings/serial/mtk-uart.txt                 | 1 +
> >  3 files changed, 6 insertions(+)
> > 
> 
> This touches different maintainers and the patches should go through their
> trees, so that no merge conflicts occur.
> I'm fine with take it through my tree but it's more work as we might need a
> stable branch that the other maintainers can merge. Apart I'd need the Acked-by
> from the maintainers.
> 
> I'm fine with either way.
> 

For prevent merge conflict and review convenient, I will split it into
different patches in next round.


> > diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> > index 7d21ab3..2754535 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> > @@ -19,6 +19,7 @@ compatible: Must contain one of
> >     "mediatek,mt8127"
> >     "mediatek,mt8135"
> >     "mediatek,mt8173"
> > +   "mediatek,mt8183"
> >  
> >  
> >  Supported boards:
> > @@ -73,3 +74,6 @@ Supported boards:
> >  - MTK mt8173 tablet EVB:
> >      Required root node properties:
> >        - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
> > +- Evaluation board for MT8183:
> > +    Required root node properties:
> > +      - compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> > index 07bf0b9..5ff48a8 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> > @@ -5,6 +5,7 @@ interrupt.
> >  
> >  Required properties:
> >  - compatible: should be
> > +	"mediatek,mt8183-sysirq", "mediatek,mt6577-sysirq": for MT8183
> >  	"mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq": for MT8173
> >  	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
> >  	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
> > diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> > index f73abff..6e6d168 100644
> > --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> > +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> > @@ -15,6 +15,7 @@ Required properties:
> >    * "mediatek,mt8127-uart" for MT8127 compatible UARTS
> >    * "mediatek,mt8135-uart" for MT8135 compatible UARTS
> >    * "mediatek,mt8173-uart" for MT8173 compatible UARTS
> > +  * "mediatek,mt8183-uart" for MT8183 compatible UARTS
> 
> If you add this compatible without a fallback that you will need an update in
> the driver. Is there really anything new in the serial console with regard to
> older devices?
> 
> Regards,
> Matthias
> 

No new function in MT8183..now
How about this...
 "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183 compatible
UARTS


Regards,
Erin

> >    * "mediatek,mt6577-uart" for MT6577 and all of the above
> >  
> >  - reg: The base address of the UART register bank.
> > 
