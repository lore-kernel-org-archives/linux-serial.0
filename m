From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 5/8] serial: max310x: Add support for RS-485 mode
Date: Mon, 10 Feb 2014 22:18:34 +0400
Message-ID: <1392056316-13844-6-git-send-email-shc_work@mail.ru>
References: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:36578 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbaBJSZ2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 13:25:28 -0500
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id 4146F50395DB
	for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2014 22:19:14 +0400 (MSK)
In-Reply-To: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch adds support for RS-485 (TIOCSRS485/TIOCGRS485) IOCTLs.
As a result this patch eliminate private driver header.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c          | 77 +++++++++++++++++++++++++----------
 include/linux/platform_data/max310x.h | 49 ----------------------
 2 files changed, 56 insertions(+), 70 deletions(-)
 delete mode 100644 include/linux/platform_data/max310x.h

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index c180576..090f25d 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -26,8 +26,6 @@
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 
-#include <linux/platform_data/max310x.h>
-
 #define MAX310X_NAME			"max310x"
 #define MAX310X_MAJOR			204
 #define MAX310X_MINOR			209
@@ -293,7 +291,6 @@ struct max310x_port {
 	struct regmap		*regmap;
 	struct mutex		mutex;
 	struct clk		*clk;
-	struct max310x_pdata	*pdata;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gpio;
 #endif
@@ -898,26 +895,70 @@ static void max310x_set_termios(struct uart_port *port,
 	uart_update_timeout(port, termios->c_cflag, baud);
 }
 
+static int max310x_ioctl(struct uart_port *port, unsigned int cmd,
+			 unsigned long arg)
+{
+	struct serial_rs485 rs485;
+	unsigned int val;
+
+	switch (cmd) {
+	case TIOCSRS485:
+		if (copy_from_user(&rs485, (struct serial_rs485 *)arg,
+				   sizeof(rs485)))
+			return -EFAULT;
+		if (rs485.delay_rts_before_send > 0x0f ||
+		    rs485.delay_rts_after_send > 0x0f)
+			return -ERANGE;
+		val = (rs485.delay_rts_before_send << 4) |
+		      rs485.delay_rts_after_send;
+		max310x_port_write(port, MAX310X_HDPIXDELAY_REG, val);
+		if (rs485.flags & SER_RS485_ENABLED) {
+			max310x_port_update(port, MAX310X_MODE1_REG,
+					    MAX310X_MODE1_TRNSCVCTRL_BIT,
+					    MAX310X_MODE1_TRNSCVCTRL_BIT);
+			max310x_port_update(port, MAX310X_MODE2_REG,
+					    MAX310X_MODE2_ECHOSUPR_BIT,
+					    MAX310X_MODE2_ECHOSUPR_BIT);
+		} else {
+			max310x_port_update(port, MAX310X_MODE1_REG,
+					    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
+			max310x_port_update(port, MAX310X_MODE2_REG,
+					    MAX310X_MODE2_ECHOSUPR_BIT, 0);
+		}
+		break;
+	case TIOCGRS485:
+		memset(&rs485, 0, sizeof(rs485));
+		val = max310x_port_read(port, MAX310X_MODE1_REG);
+		rs485.flags = (val & MAX310X_MODE1_TRNSCVCTRL_BIT) ?
+			      SER_RS485_ENABLED : 0;
+		rs485.flags |= SER_RS485_RTS_ON_SEND;
+		val = max310x_port_read(port, MAX310X_HDPIXDELAY_REG);
+		rs485.delay_rts_before_send = val >> 4;
+		rs485.delay_rts_after_send = val & 0x0f;
+		if (copy_to_user((struct serial_rs485 *)arg, &rs485,
+				 sizeof(rs485)))
+			return -EFAULT;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
 static int max310x_startup(struct uart_port *port)
 {
-	unsigned int val, line = port->line;
 	struct max310x_port *s = dev_get_drvdata(port->dev);
+	unsigned int val;
 
 	s->devtype->power(port, 1);
 
 	/* Configure MODE1 register */
 	max310x_port_update(port, MAX310X_MODE1_REG,
-			    MAX310X_MODE1_TRNSCVCTRL_BIT,
-			    (s->pdata->uart_flags[line] & MAX310X_AUTO_DIR_CTRL)
-			    ? MAX310X_MODE1_TRNSCVCTRL_BIT : 0);
+			    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
 
-	/* Configure MODE2 register */
-	val = MAX310X_MODE2_RXEMPTINV_BIT;
-	if (s->pdata->uart_flags[line] & MAX310X_ECHO_SUPRESS)
-		val |= MAX310X_MODE2_ECHOSUPR_BIT;
-
-	/* Reset FIFOs */
-	val |= MAX310X_MODE2_FIFORST_BIT;
+	/* Configure MODE2 register & Reset FIFOs*/
+	val = MAX310X_MODE2_RXEMPTINV_BIT | MAX310X_MODE2_FIFORST_BIT;
 	max310x_port_write(port, MAX310X_MODE2_REG, val);
 	max310x_port_update(port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_FIFORST_BIT, 0);
@@ -998,6 +1039,7 @@ static const struct uart_ops max310x_ops = {
 	.release_port	= max310x_null_void,
 	.config_port	= max310x_config_port,
 	.verify_port	= max310x_verify_port,
+	.ioctl		= max310x_ioctl,
 };
 
 static int __maybe_unused max310x_suspend(struct device *dev)
@@ -1077,7 +1119,6 @@ static int max310x_gpio_direction_output(struct gpio_chip *chip,
 static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 			 struct regmap *regmap, int irq)
 {
-	struct max310x_pdata *pdata = dev_get_platdata(dev);
 	int i, ret, fmin, fmax, freq, uartclk;
 	struct clk *clk_osc, *clk_xtal;
 	struct max310x_port *s;
@@ -1086,11 +1127,6 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	if (!pdata) {
-		dev_err(dev, "No platform data supplied\n");
-		return -EINVAL;
-	}
-
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, sizeof(*s) +
 			 sizeof(struct max310x_one) * devtype->nr, GFP_KERNEL);
@@ -1129,7 +1165,6 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		goto out_clk;
 	}
 
-	s->pdata = pdata;
 	s->regmap = regmap;
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
diff --git a/include/linux/platform_data/max310x.h b/include/linux/platform_data/max310x.h
deleted file mode 100644
index 1140a57..0000000
--- a/include/linux/platform_data/max310x.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- *  Maxim (Dallas) MAX3107/8/9, MAX14830 serial driver
- *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
- *
- *  Based on max3100.c, by Christian Pellegrin <chripell@evolware.org>
- *  Based on max3110.c, by Feng Tang <feng.tang@intel.com>
- *  Based on max3107.c, by Aavamobile
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- */
-
-#ifndef _MAX310X_H_
-#define _MAX310X_H_
-
-/*
- * Example board initialization data:
- *
- * static struct max310x_pdata max3107_pdata = {
- *	.uart_flags[0]	= MAX310X_ECHO_SUPRESS | MAX310X_AUTO_DIR_CTRL,
- * };
- *
- * static struct spi_board_info spi_device_max3107[] = {
- *	{
- *		.modalias	= "max3107",
- *		.irq		= IRQ_EINT3,
- *		.bus_num	= 1,
- *		.chip_select	= 1,
- *		.platform_data	= &max3107_pdata,
- *	},
- * };
- */
-
-#define MAX310X_MAX_UARTS	4
-
-/* MAX310X platform data structure */
-struct max310x_pdata {
-	/* Flags global to UART port */
-	const u8		uart_flags[MAX310X_MAX_UARTS];
-#define MAX310X_ECHO_SUPRESS	(0x00000002)	/* Enable echo supress */
-#define MAX310X_AUTO_DIR_CTRL	(0x00000004)	/* Enable Auto direction
-						 * control (RS-485)
-						 */
-};
-
-#endif
-- 
1.8.3.2

