Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84CDC433E8
	for <linux-serial@archiver.kernel.org>; Sat, 20 Mar 2021 01:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD1261927
	for <linux-serial@archiver.kernel.org>; Sat, 20 Mar 2021 01:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhCTB5P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 21:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCTB4y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 21:56:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018C8C061760;
        Fri, 19 Mar 2021 18:56:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so5715896pjb.0;
        Fri, 19 Mar 2021 18:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5T8590RX5yVXQILzjAheE+JLX7fUxt32gwKK8l2HW2w=;
        b=ZwHiKs/Uf+Bl0a9ulk0kdGs9uztueKKG400dOut0IZbbEdLf++h1aDW/vTn3g59kKU
         LL2DoQbGNXCKhBw0xWSrosFaxni/rEw4xfPHyxyf85XS9oielHE86/vHqoiK7fDL+jGo
         IOF8lCF9MI32mj58VOv6hPCC4cXZg1V6v/sW0+boN+VoSFsxS8O8qBnBFWHuaFwraqbW
         Izbc19bxSadMZOn+NDjkkSojkyQUsTVgjqF9Jj4adhLdVoOf9gOtkO5PIaLveja9Bx1j
         RLRkeljTqNgVul97SY/CXG6kaZHqlYn4yVMjAZTjrew4QwnhlfCilz4wVvd9odZ7vVSO
         hamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5T8590RX5yVXQILzjAheE+JLX7fUxt32gwKK8l2HW2w=;
        b=iJejz6cITCQGsOXt3YCB4M7zpbY7Wddl/aVDR8CIz+8ZUetNFzHrWD7kUIi9CDeGWu
         4/ylG3H60DL6bEfZ+2A6zN4KMy83cZ0Xe4FQ3DVaKGpYDyNVYdEWkfaMu6ffrbr9u1zK
         Gxr2pPM1L/iu6Fpi9ACQGQ6KGUnuefk3L3gmwL8Gfisr+qmwtkXEIHLqVLnT66g5nLCn
         ma0w2O064ZclkKfOcRPv5EepnJrLSfj9X0PPEnWAtLNtXo/bnmAVVZWkjtvaGlnIK6fS
         kfENlfHAHdZJHjsiT8Yw1eq3HRl+rvqwZy/YCobwwy0h/zztMOXY6kdMSYNMDjo1wtMm
         imwQ==
X-Gm-Message-State: AOAM530y0/nrMhta3ccqY0s4JTJ65bfQN92iXefCD+ppvSzr8+EfRUvi
        7FtgxC4XTgSxk2h9I2WEdMI=
X-Google-Smtp-Source: ABdhPJyT1R3jhmD4RIi5AsIj4O9BsFhNcMMOQDHM+l5bHIoTdKv/AKTJlI5oWh4uNXeRUrHcxBT0IQ==
X-Received: by 2002:a17:90a:540d:: with SMTP id z13mr1343328pjh.150.1616205413521;
        Fri, 19 Mar 2021 18:56:53 -0700 (PDT)
Received: from localhost.localdomain ([204.44.111.4])
        by smtp.gmail.com with ESMTPSA id y7sm5755904pgp.23.2021.03.19.18.56.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 18:56:53 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        robh+dt@kernel.org, a.fatoum@pengutronix.de,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, linux-serial@vger.kernel.org,
        lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 6/9] ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
Date:   Sat, 20 Mar 2021 09:56:20 +0800
Message-Id: <1616205383-24114-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
References: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset has following changes:

- introduce stm32h750.dtsi to support stm32h750 value line
- add stm32h750i-art-pi.dtb (arch/arm/boot/dts/Makefile)
- add dts binding usart3 for bt, uart4 for console
  usart3/uart4 pinctrl in stm32h7-pinctrl.dtsi
  usart3/uart4 register in stm32h743.dtsi
- add dts binding sdmmc2 for wifi
  sdmmc2 pinctrl in stm32h7-pinctrl.dtsi
  sdmmc2 register in stm32h743.dtsi
- add spi1 pinctrl in stm32h7-pinctrl.dtsi for spi flash
- add stm32h750-art-pi.dts to support art-pi board
- add pinctrl: pin-controller@58020000 {} to fix dtbs_check warrnings

