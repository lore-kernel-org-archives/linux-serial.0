From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH v3 3/4] serial: at91: Use helpers for gpio irqs
Date: Fri,  6 Feb 2015 17:55:34 +0100
Message-ID: <1423241735-30387-3-git-send-email-j.uzycki@elproma.com.pl>
References: <1423241735-30387-1-git-send-email-j.uzycki@elproma.com.pl>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1423241735-30387-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Cc: fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org, Janusz Uzycki <j.uzycki@elproma.com.pl>
List-Id: linux-serial@vger.kernel.org

The patch updates atmel_serial driver to use new mctrl_gpio helpers for
gpio irqs. The code is simpler now.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---

There is no changes since v2.

---
 drivers/tty/serial/atmel_serial.c | 123 +++++++-------------------------------
 1 file changed, 20 insertions(+), 103 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 846552b..6bcb181 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -168,7 +168,6 @@ struct atmel_uart_port {
 	struct circ_buf		rx_ring;
 
 	struct mctrl_gpios	*gpios;
-	int			gpio_irq[UART_GPIO_MAX];
 	unsigned int		tx_done_mask;
 	bool			ms_irq_enabled;
 	bool			is_usart;	/* usart or uart */
@@ -512,24 +511,18 @@ static void atmel_enable_ms(struct uart_port *port)
 
 	atmel_port->ms_irq_enabled = true;
 
-	if (atmel_port->gpio_irq[UART_GPIO_CTS] >= 0)
-		enable_irq(atmel_port->gpio_irq[UART_GPIO_CTS]);
-	else
+	mctrl_gpio_enable_ms(atmel_port->gpios);
+
+	if (!mctrl_gpio_is_gpio(atmel_port->gpios, UART_GPIO_CTS))
 		ier |= ATMEL_US_CTSIC;
 
-	if (atmel_port->gpio_irq[UART_GPIO_DSR] >= 0)
-		enable_irq(atmel_port->gpio_irq[UART_GPIO_DSR]);
-	else
+	if (!mctrl_gpio_is_gpio(atmel_port->gpios, UART_GPIO_DSR))
 		ier |= ATMEL_US_DSRIC;
 
-	if (atmel_port->gpio_irq[UART_GPIO_RI] >= 0)
-		enable_irq(atmel_port->gpio_irq[UART_GPIO_RI]);
-	else
+	if (!mctrl_gpio_is_gpio(atmel_port->gpios, UART_GPIO_RI))
 		ier |= ATMEL_US_RIIC;
 
-	if (atmel_port->gpio_irq[UART_GPIO_DCD] >= 0)
-		enable_irq(atmel_port->gpio_irq[UART_GPIO_DCD]);
-	else
+	if (!mctrl_gpio_is_gpio(atmel_port->gpios, UART_GPIO_DCD))
 		ier |= ATMEL_US_DCDIC;
 
 	UART_PUT_IER(port, ier);
@@ -551,24 +544,18 @@ static void atmel_disable_ms(struct uart_port *port)
 
 	atmel_port->ms_irq_enabled = false;
 
-	if (atmel_port->gpio_irq[UART_GPIO_CTS] >= 0)
-		disable_irq(atmel_port->gpio_irq[UART_GPIO_CTS]);
-	else
+	mctrl_gpio_disable_ms(atmel_port->gpios);
+
+	if (!mctrl_gpio_is_gpio(atmel_port->gpios, UART_GPIO_CTS))
 		idr |= ATMEL_US_CTSIC;
 
-	if (atmel_port->gpio_irq[UART_GPIO_DSR] >= 0)
-		disable_irq(atmel_port->gpio_irq[UART_GPIO_DSR]);
-	else
+	if (!mctrl_gpio_is_gpio(atmel_port->gpios, UART_GPIO_DSR))
 		idr |= ATMEL_US_DSRIC;
 
-	if (atmel_port->gpio_irq[UART_GPIO_RI] >= 0)
-		disable_irq(atmel_port->gpio_irq[UART_GPIO_RI]);
-	else
+	if (!mctrl_gpio_is_gpio(atmel_port->gpios, UART_GPIO_RI))
 		idr |= ATMEL_US_RIIC;
 
-	if (atmel_port->gpio_irq[UART_GPIO_DCD] >= 0)
-		disable_irq(atmel_port->gpio_irq[UART_GPIO_DCD]);
-	else
+	if (!mctrl_gpio_is_gpio(atmel_port->gpios, UART_GPIO_DCD))
 		idr |= ATMEL_US_DCDIC;
 
 	UART_PUT_IDR(port, idr);
@@ -1178,31 +1165,11 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
 static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned int status, pending, pass_counter = 0;
-	bool gpio_handled = false;
 
 	do {
 		status = atmel_get_lines_status(port);
 		pending = status & UART_GET_IMR(port);
-		if (!gpio_handled) {
-			/*
-			 * Dealing with GPIO interrupt
-			 */
-			if (irq == atmel_port->gpio_irq[UART_GPIO_CTS])
-				pending |= ATMEL_US_CTSIC;
-
-			if (irq == atmel_port->gpio_irq[UART_GPIO_DSR])
-				pending |= ATMEL_US_DSRIC;
-
-			if (irq == atmel_port->gpio_irq[UART_GPIO_RI])
-				pending |= ATMEL_US_RIIC;
-
-			if (irq == atmel_port->gpio_irq[UART_GPIO_DCD])
-				pending |= ATMEL_US_DCDIC;
-
-			gpio_handled = true;
-		}
 		if (!pending)
 			break;
 
@@ -1682,45 +1649,6 @@ static void atmel_get_ip_name(struct uart_port *port)
 	}
 }
 
