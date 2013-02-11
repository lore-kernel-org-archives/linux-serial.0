From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 1/2] tty: serial: uartlite: Fix sparse and checkpatch warnings
Date: Mon, 11 Feb 2013 19:04:33 +0100
Message-ID: <1360605874-18310-1-git-send-email-michal.simek@xilinx.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:45032 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758507Ab3BKSEl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Feb 2013 13:04:41 -0500
Received: by mail-ee0-f44.google.com with SMTP id l10so3452771eei.31
        for <linux-serial@vger.kernel.org>; Mon, 11 Feb 2013 10:04:37 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, monstr@monstr.eu, arnd@arndb.de, Peter Korsgaard <jacmet@sunsite.dk>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: linux-kernel@vger.kernel.org

Clean coding style and sparse warnings.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 89eee43..31444be 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -19,7 +19,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -615,7 +615,7 @@ static struct platform_driver ulite_platform_driver = {
  * Module setup/teardown
  */
 
-int __init ulite_init(void)
+static int __init ulite_init(void)
 {
 	int ret;
 
@@ -634,11 +634,11 @@ int __init ulite_init(void)
 err_plat:
 	uart_unregister_driver(&ulite_uart_driver);
 err_uart:
-	printk(KERN_ERR "registering uartlite driver failed: err=%i", ret);
+	pr_err("registering uartlite driver failed: err=%i", ret);
 	return ret;
 }
 
-void __exit ulite_exit(void)
+static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
 	uart_unregister_driver(&ulite_uart_driver);
-- 
1.7.0.4

