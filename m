From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX 6/6] tty: xuartps: Consolidate TX handling
Date: Mon, 11 Jan 2016 17:41:41 -0800
Message-ID: <1452562901-17848-7-git-send-email-soren.brinkmann@xilinx.com>
References: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
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
Cc: Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

start_tx and the ISR used largely identical code to transmit data.
Consolidate that in one place.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 97 ++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 57 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 3ff6e3c2347c..131a3117fbbb 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -239,6 +239,41 @@ static void cdns_uart_handle_rx(struct uart_port *port, unsigned int isrstatus)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static void cdns_uart_handle_tx(struct uart_port *port)
+{
+	unsigned int numbytes;
+
+	if (uart_circ_empty(&port->state->xmit)) {
+		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
+		return;
+	}
+
+	numbytes = port->fifosize;
+	while (numbytes && !uart_circ_empty(&port->state->xmit) &&
+	       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
+		/*
+		 * Get the data from the UART circular buffer
+		 * and write it to the cdns_uart's TX_FIFO
+		 * register.
+		 */
+		writel(port->state->xmit.buf[port->state->xmit.tail],
+			port->membase + CDNS_UART_FIFO);
+		port->icount.tx++;
+
+		/*
+		 * Adjust the tail of the UART buffer and wrap
+		 * the buffer if it reaches limit.
+		 */
+		port->state->xmit.tail =
+			(port->state->xmit.tail + 1) & (UART_XMIT_SIZE - 1);
+
+		numbytes--;
+	}
+
+	if (uart_circ_chars_pending(&port->state->xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
+
 /**
  * cdns_uart_isr - Interrupt handler
  * @irq: Irq number
@@ -250,7 +285,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
 	unsigned long flags;
-	unsigned int isrstatus, numbytes;
+	unsigned int isrstatus;
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -262,40 +297,8 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	if (isrstatus & CDNS_UART_RX_IRQS)
 		cdns_uart_handle_rx(port, isrstatus);
 
-	/* Dispatch an appropriate handler */
-	if ((isrstatus & CDNS_UART_IXR_TXEMPTY) == CDNS_UART_IXR_TXEMPTY) {
-		if (uart_circ_empty(&port->state->xmit)) {
-			writel(CDNS_UART_IXR_TXEMPTY,
-					port->membase + CDNS_UART_IDR);
-		} else {
-			numbytes = port->fifosize;
-			/* Break if no more data available in the UART buffer */
-			while (numbytes--) {
-				if (uart_circ_empty(&port->state->xmit))
-					break;
-				/* Get the data from the UART circular buffer
-				 * and write it to the cdns_uart's TX_FIFO
-				 * register.
-				 */
-				writel(port->state->xmit.buf[
-						port->state->xmit.tail],
-					port->membase + CDNS_UART_FIFO);
-
-				port->icount.tx++;
-
-				/* Adjust the tail of the UART buffer and wrap
-				 * the buffer if it reaches limit.
-				 */
-				port->state->xmit.tail =
-					(port->state->xmit.tail + 1) &
-						(UART_XMIT_SIZE - 1);
-			}
-
-			if (uart_circ_chars_pending(
-					&port->state->xmit) < WAKEUP_CHARS)
-				uart_write_wakeup(port);
-		}
-	}
+	if ((isrstatus & CDNS_UART_IXR_TXEMPTY) == CDNS_UART_IXR_TXEMPTY)
+		cdns_uart_handle_tx(port);
 
 	writel(isrstatus, port->membase + CDNS_UART_ISR);
 
@@ -502,7 +505,7 @@ static int cdns_uart_clk_notifier_cb(struct notifier_block *nb,
  */
 static void cdns_uart_start_tx(struct uart_port *port)
 {
-	unsigned int status, numbytes = port->fifosize;
+	unsigned int status;
 
 	if (uart_tx_stopped(port))
 		return;
@@ -519,31 +522,11 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	if (uart_circ_empty(&port->state->xmit))
 		return;
 
-	while (numbytes-- && ((readl(port->membase + CDNS_UART_SR) &
-				CDNS_UART_SR_TXFULL)) != CDNS_UART_SR_TXFULL) {
-		/* Break if no more data available in the UART buffer */
-		if (uart_circ_empty(&port->state->xmit))
-			break;
-
-		/* Get the data from the UART circular buffer and
-		 * write it to the cdns_uart's TX_FIFO register.
-		 */
-		writel(port->state->xmit.buf[port->state->xmit.tail],
-				port->membase + CDNS_UART_FIFO);
-		port->icount.tx++;
+	cdns_uart_handle_tx(port);
 
-		/* Adjust the tail of the UART buffer and wrap
-		 * the buffer if it reaches limit.
-		 */
-		port->state->xmit.tail = (port->state->xmit.tail + 1) &
-					(UART_XMIT_SIZE - 1);
-	}
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_ISR);
 	/* Enable the TX Empty interrupt */
 	writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IER);
-
-	if (uart_circ_chars_pending(&port->state->xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
 }
 
 /**
-- 
2.7.0.3.g497ea1e
