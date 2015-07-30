From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 2/2] atmel_serial: set 32-bit access by default
Date: Thu, 30 Jul 2015 16:06:31 +0300
Message-ID: <1438261591-13130-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1438261591-13130-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438261591-13130-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The commit b5199d468177 (tty/serial: at91: add support to FIFOs) changed data
stream 32-bit accesses in the driver to 8-bit. This, unfortunately, breaks data
register access on ATNGW100, where the IP needs data register accesses to be
long accesses (all other accesses appear to be OK).

This change introduces a new master variable to allow interface drivers to
specify that 8-bit data transfer I/O is required. This change also introduces
the ability to set this variable via device tree bindings in the driver.

Fixes: b5199d468177 (tty/serial: at91: add support to FIFOs)
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/tty/serial/atmel_serial.c | 45 +++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index e91b3b2f..0312bce 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -155,6 +155,7 @@ struct atmel_uart_port {
 	u32			rts_high;
 	u32			rts_low;
 	bool			ms_irq_enabled;
+	u32			reg_io_width;	/* I/O width in bytes */
 	bool			is_usart;	/* usart or uart */
 	struct timer_list	uart_timer;	/* uart timer */
 
@@ -214,6 +215,34 @@ static inline void atmel_uart_writeb(struct uart_port *port, u32 reg, u8 value)
 	__raw_writeb(value, port->membase + reg);
 }
 
+static inline u8 atmel_uart_read_reg(struct uart_port *port, u32 reg)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+
+	switch (atmel_port->reg_io_width) {
+	case 1:
+		return atmel_uart_readb(port, reg);
+	case 4:
+	default:
+		return atmel_uart_readl(port, reg);
+	}
+}
+
+static inline void atmel_uart_write_reg(struct uart_port *port, u32 reg, u8 value)
+{
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+
+	switch (atmel_port->reg_io_width) {
+	case 1:
+		atmel_uart_writeb(port, reg, value);
+		break;
+	case 4:
+	default:
+		atmel_uart_writel(port, reg, value);
+		break;
+	}
+}
+
 #ifdef CONFIG_SERIAL_ATMEL_PDC
 static bool atmel_use_pdc_rx(struct uart_port *port)
 {
@@ -658,7 +687,7 @@ static void atmel_rx_chars(struct uart_port *port)
 
 	status = atmel_uart_readl(port, ATMEL_US_CSR);
 	while (status & ATMEL_US_RXRDY) {
-		ch = atmel_uart_readb(port, ATMEL_US_RHR);
+		ch = atmel_uart_read_reg(port, ATMEL_US_RHR);
 
 		/*
 		 * note that the error handling code is
@@ -709,7 +738,7 @@ static void atmel_tx_chars(struct uart_port *port)
 
 	if (port->x_char &&
 	    (atmel_uart_readl(port, ATMEL_US_CSR) & atmel_port->tx_done_mask)) {
-		atmel_uart_writeb(port, ATMEL_US_THR, port->x_char);
+		atmel_uart_write_reg(port, ATMEL_US_THR, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
 	}
@@ -718,7 +747,7 @@ static void atmel_tx_chars(struct uart_port *port)
 
 	while (atmel_uart_readl(port, ATMEL_US_CSR) &
 	       atmel_port->tx_done_mask) {
-		atmel_uart_writeb(port, ATMEL_US_THR, xmit->buf[xmit->tail]);
+		atmel_uart_write_reg(port, ATMEL_US_THR, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 		if (uart_circ_empty(xmit))
@@ -2294,7 +2323,7 @@ static int atmel_poll_get_char(struct uart_port *port)
 	while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_RXRDY))
 		cpu_relax();
 
-	return atmel_uart_readb(port, ATMEL_US_RHR);
+	return atmel_uart_read_reg(port, ATMEL_US_RHR);
 }
 
 static void atmel_poll_put_char(struct uart_port *port, unsigned char ch)
@@ -2302,7 +2331,7 @@ static void atmel_poll_put_char(struct uart_port *port, unsigned char ch)
 	while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY))
 		cpu_relax();
 
-	atmel_uart_writeb(port, ATMEL_US_THR, ch);
+	atmel_uart_write_reg(port, ATMEL_US_THR, ch);
 }
 #endif
 
@@ -2409,7 +2438,7 @@ static void atmel_console_putchar(struct uart_port *port, int ch)
 {
 	while (!(atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY))
 		cpu_relax();
-	atmel_uart_writeb(port, ATMEL_US_THR, ch);
+	atmel_uart_write_reg(port, ATMEL_US_THR, ch);
 }
 
 /*
@@ -2762,6 +2791,10 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port = &atmel_ports[ret];
 	port->backup_imr = 0;
 	port->uart.line = ret;
+
+	of_property_read_u32(pdev->dev.of_node, "reg-io-width",
+			&port->reg_io_width);
+
 	atmel_serial_probe_fifos(port, pdev);
 
 	spin_lock_init(&port->lock_suspended);
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
