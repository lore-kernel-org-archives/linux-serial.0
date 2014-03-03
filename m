From: Richard Genoud <noreply.rgenoud@gmail.com>
Subject: [PATCH v5 3/3] tty/serial: at91: add interrupts for modem control lines
Date: Mon,  3 Mar 2014 12:12:00 +0100
Message-ID: <1393845120-6340-4-git-send-email-richard.genoud@gmail.com>
References: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:37307 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbaCCLMb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Mar 2014 06:12:31 -0500
Received: by mail-we0-f176.google.com with SMTP id x48so2938004wes.21
        for <linux-serial@vger.kernel.org>; Mon, 03 Mar 2014 03:12:30 -0800 (PST)
In-Reply-To: <1393845120-6340-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

Handle CTS/DSR/RI/DCD GPIO interrupts in atmel_serial.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 129 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index d7d873c1a1d0..779501db72ff 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -45,6 +45,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/err.h>
+#include <linux/irq.h>
 
 #include <asm/io.h>
 #include <asm/ioctls.h>
@@ -167,7 +168,9 @@ struct atmel_uart_port {
 
 	struct serial_rs485	rs485;		/* rs485 settings */
 	struct mctrl_gpios	*gpios;
+	int			gpio_irq[UART_GPIO_MAX];
 	unsigned int		tx_done_mask;
+	bool			ms_irq_enabled;
 	bool			is_usart;	/* usart or uart */
 	struct timer_list	uart_timer;	/* uart timer */
 	int (*prepare_rx)(struct uart_port *port);
@@ -489,8 +492,38 @@ static void atmel_stop_rx(struct uart_port *port)
  */
 static void atmel_enable_ms(struct uart_port *port)
 {
-	UART_PUT_IER(port, ATMEL_US_RIIC | ATMEL_US_DSRIC
-			| ATMEL_US_DCDIC | ATMEL_US_CTSIC);
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	uint32_t ier = 0;
+
+	/*
+	 * Interrupt should not be enabled twice
+	 */
+	if (atmel_port->ms_irq_enabled)
+		return;
+
+	atmel_port->ms_irq_enabled = true;
+
+	if (atmel_port->gpio_irq[UART_GPIO_CTS] >= 0)
+		enable_irq(atmel_port->gpio_irq[UART_GPIO_CTS]);
+	else
+		ier |= ATMEL_US_CTSIC;
+
+	if (atmel_port->gpio_irq[UART_GPIO_DSR] >= 0)
+		enable_irq(atmel_port->gpio_irq[UART_GPIO_DSR]);
+	else
+		ier |= ATMEL_US_DSRIC;
+
+	if (atmel_port->gpio_irq[UART_GPIO_RI] >= 0)
+		enable_irq(atmel_port->gpio_irq[UART_GPIO_RI]);
+	else
+		ier |= ATMEL_US_RIIC;
+
+	if (atmel_port->gpio_irq[UART_GPIO_DCD] >= 0)
+		enable_irq(atmel_port->gpio_irq[UART_GPIO_DCD]);
+	else
+		ier |= ATMEL_US_DCDIC;
+
+	UART_PUT_IER(port, ier);
 }
 
 /*
@@ -1079,11 +1112,35 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
 static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned int status, pending, pass_counter = 0;
+	bool gpio_handled = false;
 
 	do {
 		status = atmel_get_lines_status(port);
 		pending = status & UART_GET_IMR(port);
+		if (!gpio_handled) {
+			/*
+			 * Dealing with GPIO interrupt
+			 */
+			if ((irq >= 0) &&
+			    (irq == atmel_port->gpio_irq[UART_GPIO_CTS]))
+				pending |= ATMEL_US_CTSIC;
+
+			if ((irq >= 0) &&
+			    (irq == atmel_port->gpio_irq[UART_GPIO_DSR]))
+				pending |= ATMEL_US_DSRIC;
+
+			if ((irq >= 0) &&
+			    (irq == atmel_port->gpio_irq[UART_GPIO_RI]))
+				pending |= ATMEL_US_RIIC;
+
+			if ((irq >= 0) &&
+			    (irq == atmel_port->gpio_irq[UART_GPIO_DCD]))
+				pending |= ATMEL_US_DCDIC;
+
+			gpio_handled = true;
+		}
 		if (!pending)
 			break;
 
