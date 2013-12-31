From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/2] serial: clps711x: Enable driver compilation with COMPILE_TEST
Date: Tue, 31 Dec 2013 20:49:42 +0400
Message-ID: <1388508582-13094-2-git-send-email-shc_work@mail.ru>
References: <1388508582-13094-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp45.i.mail.ru ([94.100.177.105]:49495 "EHLO smtp45.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753769Ab3LaQty (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 Dec 2013 11:49:54 -0500
In-Reply-To: <1388508582-13094-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This helps increasing build testing coverage.
To do this, read{write}_relaxed() functions was be replaced with
simple read{write}() variants. Potential "uninitialized variable"
warnings was be fixed if driver compiled without MFD_SYSCON.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/Kconfig    |  3 +--
 drivers/tty/serial/clps711x.c | 40 ++++++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 7fbbbad..441ada4 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -181,9 +181,8 @@ config SERIAL_KS8695_CONSOLE
 
 config SERIAL_CLPS711X
 	tristate "CLPS711X serial port support"
-	depends on ARCH_CLPS711X
+	depends on ARCH_CLPS711X || COMPILE_TEST
 	select SERIAL_CORE
-	default y
 	help
 	  This enables the driver for the on-chip UARTs of the Cirrus
 	  Logic EP711x/EP721x/EP731x processors.
diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 5a931f9..b0eacb8 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -99,15 +99,16 @@ static irqreturn_t uart_clps711x_int_rx(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 	unsigned int status, flg;
-	u32 sysflg;
 	u16 ch;
 
 	for (;;) {
+		u32 sysflg = 0;
+
 		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
 		if (sysflg & SYSFLG_URXFE)
 			break;
 
-		ch = readw_relaxed(port->membase + UARTDR_OFFSET);
+		ch = readw(port->membase + UARTDR_OFFSET);
 		status = ch & (UARTDR_FRMERR | UARTDR_PARERR | UARTDR_OVERR);
 		ch &= 0xff;
 
@@ -151,10 +152,9 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 	struct circ_buf *xmit = &port->state->xmit;
-	u32 sysflg;
 
 	if (port->x_char) {
-		writew_relaxed(port->x_char, port->membase + UARTDR_OFFSET);
+		writew(port->x_char, port->membase + UARTDR_OFFSET);
 		port->icount.tx++;
 		port->x_char = 0;
 		return IRQ_HANDLED;
@@ -169,8 +169,9 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 	}
 
 	while (!uart_circ_empty(xmit)) {
-		writew_relaxed(xmit->buf[xmit->tail],
-			       port->membase + UARTDR_OFFSET);
+		u32 sysflg = 0;
+
+		writew(xmit->buf[xmit->tail], port->membase + UARTDR_OFFSET);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 
@@ -188,7 +189,7 @@ static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 static unsigned int uart_clps711x_tx_empty(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
-	u32 sysflg;
+	u32 sysflg = 0;
 
 	regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
 
@@ -199,9 +200,10 @@ static unsigned int uart_clps711x_get_mctrl(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 	unsigned int result = 0;
-	u32 sysflg;
 
 	if (s->use_ms) {
+		u32 sysflg = 0;
+
 		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
 		if (sysflg & SYSFLG1_DCD)
 			result |= TIOCM_CAR;
@@ -224,12 +226,12 @@ static void uart_clps711x_break_ctl(struct uart_port *port, int break_state)
 {
 	unsigned int ubrlcr;
 
-	ubrlcr = readl_relaxed(port->membase + UBRLCR_OFFSET);
+	ubrlcr = readl(port->membase + UBRLCR_OFFSET);
 	if (break_state)
 		ubrlcr |= UBRLCR_BREAK;
 	else
 		ubrlcr &= ~UBRLCR_BREAK;
-	writel_relaxed(ubrlcr, port->membase + UBRLCR_OFFSET);
+	writel(ubrlcr, port->membase + UBRLCR_OFFSET);
 }
 
 static void uart_clps711x_set_ldisc(struct uart_port *port, int ld)
@@ -247,8 +249,8 @@ static int uart_clps711x_startup(struct uart_port *port)
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 
 	/* Disable break */
-	writel_relaxed(readl_relaxed(port->membase + UBRLCR_OFFSET) &
-		       ~UBRLCR_BREAK, port->membase + UBRLCR_OFFSET);
+	writel(readl(port->membase + UBRLCR_OFFSET) & ~UBRLCR_BREAK,
+	       port->membase + UBRLCR_OFFSET);
 
 	/* Enable the port */
 	return regmap_update_bits(s->syscon, SYSCON_OFFSET,
@@ -320,7 +322,7 @@ static void uart_clps711x_set_termios(struct uart_port *port,
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	writel_relaxed(ubrlcr | (quot - 1), port->membase + UBRLCR_OFFSET);
+	writel(ubrlcr | (quot - 1), port->membase + UBRLCR_OFFSET);
 }
 
 static const char *uart_clps711x_type(struct uart_port *port)
@@ -366,13 +368,13 @@ static const struct uart_ops uart_clps711x_ops = {
 static void uart_clps711x_console_putchar(struct uart_port *port, int ch)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
-	u32 sysflg;
+	u32 sysflg = 0;
 
 	do {
 		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
 	} while (sysflg & SYSFLG_UTXFF);
 
-	writew_relaxed(ch, port->membase + UARTDR_OFFSET);
+	writew(ch, port->membase + UARTDR_OFFSET);
 }
 
 static void uart_clps711x_console_write(struct console *co, const char *c,
@@ -380,7 +382,7 @@ static void uart_clps711x_console_write(struct console *co, const char *c,
 {
 	struct uart_port *port = clps711x_uart.state[co->index].uart_port;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
-	u32 sysflg;
+	u32 sysflg = 0;
 
 	uart_console_write(port, c, n, uart_clps711x_console_putchar);
 
@@ -396,8 +398,8 @@ static int uart_clps711x_console_setup(struct console *co, char *options)
 	int ret, index = co->index;
 	struct clps711x_port *s;
 	struct uart_port *port;
-	u32 ubrlcr, syscon;
 	unsigned int quot;
+	u32 ubrlcr;
 
 	if (index < 0 || index >= UART_CLPS711X_NR)
 		return -EINVAL;
@@ -409,9 +411,11 @@ static int uart_clps711x_console_setup(struct console *co, char *options)
 	s = dev_get_drvdata(port->dev);
 
 	if (!options) {
+		u32 syscon = 0;
+
 		regmap_read(s->syscon, SYSCON_OFFSET, &syscon);
 		if (syscon & SYSCON_UARTEN) {
-			ubrlcr = readl_relaxed(port->membase + UBRLCR_OFFSET);
+			ubrlcr = readl(port->membase + UBRLCR_OFFSET);
 
 			if (ubrlcr & UBRLCR_PRTEN) {
 				if (ubrlcr & UBRLCR_EVENPRT)
-- 
1.8.3.2

