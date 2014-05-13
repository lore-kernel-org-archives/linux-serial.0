From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH RESEND 5/5] tty/serial: at91: add interrupts for modem control lines
Date: Tue, 13 May 2014 20:20:45 +0200
Message-ID: <1400005245-11943-6-git-send-email-richard.genoud@gmail.com>
References: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:38636 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbaEMSVU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 May 2014 14:21:20 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so787091wgg.0
        for <linux-serial@vger.kernel.org>; Tue, 13 May 2014 11:21:18 -0700 (PDT)
In-Reply-To: <1400005245-11943-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

Handle CTS/DSR/RI/DCD GPIO interrupts in atmel_serial.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |  125 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 43ca659..3fceae0 100644
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
@@ -1079,11 +1112,31 @@ atmel_handle_status(struct uart_port *port, unsigned int pending,
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
+			if (irq == atmel_port->gpio_irq[UART_GPIO_CTS])
+				pending |= ATMEL_US_CTSIC;
+
+			if (irq == atmel_port->gpio_irq[UART_GPIO_DSR])
+				pending |= ATMEL_US_DSRIC;
+
+			if (irq == atmel_port->gpio_irq[UART_GPIO_RI])
+				pending |= ATMEL_US_RIIC;
+
+			if (irq == atmel_port->gpio_irq[UART_GPIO_DCD])
+				pending |= ATMEL_US_DCDIC;
+
+			gpio_handled = true;
+		}
 		if (!pending)
 			break;
 
@@ -1563,6 +1616,45 @@ static void atmel_get_ip_name(struct uart_port *port)
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
+	while (err && (--i >= 0))
+		if (irq[i] >= 0)
+			free_irq(irq[i], port);
+
+	return err;
+}
+
 /*
  * Perform initialization and enable port for reception
  */
@@ -1579,6 +1671,7 @@ static int atmel_startup(struct uart_port *port)
 	 * handle an unexpected interrupt
 	 */
 	UART_PUT_IDR(port, -1);
+	atmel_port->ms_irq_enabled = false;
 
 	/*
 	 * Allocate the IRQ
@@ -1591,6 +1684,13 @@ static int atmel_startup(struct uart_port *port)
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
@@ -1654,6 +1754,11 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	return 0;
+
+free_irq:
+	free_irq(port->irq, port);
+
+	return retval;
 }
 
 /*
@@ -1701,9 +1806,12 @@ static void atmel_shutdown(struct uart_port *port)
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
@@ -2366,10 +2474,21 @@ static int atmel_serial_resume(struct platform_device *pdev)
 
 static int atmel_init_gpios(struct atmel_uart_port *p, struct device *dev)
 {
+	enum mctrl_gpio_idx i;
+	struct gpio_desc *gpiod;
+
 	p->gpios = mctrl_gpio_init(dev, 0);
 	if (IS_ERR_OR_NULL(p->gpios))
 		return -1;
 
+	for (i = 0; i < UART_GPIO_MAX; i++) {
+		gpiod = mctrl_gpio_to_gpiod(p->gpios, i);
+		if (gpiod && (gpiod_get_direction(gpiod) == GPIOF_DIR_IN))
+			p->gpio_irq[i] = gpiod_to_irq(gpiod);
+		else
+			p->gpio_irq[i] = -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
1.7.10.4

