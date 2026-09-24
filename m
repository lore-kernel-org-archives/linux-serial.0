Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBA3DE44E;
	Thu, 24 Sep 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239192; cv=none; b=fgdGX57f4j8srvHEX8+QhlqfJIpLugsGErwLthWKJRW/9Y1oObumKQINORhSprXsGIuKiLNkqApGHFmkrmh41EgZthzozkJIGcnXIc+U1qf3Yo/E449+0edYCdo+M7S+K4tfxKMntFOzjJeHY5e7vbenDm1oxnUKoe6uX8uwUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239192; c=relaxed/simple;
	bh=2rIk7GmihKXYTYbfPRjc45AhpLzrlDwJNsILHp97t5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFn+EhjfxPzAsWYUydc2T8Op/eYoEEE2644dXbJPQpxGf8YX84t9f1b6oOgPMnEu6A+7zBwGUID+qYid13X9vq/knuSZxoTpxN/IDHgkpKL3t25mzM4kP0AaM1jC7GQuEEHMAI61NIK1qEsZ+VuxWeNpEgcVcvVp4NI5Dgc1C3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i40jjdbo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i40jjdbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790239186;
	bh=2rIk7GmihKXYTYbfPRjc45AhpLzrlDwJNsILHp97t5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i40jjdbojYIh39iyAOF7m+aKmtQjbfhtUfkxePSzjmAlvuZkGTWDByNpnALMa4zb8
	 4ikbe5CJD4uTWnUeC/48vYXWNPCWuMDMokCTfGPGNl0x8gNP50wUFsVJen5AkVNnJm
	 LnJV8bI6NMJi9w4OCf0NKTvraW7yjv52LNBtui6Nxu31zaCO6p7aP1ND6KL8pT+Owv
	 I6hE2ikukKLI/iCrg0o7jnECFMe2clXOefOAE7LKWm44N90BRnlwxbKuD7U9qLseD4
	 c0LD5bXKK16DXxilTDhTrm6ZpnkMfDHf7/etYsSKClvRVr6AO5Q/CACh+w5UMVINMg
	 /bA4yW53sT/pw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 40ABC17E0A68;
	Thu, 24 Sep 2026 10:39:46 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 24 Sep 2026 10:38:12 +0200
Subject: [PATCH v3 3/4] arm64: dts: mediatek: add Genio 720-EVK board
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-add-mediatek-genio-520-720-evk-v3-3-2ec5c80677d4@collabora.com>
References: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
In-Reply-To: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790239184; l=50418;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=2rIk7GmihKXYTYbfPRjc45AhpLzrlDwJNsILHp97t5o=;
 b=lXbD+srTLBeg3kwFyvKPhESOKpesGOjT1ewv2PsvzZO0YYL+Abz9EuWMauzOiH8M/4ryW00V3
 p0cls7kb44rAsjvRuDqMjaHOOZFjilAOlRchiHRbelel46C3v4TlMGp
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add support for MediaTek MT8189 SoC and its variants, and a devicetree
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
 arch/arm64/boot/dts/mediatek/Makefile              |    1 +
 arch/arm64/boot/dts/mediatek/mt8189.dtsi           | 1009 ++++++++++++++++++++
 .../boot/dts/mediatek/mt8391-genio-720-evk.dts     |   27 +
 .../boot/dts/mediatek/mt8391-genio-common.dtsi     |  798 ++++++++++++++++
 4 files changed, 1835 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a86fb313b1a9..5c75ea1ef09a 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk-ufs.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-grinn-genio-700-sbc.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-tungsten-smarc.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8391-genio-720-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-kontron-3-5-sbc-i1200.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-radxa-nio-12l-8-hd-panel.dtbo
