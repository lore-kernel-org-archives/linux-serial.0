Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888945;
	b=c3mQQcYcVeMaOvqRiRNoDl4LPnBM4gYdcdEGrRfyg4kjjmH8U8yPN8djXAO6lFdkczXA
	 T4dHEhTDHqetcPe/k6Mh5thHiNxt5ZFbFH6tozoVjkYi/7nry/3VShwLVry4GRNUDZXSg
	 4OLKOaYiq6MnGgQ90ICIFHCaPPILFTzG7aIOE81ATA+T+5MhOhqbNGFMCoXT6xJ0urhQU
	 HrLaMDUEW1hj+pgkbuShjkDXh75lGYdhiyp+GS7N0lIrjIHAxCLIRT+ikLoQ9eI8CQS1P
	 UAu1Zx8iGFdB5BhkzXVEc15VEF7JmBjN2/0jQtF5wkpV8f05/UJcoxQlya4kacMMP2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888945;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yFXunORW+PuRObaULoq61sL3kviCqA/X6v8YIlM+9ns=;
	b=jR9zMDd9b5M9947JRWy0Z+mO/W6wfL87rM3FARFVq9ZopYDC1qNuo/IiG6eiAeHZIxzY
	 Gr2ZpkVok8hBk2LF5GyxiJfeja2TN0isIYUtITpzs9MjSl9CngcYTf1pN9ldvAanP2+Hr
	 +yvBsSTGZt09vwd2DkHRpii2+vHfF1ArV70HE/agIxwZJbctS0zcIgbAESF7ho2BjQ/nv
	 1JoiPzEzlKYj9rzD4jfEYOLt49y/C/ef44xPzhM6666528WqTokcRmmzQUBiHa9DumcSW
	 AVgbt3ZTCbOdpmsbbhJOPbSudMeyQjaB4SU5FSx4xqyIeTGp4akLbBA2hQzpoaSkTNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cpn1rVyq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B4606D812;
	Thu,  5 Nov 2026 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cpn1rVyq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793888944;
	b=UhXm8sYwmEwysJAV0j2zOxkX2I2dYwoe00VpjFhhdUyjT6rPZY67Bhz6BMZt489Toagb
	 zZFy6QY1Ejo4YtoemYTFRC/SaCFgkpTK/zsB01wxrdSzesww+yjjqZCQXHYG5lhPwbVeY
	 ewlB8pAAHOEuRO7G508O1SxoD1y7swn/V9L/b6IVIFa/JAaV4D1X+Dg7noCtb3ao0paTM
	 zjGfK8cnXJbX647sW56gtN3BBjW4Ndhum2nTmZXp5ZSImxLgL81zMlgxQ1xAFYFBB/GaN
	 mj8pfDlCBT7pxEgNzwpgPNiCV1bFcoKX9R6L46t6LT59uUiX/HVt72mBqpm8B6r0T1w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793888944;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yFXunORW+PuRObaULoq61sL3kviCqA/X6v8YIlM+9ns=;
	b=m2yafq9fB3D2sg7CeJ5Yr7/Cfy0BYHopLNmfjpWHnCeVtgz7l8l39mQhKGqFBK+TGFpD
	 2hGYcAqBeXdvNCurFIhVguQQ1xcltlYwk7pDWcy2kQNM4V+3U1+ENLH8Jd6VcVf6mp7PY
	 ATnbAvfuZaTxZU31iA6HEztXSSgt/JHZRHgRGPm1guW5ct9OkLN916g/wGbyDQsmcIaPW
	 w1H6nZTvB5QVJk2EzvKf8NtA0auErCpodrZABf6w4DVcp533ExjMhN7R0sYsXGClgweVH
	 hWuFGnnQ+lxOAB1ThRsZmWfiaJnpph/gulb3ZQlrZADUHy9ERi6yGaOLpOyc/MpPsOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DED9B1F000C1;
	Thu,  5 Nov 2026 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888944;
	bh=yFXunORW+PuRObaULoq61sL3kviCqA/X6v8YIlM+9ns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Cpn1rVyqeyKfx7mc0gXN5uc6z+aLwPgPTzVKcDrrAbPGB86AayOiYqMam8wYZBrga
	 7llXlw8P6XfZr0WuYgZ3Hb05NyBED6MR++vQotgJU8iFm6c5ve7Rl/hbc+lGLuwbCj
	 8l9CNeEw1gszgoT3YzhQ4dLx3W182sSDREQPTa5SqBIgRouB1AVeDlXOv+A+uXr47I
	 kKJw1fVA4INehyl84DTNts3lZ64ikMTcI/mC/lGA6hzdClVsBbv5SWxq29g77yLtXT
	 iROtwcQWjQyAxG/auzw0dPIzC9KXU5IfVSbwTg2nL33WTiL3XeMAdvbPiMJKGLQcYw
	 Sb8YlaTw7Z2+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 62C21472C7;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Thu, 05 Nov 2026 14:28:50 +0000
