From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 1/9] ARM: meson: debug: add debug UART for earlyprintk support
Date: Thu, 11 Sep 2014 22:11:32 +0200
Message-ID: <1410466300-19168-2-git-send-email-carlo@caione.org>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410466300-19168-1-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, afaerber-l3A5Bk7waGM@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Add the UART definitions needed to support earlyprintk for MesonX SoCs
on UARTAO.

Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
---
 arch/arm/Kconfig.debug         | 14 ++++++++++++--
 arch/arm/include/debug/meson.S | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/debug/meson.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 8f90595..c396ecc 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -340,6 +340,13 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART1 serial port on KEYSTONE2 devices.
 
+	config DEBUG_MESON_UARTAO
+		bool "Kernel low-level debugging via Meson6 UARTAO"
+		depends on ARCH_MESON
+		help
+		  Say Y here if you want kernel low-lever debugging support
+		  on Amlogic Meson6 based platforms on the UARTAO.
+
 	config DEBUG_MMP_UART2
 		bool "Kernel low-level debugging message via MMP UART2"
 		depends on ARCH_MMP
@@ -991,6 +998,7 @@ config DEBUG_STI_UART
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	default "debug/meson.S" if DEBUG_MESON_UARTAO
 	default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
 	default "debug/efm32.S" if DEBUG_LL_UART_EFM32
@@ -1084,6 +1092,7 @@ config DEBUG_UART_PHYS
 	default 0xc8000003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
 	default 0xd0000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
 	default 0xd0012000 if DEBUG_MVEBU_UART
+	default 0xc81004c0 if DEBUG_MESON_UARTAO
 	default 0xd4017000 if DEBUG_MMP_UART2
 	default 0xd4018000 if DEBUG_MMP_UART3
 	default 0xe0000000 if ARCH_SPEAR13XX
@@ -1102,7 +1111,7 @@ config DEBUG_UART_PHYS
 	default 0xfffff700 if ARCH_IOP33X
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
-		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
+		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART
 
 config DEBUG_UART_VIRT
@@ -1138,6 +1147,7 @@ config DEBUG_UART_VIRT
 	default 0xfd012000 if ARCH_MV78XX0
 	default 0xfde12000 if ARCH_DOVE
 	default 0xfe012000 if ARCH_ORION5X
+	default 0xf31004c0 if DEBUG_MESON_UARTAO
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
 	default 0xfe100000 if DEBUG_IMX23_UART || DEBUG_IMX28_UART
@@ -1169,7 +1179,7 @@ config DEBUG_UART_VIRT
 	default 0xff003000 if DEBUG_U300_UART
 	default DEBUG_UART_PHYS if !MMU
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
-		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
+		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART
 
 config DEBUG_UART_8250_SHIFT
diff --git a/arch/arm/include/debug/meson.S b/arch/arm/include/debug/meson.S
new file mode 100644
index 0000000..1bae99b
--- /dev/null
+++ b/arch/arm/include/debug/meson.S
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2014 Carlo Caione
+ * Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define MESON_AO_UART_WFIFO		0x0
+#define MESON_AO_UART_STATUS		0xc
+
+#define MESON_AO_UART_TX_FIFO_EMPTY	(1 << 22)
+#define MESON_AO_UART_TX_FIFO_FULL	(1 << 21)
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =(CONFIG_DEBUG_UART_PHYS)		@ physical
+	ldr	\rv, =(CONFIG_DEBUG_UART_VIRT)		@ virtual
+	.endm
+
+	.macro	senduart,rd,rx
+	str	\rd, [\rx, #MESON_AO_UART_WFIFO]
+	.endm
+
+	.macro	busyuart,rd,rx
+1002:	ldr	\rd, [\rx, #MESON_AO_UART_STATUS]
+	tst	\rd, #MESON_AO_UART_TX_FIFO_EMPTY
+	beq	1002b
+	.endm
+
+	.macro	waituart,rd,rx
+1001:	ldr	\rd, [\rx, #MESON_AO_UART_STATUS]
+	tst	\rd, #MESON_AO_UART_TX_FIFO_FULL
+	bne	1001b
+	.endm
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
