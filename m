From: Paul Osmialowski <pawelo@king.net.pl>
Subject: [PATCH v2 2/9] arm: twr-k70f120m: basic support for Kinetis TWR-K70F120M
Date: Tue, 30 Jun 2015 14:27:23 +0200
Message-ID: <1435667250-28299-3-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Paul Bolle <pebolle@tiscali.nl>, Thomas Gleixner <tglx@linutronix.de>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Paul Osmialowski <pawelo@king.net.pl>, Anson Huang <b20788@freescale.com>, Frank Li <Frank.Li@freescale.com>, Jingchang Lu <jingchang.lu@freescale.com>, Rob Herring <r.herring@freescale.com>, Yuri Tikhonov <yur@emcraft.com>, Sergei Poselenov <sposelenov@emcraft.com>, Alexander Potashev <aspotashev@emcraft.com>
List-Id: linux-serial@vger.kernel.org

This one was inspired by a serie of commits published on Emcraft git repo:

https://github.com/EmcraftSystems/linux-emcraft.git

Entry commit: f014da1df860ad702d923c95cb97e068bd302cb0
 RT75957. twr-k70f120m: basic support

by: Alexander Potashev <aspotashev@emcraft.com>

Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
---
 Documentation/devicetree/bindings/arm/fsl.txt |  6 +++++
 arch/arm/Kconfig                              |  9 ++++++-
 arch/arm/Kconfig-nommu                        |  1 +
 arch/arm/Makefile                             |  1 +
 arch/arm/boot/dts/kinetis-twr-k70f120m.dts    | 16 +++++++++++++
 arch/arm/boot/dts/kinetis.dtsi                |  5 ++++
 arch/arm/mach-kinetis/Makefile                |  5 ++++
 arch/arm/mach-kinetis/Makefile.boot           |  3 +++
 arch/arm/mach-kinetis/idle.c                  | 27 +++++++++++++++++++++
 arch/arm/mach-kinetis/kinetis.c               | 34 +++++++++++++++++++++++++++
 arch/arm/mm/Kconfig                           |  1 +
 11 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/kinetis-twr-k70f120m.dts
 create mode 100644 arch/arm/boot/dts/kinetis.dtsi
 create mode 100644 arch/arm/mach-kinetis/Makefile
 create mode 100644 arch/arm/mach-kinetis/Makefile.boot
 create mode 100644 arch/arm/mach-kinetis/idle.c
 create mode 100644 arch/arm/mach-kinetis/kinetis.c

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 2a3ba73..36179fd 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -135,3 +135,9 @@ LS2085A ARMv8 based Simulator model
 Required root node properties:
     - compatible = "fsl,ls2085a-simu", "fsl,ls2085a";
 
+Freescale Kinetis SoC Device Tree Bindings
+------------------------------------------
+
+TWR-K70F120M Kinetis K70 based development board.
+Required root node compatible properties:
+  - compatible = "fsl,kinetis-twr-k70f120m"
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a750c14..9c89bdc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -964,6 +964,13 @@ config ARCH_EFM32
 	  Support for Energy Micro's (now Silicon Labs) efm32 Giant Gecko
 	  processors.
 
+config ARCH_KINETIS
+	bool "Freescale Kinetis MCU"
+	depends on ARM_SINGLE_ARMV7M
+	select ARMV7M_SYSTICK
+	help
+	  This enables support for the Freescale Kinetis MCUs
+
 config ARCH_LPC18XX
 	bool "NXP LPC18xx/LPC43xx"
 	depends on ARM_SINGLE_ARMV7M
@@ -1733,7 +1740,7 @@ source "mm/Kconfig"
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
 	range 11 64 if ARCH_SHMOBILE_LEGACY
-	default "12" if SOC_AM33XX
+	default "12" if SOC_AM33XX || ARCH_KINETIS
 	default "9" if SA1111 || ARCH_EFM32
 	default "11"
 	help
diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index d081fcb..4b9aab3 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -65,6 +65,7 @@ config ARM_MPU
 
 config COPY_VECTOR_TABLE_TO_SRAM_ADDR
 	hex 'If non-zero, copy Vector Table to this SRAM Address' if CPU_V7M
+	default 0x20000000 if ARCH_KINETIS
 	default 0x00000000
 	depends on CPU_V7M
 	help
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 07ab3d2..e71fc01 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -170,6 +170,7 @@ machine-$(CONFIG_ARCH_IOP32X)		+= iop32x
 machine-$(CONFIG_ARCH_IOP33X)		+= iop33x
 machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
 machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
