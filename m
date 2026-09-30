Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3901F456288;
	Wed, 30 Sep 2026 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751604; cv=none; b=pX3ouQPSHTF4vpaIi76H+lrFGyz6+Fn2PnW87fcySdXGCsp6lBHFarXNGJOi7TBU1Gp8fJYq4R15T/qeOjnNwS5hvx1QmPCwUKmeJdto7PIDPQNqLv+xyhIFz46ZdSgY/ehM3Hx3BL1L2zZEgX4jflmoGfZPUrD9R4HvvhBvvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751604; c=relaxed/simple;
	bh=TY4Qb4K7Mbgb9HeEWYUHVIahYBNVnReMmlvWUguzK/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lDcAaDLc119xL9eoKhNWLbVzlwrALp2lz1jQ9SjzSAkmmtYGK2SBMytdGTHbJaGQw05wHy+2d9HV9H2lYyQNcPNlW04gGj5XJQ/IhJz5vqxzaMVUYLQ+2FV2+cdV7ekabG6unAvVFzQVzv567ssyj7NKyvVjN0jfxJTiDSY/Nws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxFD0YhT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxFD0YhT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C69BC4AF5F;
	Wed, 30 Sep 2026 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790751603;
	bh=TY4Qb4K7Mbgb9HeEWYUHVIahYBNVnReMmlvWUguzK/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZxFD0YhTnRFlrVuTkRDjVLRYXGUtvWZYpblRHUbg4kyuWnJrvtv33VRl8hKluHJUv
	 4CKCawGTLZuJ3wO4Re+uc9vXzb5sglxO2WswXaQ9YNBWoqKWMrnl7xoOPzQh453FZs
	 SlgSnWwrzG1fpuxxWbjxkA0z/ZMlg7RO9anoYCnzHh7woSFilirhTnrPomi5CqnEXq
	 HHYfgflhGwGnuNWjHIYR+dyG84F33t7dtat82Lqp+EmOTh0lOaq1jWJulq/vo5ZDzR
	 FMMQnu0F55YWzFeHgTygq7/DU0S9am8w7Z+Mu0GjRqqMJM6U+nyu1XM6OcccOVMwIo
	 ki1X0i2whmw0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E74BCA5FC5;
	Wed, 30 Sep 2026 07:00:03 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Wed, 30 Sep 2026 10:00:07 +0300
Subject: [PATCH RFC 08/10] ARM: dts: cortina: Add CS7542 SoC and Securifi
 Almond+ board
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-b4-cs75xx-v1-8-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790751600; l=6414;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=lzR7/Tt3kuDzP9wOxc2oRpZJ6/5jcv1dJ5QqhyOQCE4=;
 b=v3X0jqRqguC80RGDxeZTW9i1yk5x1zJK36tQMoujEDgM1MQ/ilIYTLRqSowYazAZ4jMP46cB+
 pP5oVZY5msHBcc2Nb7AHx55LQm4X/vjbo+B45k9bpdp9qgl+HgDPiuf
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Add a minimal description of the Cortina Systems CS7542 SoC: the two
Cortex-A9 cores, SCU, GIC, global timer, private timer and watchdog,
PL310 L2 cache controller and the four on-chip UARTs.

The peripheral clock (APB) runs at 100, 150 or 170 MHz depending on the
boot strap pins. Until there is a driver for the global control block
that reads the straps, model it as a fixed clock whose rate is provided
by the board.

The Securifi Almond+ is a touchscreen Wi-Fi router with 512 MiB of DDR3,
512 MiB of NAND flash, a QCA8337 switch, QCA9880 and AR9580 Wi-Fi and an
ASM1042 USB 3.0 controller behind the SoC PCIe root ports. For now,
describe the memory, the console UART and a ramoops region, and reserve
the top 64 MiB of RAM which the vendor firmware hands to the packet
engine queue manager.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/cortina/Makefile                 |   3 +
 .../dts/cortina/cs7542-securifi-almondplus.dts     |  55 +++++++++
 arch/arm/boot/dts/cortina/cs7542.dtsi              | 127 +++++++++++++++++++++
 4 files changed, 186 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 28fba538d55..cf4433001dd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -12,6 +12,7 @@ subdir-y += broadcom
 subdir-y += calxeda
 subdir-y += cirrus
 subdir-y += cnxt
