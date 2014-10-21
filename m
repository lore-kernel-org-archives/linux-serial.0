From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 03/10] tty: serial: bcm63xx: Update the Kconfig help text
Date: Tue, 21 Oct 2014 15:22:59 -0700
Message-ID: <1413930186-23168-4-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:40729 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933804AbaJUWX2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Oct 2014 18:23:28 -0400
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de, geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

Remove incorrect "bcm963xx_uart" module name; add a list of known users;
tweak grammar/indentation/capitalization.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/Kconfig | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4a5c0c8..815b652 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1281,22 +1281,24 @@ config SERIAL_TIMBERDALE
 	Add support for UART controller on timberdale.
 
 config SERIAL_BCM63XX
-	tristate "bcm63xx serial port support"
+	tristate "Broadcom BCM63xx/BCM33xx UART support"
 	select SERIAL_CORE
 	depends on MIPS || ARM || COMPILE_TEST
 	help
-	  If you have a bcm63xx CPU, you can enable its onboard
-	  serial port by enabling this options.
+	  This enables the driver for the onchip UART core found on
+	  the following chipsets:
 
-          To compile this driver as a module, choose M here: the
-          module will be called bcm963xx_uart.
+	    BCM33xx (cable modem)
+	    BCM63xx/BCM63xxx (DSL)
+	    BCM68xx (PON)
+	    BCM7xxx (STB) - DOCSIS console
 
 config SERIAL_BCM63XX_CONSOLE
-	bool "Console on bcm63xx serial port"
+	bool "Console on BCM63xx serial port"
 	depends on SERIAL_BCM63XX=y
 	select SERIAL_CORE_CONSOLE
 	help
-	  If you have enabled the serial port on the bcm63xx CPU
+	  If you have enabled the serial port on the BCM63xx CPU
 	  you can make it the console by answering Y to this option.
 
 config SERIAL_GRLIB_GAISLER_APBUART
-- 
2.1.1

