Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACF6C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 10:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0993610FC
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 10:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbhI1Kt7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbhI1Kt6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Sep 2021 06:49:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53852C061575;
        Tue, 28 Sep 2021 03:48:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t11so13875250plq.11;
        Tue, 28 Sep 2021 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJZR9w8hI2LD2vHDZX/H3aDABh040dBibJcAnh5URyU=;
        b=NBobBBPAoaIjh0xECEjWcV08qKXbrV8MH4hrrhCW8AVqfGxPnwVcIcgux5uWBByIF7
         q4jUTzeBbneWuvyrXK5ERbhXT0F2hVwEtJVGrizB2G3x6MQFKI5b7nvjP/IjNKSxsKMo
         e1JgOtHdsP9LDPtzJXHXb1rPlA0WYfKvhAcNu8bbYXMm/j6K3X7EBYO4ZJFXmlc/LnhL
         WkSDzV+ovDlLkGHqpNfUv43okxIVE/WG28LtGhoTbYZ6Yg7k6xVCKxLn6w4/k/BrrjZO
         WeddJLsln0hyfgh4X8UnXsFm7FkXrINCbemiArQUoIgeROIlIg06Cp2zrn7MXitCQJQx
         onOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJZR9w8hI2LD2vHDZX/H3aDABh040dBibJcAnh5URyU=;
        b=6u7KB2vCKOSaa15osdvbOHNs44zRw+3ZbsLLZmX2OGKcc/n9vQGPBvjns8nW5zsGUt
         bTT44kg1E/VINz/CPgSLwbJVKHq33qMfqWs8pJMvVC2OAImer+rm3TRQZQbVd07aRPuV
         nRy/jOVlJvqsaaAsrnydGUOrnbXk67ar3HHgdKy+06QqPM6qgiRdy9GPZnlI9tuvClpo
         NkZdDfHtiZfygVP3/MCZMllFRDmS9CK5Ib2AULNDfeKt8zSAO00r2OSVI4YAeDg+wLoV
         Fvs6IxGp4ZP/HolhZnCa4ppEt0UTcVLx/AvxTUOq5/Y9ds6lkCUWQkUmxM5KG8BmfCB0
         yQzA==
X-Gm-Message-State: AOAM532rSyouahYJMh7U51a4DnJzEPB7wI4KFhuR9Fms/LIQ12a/ovzR
        Vw0tF4onklcREhi5X3+qDyE=
X-Google-Smtp-Source: ABdhPJyAqWrGmDI7FsZNyBa2XMSoRiVSs58UXcx1KtZu7IZ17grlfBqS5iruggUIRDPLISVJ6ziegA==
X-Received: by 2002:a17:90a:6286:: with SMTP id d6mr4723082pjj.199.1632826098647;
        Tue, 28 Sep 2021 03:48:18 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v4sm2300380pjr.32.2021.09.28.03.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:48:18 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: Add support for Unisoc's UMS512
Date:   Tue, 28 Sep 2021 18:48:04 +0800
Message-Id: <20210928104804.240144-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928095229.233572-4-zhang.lyra@gmail.com>
References: <20210928095229.233572-4-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add basic DT to support Unisoc's UMS512, with this patch,
the board ums512-1h10 can run into console.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/Makefile        |   3 +-
 arch/arm64/boot/dts/sprd/sc2730.dtsi     | 262 +++++++
 arch/arm64/boot/dts/sprd/ums512-1h10.dts |  69 ++
 arch/arm64/boot/dts/sprd/ums512.dtsi     | 919 +++++++++++++++++++++++
 4 files changed, 1252 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/sprd/sc2730.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/ums512-1h10.dts
 create mode 100644 arch/arm64/boot/dts/sprd/ums512.dtsi

diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dts/sprd/Makefile
index f4f1f5148cc2..97522fb0bf66 100644
--- a/arch/arm64/boot/dts/sprd/Makefile
+++ b/arch/arm64/boot/dts/sprd/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb \
 			sp9860g-1h10.dtb	\