+subdir-y += cortina
 subdir-y += gemini
 subdir-y += hisilicon
 subdir-y += hpe
diff --git a/arch/arm/boot/dts/cortina/Makefile b/arch/arm/boot/dts/cortina/Makefile
new file mode 100644
index 00000000000..42ca2f511cc
--- /dev/null
+++ b/arch/arm/boot/dts/cortina/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_CORTINA_CS75XX) += \
+	cs7542-securifi-almondplus.dtb
diff --git a/arch/arm/boot/dts/cortina/cs7542-securifi-almondplus.dts b/arch/arm/boot/dts/cortina/cs7542-securifi-almondplus.dts
new file mode 100644
index 00000000000..e2988c68765
--- /dev/null
+++ b/arch/arm/boot/dts/cortina/cs7542-securifi-almondplus.dts
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Device Tree Source for the Securifi Almond+ router
+ */
+
+/dts-v1/;
+
+#include "cs7542.dtsi"
+
+/ {
+	model = "Securifi Almond+";
+	compatible = "securifi,almondplus", "cortina,cs7542";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		ramoops@1bf00000 {
+			compatible = "ramoops";
+			reg = <0x1bf00000 0x100000>;
+			record-size = <0x20000>;
+			console-size = <0x80000>;
+			ecc-size = <16>;
+			no-map;
+		};
+
+		/* Reserved for the packet engine queue manager */
+		qm-buffer@1c000000 {
+			reg = <0x1c000000 0x4000000>;
+			no-map;
+		};
+	};
+};
+
+&apb_clk {
+	clock-frequency = <150000000>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/cortina/cs7542.dtsi b/arch/arm/boot/dts/cortina/cs7542.dtsi
new file mode 100644
index 00000000000..29b0b7da866
--- /dev/null
+++ b/arch/arm/boot/dts/cortina/cs7542.dtsi
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Device Tree Source for the Cortina Systems CS7542 SoC
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+
+	/* Rate is selected by the boot strap pins, set by the board */
+	apb_clk: clock-apb {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-output-names = "apb";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			enable-method = "cortina,cs7542-smp";
+			cpu-release-addr = <0 0xf00000b8>;
+			next-level-cache = <&l2>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		uart0: serial@f0070110 {
+			compatible = "cortina,cs7542-uart";
+			reg = <0xf0070110 0x30>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb_clk>;
+
+			status = "disabled";
+		};
+
+		uart1: serial@f0070140 {
+			compatible = "cortina,cs7542-uart";
+			reg = <0xf0070140 0x30>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb_clk>;
+
+			status = "disabled";
+		};
+
+		uart2: serial@f0070170 {
+			compatible = "cortina,cs7542-uart";
+			reg = <0xf0070170 0x30>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb_clk>;
+
+			status = "disabled";
+		};
+
+		uart3: serial@f00701a0 {
+			compatible = "cortina,cs7542-uart";
+			reg = <0xf00701a0 0x30>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb_clk>;
+
+			status = "disabled";
+		};
+
+		l2: cache-controller@f5010000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xf5010000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+			arm,shared-override;
+			arm,tag-latency = <1 1 1>;
+			arm,data-latency = <1 1 2>;
+		};
+
+		scu@f8000000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xf8000000 0x100>;
+		};
+
+		timer@f8000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0xf8000200 0x20>;
+			interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
+			clocks = <&apb_clk>;
+		};
+
+		timer@f8000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xf8000600 0x20>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
+			clocks = <&apb_clk>;
+		};
+
+		watchdog@f8000620 {
+			compatible = "arm,cortex-a9-twd-wdt";
+			reg = <0xf8000620 0x20>;
+			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
+			clocks = <&apb_clk>;
+		};
+
+		gic: interrupt-controller@f8001000 {
+			compatible = "arm,cortex-a9-gic";
+			reg = <0xf8001000 0x1000>,
+			      <0xf8000100 0x100>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+		};
+	};
+};

-- 
2.53.0


