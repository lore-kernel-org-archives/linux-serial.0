From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 7/8] serial: max310x: Add devicetree support
Date: Mon, 10 Feb 2014 22:18:36 +0400
Message-ID: <1392056316-13844-8-git-send-email-shc_work@mail.ru>
References: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.176.135]:53007 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbaBJSTS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 13:19:18 -0500
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 63361F8296B9
	for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2014 22:19:16 +0400 (MSK)
In-Reply-To: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch adds devicetree support for the MAX310X serial driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e273854..8a035d6 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -19,6 +19,8 @@
 #include <linux/device.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
@@ -1093,7 +1095,7 @@ static int max310x_gpio_direction_output(struct gpio_chip *chip,
 #endif
 
 static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
-			 struct regmap *regmap, int irq)
+			 struct regmap *regmap, int irq, unsigned long flags)
 {
 	int i, ret, fmin, fmax, freq, uartclk;
 	struct clk *clk_osc, *clk_xtal;
@@ -1237,8 +1239,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 
 	/* Setup interrupt */
 	ret = devm_request_threaded_irq(dev, irq, NULL, max310x_ist,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					dev_name(dev), s);
+					IRQF_ONESHOT | flags, dev_name(dev), s);
 	if (!ret)
 		return 0;
 
@@ -1284,6 +1285,15 @@ static int max310x_remove(struct device *dev)
 	return ret;
 }
 
+static const struct of_device_id __maybe_unused max310x_dt_ids[] = {
+	{ .compatible = "maxim,max3107",	.data = &max3107_devtype, },
+	{ .compatible = "maxim,max3108",	.data = &max3108_devtype, },
+	{ .compatible = "maxim,max3109",	.data = &max3109_devtype, },
+	{ .compatible = "maxim,max14830",	.data = &max14830_devtype },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max310x_dt_ids);
+
 static struct regmap_config regcfg = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -1297,8 +1307,8 @@ static struct regmap_config regcfg = {
 #ifdef CONFIG_SPI_MASTER
 static int max310x_spi_probe(struct spi_device *spi)
 {
-	struct max310x_devtype *devtype =
-		(struct max310x_devtype *)spi_get_device_id(spi)->driver_data;
+	struct max310x_devtype *devtype;
+	unsigned long flags = 0;
 	struct regmap *regmap;
 	int ret;
 
@@ -1310,10 +1320,22 @@ static int max310x_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	if (spi->dev.of_node) {
+		const struct of_device_id *of_id =
+			of_match_device(max310x_dt_ids, &spi->dev);
+
+		devtype = (struct max310x_devtype *)of_id->data;
+	} else {
+		const struct spi_device_id *id_entry = spi_get_device_id(spi);
+
+		devtype = (struct max310x_devtype *)id_entry->driver_data;
+		flags = IRQF_TRIGGER_FALLING;
+	}
+
 	regcfg.max_register = devtype->nr * 0x20 - 1;
 	regmap = devm_regmap_init_spi(spi, &regcfg);
 
-	return max310x_probe(&spi->dev, devtype, regmap, spi->irq);
+	return max310x_probe(&spi->dev, devtype, regmap, spi->irq, flags);
 }
 
 static int max310x_spi_remove(struct spi_device *spi)
@@ -1332,9 +1354,10 @@ MODULE_DEVICE_TABLE(spi, max310x_id_table);
 
 static struct spi_driver max310x_uart_driver = {
 	.driver = {
-		.name	= MAX310X_NAME,
-		.owner	= THIS_MODULE,
-		.pm	= &max310x_pm_ops,
+		.name		= MAX310X_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(max310x_dt_ids),
+		.pm		= &max310x_pm_ops,
 	},
 	.probe		= max310x_spi_probe,
 	.remove		= max310x_spi_remove,
-- 
1.8.3.2

