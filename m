From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 7/7] arm64: renesas: r8a7795 dtsi: Add BRG support for (H)SCIF
Date: Mon, 14 Dec 2015 19:58:15 +0100
Message-ID: <1450119495-1416-8-git-send-email-geert+renesas@glider.be>
References: <1450119495-1416-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119495-1416-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add the device node for the external SCIF_CLK.
The presence of the SCIF_CLK crystal and its clock frequency depend on
the actual board.

Add the two optional clock sources (S3D1 and SCIF_CLK for the internal
resp. external clock) for the Baud Rate Generator for External Clock
(BRG) to all SCIF and HSCIF device nodes.

This increases the range and accuracy of supported baud rates on
(H)SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Correct internal clock source ZS_CLK to S3D1 in patch description,
  - Rename "int_clk" to "brg_int".
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 74 ++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a5afd9bad6791398..75d21c548f081e01 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -99,6 +99,14 @@
 		clock-frequency = <0>;
 	};
 
+	/* External SCIF clock - to be overridden by boards that provide it */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
@@ -392,8 +400,10 @@
 				     "renesas,hscif";
 			reg = <0 0xe6540000 0 96>;
 			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 520>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 520>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -406,8 +416,10 @@
 				     "renesas,hscif";
 			reg = <0 0xe6550000 0 96>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 519>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 519>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -420,8 +432,10 @@
 				     "renesas,hscif";
 			reg = <0 0xe6560000 0 96>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 518>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 518>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -434,8 +448,10 @@
 				     "renesas,hscif";
 			reg = <0 0xe66a0000 0 96>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 517>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 517>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -448,8 +464,10 @@
 				     "renesas,hscif";
 			reg = <0 0xe66b0000 0 96>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 516>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 516>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -461,8 +479,10 @@
 				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6e60000 0 64>;
 			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 207>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 207>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -474,8 +494,10 @@
 				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6e68000 0 64>;
 			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 206>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 206>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -487,8 +509,10 @@
 				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6e88000 0 64>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 310>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 310>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -500,8 +524,10 @@
 				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6c50000 0 64>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 204>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 204>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -513,8 +539,10 @@
 				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6c40000 0 64>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 203>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 203>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
@@ -526,8 +554,10 @@
 				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6f30000 0 64>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 202>;
-			clock-names = "fck";
+			clocks = <&cpg CPG_MOD 202>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
 			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
-- 
1.9.1

