From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/7] ARM: shmobile: r8a7791 dtsi: Add SCIF fallback compatibility strings
Date: Mon, 14 Dec 2015 19:57:52 +0100
Message-ID: <1450119475-1183-5-git-send-email-geert+renesas@glider.be>
References: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index ae1dda181624f8ec..6d90cca931826874 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -558,7 +558,8 @@
 	};
 
 	scifa0: serial@e6c40000 {
-		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7791",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA0>;
@@ -570,7 +571,8 @@
 	};
 
 	scifa1: serial@e6c50000 {
-		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7791",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA1>;
@@ -582,7 +584,8 @@
 	};
 
 	scifa2: serial@e6c60000 {
-		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7791",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA2>;
@@ -594,7 +597,8 @@
 	};
 
 	scifa3: serial@e6c70000 {
-		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7791",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c70000 0 64>;
 		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA3>;
@@ -606,7 +610,8 @@
 	};
 
 	scifa4: serial@e6c78000 {
-		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7791",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c78000 0 64>;
 		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA4>;
@@ -618,7 +623,8 @@
 	};
 
 	scifa5: serial@e6c80000 {
-		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7791",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c80000 0 64>;
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA5>;
@@ -630,7 +636,8 @@
 	};
 
 	scifb0: serial@e6c20000 {
-		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7791",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB0>;
@@ -642,7 +649,8 @@
 	};
 
 	scifb1: serial@e6c30000 {
-		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7791",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB1>;
@@ -654,7 +662,8 @@
 	};
 
 	scifb2: serial@e6ce0000 {
-		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7791",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB2>;
@@ -666,7 +675,8 @@
 	};
 
 	scif0: serial@e6e60000 {
-		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		compatible = "renesas,scif-r8a7791", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>;
@@ -678,7 +688,8 @@
 	};
 
 	scif1: serial@e6e68000 {
-		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		compatible = "renesas,scif-r8a7791", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>;
@@ -690,7 +701,8 @@
 	};
 
 	scif2: serial@e6e58000 {
-		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		compatible = "renesas,scif-r8a7791", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>;
@@ -702,7 +714,8 @@
 	};
 
 	scif3: serial@e6ea8000 {
-		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		compatible = "renesas,scif-r8a7791", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>;
@@ -714,7 +727,8 @@
 	};
 
 	scif4: serial@e6ee0000 {
-		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		compatible = "renesas,scif-r8a7791", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>;
@@ -726,7 +740,8 @@
 	};
 
 	scif5: serial@e6ee8000 {
-		compatible = "renesas,scif-r8a7791", "renesas,scif";
+		compatible = "renesas,scif-r8a7791", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>;
@@ -738,7 +753,8 @@
 	};
 
 	hscif0: serial@e62c0000 {
-		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7791",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>;
@@ -750,7 +766,8 @@
 	};
 
 	hscif1: serial@e62c8000 {
-		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7791",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>;
@@ -762,7 +779,8 @@
 	};
 
 	hscif2: serial@e62d0000 {
-		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7791",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>;
-- 
1.9.1

