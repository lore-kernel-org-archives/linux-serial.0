From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/8] serial: max310x: Migrate to CLK API
Date: Mon, 10 Feb 2014 22:18:31 +0400
Message-ID: <1392056316-13844-3-git-send-email-shc_work@mail.ru>
References: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback3.mail.ru ([94.100.176.58]:54142 "EHLO
	fallback3.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbaBJST4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Feb 2014 13:19:56 -0500
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
	by fallback3.mail.ru (mPOP.Fallback_MX) with ESMTP id A8F3810BC2DBE
	for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2014 22:19:07 +0400 (MSK)
In-Reply-To: <1392056316-13844-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch removes "frequency" parameter from MAX310X platform_data
and uses CLK API for getting clock. Clock type (XTAL/OSC) is
determined by clk name.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c          | 86 ++++++++++++++++++++++-------------
 include/linux/platform_data/max310x.h |  7 ---
 2 files changed, 55 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 9e147f3..310ee55 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
@@ -291,6 +292,7 @@ struct max310x_port {
 	struct max310x_devtype	*devtype;
 	struct regmap		*regmap;
 	struct mutex		mutex;
+	struct clk		*clk;
 	struct max310x_pdata	*pdata;
 	int			gpio_used;
 #ifdef CONFIG_GPIOLIB
@@ -546,18 +548,19 @@ static int max310x_update_best_err(unsigned long f, long *besterr)
 	return 1;
 }
 
-static int max310x_set_ref_clk(struct max310x_port *s)
+static int max310x_set_ref_clk(struct max310x_port *s, unsigned long freq,
+			       bool xtal)
 {
 	unsigned int div, clksrc, pllcfg = 0;
 	long besterr = -1;
-	unsigned long fdiv, fmul, bestfreq = s->pdata->frequency;
+	unsigned long fdiv, fmul, bestfreq = freq;
 
 	/* First, update error without PLL */
-	max310x_update_best_err(s->pdata->frequency, &besterr);
+	max310x_update_best_err(freq, &besterr);
 
 	/* Try all possible PLL dividers */
 	for (div = 1; (div <= 63) && besterr; div++) {
-		fdiv = DIV_ROUND_CLOSEST(s->pdata->frequency, div);
+		fdiv = DIV_ROUND_CLOSEST(freq, div);
 
 		/* Try multiplier 6 */
 		fmul = fdiv * 6;
@@ -590,10 +593,7 @@ static int max310x_set_ref_clk(struct max310x_port *s)
 	}
 
 	/* Configure clock source */
-	if (s->pdata->driver_flags & MAX310X_EXT_CLK)
-		clksrc = MAX310X_CLKSRC_EXTCLK_BIT;
-	else
-		clksrc = MAX310X_CLKSRC_CRYST_BIT;
+	clksrc = xtal ? MAX310X_CLKSRC_CRYST_BIT : MAX310X_CLKSRC_EXTCLK_BIT;
 
 	/* Configure PLL */
 	if (pllcfg) {
@@ -605,7 +605,7 @@ static int max310x_set_ref_clk(struct max310x_port *s)
 	regmap_write(s->regmap, MAX310X_CLKSRC_REG, clksrc);
 
 	/* Wait for crystal */
-	if (pllcfg && !(s->pdata->driver_flags & MAX310X_EXT_CLK))
+	if (pllcfg && xtal)
 		msleep(10);
 
 	return (int)bestfreq;
@@ -1078,9 +1078,11 @@ static int max310x_gpio_direction_output(struct gpio_chip *chip,
 static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 			 struct regmap *regmap, int irq)
 {
-	struct max310x_port *s;
 	struct max310x_pdata *pdata = dev_get_platdata(dev);
-	int i, ret, uartclk;
+	int i, ret, fmin, fmax, freq, uartclk;
+	struct clk *clk_osc, *clk_xtal;
+	struct max310x_port *s;
+	bool xtal = false;
 
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -1098,14 +1100,35 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		return -ENOMEM;
 	}
 
-	/* Check input frequency */
-	if ((pdata->driver_flags & MAX310X_EXT_CLK) &&
-	   ((pdata->frequency < 500000) || (pdata->frequency > 35000000)))
-		goto err_freq;
-	/* Check frequency for quartz */
-	if (!(pdata->driver_flags & MAX310X_EXT_CLK) &&
-	   ((pdata->frequency < 1000000) || (pdata->frequency > 4000000)))
-		goto err_freq;
+	clk_osc = devm_clk_get(dev, "osc");
+	clk_xtal = devm_clk_get(dev, "xtal");
+	if (!IS_ERR(clk_osc)) {
+		s->clk = clk_osc;
+		fmin = 500000;
+		fmax = 35000000;
+	} else if (!IS_ERR(clk_xtal)) {
+		s->clk = clk_xtal;
+		fmin = 1000000;
+		fmax = 4000000;
+		xtal = true;
+	} else if (PTR_ERR(clk_osc) == -EPROBE_DEFER ||
+		   PTR_ERR(clk_xtal) == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else {
+		dev_err(dev, "Cannot get clock\n");
+		return -EINVAL;
+	}
+
+	ret = clk_prepare_enable(s->clk);
+	if (ret)
+		return ret;
+
+	freq = clk_get_rate(s->clk);
+	/* Check frequency limits */
+	if (freq < fmin || freq > fmax) {
+		ret = -ERANGE;
+		goto out_clk;
+	}
 
 	s->pdata = pdata;
 	s->regmap = regmap;
@@ -1117,7 +1140,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	/* Check device to ensure we are talking to what we expect */
 	ret = devtype->detect(dev);
 	if (ret)
-		return ret;
+		goto out_clk;
 
 	for (i = 0; i < devtype->nr; i++) {
 		unsigned int offs = i << 5;
@@ -1139,7 +1162,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 				   MAX310X_MODE1_AUTOSLEEP_BIT);
 	}
 
-	uartclk = max310x_set_ref_clk(s);
+	uartclk = max310x_set_ref_clk(s, freq, xtal);
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 
 	/* Register UART driver */
@@ -1151,7 +1174,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	ret = uart_register_driver(&s->uart);
 	if (ret) {
 		dev_err(dev, "Registering UART driver failed\n");
-		return ret;
+		goto out_clk;
 	}
 
 	for (i = 0; i < devtype->nr; i++) {
@@ -1208,19 +1231,19 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	ret = devm_request_threaded_irq(dev, irq, NULL, max310x_ist,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					dev_name(dev), s);
-	if (ret) {
-		dev_err(dev, "Unable to reguest IRQ %i\n", irq);
+	if (!ret)
+		return 0;
+
+	dev_err(dev, "Unable to reguest IRQ %i\n", irq);
 #ifdef CONFIG_GPIOLIB
-		if (s->gpio_used)
-			WARN_ON(gpiochip_remove(&s->gpio));
+	if (s->gpio_used)
+		WARN_ON(gpiochip_remove(&s->gpio));
 #endif
-	}
 
-	return ret;
+out_clk:
+	clk_disable_unprepare(s->clk);
 
-err_freq:
-	dev_err(dev, "Frequency parameter incorrect\n");
-	return -EINVAL;
+	return ret;
 }
 
 static int max310x_remove(struct device *dev)
@@ -1236,6 +1259,7 @@ static int max310x_remove(struct device *dev)
 	}
 
 	uart_unregister_driver(&s->uart);
+	clk_disable_unprepare(s->clk);
 
 #ifdef CONFIG_GPIOLIB
 	if (s->gpio_used)
diff --git a/include/linux/platform_data/max310x.h b/include/linux/platform_data/max310x.h
index 9d5f69b..57a0cd4 100644
--- a/include/linux/platform_data/max310x.h
+++ b/include/linux/platform_data/max310x.h
@@ -20,9 +20,7 @@
  * Example board initialization data:
  *
  * static struct max310x_pdata max3107_pdata = {
- *	.driver_flags	= MAX310X_EXT_CLK,
  *	.uart_flags[0]	= MAX310X_ECHO_SUPRESS | MAX310X_AUTO_DIR_CTRL,
- *	.frequency	= 3686400,
  *	.gpio_base	= -1,
  * };
  *
@@ -41,17 +39,12 @@
 
 /* MAX310X platform data structure */
 struct max310x_pdata {
-	/* Flags global to driver */
-	const u8		driver_flags;
-#define MAX310X_EXT_CLK		(0x00000001)	/* External clock enable */
 	/* Flags global to UART port */
 	const u8		uart_flags[MAX310X_MAX_UARTS];
 #define MAX310X_ECHO_SUPRESS	(0x00000002)	/* Enable echo supress */
 #define MAX310X_AUTO_DIR_CTRL	(0x00000004)	/* Enable Auto direction
 						 * control (RS-485)
 						 */
-	/* Frequency (extrenal clock or crystal) */
-	const int		frequency;
 	/* GPIO base number (can be negative) */
 	const int		gpio_base;
 };
-- 
1.8.3.2

