Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795296964;
	b=B8sqs6cOmkOhO1OOJQ5NXJzlGZNkItnP3bBOimgIxj4nF35QqHO9bLPc0rjucc7h4WeM
	 F1lzZuFB0V386vZREnF3jS3AmKx0fi5aBwrHRXYfwFOjQkz6uZPHWoSpHVXV8tiMDHpih
	 yvDwNTdJ/NDrOilYo+43jh80DwS8V+7a1n9KOoN8o/WOxVy7BZj+e+9JMg80Fm7EeScKA
	 5MSDmAP/UIKEjxDiQhJrcVl+Uhm/UmxNkizlscqnSC5pX1mU9solTTNF1vHxF6zRY7AEI
	 ejOKNDkCg1R3+vEg9WfAD3Y8lCaPNLOBCviD9440ULCK5bJkDfr6tS8EUCNngL8HcDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296964;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YE3vXI9trThRKlTPUxAcuUZZSJoH5FvS/IfvvJzaeh8=;
	b=ZXQkGktKDdMgZVtSfM6zzUzhWM5T5f6UtRUja6RkSmJtzypm2JDBC38yAAlCE40k3YeS
	 7tTaMAbOnoeI3De5uWh3JZ5E88U8KywUW0ncS4JhQIQ2+ws210fB8emRKJyxUfiC/ZYIk
	 +aQMG59DSSgBH6EWys41n48uy9zE8pxsyObR/ZHsJqzYBaDj0ynHJbxHLjsOMkCzszNsw
	 7n0Q0breIshLD/BvJ/3k4run1neyDNJFTAD8L4XLyCZCSv3/lDWbaT7jE9iX5C6NzA7qb
	 +NZ3pfneAXB+C9Pi/rdvQ5BSdQpEYaFQogJvW2yr50JQua2kZI++7XAoh6qzSN4WJTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoGKvBfO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AFB606A6A1;
	Sat, 21 Nov 2026 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoGKvBfO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795296964;
	b=rSA1WClxzdZQm3CYxjS0KCAJWioK0e69aOYhXhznBxkFu0QQ2UjNuHxTuOd0+n625ed8
	 Mwdvmpd1JyM7jIJFJlRL1F0USK/qEz1B7SmoCFvuG4Wv9+utcgLexb4BGPAjRolJqFNkr
	 pH+EmRrxDFBMDFz/LluNB3Ac8/SEaene281G0w6NsZJ3A1F876tgkg8chRX+fSnWOKMRG
	 EMmVGycV5OK/FyhkcNRjKExNIAznZrl1CAGVIjis5IwOvG7plCtED1jOUtdHFNhFm/tr1
	 IfJPzanTruShFs0ZxPi5GxWRIxEeNrKXCTyLXgg/ur6I3x2HxmpZYYSr+yBWna+yiPQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795296964;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YE3vXI9trThRKlTPUxAcuUZZSJoH5FvS/IfvvJzaeh8=;
	b=OsmQVTeguuX8EGP0M1t2SMmzTF8a6v/uNNmUJiJog8YETA2gtQ+3e+OF+vrgcVVb2Wi0
	 AW68FvCI3b6RNVy5tbpk/XMSOF+CTl5Gq/ZQfJIoFLOgnrAC6RxEjGrwoclMQdWqsQhpg
	 dtcBEyqA3jnBqElyndGuW88mA1jVun+ezt18QFwzOJ56kqjuehTMNZ9sPveHg7L7nDapr
	 GyuEI1CVIyQjKvZ5pMmOGUcbSV+mp5NBT9cBQWtCwoLyTm4rsrqDSrUUQammY2nZJJoqa
	 uxcwISw3XNVw6EQx/oUj8pNmP2lYDVw16Al/IFA+SP3MvuFJ+EwCcNFHTSuqv71FpRg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7FAA81F000D2;
	Sat, 21 Nov 2026 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795296963;
	bh=YE3vXI9trThRKlTPUxAcuUZZSJoH5FvS/IfvvJzaeh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XoGKvBfOt1lAAWuogz2mwY+CV9P0sskZAsPflXKM3Ymdp2XMzrT0WIUbQueQkDMUs
	 HoTICKg0SgLfTXPpX294UhTdDfckmmFG6IkMoeKhYU7ApgPMIAo3rcrbj14+j3TOjO
	 rrCB81hvZBiHtGWF9lD/Wc6muFzJFiQT2rVTlOnMsRyd3jMisRbkyLx0Y+EzurW7FI
	 y2zRJX7oxVfl6/2k3xc/7kHZHWqpXzOKxZYJY1/8uVayftzstwM1LEiWxW83nQBh8J
	 KkUZo4o/vncK3kML3Wn/fzUnysC7nM3tm29s7i270U++57nqBgPdfzWDWkaWBaIYU3
	 5j3BDapi2SXPQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 461CF4BE09;
	Sat, 21 Nov 2026 21:36:00 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:35:53 +0300
Subject: [PATCH v9 08/10] ARM: dts: cortina: Add CS7542 SoC and Securifi
 Almond+ board
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
Message-Id: <20261122-b4-cs75xx-v9-8-1fc1b90bd097@gmail.com>
References: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
In-Reply-To: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
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
 Jason Li <jason.li@cortina-access.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795296958; l=6235;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=n/Dq4py/0eGRBnmQUzS6IOXN56dx/13Os1x5nNKfay0=;
 b=QjBv7YDFh8DYH6OvBP6oyUz6ukdGjhD7BxqaxBZteqT0cIVlyM9uNqOKQUv8Ek5TsBgmlhOz3
 RoWHTrXCXZ/DV+E0OgY3bIGjyOOvYAFdhClE1UqIigZEdKyYiz5tcqQ
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

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
describe the memory and the console UART, and reserve the top 64 MiB
of RAM which the vendor firmware hands to the packet engine queue
manager.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/cortina/Makefile                 |   3 +
 .../dts/cortina/cs7542-securifi-almondplus.dts     |  46 ++++++++
 arch/arm/boot/dts/cortina/cs7542.dtsi              | 127 +++++++++++++++++++++
 4 files changed, 177 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 28fba538d..cf4433001 100644
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
index 000000000..93be6c9ae
--- /dev/null
+++ b/arch/arm/boot/dts/cortina/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_CORTINA_ACCESS) += \
+	cs7542-securifi-almondplus.dtb
diff --git a/arch/arm/boot/dts/cortina/cs7542-securifi-almondplus.dts b/arch/arm/boot/dts/cortina/cs7542-securifi-almondplus.dts
new file mode 100644
index 000000000..e3152fd1d
--- /dev/null
+++ b/arch/arm/boot/dts/cortina/cs7542-securifi-almondplus.dts
@@ -0,0 +1,46 @@
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
index 000000000..29b0b7da8
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


