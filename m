From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 09/16] ARM: shmobile: r8a7779 dtsi: Rename the serial port clock to fck
Date: Thu, 19 Nov 2015 19:36:06 +0100
Message-ID: <1447958173-543-10-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a7779.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 6afa909865b52b71..e4054119ee7c5aa9 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -215,7 +215,7 @@
 		reg = <0xffe40000 0x100>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -225,7 +225,7 @@
 		reg = <0xffe41000 0x100>;
 		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -235,7 +235,7 @@
 		reg = <0xffe42000 0x100>;
 		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -245,7 +245,7 @@
 		reg = <0xffe43000 0x100>;
 		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -255,7 +255,7 @@
 		reg = <0xffe44000 0x100>;
 		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -265,7 +265,7 @@
 		reg = <0xffe45000 0x100>;
 		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
1.9.1

