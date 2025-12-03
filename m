Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4C2FB62A;
	Wed,  3 Dec 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764770384; cv=none; b=GI0d8b4Nk94/KWhLWQYwe59h06ZiKq9TN2nyCiiTHYFoXYPRvtISvbc1W+wldSuB6k/ru//rkWhZkCGFRGkyhAL06dSgOuDY0YLE4gNS8elTLcc2VMX9TQISxgnh9f0qC5F8PzR9XrSEctvlvvKcSgcyXUgoLhc6kFUM01UChjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764770384; c=relaxed/simple;
	bh=PGG/BBDoir47635rXyN/pOb1/Q58+J3wYynAC4uV1eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dR8nT048MST02Adymzl9QMhWTPeMkGbbFOaeIt98MEBZVYP/Gh9LQWeqHbsKL7FBnAYc28v0D4bn8xUpHrZOJjY8CiCYD8KirZOBg5KHuRtndXHgF9q3c9CN3iKbyVS+75p0kXhwT5ruUh9UUrKjEVGhHiW4Npm3qLF+b0JnNV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ncZPQQwq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ncZPQQwq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764770380;
	bh=PGG/BBDoir47635rXyN/pOb1/Q58+J3wYynAC4uV1eM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ncZPQQwqC8wQ9fxHgXx3vfc672o4sk914eYYLbZ2luVTEMB60cYi6hxMu5vDqmImy
	 UQlua7F0CWYelW+kOgguLcCr6H5FVlOcjc6q+Jn5nYInlfy3naGxDz+Krn+HQsVtwh
	 8jzF12+Gtx9wbX0SrWqRFN3RHtbja0Insvx26t8raasspC1sbw9a5fCTRfR04hazQy
	 rmAxGKjo4EHvYRE00g1lxCrTmIOUTQmMoV0ivjRkdNavQ4fOPGSYEB73uG6QGJVf21
	 66VbSXrHNroDP8/3/MTAk7EiP7ngaz/h4PBWa3SQW55tiO898Ypi7+G7fMr3RGtERf
	 BSdonW0qje54Q==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 536D517E10F2;
	Wed,  3 Dec 2025 14:59:39 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 03 Dec 2025 14:59:28 +0100
Subject: [PATCH 3/4] arm64: dts: mediatek: add device-tree for Genio
 720-EVK board
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-add-mediatek-genio-520-720-evk-v1-3-df794b2a30ae@collabora.com>
References: <20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com>
In-Reply-To: <20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764770376; l=39232;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=PGG/BBDoir47635rXyN/pOb1/Q58+J3wYynAC4uV1eM=;
 b=xy1hsraCcjZTSN8m7z7iTJZULgyg1EXKxIsLvPzocgbOs8B+DjpvPOuMH2Z5PsC3b2OknMbrl
 8mDmWIpBtsNA7aq+Vayc0yReZ1d/9rv02uIpio04BSvReMMjRRVOARy
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add support for MediaTek MT8189 SoC and its variants, and a device-tree
for the basic hardware enablement of the Genio 720-EVK board, based on
MT8391 SoC.

MT8391 SoC is a variant of MT8189 SoC with a difference for the Arm
Cortex-A78 CPU core maximum frequency (2.6 Ghz for MT8391, 3 Ghz for
MT8189). MT8391 hardware register maps are identical to MT8189.

