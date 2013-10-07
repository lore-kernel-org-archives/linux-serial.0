From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] serial: i.MX: do not allow to build as module
Date: Mon, 7 Oct 2013 09:44:32 -0300
Message-ID: <1381149872-13646-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:53953
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752764Ab3JGMsk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Oct 2013 08:48:40 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: s.hauer@pengutronix.de, linux@roeck-us.net, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Sascha Hauer <s.hauer@pengutronix.de>

Commit f7d2c0bbdb (serial: i.MX: evaluate linux,stdout-path property) adds a
call to add_preferred_console() into drivers/tty/serial/imx.c. The file can be
built as module, yet add_preferred_console() is not exported.

Fix the build failure by disabling module build for the i.MX driver.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 701ca60..47a05fd 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -551,7 +551,7 @@ config BFIN_UART3_CTSRTS
 	  Enable hardware flow control in the driver.
 
 config SERIAL_IMX
-	tristate "IMX serial port support"
+	bool "IMX serial port support"
 	depends on ARCH_MXC
 	select SERIAL_CORE
 	select RATIONAL
-- 
1.8.1.2


