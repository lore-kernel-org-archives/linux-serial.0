Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ABA152163;
	Sat,  3 Aug 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722689801; cv=none; b=mjz01jiGcKgeqAT8EbtYAfQxala48aFOg50dIbtcG3JhaLdDLHeGT9KdBw3uBnmeJhIxNQ+dYVX/KQ5ksJljpf8mB1imctk60lOZEkyelOgIUiNOhGfupseVy3UuDCmvYnJXKLndJLy0VXVbYm90WxJBCn1RIiwvWXyoFOAm/J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722689801; c=relaxed/simple;
	bh=lfSq/X6YRD5PkpNYt4Z/eClK/AGs8PNzLbbGY0txUPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbdRlKN+2g8Y6XjyielldTf6mo7dh5f2y0SPywgdkDEbqh23cxNcEvu0ONGNLSAKfr8BbBcLfJ+FqbG00epKXOojquYwrzuCTZczFBSypS23cXhrtxuVi73AixXtPkYgDOrF+VOYCR6M57qB8yGdfeZxCeF4nRMaJn76t+pA5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Uk9/diFy; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Uk9/diFy"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E7F7741543;
	Sat,  3 Aug 2024 14:56:37 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dGS0zS6EjaY3; Sat,  3 Aug 2024 14:56:37 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722689796; bh=lfSq/X6YRD5PkpNYt4Z/eClK/AGs8PNzLbbGY0txUPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uk9/diFyJhG1KLzh7G9qKA3W8lAx3fwAuPQPeIM4WKH+1O5FELJJ+UEKm9JlK9sVn
	 ubrkRcYJ7FSAveevxzbHx5iuNHxAPNk05F49VR9Ko/RtM8AQkgckEZ0sM35MM20IpQ
	 OGSDu5cU04/05tr57iUgnyg2sS4kg7mmMBzhh2rSJwWB1N4U6sdo8VOFN5XbkqilMi
	 aAmsTWtAFWajmxenJGfAJYFQnjC+0hIBvJrj7gSyZYQu4x9KAEfxUI7gzmuOMGdrYw
	 apReQWbztd7ZPuax3RkSMMpaQc6X6ksQa1vLVYCkil/CcIVsn26rKRjKRnE+g/mMju
	 lKq0RqITxWPcQ==
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
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 3/4] arm64: dts: rockchip: Add base DT for rk3528 SoC
Date: Sat,  3 Aug 2024 12:55:10 +0000
Message-ID: <20240803125510.4699-5-ziyao@disroot.org>
In-Reply-To: <20240803125510.4699-2-ziyao@disroot.org>
References: <20240803125510.4699-2-ziyao@disroot.org>
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
index 000000000000..77687d9e7e80
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
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
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
+	xin24m: xin24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "xin24m";
+	};
+
+	gic: interrupt-controller@fed01000 {
+		compatible = "arm,gic-400";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x0 0xfed01000 0 0x1000>,
+		      <0x0 0xfed02000 0 0x2000>,
+		      <0x0 0xfed04000 0 0x2000>,
+		      <0x0 0xfed06000 0 0x2000>;
+		interrupts = <GIC_PPI 9
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	uart0: serial@ff9f0000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff9f0000 0x0 0x100>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clock-frequency = <24000000>;
+		status = "disabled";
+	};
+
+	uart1: serial@ff9f8000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xff9f8000 0x0 0x100>;
+		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart2: serial@ffa00000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa00000 0x0 0x100>;
+		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart3: serial@ffa08000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa08000 0x0 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart4: serial@ffa10000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa10000 0x0 0x100>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart5: serial@ffa18000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa18000 0x0 0x100>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart6: serial@ffa20000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa20000 0x0 0x100>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	uart7: serial@ffa28000 {
+		compatible = "rockchip,rk3528-uart", "snps,dw-apb-uart";
+		reg = <0x0 0xffa28000 0x0 0x100>;
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+};
-- 
2.45.2