The Genio 720-EVK board has following features:
  - MT8391 SoC
  - MT6365 PMIC
  - MT6319 Buck IC
  - MT6375 Charger IC
  - 8GB LPDDR5 RAM
  - 64GB eMMC 5.1
  - 128GB UFS
  - 20V DC Jack
  - USB Type-C Power Adapter
  - Micro SD card slot
  - Push Button x 4 (Power, Reset, Download and Home Key)
  - LED x 3 (System Power, Reset, DC-IN Power)
  - USB Type-C Connector (USB 3.2) x 2
  - USB Type-C Connector (USB 2.0) x 1
  - 3.5mm Earphone Jack x 1 (with Microphone Input)
  - 3.5mm Line Out Audio Jack x 1
  - Analog Microphone x 1
  - Digital Microphone x 2
  - Gigabit Ethernet with RJ45 connector
  - DP x 1 (Mode over USB Type-C)
  - LVDS port x 1
  - eDP port x 1
  - UART x2 with serial-to-usb converters and USB Type-C connectors
  - UART Port x 2 on Pin Header
  - M.2 Slot x 2
  - I2C Capacitive Touch Pad
  - 4-Lane DSI x 1
  - 4-Data Lane CSI x 2
  - I2S Pin header
  - 40-Pin 2.54mm Pin Header x 1
  - CAN Bus x 1 (RS232 Connector)

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 arch/arm64/boot/dts/mediatek/mt8189.dtsi           | 860 +++++++++++++++++++++
 .../boot/dts/mediatek/mt8391-genio-720-evk.dts     |  15 +
 .../boot/dts/mediatek/mt8391-genio-common.dtsi     | 555 +++++++++++++
 4 files changed, 1431 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index c5fd6191a925ad8fcea401712f7a686e8b0a57c8..e3b63085c0608b86dc8638c9d5e0b73441e9ed7b 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -110,6 +110,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk-ufs.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-grinn-genio-700-sbc.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8391-genio-720-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-kontron-3-5-sbc-i1200.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l-8-hd-panel.dtbo
