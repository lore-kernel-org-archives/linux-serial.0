From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: dma: uart: add uart dma bindings
Date: Mon, 27 Feb 2017 09:22:26 -0600
Message-ID: <20170227152226.g4zokauxii2nuyxn@rob-hp-laptop>
References: <1487243251-964-1-git-send-email-long.cheng@mediatek.com>
 <1487243251-964-2-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1487243251-964-2-git-send-email-long.cheng@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Long Cheng <long.cheng@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 16, 2017 at 07:07:28PM +0800, Long Cheng wrote:
> add uart dma bindings

This and the subject need to be more specific in that this is for 
Mediatek.

> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/dma/mtk_uart_dma.txt       |   32 ++++++++++++++++++++

mediatek,uart-dma.txt for filename.

>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk_uart_dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/mtk_uart_dma.txt b/Documentation/devicetree/bindings/dma/mtk_uart_dma.txt
> new file mode 100644
> index 0000000..b8aa7f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk_uart_dma.txt
> @@ -0,0 +1,32 @@
> +* Mediatek UART APDMA Controller

Is the block really for UARTs only or just happens to be connected to 
UARTs. For the latter, you should drop UART here and in the compatible.

> +
> +Required properties:
> +- compatible should contain:
> +  * "mediatek,mt2701-uart-dma" for MT2701 compatible APDMA
> +  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
> +
> +- reg: The base address of the APDMA register bank.
> +
> +- interrupts: A single interrupt specifier.
> +
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: The APDMA clock for register accesses

Needs to list "apdma" here. Is apdma really the right name here? It 
should be the name of the input to this block.

> +
> +Examples:
> +
> +	apdma: dma-controller@11000380 {
> +		compatible = "mediatek,mt2701-uart-dma";
> +		reg = <0 0x11000380 0 0x400>;
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
> -- 
> 1.7.9.5
> 
