From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/6] Revert "drivers/tty/serial: make 8250/8250_ingenic.c explicitly non-modular"
Date: Thu, 11 Feb 2016 16:41:28 +0100
Message-ID: <1455205297-1021302-3-git-send-email-arnd@arndb.de>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>
List-Id: linux-serial@vger.kernel.org

This reverts commit cafe1ac64023, which tried to remove dead code but
left the driver in a useless state when the main 8250 driver is a
loadable module. This would normally result in a link error, but
as the entire drivers/tty/serial/8250/ directory is only entered
when CONFIG_SERIAL_8250 is set, we never notice that the driver does
not get built in this configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cafe1ac64023 ("drivers/tty: make serial 8250_ingenic.c explicitly non-modular")
---
 drivers/tty/serial/8250/8250_ingenic.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index b4e1d39805b2..97b78558caed 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -4,8 +4,6 @@
  *
  * Ingenic SoC UART support
  *
- * Author: Paul Burton <paul.burton@imgtec.com>
- *
  * This program is free software; you can redistribute	 it and/or modify it
  * under  the terms of	 the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the	License, or (at your
@@ -20,7 +18,7 @@
 #include <linux/console.h>
 #include <linux/io.h>
 #include <linux/libfdt.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_device.h>
@@ -303,6 +301,16 @@ out:
 	return err;
 }
 
+static int ingenic_uart_remove(struct platform_device *pdev)
+{
+	struct ingenic_uart_data *data = platform_get_drvdata(pdev);
+
+	serial8250_unregister_port(data->line);
+	clk_disable_unprepare(data->clk_module);
+	clk_disable_unprepare(data->clk_baud);
+	return 0;
+}
+
 static const struct ingenic_uart_config jz4740_uart_config = {
 	.tx_loadsz = 8,
 	.fifosize = 16,
@@ -325,13 +333,19 @@ static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4780-uart", .data = &jz4780_uart_config },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_match);
 
 static struct platform_driver ingenic_uart_platform_driver = {
 	.driver = {
-		.name			= "ingenic-uart",
-		.of_match_table		= of_match,
-		.suppress_bind_attrs	= true,
+		.name		= "ingenic-uart",
+		.of_match_table	= of_match,
 	},
 	.probe			= ingenic_uart_probe,
+	.remove			= ingenic_uart_remove,
 };
-builtin_platform_driver(ingenic_uart_platform_driver);
+
+module_platform_driver(ingenic_uart_platform_driver);
+
+MODULE_AUTHOR("Paul Burton");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Ingenic SoC UART driver");
-- 
2.7.0
