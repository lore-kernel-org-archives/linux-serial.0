From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] drivers/tty: make serial/mvebu-uart.c explicitly non-modular
Date: Sun, 13 Mar 2016 19:48:52 -0400
Message-ID: <1457912932-23724-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/tty/serial/Kconfig:config SERIAL_MVEBU_UART
drivers/tty/serial/Kconfig:     bool "Marvell EBU serial port support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since the code wasn't using module_init to begin with, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Wilson Ding <dingwei@marvell.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/mvebu-uart.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 0ff27818bb87..df5f1d9e233c 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -1,5 +1,7 @@
 /*
 * ***************************************************************************
+* Marvell Armada-3700 Serial Driver
+* Author: Wilson Ding <dingwei@marvell.com>
 * Copyright (C) 2015 Marvell International Ltd.
 * ***************************************************************************
 * This program is free software: you can redistribute it and/or modify it
@@ -23,7 +25,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -594,30 +595,19 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mvebu_uart_remove(struct platform_device *pdev)
-{
-	struct mvebu_uart_data *data = platform_get_drvdata(pdev);
-
-	uart_remove_one_port(&mvebu_uart_driver, data->port);
-	data->port->private_data = NULL;
-	data->port->mapbase      = 0;
-	return 0;
-}
-
 /* Match table for of_platform binding */
 static const struct of_device_id mvebu_uart_of_match[] = {
 	{ .compatible = "marvell,armada-3700-uart", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, mvebu_uart_of_match);
 
 static struct platform_driver mvebu_uart_platform_driver = {
 	.probe	= mvebu_uart_probe,
-	.remove	= mvebu_uart_remove,
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name  = "mvebu-uart",
 		.of_match_table = of_match_ptr(mvebu_uart_of_match),
+		.suppress_bind_attrs = true,
 	},
 };
 
@@ -635,16 +625,4 @@ static int __init mvebu_uart_init(void)
 
 	return ret;
 }
-
-static void __exit mvebu_uart_exit(void)
-{
-	platform_driver_unregister(&mvebu_uart_platform_driver);
-	uart_unregister_driver(&mvebu_uart_driver);
-}
-
 arch_initcall(mvebu_uart_init);
-module_exit(mvebu_uart_exit);
-
-MODULE_AUTHOR("Wilson Ding <dingwei@marvell.com>");
-MODULE_DESCRIPTION("Marvell Armada-3700 Serial Driver");
-MODULE_LICENSE("GPL");
-- 
2.6.1
