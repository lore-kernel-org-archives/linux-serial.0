From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/7] ARM: shmobile: r8a7778 dtsi: Add BRG support for SCIF
Date: Mon, 14 Dec 2015 19:58:09 +0100
Message-ID: <1450119495-1416-2-git-send-email-geert+renesas@glider.be>
References: <1450119495-1416-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119495-1416-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add the device node for the external SCIF_CLK.
The presence of the SCIF_CLK crystal and its clock frequency depends on
the actual board.

Add the two optional clock sources (S1 and SCIF_CLK for the internal
resp. external clock) for the Baud Rate Generator for External Clock
(BRG) to all SCIF device nodes.

This increases the range and accuracy of supported baud rates on SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm/boot/dts/r8a7778.dtsi | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 3e9c9d2f28deaf20..a192355e740abb07 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -300,8 +300,9 @@
 			     "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF0>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -311,8 +312,9 @@
 			     "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF1>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -322,8 +324,9 @@
 			     "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF2>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF2>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -333,8 +336,9 @@
 			     "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF3>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF3>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -344,8 +348,9 @@
 			     "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF4>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF4>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -355,8 +360,9 @@
 			     "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF5>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF5>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -443,6 +449,15 @@
 			clock-output-names = "extal";
 		};
 
+		/* External SCIF clock */
+		scif_clk: scif {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
+			status = "disabled";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks@ffc80000 {
 			compatible = "renesas,r8a7778-cpg-clocks";
-- 
1.9.1

