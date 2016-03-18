From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] serial: Make SERIAL_MVEBU_UART depend on ARCH_MVEBU
Date: Fri, 18 Mar 2016 13:45:51 +0100
Message-ID: <1458305151-6140-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wilson Ding <dingwei@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

Enabling support for the UART on Marvell EBU SoCs only make sense when
compiling for Marvell EBU SoCs, unless compile-testing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 13d4ed6caac4a78b..9ce164db25885009 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1604,6 +1604,7 @@ config SERIAL_STM32_CONSOLE
 
 config SERIAL_MVEBU_UART
 	bool "Marvell EBU serial port support"
+	depends on ARCH_MVEBU || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  This driver is for Marvell EBU SoC's UART. If you have a machine
-- 
1.9.1
