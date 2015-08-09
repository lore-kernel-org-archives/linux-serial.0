From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 5/5] drivers/tty: make serial 8250_lpc18xx.c explicitly non-modular
Date: Sat, 8 Aug 2015 20:51:37 -0400
Message-ID: <1439081497-14986-6-git-send-email-paul.gortmaker@windriver.com>
References: <1439081497-14986-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439081497-14986-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Joachim Eastwood <manabian@gmail.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

8250/Kconfig:config SERIAL_8250_LPC18XX
8250/Kconfig:        bool "NXP LPC18xx/43xx serial port support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We leave some tags like MODULE_AUTHOR for documentation purposes.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250/8250_lpc18xx.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 99cd478851ff..f5112bee1ab6 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -15,7 +15,7 @@
 
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
@@ -198,33 +198,22 @@ dis_clk_reg:
 	return ret;
 }
 
-static int lpc18xx_serial_remove(struct platform_device *pdev)
-{
-	struct lpc18xx_uart_data *data = platform_get_drvdata(pdev);
-
-	serial8250_unregister_port(data->line);
-	clk_disable_unprepare(data->clk_uart);
-	clk_disable_unprepare(data->clk_reg);
-
-	return 0;
-}
-
 static const struct of_device_id lpc18xx_serial_match[] = {
 	{ .compatible = "nxp,lpc1850-uart" },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, lpc18xx_serial_match);
 
 static struct platform_driver lpc18xx_serial_driver = {
 	.probe  = lpc18xx_serial_probe,
-	.remove = lpc18xx_serial_remove,
 	.driver = {
 		.name = "lpc18xx-uart",
 		.of_match_table = lpc18xx_serial_match,
 	},
 };
-module_platform_driver(lpc18xx_serial_driver);
+builtin_platform_driver(lpc18xx_serial_driver);
 
+/*
 MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
 MODULE_DESCRIPTION("Serial port driver NXP LPC18xx/43xx devices");
 MODULE_LICENSE("GPL v2");
+*/
-- 
2.5.0
