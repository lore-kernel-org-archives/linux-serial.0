Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794906701;
	b=4NusICpip96ivuY37juyQ6UDb+xe972hFIK2tIUsA/6QlHSOH2B3WIZonqZv8kAqdHnO
	 W3+KFMY98r61s2t7HfQogjVb7TdKrQhbbYwfIsookuzGX8G42ReatsL1A/kiUtJhiqTWs
	 rtvX1xogghd0ZgeEtM6qZc7oHEbkPH2TR+vYz98GtMVoYXCNhidSBW4d74nJtt7u/k3ES
	 WeSZSWcz1SDLfgleYYcA1HCEg/qeMS9I7BMdiI3ZxltJo3GtvOtNrOWGxZVeiS223+JUL
	 3KFp9uCPs7yNqvolA0bBYUNG/EESg4lfqMKh8WdsQ8lAK+VUGO8supLhDPEPqhZ9nsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906701;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zFx6tGSvGRSjBzYIaC/OP+wFtcJCXuc+tgP9CDmPDwU=;
	b=lcbd4pxXphEi0dB9UCAEhSh6fqmK4dm7BBAbcScfNUZ1ozuFOGwu/fTxbQ9SfhaJ/ch6
	 mMKVt6DK/AkmTyIoaSmS3DGj2p/yg04XfkULPeH6BYi8BmGCrnZZj1fDiAwkt/NmwoFZj
	 kZehtKeHMQqWttsRNM53RfAXkA7ie21Qz4pUOHXheAYNU1yRE3ka5FrYWdMuEMoqN3PQR
	 AaJshUEKwPGv64vOc1LI+E+KGgJLQxWctRcdn7kxmOte07c33hkpgK4RNp8EmlUev1Ccj
	 JIwL1ur8KJXIvs5fsX6NyzZJ9+Geb7lSUejKSdGjLecevnlyVK8pgOD3N4JujU2yd2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o20tMfGR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C62606A8A4;
	Tue, 17 Nov 2026 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o20tMfGR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794906701;
	b=RH47Vpj5/TqbaRdLYMHNbo8kNBys5ddVSzyeeokeJvPpBIhlw+F8+XdS1F2opR8Lb7HB
	 Q9uMmkC/0RoMsOUj11yFlH/F+WjSiG+et1nxnV581KGNDl0FI9jKI2/ryV3pKKWne5kw9
	 I7cnj11Mnt+JCV5+lgqBzE6/nYA1KYtB5w6l2pKvOBbNxOoXRqQ99ERlhFsZYPZ/nBLU9
	 V4NVnLtHN6mUnuBDcFKTSnau3wfz3AlUuCqujVaVzMU3Bia5K6Kf07BcGLZRBTKYF9RGP
	 LatENq8XtN47Zy5OQE1enZm3ltQR/rUtTjKZBTQ6oZCGBq47iGuWSHQUTeMT5UQgiEQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794906701;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zFx6tGSvGRSjBzYIaC/OP+wFtcJCXuc+tgP9CDmPDwU=;
	b=PbcCk8TEUv7OnI8apERhgBzvAw7Sf61Kpb/jtO738w2VpQ3hXtGn0CSeWDtM/cPTANXb
	 QmLqxn8bQDazd3NHMWX8sAgD8VBZYloSIJZ2HiJtvOPm/fCg9YT/K7tfwvtuCs11hqhW9
	 LGrOr+3Si6/hLEm3NFbOx4tOwwwYqvKTdesno2aDCKgERCQBdeaqHR4jAaE80nLSlqEXd
	 Q2NA95qhGx7NMcWExZWMjueMG8MYy3TfqEuhcx5vUfL/UKaW4zNNWLDYfNK1yDjImfntf
	 DAr4GE5GY3Ld6MJ6syrlCy5gZZwH0icjVUuT08k2/jHeLn21O5T7odMbpAtn4uIeaFw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1E58B1F000C8;
	Tue, 17 Nov 2026 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906701;
	bh=zFx6tGSvGRSjBzYIaC/OP+wFtcJCXuc+tgP9CDmPDwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=o20tMfGRQZ42vDztuk4RMXwT5hIwMB9qyMZR0VB5zp6QStAkWuguHeiC+8c+/p9gG
	 AyXAdk1RK0pqRBpxebZiyHqqfWcrEkTJhU50uEtc3+bqa0NkYpmhg2qloXHyH+RoOn
	 zWF4LrA48PASshA7ZHY7C2OzPFKNiaZod0jBMqXPI8IRnjJO3uTDdfjCWKcnx4SWYi
	 WLP3SCqXG+YWsxFzrDgfe2UXOr/iryzlVMqIyBJHLC3HVHvTM7SUIcVAwZDTFN0/Y7
	 e9+N0zPgrmsGVyus41lP3oZaA9t6EB4gK24OgF3hfFbZ0PXSZ6zK2/xVbt4kewZeOV
	 UU0kLjIrT9XPQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8B68C4A783;
	Tue, 17 Nov 2026 09:11:37 +0000 (UTC)
From: Rui Cao via B4 Relay <devnull+i.udp0.com@kernel.org>
Date: Tue, 17 Nov 2026 17:11:35 +0800
Subject: [PATCH v2 5/5] arm64: dts: mediatek: Add MT6833 and the Xiaomi
 Redmi Note 13 5G
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-mt6833-base-v2-5-058a0685c40c@udp0.com>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
In-Reply-To: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org, 
 phone-devel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>, 
 Rui Cao <i@udp0.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794906695; l=11318;
 i=i@udp0.com; s=20261107; h=from:subject:message-id;
 bh=O0MLfKFZkjuBoo2kmJGBComme0o8liP1XxIG55mQug4=;
 b=+i1lGpPfzoGptcpDKAI/OrSyo4xSKEVL99ZKfssSl++26nEzgg+2k1Aj5NnvgsfbG2/RCgdTl
 i3H97PgkgsHCBswfnFXGCBM3g2tTQQ/WEmUmM02T9CFRE7TIDWg9r/7
