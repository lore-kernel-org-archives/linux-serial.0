From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] tty/serial: atmel: add fractional baud rate support
Date: Thu, 25 Aug 2016 15:47:56 +0200
Message-ID: <20160825134756.6261-1-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-serial@vger.kernel.org

The USART device provides a fractional baud rate generator to get a more
accurate baud rate. It can be used only when the USART is configured in
'normal mode' and this feature is not available on AT91RM9200 SoC.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/tty/serial/atmel_serial.c | 41 +++++++++++++++++++++++++++++++--------
 include/linux/atmel_serial.h      |  1 +
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2eaa18d..1759239 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -166,6 +166,7 @@ struct atmel_uart_port {
 	u32			rts_low;
 	bool			ms_irq_enabled;
 	u32			rtor;	/* address of receiver timeout register if it exists */
+	bool			has_frac_baudrate;
 	bool			has_hw_timer;
 	struct timer_list	uart_timer;
 
@@ -1745,6 +1746,11 @@ static void atmel_get_ip_name(struct uart_port *port)
 	dbgu_uart = 0x44424755;	/* DBGU */
 	new_uart = 0x55415254;	/* UART */
 
+	/*
+	 * Only USART devices from at91sam9260 SOC implement fractional
+	 * baudrate.
+	 */
+	atmel_port->has_frac_baudrate = false;
 	atmel_port->has_hw_timer = false;
 
 	if (name == new_uart) {
@@ -1753,6 +1759,7 @@ static void atmel_get_ip_name(struct uart_port *port)
 		atmel_port->rtor = ATMEL_UA_RTOR;
 	} else if (name == usart) {
 		dev_dbg(port->dev, "Usart\n");
+		atmel_port->has_frac_baudrate = true;
 		atmel_port->has_hw_timer = true;
 		atmel_port->rtor = ATMEL_US_RTOR;
 	} else if (name == dbgu_uart) {
@@ -1764,6 +1771,7 @@ static void atmel_get_ip_name(struct uart_port *port)
 		case 0x302:
 		case 0x10213:
 			dev_dbg(port->dev, "This version is usart\n");
+			atmel_port->has_frac_baudrate = true;
 			atmel_port->has_hw_timer = true;
 			atmel_port->rtor = ATMEL_US_RTOR;
 			break;
@@ -2025,8 +2033,9 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
 static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 			      struct ktermios *old)
 {
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned long flags;
-	unsigned int old_mode, mode, imr, quot, baud;
+	unsigned int old_mode, mode, imr, quot, baud, div, cd, fp = 0;
 
 	/* save the current mode register */
 	mode = old_mode = atmel_uart_readl(port, ATMEL_US_MR);
@@ -2036,12 +2045,6 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		  ATMEL_US_PAR | ATMEL_US_USMODE);
 
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
-	quot = uart_get_divisor(port, baud);
-
-	if (quot > 65535) {	/* BRGR is 16-bit, so switch to slower clock */
-		quot /= 8;
-		mode |= ATMEL_US_USCLKS_MCK_DIV8;
-	}
 
 	/* byte size */
 	switch (termios->c_cflag & CSIZE) {
@@ -2160,7 +2163,29 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 		atmel_uart_writel(port, ATMEL_US_CR, rts_state);
 	}
 
-	/* set the baud rate */
+	/*
+	 * Set the baud rate:
+	 * Fractional baudrate allows to setup output frequency more
+	 * accurately. This feature is enabled only when using normal mode.
+	 * baudrate = selected clock / (8 * (2 - OVER) * (CD + FP / 8))
+	 * Currently, OVER is always set to 0 so we get
+	 * baudrate = selected clock (16 * (CD + FP / 8))
+	 */
+	if (atmel_port->has_frac_baudrate &&
+	    (mode & ATMEL_US_USMODE) == ATMEL_US_USMODE_NORMAL) {
+		div = DIV_ROUND_CLOSEST(port->uartclk, baud);
+		cd = div / 16;
+		fp = DIV_ROUND_CLOSEST(div % 16, 2);
+	} else {
+		cd = uart_get_divisor(port, baud);
+	}
+
+	if (cd > 65535) {	/* BRGR is 16-bit, so switch to slower clock */
+		cd /= 8;
+		mode |= ATMEL_US_USCLKS_MCK_DIV8;
+	}
+	quot = cd | fp << ATMEL_US_FP_OFFSET;
+
 	atmel_uart_writel(port, ATMEL_US_BRGR, quot);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_RSTSTA | ATMEL_US_RSTRX);
 	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN | ATMEL_US_RXEN);
diff --git a/include/linux/atmel_serial.h b/include/linux/atmel_serial.h
index 5a4d664..f8e452a 100644
--- a/include/linux/atmel_serial.h
+++ b/include/linux/atmel_serial.h
@@ -118,6 +118,7 @@
 
 #define ATMEL_US_BRGR		0x20	/* Baud Rate Generator Register */
 #define	ATMEL_US_CD		GENMASK(15, 0)	/* Clock Divider */
+#define ATMEL_US_FP_OFFSET	16	/* Fractional Part */
 
 #define ATMEL_US_RTOR		0x24	/* Receiver Time-out Register for USART */
 #define ATMEL_UA_RTOR		0x28	/* Receiver Time-out Register for UART */
-- 
2.9.0
