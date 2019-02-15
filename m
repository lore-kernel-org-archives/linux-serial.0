From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: mtk-sysirq: Add compatible for
 Mediatek MT8183
Date: Fri, 15 Feb 2019 11:08:06 +0100
Message-ID: <931a6082-e86c-1220-ac84-61fea5815e94@gmail.com>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-2-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550210558-30516-2-git-send-email-erin.lo@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Erin Lo <erin.lo@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 15/02/2019 07:02, Erin Lo wrote:
> This adds dt-binding documentation of SYSIRQ for Mediatek MT8183 SoC
> Platform.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

now queued in v5.1-next/dts64

>  .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> index 33a98eb..91aa9ab 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
> @@ -5,6 +5,7 @@ interrupt.
>  
>  Required properties:
>  - compatible: should be
> +	"mediatek,mt8183-sysirq", "mediatek,mt6577-sysirq": for MT8183
>  	"mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq": for MT8173
>  	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
>  	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
> 
