Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DE3EDADC
	for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090955; cv=none; b=RWUEe0SkvktdVVSG+YrLyLVz5TY/v1wk9R6qgNlLcGrfRo4qTDyIB4cgda/lVXb77YKzK80Avg+UwnOp8WIn7M8GfhTZRBvw88qslBZBivdJwY1Nxmmtn9c70NW6lBjVizcgGpQJkEtDSWoweL9JNAhSUE0GE3HvKWrGJzX2tEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090955; c=relaxed/simple;
	bh=zVc0MC2bXysppqkQRDtDyDZJUBKZd60hfNtOAwtOqxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQbD9+cwQVnX4rRuQIPyBgIYwMBHTUE5ip51bRtFY4lqmmLVqibsn2gprK2xGqWNF8ROZXldkgwk6XCMyQF91/5Tc/BwBnAwan1vK+toM1Rb6iMWmR6K90ppZOWWw4VntZhQVcUsDQbDdg20t8gQhEuG6ZuWezaRk+clpWmNNBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnNMFeAf; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnNMFeAf"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso6556738a91.2
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 04:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781090953; x=1781695753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M48g1rCWscfQlBlf5X+TWnsGxGVdXiBVb0x/zKO5E7k=;
        b=pnNMFeAf6kGFAPJGq+GrBJwJrISWhZ1bDNfVfK8yEegUEe5rIP+8SpLTbSt/2mSH0Q
         QOBZ2uZZJqsWEXgZGVNL/KwaAFGkiJmKuAQHVZ8qoVkPwExMeHwalWL1tofRcytI3cAt
         IpvtMyUYyXjz2ElaN2oZT8Q6T3eicwpE/iwnyeA7w1CPLRLZc8Sb0c+VH0YoK0/cksu4
         ExAuK7RnuhFbjKL8JDodBE/UYuE7gIq/zWKSJaA9ss6c18AOdydVtiiszN3UslXshVxx
         nkbBVSumETDW2AvGxQyexPSXDDLOFbgjmKQ+dMotM5JmBoCWzIhUsfO26JwcxqjGcZwq
         v/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781090953; x=1781695753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M48g1rCWscfQlBlf5X+TWnsGxGVdXiBVb0x/zKO5E7k=;
        b=o2gaI8g3OR0teb26pRwPcaX/ea1Wsk+WJXQlfb8qIQn2JAXDKG8IVgRAQLFg4TNoPA
         syoH18W8t8HqVoN90mPmuiN7mnfekPcReb4BJlFNlfWLB61B38DBD98oPFookFWOcpFG
         8XQcp1XVBv771WVJgYb0a3//vWR+rJWYnVx2iduubsdQRKIyFjqoQ7cHtp0lNgIJs/0s
         T/XJBqIclntP5PCjSGeIcm0xPrGv8HqwBAvDHB2VfIRpnhNzNF8QI7LbiP7IYG4QwJRL
         yMWT6mfDP13NO45GUtJOPuaUC0MFYCh8ToUKJUwmWnsA6KkC8qoRaAbgG96mzVEVWEMY
         XKQw==
X-Forwarded-Encrypted: i=1; AFNElJ/5DENtu30pbYo1R39gDlF23TkrjSEmQXvZKAz1/4ZxlStoosnYkghzVTCLdLnlS+JCxg9omeTyg3OnTx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSk0YL0kTKf9jVxT3TTO6I8/yOs8wOVlS8cc1nDkt288SIkFxN
	bCKmgh+o3qr2atZLqp3y+fpoPb2IMX/0F3furfPl/KwQmjrQpZseI7bW
X-Gm-Gg: Acq92OHU//Duwp8VrZ6AM9vx2TpzwU2U84k1RiTmjYOT2piBfjFfkBwFxDlis/FyJKZ
	yVFuO1D7pspv4g+rP7qaeslLCcM/G4qVOXZvpLPm5MyIDr/T8Jq/iNLLPTiHYcPx6fK9aOx61YY
	ExPKH/lMnTmVKOYm1r3+f9tGTy3vkmCzc5MOLIrKzBCDa1vCEw1A9wuoe9Sij1FPvZoHCXWUE/+
	RvrvGWonBwhjws0yRF2ztTDc5BoBcEDofxqURudDB7toe5jwDusVvmNxEPJ2L0svom4QBMJusX+
	8/N6pjJMOwssSsF9Wkp5yG22O5rNb5PvesTDZhaprImch9r4PuMmQMilWgeSv1P4J1hlbnoHcks
	tIf4gFoMoUptMiYdNxZyBUcDBbMdsYKdN9G49+dVnG6TARlqczil/ES4l82cFbRKLL9+PRQCV/w
	sPKQ/BL33F/KD23GJwPZZ3h5SYgZO9LhFWcCb6fEY58lj3R9xFMOD8eQ==
X-Received: by 2002:a17:90b:48ca:b0:36b:71e6:3de8 with SMTP id 98e67ed59e1d1-370f122d6a6mr26906196a91.24.1781090953042;
        Wed, 10 Jun 2026 04:29:13 -0700 (PDT)
