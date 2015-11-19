From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 21/25] ARM: shmobile: r8a7791 dtsi: Add BRG support for (H)SCIF
Date: Thu, 19 Nov 2015 19:39:00 +0100
Message-ID: <1447958344-836-22-git-send-email-geert+renesas@glider.be>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a7791.dtsi | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 684120a0a479a8d0..20f0cacd3a79095b 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -670,8 +670,9 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "int_clk", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -682,8 +683,9 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "int_clk", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -694,8 +696,9 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "int_clk", "scif_clk";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -706,8 +709,9 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "int_clk", "scif_clk";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -718,8 +722,9 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "int_clk", "scif_clk";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -730,8 +735,9 @@
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "int_clk", "scif_clk";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -742,8 +748,9 @@
 		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "int_clk", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -754,8 +761,9 @@
 		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "int_clk", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -766,8 +774,9 @@
 		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "int_clk", "scif_clk";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -1014,6 +1023,15 @@
 			status = "disabled";
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

