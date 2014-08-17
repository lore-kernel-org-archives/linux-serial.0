From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 5/7] ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200 DTSI/DTS
Date: Sun, 17 Aug 2014 12:49:52 +0200
Message-ID: <1408272594-10814-6-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:64243 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaHQKui (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Aug 2014 06:50:38 -0400
In-Reply-To: <1408272594-10814-1-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com
Cc: Carlo Caione <carlo@caione.org>

The Meson6 SoC is produced by Amlogic inc. and it is based on 2 Cortex A9
and an ARM Mali-400 GPU.
This patch adds two basic DTSI for the preliminary support of Meson and
Meson6 SoCs. Another DTS is also added for supporting the atv1200 board,
produced by Geniatech inc.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/meson.dtsi         | 75 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson6-atv1200.dts | 27 +++++++++++++
 arch/arm/boot/dts/meson6.dtsi        | 44 +++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 arch/arm/boot/dts/meson.dtsi
 create mode 100644 arch/arm/boot/dts/meson6-atv1200.dts
 create mode 100644 arch/arm/boot/dts/meson6.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..604acce 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -159,6 +159,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
 	kirkwood-ts419-6282.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
+dtb-$(CONFIG_MACH_MESON6) += meson6-atv1200.dtb
 dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
 	imx25-eukrea-mbimxsd25-baseboard.dtb \
diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
new file mode 100644
index 0000000..934bb2c
--- /dev/null
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -0,0 +1,75 @@
+/*
+ * Copyright 2014 Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &uart_AO;
+		serial1 = &uart_A;
+		serial2 = &uart_B;
+		serial3 = &uart_C;
+	};
+
+	gic: interrupt-controller@c4301000 {
+		compatible = "arm,cortex-a9-gic";
+		reg = <0xc4301000 0x1000>,
+		      <0xc4300100 0x0100>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+	};
+
+	timer@c1109940 {
+		compatible = "amlogic,meson6-timer";
+		reg = <0xc1109940 0x14>;
+		interrupts = <0 10 1>;
+	};
+
+	soc@c8100000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		uart_AO: serial@c81004c0 {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc81004c0 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clk81>;
+			status = "disabled";
+		};
+
+		uart_A: serial@c81084c0 {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc81084c0 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clk81>;
+			status = "disabled";
+		};
+
+		uart_B: serial@c81084dc {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc81084dc 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clk81>;
+			status = "disabled";
+		};
+
+		uart_C: serial@c8108700 {
+			compatible = "amlogic,meson-uart";
+			reg = <0xc8108700 0x14>;
+			interrupts = <0 90 1>;
+			clocks = <&clk81>;
+			status = "disabled";
+		};
+	};
+}; /* end of / */
+
diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts/meson6-atv1200.dts
new file mode 100644
index 0000000..b358402
--- /dev/null
+++ b/arch/arm/boot/dts/meson6-atv1200.dts
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2014 Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+/include/ "meson6.dtsi"
+
+/ {
+	model = "Geniatech ATV1200";
+	compatible = "geniatech,atv1200";
+
+	memory {
+		reg = <0x40000000 0x80000000>;
+	};
+
+	soc@c8100000 {
+		uart_AO: serial@c81004c0 {
+			status = "okay";
+		};
+	};
+}; /* end of / */
+
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
new file mode 100644
index 0000000..d62add4
--- /dev/null
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -0,0 +1,44 @@
+/*
+ * Copyright 2014 Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+/include/ "meson.dtsi"
+
+/ {
+	model = "Amlogic Meson6 SoC";
+	compatible = "amlogic,meson6", "amlogic,8726_mx";
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x200>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x1>;
+		};
+	};
+
+	clocks {
+		#address-cells = <1>;
+
+		clk81: clk@0 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
+		};
+	};
+}; /* end of / */
-- 
1.9.1

