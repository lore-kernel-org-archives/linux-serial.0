From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v2] tty/serial: atmel: remove unneeded atmel_get_lines_status function
Date: Mon, 26 Aug 2019 09:17:52 +0200
Message-ID: <20190826071752.30396-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>
List-Id: linux-serial@vger.kernel.org

Since commit 18dfef9c7f87 ("serial: atmel: convert to irq handling
provided mctrl-gpio"), the GPIOs interrupts are handled by
mctrl_gpio_irq_handle().
So, atmel_get_lines_status() can be completely killed and replaced by :
atmel_uart_readl(port, ATMEL_US_CSR);

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 48 ++-----------------------------
 1 file changed, 2 insertions(+), 46 deletions(-)

Changes from v1:
 - point out the right commit (thx Uwe)
 - add Suggested-by/Acked-by

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 9a54c9e6d36e..a8dc8af83f39 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -294,50 +294,6 @@ static void atmel_tasklet_schedule(struct atmel_uart_port *atmel_port,
 		tasklet_schedule(t);
 }
 
-static unsigned int atmel_get_lines_status(struct uart_port *port)
-{
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	unsigned int status, ret = 0;
-
-	status = atmel_uart_readl(port, ATMEL_US_CSR);
-
-	mctrl_gpio_get(atmel_port->gpios, &ret);
-
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_CTS))) {
-		if (ret & TIOCM_CTS)
-			status &= ~ATMEL_US_CTS;
-		else
-			status |= ATMEL_US_CTS;
-	}
-
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_DSR))) {
-		if (ret & TIOCM_DSR)
-			status &= ~ATMEL_US_DSR;
-		else
-			status |= ATMEL_US_DSR;
-	}
-
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_RI))) {
-		if (ret & TIOCM_RI)
-			status &= ~ATMEL_US_RI;
-		else
-			status |= ATMEL_US_RI;
-	}
-
-	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
-						UART_GPIO_DCD))) {
-		if (ret & TIOCM_CD)
-			status &= ~ATMEL_US_DCD;
-		else
-			status |= ATMEL_US_DCD;
-	}
-
-	return status;
-}
-
 /* Enable or disable the rs485 support */
 static int atmel_config_rs485(struct uart_port *port,
 			      struct serial_rs485 *rs485conf)
@@ -1453,7 +1409,7 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 	spin_lock(&atmel_port->lock_suspended);
 
 	do {
-		status = atmel_get_lines_status(port);
+		status = atmel_uart_readl(port, ATMEL_US_CSR);
 		mask = atmel_uart_readl(port, ATMEL_US_IMR);
 		pending = status & mask;
 		if (!pending)
@@ -2002,7 +1958,7 @@ static int atmel_startup(struct uart_port *port)
 	}
 
 	/* Save current CSR for comparison in atmel_tasklet_func() */
-	atmel_port->irq_status_prev = atmel_get_lines_status(port);
+	atmel_port->irq_status_prev = atmel_uart_readl(port, ATMEL_US_CSR);
 
 	/*
 	 * Finally, enable the serial port