Received: from hc-pb-01.realtek.com ([123.51.179.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-376460ee14fsm2027651a91.1.2026.06.10.04.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:29:12 -0700 (PDT)
From: Jason Li <jason.lee651024@gmail.com>
X-Google-Original-From: Jason Li <jason.li@cortina-access.com>
To: jason.li@cortina-access.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: cortina-access: Add DTS for CA8289 SoC and Venus board
Date: Wed, 10 Jun 2026 19:28:21 +0800
Message-Id: <20260610112821.3030099-5-jason.li@cortina-access.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260610112821.3030099-1-jason.li@cortina-access.com>
References: <20260610112821.3030099-1-jason.li@cortina-access.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SoC DTSI for the Cortina-Access CA8289 (Venus) and a board DTS for
the Venus engineering board. The description covers the minimum set of
hardware nodes needed to boot a kernel with an INITRD rootfs: CPUs,
GIC, timer, PSCI, fixed clock and UART.

Signed-off-by: Jason Li <jason.li@cortina-access.com>
Assisted-by: Claude:claude-opus-4-8
---
 MAINTAINERS                                   |   1 +
 arch/arm64/Kconfig.platforms                  |  10 ++
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/cortina-access/Makefile   |   2 +
 .../dts/cortina-access/ca8289-engboard.dts    |  31 +++++
 .../boot/dts/cortina-access/ca8289-soc.dtsi   | 118 ++++++++++++++++++
 6 files changed, 163 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cortina-access/Makefile
 create mode 100644 arch/arm64/boot/dts/cortina-access/ca8289-engboard.dts
 create mode 100644 arch/arm64/boot/dts/cortina-access/ca8289-soc.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 515d89d96472..ebfdb9c267cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2826,6 +2826,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/cortina-access.yaml
 F:	Documentation/devicetree/bindings/serial/cortina-access,serial.yaml
+F:	arch/arm64/boot/dts/cortina-access/
 
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index dc995a732117..ba6dda0660c3 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -134,6 +134,16 @@ config ARCH_CIX
 	  This enables support for the Cixtech SoC family,
 	  like P1(sky1).
 
+config ARCH_CORTINA_ACCESS
+	bool "Cortina-Access SoC Family"
+	select GPIOLIB
+	select PINCTRL
+	help
+	  This enables support for Cortina-Access SoCs.  The family
+	  includes ARMv8-based devices targeting networking and access
+	  applications.
+	  If you have a Cortina-Access board, say Y here.
+
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 98ec8f1b76e4..a599f525fb9a 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -16,6 +16,7 @@ subdir-y += broadcom
 subdir-y += bst
 subdir-y += cavium
 subdir-y += cix
+subdir-y += cortina-access
 subdir-y += exynos
 subdir-y += freescale
 subdir-y += hisilicon
diff --git a/arch/arm64/boot/dts/cortina-access/Makefile b/arch/arm64/boot/dts/cortina-access/Makefile
new file mode 100644
index 000000000000..554893f381fe
--- /dev/null
+++ b/arch/arm64/boot/dts/cortina-access/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_CORTINA_ACCESS) += ca8289-engboard.dtb
diff --git a/arch/arm64/boot/dts/cortina-access/ca8289-engboard.dts b/arch/arm64/boot/dts/cortina-access/ca8289-engboard.dts
new file mode 100644
index 000000000000..c8289a0f8269
--- /dev/null
+++ b/arch/arm64/boot/dts/cortina-access/ca8289-engboard.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Cortina Access Venus Engineering Board
+ *
+ * Copyright (C) 2026, Cortina Access Inc.
+ *
+ */
+
+/dts-v1/;
+
+#include "ca8289-soc.dtsi"
+
+/ {
+	model = "Cortina Access Venus Engineering Board";
+	compatible = "cortina-access,ca8289-engboard";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {	/* 512MB */
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x0 0x20000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/cortina-access/ca8289-soc.dtsi b/arch/arm64/boot/dts/cortina-access/ca8289-soc.dtsi
new file mode 100644
index 000000000000..8e7ffcf4ccab
--- /dev/null
+++ b/arch/arm64/boot/dts/cortina-access/ca8289-soc.dtsi
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * dts file for Cortina Access CA8289 SoC
+ *
+ * Copyright (C) 2026, Cortina Access Inc.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+		cpu1: cpu@100 {
+			compatible = "arm,cortex-a55", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+		};
+		cpu2: cpu@200 {
+			compatible = "arm,cortex-a55", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+		};
+		cpu3: cpu@300 {
+			compatible = "arm,cortex-a55", "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+		};
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
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	gic: interrupt-controller@4f8000000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		#redistributor-regions = <1>;
+		reg = <0x00000004 0xF8000000 0 0x10000>,
+		      <0x00000004 0xF8040000 0 0x80000>;
+	};
+
+	apb_pclk: apb-pclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* TrustZone reserved region; must not be mapped by the kernel */
+		tz_pool: tz-buffer@f000000 {
+			reg = <0x0 0x0F000000 0x0 0x1000000>;
+			no-map;
+		};
+	};
+
+	/* See Documentation/devicetree/bindings/timer/arm,arch_timer.yaml */
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		clock-frequency = <25000000>;
+	};
+
+	uart0: serial@f4329188 {
+		device_type = "serial";
+		compatible = "cortina-access,serial";
+		reg = <0x00000000 0xf4329188 0x0 0x30>;
+		clocks = <&apb_pclk>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	uart1: serial@f43291b8 {
+		device_type = "serial";
+		compatible = "cortina-access,serial";
+		reg = <0x00000000 0xf43291b8 0x0 0x30>;
+		clocks = <&apb_pclk>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.39.5