art-pi board component:
- 8MiB qspi flash
- 16MiB spi flash
- 32MiB sdram
- ap6212 wifi&bt&fm

the detail board information can be found at:
https://art-pi.gitee.io/website/

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 500cdb23d608 ("ARM: dts: stm32: Add STM32H743 MCU and STM32H743i-EVAL board")
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v4:
- add Reported-by and Fixes tag
- replace 'C' to 'c' in hex to fix dtbs_check warrnings

 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/stm32h743.dtsi        | 153 ++++++++++++++++++++-
 arch/arm/boot/dts/stm32h750.dtsi        |   6 +
 arch/arm/boot/dts/stm32h750i-art-pi.dts | 229 ++++++++++++++++++++++++++++++++
 4 files changed, 387 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8e5d4ab4e75e..a19c5ab9df84 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1071,6 +1071,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32746g-eval.dtb \
 	stm32h743i-eval.dtb \
 	stm32h743i-disco.dtb \
+	stm32h750i-art-pi.dtb \
 	stm32mp153c-dhcom-drc02.dtb \
 	stm32mp157a-avenger96.dtb \
 	stm32mp157a-dhcor-avenger96.dtb \
diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 4ebffb0a45a3..4379063d36a2 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -135,6 +135,22 @@
 			clocks = <&rcc USART2_CK>;
 		};
 
+		usart3: serial@40004800 {
+			compatible = "st,stm32h7-uart";
+			reg = <0x40004800 0x400>;
+			interrupts = <39>;
+			status = "disabled";
+			clocks = <&rcc USART3_CK>;
+		};
+
+		uart4: serial@40004c00 {
+			compatible = "st,stm32h7-uart";
+			reg = <0x40004c00 0x400>;
+			interrupts = <52>;
+			status = "disabled";
+			clocks = <&rcc UART4_CK>;
+		};
+
 		i2c1: i2c@40005400 {
 			compatible = "st,stm32f7-i2c";
 			#address-cells = <1>;
@@ -159,7 +175,7 @@
 			status = "disabled";
 		};
 
