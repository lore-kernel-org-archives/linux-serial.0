From: Michal Simek <michal.simek@xilinx.com>
Subject: [RFC PATCH 2/3] serial: uartps: Move register to probe based on run time detection
Date: Thu, 26 Apr 2018 16:08:18 +0200
Message-ID: <7dc0d444ddfae465a80e509af6ceb6be5b42881a.1524751696.git.michal.simek@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524751696.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1524751696.git.michal.simek@xilinx.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Find out the highest serial alias and allocate that amount of
structures/minor numbers to be able to handle all of them.
Origin setting that there are two prealocated CDNS_UART_NR_PORTS is kept
there.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Discussed here: https://patchwork.kernel.org/patch/9738445/

The same solution is done in pl011 driver.
---
 drivers/tty/serial/xilinx_uartps.c | 32 ++++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 0fc9de20843c..ffb5b66a05b5 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1432,6 +1432,22 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	struct cdns_uart *cdns_uart_data;
 	const struct of_device_id *match;
 
+	if (!cdns_uart_uart_driver.state) {
+		rc = of_alias_get_highest_id("serial");
+		if (rc >= CDNS_UART_NR_PORTS) {
+			/* serial2 means 3 ports that's why rc(2) + 1 here */
+			rc += 1;
+			/* Rewrite default setup which is using 2 ports */
+			cdns_uart_uart_driver.nr = rc;
+		}
+
+		rc = uart_register_driver(&cdns_uart_uart_driver);
+		if (rc < 0) {
+			dev_err(&pdev->dev, "Failed to register driver\n");
+			return rc;
+		}
+	}
+
 	cdns_uart_data = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_data),
 			GFP_KERNEL);
 	if (!cdns_uart_data)
@@ -1622,28 +1638,14 @@ static struct platform_driver cdns_uart_platform_driver = {
 
 static int __init cdns_uart_init(void)
 {
-	int retval = 0;
-
-	/* Register the cdns_uart driver with the serial core */
-	retval = uart_register_driver(&cdns_uart_uart_driver);
-	if (retval)
-		return retval;
-
 	/* Register the platform driver */
-	retval = platform_driver_register(&cdns_uart_platform_driver);
-	if (retval)
-		uart_unregister_driver(&cdns_uart_uart_driver);
-
-	return retval;
+	return platform_driver_register(&cdns_uart_platform_driver);
 }
 
 static void __exit cdns_uart_exit(void)
 {
 	/* Unregister the platform driver */
 	platform_driver_unregister(&cdns_uart_platform_driver);
-
-	/* Unregister the cdns_uart driver */
-	uart_unregister_driver(&cdns_uart_uart_driver);
 }
 
 arch_initcall(cdns_uart_init);
-- 
2.17.0
