From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 6/9] ARM: shmobile: marzen dts: Enable SCIF_CLK frequency and pins
Date: Mon, 14 Dec 2015 19:58:21 +0100
Message-ID: <1450119504-1517-7-git-send-email-geert+renesas@glider.be>
References: <1450119504-1517-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119504-1517-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add and enable the external crystal for the SCIF_CLK and its pinctrl, to
be used by the Baud Rate Generator for External Clock (BRG) on (H)SCIF.

This increases the range and accuracy of supported baud rates.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Based on schematics, tested with remote access.

v2:
  - New.
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index fe396c8d58db7986..e111d35d02aebe19 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -165,6 +165,9 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	du_pins: du {
 		du0 {
 			renesas,groups = "du0_rgb888", "du0_sync_1", "du0_clk_out_0";
@@ -176,6 +179,11 @@
 		};
 	};
 
+	scif_clk_pins: scif_clk {
+		renesas,groups = "scif_clk_b";
+		renesas,function = "scif_clk";
+	};
+
 	ethernet_pins: ethernet {
 		intc {
 			renesas,groups = "intc_irq1_b";
@@ -222,6 +230,11 @@
 	status = "okay";
 };
 
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
-- 
1.9.1