+machine-$(CONFIG_ARCH_KINETIS)		+= kinetis
 machine-$(CONFIG_ARCH_KS8695)		+= ks8695
 machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
diff --git a/arch/arm/boot/dts/kinetis-twr-k70f120m.dts b/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
new file mode 100644
index 0000000..edccf37
--- /dev/null
+++ b/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
@@ -0,0 +1,16 @@
+/*
+ * Device tree for TWR-K70F120M development board.
+ *
+ */
+
+/dts-v1/;
+#include "kinetis.dtsi"
+
+/ {
+	model = "Freescale TWR-K70F120M Development Kit";
+	compatible = "fsl,kinetis-twr-k70f120m";
+
+	memory {
+		reg = <0x8000000 0x8000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/kinetis.dtsi b/arch/arm/boot/dts/kinetis.dtsi
new file mode 100644
index 0000000..93d2a8a
--- /dev/null
+++ b/arch/arm/boot/dts/kinetis.dtsi
@@ -0,0 +1,5 @@
+/*
+ * Device tree for Freescale Kinetis SoC.
+ *
+ */
+#include "armv7-m.dtsi"
diff --git a/arch/arm/mach-kinetis/Makefile b/arch/arm/mach-kinetis/Makefile
new file mode 100644
index 0000000..e759d9e
--- /dev/null
+++ b/arch/arm/mach-kinetis/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the Freescale Kinetis platform files
+#
+
+obj-y += kinetis.o idle.o
diff --git a/arch/arm/mach-kinetis/Makefile.boot b/arch/arm/mach-kinetis/Makefile.boot
new file mode 100644
index 0000000..3b442ab
--- /dev/null
+++ b/arch/arm/mach-kinetis/Makefile.boot
@@ -0,0 +1,3 @@
+   zreladdr-y	:= 0x08008000
+params_phys-y	:= 0x08000100
+initrd_phys-y	:= 0x08100000
diff --git a/arch/arm/mach-kinetis/idle.c b/arch/arm/mach-kinetis/idle.c
new file mode 100644
index 0000000..79d2e1c
--- /dev/null
+++ b/arch/arm/mach-kinetis/idle.c
@@ -0,0 +1,27 @@
+/*
+ * arch/arm/mach-kinetis/idle.c
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <asm/system_misc.h>
+#include <asm/proc-fns.h>
+
+static void kinetis_idle(void)
+{
+	asm volatile ("wfi");
+
+	/*
+	 * This is a dirty hack that invalidates the I/D bus cache
+	 * on Kinetis K70. This must be done after idle.
+	 */
+	writel(readl(IOMEM(0xe0082000)) | 0x85000000, IOMEM(0xe0082000));
+}
+
+static int __init kinetis_idle_init(void)
+{
+	arm_pm_idle = kinetis_idle;
+	return 0;
+}
+
+arch_initcall(kinetis_idle_init);
diff --git a/arch/arm/mach-kinetis/kinetis.c b/arch/arm/mach-kinetis/kinetis.c
new file mode 100644
index 0000000..45e15c6
--- /dev/null
+++ b/arch/arm/mach-kinetis/kinetis.c
@@ -0,0 +1,34 @@
+/*
+ * kinetis.c - Freescale Kinetis K70F120M Development Board
+ *
+ * Based on legacy pre-OF code by Alexander Potashev <aspotashev@emcraft.com>
+ *
+ * (C) Copyright 2011, 2012
+ * Emcraft Systems, <www.emcraft.com>
+ * Alexander Potashev <aspotashev@emcraft.com>
+ *
+ * Copyright (C) 2015 Paul Osmialowski <pawelo@king.net.pl>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <asm/v7m.h>
+#include <asm/mach/arch.h>
+
+static const char *const kinetis_compat[] __initconst = {
+	"fsl,kinetis-twr-k70f120m",
+	NULL
+};
+
+/*
+ * Freescale Kinetis platform machine description
+ */
+DT_MACHINE_START(KINETIS, "Freescale Kinetis")
+	.dt_compat	= kinetis_compat,
+	.restart	= armv7m_restart,
+MACHINE_END
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7c6b976..121b580 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -609,6 +609,7 @@ config CPU_V7M_NUM_IRQ
 	depends on CPU_V7M
 	default 90 if ARCH_STM32
 	default 38 if ARCH_EFM32
+	default 106 if ARCH_KINETIS
 	default 112 if SOC_VF610
 	default 240
 	help
-- 
2.3.6
