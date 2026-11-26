Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795696898;
	b=L2rxFsrb6UfzMNl7NHdfqcP1EORsjgBzBZ86GMpSglo55LK3sCxZ+osuhBfAotVQO0sw
	 kdBZTu2qI627IR8gOS6DsSAz/mnSVTZhAteICuHd8wh/BzOulUdVrt9rYnX27hY3eNsyd
	 RZrutxud4CgsddxM8hh9QLmjP+llYZUHAjH5Bl6j91eLnYpRGJ+3YFMWXggLzLRmeGKy9
	 68LFSzBPFBwfeFays9YSmp6kvbyIIwgzhhnRVXSR7zjKx3DCbDnHZ2Qmo+HzYvTTT1bNQ
	 ZVY6Wbk0CV+nyB2hG2PFYTzDB/9vig5QcbAwvx9rvkStdDwEww2bpBm4SNeZ0gUe/gQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696898;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NCzzKiuFMOY3fAwq3LpJyBfxrgfpY9TvMW9o9zSxnRQ=;
	b=aSPJSyyFx1MPaqrHPdao9mo8QkYl2Zz0WJpqVtcgoo32bvkW0YQvz+aKnCEwOtfl5VU3
	 cEcC5BzOp0SzbxXVS3iOtUNHHozU7yV3cW4pFwr/+rjGjR/tRrYBQ06Vm40POpAhBp4VB
	 QomfGS4P1ZtyPHEr0ADFwe/822OS49+NCMfjlBw1KRl9tnjWFrUrR2qbLu8QTizyH4dy4
	 Is61uP99usbeWVlso/P3j3t6lVftui6IeJ8zzj7el6bL3ox0u0eaZYyHsudQFJwnk+c19
	 zjCtuyNJveNLXePz7i4EohKjKioY4oKSbjVmgeYX3KZUo+JuEIroiC3AZ6DF3MQYALQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izqX+s7C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07889606A327;
	Thu, 26 Nov 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izqX+s7C
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795696897;
	b=KmU3YhXWonbeAbQOw2XjRskvt0rx+7jXF4NCme2ua1Z7IcTq8Euz96MJGadTh5o+dL90
	 5HUVBMErKgKywHAAvyHaYReZJdEQnb/G9BAlnKAHUp5/FrqFAyG/0cymZi8SuP8gRA8L2
	 zx8dlFM/Zx+1m0QI3detsHB0d2JXuD3GmstocdP+ZZdF8UO8U5NTQm9FnbeASH2QYgRDL
	 d/hYpxVjrM8TFcBNjcCbMaeR6oWtc7O7aO/w5Ck8aYIxWhFtDVn5s93B96FqsHIFzBja+
	 otc+rm+Xu4KjnI7dzZ5xMNWQv9BXCdgnM3eBU/IF5JNB6CkMx9QwLjwN6lXnQL3cR2w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696897;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NCzzKiuFMOY3fAwq3LpJyBfxrgfpY9TvMW9o9zSxnRQ=;
	b=BjA3OJT5DmhfhWNCNAED62IeyE8NUH5hzFRmIcA8QahLydKl8jdul3Gr5sbzS30CPHgW
	 8Gb53AvAme1DCQFzGthbom2s2VGTaRfj+y9M4V69Kjr22XYraq+JJCC3RqXi2Lm0YGgyp
	 urkQEkXDE1jdHKKCGi6Chv4vy12WjYiO0HUWzahHJSFTKxavU/t5F7Lj4WShiHYy7s5xr
	 0MD4RunFyeFOWXAbvmSlfBe8hCPOp+adLoKQjPWRMlLxRgD1ZaORsk1Xy4WpPrhYo1d3W
	 sKYJSPjUMfzxQXAItfMh0m4VH8DjkPUD/59JGUD/Md78hCd0/FgwjyjJHw1vWLmMr9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2410B1F000E6;
	Thu, 26 Nov 2026 12:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696897;
	bh=NCzzKiuFMOY3fAwq3LpJyBfxrgfpY9TvMW9o9zSxnRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=izqX+s7CYKK2y2vDLzYJytZdQu1eheDDBdpxpzoEWkxD8iUc26flTtY5if+ja105t
	 J4GWVtaGgHhf+6k7A0Gynz74ZQq7MUhOMo/D1aQIrkjGM1AuIva28HF3vHDKtBe6bk
	 FJ4gnrhb461/rkdnG+2GTqlpa7OWRjmx4pbKjnSTKlR9wB5umK6/yP9kluU96CZUwi
	 yk5Sndn+S+I3IAwpdxeDatOt+E60wsl2xBkTCsN2gHRoG0P0tqqvcaah5QOEqXVqCL
	 TWYaI3W4oAx4UX1k8kW581CxcQgEZ+zIzrTeYhzs8CSpYxrMZMwbdnzcsHYkekyQS4
	 o1fFEU29iLW6w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4A8384D4E0;
	Thu, 26 Nov 2026 12:41:17 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:40:00 +0200
Subject: [PATCH 7/8] arm64: dts: mediatek: add initial mt6768 support
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
Message-Id: <20261126-6768-init-v1-7-abc364a2447e@protonmail.com>
References: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
In-Reply-To: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795696875; l=11118;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=CLKEgJtNCT1nxNxkjyvNgyKrdEjCGEY7IpAzTuWRPII=;
 b=zNo8QR3i+QxTtjdC1B0W4yAZJ/lNQD7/meWeFANwpoA2ULqHX7yL1ktxAVOUr/1GSZKnDkp7t
 H+zUuiFQmwRARvFdpEFg9EvX/1keqYyJZs8akB9q3XRJ1DAKfiJrU5p
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

