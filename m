Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73821ADB5;
	Mon, 17 Mar 2025 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195815; cv=none; b=MIy0VVqagFviuUOcgTaj0xHdqpeTq8/M0vhyEhEMiWzXwMWT0lNq+lITbJ8kV1zirEIzb5kqcsG4ZAOHfSZP/EBPAE9jJwnzJz5SzpzySl2ZJBjFGTgIebMhNf/d56TI2jnIAEeUrzu5E4qLZGGIlwU9UNeJ4abV/WH6Dlb0vgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195815; c=relaxed/simple;
	bh=D7WMmAq5LBFJic8CyDRquVvn3q42V/MGb5HMDNqQ27A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=us6qcyidKb5nnquhr5PaoGIn3zw+qiPQyYnB107xTSJeuwXPXPCid2me8DOg2O5FoPLHOAVu/lJM3u0/POvFtCDOaw0lTvshx0RljSJfkzA6ytHoT7ilXNqnusn0l8ZAmDawedO8ESCnh9UvbSw0L1vssmkrM0v7IBzGFLuwlTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbcCiP//; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbcCiP//"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC96BC4CEE3;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742195814;
	bh=D7WMmAq5LBFJic8CyDRquVvn3q42V/MGb5HMDNqQ27A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZbcCiP//rEFhVYAwaOaqsysaKq2X8Uq7GiTk+8jCEED22qYwA6Y9+9jZoE8hWiUMO
	 BIUIhRGd3Hz6D8VShdUK+BGJO9GsTb0TfVUn+Y6fH2aTBmJrED7HJQEavkygvy3yPP
	 4PCn8LE1o0Zrz06bpJvyTMG+WueVm3WyCoBmxulpZzD61nCTcQ4rxDrQKH8MnE80io
	 HAtxiG2AhdEqyyA9AuumbQVxyjPy2PSWiqMZ7bElEIyZp8SlF05jDdYCcC4GBnOwzC
	 b9flXTx7ZfUmywidWH0Se3F4IzXJMzwBWRoDIhmiD3PZC+tikp1y+PpqzwEsSDrzw4
	 DJUu+NFay6k1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCA9C35FF3;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 17 Mar 2025 15:16:58 +0800
Subject: [PATCH 7/7] arm64: dts: add support for S7D based Amlogic BM202
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-s6-s7-basic-v1-7-d653384e41f3@amlogic.com>
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
In-Reply-To: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742195812; l=5083;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=8HBKGThj61yCyT/nevxdLdrGJPynTVZ5IStBzZD4tJU=;
 b=zMUWAkth54rtfWZJo8q97ktf7u0zaYTrr9GmYkz7XldWMUcbMRUAPf5U07/GRQiS51Fma6AJk
 l1kVqCrewARAPDQF7z5AF7HP1ZcBtmNzV0QoT33jUGPUX01oTtG0PuM
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic S7D is an advanced application processor designed for
hybrid OTT/IP Set Top Box and high-end media box applications.

Add basic support for the S7D based Amlogic BM202 board, Reusing
S7 basic components: CPU, GIC, IRQ, Timer and UART.
These are capable of booting up into the serial console.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../boot/dts/amlogic/amlogic-s7d-s905x5m-bm202.dts | 41 +++++++++
 arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       | 99 ++++++++++++++++++++++
 3 files changed, 141 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 29e1c7b9ee31..8c16c22c7b8e 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c308l-aw419.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-s6-s905x5-bl209.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-s7-s805x3-bp201.dtb
+dtb-$(CONFIG_ARCH_MESON) += amlogic-s7d-s905x5m-bm202.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7d-s905x5m-bm202.dts b/arch/arm64/boot/dts/amlogic/amlogic-s7d-s905x5m-bm202.dts
new file mode 100644
index 000000000000..2933fcdbc8ef
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s7d-s905x5m-bm202.dts
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Amlogic, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "amlogic-s7d.dtsi"
+/ {
+	model = "Amlogic S905X5M BM202 Development Board";
+	compatible = "amlogic,bm202", "amlogic,s7d";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart_b;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 36 MiB reserved for ARM Trusted Firmware */
+		secmon_reserved: secmon@5000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x05000000 0x0 0x2400000>;
+			no-map;
+		};
+	};
+};
+
+&uart_b {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
new file mode 100644
index 000000000000..e1099bc1535d
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+		};
+
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@fff01000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xfff01000 0 0x1000>,
+			      <0x0 0xfff02000 0 0x0100>;
+			interrupts = <GIC_PPI 9 0xf04>;
+		};
+
+		apb: bus@fe000000 {
+			compatible = "simple-bus";
+			reg = <0x0 0xfe000000 0x0 0x480000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
+
+			uart_b: serial@7a000 {
+				compatible = "amlogic,s7d-uart",
+					     "amlogic,meson-s4-uart";
+				reg = <0x0 0x7a000 0x0 0x18>;
+				interrupts = <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&xtal>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+		};
+	};
+};

-- 
2.37.1