@@ -1563,6 +1620,45 @@ static void atmel_get_ip_name(struct uart_port *port)
 	}
 }
 
+static void atmel_free_gpio_irq(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	enum mctrl_gpio_idx i;
+
+	for (i = 0; i < UART_GPIO_MAX; i++)
+		if (atmel_port->gpio_irq[i] >= 0)
+			free_irq(atmel_port->gpio_irq[i], port);
+}
+
+static int atmel_request_gpio_irq(struct uart_port *port)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	int *irq = atmel_port->gpio_irq;
+	enum mctrl_gpio_idx i;
+	int err = 0;
+
+	for (i = 0; (i < UART_GPIO_MAX) && !err; i++) {
+		if (irq[i] < 0)
+			continue;
+
+		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
+		err = request_irq(irq[i], atmel_interrupt, IRQ_TYPE_EDGE_BOTH,
+				  "atmel_serial", port);
+		if (err)
+			dev_err(port->dev, "atmel_startup - Can't get %d irq\n",
+				irq[i]);
+	}
+
+	/*
+	 * If something went wrong, rollback.
+	 */
+	while (err && --i)
+		if (irq[i] >= 0)
+			free_irq(irq[i], port);
+
+	return err;
+}
+
 /*
  * Perform initialization and enable port for reception
  */
@@ -1579,6 +1675,7 @@ static int atmel_startup(struct uart_port *port)
 	 * handle an unexpected interrupt
 	 */
 	UART_PUT_IDR(port, -1);
+	atmel_port->ms_irq_enabled = false;
 
 	/*
 	 * Allocate the IRQ
@@ -1591,6 +1688,13 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	/*
+	 * Get the GPIO lines IRQ
+	 */
+	retval = atmel_request_gpio_irq(port);
+	if (retval)
+		goto free_irq;
+
+	/*
 	 * Initialize DMA (if necessary)
 	 */
 	atmel_init_property(atmel_port, pdev);
@@ -1654,6 +1758,11 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	return 0;
+
+free_irq:
+	free_irq(port->irq, port);
+
+	return retval;
 }
 
 /*
@@ -1701,9 +1810,12 @@ static void atmel_shutdown(struct uart_port *port)
 	atmel_port->rx_ring.tail = 0;
 
 	/*
-	 * Free the interrupt
+	 * Free the interrupts
 	 */
 	free_irq(port->irq, port);
+	atmel_free_gpio_irq(port);
+
+	atmel_port->ms_irq_enabled = false;
 }
 
 /*
@@ -2366,12 +2478,23 @@ static int atmel_serial_resume(struct platform_device *pdev)
 
 static int atmel_init_gpios(struct atmel_uart_port *p, struct device *dev)
 {
+	enum mctrl_gpio_idx i;
+	struct gpio_desc *gpiod;
 	int err = 0;
 
 	p->gpios = mctrl_gpio_init(dev, 0);
 	if (IS_ERR_OR_NULL(p->gpios))
 		err = PTR_ERR(p->gpios);
 
+	for (i = 0; i < UART_GPIO_MAX; i++) {
+		gpiod = mctrl_gpio_to_gpiod(p->gpios, i);
+		if (!IS_ERR_OR_NULL(gpiod) &&
+		    (gpiod_get_direction(gpiod) == GPIOF_DIR_IN))
+			p->gpio_irq[i] = gpiod_to_irq(gpiod);
+		else
+			p->gpio_irq[i] = -EINVAL;
+	}
+
 	return err;
 }
 
-- 
1.8.5.5

