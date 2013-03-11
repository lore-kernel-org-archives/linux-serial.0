From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] tty: mrst_max3110: Use dev_pm_ops
Date: Mon, 11 Mar 2013 18:44:51 +0100
Message-ID: <1363023892-15957-3-git-send-email-lars@metafoo.de>
References: <1363023892-15957-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363023892-15957-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Use dev_pm_ops instead of the deprecated legacy suspend/resume for the
mrst_max3110 driver.

Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/tty/serial/mrst_max3110.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index f641c23..9b6ef20 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -743,9 +743,10 @@ static struct uart_driver serial_m3110_reg = {
 	.cons		= &serial_m3110_console,
 };
 
-#ifdef CONFIG_PM
-static int serial_m3110_suspend(struct spi_device *spi, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int serial_m3110_suspend(struct device *dev)
 {
+	struct spi_device *spi = to_spi_device(dev);
 	struct uart_max3110 *max = spi_get_drvdata(spi);
 
 	disable_irq(max->irq);
@@ -754,8 +755,9 @@ static int serial_m3110_suspend(struct spi_device *spi, pm_message_t state)
 	return 0;
 }
 
-static int serial_m3110_resume(struct spi_device *spi)
+static int serial_m3110_resume(struct device *dev)
 {
+	struct spi_device *spi = to_spi_device(dev);
 	struct uart_max3110 *max = spi_get_drvdata(spi);
 
 	max3110_out(max, max->cur_conf);
@@ -763,9 +765,13 @@ static int serial_m3110_resume(struct spi_device *spi)
 	enable_irq(max->irq);
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(serial_m3110_pm_ops, serial_m3110_suspend,
+			serial_m3110_resume);
+#define SERIAL_M3110_PM_OPS (&serial_m3110_pm_ops)
+
 #else
-#define serial_m3110_suspend	NULL
-#define serial_m3110_resume	NULL
+#define SERIAL_M3110_PM_OPS NULL
 #endif
 
 static int serial_m3110_probe(struct spi_device *spi)
@@ -872,11 +878,10 @@ static struct spi_driver uart_max3110_driver = {
 	.driver = {
 			.name	= "spi_max3111",
 			.owner	= THIS_MODULE,
+			.pm	= SERIAL_M3110_PM_OPS,
 	},
 	.probe		= serial_m3110_probe,
 	.remove		= serial_m3110_remove,
-	.suspend	= serial_m3110_suspend,
-	.resume		= serial_m3110_resume,
 };
 
 static int __init serial_m3110_init(void)
-- 
1.8.0
