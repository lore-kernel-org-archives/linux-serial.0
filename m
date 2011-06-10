From: Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] serial: bcm63xx_uart: fix irq storm after rx fifo overrun.
Date: Fri, 10 Jun 2011 23:17:58 +0200
Message-ID: <1307740678.30618.67.camel@sakura.staff.proxad.net>
Reply-To: mbizon@freebox.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:49092 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757627Ab1FJVSH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Jun 2011 17:18:07 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-serial@vger.kernel.org


RX fifo reset is required to clear irq.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/tty/serial/bcm63xx_uart.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index a1a0e55..c0b68b9 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -250,6 +250,20 @@ static void bcm_uart_do_rx(struct uart_port *port)
 		/* get overrun/fifo empty information from ier
 		 * register */
 		iestat = bcm_uart_readl(port, UART_IR_REG);
+
+		if (unlikely(iestat & UART_IR_STAT(UART_IR_RXOVER))) {
+			unsigned int val;
+
+			/* fifo reset is required to clear
+			 * interrupt */
+			val = bcm_uart_readl(port, UART_CTL_REG);
+			val |= UART_CTL_RSTRXFIFO_MASK;
+			bcm_uart_writel(port, val, UART_CTL_REG);
+
+			port->icount.overrun++;
+			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+		}
+
 		if (!(iestat & UART_IR_STAT(UART_IR_RXNOTEMPTY)))
 			break;
 
@@ -284,10 +298,6 @@ static void bcm_uart_do_rx(struct uart_port *port)
 		if (uart_handle_sysrq_char(port, c))
 			continue;
 
-		if (unlikely(iestat & UART_IR_STAT(UART_IR_RXOVER))) {
-			port->icount.overrun++;
-			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
-		}
 
 		if ((cstat & port->ignore_status_mask) == 0)
 			tty_insert_flip_char(tty, c, flag);
-- 
1.7.1.1


-- 
Maxime


