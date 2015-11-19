From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 23/25] arm64: renesas: r8a7795 dtsi: Add BRG support for (H)SCIF
Date: Thu, 19 Nov 2015 23:07:33 +0200
Message-ID: <6606020.G1vmRDrqTj@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <1447958344-836-24-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-24-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 19 November 2015 19:39:02 Geert Uytterhoeven wrote:
> Add the device node for the external SCIF_CLK.
> The presence of the SCIF_CLK crystal and its clock frequency depend on
> the actual board.
> 
> Add the two optional clock sources (ZS_CLK and SCIF_CLK for the internal
> resp. external clock) for the Baud Rate Generator for External Clock
> (BRG) to all SCIF and HSCIF device nodes.
> 
> This increases the range and accuracy of supported baud rates on
> (H)SCIF.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 74 +++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi index
> 53a2a8fb42b7480c..25900761cfde201e 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -84,6 +84,14 @@
>  		status = "disabled";
>  	};
> 
> +	/* External SCIF clock - to be overridden by boards that provide it */
> +	scif_clk: scif {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +		status = "disabled";
> +	};

I have mixed feelings about this. Defining an external clock that isn't 
present on the board isn't very clean, even more so when the clock has such a 
generic name. Wouldn't it be better to let board files define the clock when 
they need it ? I know it would require board files to override the clocks and 
clock-names property too. Maybe we need to extend the DTS syntax to allow 
extending list properties instead of overriding them completely ?

>  	soc {
>  		compatible = "simple-bus";
>  		interrupt-parent = <&gic>;
> @@ -362,8 +370,10 @@
>  			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
>  			reg = <0 0xe6540000 0 96>;
>  			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 520>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 520>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;
> @@ -374,8 +384,10 @@
>  			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
>  			reg = <0 0xe6550000 0 96>;
>  			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 519>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 519>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;
> @@ -386,8 +398,10 @@
>  			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
>  			reg = <0 0xe6560000 0 96>;
>  			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 518>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 518>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;
> @@ -398,8 +412,10 @@
>  			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
>  			reg = <0 0xe66a0000 0 96>;
>  			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 517>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 517>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;
> @@ -410,8 +426,10 @@
>  			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
>  			reg = <0 0xe66b0000 0 96>;
>  			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 516>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 516>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;
> @@ -422,8 +440,10 @@
>  			compatible = "renesas,scif-r8a7795", "renesas,scif";
>  			reg = <0 0xe6e60000 0 64>;
>  			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 207>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 207>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;
> @@ -434,8 +454,10 @@
>  			compatible = "renesas,scif-r8a7795", "renesas,scif";
>  			reg = <0 0xe6e68000 0 64>;
>  			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 206>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 206>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;
> @@ -446,8 +468,10 @@
>  			compatible = "renesas,scif-r8a7795", "renesas,scif";
>  			reg = <0 0xe6e88000 0 64>;
>  			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 310>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 310>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;
> @@ -458,8 +482,10 @@
>  			compatible = "renesas,scif-r8a7795", "renesas,scif";
>  			reg = <0 0xe6c50000 0 64>;
>  			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 204>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 204>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;
> @@ -470,8 +496,10 @@
>  			compatible = "renesas,scif-r8a7795", "renesas,scif";
>  			reg = <0 0xe6c40000 0 64>;
>  			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 203>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 203>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;
> @@ -482,8 +510,10 @@
>  			compatible = "renesas,scif-r8a7795", "renesas,scif";
>  			reg = <0 0xe6f30000 0 64>;
>  			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&cpg CPG_MOD 202>;
> -			clock-names = "fck";
> +			clocks = <&cpg CPG_MOD 202>,
> +				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
> +				 <&scif_clk>;
> +			clock-names = "fck", "int_clk", "scif_clk";
>  			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
>  			dma-names = "tx", "rx";
>  			power-domains = <&cpg>;

-- 
Regards,

Laurent Pinchart

