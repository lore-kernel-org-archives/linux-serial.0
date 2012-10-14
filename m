From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 08/12] serial: clps711x: Check for valid TTY in RX-interrupt
Date: Sun, 14 Oct 2012 11:05:30 +0400
Message-ID: <1350198334-18737-8-git-send-email-shc_work@mail.ru>
References: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp17.mail.ru ([94.100.176.154]:45991 "EHLO smtp17.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606Ab2JNHGW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 14 Oct 2012 03:06:22 -0400
In-Reply-To: <1350198334-18737-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |   59 ++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 73505c1..6039ebe 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -55,8 +55,6 @@
 #define TX_IRQ(port)		((port)->line ? IRQ_UTXINT2 : IRQ_UTXINT1)
 #define RX_IRQ(port)		((port)->line ? IRQ_URXINT2 : IRQ_URXINT1)
 
-#define UART_ANY_ERR		(UARTDR_FRMERR | UARTDR_PARERR | UARTDR_OVERR)
-
 struct clps711x_port {
 	struct uart_driver	uart;
 	struct clk		*uart_clk;
@@ -99,54 +97,55 @@ static void clps711xuart_enable_ms(struct uart_port *port)
 static irqreturn_t clps711xuart_int_rx(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	struct tty_struct *tty = port->state->port.tty;
+	struct tty_struct *tty = tty_port_tty_get(&port->state->port);
 	unsigned int status, ch, flg;
 
-	status = clps_readl(SYSFLG(port));
-	while (!(status & SYSFLG_URXFE)) {
-		ch = clps_readl(UARTDR(port));
+	if (!tty)
+		return IRQ_HANDLED;
 
-		port->icount.rx++;
+	for (;;) {
+		status = clps_readl(SYSFLG(port));
+		if (status & SYSFLG_URXFE)
+			break;
 
+		ch = clps_readw(UARTDR(port));
+		status = ch & (UARTDR_FRMERR | UARTDR_PARERR | UARTDR_OVERR);
+		ch &= 0xff;
+
+		port->icount.rx++;
 		flg = TTY_NORMAL;
 
-		/*
-		 * Note that the error handling code is
-		 * out of the main execution path
-		 */
-		if (unlikely(ch & UART_ANY_ERR)) {
-			if (ch & UARTDR_PARERR)
+		if (unlikely(status)) {
+			if (status & UARTDR_PARERR)
 				port->icount.parity++;
-			else if (ch & UARTDR_FRMERR)
+			else if (status & UARTDR_FRMERR)
 				port->icount.frame++;
-			if (ch & UARTDR_OVERR)
+			else if (status & UARTDR_OVERR)
 				port->icount.overrun++;
 
-			ch &= port->read_status_mask;
+			status &= port->read_status_mask;
 
-			if (ch & UARTDR_PARERR)
+			if (status & UARTDR_PARERR)
 				flg = TTY_PARITY;
-			else if (ch & UARTDR_FRMERR)
+			else if (status & UARTDR_FRMERR)
 				flg = TTY_FRAME;
-
-#ifdef SUPPORT_SYSRQ
-			port->sysrq = 0;
-#endif
+			else if (status & UARTDR_OVERR)
+				flg = TTY_OVERRUN;
 		}
 
 		if (uart_handle_sysrq_char(port, ch))
-			goto ignore_char;
+			continue;
 
-		/*
-		 * CHECK: does overrun affect the current character?
-		 * ASSUMPTION: it does not.
-		 */
-		uart_insert_char(port, ch, UARTDR_OVERR, ch, flg);
+		if (status & port->ignore_status_mask)
+			continue;
 
-	ignore_char:
-		status = clps_readl(SYSFLG(port));
+		uart_insert_char(port, status, UARTDR_OVERR, ch, flg);
 	}
+
 	tty_flip_buffer_push(tty);
+
+	tty_kref_put(tty);
+
 	return IRQ_HANDLED;
 }
 
-- 
1.7.8.6

