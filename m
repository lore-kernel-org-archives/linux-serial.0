From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/7] ARM: shmobile: r8a7779 dtsi: Add BRG support for SCIF
Date: Mon, 14 Dec 2015 19:58:10 +0100
Message-ID: <1450119495-1416-3-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a7779.dtsi | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index aa71cd234ac4dd3e..bdb39e657589c86c 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -215,8 +215,9 @@
 			     "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -226,8 +227,9 @@
 			     "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -237,8 +239,9 @@
 			     "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -248,8 +251,9 @@
 			     "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -259,8 +263,9 @@
 			     "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -270,8 +275,9 @@
 			     "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>,
+			 <&cpg_clocks R8A7779_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -447,6 +453,15 @@
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
 		cpg_clocks: clocks@ffc80000 {
 			compatible = "renesas,r8a7779-cpg-clocks";
-- 
1.9.1

