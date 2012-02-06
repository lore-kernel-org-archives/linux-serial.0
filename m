From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 2/3] serial: pch_uart: trivial cleanup by removing the get_msr()
Date: Mon,  6 Feb 2012 17:24:44 +0800
Message-ID: <1328520285-10826-2-git-send-email-feng.tang@intel.com>
References: <1328520285-10826-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34694 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754205Ab2BFJZo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Feb 2012 04:25:44 -0500
In-Reply-To: <1328520285-10826-1-git-send-email-feng.tang@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com, tomoya.rohm@gmail.com
Cc: Feng Tang <feng.tang@intel.com>

The short get_msr() has some unnecessary code and only used once,
so merge it with its caller to make code cleaner. No functional
change at all.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/tty/serial/pch_uart.c |   29 ++++++++---------------------
 1 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6d9ca29..811edcb 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -373,14 +373,6 @@ static void pch_uart_hal_request(struct pci_dev *pdev, int fifosize,
 	priv->fcr = 0;
 }
 
-static unsigned int get_msr(struct eg20t_port *priv, void __iomem *base)
-{
-	unsigned int msr = ioread8(base + UART_MSR);
-	priv->dmsr |= msr & PCH_UART_MSR_DELTA;
-
-	return msr;
-}
-
 static void pch_uart_hal_enable_interrupt(struct eg20t_port *priv,
 					  unsigned int flag)
 {
@@ -514,8 +506,9 @@ static int pch_uart_hal_set_fifo(struct eg20t_port *priv,
 
 static u8 pch_uart_hal_get_modem(struct eg20t_port *priv)
 {
-	priv->dmsr = 0;
-	return get_msr(priv, priv->membase);
+	unsigned int msr = ioread8(priv->membase + UART_MSR);
+	priv->dmsr = msr & PCH_UART_MSR_DELTA;
+	return (u8)msr;
 }
 
 static void pch_uart_hal_write(struct eg20t_port *priv,
@@ -596,7 +589,7 @@ static int push_rx(struct eg20t_port *priv, const unsigned char *buf,
 
 static int pop_tx_x(struct eg20t_port *priv, unsigned char *buf)
 {
-	int ret;
+	int ret = 0;
 	struct uart_port *port = &priv->port;
 
 	if (port->x_char) {
@@ -605,8 +598,6 @@ static int pop_tx_x(struct eg20t_port *priv, unsigned char *buf)
 		buf[0] = port->x_char;
 		port->x_char = 0;
 		ret = 1;
-	} else {
-		ret = 0;
 	}
 
 	return ret;
@@ -1104,14 +1095,12 @@ static irqreturn_t pch_uart_interrupt(int irq, void *dev_id)
 static unsigned int pch_uart_tx_empty(struct uart_port *port)
 {
 	struct eg20t_port *priv;
-	int ret;
+
 	priv = container_of(port, struct eg20t_port, port);
 	if (priv->tx_empty)
-		ret = TIOCSER_TEMT;
+		return TIOCSER_TEMT;
 	else
-		ret = 0;
-
-	return ret;
+		return 0;
 }
 
 /* Returns the current state of modem control inputs. */
@@ -1345,9 +1334,8 @@ static void pch_uart_set_termios(struct uart_port *port,
 		else
 			parity = PCH_UART_HAL_PARITY_EVEN;
 
-	} else {
+	} else
 		parity = PCH_UART_HAL_PARITY_NONE;
-	}
 
 	/* Only UART0 has auto hardware flow function */
 	if ((termios->c_cflag & CRTSCTS) && (priv->fifo_size == 256))
@@ -1519,7 +1507,6 @@ static void
 pch_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct eg20t_port *priv;
-
 	unsigned long flags;
 	u8 ier;
 	int locked = 1;
-- 
1.7.1

