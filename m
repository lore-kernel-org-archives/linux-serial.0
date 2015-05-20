From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] ARM: shmobile: r8a7790 dtsi: Describe DMA for the serial ports
Date: Wed, 20 May 2015 19:46:25 +0200
Message-ID: <1432143987-10308-3-git-send-email-geert+renesas@glider.be>
References: <1432143987-10308-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1432143987-10308-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add DMA properties to all SCIF, SCIFA, SCIFB, and HSCIF device nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 62a9086b133d5b91..6ef146d9384da332 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -554,6 +554,8 @@
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -563,6 +565,8 @@
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -572,6 +576,8 @@
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -581,6 +587,8 @@
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -590,6 +598,8 @@
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -599,6 +609,8 @@
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -608,6 +620,8 @@
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -617,6 +631,8 @@
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -626,6 +642,8 @@
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -635,6 +653,8 @@
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
1.9.1

