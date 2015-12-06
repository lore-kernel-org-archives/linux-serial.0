From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v4 05/13] tty: xuartps: Improve startup function
Date: Sat, 5 Dec 2015 20:39:21 -0800
Message-ID: <1449376769-13369-6-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The startup function is supposed to initialize the UART for receiving.
Hence, don't enable the TX part. Also, protect HW accesses with the port
lock.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/xilinx_uartps.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index ef114d7a0623..6ffd3bbe3e18 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -758,6 +758,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
  */
 static int cdns_uart_startup(struct uart_port *port)
 {
+	unsigned long flags;
 	unsigned int retval = 0, status = 0;
 
 	retval = request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME,
@@ -765,6 +766,8 @@ static int cdns_uart_startup(struct uart_port *port)
 	if (retval)
 		return retval;
 
+	spin_lock_irqsave(&port->lock, flags);
+
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
 			port->membase + CDNS_UART_CR_OFFSET);
@@ -775,15 +778,14 @@ static int cdns_uart_startup(struct uart_port *port)
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
@@ -814,6 +816,8 @@ static int cdns_uart_startup(struct uart_port *port)
 		CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT,
 		port->membase + CDNS_UART_IER_OFFSET);
 
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	return retval;
 }
 
-- 
2.6.3.3.g9bb996a
