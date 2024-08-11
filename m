Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845721494DD;
	Sun, 11 Aug 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723385344; cv=none; b=hH4yhkR9QB6C/wJeD2LmebpXhgv6lwl8g0zMrCUCBSyUT93pjX14lQ9QiX8JB9MlOIFGbQ6Eel1QSRIpB6HXp9Lh9TM8GUu9Ldy9Xc1iWmsMy2iKnM08F/gifpwaJCTyhnoFsrnnSaPC7f7t+R9CFa/8NTGsQ9+HOCSLpQ4TVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723385344; c=relaxed/simple;
	bh=8blVLui+toi2hHeNTG/KU40I0aA/BYfHBkILQZ+m6H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbxxkMnGs/BmcPboP3VH3912bsN2OmKYlpnAdm7hXhiW73wAvwPFgOgJGmdgBEw3mJ3J653bp4IycTY0oo63j3F5vICUgHaNfej1OakcEWN1Rx53xPLPqk/wMq7WVfcye/eoDaB1kWnwyT/Ib8MDgZwhrPF96UBMnKD9xJ2CayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BmQy9HLj; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BmQy9HLj"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0BB9A41255;
	Sun, 11 Aug 2024 16:09:01 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZDS70hjfTIJx; Sun, 11 Aug 2024 16:09:00 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1723385339; bh=8blVLui+toi2hHeNTG/KU40I0aA/BYfHBkILQZ+m6H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BmQy9HLjMWjoXLhZStJiRsp27afYGRpNFxG/DagLISwnxW+d3oSZTLZ+3YGJIDwaM
	 EzZO1HhLs32cvXRCflXANw6HzmduFXpyM9N03RklXo+SokqBUN7sJ08NmKGOdBi1iz
	 sf7yM8syhZh0QK4YU0tctzlokA0ZtOGtn/O4ARQjkNoTBJKYf8iJEKuN5YP31ERKcK
	 dZ0j4KGAlfrcsPggv14x4vmL+HxEc3sjFTSI46oFczpg0o1p1nlN3vyE1rvArTpJvM
	 MnLVR8VcLvmc5p9Ewkbv0V+B9iBBFgsH/RUHkqYKfU2q2zbhol0ICnRKMSWBICs+LY
	 p58IStWC4Nm2w==
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>
Cc: Celeste Liu <CoelacanthusHex@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Date: Sun, 11 Aug 2024 14:07:24 +0000
Message-ID: <20240811140725.64866-4-ziyao@disroot.org>
In-Reply-To: <20240811140725.64866-1-ziyao@disroot.org>
References: <20240811140725.64866-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This initial device tree describes CPU, interrupts and UART on the chip
and is able to boot into basic kernel with only UART. Cache information
is omitted for now as there is no precise documentation. Support for
other features will be added later.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 182 +++++++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
new file mode 100644
index 000000000000..0596cdc38737
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	compatible = "rockchip,rk3528";
+
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+	};
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
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
+			device_type = "cpu";
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
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
+	xin24m: clk-24m {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xin24m";
+		#clock-cells = <0>;
+	};
+
+	gic: interrupt-controller@fed01000 {
+		compatible = "arm,gic-400";
+		reg = <0x0 0xfed01000 0 0x1000>,
+		      <0x0 0xfed02000 0 0x2000>,
+		      <0x0 0xfed04000 0 0x2000>,
+		      <0x0 0xfed06000 0 0x2000>;
+		interrupts = <GIC_PPI 9
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-controller;
+		#address-cells = <0>;
+		#interrupt-cells = <3>;
+	};
+
+	uart0: serial@ff9f0000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff9f0000 0x0 0x100>;
+		clock-frequency = <24000000>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	uart1: serial@ff9f8000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff9f8000 0x0 0x100>;
+		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	uart2: serial@ffa00000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa00000 0x0 0x100>;
+		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	uart3: serial@ffa08000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa08000 0x0 0x100>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	uart4: serial@ffa10000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa10000 0x0 0x100>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	uart5: serial@ffa18000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa18000 0x0 0x100>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	uart6: serial@ffa20000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa20000 0x0 0x100>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+
+	uart7: serial@ffa28000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa28000 0x0 0x100>;
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+		reg-io-width = <4>;
+		reg-shift = <2>;
+		status = "disabled";
+	};
+};
-- 
2.45.2

