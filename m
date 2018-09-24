From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: dma: uart: add uart dma bindings
Date: Mon, 24 Sep 2018 15:19:46 -0700
Message-ID: <5baa1b00.1c69fb81.efde0.46e6@mx.google.com>
References: <1537425673-18807-1-git-send-email-long.cheng@mediatek.com>
 <1537425673-18807-2-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1537425673-18807-2-git-send-email-long.cheng@mediatek.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, YT Shen <yt.shen@mediatek.com>, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Dan Williams <dan.j.williams@intel.com>, Ed Blake <ed.blake@sondrel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 20, 2018 at 02:41:10PM +0800, Long Cheng wrote:
> add uart dma bindings
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/dma/8250_mtk_dma.txt       |   32 ++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt b/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
> new file mode 100644
> index 0000000..b140cf4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
> @@ -0,0 +1,32 @@
> +* Mediatek UART APDMA Controller
> +
> +Required properties:
> +- compatible should contain:
> +  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
> +  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
> +
> +- reg: The base address of the APDMA register bank.
> +
> +- interrupts: A single interrupt specifier.
> +
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: The APDMA clock for register accesses
> +
> +Examples:
> +
> +	apdma: dma-controller@11000380 {
> +		compatible = "mediatek,mt2712-uart-dma";
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
> \ No newline at end of file

Please fix this.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