-			sp9863a-1h10.dtb
+			sp9863a-1h10.dtb	\
+			ums512-1h10.dtb
diff --git a/arch/arm64/boot/dts/sprd/sc2730.dtsi b/arch/arm64/boot/dts/sprd/sc2730.dtsi
new file mode 100644
index 000000000000..cd4d4abcfca6
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sc2730.dtsi
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Unisoc SC2730 PMIC dts file
+ *
+ * Copyright (C) 2021, Unisoc Inc.
+ */
+
+&adi_bus {
+	sc2730_pmic: pmic@0 {
+		compatible = "sprd,sc2730";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		power-controller@1800 {
+			compatible = "sprd,sc2730-regulator";
+
+			vddcpu: DCDC_CPU {
+				regulator-name = "vddcpu";
+				regulator-min-microvolt = <200000>;
+				regulator-max-microvolt = <1596875>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddgpu: DCDC_GPU {
+				regulator-name = "vddgpu";
+				regulator-min-microvolt = <200000>;
+				regulator-max-microvolt = <1596875>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddcore: DCDC_CORE {
+				regulator-name = "vddcore";
+				regulator-min-microvolt = <200000>;
+				regulator-max-microvolt = <1596875>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddmodem: DCDC_MODEM {
+				regulator-name = "vddmodem";
+				regulator-min-microvolt = <200000>;
+				regulator-max-microvolt = <1596875>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddmem: DCDC_MEM {
+				regulator-name = "vddmem";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1593750>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddmemq: DCDC_MEMQ {
+				regulator-name = "vddmemq";
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1596875>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddgen0: DCDC_GEN0 {
+				regulator-name = "vddgen0";
+				regulator-min-microvolt = <1220000>;
+				regulator-max-microvolt = <2410625>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddgen1: DCDC_GEN1 {
+				regulator-name = "vddgen1";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1643750>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddsram: DCDC_SRAM {
+				regulator-name = "vddsram";
+				regulator-min-microvolt = <200000>;
+				regulator-max-microvolt = <1596875>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			avdd18: LDO_AVDD18 {
+				regulator-name = "avdd18";
+				regulator-min-microvolt = <1175000>;
+				regulator-max-microvolt = <1805000>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddrf18: LDO_VDDRF18 {
+				regulator-name = "vddrf18";
+				regulator-min-microvolt = <1175000>;
+				regulator-max-microvolt = <1805000>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddcamio: LDO_VDDCAMIO {
+				regulator-name = "vddcamio";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1830000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddwcn: LDO_VDDWCN {
+				regulator-name = "vddwcn";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1845000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddcamd1: LDO_VDDCAMD1 {
+				regulator-name = "vddcamd1";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1365000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddcamd0: LDO_VDDCAMD0 {
+				regulator-name = "vddcamd0";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1365000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddrf1v25: LDO_VDDRF1V25 {
+				regulator-name = "vddrf1v25";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1365000>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			avdd12: LDO_AVDD12 {
+				regulator-name = "avdd12";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1365000>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddcama0: LDO_VDDCAMA0 {
+				regulator-name = "vddcama0";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddcama1: LDO_VDDCAMA1 {
+				regulator-name = "vddcama1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddcammot: LDO_VDDCAMMOT {
+				regulator-name = "vddcammot";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddsim2: LDO_VDDSIM2 {
+				regulator-name = "vddsim2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddemmccore: LDO_VDDEMMCCORE {
+				regulator-name = "vddemmccore";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddsdcore: LDO_VDDSDCORE {
+				regulator-name = "vddsdcore";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddsdio: LDO_VDDSDIO {
+				regulator-name = "vddsdio";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vdd28: LDO_VDD28 {
+				regulator-name = "vdd28";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddwifipa: LDO_VDDWIFIPA {
+				regulator-name = "vddwifipa";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vdd18_dcxo: LDO_VDD18_DCXO {
+				regulator-name = "vdd18_dcxo";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+				regulator-always-on;
+			};
+
+			vddusb33: LDO_VDDUSB33 {
+				regulator-name = "vddusb33";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddldo0: LDO_VDDLDO0 {
+				regulator-name = "vddldo0";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddldo1: LDO_VDDLDO1 {
+				regulator-name = "vddldo1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddldo2: LDO_VDDLDO2 {
+				regulator-name = "vddldo2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+
+			vddkpled: LDO_VDDKPLED {
+				regulator-name = "vddkpled";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3750000>;
+				regulator-ramp-delay = <25000>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/sprd/ums512-1h10.dts b/arch/arm64/boot/dts/sprd/ums512-1h10.dts
new file mode 100644
index 000000000000..8722c3999ade
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/ums512-1h10.dts
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Unisoc UMS512-1h10 boards DTS file
+ *
+ * Copyright (C) 2021, Unisoc Inc.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "ums512.dtsi"
+#include "sc2730.dtsi"
+
+/ {
+	model = "Unisoc UMS512-1H10 Board";
+
+	compatible = "sprd,ums512-1h10", "sprd,ums512";
+
+	sprd,sc-id = <512 1 0x20000>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+		bootargs = "earlycon";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+/* SD card */
+&sdio0 {
+	status = "okay";
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	sprd,phy-delay-sd-uhs-sdr104 = <0x7f 0x73 0x72 0x72>;
+	sprd,phy-delay-sd-uhs-sdr50 = <0x6e 0x7f 0x01 0x01>;
+	sprd,phy-delay-sd-highspeed = <0x7f 0x1a 0x9a 0x9a>;
+	sprd,phy-delay-legacy = <0x7f 0x1a 0x9a 0x9a>;
+	vmmc-supply = <&vddsdcore>;
+	vqmmc-supply = <&vddsdio>;
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+};
+
+/* EMMC storage */
+&sdio3 {
+	status = "okay";
+	bus-width = <8>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	cap-mmc-hw-reset;
+};
diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
new file mode 100644
index 000000000000..028e17f8198e
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -0,0 +1,919 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Unisoc UMS512 SoC DTS file
+ *
+ * Copyright (C) 2021, Unisoc Inc.
+ */
+
+#include <dt-bindings/clock/sprd,ums512-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+				core2 {
+					cpu = <&CPU2>;
+				};
+				core3 {
+					cpu = <&CPU3>;
+				};
+				core4 {
+					cpu = <&CPU4>;
+				};
+				core5 {
+					cpu = <&CPU5>;
+				};
+				core6 {
+					cpu = <&CPU6>;
+				};
+				core7 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x400>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x500>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x600>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+
+		CPU7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x700>;
+			enable-method = "psci";
+			cpu-idle-states = <&CORE_PD>;
+		};
+	};
+
+	idle-states {
+		entry-method = "psci";
+		CORE_PD: core-pd {
+			compatible = "arm,idle-state";
+			entry-latency-us = <4000>;
+			exit-latency-us = <4000>;
+			min-residency-us = <10000>;
+			local-timer-stop;
+			arm,psci-suspend-param = <0x00010000>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* Physical Secure PPI */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Physical Non-Secure PPI */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Virtual PPI */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hipervisor PPI */
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@12000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			redistributor-stride = <0x0 0x20000>;	/* 128KB stride */
+			#redistributor-regions = <1>;
+			interrupt-controller;
+			reg = <0x0 0x12000000 0 0x20000>,	/* GICD */
+			      <0x0 0x12040000 0 0x100000>;	/* GICR */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		ap_ahb_regs: syscon@20100000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x20100000 0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x20100000 0x4000>;
+
+			apahb_gate: clock-controller@0 {
+				compatible = "sprd,ums512-apahb-gate";
+				reg = <0x0 0x3000>;
+				clocks = <&ext_26m>;
+				clock-names = "ext-26m";
+				#clock-cells = <1>;
+			};
+		};
+
+		pub_apb_regs: syscon@31050000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x31050000 0 0x9000>;
+		};
+
+		top_dvfs_apb_regs: syscon@322a0000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x322a0000 0 0x8000>;
+		};
+
+		ap_intc0_regs: syscon@32310000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x32310000 0 0x1000>;
+		};
+
+		ap_intc1_regs: syscon@32320000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x32320000 0 0x1000>;
+		};
+
+		ap_intc2_regs: syscon@32330000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x32330000 0 0x1000>;
+		};
+
+		ap_intc3_regs: syscon@32340000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x32340000 0 0x1000>;
+		};
+
+		ap_intc4_regs: syscon@32350000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x32350000 0 0x1000>;
+		};
+
+		ap_intc5_regs: syscon@32360000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x32360000 0 0x1000>;
+		};
+
+		anlg_phy_g0_regs: syscon@32390000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x32390000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x32390000 0x3000>;
+
+			dpll0: clock-controller@0 {
+				compatible = "sprd,ums512-g0-pll";
+				reg = <0x0 0x100>;
+				#clock-cells = <1>;
+			};
+		};
+
+		anlg_phy_g2_regs: syscon@323b0000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x323b0000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x323b0000 0x3000>;
+
+			mpll1: clock-controller@0 {
+				compatible = "sprd,ums512-g2-pll";
+				reg = <0x0 0x100>;
+				#clock-cells = <1>;
+			};
+		};
+
+		anlg_phy_g3_regs: syscon@323c0000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x323c0000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x323c0000 0x3000>;
+
+			pll1: clock-controller@0 {
+				compatible = "sprd,ums512-g3-pll";
+				reg = <0x0 0x3000>;
+				clocks = <&ext_26m>;
+				clock-names = "ext-26m";
+				#clock-cells = <1>;
+			};
+		};
+
+		anlg_phy_gc_regs: syscon@323e0000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x323e0000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x323e0000 0x3000>;
+
+			pll2: clock-controller@0 {
+				compatible = "sprd,ums512-gc-pll";
+				reg = <0x0 0x100>;
+				clock-names = "ext-26m";
+				#clock-cells = <1>;
+			};
+		};
+
+		anlg_phy_g10_regs: syscon@323f0000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x323f0000 0 0x3000>;
+		};
+
+		aon_apb_regs: syscon@327d0000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x327d0000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x327d0000 0x3000>;
+
+			aonapb_gate: clock-controller@0 {
+				compatible = "sprd,ums512-aon-gate";
+				reg = <0x0 0x3000>;
+				clocks = <&ext_26m>;
+				clock-names = "ext-26m";
+				#clock-cells = <1>;
+			};
+		};
+
+		pmu_apb_regs: syscon@327e0000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x327e0000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x327e0000 0x3000>;
+
+			pmu_gate: clock-controller@0 {
+				compatible = "sprd,ums512-pmu-gate";
+				reg = <0x0 0x3000>;
+				clocks = <&ext_26m>;
+				clock-names = "ext-26m";
+				#clock-cells = <1>;
+			};
+		};
+
+		audcp_apb_regs: syscon@3350d000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x3350d000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x3350d000 0x1000>;
+
+			audcpapb_gate: clock-controller@0 {
+				compatible = "sprd,ums512-audcpapb-gate";
+				reg = <0x0 0x300>;
+				#clock-cells = <1>;
+			};
+		};
+
+		audcp_ahb_regs: syscon@335e0000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x335e0000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x335e0000 0x1000>;
+
+			audcpahb_gate: clock-controller@0 {
+				compatible = "sprd,ums512-audcpahb-gate";
+				reg = <0x0 0x300>;
+				#clock-cells = <1>;
+			};
+		};
+
+		gpu_apb_regs: syscon@60100000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x60100000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x60100000 0x3000>;
+
+			gpu_clk: clock-controller@0 {
+				compatible = "sprd,ums512-gpu-clk";
+				clocks = <&ext_26m>;
+				clock-names = "ext-26m";
+				reg = <0x0 0x100>;
+				#clock-cells = <1>;
+			};
+		};
+
+		gpu_dvfs_apb_regs: syscon@60110000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x60110000 0 0x3000>;
+		};
+
+		mm_ahb_regs: syscon@62200000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x62200000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x62200000 0x3000>;
+
+			mm_gate: clock-controller@0 {
+				compatible = "sprd,ums512-mm-gate-clk";
+				reg = <0x0 0x3000>;
+				#clock-cells = <1>;
+			};
+		};
+
+		ap_apb_regs: syscon@71000000 {
+			compatible = "sprd,ums512-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x71000000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x71000000 0x3000>;
+
+			apapb_gate: clock-controller@0 {
+				compatible = "sprd,ums512-apapb-gate";
+				reg = <0x0 0x3000>;
+				#clock-cells = <1>;
+			};
+		};
+
+		ap_clk: clock-controller@20200000 {
+			compatible = "sprd,ums512-ap-clk";
+			reg = <0 0x20200000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "ext-26m";
+			#clock-cells = <1>;
+		};
+
+		aon_clk: clock-controller@32080000 {
+			compatible = "sprd,ums512-aonapb-clk";
+			reg = <0 0x32080000 0 0x1000>;
+			clocks = <&ext_26m>, <&ext_32k>,
+				 <&ext_4m>, <&rco_100m>;
+			clock-names = "ext-26m", "ext-32k",
+				      "ext-4m", "rco-100m";
+			#clock-cells = <1>;
+		};
+
+		mm_clk: clock-controller@62100000 {
+			compatible = "sprd,ums512-mm-clk";
+			reg = <0 0x62100000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "ext-26m";
+			#clock-cells = <1>;
+		};
+
+		/* SoC Funnel */
+		funnel@3c002000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x3c002000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_soc_out_port: endpoint {
+						remote-endpoint = <&etb_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+					funnel_soc_in_port: endpoint {
+						remote-endpoint =
+						<&funnel_corinth_out_port>;
+					};
+				};
+			};
+		};
+
+		/* SoC ETF */
+		soc_etb: etb@3c003000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x3c003000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			in-ports {
+				port {
+					etb_in: endpoint {
+						remote-endpoint =
+						<&funnel_soc_out_port>;
+					};
+				};
+			};
+		};
+
+		/* AP-CPU Funnel for core3/4/5/7 */
+		funnel@3e001000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x3e001000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_corinth_lit_out_port: endpoint {
+						remote-endpoint =
+						<&corinth_etf_lit_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_core_in_port3: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel_core_in_port4: endpoint {
+						remote-endpoint = <&etm4_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					funnel_core_in_port5: endpoint {
+						remote-endpoint = <&etm5_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					funnel_core_in_port7: endpoint {
+						remote-endpoint = <&etm7_out>;
+					};
+				};
+			};
+		};
+
+		/* AP-CPU ETF for little cores */
+		etf@3e002000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x3e002000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					corinth_etf_lit_out: endpoint {
+						remote-endpoint =
+						<&funnel_corinth_from_lit_in_port>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					corinth_etf_lit_in: endpoint {
+						remote-endpoint =
+						<&funnel_corinth_lit_out_port>;
+					};
+				};
+			};
+		};
+
+		/* AP-CPU ETF for big cores */
+		etf@3e003000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x3e003000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					corinth_etf_big_out: endpoint {
+						remote-endpoint =
+						<&funnel_corinth_from_big_in_port>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					corinth_etf_big_in: endpoint {
+						remote-endpoint =
+						<&funnel_corinth_big_out_port>;
+					};
+				};
+			};
+		};
+
+		/* Funnel to SoC */
+		funnel@3e004000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x3e004000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_corinth_out_port: endpoint {
+						remote-endpoint =
+						<&funnel_soc_in_port>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_corinth_from_lit_in_port: endpoint {
+						remote-endpoint = <&corinth_etf_lit_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel_corinth_from_big_in_port: endpoint {
+						remote-endpoint = <&corinth_etf_big_out>;
+					};
+				};
+			};
+		};
+
+		/* AP-CPU Funnel for core0/1/2/6 */
+		funnel@3e005000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0 0x3e005000 0 0x1000>;
+			clocks = <&ext_26m>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					funnel_corinth_big_out_port: endpoint {
+						remote-endpoint = <&corinth_etf_big_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_core_in_port0: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel_core_in_port1: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					funnel_core_in_port2: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					funnel_core_in_port6: endpoint {
+						remote-endpoint = <&etm6_out>;
+					};
+				};
+			};
+		};
+
+		etm0: etm@3f040000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x3f040000 0 0x1000>;
+			cpu = <&CPU0>;
+			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
+			clock-names = "apb_pclk", "clk_cs", "cs_src";
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+						<&funnel_core_in_port0>;
+					};
+				};
+			};
+		};
+
+		etm1: etm@3f140000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x3f140000 0 0x1000>;
+			cpu = <&CPU1>;
+			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
+			clock-names = "apb_pclk", "clk_cs", "cs_src";
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+						<&funnel_core_in_port1>;
+					};
+				};
+			};
+		};
+
+		etm2: etm@3f240000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x3f240000 0 0x1000>;
+			cpu = <&CPU2>;
+			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
+			clock-names = "apb_pclk", "clk_cs", "cs_src";
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+						<&funnel_core_in_port2>;
+					};
+				};
+			};
+		};
+
+		etm3: etm@3f340000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x3f340000 0 0x1000>;
+			cpu = <&CPU3>;
+			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
+			clock-names = "apb_pclk", "clk_cs", "cs_src";
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+						<&funnel_core_in_port3>;
+					};
+				};
+			};
+		};
+
+		etm4: etm@3f440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x3f440000 0 0x1000>;
+			cpu = <&CPU4>;
+			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
+			clock-names = "apb_pclk", "clk_cs", "cs_src";
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint =
+						<&funnel_core_in_port4>;
+					};
+				};
+			};
+		};
+
+		etm5: etm@3f540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x3f540000 0 0x1000>;
+			cpu = <&CPU5>;
+			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
+			clock-names = "apb_pclk", "clk_cs", "cs_src";
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint =
+						<&funnel_core_in_port5>;
+					};
+				};
+			};
+		};
+
+		etm6: etm@3f640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x3f640000 0 0x1000>;
+			cpu = <&CPU6>;
+			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
+			clock-names = "apb_pclk", "clk_cs", "cs_src";
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint =
+						<&funnel_core_in_port6>;
+					};
+				};
+			};
+		};
+
+		etm7: etm@3f740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0 0x3f740000 0 0x1000>;
+			cpu = <&CPU7>;
+			clocks = <&ext_26m>, <&aon_clk CLK_CSSYS>, <&pll2 CLK_TWPLL_512M>;
+			clock-names = "apb_pclk", "clk_cs", "cs_src";
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint =
+						<&funnel_core_in_port7>;
+					};
+				};
+			};
+		};
+
+
+		apb@70000000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x70000000 0x10000000>;
+
+			uart0: serial@0 {
+				compatible = "sprd,ums512-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x0 0x100>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+
+			uart1: serial@100000 {
+				compatible = "sprd,ums512-uart",
+					     "sprd,sc9836-uart";
+				reg = <0x100000 0x100>;
+				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_26m>;
+				status = "disabled";
+			};
+		};
+
+		ap-apb {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			sdio0: sdio@71100000 {
+				compatible = "sprd,sdhci-r11";
+				reg = <0 0x71100000 0 0x1000>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "sdio", "enable";
+				clocks = <&ap_clk CLK_SDIO0_2X>,
+					 <&apapb_gate CLK_SDIO0_EB>;
+				assigned-clocks = <&ap_clk CLK_SDIO0_2X>;
+				assigned-clock-parents = <&pll1 CLK_RPLL>;
+				status = "disabled";
+			};
+
+			sdio3: sdio@71400000 {
+				compatible = "sprd,sdhci-r11";
+				reg = <0 0x71400000 0 0x1000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				clock-names = "sdio", "enable";
+				clocks = <&ap_clk CLK_EMMC_2X>,
+					 <&apapb_gate CLK_EMMC_EB>;
+				assigned-clocks = <&ap_clk CLK_EMMC_2X>;
+				assigned-clock-parents = <&pll1 CLK_RPLL>;
+				status = "disabled";
+			};
+		};
+
+		aon {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			adi_bus: spi@32100000 {
+				compatible = "sprd,ums512-adi";
+				reg = <0 0x32100000 0 0x100000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				sprd,hw-channels = <2 0x18cc>, <3 0x18cc>, <13 0x1854>, <15 0x1874>,
+					<17 0x1844>,<19 0x1844>, <21 0x1864>, <30 0x1820>,
+					<35 0x19b8>, <39 0x19ac>;
+			};
+		};
+	};
+
+	ext_26m: ext-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "ext-26m";
+	};
+
+	ext_32k: ext-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ext-32k";
+	};
+
+	ext_4m: ext-4m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <4000000>;
+		clock-output-names = "ext-4m";
+	};
+
+	rco_100m: rco-100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "rco-100m";
+	};
+};
-- 
2.25.1