-static void atmel_free_gpio_irq(struct uart_port *port)
-{
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	enum mctrl_gpio_idx i;
-
-	for (i = 0; i < UART_GPIO_MAX; i++)
-		if (atmel_port->gpio_irq[i] >= 0)
-			free_irq(atmel_port->gpio_irq[i], port);
-}
-
-static int atmel_request_gpio_irq(struct uart_port *port)
-{
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	int *irq = atmel_port->gpio_irq;
-	enum mctrl_gpio_idx i;
-	int err = 0;
-
-	for (i = 0; (i < UART_GPIO_MAX) && !err; i++) {
-		if (irq[i] < 0)
-			continue;
-
-		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
-		err = request_irq(irq[i], atmel_interrupt, IRQ_TYPE_EDGE_BOTH,
-				  "atmel_serial", port);
-		if (err)
-			dev_err(port->dev, "atmel_startup - Can't get %d irq\n",
-				irq[i]);
-	}
-
-	/*
-	 * If something went wrong, rollback.
-	 */
-	while (err && (--i >= 0))
-		if (irq[i] >= 0)
-			free_irq(irq[i], port);
-
-	return err;
-}
-
 /*
  * Perform initialization and enable port for reception
  */
@@ -1752,7 +1680,7 @@ static int atmel_startup(struct uart_port *port)
 	/*
 	 * Get the GPIO lines IRQ
 	 */
-	retval = atmel_request_gpio_irq(port);
+	retval = mctrl_gpio_request_irqs(atmel_port->gpios);
 	if (retval)
 		goto free_irq;
 
@@ -1889,7 +1817,7 @@ static void atmel_shutdown(struct uart_port *port)
 	 * Free the interrupts
 	 */
 	free_irq(port->irq, port);
-	atmel_free_gpio_irq(port);
+	mctrl_gpio_free_irqs(atmel_port->gpios);
 
 	atmel_port->ms_irq_enabled = false;
 
@@ -2536,24 +2464,13 @@ static int atmel_serial_resume(struct platform_device *pdev)
 #define atmel_serial_resume NULL
 #endif
 
-static int atmel_init_gpios(struct atmel_uart_port *p, struct device *dev)
+static bool atmel_init_gpios(struct atmel_uart_port *p)
 {
-	enum mctrl_gpio_idx i;
-	struct gpio_desc *gpiod;
-
-	p->gpios = mctrl_gpio_init(dev, 0);
+	p->gpios = mctrl_gpio_init_dt(&p->uart, 0);
 	if (IS_ERR_OR_NULL(p->gpios))
-		return -1;
+		return false;
 
-	for (i = 0; i < UART_GPIO_MAX; i++) {
-		gpiod = mctrl_gpio_to_gpiod(p->gpios, i);
-		if (gpiod && (gpiod_get_direction(gpiod) == GPIOF_DIR_IN))
-			p->gpio_irq[i] = gpiod_to_irq(gpiod);
-		else
-			p->gpio_irq[i] = -EINVAL;
-	}
-
-	return 0;
+	return true;
 }
 
 static int atmel_serial_probe(struct platform_device *pdev)
@@ -2593,8 +2510,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port->backup_imr = 0;
 	port->uart.line = ret;
 
-	ret = atmel_init_gpios(port, &pdev->dev);
-	if (ret < 0)
+	port->uart.dev = &pdev->dev;
+	if (!atmel_init_gpios(port))
 		dev_err(&pdev->dev, "%s",
 			"Failed to initialize GPIOs. The serial port may not work as expected");
 
-- 
1.7.11.3

