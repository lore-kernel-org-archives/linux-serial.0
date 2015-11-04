From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 5/9] tty: xuartps: Improve startup function
Date: Tue, 3 Nov 2015 16:20:46 -0800
Message-ID: <1446596450-20918-6-git-send-email-soren.brinkmann@xilinx.com>
References: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

The startup function is supposed to initialize the UART for receiving.
Hence, don't enable the TX part. Also, protect HW accesses with the port
lock.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 738df6bb2646..b189e600d4ab 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -755,6 +755,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
  */
 static int cdns_uart_startup(struct uart_port *port)
 {
+	unsigned long flags;
 	unsigned int retval = 0, status = 0;
 
 	retval = request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME,
@@ -762,6 +763,8 @@ static int cdns_uart_startup(struct uart_port *port)
 	if (retval)
 		return retval;
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
 			port->membase + CDNS_UART_CR_OFFSET);
@@ -772,15 +775,14 @@ static int cdns_uart_startup(struct uart_port *port)
 	writel(CDNS_UART_CR_TXRST | CDNS_UART_CR_RXRST,
 			port->membase + CDNS_UART_CR_OFFSET);
 
-	status = readl(port->membase + CDNS_UART_CR_OFFSET);
-
-	/* Clear the RX disable and TX disable bits and then set the TX enable
-	 * bit and RX enable bit to enable the transmitter and receiver.
+	/*
+	 * Clear the RX disable bit and then set the RX enable bit to enable
+	 * the receiver.
 	 */
-	writel((status & ~(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS))
-			| (CDNS_UART_CR_TX_EN | CDNS_UART_CR_RX_EN |
-			CDNS_UART_CR_STOPBRK),
-			port->membase + CDNS_UART_CR_OFFSET);
+	status = readl(port->membase + CDNS_UART_CR_OFFSET);
+	status &= CDNS_UART_CR_RX_DIS;
+	status |= CDNS_UART_CR_RX_EN;
+	writel(status, port->membase + CDNS_UART_CR_OFFSET);
 
 	/* Set the Mode Register with normal mode,8 data bits,1 stop bit,
 	 * no parity.
@@ -811,6 +813,8 @@ static int cdns_uart_startup(struct uart_port *port)
 		CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT,
 		port->membase + CDNS_UART_IER_OFFSET);
 
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	return retval;
 }
 
-- 
2.6.2.3.ga463a5b
