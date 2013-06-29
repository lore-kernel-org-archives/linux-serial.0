From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/3] serial: max310x: Add MAX3109 support
Date: Sat, 29 Jun 2013 09:24:18 +0400
Message-ID: <1372483459-11836-3-git-send-email-shc_work@mail.ru>
References: <1372483459-11836-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:36772 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab3F2FZM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 29 Jun 2013 01:25:12 -0400
Received: from smtp29.i.mail.ru (smtp29.i.mail.ru [94.100.177.89])
	by fallback2.mail.ru (mPOP.Fallback_MX) with ESMTP id 6FDEAE0E5C82
	for <linux-serial@vger.kernel.org>; Sat, 29 Jun 2013 09:25:08 +0400 (MSK)
In-Reply-To: <1372483459-11836-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch adds support for MAX3109 (advanced dual universal asynchronous
receiver-transmitter) into max310x driver.
---
 drivers/tty/serial/Kconfig            |  2 +-
 drivers/tty/serial/max310x.c          | 35 +++++++++++++++++++++++++++++++----
 include/linux/platform_data/max310x.h |  4 ++--
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 25772c1..8e1a9c5 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -297,7 +297,7 @@ config SERIAL_MAX310X
 	default n
 	help
 	  This selects support for an advanced UART from Maxim (Dallas).
-	  Supported ICs are MAX3107, MAX3108.
+	  Supported ICs are MAX3107, MAX3108, MAX3109.
 	  Each IC contains 128 words each of receive and transmit FIFO
 	  that can be controlled through I2C or high-speed SPI.
 
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4620289..a6c4642 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1,5 +1,5 @@
 /*
- *  Maxim (Dallas) MAX3107/8 serial driver
+ *  Maxim (Dallas) MAX3107/8/9 serial driver
  *
  *  Copyright (C) 2012-2013 Alexander Shiyan <shc_work@mail.ru>
  *
@@ -13,9 +13,6 @@
  *  (at your option) any later version.
  */
 
-/* TODO: MAX3109 support (Dual) */
-/* TODO: MAX14830 support (Quad) */
-
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -269,6 +266,9 @@
 /* MAX3107 specific */
 #define MAX3107_REV_ID			(0xa0)
 
+/* MAX3109 specific */
+#define MAX3109_REV_ID			(0xc0)
+
 struct max310x_devtype {
 	char	name[9];
 	int	nr;
@@ -359,6 +359,25 @@ static int max3108_detect(struct device *dev)
 	return 0;
 }
 
+static int max3109_detect(struct device *dev)
+{
+	struct max310x_port *s = dev_get_drvdata(dev);
+	unsigned int val = 0;
+	int ret;
+
+	ret = regmap_read(s->regmap, MAX310X_REVID_REG, &val);
+	if (ret)
+		return ret;
+
+	if (((val & MAX310x_REV_MASK) != MAX3109_REV_ID)) {
+		dev_err(dev,
+			"%s ID 0x%02x does not match\n", s->devtype->name, val);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static void max310x_power(struct uart_port *port, int on)
 {
 	max310x_port_update(port, MAX310X_MODE1_REG,
@@ -382,6 +401,13 @@ static const struct max310x_devtype max3108_devtype = {
 	.power	= max310x_power,
 };
 
+static const struct max310x_devtype max3109_devtype = {
+	.name	= "MAX3109",
+	.nr	= 2,
+	.detect	= max3109_detect,
+	.power	= max310x_power,
+};
+
 static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 {
 	switch (reg & 0x1f) {
@@ -1226,6 +1252,7 @@ static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
 static const struct spi_device_id max310x_id_table[] = {
 	{ "max3107",	(kernel_ulong_t)&max3107_devtype, },
 	{ "max3108",	(kernel_ulong_t)&max3108_devtype, },
+	{ "max3109",	(kernel_ulong_t)&max3109_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, max310x_id_table);
diff --git a/include/linux/platform_data/max310x.h b/include/linux/platform_data/max310x.h
index 1aec0b6..4c128ed 100644
--- a/include/linux/platform_data/max310x.h
+++ b/include/linux/platform_data/max310x.h
@@ -1,5 +1,5 @@
 /*
- *  Maxim (Dallas) MAX3107/8 serial driver
+ *  Maxim (Dallas) MAX3107/8/9 serial driver
  *
  *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
  *
@@ -37,7 +37,7 @@
  * };
  */
 
-#define MAX310X_MAX_UARTS	1
+#define MAX310X_MAX_UARTS	2
 
 /* MAX310X platform data structure */
 struct max310x_pdata {
-- 
1.8.1.5

