From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4/8] serial: imx: use dev_pm_ops
Date: Sun,  9 Aug 2015 11:19:05 -0700
Message-ID: <1439144349-10494-5-git-send-email-edubezval@gmail.com>
References: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1439144349-10494-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabio Stevam <festevam@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This is a simple reorganization to start using
struct dev_pm_ops instead of assigning .suspend
and .resume callbacks in platform driver.
The change allows further code to be added,
for example, runtime_pm.

Cc: Fabio Stevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/tty/serial/imx.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 70802be..a03855d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -39,6 +39,7 @@
 #include <linux/of_device.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm.h>
 
 #include <asm/irq.h>
 #include <linux/platform_data/serial-imx.h>
@@ -1821,9 +1822,9 @@ static void serial_imx_enable_wakeup(struct imx_port *sport, bool on)
 	writel(val, sport->port.membase + UCR1);
 }
 
-static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
+static int serial_imx_suspend(struct device *dev)
 {
-	struct imx_port *sport = platform_get_drvdata(dev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 
 	/* enable wakeup from i.MX UART */
 	serial_imx_enable_wakeup(sport, true);
@@ -1833,9 +1834,9 @@ static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 	return 0;
 }
 
-static int serial_imx_resume(struct platform_device *dev)
+static int serial_imx_resume(struct device *dev)
 {
-	struct imx_port *sport = platform_get_drvdata(dev);
+	struct imx_port *sport = dev_get_drvdata(dev);
 
 	/* disable wakeup from i.MX UART */
 	serial_imx_enable_wakeup(sport, false);
@@ -1996,15 +1997,18 @@ static int serial_imx_remove(struct platform_device *pdev)
 	return uart_remove_one_port(&imx_reg, &sport->port);
 }
 
+static const struct dev_pm_ops serial_imx_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(serial_imx_suspend, serial_imx_resume)
+};
+
 static struct platform_driver serial_imx_driver = {
 	.probe		= serial_imx_probe,
 	.remove		= serial_imx_remove,
 
-	.suspend	= serial_imx_suspend,
-	.resume		= serial_imx_resume,
 	.id_table	= imx_uart_devtype,
 	.driver		= {
 		.name	= "imx-uart",
+		.pm	= &serial_imx_dev_pm_ops,
 		.of_match_table = imx_uart_dt_ids,
 	},
 };
-- 
2.5.0

