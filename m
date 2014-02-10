From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 3/8] serial: max310x: Always use dynamic GPIO ID assignment
Date: Mon, 10 Feb 2014 22:18:32 +0400
Message-ID: <1392056316-13844-4-git-send-email-shc_work@mail.ru>
References: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:49623 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbaBJSTS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 13:19:18 -0500
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id E671210C8E5E1
	for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2014 22:19:12 +0400 (MSK)
In-Reply-To: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

Always register GPIOs and use dynamic GPIO ID assignment.
This is no much worth if GPIOs is not used, but helps remove
private driver header and add DT support in the future.
Additionally, patch adds missing uart_unregister_driver()
call if probe() fails.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c          | 55 ++++++++++++++++++-----------------
 include/linux/platform_data/max310x.h |  3 --
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 310ee55..2a12cbc 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -294,7 +294,6 @@ struct max310x_port {
 	struct mutex		mutex;
 	struct clk		*clk;
 	struct max310x_pdata	*pdata;
-	int			gpio_used;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gpio;
 #endif
@@ -1177,6 +1176,23 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		goto out_clk;
 	}
 
+#ifdef CONFIG_GPIOLIB
+	/* Setup GPIO cotroller */
+	s->gpio.owner		= THIS_MODULE;
+	s->gpio.dev		= dev;
+	s->gpio.label		= dev_name(dev);
+	s->gpio.direction_input	= max310x_gpio_direction_input;
+	s->gpio.get		= max310x_gpio_get;
+	s->gpio.direction_output= max310x_gpio_direction_output;
+	s->gpio.set		= max310x_gpio_set;
+	s->gpio.base		= -1;
+	s->gpio.ngpio		= devtype->nr * 4;
+	s->gpio.can_sleep	= 1;
+	ret = gpiochip_add(&s->gpio);
+	if (ret)
+		goto out_uart;
+#endif
+
 	for (i = 0; i < devtype->nr; i++) {
 		/* Initialize port data */
 		s->p[i].port.line	= i;
@@ -1208,25 +1224,6 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		devtype->power(&s->p[i].port, 0);
 	}
 
-#ifdef CONFIG_GPIOLIB
-	/* Setup GPIO cotroller */
-	if (s->pdata->gpio_base) {
-		s->gpio.owner		= THIS_MODULE;
-		s->gpio.dev		= dev;
-		s->gpio.label		= dev_name(dev);
-		s->gpio.direction_input	= max310x_gpio_direction_input;
-		s->gpio.get		= max310x_gpio_get;
-		s->gpio.direction_output= max310x_gpio_direction_output;
-		s->gpio.set		= max310x_gpio_set;
-		s->gpio.base		= s->pdata->gpio_base;
-		s->gpio.ngpio		= devtype->nr * 4;
-		s->gpio.can_sleep	= 1;
-		if (!gpiochip_add(&s->gpio))
-			s->gpio_used = 1;
-	} else
-		dev_info(dev, "GPIO support not enabled\n");
-#endif
-
 	/* Setup interrupt */
 	ret = devm_request_threaded_irq(dev, irq, NULL, max310x_ist,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
@@ -1235,11 +1232,14 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		return 0;
 
 	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+
 #ifdef CONFIG_GPIOLIB
-	if (s->gpio_used)
-		WARN_ON(gpiochip_remove(&s->gpio));
+	WARN_ON(gpiochip_remove(&s->gpio));
 #endif
 
+out_uart:
+	uart_unregister_driver(&s->uart);
+
 out_clk:
 	clk_disable_unprepare(s->clk);
 
@@ -1251,6 +1251,12 @@ static int max310x_remove(struct device *dev)
 	struct max310x_port *s = dev_get_drvdata(dev);
 	int i, ret = 0;
 
+#ifdef CONFIG_GPIOLIB
+	ret = gpiochip_remove(&s->gpio);
+	if (ret)
+		return ret;
+#endif
+
 	for (i = 0; i < s->uart.nr; i++) {
 		cancel_work_sync(&s->p[i].tx_work);
 		cancel_work_sync(&s->p[i].md_work);
@@ -1261,11 +1267,6 @@ static int max310x_remove(struct device *dev)
 	uart_unregister_driver(&s->uart);
 	clk_disable_unprepare(s->clk);
 
-#ifdef CONFIG_GPIOLIB
-	if (s->gpio_used)
-		ret = gpiochip_remove(&s->gpio);
-#endif
-
 	return ret;
 }
 
diff --git a/include/linux/platform_data/max310x.h b/include/linux/platform_data/max310x.h
index 57a0cd4..1140a57 100644
--- a/include/linux/platform_data/max310x.h
+++ b/include/linux/platform_data/max310x.h
@@ -21,7 +21,6 @@
  *
  * static struct max310x_pdata max3107_pdata = {
  *	.uart_flags[0]	= MAX310X_ECHO_SUPRESS | MAX310X_AUTO_DIR_CTRL,
- *	.gpio_base	= -1,
  * };
  *
  * static struct spi_board_info spi_device_max3107[] = {
@@ -45,8 +44,6 @@ struct max310x_pdata {
 #define MAX310X_AUTO_DIR_CTRL	(0x00000004)	/* Enable Auto direction
 						 * control (RS-485)
 						 */
-	/* GPIO base number (can be negative) */
-	const int		gpio_base;
 };
 
 #endif
-- 
1.8.3.2

