From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] serial: 8250_ingenic: delete redundant "select SERIAL_EARLYCON"
Date: Fri, 23 Oct 2015 22:31:15 +0900
Message-ID: <1445607076-14135-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Paul Burton <paul.burton@imgtec.com>, Peter Hurley <peter@hurleysoftware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joachim Eastwood <manabian@gmail.com>, John Crispin <blogic@openwrt.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

SERIAL_8250_INGENIC depends on SERIAL_8250_CONSOLE, which already
selects SERIAL_EARLYCON.

This line is redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index e1de118..960da95 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -362,7 +362,6 @@ config SERIAL_8250_INGENIC
 	bool "Support for Ingenic SoC serial ports"
 	depends on SERIAL_8250_CONSOLE && OF_FLATTREE
 	select LIBFDT
-	select SERIAL_EARLYCON
 	help
 	  If you have a system using an Ingenic SoC and wish to make use of
 	  its UARTs, say Y to this option. If unsure, say N.
-- 
1.9.1
