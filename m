From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/7] ARM: shmobile: r8a7794 dtsi: Add SCIF fallback compatibility strings
Date: Mon, 14 Dec 2015 19:57:54 +0100
Message-ID: <1450119475-1183-7-git-send-email-geert+renesas@glider.be>
References: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 89e914f2a2cf21a9..cc115a9d1c867715 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -282,7 +282,8 @@
 	};
 
 	scifa0: serial@e6c40000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA0>;
@@ -294,7 +295,8 @@
 	};
 
 	scifa1: serial@e6c50000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA1>;
@@ -306,7 +308,8 @@
 	};
 
 	scifa2: serial@e6c60000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA2>;
@@ -318,7 +321,8 @@
 	};
 
 	scifa3: serial@e6c70000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c70000 0 64>;
 		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA3>;
@@ -330,7 +334,8 @@
 	};
 
 	scifa4: serial@e6c78000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c78000 0 64>;
 		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA4>;
@@ -342,7 +347,8 @@
 	};
 
 	scifa5: serial@e6c80000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c80000 0 64>;
 		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA5>;
@@ -354,7 +360,8 @@
 	};
 
 	scifb0: serial@e6c20000 {
-		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7794",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB0>;
@@ -366,7 +373,8 @@
 	};
 
 	scifb1: serial@e6c30000 {
-		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7794",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB1>;
@@ -378,7 +386,8 @@
 	};
 
 	scifb2: serial@e6ce0000 {
-		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7794",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB2>;
@@ -390,7 +399,8 @@
 	};
 
 	scif0: serial@e6e60000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF0>;
@@ -402,7 +412,8 @@
 	};
 
 	scif1: serial@e6e68000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF1>;
@@ -414,7 +425,8 @@
 	};
 
 	scif2: serial@e6e58000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF2>;
@@ -426,7 +438,8 @@
 	};
 
 	scif3: serial@e6ea8000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF3>;
@@ -438,7 +451,8 @@
 	};
 
 	scif4: serial@e6ee0000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF4>;
@@ -450,7 +464,8 @@
 	};
 
 	scif5: serial@e6ee8000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF5>;
@@ -462,7 +477,8 @@
 	};
 
 	hscif0: serial@e62c0000 {
-		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7794",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF0>;
@@ -474,7 +490,8 @@
 	};
 
 	hscif1: serial@e62c8000 {
-		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7794",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF1>;
@@ -486,7 +503,8 @@
 	};
 
 	hscif2: serial@e62d0000 {
-		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7794",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF2>;
-- 
1.9.1

