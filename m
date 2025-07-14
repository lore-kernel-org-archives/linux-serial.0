Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B932550AD;
	Mon, 14 Jul 2025 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502005; cv=none; b=cAwWPRolVSAU4Ocd8hMsKw0lSOLFN6au904sDFolWJpnbJmGndB/dzoMXn8cmG5zlMAohFVf7JGOYElT0c5HriRPqDKeJNoQABmLSjqhmlJQOQbIbZsahr05q6wEBV72bjszM/YYOV6otFTMxZWT5kB12L9gWKGULUX3+fE8MRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502005; c=relaxed/simple;
	bh=S2ENDsdsQVANZls6Gv5jrHvt97EuvsvS0PV0mDHTrkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ot1I5SXC+5lEc+2mMH4fScAlCzoy7gUaoITXeo3zT/kUKjkTgHPgaGFRxF/ERNbzrvccXasmdZAYcizQORvZD6qYd767NjOFLnDHxcbqOk6aXRLblHoECt1nvwGZ/oJ1KUqH09sZo5cH5IipOUzMqnFTLbSYAfZtTDiMr6VpgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pK66NzLC; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pK66NzLC"
X-UUID: bdef1b1060bb11f0b33aeb1e7f16c2b6-20250714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HF/18ieS/SSN9fNOm5vOPPw2JMug1JxPkxgNb1Zv+hQ=;
	b=pK66NzLCVQmJ5kvGrMe99L6NJuvKdMGJIMBep2jZpEpGhQX12mkoxD2OeonsRI2JoKjhiBiFvpF2DBhxYHIbNKy/bXVQhrx875J1IPUg/K4BuwKF9UsUyllL45SNGB/FaPT92NmqykYUHk+kkAqCISzoUtEItzb1eCtK0kGMtPw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:0a952dec-9ebd-4571-87e2-aec7338b7502,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:9a2c30d8-b768-4ffb-8a44-cd8427608ba6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bdef1b1060bb11f0b33aeb1e7f16c2b6-20250714
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <sirius.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 606374275; Mon, 14 Jul 2025 22:06:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 14 Jul 2025 22:06:29 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 14 Jul 2025 22:06:29 +0800
From: Sirius Wang <sirius.wang@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wenst@chromium.org>,
	<xavier.chang@mediatek.com>, Sirius Wang <sirius.wang@mediatek.com>
Subject: [PATCH v4 3/3] arm64: dts: mt8189: Add mt8189 dts evaluation board and Mafefile
Date: Mon, 14 Jul 2025 22:06:05 +0800
Message-ID: <20250714140608.2065966-4-sirius.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250714140608.2065966-1-sirius.wang@mediatek.com>
References: <20250714140608.2065966-1-sirius.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add mt8189 dts evaluation board and Mafefile

Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8189-evb.dts |  20 +
 arch/arm64/boot/dts/mediatek/mt8189.dtsi    | 419 ++++++++++++++++++++
 3 files changed, 440 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a4df4c21399e..52c5b799308e 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -88,6 +88,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku4.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku5.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku6.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8188-geralt-ciri-sku7.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8189-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-spherion-r0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8189-evb.dts b/arch/arm64/boot/dts/mediatek/mt8189-evb.dts
new file mode 100644
index 000000000000..e5d9ce1b8e61
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8189-evb.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Author: Sirius Wang <sirius.wang@mediatek.com>
+ */
+/dts-v1/;
+#include "mt8189.dtsi"
+
+/ {
+	model = "MediaTek MT8189 evaluation board";
+	compatible = "mediatek,mt8189-evb", "mediatek,mt8189";
+
+	chosen: chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8189.dtsi b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
new file mode 100644
index 000000000000..a484a40a036c
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
@@ -0,0 +1,419 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ */
+
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
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x000>;
+			enable-method = "psci";
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
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
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
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
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
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
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
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
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
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
+			clock-frequency = <2000000000>;
+			capacity-dmips-mhz = <742>;
+			cpu-idle-states = <&cpu_off_l>, <&cpu_s2idle>;
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
+			clock-frequency = <3000000000>;
+			capacity-dmips-mhz = <958>;
+			cpu-idle-states = <&cpu_off_b>, <&cpu_s2idle>;
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
+			clock-frequency = <3000000000>;
+			capacity-dmips-mhz = <958>;
+			cpu-idle-states = <&cpu_off_b>, <&cpu_s2idle>;
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
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+				core4 {
+					cpu = <&cpu4>;
+				};
+				core5 {
+					cpu = <&cpu5>;
+				};
+				core6 {
+					cpu = <&cpu6>;
+				};
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
+
+			cpu_cluster_off_l: cpu-cluster-off-l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x01010001>;
+				local-timer-stop;
+				entry-latency-us = <57>;
+				exit-latency-us = <134>;
+				min-residency-us = <5700>;
+			};
+
+			cpu_cluster_off_b: cpu-cluster-off-b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x01010001>;
+				local-timer-stop;
+				entry-latency-us = <50>;
+				exit-latency-us = <144>;
+				min-residency-us = <2460>;
+			};
+
+			cpu_mcusys_off_l: cpu-mcusys-off-l {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x02010007>;
+				local-timer-stop;
+				entry-latency-us = <863>;
+				exit-latency-us = <1237>;
+				min-residency-us = <5700>;
+			};
+
+			cpu_mcusys_off_b: cpu-mcusys-off-b {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x02010007>;
+				local-timer-stop;
+				entry-latency-us = <648>;
+				exit-latency-us = <1172>;
+				min-residency-us = <4570>;
+			};
+
+			cpu_system_vcore: cpu-system-vcore {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x020100ff>;
+				local-timer-stop;
+				entry-latency-us = <2400>;
+				exit-latency-us = <4800>;
+				min-residency-us = <35200>;
+			};
+
+			cpu_s2idle: cpu-s2idle {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x020180ff>;
+				local-timer-stop;
+				entry-latency-us = <10000>;
+				exit-latency-us = <10000>;
+				min-residency-us = <4294967295>;
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
+		reg = <0 0x40000000 0 0xc0000000>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
+
+		performance: performance-controller@11bc10 {
+			compatible = "mediatek,cpufreq-hw";
+			reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
+			#performance-domain-cells = <1>;
+		};
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <4>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0xc000000 0 0x40000>, /* distributor */
+			      <0 0xc040000 0 0x200000>; /* redistributor */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
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
+		uart0: serial@11001000 {
+			compatible = "mediatek,mt8189-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11001000 0 0x1000>;
+			interrupts = <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+	};
+};
-- 
2.45.2

