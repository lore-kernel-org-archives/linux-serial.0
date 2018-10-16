From: <shubhrajyoti.datta@gmail.com>
Subject: [LINUX PATCHv3 4/9] serial-uartlite: Add runtime support
Date: Tue, 16 Oct 2018 15:48:03 +0530
Message-ID: <1539685088-13465-5-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, jacmet@sunsite.dk, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add runtime support

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 52 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 64c7248..58296eb 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -22,6 +22,7 @@
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
+#include <linux/pm_runtime.h>
 
 #define ULITE_NAME		"ttyUL"
 #define ULITE_MAJOR		204
@@ -54,6 +55,7 @@
 #define ULITE_CONTROL_RST_TX	0x01
 #define ULITE_CONTROL_RST_RX	0x02
 #define ULITE_CONTROL_IE	0x10
+#define UART_AUTOSUSPEND_TIMEOUT	3000
 
 /* Static pointer to console port */
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
@@ -391,12 +393,12 @@ static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
 static void ulite_pm(struct uart_port *port, unsigned int state,
 		     unsigned int oldstate)
 {
-	struct uartlite_data *pdata = port->private_data;
-
-	if (!state)
-		clk_enable(pdata->clk);
-	else
-		clk_disable(pdata->clk);
+	if (!state) {
+		pm_runtime_get_sync(port->dev);
+	} else {
+		pm_runtime_mark_last_busy(port->dev);
+		pm_runtime_put_autosuspend(port->dev);
+	}
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -738,11 +740,32 @@ static int __maybe_unused ulite_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused ulite_runtime_suspend(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
+
+	clk_disable(pdata->clk);
+	return 0;
+};
+
+static int __maybe_unused ulite_runtime_resume(struct device *dev)
+{
+	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
+
+	clk_enable(pdata->clk);
+	return 0;
+}
 /* ---------------------------------------------------------------------
  * Platform bus binding
  */
 
-static SIMPLE_DEV_PM_OPS(ulite_pm_ops, ulite_suspend, ulite_resume);
+static const struct dev_pm_ops ulite_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ulite_suspend, ulite_resume)
+	SET_RUNTIME_PM_OPS(ulite_runtime_suspend,
+			   ulite_runtime_resume, NULL)
+};
 
 #if defined(CONFIG_OF)
 /* Match table for of_platform binding */
@@ -815,9 +838,15 @@ static int ulite_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
-	clk_disable(pdata->clk);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return ret;
 }
@@ -826,9 +855,14 @@ static int ulite_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = dev_get_drvdata(&pdev->dev);
 	struct uartlite_data *pdata = port->private_data;
+	int rc;
 
 	clk_disable_unprepare(pdata->clk);
-	return ulite_release(&pdev->dev);
+	rc = ulite_release(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	return rc;
 }
 
 /* work with hotplug and coldplug */
-- 
2.1.1
