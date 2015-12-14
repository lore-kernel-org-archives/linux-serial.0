From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 8/9] ARM: shmobile: silk dts: Enable SCIF_CLK frequency and pins
Date: Mon, 14 Dec 2015 19:58:23 +0100
Message-ID: <1450119504-1517-9-git-send-email-geert+renesas@glider.be>
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
Untested, based on hardware manual.

v2:
  - New.
---
 arch/arm/boot/dts/r8a7794-silk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 5a8dcac37c8e70c2..eb608283a24c070c 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -71,11 +71,19 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	scif2_pins: serial2 {
 		renesas,groups = "scif2_data";
 		renesas,function = "scif2";
 	};
 
+	scif_clk_pins: scif_clk {
+		renesas,groups = "scif_clk";
+		renesas,function = "scif_clk";
+	};
+
 	ether_pins: ether {
 		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
 		renesas,function = "eth";
@@ -129,6 +137,11 @@
 	status = "okay";
 };
 
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
+
 &ether {
 	pinctrl-0 = <&ether_pins &phy1_pins>;
 	pinctrl-names = "default";
-- 
1.9.1

