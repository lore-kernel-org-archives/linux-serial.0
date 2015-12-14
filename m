From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 9/9] arm64: renesas: salvator-x dts: Enable SCIF_CLK frequency and pins
Date: Mon, 14 Dec 2015 19:58:24 +0100
Message-ID: <1450119504-1517-10-git-send-email-geert+renesas@glider.be>
References: <1450119504-1517-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119504-1517-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add and enable the external crystal for the SCIF_CLK and its pinctrl, to
be used by the Baud Rate Generator for External Clock (BRG) on (H)SCIF.

This increases the range and accuracy of supported baud rates:
  - SCIF:
      - Supports now 50, 230400, 460800, 500000, and 921600 bps,
      - Perfect match for standard 50-460800, and 9216000 bps.
  - HSCIF:
      - Supports now 50, 75, and 110 bps,
      - Perfect match for standard 50-460800, and 9216000 bps.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v2:
  - Add Reviewed-by.
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 75af5ec5a4d4133d..56bb64838ba3cecf 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -93,6 +93,9 @@
 };
 
 &pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	scif1_pins: scif1 {
 		renesas,groups = "scif1_data_a", "scif1_ctrl";
 		renesas,function = "scif1";
@@ -101,6 +104,10 @@
 		renesas,groups = "scif2_data_a";
 		renesas,function = "scif2";
 	};
+	scif_clk_pins: scif_clk {
+		renesas,groups = "scif_clk_a";
+		renesas,function = "scif_clk";
+	};
 
 	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2_a";
@@ -138,6 +145,11 @@
 	status = "okay";
 };
 
+&scif_clk {
+	clock-frequency = <14745600>;
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
-- 
1.9.1

