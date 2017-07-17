From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [RFC v2 6/6] ARM: dts: blanche: add SCIF1 and MAX9260 deserializer
Date: Mon, 17 Jul 2017 17:24:36 +0200
Message-ID: <1500305076-15570-7-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1500305076-15570-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Adds serial port SCIF1 and the MAX9260 deserializers connected to it.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7792-blanche.dts | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
index 9b67dca..2ae9a87 100644
--- a/arch/arm/boot/dts/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -21,6 +21,7 @@
 	aliases {
 		serial0 = &scif0;
 		serial1 = &scif3;
+		serial2 = &scif1;
 	};
 
 	chosen {
@@ -186,6 +187,16 @@
 		gpio = <&gpio11 12 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	mux: mux-controller {
+		compatible = "gpio-mux";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&gpio5 12 GPIO_ACTIVE_HIGH>,
+			    <&gpio5 13 GPIO_ACTIVE_HIGH>,
+			    <&gpio5 14 GPIO_ACTIVE_HIGH>,
+			    <&gpio5 15 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &extal_clk {
@@ -202,6 +213,11 @@
 		function = "scif0";
 	};
 
+	scif1_pins: scif1 {
+		groups = "scif1_data";
+		function = "scif1";
+	};
+
 	scif3_pins: scif3 {
 		groups = "scif3_data";
 		function = "scif3";
@@ -246,6 +262,42 @@
 	status = "okay";
 };
 
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	mux-controls = <&mux>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	gmsl-deserializer@0 {
+		compatible = "maxim,max9260";
+		reg = <0x8>;
+	};
+	gmsl-deserializer@1 {
+		compatible = "maxim,max9260";
+		reg = <0x9>;
+	};
+	gmsl-deserializer@2 {
+		compatible = "maxim,max9260";
+		reg = <0xa>;
+	};
+	gmsl-deserializer@3 {
+		compatible = "maxim,max9260";
+		reg = <0xb>;
+	};
+	gmsl-deserializer@4 {
+		compatible = "maxim,max9260";
+		reg = <0x4>;
+	};
+	gmsl-deserializer@5 {
+		compatible = "maxim,max9260";
+		reg = <0x5>;
+	};
+};
+
 &scif3 {
 	pinctrl-0 = <&scif3_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
