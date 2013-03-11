From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] tty: max3100: Use dev_pm_ops
Date: Mon, 11 Mar 2013 18:44:49 +0100
Message-ID: <1363023892-15957-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-serial@vger.kernel.org

Use dev_pm_ops instead of the deprecated legacy suspend/resume for the
max3100 driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/tty/serial/max3100.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 32517d4..57da9bb 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -849,11 +849,11 @@ static int max3100_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 
-static int max3100_suspend(struct spi_device *spi, pm_message_t state)
+static int max3100_suspend(struct device *dev)
 {
-	struct max3100_port *s = dev_get_drvdata(&spi->dev);
+	struct max3100_port *s = dev_get_drvdata(dev);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -874,9 +874,9 @@ static int max3100_suspend(struct spi_device *spi, pm_message_t state)
 	return 0;
 }
 
-static int max3100_resume(struct spi_device *spi)
+static int max3100_resume(struct device *dev)
 {
-	struct max3100_port *s = dev_get_drvdata(&spi->dev);
+	struct max3100_port *s = dev_get_drvdata(dev);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -894,21 +894,21 @@ static int max3100_resume(struct spi_device *spi)
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(max3100_pm_ops, max3100_suspend, max3100_resume);
+#define MAX3100_PM_OPS (&max3100_pm_ops)
+
 #else
-#define max3100_suspend NULL
-#define max3100_resume  NULL
+#define MAX3100_PM_OPS NULL
 #endif
 
 static struct spi_driver max3100_driver = {
 	.driver = {
 		.name		= "max3100",
 		.owner		= THIS_MODULE,
+		.pm		= MAX3100_PM_OPS,
 	},
-
 	.probe		= max3100_probe,
 	.remove		= max3100_remove,
-	.suspend	= max3100_suspend,
-	.resume		= max3100_resume,
 };
 
 module_spi_driver(max3100_driver);
-- 
1.8.0
