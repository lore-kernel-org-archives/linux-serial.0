From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/3] serial: pxa: make it explicitly non-modular
Date: Mon, 20 Jun 2016 18:55:03 -0400
Message-ID: <20160620225505.7320-2-paul.gortmaker@windriver.com>
References: <20160620225505.7320-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160620225505.7320-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/tty/serial/Kconfig:config SERIAL_PXA
drivers/tty/serial/Kconfig:     bool "PXA serial port support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE and MODULE_ALIAS are both a
no-op for non-modular builds.

We also delete the MODULE_LICENSE tag since that information is
already contained at the top of the file in the comments.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/pxa.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 41eab75ba2af..29c2309b4b28 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -27,7 +27,6 @@
 #define SUPPORT_SYSRQ
 #endif
 
-#include <linux/module.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -829,7 +829,6 @@ static const struct of_device_id serial_pxa_dt_ids[] = {
 	{ .compatible = "mrvl,mmp-uart", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
 
 static int serial_pxa_probe_dt(struct platform_device *pdev,
 			       struct uart_pxa_port *sport)
@@ -914,28 +913,15 @@ static int serial_pxa_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int serial_pxa_remove(struct platform_device *dev)
-{
-	struct uart_pxa_port *sport = platform_get_drvdata(dev);
-
-	uart_remove_one_port(&serial_pxa_reg, &sport->port);
-
-	clk_unprepare(sport->clk);
-	clk_put(sport->clk);
-	kfree(sport);
-
-	return 0;
-}
-
 static struct platform_driver serial_pxa_driver = {
         .probe          = serial_pxa_probe,
-        .remove         = serial_pxa_remove,
 
 	.driver		= {
 	        .name	= "pxa2xx-uart",
 #ifdef CONFIG_PM
 		.pm	= &serial_pxa_pm_ops,
 #endif
+		.suppress_bind_attrs = true,
 		.of_match_table = serial_pxa_dt_ids,
 	},
 };
@@ -954,15 +940,4 @@ static int __init serial_pxa_init(void)
 
 	return ret;
 }
-
-static void __exit serial_pxa_exit(void)
-{
-	platform_driver_unregister(&serial_pxa_driver);
-	uart_unregister_driver(&serial_pxa_reg);
-}
-
-module_init(serial_pxa_init);
-module_exit(serial_pxa_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:pxa2xx-uart");
+device_initcall(serial_pxa_init);
-- 
2.8.4
