From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 1/7] ARM: meson: debug: add debug UART for earlyprintk support
Date: Sun, 17 Aug 2014 12:49:48 +0200
Message-ID: <1408272594-10814-2-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39024 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbaHQKu0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Aug 2014 06:50:26 -0400
In-Reply-To: <1408272594-10814-1-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com
Cc: Carlo Caione <carlo@caione.org>

Add the UART definitions needed to support earlyprintk for MesonX SoCs
on UARTAO.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/Kconfig.debug         | 14 ++++++++++++--
 arch/arm/include/debug/meson.S | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/debug/meson.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b11ad54..16079c5 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -348,6 +348,13 @@ choice
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
@@ -1011,6 +1018,7 @@ config DEBUG_LL_INCLUDE
 	string
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	default "debug/clps711x.S" if DEBUG_CLPS711X_UART1 || DEBUG_CLPS711X_UART2
+	default "debug/meson.S" if DEBUG_MESON_UARTAO
 	default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
 	default "debug/efm32.S" if DEBUG_LL_UART_EFM32
@@ -1106,6 +1114,7 @@ config DEBUG_UART_PHYS
 	default 0xc8000003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
 	default 0xd0000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
 	default 0xd0012000 if DEBUG_MVEBU_UART
+	default 0xc81004c0 if DEBUG_MESON_UARTAO
 	default 0xd4017000 if DEBUG_MMP_UART2
 	default 0xd4018000 if DEBUG_MMP_UART3
 	default 0xe0000000 if ARCH_SPEAR13XX
@@ -1125,7 +1134,7 @@ config DEBUG_UART_PHYS
 	default 0xfffff700 if ARCH_IOP33X
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
-		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
+		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART
 
 config DEBUG_UART_VIRT
@@ -1162,6 +1171,7 @@ config DEBUG_UART_VIRT
 	default 0xfd012000 if ARCH_MV78XX0
 	default 0xfde12000 if ARCH_DOVE
 	default 0xfe012000 if ARCH_ORION5X
+	default 0xf31004c0 if DEBUG_MESON_UARTAO
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
 	default 0xfe100000 if DEBUG_IMX23_UART || DEBUG_IMX28_UART
@@ -1193,7 +1203,7 @@ config DEBUG_UART_VIRT
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
+ * Carlo Caione <carlo@caione.org>
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

