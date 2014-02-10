From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/8] serial: max310x: Move all SPI-dependent stuff in one place
Date: Mon, 10 Feb 2014 22:18:30 +0400
Message-ID: <1392056316-13844-2-git-send-email-shc_work@mail.ru>
References: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback3.mail.ru ([94.100.176.58]:54233 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbaBJST6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 13:19:58 -0500
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
	by fallback3.mail.ru (mPOP.Fallback_MX) with ESMTP id 231A110BCD57E
	for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2014 22:19:12 +0400 (MSK)
In-Reply-To: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

Patch move all SPI-dependent stuff in one place. This include move
PM-function definitions out of CONFIG_SPI_MASTER and move regmap
initialization out of common probe into CONFIG_SPI_MASTER which
may help to add I2C support in the future for this driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 56 +++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ac1d54c..9e147f3 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -290,7 +290,6 @@ struct max310x_port {
 	struct uart_driver	uart;
 	struct max310x_devtype	*devtype;
 	struct regmap		*regmap;
-	struct regmap_config	regcfg;
 	struct mutex		mutex;
 	struct max310x_pdata	*pdata;
 	int			gpio_used;
@@ -1028,6 +1027,8 @@ static int __maybe_unused max310x_resume(struct device *dev)
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
+
 #ifdef CONFIG_GPIOLIB
 static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
@@ -1074,13 +1075,16 @@ static int max310x_gpio_direction_output(struct gpio_chip *chip,
 }
 #endif
 
-static int max310x_probe(struct device *dev, int is_spi,
-			 struct max310x_devtype *devtype, int irq)
+static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
+			 struct regmap *regmap, int irq)
 {
 	struct max310x_port *s;
 	struct max310x_pdata *pdata = dev_get_platdata(dev);
 	int i, ret, uartclk;
 
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	if (!pdata) {
 		dev_err(dev, "No platform data supplied\n");
 		return -EINVAL;
@@ -1104,34 +1108,12 @@ static int max310x_probe(struct device *dev, int is_spi,
 		goto err_freq;
 
 	s->pdata = pdata;
+	s->regmap = regmap;
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 
 	mutex_init(&s->mutex);
 
-	/* Setup regmap */
-	s->regcfg.reg_bits		= 8;
-	s->regcfg.val_bits		= 8;
-	s->regcfg.read_flag_mask	= 0x00;
-	s->regcfg.write_flag_mask	= 0x80;
-	s->regcfg.cache_type		= REGCACHE_RBTREE;
-	s->regcfg.writeable_reg		= max310x_reg_writeable;
-	s->regcfg.volatile_reg		= max310x_reg_volatile;
-	s->regcfg.precious_reg		= max310x_reg_precious;
-	s->regcfg.max_register		= devtype->nr * 0x20 - 1;
-
-	if (IS_ENABLED(CONFIG_SPI_MASTER) && is_spi) {
-		struct spi_device *spi = to_spi_device(dev);
-
-		s->regmap = devm_regmap_init_spi(spi, &s->regcfg);
-	} else
-		return -ENOTSUPP;
-
-	if (IS_ERR(s->regmap)) {
-		dev_err(dev, "Failed to initialize register map\n");
-		return PTR_ERR(s->regmap);
-	}
-
 	/* Check device to ensure we are talking to what we expect */
 	ret = devtype->detect(dev);
 	if (ret)
@@ -1263,11 +1245,22 @@ static int max310x_remove(struct device *dev)
 	return ret;
 }
 
+static struct regmap_config regcfg = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.write_flag_mask = 0x80,
+	.cache_type = REGCACHE_RBTREE,
+	.writeable_reg = max310x_reg_writeable,
+	.volatile_reg = max310x_reg_volatile,
+	.precious_reg = max310x_reg_precious,
+};
+
 #ifdef CONFIG_SPI_MASTER
 static int max310x_spi_probe(struct spi_device *spi)
 {
 	struct max310x_devtype *devtype =
 		(struct max310x_devtype *)spi_get_device_id(spi)->driver_data;
+	struct regmap *regmap;
 	int ret;
 
 	/* Setup SPI bus */
@@ -1275,12 +1268,13 @@ static int max310x_spi_probe(struct spi_device *spi)
 	spi->mode		= spi->mode ? : SPI_MODE_0;
 	spi->max_speed_hz	= spi->max_speed_hz ? : 26000000;
 	ret = spi_setup(spi);
-	if (ret) {
-		dev_err(&spi->dev, "SPI setup failed\n");
+	if (ret)
 		return ret;
-	}
 
-	return max310x_probe(&spi->dev, 1, devtype, spi->irq);
+	regcfg.max_register = devtype->nr * 0x20 - 1;
+	regmap = devm_regmap_init_spi(spi, &regcfg);
+
+	return max310x_probe(&spi->dev, devtype, regmap, spi->irq);
 }
 
 static int max310x_spi_remove(struct spi_device *spi)
@@ -1288,8 +1282,6 @@ static int max310x_spi_remove(struct spi_device *spi)
 	return max310x_remove(&spi->dev);
 }
 
-static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
-
 static const struct spi_device_id max310x_id_table[] = {
 	{ "max3107",	(kernel_ulong_t)&max3107_devtype, },
 	{ "max3108",	(kernel_ulong_t)&max3108_devtype, },
-- 
1.8.3.2

