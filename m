From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 09/12] serial: clps711x: Using resource-managed functions
Date: Sun, 14 Oct 2012 11:05:31 +0400
Message-ID: <1350198334-18737-9-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:46426 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHG1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:06:27 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |   39 +++++++++++++++++----------------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 6039ebe..7cf3928 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -94,7 +94,7 @@ static void clps711xuart_enable_ms(struct uart_port *port)
 {
 }
 
-static irqreturn_t clps711xuart_int_rx(int irq, void *dev_id)
+static irqreturn_t uart_clps711x_int_rx(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 	struct tty_struct *tty = tty_port_tty_get(&port->state->port);
@@ -149,7 +149,7 @@ static irqreturn_t clps711xuart_int_rx(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t clps711xuart_int_tx(int irq, void *dev_id)
+static irqreturn_t uart_clps711x_int_tx(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
@@ -232,23 +232,20 @@ static int clps711xuart_startup(struct uart_port *port)
 {
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 	unsigned int syscon;
-	int retval;
+	int ret;
 
 	s->tx_enabled[port->line] = 1;
-
-	/*
-	 * Allocate the IRQs
-	 */
-	retval = request_irq(TX_IRQ(port), clps711xuart_int_tx, 0,
-			     "clps711xuart_tx", port);
-	if (retval)
-		return retval;
-
-	retval = request_irq(RX_IRQ(port), clps711xuart_int_rx, 0,
-			     "clps711xuart_rx", port);
-	if (retval) {
-		free_irq(TX_IRQ(port), port);
-		return retval;
+	/* Allocate the IRQs */
+	ret = devm_request_irq(port->dev, TX_IRQ(port), uart_clps711x_int_tx,
+			       0, UART_CLPS711X_NAME " TX", port);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(port->dev, RX_IRQ(port), uart_clps711x_int_rx,
+			       0, UART_CLPS711X_NAME " RX", port);
+	if (ret) {
+		devm_free_irq(port->dev, TX_IRQ(port), port);
+		return ret;
 	}
 
 	/*
@@ -265,11 +262,9 @@ static void clps711xuart_shutdown(struct uart_port *port)
 {
 	unsigned int ubrlcr, syscon;
 
-	/*
-	 * Free the interrupt
-	 */
-	free_irq(TX_IRQ(port), port);	/* TX interrupt */
-	free_irq(RX_IRQ(port), port);	/* RX interrupt */
+	/* Free the interrupts */
+	devm_free_irq(port->dev, TX_IRQ(port), port);
+	devm_free_irq(port->dev, RX_IRQ(port), port);
 
 	/*
 	 * disable the port
-- 
1.7.8.6

