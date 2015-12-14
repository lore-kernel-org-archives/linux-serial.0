From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/7] ARM: shmobile: r8a7778 dtsi: Add SCIF fallback compatibility strings
Date: Mon, 14 Dec 2015 19:57:49 +0100
Message-ID: <1450119475-1183-2-git-send-email-geert+renesas@glider.be>
References: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 791aafd310a5d78b..2786af1b89790e4c 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -296,7 +296,8 @@
 	};
 
 	scif0: serial@ffe40000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF0>;
@@ -306,7 +307,8 @@
 	};
 
 	scif1: serial@ffe41000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF1>;
@@ -316,7 +318,8 @@
 	};
 
 	scif2: serial@ffe42000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF2>;
@@ -326,7 +329,8 @@
 	};
 
 	scif3: serial@ffe43000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF3>;
@@ -336,7 +340,8 @@
 	};
 
 	scif4: serial@ffe44000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF4>;
@@ -346,7 +351,8 @@
 	};
 
 	scif5: serial@ffe45000 {
-		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		compatible = "renesas,scif-r8a7778", "renesas,rcar-gen1-scif",
+			     "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF5>;
-- 
1.9.1

