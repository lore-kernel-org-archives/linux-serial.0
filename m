From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: arm: Add bindings for Mediatek MT8183
 SoC Platform
Date: Thu, 7 Feb 2019 16:15:16 +0100
Message-ID: <4ece8d53-e803-97d3-6f5e-5c3002a31cf1@gmail.com>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-3-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1548317240-44682-3-git-send-email-erin.lo@mediatek.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Erin Lo <erin.lo@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, mars.cheng@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On 24/01/2019 09:07, Erin Lo wrote:
> This adds dt-binding documentation of cpu for Mediatek MT8183.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

pushed to v5.0-next/dts64

Thanks,
Matthias

> ---
>  Documentation/devicetree/bindings/arm/mediatek.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
> index 8f260e5..f6d6ed3 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek.txt
> @@ -20,6 +20,7 @@ compatible: Must contain one of
>     "mediatek,mt8127"
>     "mediatek,mt8135"
>     "mediatek,mt8173"
> +   "mediatek,mt8183"
>  
>  
>  Supported boards:
> @@ -77,3 +78,6 @@ Supported boards:
>  - MTK mt8173 tablet EVB:
>      Required root node properties:
>        - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
> +- Evaluation board for MT8183:
> +    Required root node properties:
> +      - compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
> 