MediaTek mt6768 is a popular budget SoC for smartphones, released in 2020
and still used for low-end devices. It features 2x Cortex-A75 cores,
6x Cortex-A55 cores and Mali-G52 MC2 GPU. The CPU and GPU clocks depend
on the exact SoC variant.

This SoC has multiple variants released under different marketing names.
This includes, but is not limited to: Helio P65/G70/G80/G81/G85/G88/G91/
G92. The only differences between them are CPU/GPU speedbins and LPDDR4X
memory support.

Add initial devicetree for the mt6768 with support for two UARTs,
systimer, watchdog, and interrupt controllers.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6768.dtsi | 418 +++++++++++++++++++++++++++++++
 1 file changed, 418 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6768.dtsi b/arch/arm64/boot/dts/mediatek/mt6768.dtsi
new file mode 100644
index 000000000000..d06a98f35960
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6768.dtsi
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025-2026 Roman Vivchar <rva333@protonmail.com>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
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
+			capacity-dmips-mhz = <495>;
+			cpu-idle-states = <&cpu_sleep>;
+			dynamic-power-coefficient = <85>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+
+			l2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <65536>;
+				cache-line-size = <64>;
+				cache-sets = <256>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <495>;
+			cpu-idle-states = <&cpu_sleep>;
+			dynamic-power-coefficient = <85>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_1>;
+			#cooling-cells = <2>;
+
+			l2_1: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <65536>;
+				cache-line-size = <64>;
+				cache-sets = <256>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <495>;
+			cpu-idle-states = <&cpu_sleep>;
+			dynamic-power-coefficient = <85>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_2>;
+			#cooling-cells = <2>;
+
+			l2_2: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <65536>;
+				cache-line-size = <64>;
+				cache-sets = <256>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <495>;
+			cpu-idle-states = <&cpu_sleep>;
+			dynamic-power-coefficient = <85>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_3>;
+			#cooling-cells = <2>;
+
+			l2_3: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <65536>;
+				cache-line-size = <64>;
+				cache-sets = <256>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x400>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <495>;
+			cpu-idle-states = <&cpu_sleep>;
+			dynamic-power-coefficient = <85>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_4>;
+			#cooling-cells = <2>;
+
+			l2_4: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <65536>;
+				cache-line-size = <64>;
+				cache-sets = <256>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x500>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <495>;
+			cpu-idle-states = <&cpu_sleep>;
+			dynamic-power-coefficient = <85>;
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <128>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_5>;
+			#cooling-cells = <2>;
+
+			l2_5: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <65536>;
+				cache-line-size = <64>;
+				cache-sets = <256>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu6: cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a75";
+			reg = <0x600>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_sleep>;
+			dynamic-power-coefficient = <275>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_6>;
+			#cooling-cells = <2>;
+
+			l2_6: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <262144>;
+				cache-line-size = <64>;
+				cache-sets = <512>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
+		};
+
+		cpu7: cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a75";
+			reg = <0x700>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			cpu-idle-states = <&cpu_sleep>;
+			dynamic-power-coefficient = <275>;
+			i-cache-size = <65536>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <65536>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&l2_7>;
+			#cooling-cells = <2>;
+
+			l2_7: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-size = <262144>;
+				cache-line-size = <64>;
+				cache-sets = <512>;
+				cache-unified;
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
+		idle-states {
+			entry-method = "psci";
+
+			cpu_sleep: cpu-sleep {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				entry-latency-us = <200>;
+				exit-latency-us = <400>;
+				min-residency-us = <1200>;
+				arm,psci-suspend-param = <0x00010001>;
+			};
+		};
+
+		l3_0: l3-cache {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-unified;
+		};
+	};
+
+	dsu-pmu {
+		compatible = "arm,dsu-pmu";
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
+		       <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+	};
+
+	clk13m: fixed-factor-clock-13m {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "clk13m";
+	};
+
+	clk26m: oscillator-26m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "clk26m";
+	};
+
+	pmu-a55 {
+		compatible = "arm,cortex-a55-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster0>;
+	};
+
+	pmu-a75 {
+		compatible = "arm,cortex-a75-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster1>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		gic: interrupt-controller@c000000 {
+			compatible = "arm,gic-v3";
+			reg = <0 0xc000000 0 0x40000>,
+			      <0 0xc040000 0 0x200000>;
+			#interrupt-cells = <4>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
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
+		sysirq: interrupt-controller@c53a650 {
+			compatible = "mediatek,mt6768-sysirq", "mediatek,mt6577-sysirq";
+			reg = <0 0xc53a650 0 0x50>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+		};
+
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt6768-wdt";
+			reg = <0 0x10007000 0 0x100>;
+			#reset-cells = <1>;
+		};
+
+		systimer: timer@10017000 {
+			compatible = "mediatek,mt6768-timer", "mediatek,mt6765-timer";
+			reg = <0 0x10017000 0 0x1000>;
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk13m>;
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt6768-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x1000>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "baud", "bus";
+
+			status = "disabled";
+		};
+
+		uart1: serial@11003000 {
+			compatible = "mediatek,mt6768-uart", "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x1000>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "baud", "bus";
+
+			status = "disabled";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW 0>;
+	};
+};

-- 
2.56.1


