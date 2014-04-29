From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: add missing SERIAL_CORE dependencies
Date: Tue, 29 Apr 2014 22:26:22 +0200
Message-ID: <4248250.YpsTrJcea5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:49211 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbaD2U0b (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Apr 2014 16:26:31 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, Johannes Thumshirn <johannes.thumshirn@men.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Two new drivers have been added since 3.14, the MEN 16z135 uart, and
the ARM semihosting console. Both are missing an explicit 'select
SERIAL_CORE', which can leads build errors when no other driver
selects the core, as found during ARM randconfig testing.
In case of the ARM semihosting console, we also have to select
SERIAL_CORE_CONSOLE.

This adds the missing 'select' statements.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index da67813..cd398cb 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -76,6 +76,8 @@ config SERIAL_AMBA_PL011_CONSOLE
 config SERIAL_EARLYCON_ARM_SEMIHOST
 	bool "Early console using ARM semihosting"
 	depends on ARM64 || ARM
+	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
 	  Support for early debug console using ARM semihosting. This enables
@@ -1539,6 +1541,7 @@ config SERIAL_ST_ASC_CONSOLE
 
 config SERIAL_MEN_Z135
 	tristate "MEN 16z135 Support"
+	select SERIAL_CORE
 	depends on MCB
 	help
 	  Say yes here to enable support for the MEN 16z135 High Speed UART IP-Core

