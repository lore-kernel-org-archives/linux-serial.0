From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] serial: sccnxp: Allows the driver to be compiled as a module
Date: Sun, 30 Sep 2012 13:19:19 +0400
Message-ID: <1348996759-2449-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp28.mail.ru ([94.100.176.181]:60142 "EHLO smtp28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab2I3JTd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 30 Sep 2012 05:19:33 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 750671d..b7aaa95 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1105,7 +1105,7 @@ config SERIAL_SC26XX_CONSOLE
 	  Support for Console on SC2681/SC2692 serial ports.
 
 config SERIAL_SCCNXP
-	bool "SCCNXP serial port support"
+	tristate "SCCNXP serial port support"
 	depends on !SERIAL_SC26XX
 	select SERIAL_CORE
 	default n
@@ -1117,7 +1117,7 @@ config SERIAL_SCCNXP
 
 config SERIAL_SCCNXP_CONSOLE
 	bool "Console on SCCNXP serial port"
-	depends on SERIAL_SCCNXP
+	depends on SERIAL_SCCNXP=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  Support for console on SCCNXP serial ports.
-- 
1.7.8.6

