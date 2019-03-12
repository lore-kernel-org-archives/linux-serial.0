From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: serial: Add compatible for Mediatek
 MT8183
Date: Tue, 12 Mar 2019 15:41:57 +0100
Message-ID: <d824b15d-49b4-ef6c-779a-0c21c8c05d62@gmail.com>
References: <1552294472-32929-1-git-send-email-erin.lo@mediatek.com>
 <1552294472-32929-2-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552294472-32929-2-git-send-email-erin.lo@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Erin Lo <erin.lo@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, zhiyong.tao@mediatek.com, Mengqi.Zhang@mediatek.com
List-Id: linux-serial@vger.kernel.org



On 11/03/2019 09:54, Erin Lo wrote:
> This adds dt-binding documentation of uart for Mediatek MT8183 SoC
> Platform.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> index 742cb47..bcfb131 100644
> --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> @@ -16,6 +16,7 @@ Required properties:
>    * "mediatek,mt8127-uart" for MT8127 compatible UARTS
>    * "mediatek,mt8135-uart" for MT8135 compatible UARTS
>    * "mediatek,mt8173-uart" for MT8173 compatible UARTS
> +  * "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183 compatible UARTS
>    * "mediatek,mt6577-uart" for MT6577 and all of the above
>  
>  - reg: The base address of the UART register bank.
> 

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

Greg will you take this through your branch or do you prefer me to queue it?

Regards,
Matthias
