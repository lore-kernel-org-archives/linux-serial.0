From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 3/4] arm: exynos4: Add a new Exynos4 device tree enabled machine
Date: Wed,  3 Aug 2011 00:08:28 +0100
Message-ID: <1312326509-2723-4-git-send-email-thomas.abraham@linaro.org>
References: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org
List-Id: linux-serial@vger.kernel.org

Add a new basic Exynos4 machine with device tree support that can boot
on a Exynos4 processor based board and bring up the console. This acts
as a stating point to add device tree support for Exynos4 architecture.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 Documentation/devicetree/bindings/arm/samsung.txt |    8 ++
 arch/arm/mach-exynos4/Kconfig                     |   10 +++
 arch/arm/mach-exynos4/Makefile                    |    1 +
 arch/arm/mach-exynos4/mach-exynos4-dt.c           |   84 +++++++++++++++++++++
 4 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung.txt
 create mode 100644 arch/arm/mach-exynos4/mach-exynos4-dt.c

diff --git a/Documentation/devicetree/bindings/arm/samsung.txt b/Documentation/devicetree/bindings/arm/samsung.txt
new file mode 100644
index 0000000..ce4a1aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung.txt
@@ -0,0 +1,8 @@
+Samsung Exynos4 based SMDKV310 eval board
+
+    SMDKV310 eval board is based on Samsung's Exynos4 processor architecture.
+
+Required root node properties:
+    - compatible = "samsung,smdkv310","samsung,exynos4"
+        (a) "samsung,smdkv310" - for Samsung's SMDKV310 eval board.
+        (b) "samsung,exynos4"  - for boards based on Exynos4 architecture.
diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 0c77ab9..c29de4e 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -218,6 +218,16 @@ config MACH_NURI
 	help
 	  Machine support for Samsung Mobile NURI Board.
 
+config MACH_EXYNOS4_DT
+	bool "Samsung Exynos4 Machine using device tree"
+	select CPU_EXYNOS4210
+	select USE_OF
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC2
+	select EXYNOS4_SETUP_SDHCI
+	help
+	  Machine support for Samsung Exynos4 machine with device tree enabled.
+
 endmenu
 
 comment "Configuration for HSMMC bus width"
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index b7fe1d7..d2bf5bf 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_MACH_SMDKV310)		+= mach-smdkv310.o
 obj-$(CONFIG_MACH_ARMLEX4210)		+= mach-armlex4210.o
 obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 obj-$(CONFIG_MACH_NURI)			+= mach-nuri.o
+obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 
 # device support
 
diff --git a/arch/arm/mach-exynos4/mach-exynos4-dt.c b/arch/arm/mach-exynos4/mach-exynos4-dt.c
new file mode 100644
index 0000000..47c3892
--- /dev/null
+++ b/arch/arm/mach-exynos4/mach-exynos4-dt.c
@@ -0,0 +1,84 @@
+/*
+ * Samsung's Exynos4 device tree enabled machine.
+ *
+ * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2010-2011 Linaro Ltd.
+ *		www.linaro.org
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/serial_core.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <plat/regs-serial.h>
+#include <plat/exynos4.h>
+#include <plat/cpu.h>
+
+#include <mach/map.h>
+
+/*
+ * The following lookup table is used to override device names when devices
+ * are registered from device tree. This is temporarily added to enable
+ * device tree support addition for the Exynos4 architecture.
+ *
+ * For drivers that require platform data to be provided from the machine
+ * file, a platform data pointer can also be supplied along with the
+ * devices names. Usually, the platform data elements that cannot be parsed
+ * from the device tree by the drivers (example: function pointers) are
+ * supplied. But it should be noted that this is a temporary mechanism and
+ * at some point, the drivers should be capable of parsing all the platform
+ * data from the device tree.
+ */
+static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("samsung,s5pv310-uart", S5P_PA_UART0,
+				"s5pv210-uart.0", NULL),
+	OF_DEV_AUXDATA("samsung,s5pv310-uart", S5P_PA_UART1,
+				"s5pv210-uart.1", NULL),
+	OF_DEV_AUXDATA("samsung,s5pv310-uart", S5P_PA_UART2,
+				"s5pv210-uart.2", NULL),
+	OF_DEV_AUXDATA("samsung,s5pv310-uart", S5P_PA_UART3,
+				"s5pv210-uart.3", NULL),
+	{},
+};
+
+static void __init exynos4_dt_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s3c24xx_init_clocks(24000000);
+}
+
+static const struct of_device_id intc_of_match[] __initconst = {
+	{ .compatible = "samsung,exynos4-gic", },
+	{},
+};
+
+static void __init exynos4_dt_machine_init(void)
+{
+	irq_domain_generate_simple(intc_of_match, EXYNOS4_PA_GIC_DIST, 0);
+	of_platform_populate(NULL, of_default_bus_match_table,
+				exynos4_auxdata_lookup, NULL);
+}
+
+static char const *exynos4_dt_compat[] __initdata = {
+	"samsung,exynos4",
+	NULL
+};
+
+DT_MACHINE_START(SMDKV310, "Samsung Exynos4 DT")
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	.init_irq	= exynos4_init_irq,
+	.map_io		= exynos4_dt_map_io,
+	.init_machine	= exynos4_dt_machine_init,
+	.timer		= &exynos4_timer,
+	.dt_compat	= exynos4_dt_compat,
+MACHINE_END
-- 
1.7.4.1
