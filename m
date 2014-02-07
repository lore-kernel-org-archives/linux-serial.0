From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH 3/8] tty/serial: at91: prepare for more gpio lines to come
Date: Fri,  7 Feb 2014 15:59:10 +0100
Message-ID: <1391785155-18525-4-git-send-email-richard.genoud@gmail.com>
References: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:60781 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbaBGPAR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 10:00:17 -0500
Received: by mail-we0-f171.google.com with SMTP id u56so2411642wes.30
        for <linux-serial@vger.kernel.org>; Fri, 07 Feb 2014 07:00:16 -0800 (PST)
In-Reply-To: <1391785155-18525-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

There's no functionnal change, it will just be easier to review the
next patches.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 73 ++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a51b3a762948..7ef99d7e070b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -126,6 +126,10 @@ struct atmel_uart_char {
 
 #define ATMEL_SERIAL_RINGSIZE 1024
 
+struct gpio_lines {
+	int rts;	/* optional RTS GPIO */
+};
+
 /*
  * We wrap our port structure around the generic uart_port.
  */
@@ -162,7 +166,7 @@ struct atmel_uart_port {
 	struct circ_buf		rx_ring;
 
 	struct serial_rs485	rs485;		/* rs485 settings */
-	int			rts_gpio;	/* optional RTS GPIO */
+	struct gpio_lines	gpio;
 	unsigned int		tx_done_mask;
 	bool			is_usart;	/* usart or uart */
 	struct timer_list	uart_timer;	/* uart timer */
@@ -300,11 +304,11 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 	 * AT91RM9200 Errata #39: RTS0 is not internally connected
 	 * to PA21. We need to drive the pin as a GPIO.
 	 */
-	if (gpio_is_valid(atmel_port->rts_gpio)) {
+	if (gpio_is_valid(atmel_port->gpio.rts)) {
 		if (mctrl & TIOCM_RTS)
-			gpio_set_value(atmel_port->rts_gpio, 0);
+			gpio_set_value(atmel_port->gpio.rts, 0);
 		else
-			gpio_set_value(atmel_port->rts_gpio, 1);
+			gpio_set_value(atmel_port->gpio.rts, 1);
 	}
 
 	if (mctrl & TIOCM_RTS)
@@ -2327,6 +2331,45 @@ static int atmel_serial_resume(struct platform_device *pdev)
 #define atmel_serial_resume NULL
 #endif
 
+static int atmel_request_gpio(struct device *dev, int gpio,
+			      const char *label, int *irq)
+{
+	int ret = 0;
+
+	if (gpio_is_valid(gpio)) {
+		ret = devm_gpio_request(dev, gpio, label);
+		if (ret) {
+			dev_err(dev, "error requesting %s GPIO\n", label);
+			goto err;
+		}
+
+		if (irq == NULL) {
+			/* Default to 1 as all signals are active low */
+			ret = gpio_direction_output(gpio, 1);
+		} else {
+			ret = gpio_direction_input(gpio);
+			*irq = gpio_to_irq(gpio);
+		}
+		if (ret) {
+			dev_err(dev, "error setting up %s GPIO\n", label);
+			goto err;
+		}
+	}
+
+err:
+	return ret;
+}
+
+static int atmel_init_gpios(struct atmel_uart_port *atmel_port,
+			    struct platform_device *pdev)
+{
+	int ret;
+
+	ret = atmel_request_gpio(&pdev->dev, atmel_port->gpio.rts,
+				 "RTS", NULL);
+	return ret;
+}
+
 static int atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *port;
@@ -2362,25 +2405,15 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port = &atmel_ports[ret];
 	port->backup_imr = 0;
 	port->uart.line = ret;
-	port->rts_gpio = -EINVAL; /* Invalid, zero could be valid */
+	port->gpio.rts = -EINVAL; /* Invalid, zero could be valid */
 	if (pdata)
-		port->rts_gpio = pdata->rts_gpio;
+		port->gpio.rts = pdata->rts_gpio;
 	else if (np)
-		port->rts_gpio = of_get_named_gpio(np, "rts-gpios", 0);
+		port->gpio.rts = of_get_named_gpio(np, "rts-gpios", 0);
 
-	if (gpio_is_valid(port->rts_gpio)) {
-		ret = devm_gpio_request(&pdev->dev, port->rts_gpio, "RTS");
-		if (ret) {
-			dev_err(&pdev->dev, "error requesting RTS GPIO\n");
-			goto err;
-		}
-		/* Default to 1 as RTS is active low */
-		ret = gpio_direction_output(port->rts_gpio, 1);
-		if (ret) {
-			dev_err(&pdev->dev, "error setting up RTS GPIO\n");
-			goto err;
-		}
-	}
+	ret = atmel_init_gpios(port, pdev);
+	if (ret)
+		goto err;
 
 	ret = atmel_init_port(port, pdev);
 	if (ret)
-- 
1.8.5

