From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/6] serial: of: CONFIG_SERIAL_8250 is always set
Date: Mon, 16 Nov 2015 16:48:13 +0100
Message-ID: <1447688894-2936779-6-git-send-email-arnd@arndb.de>
References: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

The only other user of this code was the nwp-serial driver, but that
is now gone, so we can remove a couple of #ifdef statments in this
driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/of_serial.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 276c804e7eb4..7044eb2be91b 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -21,10 +21,6 @@
 #include <linux/nwpserial.h>
 #include <linux/clk.h>
 
-#ifdef CONFIG_SERIAL_8250_MODULE
-#define CONFIG_SERIAL_8250 CONFIG_SERIAL_8250_MODULE
-#endif
-
 #include "8250/8250.h"
 
 struct of_serial_info {
@@ -195,7 +191,6 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 		goto out;
 
 	switch (port_type) {
-#ifdef CONFIG_SERIAL_8250
 	case PORT_8250 ... PORT_MAX_8250:
 	{
 		struct uart_8250_port port8250;
@@ -212,7 +207,6 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 		ret = serial8250_register_8250_port(&port8250);
 		break;
 	}
-#endif
 	default:
 		/* need to add code for these */
 	case PORT_UNKNOWN:
@@ -240,11 +234,9 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 {
 	struct of_serial_info *info = platform_get_drvdata(ofdev);
 	switch (info->type) {
-#ifdef CONFIG_SERIAL_8250
 	case PORT_8250 ... PORT_MAX_8250:
 		serial8250_unregister_port(info->line);
 		break;
-#endif
 	default:
 		/* need to add code for these */
 		break;
@@ -257,7 +249,6 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-#ifdef CONFIG_SERIAL_8250
 static void of_serial_suspend_8250(struct of_serial_info *info)
 {
 	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
@@ -278,15 +269,6 @@ static void of_serial_resume_8250(struct of_serial_info *info)
 
 	serial8250_resume_port(info->line);
 }
-#else
-static inline void of_serial_suspend_8250(struct of_serial_info *info)
-{
-}
-
-static inline void of_serial_resume_8250(struct of_serial_info *info)
-{
-}
-#endif
 
 static int of_serial_suspend(struct device *dev)
 {
-- 
2.1.0.rc2
