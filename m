From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 07/11] serial/atmel: Use the rs485 functions on serial_core
Date: Thu,  6 Nov 2014 09:22:56 +0100
Message-ID: <1415262180-2694-8-git-send-email-ricardo.ribalda@gmail.com>
References: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:50970 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaKFIXP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 03:23:15 -0500
Received: by mail-lb0-f177.google.com with SMTP id z12so466114lbi.36
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2014 00:23:13 -0800 (PST)
In-Reply-To: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

In order to unify all the rs485 ioctl handling.
Use the implementation of TIOC[GS]RS485 ioctl handling on serial_core.

Reviewed-by: Alan Cox <alan@linux.intel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/atmel_serial.c | 79 ++++++++++++---------------------------
 1 file changed, 24 insertions(+), 55 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 8a84034..ab33a53 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -167,7 +167,6 @@ struct atmel_uart_port {
 
 	struct circ_buf		rx_ring;
 
-	struct serial_rs485	rs485;		/* rs485 settings */
 	struct mctrl_gpios	*gpios;
 	int			gpio_irq[UART_GPIO_MAX];
 	unsigned int		tx_done_mask;
@@ -290,7 +289,8 @@ static unsigned int atmel_get_lines_status(struct uart_port *port)
 }
 
 /* Enable or disable the rs485 support */
-void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
+static int atmel_config_rs485(struct uart_port *port,
+			      struct serial_rs485 *rs485conf)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned int mode;
@@ -306,7 +306,7 @@ void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 	/* Resetting serial mode to RS232 (0x0) */
 	mode &= ~ATMEL_US_USMODE;
 
-	atmel_port->rs485 = *rs485conf;
+	port->rs485 = *rs485conf;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
@@ -329,6 +329,7 @@ void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
+	return 0;
 }
 
 /*
@@ -372,11 +373,10 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
 	/* Resetting serial mode to RS232 (0x0) */
 	mode &= ~ATMEL_US_USMODE;
 
