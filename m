From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RESEND 3/3] serial: max310x: Add MAX14830 support
Date: Sat, 29 Jun 2013 10:44:19 +0400
Message-ID: <1372488259-14539-3-git-send-email-shc_work@mail.ru>
References: <1372488259-14539-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp33.i.mail.ru ([94.100.177.93]:57325 "EHLO smtp33.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab3F2Go2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 29 Jun 2013 02:44:28 -0400
In-Reply-To: <1372488259-14539-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch adds support for MAX14830 (advanced quad universal asynchronous
receiver-transmitter) into max310x driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/Kconfig            |  2 +-
 drivers/tty/serial/max310x.c          | 45 ++++++++++++++++++++++++++++++++++-
 include/linux/platform_data/max310x.h |  4 ++--
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8e1a9c5..bc486de 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -297,7 +297,7 @@ config SERIAL_MAX310X
 	default n
 	help
 	  This selects support for an advanced UART from Maxim (Dallas).
-	  Supported ICs are MAX3107, MAX3108, MAX3109.
+	  Supported ICs are MAX3107, MAX3108, MAX3109, MAX14830.
 	  Each IC contains 128 words each of receive and transmit FIFO
 	  that can be controlled through I2C or high-speed SPI.
 
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a6c4642..4ab5b27 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1,5 +1,5 @@
 /*
- *  Maxim (Dallas) MAX3107/8/9 serial driver
+ *  Maxim (Dallas) MAX3107/8/9, MAX14830 serial driver
  *
  *  Copyright (C) 2012-2013 Alexander Shiyan <shc_work@mail.ru>
  *
@@ -269,6 +269,10 @@
 /* MAX3109 specific */
 #define MAX3109_REV_ID			(0xc0)
 
+/* MAX14830 specific */
+#define MAX14830_BRGCFG_CLKDIS_BIT	(1 << 6) /* Clock Disable */
+#define MAX14830_REV_ID			(0xb0)
+
 struct max310x_devtype {
 	char	name[9];
 	int	nr;
@@ -387,6 +391,37 @@ static void max310x_power(struct uart_port *port, int on)
 		msleep(50);
 }
 
+static int max14830_detect(struct device *dev)
+{
+	struct max310x_port *s = dev_get_drvdata(dev);
+	unsigned int val = 0;
+	int ret;
+
+	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
+			   MAX310X_EXTREG_ENBL);
+	if (ret)
+		return ret;
+	
+	regmap_read(s->regmap, MAX310X_REVID_EXTREG, &val);
+	regmap_write(s->regmap, MAX310X_GLOBALCMD_REG, MAX310X_EXTREG_DSBL);
+	if (((val & MAX310x_REV_MASK) != MAX14830_REV_ID)) {
+		dev_err(dev,
+			"%s ID 0x%02x does not match\n", s->devtype->name, val);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void max14830_power(struct uart_port *port, int on)
+{
+	max310x_port_update(port, MAX310X_BRGCFG_REG,
+			    MAX14830_BRGCFG_CLKDIS_BIT,
+			    on ? 0 : MAX14830_BRGCFG_CLKDIS_BIT);
+	if (on)
+		msleep(50);
+}
+
 static const struct max310x_devtype max3107_devtype = {
 	.name	= "MAX3107",
 	.nr	= 1,
@@ -408,6 +443,13 @@ static const struct max310x_devtype max3109_devtype = {
 	.power	= max310x_power,
 };
 
+static const struct max310x_devtype max14830_devtype = {
+	.name	= "MAX14830",
+	.nr	= 4,
+	.detect	= max14830_detect,
+	.power	= max14830_power,
+};
+
 static bool max310x_reg_writeable(struct device *dev, unsigned int reg)
 {
 	switch (reg & 0x1f) {
@@ -1253,6 +1295,7 @@ static const struct spi_device_id max310x_id_table[] = {
 	{ "max3107",	(kernel_ulong_t)&max3107_devtype, },
 	{ "max3108",	(kernel_ulong_t)&max3108_devtype, },
 	{ "max3109",	(kernel_ulong_t)&max3109_devtype, },
+	{ "max14830",	(kernel_ulong_t)&max14830_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, max310x_id_table);
diff --git a/include/linux/platform_data/max310x.h b/include/linux/platform_data/max310x.h
index 4c128ed..dd11dcd 100644
--- a/include/linux/platform_data/max310x.h
+++ b/include/linux/platform_data/max310x.h
@@ -1,5 +1,5 @@
 /*
- *  Maxim (Dallas) MAX3107/8/9 serial driver
+ *  Maxim (Dallas) MAX3107/8/9, MAX14830 serial driver
  *
  *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
  *
@@ -37,7 +37,7 @@
  * };
  */
 
-#define MAX310X_MAX_UARTS	2
+#define MAX310X_MAX_UARTS	4
 
 /* MAX310X platform data structure */
 struct max310x_pdata {
-- 
1.8.1.5