Subject: [PATCH v2 5/6] arm64: dts: mediatek: Add basic support for MT8163
 SoC
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
Message-Id: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-5-e68d7d428f99@protonmail.ch>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793888941; l=6537;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=14rHWBooScrYpq6ceUihMici2wAk5TROgmMtstlnlWA=;
 b=dsT0Ql+OEsVfaICjAX6vUHztbbGYxVAGY3n+kpdrkpyMvZTT3ec9WsiivohyflVgFRhD9IwOc
 +0nirL4kUvMAiLw5LEvossyvwPHfF8tB7h/NNeb25hwAKRTwqAduU7t
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch
Content-Transfer-Encoding: 7bit

From: Ben Grisdale <bengris32@protonmail.ch>

Add a basic dtsi for the MediaTek MT8163 SoC, describing the CPUs and
caches, PSCI, interrupt controllers, timers, PMU, watchdog and UARTs.

Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 arch/arm64/boot/dts/mediatek/mt8163.dtsi | 243 +++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8163.dtsi b/arch/arm64/boot/dts/mediatek/mt8163.dtsi
new file mode 100644
index 000000000000..645f4e15587b
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8163.dtsi
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) 2026 Ben Grisdale <bengris32@protonmail.ch>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt8163";
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clk32k: clock-32768 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "clk32k";
+	};
+
+	clk13m: clock-13000000 {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&clk26m>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "clk13m";
+	};
+
+	clk26m: clock-26000000 {
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
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			enable-method = "psci";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
+			enable-method = "psci";
+			i-cache-size = <32768>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <32768>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2>;
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
+			};
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-unified;
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 9 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 11 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
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
+		watchdog: watchdog@10007000 {
+			compatible = "mediatek,mt8163-wdt";
+			reg = <0 0x10007000 0 0x1000>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_EDGE_FALLING>;
+			#reset-cells = <1>;
+		};
+
+		timer: timer@10008000 {
+			compatible = "mediatek,mt8163-timer",
+				     "mediatek,mt6577-timer";
+			reg = <0 0x10008000 0 0x1000>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk13m>, <&clk32k>;
+			clock-names = "system-clk", "rtc-clk";
+		};
+
+		sysirq: interrupt-controller@10200620 {
+			compatible = "mediatek,mt8163-sysirq",
+				     "mediatek,mt6577-sysirq";
+			reg = <0 0x10200620 0 0x20>;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+		};
+
+		gic: interrupt-controller@10221000 {
+			compatible = "arm,gic-400";
+			reg = <0 0x10221000 0 0x1000>,
+			      <0 0x10222000 0 0x2000>,
+			      <0 0x10224000 0 0x2000>,
+			      <0 0x10226000 0 0x2000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+				      IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		uart0: serial@11002000 {
+			compatible = "mediatek,mt8163-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x400>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "baud", "bus";
+
+			status = "disabled";
+		};
+
+		uart1: serial@11003000 {
+			compatible = "mediatek,mt8163-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x400>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "baud", "bus";
+
+			status = "disabled";
+		};
+
+		uart2: serial@11004000 {
+			compatible = "mediatek,mt8163-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11004000 0 0x400>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clk26m>, <&clk26m>;
+			clock-names = "baud", "bus";
+
+			status = "disabled";
+		};
+
+		uart3: serial@11005000 {
+			compatible = "mediatek,mt8163-uart",
+				     "mediatek,mt6577-uart";
+			reg = <0 0x11005000 0 0x400>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
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
+		interrupts = <GIC_PPI 13
+			      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		arm,no-tick-in-suspend;
+	};
+};

-- 
2.56.0


