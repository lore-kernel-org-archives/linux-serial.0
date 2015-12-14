From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/7] ARM: shmobile: r8a7790 dtsi: Add BRG support for (H)SCIF
Date: Mon, 14 Dec 2015 19:58:11 +0100
Message-ID: <1450119495-1416-4-git-send-email-geert+renesas@glider.be>
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

Add the two optional clock sources (ZS_CLK and SCIF_CLK for the internal
resp. external clock) for the Baud Rate Generator for External Clock
(BRG) to all SCIF and HSCIF device nodes.

This increases the range and accuracy of supported baud rates on
(H)SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm/boot/dts/r8a7790.dtsi | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index cb3d9b8790d2dfdb..ec71d89f16db1eec 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -663,8 +663,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -676,8 +677,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -689,8 +691,9 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -702,8 +705,9 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -992,6 +996,15 @@
 			clock-output-names = "audio_clk_c";
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
 		/* External USB clock - can be overridden by the board */
 		usb_extal_clk: usb_extal_clk {
 			compatible = "fixed-clock";
-- 
1.9.1