-		i2c3: i2c@40005C00 {
+		i2c3: i2c@40005c00 {
 			compatible = "st,stm32f7-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -368,6 +384,20 @@
 			max-frequency = <120000000>;
 		};
 
+		sdmmc2: mmc@48022400 {
+			compatible = "arm,pl18x", "arm,primecell";
+			arm,primecell-periphid = <0x10153180>;
+			reg = <0x48022400 0x400>;
+			interrupts = <124>;
+			interrupt-names	= "cmd_irq";
+			clocks = <&rcc SDMMC2_CK>;
+			clock-names = "apb_pclk";
+			resets = <&rcc STM32H7_AHB2_RESET(SDMMC2)>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			max-frequency = <120000000>;
+		};
+
 		exti: interrupt-controller@58000000 {
 			compatible = "st,stm32h7-exti";
 			interrupt-controller;
@@ -392,7 +422,7 @@
 			status = "disabled";
 		};
 
-		i2c4: i2c@58001C00 {
+		i2c4: i2c@58001c00 {
 			compatible = "st,stm32f7-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -555,6 +585,125 @@
 			snps,pbl = <8>;
 			status = "disabled";
 		};
+
+		pinctrl: pin-controller@58020000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x58020000 0x3000>;
+			interrupt-parent = <&exti>;
+			st,syscfg = <&syscfg 0x8>;
+			pins-are-numbered;
+
+			gpioa: gpio@58020000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x0 0x400>;
+				clocks = <&rcc GPIOA_CK>;
+				st,bank-name = "GPIOA";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiob: gpio@58020400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x400 0x400>;
+				clocks = <&rcc GPIOB_CK>;
+				st,bank-name = "GPIOB";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioc: gpio@58020800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x800 0x400>;
+				clocks = <&rcc GPIOC_CK>;
+				st,bank-name = "GPIOC";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiod: gpio@58020c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0xc00 0x400>;
+				clocks = <&rcc GPIOD_CK>;
+				st,bank-name = "GPIOD";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioe: gpio@58021000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1000 0x400>;
+				clocks = <&rcc GPIOE_CK>;
+				st,bank-name = "GPIOE";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiof: gpio@58021400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1400 0x400>;
+				clocks = <&rcc GPIOF_CK>;
+				st,bank-name = "GPIOF";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiog: gpio@58021800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1800 0x400>;
+				clocks = <&rcc GPIOG_CK>;
+				st,bank-name = "GPIOG";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioh: gpio@58021c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1c00 0x400>;
+				clocks = <&rcc GPIOH_CK>;
+				st,bank-name = "GPIOH";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioi: gpio@58022000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2000 0x400>;
+				clocks = <&rcc GPIOI_CK>;
+				st,bank-name = "GPIOI";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpioj: gpio@58022400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2400 0x400>;
+				clocks = <&rcc GPIOJ_CK>;
+				st,bank-name = "GPIOJ";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+
+			gpiok: gpio@58022800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2800 0x400>;
+				clocks = <&rcc GPIOK_CK>;
+				st,bank-name = "GPIOK";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/stm32h750.dtsi b/arch/arm/boot/dts/stm32h750.dtsi
new file mode 100644
index 000000000000..41e3b1e3a874
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h750.dtsi
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright (C) STMicroelectronics 2021 - All Rights Reserved */
+
+#include "stm32h743.dtsi"
+
+
diff --git a/arch/arm/boot/dts/stm32h750i-art-pi.dts b/arch/arm/boot/dts/stm32h750i-art-pi.dts
new file mode 100644
index 000000000000..098181efd172
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h750i-art-pi.dts
@@ -0,0 +1,229 @@
+/*
+ * Copyright 2021 - Dillon Min <dillon.minfei@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * For art-pi board resources, you can refer to link:
+ * 	https://art-pi.gitee.io/website/
+ */
+
+/dts-v1/;
+#include "stm32h750.dtsi"
+#include "stm32h750-pinctrl.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "RT-Thread STM32H750i-ART-PI board";
+	compatible = "st,stm32h750i-art-pi", "st,stm32h750";
+
+	chosen {
+		bootargs = "root=/dev/ram";
+		stdout-path = "serial0:2000000n8";
+	};
+
+	memory@c0000000 {
+		device_type = "memory";
+		reg = <0xc0000000 0x2000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			no-map;
+			size = <0x100000>;
+			linux,dma-default;
+		};
+	};
+
+	aliases {
+		serial0 = &uart4;
+		serial1 = &usart3;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-red {
+			gpios = <&gpioi 8 0>;
+		};
+		led-green {
+			gpios = <&gpioc 15 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	v3v3: regulator-v3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "v3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wlan_pwr: regulator-wlan {
+		compatible = "regulator-fixed";
+
+		regulator-name = "wl-reg";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpioc 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&clk_hse {
+	clock-frequency = <25000000>;
+};
+
+&dma1 {
+	status = "okay";
+};
+
+&dma2 {
+	status = "okay";
+};
+
+&mac {
+	status = "disabled";
+	pinctrl-0	= <&ethernet_rmii>;
+	pinctrl-names	= "default";
+	phy-mode	= "rmii";
+	phy-handle	= <&phy0>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	broken-cd;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	status = "okay";
+};
+
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a>;
+	broken-cd;
+	non-removable;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&wlan_pwr>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-0 = <&spi1_pins>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpioa 4 GPIO_ACTIVE_LOW>;
+	dmas = <&dmamux1 37 0x400 0x05>,
+	       <&dmamux1 38 0x400 0x05>;
+	dma-names = "rx", "tx";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+
+		partition@0 {
+			label = "root filesystem";
+			reg = <0 0x1000000>;
+		};
+	};
+};
+
+&usart2 {
+	pinctrl-0 = <&usart2_pins>;
+	pinctrl-names = "default";
+	status = "disabled";
+};
+
+&usart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usart3_pins>;
+	dmas = <&dmamux1 45 0x400 0x05>,
+	       <&dmamux1 46 0x400 0x05>;
+	dma-names = "rx", "tx";
+	st,hw-flow-ctrl;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		host-wakeup-gpios = <&gpioc 0 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpioi 10 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpioi 11 GPIO_ACTIVE_HIGH>;
+		max-speed = <115200>;
+	};
+};
+
+&uart4 {
+	pinctrl-0 = <&uart4_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+
-- 
1.9.1

