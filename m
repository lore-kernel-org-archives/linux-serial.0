From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] drivers/tty: make serial 8250_ingenic.c explicitly non-modular
Date: Thu, 7 Jan 2016 13:28:32 -0500
Message-ID: <1452191312-552-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Burton <paul.burton@imgtec.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/tty/serial/8250/Kconfig:config SERIAL_8250_INGENIC
drivers/tty/serial/8250/Kconfig:        bool "Support for Ingenic SoC serial ports"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Nobody seemed to jump in and suggest this should be tristate:
 http://lkml.iu.edu/hypermail/linux/kernel/1512.2/03520.html
 so I went ahead with the removal of the dead module code.]

 drivers/tty/serial/8250/8250_ingenic.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index d6e1ec9b4fde..47824887b63f 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -4,6 +4,8 @@
  *
  * Ingenic SoC UART support
  *
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
  * This program is free software; you can redistribute	 it and/or modify it
  * under  the terms of	 the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the	License, or (at your
@@ -18,7 +20,7 @@
 #include <linux/console.h>
 #include <linux/io.h>
 #include <linux/libfdt.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_device.h>
@@ -297,16 +299,6 @@ out:
 	return err;
 }
 
-static int ingenic_uart_remove(struct platform_device *pdev)
-{
-	struct ingenic_uart_data *data = platform_get_drvdata(pdev);
-
-	serial8250_unregister_port(data->line);
-	clk_disable_unprepare(data->clk_module);
-	clk_disable_unprepare(data->clk_baud);
-	return 0;
-}
-
 static const struct ingenic_uart_config jz4740_uart_config = {
 	.tx_loadsz = 8,
 	.fifosize = 16,
@@ -329,19 +321,13 @@ static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4780-uart", .data = &jz4780_uart_config },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, of_match);
 
 static struct platform_driver ingenic_uart_platform_driver = {
 	.driver = {
-		.name		= "ingenic-uart",
-		.of_match_table	= of_match,
+		.name			= "ingenic-uart",
+		.of_match_table		= of_match,
+		.suppress_bind_attrs	= true,
 	},
 	.probe			= ingenic_uart_probe,
-	.remove			= ingenic_uart_remove,
 };
-
-module_platform_driver(ingenic_uart_platform_driver);
-
-MODULE_AUTHOR("Paul Burton");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Ingenic SoC UART driver");
+builtin_platform_driver(ingenic_uart_platform_driver);
-- 
2.6.1
