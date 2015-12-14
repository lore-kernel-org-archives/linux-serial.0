From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 03/12] ARM: shmobile: r7s72100 dtsi: Rename the serial port clock to fck
Date: Mon, 14 Dec 2015 19:57:57 +0100
Message-ID: <1450119486-1285-4-git-send-email-geert+renesas@glider.be>
References: <1450119486-1285-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119486-1285-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The clock is really the device functional clock, not the interface
clock. Rename it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - Add Acked-by.
---
 arch/arm/boot/dts/r7s72100.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 4657d7fb5bceede5..0c3b9e341ce7fd8e 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -157,7 +157,7 @@
 			     <0 192 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -170,7 +170,7 @@
 			     <0 196 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 193 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -183,7 +183,7 @@
 			     <0 200 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 197 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -196,7 +196,7 @@
 			     <0 204 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 201 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -209,7 +209,7 @@
 			     <0 208 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 205 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -222,7 +222,7 @@
 			     <0 212 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 209 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -235,7 +235,7 @@
 			     <0 216 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 213 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF6>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -248,7 +248,7 @@
 			     <0 220 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 217 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF7>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
1.9.1