X-Developer-Key: i=i@udp0.com; a=ed25519;
 pk=XZJKcKgnUUjjyw8KuKy7u2QeIX0JLY/L1Fxzwwje41w=
X-Endpoint-Received: by B4 Relay for i@udp0.com/20261107 with auth_id=1443
X-Original-From: Rui Cao <i@udp0.com>
Reply-To: i@udp0.com
Content-Transfer-Encoding: 7bit

From: Rui Cao <i@udp0.com>

Add a device tree for MediaTek's MT6833 (Dimensity 700): its eight
cores, six Cortex-A55 and two Cortex-A76 in one DynamIQ cluster, with
their caches and PMUs, PSCI, the architected timer, the GICv3, the
watchdog and the first UART.

Add the Xiaomi Redmi Note 13 5G (gold) on it, with the framebuffer the
bootloader leaves the panel scanning out and a ramoops region. The
memory size and the regions reserved for the firmware the bootloader
starts depend on the RAM variant, so they are left to the bootloader:
the memory node has no size, and reserved-memory holds only the regions
the kernel uses itself.

The cache sizes are the ones the cores report in CCSIDR_EL1. The
bootloader programs CNTFRQ_EL0 (13 MHz), so the timer has no
clock-frequency.

Signed-off-by: Rui Cao <i@udp0.com>
---
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 .../arm64/boot/dts/mediatek/mt6833-xiaomi-gold.dts |  57 ++++
 arch/arm64/boot/dts/mediatek/mt6833.dtsi           | 341 +++++++++++++++++++++
 3 files changed, 399 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a86fb313b1a..b8466d4a3d6 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-sony-xperia-m5.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6833-xiaomi-gold.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-cudy-wr3000-v1.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt6833-xiaomi-gold.dts b/arch/arm64/boot/dts/mediatek/mt6833-xiaomi-gold.dts
new file mode 100644
index 00000000000..bf5340617e6
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6833-xiaomi-gold.dts
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Xiaomi Redmi Note 13 5G (gold)
+ *
+ * Copyright (C) 2026 Rui Cao <i@udp0.com>
+ */
+
+/dts-v1/;
+#include "mt6833.dtsi"
+
+/ {
+	model = "Xiaomi Redmi Note 13 5G";
+	compatible = "xiaomi,gold", "mediatek,mt6833";
+	chassis-type = "handset";
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* The bootloader leaves the panel lit, scanning out this buffer */
+		framebuffer@73c10000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x73c10000 0 (4352 * 2400)>;
+			width = <1080>;
+			height = <2400>;
+			stride = <4352>;
+			format = "a8r8g8b8";
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/* The bootloader fills in the size */
+		reg = <0 0x40000000 0 0>;
+	};
+
+	/* The bootloader adds the regions it reserves for firmware */
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ramoops@48090000 {
+			compatible = "ramoops";
+			reg = <0 0x48090000 0 0xe0000>;
+			console-size = <0x40000>;
+			pmsg-size = <0x80000>;
+			no-map;
+		};
+
+		framebuffer@73c10000 {
+			reg = <0 0x73c10000 0 0x1df0000>;
+			no-map;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt6833.dtsi b/arch/arm64/boot/dts/mediatek/mt6833.dtsi
new file mode 100644
index 00000000000..51bcdad846e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6833.dtsi
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * MediaTek MT6833 (Dimensity 700)
+ *
+ * Copyright (C) 2026 Rui Cao <i@udp0.com>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "mediatek,mt6833";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clk26m: oscillator-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
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
+			capacity-dmips-mhz = <405>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+
+			l2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				cache-size = <131072>;
+				cache-line-size = <64>;
+				cache-sets = <512>;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <405>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_1>;
+
+			l2_1: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				cache-size = <131072>;
+				cache-line-size = <64>;
+				cache-sets = <512>;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <405>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_2>;
+
+			l2_2: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				cache-size = <131072>;
+				cache-line-size = <64>;
+				cache-sets = <512>;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <405>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_3>;
+
+			l2_3: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				cache-size = <131072>;
+				cache-line-size = <64>;
+				cache-sets = <512>;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x400>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <405>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_4>;
+
+			l2_4: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				cache-size = <131072>;
+				cache-line-size = <64>;
+				cache-sets = <512>;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x500>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <405>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_5>;
+
+			l2_5: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				cache-size = <131072>;
+				cache-line-size = <64>;
+				cache-sets = <512>;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x600>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_6>;
+
+			l2_6: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				cache-size = <262144>;
+				cache-line-size = <64>;
+				cache-sets = <512>;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a76";
+			reg = <0x700>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_7>;
+
+			l2_7: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				cache-size = <262144>;
+				cache-line-size = <64>;
+				cache-sets = <512>;
+				next-level-cache = <&l3_0>;
+			};
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
+		l3_0: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-unified;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+		};
+	};
+
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
+	};
+
+	pmu-a76 {
+		compatible = "arm,cortex-a76-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
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
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			reg = <0 0x0c000000 0 0x40000>,
+			      <0 0x0c040000 0 0x200000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-parent = <&gic>;
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
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt6833-wdt";
+			reg = <0 0x10007000 0 0x100>;
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt6833-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x1000>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "baud", "bus";
+			status = "disabled";
+		};
+	};
+};

-- 
Git-157)


