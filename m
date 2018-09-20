From: Michal Simek <michal.simek@xilinx.com>
Subject: [RESEND PATCH v3 2/2] serial: uartps: Change uart ID port allocation
Date: Thu, 20 Sep 2018 13:41:53 +0200
Message-ID: <39e840d1f727fe6338ea14b882ca9bf831f53e32.1537443710.git.michal.simek@xilinx.com>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
In-Reply-To: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gregkh@linuxfoundation.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For IPs which have alias algorightm all the time using that alias and
minor number. It means serial20 alias ends up as ttyPS20.

If alias is not setup for probed IP instance the first unused position is
used but that needs to be checked if it is really empty because another
instance doesn't need to be probed at that time. of_alias_get_alias_list()
fills alias bitmap which exactly shows which ID is free.
If alias pointing to different not compatible IP, it is free to use.

cdns_get_id() call is placed below structure allocation to simplify
error path.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3: None
Changes in v2:
- Add handle of return value from of_alias_get_alias_list

Needs to be applied on the top of
https://lkml.org/lkml/2018/9/3/404
https://lkml.org/lkml/2018/9/3/400 (minor that's why just in case)

Greg: Please apply it with
"of: base: Introduce of_alias_get_alias_list() to check alias IDs
Rob is ok with that.

---
 drivers/tty/serial/xilinx_uartps.c | 109 ++++++++++++++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 71c032744dae..f77200a0f461 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -30,7 +30,6 @@
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
 #define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
-#define CDNS_UART_NR_PORTS	2
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
 
@@ -1370,6 +1369,88 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
 };
 MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 
+/*
+ * Maximum number of instances without alias IDs but if there is alias
+ * which target "< MAX_UART_INSTANCES" range this ID can't be used.
+ */
+#define MAX_UART_INSTANCES	32
+
+/* Stores static aliases list */
+static DECLARE_BITMAP(alias_bitmap, MAX_UART_INSTANCES);
+static int alias_bitmap_initialized;
+
+/* Stores actual bitmap of allocated IDs with alias IDs together */
+static DECLARE_BITMAP(bitmap, MAX_UART_INSTANCES);
+/* Protect bitmap operations to have unique IDs */
+static DEFINE_MUTEX(bitmap_lock);
+
+static int cdns_get_id(struct platform_device *pdev)
+{
+	int id, ret;
+
+	mutex_lock(&bitmap_lock);
+
+	/* Alias list is stable that's why get alias bitmap only once */
+	if (!alias_bitmap_initialized) {
+		ret = of_alias_get_alias_list(cdns_uart_of_match, "serial",
+					      alias_bitmap, MAX_UART_INSTANCES);
+		if (ret)
+			return ret;
+
+		alias_bitmap_initialized++;
+	}
+
+	/* Make sure that alias ID is not taken by instance without alias */
+	bitmap_or(bitmap, bitmap, alias_bitmap, MAX_UART_INSTANCES);
+
+	dev_dbg(&pdev->dev, "Alias bitmap: %*pb\n",
+		MAX_UART_INSTANCES, bitmap);
+
+	/* Look for a serialN alias */
+	id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (id < 0) {
+		dev_warn(&pdev->dev,
+			 "No serial alias passed. Using the first free id\n");
+
+		/*
+		 * Start with id 0 and check if there is no serial0 alias
+		 * which points to device which is compatible with this driver.
+		 * If alias exists then try next free position.
+		 */
+		id = 0;
+
+		for (;;) {
+			dev_info(&pdev->dev, "Checking id %d\n", id);
+			id = find_next_zero_bit(bitmap, MAX_UART_INSTANCES, id);
+
+			/* No free empty instance */
+			if (id == MAX_UART_INSTANCES) {
+				dev_err(&pdev->dev, "No free ID\n");
+				mutex_unlock(&bitmap_lock);
+				return -EINVAL;
+			}
+
+			dev_dbg(&pdev->dev, "The empty id is %d\n", id);
+			/* Check if ID is empty */
+			if (!test_and_set_bit(id, bitmap)) {
+				/* Break the loop if bit is taken */
+				dev_dbg(&pdev->dev,
+					"Selected ID %d allocation passed\n",
+					id);
+				break;
+			}
+			dev_dbg(&pdev->dev,
+				"Selected ID %d allocation failed\n", id);
+			/* if taking bit fails then try next one */
+			id++;
+		}
+	}
+
+	mutex_unlock(&bitmap_lock);
+
+	return id;
+}
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1403,21 +1484,17 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (!cdns_uart_uart_driver)
 		return -ENOMEM;
 
-	/* Look for a serialN alias */
-	cdns_uart_data->id = of_alias_get_id(pdev->dev.of_node, "serial");
+	cdns_uart_data->id = cdns_get_id(pdev);
 	if (cdns_uart_data->id < 0)
-		cdns_uart_data->id = 0;
-
-	if (cdns_uart_data->id >= CDNS_UART_NR_PORTS) {
-		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
-		return -ENODEV;
-	}
+		return cdns_uart_data->id;
 
 	/* There is a need to use unique driver name */
 	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
 				     CDNS_UART_NAME, cdns_uart_data->id);
-	if (!driver_name)
-		return -ENOMEM;
+	if (!driver_name) {
+		rc = -ENOMEM;
+		goto err_out_id;
+	}
 
 	cdns_uart_uart_driver->owner = THIS_MODULE;
 	cdns_uart_uart_driver->driver_name = driver_name;
@@ -1446,7 +1523,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	rc = uart_register_driver(cdns_uart_uart_driver);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Failed to register driver\n");
-		return rc;
+		goto err_out_id;
 	}
 
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
@@ -1587,7 +1664,10 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cdns_uart_data->pclk);
 err_out_unregister_driver:
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
-
+err_out_id:
+	mutex_lock(&bitmap_lock);
+	clear_bit(cdns_uart_data->id, bitmap);
+	mutex_unlock(&bitmap_lock);
 	return rc;
 }
 
@@ -1610,6 +1690,9 @@ static int cdns_uart_remove(struct platform_device *pdev)
 #endif
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
+	mutex_lock(&bitmap_lock);
+	clear_bit(cdns_uart_data->id, bitmap);
+	mutex_unlock(&bitmap_lock);
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
 	pm_runtime_disable(&pdev->dev);
-- 
1.9.1