diff --git a/arch/arm64/boot/dts/mediatek/mt8189.dtsi b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..bf8a232bcaf10cdf4c590109aea68c9a3e82cc42
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
@@ -0,0 +1,860 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *
+ * Copyright (c) 2025 Collabora Ltd.
+ * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "mediatek,mt8189";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		serial0 = &uart0;
+	};
+
+	clk32k: oscillator-clk32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32000>;
+		clock-output-names = "clk32k";
+	};
+
+	clk13m: oscillator-clk13m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-mult = <1>;
+		clock-div = <2>;
+		clock-output-names = "clk13m";
+	};
+
+	clk26m: oscillator-clk26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	clk104m: oscillator-clk104m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-mult = <4>;
+		clock-div = <1>;
+		clock-output-names = "clk104m";
+	};
+
+	ulposc: oscillator-ulposc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <520000000>;
+		clock-output-names = "ulposc";
+	};
+
+	ulposc3: oscillator-ulposc3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "ulposc3";
+	};
+
+	vowpll: oscillator-vowpll {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "vowpll";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x000>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x400>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x500>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <282>;
+			cpu-idle-states = <&cpu_off_l>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
+			#cooling-cells = <2>;
+		};
+
+		cpu6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x600>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_off_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
+			#cooling-cells = <2>;
+		};
+
+		cpu7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78";
+			reg = <0x700>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_off_b>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
+			#cooling-cells = <2>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+
+				core4 {
+					cpu = <&cpu4>;
+				};
+
+				core5 {
+					cpu = <&cpu5>;
+				};
+
+				core6 {
+					cpu = <&cpu6>;
+				};
+
+				core7 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			cpu_off_l: cpu-off-l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010000>;
+				local-timer-stop;
+				entry-latency-us = <25>;
+				exit-latency-us = <57>;
+				min-residency-us = <5700>;
+			};
+
+			cpu_off_b: cpu-off-b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x00010000>;
+				local-timer-stop;
+				entry-latency-us = <35>;
+				exit-latency-us = <82>;
+				min-residency-us = <1890>;
+			};
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <131072>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <262144>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			next-level-cache = <&l3_0>;
+			cache-unified;
+		};
+
+		l3_0: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <2048>;
+			cache-unified;
+		};
+	};
+
+	memory: memory@40000000 {
+		device_type = "memory";
+		/* This memory size is filled in by the bootloader */
+		reg = <0 0x40000000 0 0>;
+	};
+
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
+	};
+
+	pmu-a78 {
+		compatible = "arm,cortex-a78-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		performance: performance-controller@108d78 {
+			compatible = "mediatek,cpufreq-hw";
+			reg = <0 0x00108d78 0 0x120>, <0 0x00108e98 0 0x120>;
+			#performance-domain-cells = <1>;
+		};
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			reg = <0 0xc000000 0 0x40000>, /* distributor */
+			      <0 0xc040000 0 0x200000>; /* redistributor */
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			#redistributor-regions = <1>;
+
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3 &cpu4 &cpu5>;
+				};
+
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&cpu6 &cpu7>;
+				};
+			};
+		};
+
+		auxadc: adc@11019000 {
+			compatible = "mediatek,mt8189-auxadc", "mediatek,mt8173-auxadc";
+			reg = <0 0x11019000 0 0x1000>;
+			clocks = <&pericfg_ao_clk CLK_PERAO_AUXADC_26M>;
+			clock-names = "main";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
+		clock-controller@1000c000 {
+			compatible = "mediatek,mt8189-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1a000000 {
+			compatible = "mediatek,mt8189-camsys-main", "syscon";
+			reg = <0 0x1a000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1a04f000 {
+			compatible = "mediatek,mt8189-camsys-rawa", "syscon";
+			reg = <0 0x1a04f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1a06f000 {
+			compatible = "mediatek,mt8189-camsys-rawb", "syscon";
+			reg = <0 0x1a06f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@d01a000 {
+			compatible = "mediatek,mt8189-dbg-ao", "syscon";
+			reg = <0 0xd01a000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@d0a0000 {
+			compatible = "mediatek,mt8189-dem", "syscon";
+			reg = <0 0xd0a0000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@14000000 {
+			compatible = "mediatek,mt8189-dispsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1c00f000 {
+			compatible = "mediatek,mt8189-dvfsrc-top", "syscon";
+			reg = <0 0x1c00f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1e980000 {
+			compatible = "mediatek,mt8189-gce-d", "syscon";
+			reg = <0 0x1e980000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1e990000 {
+			compatible = "mediatek,mt8189-gce-m", "syscon";
+			reg = <0 0x1e990000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		iic_wrap_e_clk: clock-controller@11c22e00 {
+			compatible = "mediatek,mt8189-iic-wrap-e", "syscon";
+			reg = <0 0x11c22e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		iic_wrap_en_clk: clock-controller@11f32e00 {
+			compatible = "mediatek,mt8189-iic-wrap-en", "syscon";
+			reg = <0 0x11f32e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		iic_wrap_s_clk: clock-controller@11d74e00 {
+			compatible = "mediatek,mt8189-iic-wrap-s", "syscon";
+			reg = <0 0x11d74e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		iic_wrap_ws_clk: clock-controller@11b21e00 {
+			compatible = "mediatek,mt8189-iic-wrap-ws", "syscon";
+			reg = <0 0x11b21e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@15020000 {
+			compatible = "mediatek,mt8189-imgsys1", "syscon";
+			reg = <0 0x15020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@15820000 {
+			compatible = "mediatek,mt8189-imgsys2", "syscon";
+			reg = <0 0x15820000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@10001000 {
+			compatible = "mediatek,mt8189-infra-ao", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1b000000 {
+			compatible = "mediatek,mt8189-ipesys", "syscon";
+			reg = <0 0x1b000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1f000100 {
+			compatible = "mediatek,mt8189-mdpsys", "syscon";
+			reg = <0 0x1f000100 0 0x20>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@13fbf000 {
+			compatible = "mediatek,mt8189-mfgcfg", "syscon";
+			reg = <0 0x13fbf000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1e800000 {
+			compatible = "mediatek,mt8189-mm-infra", "syscon";
+			reg = <0 0x1e800000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		pericfg_ao_clk: clock-controller@11036000 {
+			compatible = "mediatek,mt8189-peri-ao", "syscon";
+			reg = <0 0x11036000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		topckgen_clk: clock-controller@10000000 {
+			compatible = "mediatek,mt8189-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1c80ae10 {
+			compatible = "mediatek,mt8189-scp-i2c-clk", "syscon";
+			reg = <0 0x1c80ae10 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1cb21150 {
+			compatible = "mediatek,mt8189-scp-clk", "syscon";
+			reg = <0 0x1cb21150 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@112b8000 {
+			compatible = "mediatek,mt8189-ufscfg-ao", "syscon";
+			reg = <0 0x112b8000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		clock-controller@112bb000 {
+			compatible = "mediatek,mt8189-ufscfg-pdn", "syscon";
+			reg = <0 0x112bb000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		clock-controller@1602f000 {
+			compatible = "mediatek,mt8189-vdec-core", "syscon";
+			reg = <0 0x1602f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@17000000 {
+			compatible = "mediatek,mt8189-venc", "syscon";
+			reg = <0 0x17000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1c000800 {
+			compatible = "mediatek,mt8189-vlp-ao", "syscon";
+			reg = <0 0x1c000800 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		vlpcfg_ao_clk: clock-controller@1c00c000 {
+			compatible = "mediatek,mt8189-vlpcfg-ao", "syscon";
+			reg = <0 0x1c00c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vlpckgen_clk: clock-controller@1c012000 {
+			compatible = "mediatek,mt8189-vlpckgen", "syscon";
+			reg = <0 0x1c012000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		efuse@11f10000 {
+			compatible = "mediatek,mt8189-efuse", "mediatek,mt8186-efuse";
+			reg = <0 0x11f10000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			socinfo-data1@7a0 {
+				reg = <0x7a0 0x4>;
+			};
+
+			socinfo-data2@7e0 {
+				reg = <0x7e0 0x4>;
+			};
+		};
+
+		i2c0: i2c@11c20000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11c20000 0 0x1000>,
+			      <0 0x11300200 0 0x80>;
+			clock-div = <1>;
+			#address-cells = <1>;
+			clocks = <&iic_wrap_e_clk CLK_IMPE_I2C0>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@11c21000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11c21000 0 0x1000>,
+			      <0 0x11300300 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_e_clk CLK_IMPE_I2C1>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@11b20000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11b20000 0 0x1000>,
+			      <0 0x11300400 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_ws_clk CLK_IMPWS_I2C2>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@11d70000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d70000 0 0x1000>,
+			      <0 0x11300500 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_s_clk CLK_IMPS_I2C3>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@11d71000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d71000 0 0x1000>,
+			      <0 0x11300600 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_s_clk CLK_IMPS_I2C4>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@11d72000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d72000 0 0x1000>,
+			      <0 0x11300700 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_s_clk CLK_IMPS_I2C5>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@11d73000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d73000 0 0x1000>,
+			      <0 0x11300800 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_s_clk CLK_IMPS_I2C6>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@11f30000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11f30000 0 0x1000>,
+			      <0 0x11300900 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_en_clk CLK_IMPEN_I2C7>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@11f31000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11f31000 0 0x1000>,
+			      <0 0x11300a00 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_en_clk CLK_IMPEN_I2C8>,
+				 <&pericfg_ao_clk CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt8189-mmc";
+			reg = <0 0x11230000 0 0x10000>,
+			      <0 0x11e70000 0 0x1000>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC50_0_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC0_H>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC0>;
+			clock-names = "source", "hclk", "source_cg";
+			interrupts = <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt8189-mmc";
+			reg = <0 0x11240000 0 0x1000>,
+			      <0 0x11d80000 0 0x1000>;
+			clocks = <&topckgen_clk CLK_TOP_MSDC30_1_SEL>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC1_H>,
+				 <&pericfg_ao_clk CLK_PERAO_MSDC1>;
+			clock-names = "source", "hclk", "source_cg";
+			interrupts = <GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		pio: pinctrl@10005000 {
+			compatible = "mediatek,mt8189-pinctrl";
+			reg = <0 0x10005000 0 0x1000>,
+			      <0 0x11b50000 0 0x1000>,
+			      <0 0x11c50000 0 0x1000>,
+			      <0 0x11c60000 0 0x1000>,
+			      <0 0x11d20000 0 0x1000>,
+			      <0 0x11d30000 0 0x1000>,
+			      <0 0x11d40000 0 0x1000>,
+			      <0 0x11e20000 0 0x1000>,
+			      <0 0x11e30000 0 0x1000>,
+			      <0 0x11f20000 0 0x1000>,
+			      <0 0x11ce0000 0 0x1000>,
+			      <0 0x11de0000 0 0x1000>,
+			      <0 0x11e60000 0 0x1000>,
+			      <0 0x1c01e000 0 0x1000>,
+			      <0 0x11f00000 0 0x1000>;
+			reg-names = "base", "lm", "rb0", "rb1", "bm0", "bm1",
+				    "bm2", "lt0", "lt1", "rt", "eint0", "eint1",
+				    "eint2", "eint3", "eint4";
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pio 0 0 182>;
+			interrupt-controller;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH 0>;
+			#interrupt-cells = <2>;
+		};
+
+		pwrap: pwrap@1cc04000 {
+			compatible = "mediatek,mt8189-pwrap", "mediatek,mt8195-pwrap", "syscon";
+			reg = <0 0x1cc04000 0 0x1000>;
+			reg-names = "pwrap";
+			assigned-clocks = <&vlpckgen_clk CLK_VLP_CK_PWRAP_ULPOSC_SEL>;
+			assigned-clock-parents = <&topckgen_clk CLK_TOP_OSC_D10>;
+			clocks =  <&vlpcfg_ao_clk CLK_VLPCFG_REG_PMIF_SPMI_M_SYS>,
+				  <&vlpcfg_ao_clk CLK_VLPCFG_REG_PMIF_SPMI_M_TMR>;
+			clock-names = "spi", "wrap";
+			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		spmi: spmi@1cc06000 {
+			compatible = "mediatek,mt8189-spmi", "mediatek,mt8195-spmi";
+			reg = <0 0x1cc06000 0 0x0008ff>,
+			      <0 0x1cc00000 0 0x000100>;
+			reg-names = "pmif", "spmimst";
+			clocks = <&vlpcfg_ao_clk CLK_VLPCFG_REG_PMIF_SPMI_P_SYS>,
+				 <&vlpcfg_ao_clk CLK_VLPCFG_REG_PMIF_SPMI_P_TMR>,
+				 <&vlpckgen_clk CLK_VLP_CK_SPMI_P_MST_SEL>;
+			clock-names = "pmif_sys_ck", "pmif_tmr_ck", "spmimst_clk_mux";
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		timer@1cc10000 {
+			compatible = "mediatek,mt8189-timer", "mediatek,mt6765-timer";
+			reg = <0 0x1cc10000 0 0x1000>;
+			clocks = <&clk13m>;
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		uart0: serial@11001000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11001000 0 0x1000>;
+			interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&pericfg_ao_clk CLK_PERAO_UART0>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		uart1: serial@11002000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x1000>;
+			interrupts = <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&pericfg_ao_clk CLK_PERAO_UART1>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		uart2: serial@11003000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x1000>;
+			interrupts = <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&pericfg_ao_clk CLK_PERAO_UART2>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		uart3: serial@11004000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11004000 0 0x1000>;
+			interrupts = <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&pericfg_ao_clk CLK_PERAO_UART3>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+
+		watchdog@1c00a000 {
+			compatible = "mediatek,mt8189-wdt", "mediatek,mt6589-wdt";
+			reg = <0 0x1c00a000 0 0x100>;
+			#reset-cells = <1>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8391-genio-720-evk.dts b/arch/arm64/boot/dts/mediatek/mt8391-genio-720-evk.dts
new file mode 100644
index 0000000000000000000000000000000000000000..ddb6cdb95b04b2b732b24588b3ea2ee023ddf884
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8391-genio-720-evk.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+/dts-v1/;
+
+#include "mt8189.dtsi"
+#include "mt8391-genio-common.dtsi"
+
+/ {
+	model = "MediaTek Genio 720 EVK";
+	compatible = "mediatek,mt8391-evk", "mediatek,mt8391",
+		     "mediatek,mt8189";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..744641916952111a4b389cf6adbd27c429b6eff2
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi
@@ -0,0 +1,555 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+
+#include "mt6359.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+#include "mt8189-pinfunc.h"
+
+/ {
+	aliases {
+		mmc0 = &mmc0;
+		serial0 = &uart0;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: memory@54600000 {
+			reg = <0 0x54600000 0x0 0x200000>;
+			no-map;
+		};
+	};
+};
+
+&auxadc {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&mt6359_vmodem_buck_reg>;
+};
+
+&cpu1 {
+	cpu-supply = <&mt6359_vmodem_buck_reg>;
+};
+
+&cpu2 {
+	cpu-supply = <&mt6359_vmodem_buck_reg>;
+};
+
+&cpu3 {
+	cpu-supply = <&mt6359_vmodem_buck_reg>;
+};
+
+&cpu4 {
+	cpu-supply = <&mt6359_vmodem_buck_reg>;
+};
+
+&cpu5 {
+	cpu-supply = <&mt6359_vmodem_buck_reg>;
+};
+
+&cpu6 {
+	cpu-supply = <&mt6319_vbuck1>;
+};
+
+&cpu7 {
+	cpu-supply = <&mt6319_vbuck1>;
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <1000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	status = "disabled";
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	status = "okay";
+};
+
+&i2c5 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+	status = "okay";
+};
+
+&i2c6 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+	status = "okay";
+};
+
+&i2c7 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c7_pins>;
+	status = "okay";
+};
+
+&i2c8 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c8_pins>;
+	status = "okay";
+};
+
+&mmc0 {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	hs400-ds-delay = <0x1481b>;
+	max-frequency = <200000000>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	no-sdio;
+	no-sd;
+	non-removable;
+	supports-cqe;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_default_pins>;
+	pinctrl-1 = <&mmc0_uhs_pins>;
+	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
+	status = "okay";
+};
+
+&mmc1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cd-gpios = <&pio 2 GPIO_ACTIVE_HIGH>;
+	max-frequency = <200000000>;
+	no-mmc;
+	no-sdio;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_default_pins>;
+	pinctrl-1 = <&mmc1_uhs_pins>;
+	vmmc-supply = <&mt6359_vpa_buck_reg>;
+	vqmmc-supply = <&mt6359_vsim1_ldo_reg>;
+	status = "okay";
+};
+
+&mt6359_va09_ldo_reg{
+	regulator-name = "dvdd_sram_vadsp";
+	regulator-always-on;
+};
+
+&mt6359_vaux18_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vbbck_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vcore_buck_reg {
+	regulator-name = "dvdd_apu";
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_buck_reg {
+	regulator-name = "dvdd_sram_core";
+	regulator-always-on;
+};
+
+&mt6359_vmodem_buck_reg {
+	regulator-name = "dvdd_proc_l";
+	regulator-always-on;
+};
+
+&mt6359_vproc1_buck_reg {
+	regulator-name = "vgpu";
+};
+
+&mt6359_vproc2_buck_reg {
+	regulator-name = "dvdd_core";
+	regulator-always-on;
+};
+
+&mt6359_vpu_buck_reg {
+	regulator-name = "avdd075_emi";
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-name = "va12_abb2";
+	regulator-always-on;
+};
+
+&mt6359_vrfck_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsram_md_ldo_reg {
+	regulator-name = "dvdd_sram_proc_l";
+	regulator-always-on;
+};
+
+&mt6359_vsram_proc1_ldo_reg {
+	/delete-property/ regulator-always-on;
+
+	regulator-name = "vsram_gpu";
+};
+
+&mt6359_vsram_proc2_ldo_reg {
+	regulator-name = "dvdd_sram_proc_b";
+	regulator-always-on;
+};
+
+&mt6359_vsram_others_ldo_reg {
+	regulator-name = "dvdd_sram_apu";
+	regulator-always-on;
+};
+
+&mt6359_vufs_ldo_reg {
+	regulator-always-on;
+};
+
+&pio {
+	i2c0_pins: i2c0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO52__FUNC_SDA0>,
+				 <PINMUX_GPIO51__FUNC_SCL0>;
+			bias-pull-up;
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO54__FUNC_SDA1>,
+				 <PINMUX_GPIO53__FUNC_SCL1>;
+			bias-pull-up;
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		pins {
+			pinmux = <PINMUX_GPIO56__FUNC_SDA2>,
+				 <PINMUX_GPIO55__FUNC_SCL2>;
+			bias-pull-up;
+		};
+	};
+
+	i2c3_pins: i2c3-pins {
+		pins {
+			pinmux = <PINMUX_GPIO58__FUNC_SDA3>,
+				 <PINMUX_GPIO57__FUNC_SCL3>;
+			bias-pull-up;
+		};
+	};
+
+	i2c4_pins: i2c4-pins {
+		pins {
+			pinmux = <PINMUX_GPIO60__FUNC_SDA4>,
+				 <PINMUX_GPIO59__FUNC_SCL4>;
+			bias-pull-up;
+		};
+	};
+	i2c5_pins: i2c5-pins {
+		pins {
+			pinmux = <PINMUX_GPIO62__FUNC_SDA5>,
+				 <PINMUX_GPIO61__FUNC_SCL5>;
+			bias-pull-up;
+		};
+	};
+
+	i2c6_pins: i2c6-pins {
+		pins {
+			pinmux = <PINMUX_GPIO64__FUNC_SDA6>,
+				 <PINMUX_GPIO63__FUNC_SCL6>;
+			bias-pull-up;
+		};
+	};
+
+	i2c7_pins: i2c7-pins {
+		pins {
+			pinmux = <PINMUX_GPIO66__FUNC_SDA7>,
+				 <PINMUX_GPIO65__FUNC_SCL7>;
+			bias-pull-up;
+		};
+	};
+
+	i2c8_pins: i2c8-pins {
+		pins {
+			pinmux = <PINMUX_GPIO68__FUNC_SDA8>,
+				 <PINMUX_GPIO67__FUNC_SCL8>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_default_pins: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
+		};
+	};
+
+	mmc0_uhs_pins: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO167__FUNC_MSDC0_DSL>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
+		};
+	};
+
+	mmc1_default_pins: mmc1-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO173__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO168__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO2__FUNC_GPIO2>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_uhs_pins: mmc1-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO169__FUNC_MSDC1_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO170__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO171__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO172__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO173__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO168__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO31__FUNC_UTXD0>,
+				 <PINMUX_GPIO32__FUNC_URXD0>;
+			bias-pull-up;
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO33__FUNC_UTXD1>,
+				 <PINMUX_GPIO34__FUNC_URXD1>;
+			bias-pull-up;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		pins {
+			pinmux = <PINMUX_GPIO35__FUNC_UTXD2>,
+				 <PINMUX_GPIO36__FUNC_URXD2>;
+			bias-pull-up;
+		};
+
+		pins-rtscts {
+			pinmux = <PINMUX_GPIO16__FUNC_UCTS2>,
+				 <PINMUX_GPIO17__FUNC_URTS2>;
+		};
+	};
+
+	uart3_pins: uart3-pins {
+		pins {
+			pinmux = <PINMUX_GPIO37__FUNC_UTXD3>,
+				 <PINMUX_GPIO38__FUNC_URXD3>;
+			bias-pull-up;
+		};
+
+		pins-rtscts {
+			pinmux = <PINMUX_GPIO14__FUNC_UCTS3>,
+				 <PINMUX_GPIO15__FUNC_URTS3>;
+		};
+	};
+};
+
+&pmic {
+	interrupts-extended = <&pio 194 IRQ_TYPE_LEVEL_HIGH>;
+
+	keys {
+		compatible = "mediatek,mt6359-keys";
+		mediatek,long-press-mode = <1>;
+		power-off-time-sec = <0>;
+
+		power-key {
+			linux,keycodes = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		home {
+			linux,keycodes = <KEY_HOME>;
+		};
+	};
+};
+
+&spmi {
+	pmic@7 {
+		compatible = "mediatek,mt6319-regulator", "mediatek,mt6315-regulator";
+		reg = <0x7 SPMI_USID>;
+
+		regulators {
+			mt6319_vbuck1: vbuck1 {
+				regulator-name = "dvdd_proc_b";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+
+			vbuck2 {
+				regulator-name = "vbuck2";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+
+			vbuck3 {
+				regulator-name = "vdd2h_emi";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+
+			vbuck4 {
+				regulator-name = "avddq_emi";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-0 = <&uart3_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};

-- 
2.52.0

