From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH v5 2/2] arm: dts: mt2712: add uart APDMA to device tree
Date: Thu, 13 Dec 2018 14:18:07 +0800
Message-ID: <1544681887.32198.1.camel@mtksdaap41>
References: <1544506645-27979-1-git-send-email-long.cheng@mediatek.com>
         <1544506645-27979-3-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544506645-27979-3-git-send-email-long.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Long Cheng <long.cheng@mediatek.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, Sean Wang <sean.wang@kernel.org>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, YT Shen <yt.shen@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2018-12-11 at 13:37 +0800, Long Cheng wrote:
> 1. add uart APDMA controller device node
> 2. add uart 0/1/2/3/4/5 DMA function
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   50 +++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index 976d92a..a59728b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -300,6 +300,9 @@
>  		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
>  		clocks = <&baud_clk>, <&sys_clk>;
>  		clock-names = "baud", "bus";
> +		dmas = <&apdma 10
> +			&apdma 11>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};
>  
> @@ -378,6 +381,38 @@
>  		status = "disabled";
>  	};
>  
> +	apdma: dma-controller@11000400 {
> +		compatible = "mediatek,mt2712-uart-dma",
> +			     "mediatek,mt6577-uart-dma";

Sorting, please make sure this is before 

        auxadc: adc@11001000 {


> +		reg = <0 0x11000400 0 0x80>,
> +		      <0 0x11000480 0 0x80>,
> +		      <0 0x11000500 0 0x80>,
> +		      <0 0x11000580 0 0x80>,
> +		      <0 0x11000600 0 0x80>,
> +		      <0 0x11000680 0 0x80>,
> +		      <0 0x11000700 0 0x80>,
> +		      <0 0x11000780 0 0x80>,
> +		      <0 0x11000800 0 0x80>,
> +		      <0 0x11000880 0 0x80>,
> +		      <0 0x11000900 0 0x80>,
> +		      <0 0x11000980 0 0x80>;
> +		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_AP_DMA>;
> +		clock-names = "apdma";
> +		#dma-cells = <1>;
> +	};
> +
>  	uart0: serial@11002000 {
>  		compatible = "mediatek,mt2712-uart",
>  			     "mediatek,mt6577-uart";
> @@ -385,6 +420,9 @@


...deleted
