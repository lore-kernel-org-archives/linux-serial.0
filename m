From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: Unneeded ARCH dependencies are removed
Date: Sun, 11 Nov 2012 10:24:19 +0400
Message-ID: <1352615059-2573-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:60973 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab2KKGYt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Nov 2012 01:24:49 -0500
Received: from smtp53.i.mail.ru (smtp53.i.mail.ru [94.100.177.113])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 45144B042A6D
	for <linux-serial@vger.kernel.org>; Sun, 11 Nov 2012 10:24:46 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This patch performs a small cleanup tty/Serial/Kconfig file by removing
unneeded ARCH dependencies. This dependencies already included in
board/type symbols.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/Kconfig |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index b176801..500f043 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -93,7 +93,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 
 config SERIAL_ATMEL
 	bool "AT91 / AT32 on-chip serial port support"
-	depends on (ARM && ARCH_AT91) || AVR32
+	depends on ARCH_AT91 || AVR32
 	select SERIAL_CORE
 	help
 	  This enables the driver for the on-chip UARTs of the Atmel
@@ -198,7 +198,7 @@ config SERIAL_CLPS711X_CONSOLE
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on ARM && PLAT_SAMSUNG
+	depends on PLAT_SAMSUNG
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
@@ -208,14 +208,14 @@ config SERIAL_SAMSUNG
 
 config SERIAL_SAMSUNG_UARTS_4
 	bool
-	depends on ARM && PLAT_SAMSUNG
+	depends on PLAT_SAMSUNG
 	default y if !(CPU_S3C2410 || SERIAL_S3C2412 || CPU_S3C2440 || CPU_S3C2442)
 	help
 	  Internal node for the common case of 4 Samsung compatible UARTs
 
 config SERIAL_SAMSUNG_UARTS
 	int
-	depends on ARM && PLAT_SAMSUNG
+	depends on PLAT_SAMSUNG
 	default 6 if ARCH_S5P6450
 	default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
 	default 3
@@ -249,7 +249,7 @@ config SERIAL_SAMSUNG_CONSOLE
 
 config SERIAL_SIRFSOC
         tristate "SiRF SoC Platform Serial port support"
-        depends on ARM && ARCH_PRIMA2
+        depends on ARCH_PRIMA2
         select SERIAL_CORE
         help
           Support for the on-chip UART on the CSR SiRFprimaII series,
@@ -347,7 +347,7 @@ config SERIAL_ZS_CONSOLE
 
 config SERIAL_21285
 	tristate "DC21285 serial port support"
-	depends on ARM && FOOTBRIDGE
+	depends on FOOTBRIDGE
 	select SERIAL_CORE
 	help
 	  If you have a machine based on a 21285 (Footbridge) StrongARM(R)/
@@ -371,7 +371,7 @@ config SERIAL_21285_CONSOLE
 
 config SERIAL_MPSC
 	bool "Marvell MPSC serial port support"
-	depends on PPC32 && MV64X60
+	depends on MV64X60
 	select SERIAL_CORE
 	help
 	  Say Y here if you want to use the Marvell MPSC serial controller.
@@ -408,7 +408,7 @@ config SERIAL_PXA_CONSOLE
 
 config SERIAL_SA1100
 	bool "SA1100 serial port support"
-	depends on ARM && ARCH_SA1100
+	depends on ARCH_SA1100
 	select SERIAL_CORE
 	help
 	  If you have a machine based on a SA1100/SA1110 StrongARM(R) CPU you
@@ -716,7 +716,7 @@ config SERIAL_SH_SCI_DMA
 
 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
-	depends on MIPS && (SOC_PNX8550 || SOC_PNX833X)
+	depends on SOC_PNX8550 || SOC_PNX833X
 	select SERIAL_CORE
 	help
 	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
@@ -1013,7 +1013,7 @@ config SERIAL_SGI_IOC3
 
 config SERIAL_MSM
 	bool "MSM on-chip serial port support"
-	depends on ARM && ARCH_MSM
+	depends on ARCH_MSM
 	select SERIAL_CORE
 
 config SERIAL_MSM_CONSOLE
@@ -1035,7 +1035,7 @@ config SERIAL_MSM_HS
 
 config SERIAL_VT8500
 	bool "VIA VT8500 on-chip serial port support"
-	depends on ARM && ARCH_VT8500
+	depends on ARCH_VT8500
 	select SERIAL_CORE
 
 config SERIAL_VT8500_CONSOLE
@@ -1045,7 +1045,7 @@ config SERIAL_VT8500_CONSOLE
 
 config SERIAL_NETX
 	tristate "NetX serial port support"
-	depends on ARM && ARCH_NETX
+	depends on ARCH_NETX
 	select SERIAL_CORE
 	help
 	  If you have a machine based on a Hilscher NetX SoC you
-- 
1.7.8.6

