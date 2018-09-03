From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v3 06/10] serial: uartps: Move register to probe based on run time detection
Date: Mon,  3 Sep 2018 15:10:54 +0200
Message-ID: <0ffd804b18c15b60a64aecadcf32b0036e6cbcdb.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Register uart driver in probe to be able to register one device with
unique major/minor separately. Also calculate number of instances of
this driver to be able to call uart_unregister_driver() when there is no
instance.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- Fix uart_unregister_driver() in error path or when driver is removed.
- Change commit message

Changes in v2:
- Remove nr field logic

Discussed here: https://patchwork.kernel.org/patch/9738445/

The same solution is done in pl011 driver.

---
 drivers/tty/serial/xilinx_uartps.c | 42 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a3e97ccb376d..54735a7f9960 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1393,6 +1393,9 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
 };
 MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 
+/* Temporary variable for storing number of instances */
+static int instances;
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1425,6 +1428,14 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (!cdns_uart_uart_driver.state) {
+		rc = uart_register_driver(&cdns_uart_uart_driver);
+		if (rc < 0) {
+			dev_err(&pdev->dev, "Failed to register driver\n");
+			return rc;
+		}
+	}
+
 	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
@@ -1442,7 +1453,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 	if (IS_ERR(cdns_uart_data->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
-		return PTR_ERR(cdns_uart_data->pclk);
+		rc = PTR_ERR(cdns_uart_data->pclk);
+		goto err_out_unregister_driver;
 	}
 
 	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
@@ -1453,13 +1465,14 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 	if (IS_ERR(cdns_uart_data->uartclk)) {
 		dev_err(&pdev->dev, "uart_clk clock not found.\n");
-		return PTR_ERR(cdns_uart_data->uartclk);
+		rc = PTR_ERR(cdns_uart_data->uartclk);
+		goto err_out_unregister_driver;
 	}
 
 	rc = clk_prepare_enable(cdns_uart_data->pclk);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to enable pclk clock.\n");
-		return rc;
+		goto err_out_unregister_driver;
 	}
 	rc = clk_prepare_enable(cdns_uart_data->uartclk);
 	if (rc) {
@@ -1538,6 +1551,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
+	instances++;
 	return 0;
 
 err_out_pm_disable:
@@ -1552,7 +1566,9 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 err_out_clk_dis_pclk:
 	clk_disable_unprepare(cdns_uart_data->pclk);
-
+err_out_unregister_driver:
+	if (!instances)
+		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
 
@@ -1580,6 +1596,8 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (!--instances)
+		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
 
@@ -1595,28 +1613,14 @@ static int cdns_uart_remove(struct platform_device *pdev)
 
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
1.9.1
