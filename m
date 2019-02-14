From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v10 3/3] dt-bindings: dma: uart: rename binding
Date: Thu, 14 Feb 2019 11:13:09 +0100
Message-ID: <f16c7833-71cd-c43f-392e-a18b9fef177d@gmail.com>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-4-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547781016-890-4-git-send-email-long.cheng@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Long Cheng <long.cheng@mediatek.com>, Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>, Zhenbao Liu <zhenbao.liu@mediatek.com>
List-Id: linux-serial@vger.kernel.org



On 18/01/2019 04:10, Long Cheng wrote:
> The filename matches mtk-uart-apdma.c.
> So using "mtk-uart-apdma.txt" should be better.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 --------------------
>  .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   33 ++++++++++++++++++++
>  2 files changed, 33 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt b/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
> deleted file mode 100644
> index 3fe0961..0000000
> --- a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -* Mediatek UART APDMA Controller
> -
> -Required properties:
> -- compatible should contain:
> -  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
> -  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
> -
> -- reg: The base address of the APDMA register bank.> -
> -- interrupts: A single interrupt specifier.

One interrupt per dma-request, or 8 if no dma-requests property is present.

> -
> -- clocks : Must contain an entry for each entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names: The APDMA clock for register accesses> -
> -Examples:
> -
> -	apdma: dma-controller@11000380 {
> -		compatible = "mediatek,mt2712-uart-dma";
> -		reg = <0 0x11000380 0 0x400>;
> -		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 65 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 66 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 69 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&pericfg CLK_PERI_AP_DMA>;
> -		clock-names = "apdma";
> -		#dma-cells = <1>;
> -	};
> -
> diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> new file mode 100644
> index 0000000..3fe0961
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> @@ -0,0 +1,33 @@
> +* Mediatek UART APDMA Controller
> +
> +Required properties:
> +- compatible should contain:
> +  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
> +  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
> +
> +- reg: The base address of the APDMA register bank.
> +

There is one address needed for every dma-request or 8 if dma-requests property
is not present. As already mentioned in the driver review dma-requests property
is missing.

> +- interrupts: A single interrupt specifier.
> +
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: The APDMA clock for register accesses
> +

Missing option property dma-33bits (should be mtk,dma-33bits?).

> +Examples:
> +
> +	apdma: dma-controller@11000380 {
> +		compatible = "mediatek,mt2712-uart-dma";
> +		reg = <0 0x11000380 0 0x400>;

We are missing the io mem areas here, right?

Regards,
Matthias

> +		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 65 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 66 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 69 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_AP_DMA>;
> +		clock-names = "apdma";
> +		#dma-cells = <1>;
> +	};
> +
> 