diff --git a/arch/arm64/boot/dts/mediatek/mt8189.dtsi b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
new file mode 100644
index 000000000000..b64882a93151
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
@@ -0,0 +1,1009 @@
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
+#include <dt-bindings/power/mediatek,mt8189-power.h>
+#include <dt-bindings/phy/phy.h>
+
+/ {
+	compatible = "mediatek,mt8189";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clk32k: clock-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32000>;
+		clock-output-names = "clk32k";
+	};
+
+	clk13m: clock-13m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-mult = <1>;
+		clock-div = <2>;
+		clock-output-names = "clk13m";
+	};
+
+	clk26m: clock-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	clock-520m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <520000000>;
+		clock-output-names = "ulposc";
+	};
+
+	clock-vow-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "vowpll";
+	};
+
+	clock-auxadc-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "aud_adc_ext";
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
+	dsu-pmu {
+		compatible = "arm,dsu-pmu";
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
+		cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
+		       <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+		status = "fail";
+	};
+
+	fhctl: fhctl@1000ce00 {
+		compatible = "mediatek,mt8189-fhctl";
+		clocks = <&apmixedsys CLK_APMIXED_APUPLL>,
+			 <&apmixedsys CLK_APMIXED_APUPLL2>,
+			 <&apmixedsys CLK_APMIXED_ARMPLL_LL>,
+			 <&apmixedsys CLK_APMIXED_ARMPLL_BL>,
+			 <&apmixedsys CLK_APMIXED_CCIPLL>,
+			 <&apmixedsys CLK_APMIXED_EMIPLL>,
+			 <&apmixedsys CLK_APMIXED_MAINPLL>,
+			 <&apmixedsys CLK_APMIXED_MFGPLL>,
+			 <&apmixedsys CLK_APMIXED_MMPLL>,
+			 <&apmixedsys CLK_APMIXED_MSDCPLL>,
+			 <&apmixedsys CLK_APMIXED_TVDPLL1>,
+			 <&apmixedsys CLK_APMIXED_TVDPLL2>,
+			 <&apmixedsys CLK_APMIXED_UFSPLL>;
+		reg = <0 0x1000ce00 0 0x200>;
+		status = "okay";
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
+		clock-controller@d01a000 {
+			compatible = "mediatek,mt8189-dbg-ao";
+			reg = <0 0xd01a000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@d0a0000 {
+			compatible = "mediatek,mt8189-dem";
+			reg = <0 0xd0a0000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		topckgen: clock-controller@10000000 {
+			compatible = "mediatek,mt8189-topckgen", "syscon";
+			reg = <0 0x10000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		infra_ao: clock-controller@10001000 {
+			compatible = "mediatek,mt8189-infra-ao", "syscon";
+			reg = <0 0x10001000 0 0x1000>;
+			#clock-cells = <1>;
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
+		apmixedsys: clock-controller@1000c000 {
+			compatible = "mediatek,mt8189-apmixedsys", "syscon";
+			reg = <0 0x1000c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		uart0: serial@11001000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11001000 0 0x1000>;
+			interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&peri_ao CLK_PERAO_UART0>;
+			clock-names = "baud", "bus";
+			dmas = <&apdma 0>, <&apdma 1>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		uart1: serial@11002000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x1000>;
+			interrupts = <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&peri_ao CLK_PERAO_UART1>;
+			clock-names = "baud", "bus";
+			dmas = <&apdma 2>, <&apdma 3>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		uart2: serial@11003000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x1000>;
+			interrupts = <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&peri_ao CLK_PERAO_UART2>;
+			clock-names = "baud", "bus";
+			dmas = <&apdma 4>, <&apdma 5>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		uart3: serial@11004000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11004000 0 0x1000>;
+			interrupts = <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&peri_ao CLK_PERAO_UART3>;
+			clock-names = "baud", "bus";
+			dmas = <&apdma 6>, <&apdma 7>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		auxadc: adc@11019000 {
+			compatible = "mediatek,mt8189-auxadc", "mediatek,mt8173-auxadc";
+			reg = <0 0x11019000 0 0x1000>;
+			clocks = <&peri_ao CLK_PERAO_AUXADC_26M>;
+			clock-names = "main";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
+		eth: ethernet@1101a000 {
+			compatible = "mediatek,mt8189-gmac", "snps,dwmac-5.10a";
+			reg = <0 0x1101a000 0 0x4000>;
+			assigned-clocks = <&topckgen CLK_TOP_ETH_250M_SEL>,
+					  <&topckgen CLK_TOP_ETH_62P4M_PTP_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_ETHPLL_D2>,
+						 <&topckgen CLK_TOP_ETHPLL_D8>;
+			clocks = <&topckgen CLK_TOP_ETH_250M_SEL>,
+				 <&topckgen CLK_TOP_ETH_62P4M_PTP_SEL>;
+			clock-names = "mac_main", "ptp_ref";
+			interrupts = <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "macirq";
+			power-domains = <&spm MT8189_POWER_DOMAIN_PCIE>;
+			mediatek,pericfg = <&peri_ao>;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,mtl-rx-config = <&mtl_rx_setup>;
+			snps,mtl-tx-config = <&mtl_tx_setup>;
+			snps,txpbl = <16>;
+			snps,rxpbl = <16>;
+			snps,clk-csr = <0>;
+			status = "disabled";
+
+			mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			stmmac_axi_setup: stmmac-axi-config {
+				snps,blen = <0 0 0 0 16 8 4>;
+				snps,rd_osr_lmt = <0x7>;
+				snps,wr_osr_lmt = <0x7>;
+			};
+
+			mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <4>;
+				snps,rx-sched-sp;
+
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+
+				queue2 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+
+				queue3 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+				};
+			};
+
+			mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <4>;
+				snps,tx-sched-wrr;
+
+				queue0 {
+					snps,dcb-algorithm;
+					snps,priority = <0x0>;
+					snps,weight = <0x10>;
+				};
+
+				queue1 {
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+					snps,weight = <0x11>;
+				};
+
+				queue2 {
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+					snps,weight = <0x12>;
+				};
+
+				queue3 {
+					snps,dcb-algorithm;
+					snps,priority = <0x3>;
+					snps,weight = <0x13>;
+				};
+			};
+		};
+
+		peri_ao: clock-controller@11036000 {
+			compatible = "mediatek,mt8189-peri-ao", "syscon";
+			reg = <0 0x11036000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt8189-mmc";
+			reg = <0 0x11230000 0 0x10000>, <0 0x11e70000 0 0x1000>;
+			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
+				 <&peri_ao CLK_PERAO_MSDC0_H>,
+				 <&peri_ao CLK_PERAO_MSDC0>,
+				 <&topckgen CLK_TOP_MSDC50_0_HCLK_SEL>,
+				 <&peri_ao CLK_PERAO_MSDC0_SLV_H>,
+				 <&peri_ao CLK_PERAO_MSDC0_MST_F>;
+			clock-names = "source", "hclk", "source_cg",
+				      "bus_clk", "pclk_cg", "axi_cg";
+			interrupts = <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt8189-mmc";
+			reg = <0 0x11240000 0 0x1000>, <0 0x11d80000 0 0x1000>;
+			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
+				 <&peri_ao CLK_PERAO_MSDC1_H>,
+				 <&peri_ao CLK_PERAO_MSDC1>,
+				 <&topckgen CLK_TOP_MSDC30_1_HCLK_SEL>,
+				 <&peri_ao CLK_PERAO_MSDC1_SLV_H>,
+				 <&peri_ao CLK_PERAO_MSDC1_MST_F>;
+			clock-names = "source", "hclk", "source_cg",
+				      "bus_clk", "pclk_cg", "axi_cg";
+			interrupts = <GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH 0>;
+			status = "disabled";
+		};
+
+		clock-controller@112b8000 {
+			compatible = "mediatek,mt8189-ufscfg-ao";
+			reg = <0 0x112b8000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		clock-controller@112bb000 {
+			compatible = "mediatek,mt8189-ufscfg-pdn";
+			reg = <0 0x112bb000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		pcie: pcie@112f0000 {
+			compatible = "mediatek,mt8189-pcie", "mediatek,mt8192-pcie";
+			reg = <0 0x112f0000 0 0x4000>;
+			reg-names = "pcie-mac";
+			ranges = <0x82000000 0 0x30000000 0x0 0x30000000 0 0x04000000>;
+			bus-range = <0x00 0xff>;
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			clocks = <&peri_ao CLK_PERAO_AHB_APB>,
+				 <&topckgen CLK_TOP_F26M_CK_EN>,
+				 <&peri_ao CLK_PERAO_TL>,
+				 <&clk32k>,
+				 <&peri_ao CLK_PERAO_REF>,
+				 <&peri_ao CLK_PERAO_AXI>;
+			clock-names = "pl_250m", "tl_26m", "tl_96m",
+				      "tl_32k", "peri_26m", "peri_mem";
+			#interrupt-cells = <1>;
+			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-map = <0 0 0 1 &pcie_intc 0>,
+					<0 0 0 2 &pcie_intc 1>,
+					<0 0 0 3 &pcie_intc 2>,
+					<0 0 0 4 &pcie_intc 3>;
+			interrupt-map-mask = <0 0 0 7>;
+			phys = <&pcieport PHY_TYPE_PCIE>;
+			phy-names = "pcie-phy";
+			power-domains = <&spm MT8189_POWER_DOMAIN_PCIE>;
+			status = "disabled";
+
+			pcie_intc: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		apdma: dma-controller@11300b00 {
+			compatible = "mediatek,mt8189-uart-dma", "mediatek,mt6985-uart-dma";
+			reg = <0 0x11300b00 0 0x80>,
+			      <0 0x11300b80 0 0x80>,
+			      <0 0x11300c00 0 0x80>,
+			      <0 0x11300c80 0 0x80>,
+			      <0 0x11300d00 0 0x80>,
+			      <0 0x11300d80 0 0x80>,
+			      <0 0x11300e00 0 0x80>,
+			      <0 0x11300e80 0 0x80>;
+			interrupts = <GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 433 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&peri_ao CLK_PERAO_DMA_B>;
+			clock-names = "apdma";
+			dma-requests = <8>;
+			#dma-cells = <1>;
+		};
+
+		i2c2: i2c@11b20000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11b20000 0 0x1000>, <0 0x11300400 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_ws CLK_IMPWS_I2C2>, <&peri_ao CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		iic_wrap_ws: clock-controller@11b21e00 {
+			compatible = "mediatek,mt8189-iic-wrap-ws";
+			reg = <0 0x11b21e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		i2c0: i2c@11c20000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11c20000 0 0x1000>, <0 0x11300200 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_e CLK_IMPE_I2C0>, <&peri_ao CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@11c21000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11c21000 0 0x1000>, <0 0x11300300 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_e CLK_IMPE_I2C1>, <&peri_ao CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		iic_wrap_e: clock-controller@11c22e00 {
+			compatible = "mediatek,mt8189-iic-wrap-e";
+			reg = <0 0x11c22e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		i2c3: i2c@11d70000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d70000 0 0x1000>, <0 0x11300500 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_s CLK_IMPS_I2C3>, <&peri_ao CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@11d71000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d71000 0 0x1000>, <0 0x11300600 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_s CLK_IMPS_I2C4>, <&peri_ao CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@11d72000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d72000 0 0x1000>, <0 0x11300700 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_s CLK_IMPS_I2C5>, <&peri_ao CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@11d73000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11d73000 0 0x1000>, <0 0x11300800 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_s CLK_IMPS_I2C6>, <&peri_ao CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		iic_wrap_s: clock-controller@11d74e00 {
+			compatible = "mediatek,mt8189-iic-wrap-s";
+			reg = <0 0x11d74e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		pciephy: t-phy@11e50700 {
+			compatible = "mediatek,mt8189-tphy", "mediatek,generic-tphy-v3";
+			ranges = <0x0 0x0 0x11e50700 0x700>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			power-domains = <&spm MT8189_POWER_DOMAIN_PCIE_PHY>;
+			status = "disabled";
+
+			pcieport: pcie-phy@0 {
+				reg = <0 0x700>;
+				clocks = <&topckgen CLK_TOP_SSPXTP_F26M_CK_EN>;
+				clock-names = "ref";
+				#phy-cells = <1>;
+			};
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
+		i2c7: i2c@11f30000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11f30000 0 0x1000>, <0 0x11300900 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_en CLK_IMPEN_I2C7>, <&peri_ao CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@11f31000 {
+			compatible = "mediatek,mt8189-i2c", "mediatek,mt8188-i2c";
+			reg = <0 0x11f31000 0 0x1000>, <0 0x11300a00 0 0x80>;
+			#address-cells = <1>;
+			clock-div = <1>;
+			clocks = <&iic_wrap_en CLK_IMPEN_I2C8>, <&peri_ao CLK_PERAO_DMA_B>;
+			clock-names = "main", "dma";
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH 0>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		iic_wrap_en: clock-controller@11f32e00 {
+			compatible = "mediatek,mt8189-iic-wrap-en";
+			reg = <0 0x11f32e00 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1c000800 {
+			compatible = "mediatek,mt8189-vlpcfg-ao";
+			reg = <0 0x1c000800 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		scpsys: syscon@1c001000 {
+			compatible = "mediatek,mt8189-scpsys", "syscon", "simple-mfd";
+			reg = <0 0x1c001000 0 0x1000>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8189-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domain of the SoC */
+				power-domain@MT8189_POWER_DOMAIN_CONN {
+					reg = <MT8189_POWER_DOMAIN_CONN>;
+					mediatek,infracfg = <&infra_ao>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_AUDIO {
+					reg = <MT8189_POWER_DOMAIN_AUDIO>;
+					clocks = <&topckgen CLK_TOP_AUD_INTBUS_SEL>;
+					clock-names = "audio";
+					mediatek,infracfg = <&infra_ao>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_ADSP_AO {
+					reg = <MT8189_POWER_DOMAIN_ADSP_AO>;
+					clocks = <&vlpckgen CLK_VLP_CK_VADSP_SEL>;
+					clock-names = "vadsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8189_POWER_DOMAIN_ADSP_INFRA {
+						reg = <MT8189_POWER_DOMAIN_ADSP_INFRA>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT {
+							reg = <MT8189_POWER_DOMAIN_ADSP_TOP_DORMANT>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_SSUSB {
+					reg = <MT8189_POWER_DOMAIN_SSUSB>;
+					mediatek,infracfg = <&infra_ao>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8189_POWER_DOMAIN_PCIE {
+					reg = <MT8189_POWER_DOMAIN_PCIE>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8189_POWER_DOMAIN_PCIE_PHY {
+						reg = <MT8189_POWER_DOMAIN_PCIE_PHY>;
+						#power-domain-cells = <0>;
+					};
+				};
+			};
+		};
+
+		watchdog@1c00a000 {
+			compatible = "mediatek,mt8189-wdt", "mediatek,mt6589-wdt";
+			reg = <0 0x1c00a000 0 0x100>;
+			#reset-cells = <1>;
+		};
+
+		vlpcfg: clock-controller@1c00c000 {
+			compatible = "mediatek,mt8189-vlpcfg";
+			reg = <0 0x1c00c000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1c00f000 {
+			compatible = "mediatek,mt8189-dvfsrc-top";
+			reg = <0 0x1c00f000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vlpckgen: clock-controller@1c012000 {
+			compatible = "mediatek,mt8189-vlpckgen", "syscon";
+			reg = <0 0x1c012000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1c80ae10 {
+			compatible = "mediatek,mt8189-scp-i2c-clk";
+			reg = <0 0x1c80ae10 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		clock-controller@1cb21150 {
+			compatible = "mediatek,mt8189-scp-clk";
+			reg = <0 0x1cb21150 0 0x10>;
+			#clock-cells = <1>;
+		};
+
+		pwrap: pwrap@1cc04000 {
+			compatible = "mediatek,mt8189-pwrap", "mediatek,mt8195-pwrap", "syscon";
+			reg = <0 0x1cc04000 0 0x1000>;
+			reg-names = "pwrap";
+			assigned-clocks = <&vlpckgen CLK_VLP_CK_PWRAP_ULPOSC_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
+			clocks =  <&vlpcfg CLK_VLPCFG_REG_PMIF_SPMI_M_SYS>,
+				  <&vlpcfg CLK_VLPCFG_REG_PMIF_SPMI_M_TMR>;
+			clock-names = "spi", "wrap";
+			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH 0>;
+		};
+
+		spmi: spmi@1cc06000 {
+			compatible = "mediatek,mt8189-spmi", "mediatek,mt8195-spmi";
+			reg = <0 0x1cc06000 0 0x000e00>, <0 0x1cc00000 0 0x000100>;
+			reg-names = "pmif", "spmimst";
+			clocks = <&vlpcfg CLK_VLPCFG_REG_PMIF_SPMI_P_SYS>,
+				 <&vlpcfg CLK_VLPCFG_REG_PMIF_SPMI_P_TMR>,
+				 <&vlpckgen CLK_VLP_CK_SPMI_P_MST_SEL>;
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
index 000000000000..717077806e24
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8391-genio-720-evk.dts
@@ -0,0 +1,27 @@
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
+
+&cpu6 {
+	cpu-supply = <&mt6319_sid7_vbuck1>;
+};
+
+&cpu7 {
+	cpu-supply = <&mt6319_sid7_vbuck1>;
+};
+
+&mt6319_sid7 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi
new file mode 100644
index 000000000000..00c9f3c078f5
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8391-genio-common.dtsi
@@ -0,0 +1,798 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+
+#include "mt6365.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/spmi/spmi.h>
+#include "mt8189-pinfunc.h"
+
+/ {
+	aliases {
+		ethernet0 = &eth;
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
+
+	/* system wide 4.2V power rail from charger */
+	reg_vsys: regulator-vsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* used by PCIe Wi-Fi Module */
+	reg_wifi_3v3: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "wifi_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 79 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pcie_3v3_en_pins>;
+		vin-supply = <&reg_vsys>;
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
+&eth {
+	phy-handle = <&eth_phy0>;
+	phy-mode ="rgmii-id";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default_pins>;
+	pinctrl-1 = <&eth_sleep_pins>;
+	mediatek,mac-wol;
+	snps,reset-delays-us = <0 10000 10000>;
+	snps,reset-gpio = <&pio 135 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	mdio {
+		eth_phy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-idc0ff.0421";
+			reg = <0x0>;
+
+			leds {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* LED_D5 */
+				led@0 {
+					reg = <0>;
+					active-high;
+					color = <LED_COLOR_ID_YELLOW>;
+					default-state = "keep";
+					function = LED_FUNCTION_LAN;
+					function-enumerator = <0>;
+				};
+
+				/* LED_D6 */
+				led@1 {
+					reg = <1>;
+					active-high;
+					color = <LED_COLOR_ID_YELLOW>;
+					default-state = "keep";
+					function = LED_FUNCTION_LAN;
+					function-enumerator = <2>;
+				};
+
+				/* LED_D7 */
+				led@2 {
+					reg = <2>;
+					active-low;
+					color = <LED_COLOR_ID_GREEN>;
+					default-state = "keep";
+					function = LED_FUNCTION_LAN;
+					function-enumerator = <1>;
+				};
+			};
+		};
+	};
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
+&pcie {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pcie_default_pins>;
+	pinctrl-1 = <&pcie_sleep_pins>;
+	status = "okay";
+};
+
+&pciephy {
+	status = "okay";
+};
+
+&pio {
+	eth_default_pins: eth-default-pins {
+		pins-cc {
+			pinmux = <PINMUX_GPIO127__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO130__FUNC_GBE_TXEN>,
+				 <PINMUX_GPIO129__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO128__FUNC_GBE_RXC>;
+			drive-strength = <8>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO131__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO132__FUNC_GBE_MDIO>;
+			drive-strength = <8>;
+			input-enable;
+		};
+
+		pins-power {
+			pinmux = <PINMUX_GPIO133__FUNC_GPIO133>,
+				 <PINMUX_GPIO134__FUNC_GPIO134>;
+			output-high;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO123__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO124__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO125__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO126__FUNC_GBE_RXD0>;
+			drive-strength = <8>;
+		};
+
+		pins-txd {
+			pinmux = <PINMUX_GPIO119__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO120__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO121__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO122__FUNC_GBE_TXD0>;
+			drive-strength = <8>;
+		};
+	};
+
+	eth_sleep_pins: eth-sleep-pins {
+		pins-cc {
+			pinmux = <PINMUX_GPIO127__FUNC_GPIO127>,
+				 <PINMUX_GPIO130__FUNC_GPIO130>,
+				 <PINMUX_GPIO129__FUNC_GPIO129>,
+				 <PINMUX_GPIO128__FUNC_GPIO128>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO131__FUNC_GPIO131>,
+				 <PINMUX_GPIO132__FUNC_GPIO132>;
+			input-disable;
+			bias-disable;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO123__FUNC_GPIO123>,
+				 <PINMUX_GPIO124__FUNC_GPIO124>,
+				 <PINMUX_GPIO125__FUNC_GPIO125>,
+				 <PINMUX_GPIO126__FUNC_GPIO126>;
+		};
+
+		pins-txd {
+			pinmux = <PINMUX_GPIO119__FUNC_GPIO119>,
+				 <PINMUX_GPIO120__FUNC_GPIO120>,
+				 <PINMUX_GPIO121__FUNC_GPIO121>,
+				 <PINMUX_GPIO122__FUNC_GPIO122>;
+		};
+	};
+
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
+	pcie_default_pins: pcie-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO48__FUNC_WAKEN>,
+				 <PINMUX_GPIO49__FUNC_PERSTN>,
+				 <PINMUX_GPIO50__FUNC_CLKREQN>;
+			bias-pull-up;
+		};
+	};
+
+	pcie_sleep_pins: pcie-sleep-pins {
+		pins {
+			pinmux = <PINMUX_GPIO49__FUNC_PERSTN>;
+			bias-disable;
+			output-low;
+		};
+	};
+
+	pcie_3v3_en_pins: pcie-3v3-en-pins {
+		pins {
+			pinmux = <PINMUX_GPIO79__FUNC_GPIO79>;
+			output-high;
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
+	vsys-smps-supply = <&reg_vsys>;
+	vsys-vcore-supply = <&reg_vsys>;
+	vsys-vgpu11-supply = <&reg_vsys>;
+	vsys-vgpu12-supply = <&reg_vsys>;
+	vsys-vpa-supply = <&reg_vsys>;
+	vsys-vproc1-supply = <&reg_vsys>;
+	vsys-vproc2-supply = <&reg_vsys>;
+	vsys-vpu-supply = <&reg_vsys>;
+	vsys-vs1-supply = <&reg_vsys>;
+	vsys-vs2-supply = <&reg_vsys>;
+	vsys-vmodem-supply = <&reg_vsys>;
+	vsys-ldo1-supply = <&reg_vsys>;
+	vsys-ldo2-supply = <&reg_vsys>;
+	vs1-ldo1-supply = <&mt6359_vs1_buck_reg>;
+	vs1-ldo2-supply = <&mt6359_vs1_buck_reg>;
+	vs2-ldo1-supply = <&mt6359_vs2_buck_reg>;
+	vs2-ldo2-supply = <&mt6359_vs2_buck_reg>;
+
+	keys {
+		compatible = "mediatek,mt6365-keys", "mediatek,mt6359-keys";
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
+	/*
+	 * MT6319 PMIC SID can change depending on the boards so add
+	 * in this include file the nodes for the possible values,
+	 * disabled by default to limit the code duplication.
+	 */
+	mt6319_sid6: pmic@6 {
+		compatible = "mediatek,mt6319-regulator", "mediatek,mt6315-regulator";
+		reg = <0x6 SPMI_USID>;
+
+		pvdd1-supply = <&reg_vsys>;
+		pvdd2-supply = <&reg_vsys>;
+		pvdd3-supply = <&reg_vsys>;
+		pvdd4-supply = <&reg_vsys>;
+
+		status = "disabled";
+
+		regulators {
+			mt6319_sid6_vbuck1: vbuck1 {
+				regulator-name = "dvdd_proc_b";
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
+
+	mt6319_sid7: pmic@7 {
+		compatible = "mediatek,mt6319-regulator", "mediatek,mt6315-regulator";
+		reg = <0x7 SPMI_USID>;
+
+		pvdd1-supply = <&reg_vsys>;
+		pvdd2-supply = <&reg_vsys>;
+		pvdd3-supply = <&reg_vsys>;
+		pvdd4-supply = <&reg_vsys>;
+
+		status = "disabled";
+
+		regulators {
+			mt6319_sid7_vbuck1: vbuck1 {
+				regulator-name = "dvdd_proc_b";
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
2.55.0

