From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 7/7] arm64: renesas: r8a7795 dtsi: Add SCIF fallback compatibility strings
Date: Mon, 14 Dec 2015 19:57:55 +0100
Message-ID: <1450119475-1183-8-git-send-email-geert+renesas@glider.be>
References: <1450119475-1183-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450119475-1183-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 38 +++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b9229a49dabca343..dd266e56f23ded2c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -387,7 +387,9 @@
 		};
 
 		hscif0: serial@e6540000 {
-			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
 			reg = <0 0xe6540000 0 96>;
 			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 520>;
@@ -399,7 +401,9 @@
 		};
 
 		hscif1: serial@e6550000 {
-			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
 			reg = <0 0xe6550000 0 96>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 519>;
@@ -411,7 +415,9 @@
 		};
 
 		hscif2: serial@e6560000 {
-			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
 			reg = <0 0xe6560000 0 96>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 518>;
@@ -423,7 +429,9 @@
 		};
 
 		hscif3: serial@e66a0000 {
-			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
 			reg = <0 0xe66a0000 0 96>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 517>;
@@ -435,7 +443,9 @@
 		};
 
 		hscif4: serial@e66b0000 {
-			compatible = "renesas,hscif-r8a7795", "renesas,hscif";
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
 			reg = <0 0xe66b0000 0 96>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 516>;
@@ -447,7 +457,8 @@
 		};
 
 		scif0: serial@e6e60000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6e60000 0 64>;
 			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 207>;
@@ -459,7 +470,8 @@
 		};
 
 		scif1: serial@e6e68000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6e68000 0 64>;
 			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 206>;
@@ -471,7 +483,8 @@
 		};
 
 		scif2: serial@e6e88000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6e88000 0 64>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 310>;
@@ -483,7 +496,8 @@
 		};
 
 		scif3: serial@e6c50000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6c50000 0 64>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 204>;
@@ -495,7 +509,8 @@
 		};
 
 		scif4: serial@e6c40000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6c40000 0 64>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 203>;
@@ -507,7 +522,8 @@
 		};
 
 		scif5: serial@e6f30000 {
-			compatible = "renesas,scif-r8a7795", "renesas,scif";
+			compatible = "renesas,scif-r8a7795",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
 			reg = <0 0xe6f30000 0 64>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 202>;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
