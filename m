From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 03/12] serial: clps711x: Do not use "uart_port->unused" field
Date: Sun, 14 Oct 2012 11:05:25 +0400
Message-ID: <1350198334-18737-3-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:39405 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHF5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:05:57 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index de6aa33..3b17d19 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -56,11 +56,10 @@
 
 #define UART_ANY_ERR		(UARTDR_FRMERR | UARTDR_PARERR | UARTDR_OVERR)
 
-#define tx_enabled(port)	((port)->unused[0])
-
 struct clps711x_port {
 	struct uart_driver	uart;
 	struct uart_port	port[UART_CLPS711X_NR];
+	int			tx_enabled[UART_CLPS711X_NR];
 #ifdef CONFIG_SERIAL_CLPS711X_CONSOLE
 	struct console		console;
 #endif
@@ -68,17 +67,21 @@ struct clps711x_port {
 
 static void clps711xuart_stop_tx(struct uart_port *port)
 {
-	if (tx_enabled(port)) {
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+
+	if (s->tx_enabled[port->line]) {
 		disable_irq(TX_IRQ(port));
-		tx_enabled(port) = 0;
+		s->tx_enabled[port->line] = 0;
 	}
 }
 
 static void clps711xuart_start_tx(struct uart_port *port)
 {
-	if (!tx_enabled(port)) {
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
+
+	if (!s->tx_enabled[port->line]) {
 		enable_irq(TX_IRQ(port));
-		tx_enabled(port) = 1;
+		s->tx_enabled[port->line] = 1;
 	}
 }
 
@@ -148,6 +151,7 @@ static irqreturn_t clps711xuart_int_rx(int irq, void *dev_id)
 static irqreturn_t clps711xuart_int_tx(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
 	struct circ_buf *xmit = &port->state->xmit;
 	int count;
 
@@ -158,8 +162,11 @@ static irqreturn_t clps711xuart_int_tx(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
-		goto disable_tx_irq;
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		disable_irq_nosync(TX_IRQ(port));
+		s->tx_enabled[port->line] = 0;
+		return IRQ_HANDLED;
+	}
 
 	count = port->fifosize >> 1;
 	do {
@@ -173,12 +180,6 @@ static irqreturn_t clps711xuart_int_tx(int irq, void *dev_id)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	if (uart_circ_empty(xmit)) {
-	disable_tx_irq:
-		disable_irq_nosync(TX_IRQ(port));
-		tx_enabled(port) = 0;
-	}
-
 	return IRQ_HANDLED;
 }
 
@@ -230,10 +231,11 @@ static void clps711xuart_break_ctl(struct uart_port *port, int break_state)
 
 static int clps711xuart_startup(struct uart_port *port)
 {
+	struct clps711x_port *s = dev_get_drvdata(port->dev);
 	unsigned int syscon;
 	int retval;
 
-	tx_enabled(port) = 1;
+	s->tx_enabled[port->line] = 1;
 
 	/*
 	 * Allocate the IRQs
-- 
1.7.8.6

