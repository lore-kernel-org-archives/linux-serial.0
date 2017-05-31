From: YT Shen <yt.shen@mediatek.com>
Subject: [PATCH v2 2/2] arm64: dts: Add Mediatek SoC MT2712 and evaluation board dts and Makefile
Date: Wed, 31 May 2017 19:39:33 +0800
Message-ID: <1496230773-22633-3-git-send-email-yt.shen@mediatek.com>
References: <1496230773-22633-1-git-send-email-yt.shen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496230773-22633-1-git-send-email-yt.shen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mars Cheng <mars.cheng@mediatek.com>, YT Shen <yt.shen@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
List-Id: linux-serial@vger.kernel.org

This adds basic chip support for Mediatek 2712

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts |  39 +++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 166 ++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712e.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 9fbfd32..fcc0604 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
new file mode 100644
index 0000000..e526c0f
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Author: YT Shen <yt.shen@mediatek.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0 OR MIT)
+ */
+
+/dts-v1/;
+#include "mt2712e.dtsi"
+
+/ {
+	model = "MediaTek MT2712 evaluation board";
+	compatible = "mediatek,mt2712-evb", "mediatek,mt2712";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+		linux,initrd-start = <0x45000000>;
+		linux,initrd-end   = <0x4a000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
new file mode 100644
index 0000000..6df0da9
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -0,0 +1,166 @@
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Author: YT Shen <yt.shen@mediatek.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0 OR MIT)
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt2712";
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu2>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x000>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x001>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x200>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	uart_clk: dummy26m {
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+		#clock-cells = <0>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13
+			      (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			      (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			      (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			      (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		uart5: serial@1000f000 {
+			compatible = "mediatek,mt2712-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x1000f000 0 0x400>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		sysirq: interrupt-controller@10220a80 {
+			compatible = "mediatek,mt2712-sysirq",
+				     "mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0 0x10220a80 0 0x40>;
+		};
+
+		gic: interrupt-controller@10510000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x10510000 0 0x1000>,
+			      <0 0x10520000 0 0x1000>,
+			      <0 0x10540000 0 0x2000>,
+			      <0 0x10560000 0 0x2000>;
+			interrupts = <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt2712-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x400>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart1: serial@11003000 {
+			compatible = "mediatek,mt2712-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x400>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial@11004000 {
+			compatible = "mediatek,mt2712-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11004000 0 0x400>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart3: serial@11005000 {
+			compatible = "mediatek,mt2712-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11005000 0 0x400>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart4: serial@11019000 {
+			compatible = "mediatek,mt2712-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11019000 0 0x400>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+	};
+};
+
-- 
1.9.1
