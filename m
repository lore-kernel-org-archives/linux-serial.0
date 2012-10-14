From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 01/12] serial: clps711x: Add platform_driver interface to clps711x driver
Date: Sun, 14 Oct 2012 11:05:23 +0400
Message-ID: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:37937 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHFo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:05:44 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |   39 +++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index d0f719f..07fef1c 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -37,10 +37,13 @@
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 
+#define UART_CLPS711X_NAME	"uart-clps711x"
+
 #define UART_NR		2
 
 #define SERIAL_CLPS711X_MAJOR	204
@@ -543,7 +546,7 @@ static struct uart_driver clps711x_reg = {
 	.cons			= CLPS711X_CONSOLE,
 };
 
-static int __init clps711xuart_init(void)
+static int __devinit uart_clps711x_probe(struct platform_device *pdev)
 {
 	int ret, i;
 
@@ -559,7 +562,7 @@ static int __init clps711xuart_init(void)
 	return 0;
 }
 
-static void __exit clps711xuart_exit(void)
+static int __devexit uart_clps711x_remove(struct platform_device *pdev)
 {
 	int i;
 
@@ -567,12 +570,36 @@ static void __exit clps711xuart_exit(void)
 		uart_remove_one_port(&clps711x_reg, &clps711x_ports[i]);
 
 	uart_unregister_driver(&clps711x_reg);
+
+	return 0;
 }
 
-module_init(clps711xuart_init);
-module_exit(clps711xuart_exit);
+static struct platform_driver clps711x_uart_driver = {
+	.driver = {
+		.name	= UART_CLPS711X_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe	= uart_clps711x_probe,
+	.remove	= __devexit_p(uart_clps711x_remove),
+};
+module_platform_driver(clps711x_uart_driver);
+
+static struct platform_device clps711x_uart_device = {
+	.name	= UART_CLPS711X_NAME,
+};
+
+static int __init uart_clps711x_init(void)
+{
+	return platform_device_register(&clps711x_uart_device);
+}
+module_init(uart_clps711x_init);
+
+static void __exit uart_clps711x_exit(void)
+{
+	platform_device_unregister(&clps711x_uart_device);
+}
+module_exit(uart_clps711x_exit);
 
 MODULE_AUTHOR("Deep Blue Solutions Ltd");
-MODULE_DESCRIPTION("CLPS-711x generic serial driver");
+MODULE_DESCRIPTION("CLPS711X serial driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_CHARDEV(SERIAL_CLPS711X_MAJOR, SERIAL_CLPS711X_MINOR);
-- 
1.7.8.6

