From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v2 01/10] ARM: dts: fork out common Exynos5 nodes
Date: Fri, 14 Jun 2013 19:32:43 +0530
Message-ID: <1371218572-8993-2-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-10-git-send-email-chander.kashyap@linaro.org>
 <1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:41896 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab3FNODW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 10:03:22 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so599764pbc.39
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2013 07:03:21 -0700 (PDT)
In-Reply-To: <1371218572-8993-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>

In preparation of adding support for Exynos5420, which has many peripherals
similar to Exynos5250, a new common Exynos5 device tree source file is
created out of the exising Exynos5250 device tree source file. Only the
common nodes required for basic boot up on Exynos5420 based boards are moved
into this new file and the rest of the common nodes would be moved subsequently.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/boot/dts/exynos5.dtsi    |  111 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi |   68 +----------------------
 2 files changed, 113 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5.dtsi

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
new file mode 100644
index 0000000..5684f89
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -0,0 +1,111 @@
+/*
+ * Samsung's Exynos5 SoC series common device tree source
+ *
+ * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos5 SoC series device nodes are listed in this file. Particular
+ * SoCs from Exynos5 series can include this file and provide values for SoCs
+ * specfic bindings.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&gic>;
+
+	chipid@10000000 {
+		compatible = "samsung,exynos4210-chipid";
+		reg = <0x10000000 0x100>;
+	};
+
+	watchdog {
+		compatible = "samsung,s3c2410-wdt";
+		reg = <0x101D0000 0x100>;
+		interrupts = <0 42 0>;
+		status = "disabled";
+	};
+
+	rtc {
+		compatible = "samsung,s3c6410-rtc";
+		reg = <0x101E0000 0x100>;
+		interrupts = <0 43 0>, <0 44 0>;
+		status = "disabled";
+	};
+
+	combiner:interrupt-controller@10440000 {
+		compatible = "samsung,exynos4210-combiner";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		samsung,combiner-nr = <32>;
+		reg = <0x10440000 0x1000>;
+		interrupts =	<0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
+				<0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
+				<0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
+				<0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
+				<0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
+				<0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
+				<0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
+				<0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
+	};
+
+	gic:interrupt-controller@10481000 {
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg =	<0x10481000 0x1000>,
+			<0x10482000 0x1000>,
+			<0x10484000 0x2000>,
+			<0x10486000 0x2000>;
+		interrupts = <1 9 0xf04>;
+	};
+
+	dwmmc_0: dwmmc0@12200000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		interrupts = <0 75 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	dwmmc_1: dwmmc1@12210000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		interrupts = <0 76 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	dwmmc_2: dwmmc2@12220000 {
+		compatible = "samsung,exynos5250-dw-mshc";
+		interrupts = <0 77 0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	serial@12C00000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C00000 0x100>;
+		interrupts = <0 51 0>;
+	};
+
+	serial@12C10000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C10000 0x100>;
+		interrupts = <0 52 0>;
+	};
+
+	serial@12C20000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C20000 0x100>;
+		interrupts = <0 53 0>;
+	};
+
+	serial@12C30000 {
+		compatible = "samsung,exynos4210-uart";
+		reg = <0x12C30000 0x100>;
+		interrupts = <0 54 0>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 0673524..2b59ea3 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -17,12 +17,11 @@
  * published by the Free Software Foundation.
 */
 
-/include/ "skeleton.dtsi"
-/include/ "exynos5250-pinctrl.dtsi"
+#include "exynos5.dtsi"
+#include "exynos5250-pinctrl.dtsi"
 
 / {
 	compatible = "samsung,exynos5250";
-	interrupt-parent = <&gic>;
 
 	aliases {
 		spi0 = &spi_0;
@@ -51,11 +50,6 @@
 		pinctrl3 = &pinctrl_3;
 	};
 
-	chipid@10000000 {
-		compatible = "samsung,exynos4210-chipid";
-		reg = <0x10000000 0x100>;
-	};
-
 	pd_gsc: gsc-power-domain@0x10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
@@ -72,17 +66,6 @@
 		#clock-cells = <1>;
 	};
 
-	gic:interrupt-controller@10481000 {
-		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x10481000 0x1000>,
-		      <0x10482000 0x1000>,
-		      <0x10484000 0x2000>,
-		      <0x10486000 0x2000>;
-		interrupts = <1 9 0xf04>;
-	};
-
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 0xf08>,
@@ -91,22 +74,6 @@
 			     <1 10 0xf08>;
 	};
 
-	combiner:interrupt-controller@10440000 {
-		compatible = "samsung,exynos4210-combiner";
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		samsung,combiner-nr = <32>;
-		reg = <0x10440000 0x1000>;
-		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
-			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
-			     <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
-			     <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
-			     <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
-			     <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
-			     <0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
-			     <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
-	};
-
 	mct@101C0000 {
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x101C0000 0x800>;
@@ -168,9 +135,6 @@
 	};
 
 	watchdog {
-		compatible = "samsung,s3c2410-wdt";
-		reg = <0x101D0000 0x100>;
-		interrupts = <0 42 0>;
 		clocks = <&clock 336>;
 		clock-names = "watchdog";
 	};
@@ -183,12 +147,8 @@
 	};
 
 	rtc {
-		compatible = "samsung,s3c6410-rtc";
-		reg = <0x101E0000 0x100>;
-		interrupts = <0 43 0>, <0 44 0>;
 		clocks = <&clock 337>;
 		clock-names = "rtc";
-		status = "disabled";
 	};
 
 	tmu@10060000 {
@@ -200,33 +160,21 @@
 	};
 
 	serial@12C00000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x12C00000 0x100>;
-		interrupts = <0 51 0>;
 		clocks = <&clock 289>, <&clock 146>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial@12C10000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x12C10000 0x100>;
-		interrupts = <0 52 0>;
 		clocks = <&clock 290>, <&clock 147>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial@12C20000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x12C20000 0x100>;
-		interrupts = <0 53 0>;
 		clocks = <&clock 291>, <&clock 148>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
 
 	serial@12C30000 {
-		compatible = "samsung,exynos4210-uart";
-		reg = <0x12C30000 0x100>;
-		interrupts = <0 54 0>;
 		clocks = <&clock 292>, <&clock 149>;
 		clock-names = "uart", "clk_uart_baud0";
 	};
@@ -405,31 +353,19 @@
 	};
 
 	dwmmc_0: dwmmc0@12200000 {
-		compatible = "samsung,exynos5250-dw-mshc";
 		reg = <0x12200000 0x1000>;
-		interrupts = <0 75 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clocks = <&clock 280>, <&clock 139>;
 		clock-names = "biu", "ciu";
 	};
 
 	dwmmc_1: dwmmc1@12210000 {
-		compatible = "samsung,exynos5250-dw-mshc";
 		reg = <0x12210000 0x1000>;
-		interrupts = <0 76 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clocks = <&clock 281>, <&clock 140>;
 		clock-names = "biu", "ciu";
 	};
 
 	dwmmc_2: dwmmc2@12220000 {
-		compatible = "samsung,exynos5250-dw-mshc";
 		reg = <0x12220000 0x1000>;
-		interrupts = <0 77 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		clocks = <&clock 282>, <&clock 141>;
 		clock-names = "biu", "ciu";
 	};
-- 
1.7.9.5

