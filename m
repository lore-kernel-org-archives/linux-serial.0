From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 7/9] ARM: meson: add basic support for MesonX SoCs
Date: Thu, 11 Sep 2014 22:11:38 +0200
Message-ID: <1410466300-19168-8-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410466300-19168-1-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This patch adds the basic machine file for the MesonX SoCs. Only Meson6
is populated.

Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
---
 arch/arm/Kconfig             |  2 ++
 arch/arm/Makefile            |  1 +
 arch/arm/mach-meson/Kconfig  | 13 +++++++++++++
 arch/arm/mach-meson/Makefile |  1 +
 arch/arm/mach-meson/meson.c  | 27 +++++++++++++++++++++++++++
 5 files changed, 44 insertions(+)
 create mode 100644 arch/arm/mach-meson/Kconfig
 create mode 100644 arch/arm/mach-meson/Makefile
 create mode 100644 arch/arm/mach-meson/meson.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 88acf8b..cf7f870 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -956,6 +956,8 @@ source "arch/arm/mach-kirkwood/Kconfig"
 
 source "arch/arm/mach-ks8695/Kconfig"
 
+source "arch/arm/mach-meson/Kconfig"
+
 source "arch/arm/mach-msm/Kconfig"
 
 source "arch/arm/mach-moxart/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6721fab..f998803 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -166,6 +166,7 @@ machine-$(CONFIG_ARCH_KEYSTONE)		+= keystone
 machine-$(CONFIG_ARCH_KIRKWOOD)		+= kirkwood
 machine-$(CONFIG_ARCH_KS8695)		+= ks8695
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
+machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
 machine-$(CONFIG_ARCH_MOXART)		+= moxart
 machine-$(CONFIG_ARCH_MSM)		+= msm
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
new file mode 100644
index 0000000..2c1154e
--- /dev/null
+++ b/arch/arm/mach-meson/Kconfig
@@ -0,0 +1,13 @@
+menuconfig ARCH_MESON
+	bool "Amlogic Meson SoCs" if ARCH_MULTI_V7
+	select GENERIC_IRQ_CHIP
+	select ARM_GIC
+
+if ARCH_MESON
+
+config MACH_MESON6
+	bool "Amlogic Meson6 (8726MX) SoCs support"
+	default ARCH_MESON
+	select MESON6_TIMER
+
+endif
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
new file mode 100644
index 0000000..9d7380e
--- /dev/null
+++ b/arch/arm/mach-meson/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_MESON) += meson.o
diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
new file mode 100644
index 0000000..5ee064f
--- /dev/null
+++ b/arch/arm/mach-meson/meson.c
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2014 Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+
+static const char * const m6_common_board_compat[] = {
+	"amlogic,meson6",
+	NULL,
+};
+
+DT_MACHINE_START(AML8726_MX, "Amlogic Meson6 platform")
+	.dt_compat	= m6_common_board_compat,
+MACHINE_END
+
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
