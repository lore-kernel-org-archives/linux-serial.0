From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 7/7] arm64: dts: r8a7796: salvator-x: add SCIF1 (DEBUG1)
Date: Mon, 23 Jan 2017 17:04:18 +0100
Message-ID: <1485187458-8195-8-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485187458-8195-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Enables the SCIF hooked up to the DEBUG1 connector.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index c7f40f8..498d971 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -18,6 +18,7 @@
 
 	aliases {
 		serial0 = &scif2;
+		serial1 = &scif1;
 		ethernet0 = &avb;
 	};
 
@@ -113,6 +114,11 @@
 		function = "avb";
 	};
 
+	scif1_pins: scif1 {
+		groups = "scif1_data_a", "scif1_ctrl";
+		function = "scif1";
+	};
+
 	scif2_pins: scif2 {
 		groups = "scif2_data_a";
 		function = "scif2";
@@ -239,6 +245,14 @@
 	status = "okay";
 };
 
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	status = "okay";
+};
+
 &scif2 {
 	pinctrl-0 = <&scif2_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
