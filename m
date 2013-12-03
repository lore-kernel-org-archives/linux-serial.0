From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: Remove old SC26XX driver
Date: Tue,  3 Dec 2013 19:23:12 +0400
Message-ID: <1386084192-24158-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:57684 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab3LCP43 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Dec 2013 10:56:29 -0500
Received: from smtp2.mail.ru (smtp2.mail.ru [94.100.176.130])
	by fallback2.mail.ru (mPOP.Fallback_MX) with ESMTP id 3B5E5F658824
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2013 19:23:33 +0400 (MSK)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

New driver for NXP (Philips) UART ICs was introduced in September 2012.
Old driver no longer used anywhere, this patch removes it.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/Kconfig  |  18 --
 drivers/tty/serial/Makefile |   1 -
 drivers/tty/serial/sc26xx.c | 749 --------------------------------------------
 3 files changed, 768 deletions(-)
 delete mode 100644 drivers/tty/serial/sc26xx.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a3817ab..7fbbbad 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1146,31 +1146,13 @@ config SERIAL_QE
 	  This driver supports the QE serial ports on Freescale embedded
 	  PowerPC that contain a QUICC Engine.
 
-config SERIAL_SC26XX
-	tristate "SC2681/SC2692 serial port support"
-	depends on SNI_RM
-	select SERIAL_CORE
-	help
-	  This is a driver for the onboard serial ports of
-	  older RM400 machines.
-
-config SERIAL_SC26XX_CONSOLE
-	bool "Console on SC2681/SC2692 serial port"
-	depends on SERIAL_SC26XX=y
-	select SERIAL_CORE_CONSOLE
-	help
-	  Support for Console on SC2681/SC2692 serial ports.
-
 config SERIAL_SCCNXP
 	tristate "SCCNXP serial port support"
-	depends on !SERIAL_SC26XX
 	select SERIAL_CORE
-	default n
 	help
 	  This selects support for an advanced UART from NXP (Philips).
 	  Supported ICs are SCC2681, SCC2691, SCC2692, SC28L91, SC28L92,
 	  SC28L202, SCC68681 and SCC68692.
-	  Positioned as a replacement for the driver SC26XX.
 
 config SERIAL_SCCNXP_CONSOLE
 	bool "Console on SCCNXP serial port"
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 3068c77..3680854 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -47,7 +47,6 @@ obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
 obj-$(CONFIG_SERIAL_MPSC) += mpsc.o
 obj-$(CONFIG_SERIAL_SB1250_DUART) += sb1250-duart.o
 obj-$(CONFIG_ETRAX_SERIAL) += crisv10.o
-obj-$(CONFIG_SERIAL_SC26XX) += sc26xx.o
 obj-$(CONFIG_SERIAL_SCCNXP) += sccnxp.o
 obj-$(CONFIG_SERIAL_JSM) += jsm/
 obj-$(CONFIG_SERIAL_TXX9) += serial_txx9.o
diff --git a/drivers/tty/serial/sc26xx.c b/drivers/tty/serial/sc26xx.c
deleted file mode 100644
index 887b4f7..0000000
-- 
1.8.3.2

