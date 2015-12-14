From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 4/7] ARM: shmobile: r8a7791 dtsi: Add BRG support for (H)SCIF
Date: Mon, 14 Dec 2015 19:58:12 +0100
Message-ID: <1450119495-1416-5-git-send-email-geert+renesas@glider.be>
References: <1450119495-1416-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450119495-1416-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Add the device node for the external SCIF_CLK.
The presence of the SCIF_CLK crystal and its clock frequency depends on
the actual board.

Add the two optional clock sources (ZS_CLK and SCIF_CLK for the internal
resp. external clock) for the Baud Rate Generator for External Clock
(BRG) to all SCIF and HSCIF device nodes.

This increases the range and accuracy of supported baud rates on
(H)SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - Rename "int_clk" to "brg_int".
---
 arch/arm/boot/dts/r8a7791.dtsi | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 514294e5d4f047c3..e9bdf87576c3b317 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -679,8 +679,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -692,8 +693,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -705,8 +707,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -718,8 +721,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -731,8 +735,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -744,8 +749,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -757,8 +763,9 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -770,8 +777,9 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -783,8 +791,9 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -1043,6 +1052,15 @@
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
