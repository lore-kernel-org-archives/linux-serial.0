From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3] serial: 8250_of: Add basic PM runtime support
Date: Wed, 16 Aug 2017 15:55:36 -0500
Message-ID: <20170816205536.19634-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com, joel@jms.id.au, khoroshilov@ispras.ru, arnd@arndb.de, robert.jarzmik@free.fr, tthayer@opensource.altera.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-serial@vger.kernel.org

66AK2G UART instances are not apart of the ALWAYS_ON power domain.
Therefore, pm_runtime calls must be made to properly insure the appropriate
power domains needed by UART are on. Keep legacy clk api calls since other
users of this driver may not support PM runtime.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version 3 changes:
Commit message updated
Drop extra parenthesis

Version 2 changes:
Fix build error
Build tested using allmodconfig

 drivers/tty/serial/8250/8250_of.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 6c5a8ca..be90c16 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 
@@ -65,6 +66,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	int ret;
 
 	memset(port, 0, sizeof *port);
+
+	pm_runtime_enable(&ofdev->dev);
+	pm_runtime_get_sync(&ofdev->dev);
+
 	if (of_property_read_u32(np, "clock-frequency", &clk)) {
 
 		/* Get clk rate through clk driver if present */
@@ -72,12 +77,13 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		if (IS_ERR(info->clk)) {
 			dev_warn(&ofdev->dev,
 				"clk or clock-frequency not defined\n");
-			return PTR_ERR(info->clk);
+			ret = PTR_ERR(info->clk);
+			goto err_pmruntime;
 		}
 
 		ret = clk_prepare_enable(info->clk);
 		if (ret < 0)
-			return ret;
+			goto err_pmruntime;
 
 		clk = clk_get_rate(info->clk);
 	}
@@ -170,8 +176,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 err_dispose:
 	irq_dispose_mapping(port->irq);
 err_unprepare:
-	if (info->clk)
-		clk_disable_unprepare(info->clk);
+	clk_disable_unprepare(info->clk);
+err_pmruntime:
+	pm_runtime_put_sync(&ofdev->dev);
+	pm_runtime_disable(&ofdev->dev);
 	return ret;
 }
 
@@ -227,8 +235,9 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	return 0;
 err_dispose:
 	irq_dispose_mapping(port8250.port.irq);
-	if (info->clk)
-		clk_disable_unprepare(info->clk);
+	pm_runtime_put_sync(&ofdev->dev);
+	pm_runtime_disable(&ofdev->dev);
+	clk_disable_unprepare(info->clk);
 err_free:
 	kfree(info);
 	return ret;
@@ -244,8 +253,9 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 	serial8250_unregister_port(info->line);
 
 	reset_control_assert(info->rst);
-	if (info->clk)
-		clk_disable_unprepare(info->clk);
+	pm_runtime_put_sync(&ofdev->dev);
+	pm_runtime_disable(&ofdev->dev);
+	clk_disable_unprepare(info->clk);
 	kfree(info);
 	return 0;
 }
@@ -259,9 +269,10 @@ static int of_serial_suspend(struct device *dev)
 
 	serial8250_suspend_port(info->line);
 
-	if (info->clk && (!uart_console(port) || console_suspend_enabled))
+	if (!uart_console(port) || console_suspend_enabled) {
+		pm_runtime_put_sync(dev);
 		clk_disable_unprepare(info->clk);
-
+	}
 	return 0;
 }
 
@@ -271,8 +282,10 @@ static int of_serial_resume(struct device *dev)
 	struct uart_8250_port *port8250 = serial8250_get_port(info->line);
 	struct uart_port *port = &port8250->port;
 
-	if (info->clk && (!uart_console(port) || console_suspend_enabled))
+	if (!uart_console(port) || console_suspend_enabled) {
+		pm_runtime_get_sync(dev);
 		clk_prepare_enable(info->clk);
+	}
 
 	serial8250_resume_port(info->line);
 
-- 
2.9.4.dirty
