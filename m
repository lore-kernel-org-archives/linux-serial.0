From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 05/12] serial: clps711x: Improved TX FIFO handling
Date: Sun, 14 Oct 2012 11:05:27 +0400
Message-ID: <1350198334-18737-5-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:44457 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHGH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:06:07 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 0884939..d374609 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -155,7 +155,6 @@ static irqreturn_t clps711xuart_int_tx(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	struct clps711x_port *s = dev_get_drvdata(port->dev);
 	struct circ_buf *xmit = &port->state->xmit;
-	int count;
 
 	if (port->x_char) {
 		clps_writel(port->x_char, UARTDR(port));
@@ -170,14 +169,13 @@ static irqreturn_t clps711xuart_int_tx(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	count = port->fifosize >> 1;
-	do {
-		clps_writel(xmit->buf[xmit->tail], UARTDR(port));
+	while (!uart_circ_empty(xmit)) {
+		clps_writew(xmit->buf[xmit->tail], UARTDR(port));
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
-		if (uart_circ_empty(xmit))
+		if (clps_readl(SYSFLG(port) & SYSFLG_UTXFF))
 			break;
-	} while (--count > 0);
+	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
@@ -327,8 +325,9 @@ clps711xuart_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (!(termios->c_cflag & PARODD))
 			ubrlcr |= UBRLCR_EVENPRT;
 	}
-	if (port->fifosize > 1)
-		ubrlcr |= UBRLCR_FIFOEN;
+
+	/* Enable FIFO */
+	ubrlcr |= UBRLCR_FIFOEN;
 
 	spin_lock_irqsave(&port->lock, flags);
 
-- 
1.7.8.6

