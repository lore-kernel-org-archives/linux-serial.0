From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 8/9] ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200 DTSI/DTS
Date: Thu, 11 Sep 2014 22:11:39 +0200
Message-ID: <1410466300-19168-9-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:41519 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606AbaIKUMX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 16:12:23 -0400
In-Reply-To: <1410466300-19168-1-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com, maxime.ripard@free-electrons.com, afaerber@suse.de, matthias.bgg@gmail.com
Cc: Carlo Caione <carlo@caione.org>

The Meson6 SoC is produced by Amlogic inc. and it is based on 2 Cortex
A9 and an ARM Mali-400 GPU.
This patch adds two basic DTSI for the preliminary support of Meson and
Meson6 SoCs. Another DTS is also added for supporting the atv1200 board,
produced by Geniatech inc.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/meson.dtsi         | 74 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson6-atv1200.dts | 25 ++++++++++++
 arch/arm/boot/dts/meson6.dtsi        | 40 +++++++++++++++++++
 4 files changed, 140 insertions(+)
 create mode 100644 arch/arm/boot/dts/meson.dtsi
 create mode 100644 arch/arm/boot/dts/meson6-atv1200.dts
 create mode 100644 arch/arm/boot/dts/meson6.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index adb5ed9..4e2bb17 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -154,6 +154,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += $(kirkwood)
 dtb-$(CONFIG_MACH_KIRKWOOD) += $(kirkwood)
 dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
+dtb-$(CONFIG_MACH_MESON6) += meson6-atv1200.dtb
 dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
 	imx25-eukrea-mbimxsd25-baseboard.dtb \
diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
new file mode 100644
index 0000000..ace5db8
--- /dev/null
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -0,0 +1,74 @@
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
+	soc {
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
diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts/meson6-atv1200.dts
new file mode 100644
index 0000000..84576aa
--- /dev/null
+++ b/arch/arm/boot/dts/meson6-atv1200.dts
@@ -0,0 +1,25 @@
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
+};
+
+&uart_AO {
+	status = "okay";
+};
+
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
new file mode 100644
index 0000000..f9d2cb5
--- /dev/null
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -0,0 +1,40 @@
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
+	compatible = "amlogic,meson6";
+
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x200>;
+		};
+
+		cpu@201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x201>;
+		};
+	};
+
+	clk81: clk@0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <200000000>;
+	};
+}; /* end of / */
-- 
1.9.1

