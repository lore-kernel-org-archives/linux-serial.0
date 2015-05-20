From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] ARM: shmobile: r8a7791 dtsi: Describe DMA for the serial ports
Date: Wed, 20 May 2015 19:46:26 +0200
Message-ID: <1432143987-10308-4-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a7791.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 7613abea13d79037..7e79e01202f80dac 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -532,6 +532,8 @@
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -541,6 +543,8 @@
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -550,6 +554,8 @@
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -559,6 +565,8 @@
 		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA3>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -568,6 +576,8 @@
 		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA4>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -577,6 +587,8 @@
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA5>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -586,6 +598,8 @@
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -595,6 +609,8 @@
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -604,6 +620,8 @@
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -613,6 +631,8 @@
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -622,6 +642,8 @@
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -631,6 +653,8 @@
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -640,6 +664,8 @@
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -649,6 +675,8 @@
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -658,6 +686,8 @@
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -667,6 +697,8 @@
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -676,6 +708,8 @@
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -685,6 +719,8 @@
 		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>;
 		clock-names = "sci_ick";
+		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
1.9.1

