From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 07/16] ARM: shmobile: r8a7740 dtsi: Rename the serial port clock to fck
Date: Thu, 19 Nov 2015 19:36:04 +0100
Message-ID: <1447958173-543-8-git-send-email-geert+renesas@glider.be>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The clock is really the device functional clock, not the interface
clock. Rename it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add Acked-by.
---
 arch/arm/boot/dts/r8a7740.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index e14cb1438216e8df..387aef60c825bc24 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -200,7 +200,7 @@
 		reg = <0xe6c40000 0x100>;
 		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -210,7 +210,7 @@
 		reg = <0xe6c50000 0x100>;
 		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -220,7 +220,7 @@
 		reg = <0xe6c60000 0x100>;
 		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -230,7 +230,7 @@
 		reg = <0xe6c70000 0x100>;
 		interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -240,7 +240,7 @@
 		reg = <0xe6c80000 0x100>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -250,7 +250,7 @@
 		reg = <0xe6cb0000 0x100>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -260,7 +260,7 @@
 		reg = <0xe6cc0000 0x100>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA6>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -270,7 +270,7 @@
 		reg = <0xe6cd0000 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFA7>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -280,7 +280,7 @@
 		reg = <0xe6c30000 0x100>;
 		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7740_CLK_SCIFB>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
-- 
1.9.1

