From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/7] ARM: shmobile: r8a7790 dtsi: Add SCIF fallback compatibility strings
Date: Mon, 14 Dec 2015 19:57:51 +0100
Message-ID: <1450119475-1183-4-git-send-email-geert+renesas@glider.be>
References: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index c6f083c9345d9269..de65cb731fa5e801 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -581,7 +581,8 @@
 	};
 
 	scifa0: serial@e6c40000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7790",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
@@ -593,7 +594,8 @@
 	};
 
 	scifa1: serial@e6c50000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7790",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA1>;
@@ -605,7 +607,8 @@
 	};
 
 	scifa2: serial@e6c60000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7790",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA2>;
@@ -617,7 +620,8 @@
 	};
 
 	scifb0: serial@e6c20000 {
-		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7790",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB0>;
@@ -629,7 +633,8 @@
 	};
 
 	scifb1: serial@e6c30000 {
-		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7790",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB1>;
@@ -641,7 +646,8 @@
 	};
 
 	scifb2: serial@e6ce0000 {
-		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7790",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB2>;
@@ -653,7 +659,8 @@
 	};
 
 	scif0: serial@e6e60000 {
-		compatible = "renesas,scif-r8a7790", "renesas,scif";
+		compatible = "renesas,scif-r8a7790", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>;
@@ -665,7 +672,8 @@
 	};
 
 	scif1: serial@e6e68000 {
-		compatible = "renesas,scif-r8a7790", "renesas,scif";
+		compatible = "renesas,scif-r8a7790", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>;
@@ -677,7 +685,8 @@
 	};
 
 	hscif0: serial@e62c0000 {
-		compatible = "renesas,hscif-r8a7790", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7790",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>;
@@ -689,7 +698,8 @@
 	};
 
 	hscif1: serial@e62c8000 {
-		compatible = "renesas,hscif-r8a7790", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7790",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>;
-- 
1.9.1