-	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
+	if (port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		if ((atmel_port->rs485.delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port,
-					atmel_port->rs485.delay_rts_after_send);
+		if ((port->rs485.delay_rts_after_send) > 0)
+			UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -423,8 +423,8 @@ static void atmel_stop_tx(struct uart_port *port)
 	/* Disable interrupts */
 	UART_PUT_IDR(port, atmel_port->tx_done_mask);
 
-	if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
-	    !(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX))
+	if ((port->rs485.flags & SER_RS485_ENABLED) &&
+	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
 		atmel_start_rx(port);
 }
 
@@ -441,8 +441,8 @@ static void atmel_start_tx(struct uart_port *port)
 			   really need this.*/
 			return;
 
-		if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
-		    !(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX))
+		if ((port->rs485.flags & SER_RS485_ENABLED) &&
+		    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
 			atmel_stop_rx(port);
 
 		/* re-enable PDC transmit */
@@ -807,7 +807,7 @@ static void atmel_tx_dma(struct uart_port *port)
 		atmel_port->cookie_tx = dmaengine_submit(desc);
 
 	} else {
-		if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
+		if (port->rs485.flags & SER_RS485_ENABLED) {
 			/* DMA done, stop TX, start RX for RS485 */
 			atmel_start_rx(port);
 		}
@@ -1240,8 +1240,8 @@ static void atmel_tx_pdc(struct uart_port *port)
 		/* Enable interrupts */
 		UART_PUT_IER(port, atmel_port->tx_done_mask);
 	} else {
-		if ((atmel_port->rs485.flags & SER_RS485_ENABLED) &&
-		    !(atmel_port->rs485.flags & SER_RS485_RX_DURING_TX)) {
+		if ((port->rs485.flags & SER_RS485_ENABLED) &&
+		    !(port->rs485.flags & SER_RS485_RX_DURING_TX)) {
 			/* DMA done, stop TX, start RX for RS485 */
 			atmel_start_rx(port);
 		}
@@ -1552,7 +1552,7 @@ static int atmel_init_property(struct atmel_uart_port *atmel_port,
 	return 0;
 }
 
-static void atmel_init_rs485(struct atmel_uart_port *atmel_port,
+static void atmel_init_rs485(struct uart_port *port,
 				struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1563,7 +1563,7 @@ static void atmel_init_rs485(struct atmel_uart_port *atmel_port,
 		/* rs485 properties */
 		if (of_property_read_u32_array(np, "rs485-rts-delay",
 					rs485_delay, 2) == 0) {
-			struct serial_rs485 *rs485conf = &atmel_port->rs485;
+			struct serial_rs485 *rs485conf = &port->rs485;
 
 			rs485conf->delay_rts_before_send = rs485_delay[0];
 			rs485conf->delay_rts_after_send = rs485_delay[1];
@@ -1577,7 +1577,7 @@ static void atmel_init_rs485(struct atmel_uart_port *atmel_port,
 			rs485conf->flags |= SER_RS485_ENABLED;
 		}
 	} else {
-		atmel_port->rs485       = pdata->rs485;
+		port->rs485       = pdata->rs485;
 	}
 
 }
@@ -1913,7 +1913,6 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	unsigned long flags;
 	unsigned int mode, imr, quot, baud;
-	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
 	/* Get current mode register */
 	mode = UART_GET_MR(port) & ~(ATMEL_US_USCLKS | ATMEL_US_CHRL
@@ -2015,10 +2014,9 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* Resetting serial mode to RS232 (0x0) */
 	mode &= ~ATMEL_US_USMODE;
 
-	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
-		if ((atmel_port->rs485.delay_rts_after_send) > 0)
-			UART_PUT_TTGR(port,
-					atmel_port->rs485.delay_rts_after_send);
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		if ((port->rs485.delay_rts_after_send) > 0)
+			UART_PUT_TTGR(port, port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	}
 
@@ -2150,35 +2148,6 @@ static void atmel_poll_put_char(struct uart_port *port, unsigned char ch)
 }
 #endif
 
-static int
-atmel_ioctl(struct uart_port *port, unsigned int cmd, unsigned long arg)
-{
-	struct serial_rs485 rs485conf;
-
-	switch (cmd) {
-	case TIOCSRS485:
-		if (copy_from_user(&rs485conf, (struct serial_rs485 *) arg,
-					sizeof(rs485conf)))
-			return -EFAULT;
-
-		atmel_config_rs485(port, &rs485conf);
-		break;
-
-	case TIOCGRS485:
-		if (copy_to_user((struct serial_rs485 *) arg,
-					&(to_atmel_uart_port(port)->rs485),
-					sizeof(rs485conf)))
-			return -EFAULT;
-		break;
-
-	default:
-		return -ENOIOCTLCMD;
-	}
-	return 0;
-}
-
-
-
 static struct uart_ops atmel_pops = {
 	.tx_empty	= atmel_tx_empty,
 	.set_mctrl	= atmel_set_mctrl,
@@ -2199,7 +2168,6 @@ static struct uart_ops atmel_pops = {
 	.config_port	= atmel_config_port,
 	.verify_port	= atmel_verify_port,
 	.pm		= atmel_serial_pm,
-	.ioctl		= atmel_ioctl,
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_get_char	= atmel_poll_get_char,
 	.poll_put_char	= atmel_poll_put_char,
@@ -2219,7 +2187,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	if (!atmel_init_property(atmel_port, pdev))
 		atmel_set_ops(port);
 
-	atmel_init_rs485(atmel_port, pdev);
+	atmel_init_rs485(port, pdev);
 
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF;
@@ -2228,6 +2196,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	port->dev		= &pdev->dev;
 	port->mapbase	= pdev->resource[0].start;
 	port->irq	= pdev->resource[1].start;
+	port->rs485_config	= atmel_config_rs485;
 
 	tasklet_init(&atmel_port->tasklet, atmel_tasklet_func,
 			(unsigned long)port);
@@ -2262,7 +2231,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	}
 
 	/* Use TXEMPTY for interrupt when rs485 else TXRDY or ENDTX|TXBUFE */
-	if (atmel_port->rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
 	else if (atmel_use_pdc_tx(port)) {
 		port->fifosize = PDC_BUFFER_SIZE;
@@ -2608,7 +2577,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 1);
 	platform_set_drvdata(pdev, port);
 
-	if (port->rs485.flags & SER_RS485_ENABLED) {
+	if (port->uart.rs485.flags & SER_RS485_ENABLED) {
 		UART_PUT_MR(&port->uart, ATMEL_US_USMODE_NORMAL);
 		UART_PUT_CR(&port->uart, ATMEL_US_RTSEN);
 	}
-- 
2.1.1

