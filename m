From: Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 03/14] ARM: milbeaut: Add Milbeaut M10V early printk
Date: Mon, 19 Nov 2018 10:01:08 +0900
Message-ID: <1542589274-13878-4-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>, Sugaya Taichi <sugaya.taichi@socionext.com>
List-Id: linux-serial@vger.kernel.org

Add Milbeaut M10V earlyprintk.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/Kconfig.debug            | 12 ++++++++++--
 arch/arm/include/debug/milbeaut.S | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/debug/milbeaut.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d6a49f5..5c44533 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1413,6 +1413,11 @@ choice
 		  options; the platform specific options are deprecated
 		  and will be soon removed.
 
+	config DEBUG_LL_MILBEAUT_UART
+		bool "Kernel low-level debug output via USIO"
+		depends on ARCH_MILBEAUT
+		help
+		  Say Y here if you want to debug with USIO
 endchoice
 
 config DEBUG_AT91_UART
@@ -1534,6 +1539,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/bcm63xx.S" if DEBUG_BCM63XX_UART
 	default "debug/digicolor.S" if DEBUG_DIGICOLOR_UA0
 	default "debug/brcmstb.S" if DEBUG_BRCMSTB_UART
+	default "debug/milbeaut.S" if DEBUG_LL_MILBEAUT_UART
 	default "mach/debug-macro.S"
 
 # Compatibility options for PL01x
@@ -1580,6 +1586,7 @@ config DEBUG_UART_PHYS
 	default 0x18020000 if DEBUG_SIRFATLAS7_UART1
 	default 0x18023000 if DEBUG_BCM_IPROC_UART3
 	default 0x1c090000 if DEBUG_VEXPRESS_UART0_RS1
+	default 0x1e700010 if ARCH_MILBEAUT_M10V
 	default 0x20001000 if DEBUG_HIP01_UART
 	default 0x20060000 if DEBUG_RK29_UART0
 	default 0x20064000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
@@ -1681,7 +1688,7 @@ config DEBUG_UART_PHYS
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART
+		DEBUG_AT91_UART || DEBUG_LL_MILBEAUT_UART
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1755,6 +1762,7 @@ config DEBUG_UART_VIRT
 	default 0xfe100000 if DEBUG_IMX23_UART || DEBUG_IMX28_UART
 	default 0xfe230000 if DEBUG_PICOXCELL_UART
 	default 0xfe300000 if DEBUG_BCM_KONA_UART
+	default 0xfe700010 if ARCH_MILBEAUT_M10V
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xfeb00000 if DEBUG_HI3620_UART || DEBUG_HIX5HD2_UART
 	default 0xfeb24000 if DEBUG_RK3X_UART0
@@ -1796,7 +1804,7 @@ config DEBUG_UART_VIRT
 		DEBUG_S3C64XX_UART || \
 		DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
 		DEBUG_SIRFSOC_UART || DEBUG_DIGICOLOR_UA0 || \
-		DEBUG_AT91_UART
+		DEBUG_AT91_UART || DEBUG_LL_MILBEAUT_UART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/milbeaut.S b/arch/arm/include/debug/milbeaut.S
new file mode 100644
index 0000000..0660e0f
--- /dev/null
+++ b/arch/arm/include/debug/milbeaut.S
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Socionext Inc.
+ */
+
+	.macro addruart, rp, rv, tmp
+	ldr	\rp, =CONFIG_DEBUG_UART_PHYS
+	ldr	\rv, =CONFIG_DEBUG_UART_VIRT
+	.endm
+
+	.macro senduart,rd,rx
+	strh    \rd, [\rx, #0x04]               @ write to TxData register
+	.endm
+
+	.macro waituart,rd,rx
+1:	ldrb    \rd, [\rx, #0x03]               @ SSR
+	tst     \rd, #1 << 1                    @ check TDRE bit
+	beq     1b
+	.endm
+
+	.macro busyuart,rd,rx
+2:	ldrb    \rd, [\rx, #0x03]               @ SSR
+	tst     \rd, #1 << 1                    @ check TEMT bit
+	beq     2b
+	.endm
-- 
1.9.1
