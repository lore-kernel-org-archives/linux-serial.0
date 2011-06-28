From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/12] serial: bcm63xx_uart: fix irq storm after rx fifo overrun.
Date: Tue, 28 Jun 2011 09:03:49 -0700
Message-ID: <1309277029-1532-12-git-send-email-gregkh@suse.de>
References: <20110628153856.GB32710@kroah.com>
 <1309277029-1532-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58495 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759233Ab1F1QEJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 12:04:09 -0400
In-Reply-To: <1309277029-1532-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Maxime Bizon <mbizon@freebox.fr>, Greg Kroah-Hartman <gregkh@suse.de>

From: Maxime Bizon <mbizon@freebox.fr>

RX fifo reset is required to clear irq.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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
1.7.5.4

