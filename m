Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C79121ADB9;
	Mon, 17 Mar 2025 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195815; cv=none; b=ZtrT7nxeuerxSaK35PA5FEl/WY2Nr03O5FxumN9YO3IQw+TND9TA+j7ta8/D5TaNrS79VXJlb4EtH2QbZ2h0N4f3t9WO8yCDQ9DOMPMOzNj/Hye3jzVr8/Do3pebd1kBWRGNKtdllIrQP4B8+zUzmBLdd4Cswp/Zx8xf69hsQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195815; c=relaxed/simple;
	bh=+POl+cmFoKPhYkGV3YX5zWEpHLNlNQsomdnoqKxuy2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbPVbytYgkCOrqd3vXvEbJCJ5p01/YPuLIpooOYOzQyjpyG/aoaNyIheC9ksE+1+TrnF7ssxrigRpdVhcumlldFCIGfAOknHvWzeqb5N2CLet4/2V1IMLGBMqW78E5VJrS0wVe100kztrsKfiTdQKUPnB2jRA1EKvd2M9Zv4iEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5u+/YZF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5u+/YZF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A110EC4CEF9;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742195814;
	bh=+POl+cmFoKPhYkGV3YX5zWEpHLNlNQsomdnoqKxuy2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=K5u+/YZF9ntEnP4rRqgtZm7fn+XobY064azNj1tPFBySkBUhQ91vGq248wh4ps0jG
	 G41YGrCSXuCvnCo6kG53qZn+yutS5t8Bgn/u4Pesv6BYLRlOm75cXYccB0MyNMIoft
	 X1UZ0AlnF0H3pKNfgPetz4YsCHSMhd2YQmv8zBQ5NNlYEZ/TvjkxmdWpzQp/ZPAVrF
	 D2Pt8WzRVqnOPySic5VhOEO7KCOwnJSvuMQBjT6B0f5Rn7c+aAZluvdATJm9P8hsmq
	 QdNynfVS1yMFET6RehBr+4GEcqopGM2Oe0JjHsCQQpNpw2d1Yvk3PdtsK5rK0KOphB
	 1jMmJzg0TYybA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938DFC35FF3;
	Mon, 17 Mar 2025 07:16:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 17 Mar 2025 15:16:56 +0800
Subject: [PATCH 5/7] arm64: dts: add support for S6 based Amlogic BL209
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-s6-s7-basic-v1-5-d653384e41f3@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742195812; l=5125;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=oaHHrXYztSUX5H9tDHb6+XL+HhxX9T90X3WIPyLsShA=;
 b=PQ30eNzSbUMN+efF01ZAa0kgUW/jaIejKIkNHePyU3v/mQJmlraWXuZOlUh/cVzVLZYrqgtv8
 o5gEJqKrfESDlIE64d6aW/G2prpBP/V75dMCkVPOkp+MgspZQ+/6pWR
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic S6 is an advanced application processor designed for
hybrid OTT/IP Set Top Box and high-end media box applications.

Add basic support for the S6 based Amlogic BL209 board, which describes
the following components: CPU, GIC, IRQ, Timer and UART.
These are capable of booting up into the serial console.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../boot/dts/amlogic/amlogic-s6-s905x5-bl209.dts   | 42 ++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        | 97 ++++++++++++++++++++++
 3 files changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 2fbda8419c65..a1ad8fa9999f 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_MESON) += amlogic-a4-a113l2-ba400.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-a5-a113x2-av400.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c302x-aw409.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-c3-c308l-aw419.dtb
+dtb-$(CONFIG_ARCH_MESON) += amlogic-s6-s905x5-bl209.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-an400.dtb
 dtb-$(CONFIG_ARCH_MESON) += amlogic-t7-a311d2-khadas-vim4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s6-s905x5-bl209.dts b/arch/arm64/boot/dts/amlogic/amlogic-s6-s905x5-bl209.dts
new file mode 100644
index 000000000000..c45b22651798
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s6-s905x5-bl209.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Amlogic, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "amlogic-s6.dtsi"
+/ {
+	model = "Amlogic S905X5 BL209 Development Board";
+	compatible = "amlogic,bl209", "amlogic,s6";
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
+		reg = <0x0 0x000000 0x0 0xe0000000>,
+		      <0x1 0x000000 0x0 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 27 MiB reserved for ARM Trusted Firmware */
+		secmon_reserved: secmon@5000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x05000000 0x0 0x1b00000>;
+			no-map;
+		};
+	};
+};
+
+&uart_b {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
new file mode 100644
index 000000000000..a8c90245c42a
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/gpio/gpio.h>
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a510";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a510";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a510";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a510";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+		};
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
+		gic: interrupt-controller@ff200000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xff200000 0 0x10000>,
+			      <0x0 0xff240000 0 0x80000>;
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
+				compatible = "amlogic,s6-uart",
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


