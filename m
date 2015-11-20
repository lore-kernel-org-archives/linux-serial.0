From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 1/3] serial: xuartps: Spliting the ISR into smaller
 routines.
Date: Fri, 20 Nov 2015 19:04:36 +0530
Message-ID: <1448026478-22131-1-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jslaby@suse.com, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, anirudh@xilinx.com
Cc: Nava kishore Manne <navam@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Breaking the single big ISR that has both Rx and Tx
in a single function into smaller ones

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v2:
	--Splits up the ISR without any functional changes as suggested
	by Peter Hurley

 drivers/tty/serial/xilinx_uartps.c | 247 ++++++++++++++++++++-----------------
 1 file changed, 135 insertions(+), 112 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 009e0db..2e1b0a8 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -172,6 +172,9 @@ struct cdns_uart {
 #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
 		clk_rate_change_nb);
 
+static void cdns_uart_handle_tx(void *dev_id);
+static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus);
+
 /**
  * cdns_uart_isr - Interrupt handler
  * @irq: Irq number
@@ -183,9 +186,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
 	unsigned long flags;
-	unsigned int isrstatus, numbytes;
-	unsigned int data;
-	char status = TTY_NORMAL;
+	unsigned int isrstatus;
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -194,116 +195,12 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	 */
 	isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
 
-	/*
-	 * There is no hardware break detection, so we interpret framing
-	 * error with all-zeros data as a break sequence. Most of the time,
-	 * there's another non-zero byte at the end of the sequence.
-	 */
-	if (isrstatus & CDNS_UART_IXR_FRAMING) {
-		while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
-					CDNS_UART_SR_RXEMPTY)) {
-			if (!readl(port->membase + CDNS_UART_FIFO_OFFSET)) {
-				port->read_status_mask |= CDNS_UART_IXR_BRK;
-				isrstatus &= ~CDNS_UART_IXR_FRAMING;
-			}
-		}
-		writel(CDNS_UART_IXR_FRAMING,
-				port->membase + CDNS_UART_ISR_OFFSET);
-	}
-
-	/* drop byte with parity error if IGNPAR specified */
-	if (isrstatus & port->ignore_status_mask & CDNS_UART_IXR_PARITY)
-		isrstatus &= ~(CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT);
-
-	isrstatus &= port->read_status_mask;
-	isrstatus &= ~port->ignore_status_mask;
-
-	if ((isrstatus & CDNS_UART_IXR_TOUT) ||
-		(isrstatus & CDNS_UART_IXR_RXTRIG)) {
-		/* Receive Timeout Interrupt */
-		while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
-					CDNS_UART_SR_RXEMPTY)) {
-			data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
-
-			/* Non-NULL byte after BREAK is garbage (99%) */
-			if (data && (port->read_status_mask &
-						CDNS_UART_IXR_BRK)) {
-				port->read_status_mask &= ~CDNS_UART_IXR_BRK;
-				port->icount.brk++;
-				if (uart_handle_break(port))
-					continue;
-			}
-
-#ifdef SUPPORT_SYSRQ
-			/*
-			 * uart_handle_sysrq_char() doesn't work if
-			 * spinlocked, for some reason
-			 */
-			 if (port->sysrq) {
-				spin_unlock(&port->lock);
-				if (uart_handle_sysrq_char(port,
-							(unsigned char)data)) {
-					spin_lock(&port->lock);
-					continue;
-				}
-				spin_lock(&port->lock);
-			}
-#endif
-
-			port->icount.rx++;
-
-			if (isrstatus & CDNS_UART_IXR_PARITY) {
-				port->icount.parity++;
-				status = TTY_PARITY;
-			} else if (isrstatus & CDNS_UART_IXR_FRAMING) {
-				port->icount.frame++;
-				status = TTY_FRAME;
-			} else if (isrstatus & CDNS_UART_IXR_OVERRUN) {
-				port->icount.overrun++;
-			}
-
-			uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
-					data, status);
-		}
-		spin_unlock(&port->lock);
-		tty_flip_buffer_push(&port->state->port);
-		spin_lock(&port->lock);
-	}
-
-	/* Dispatch an appropriate handler */
-	if ((isrstatus & CDNS_UART_IXR_TXEMPTY) == CDNS_UART_IXR_TXEMPTY) {
-		if (uart_circ_empty(&port->state->xmit)) {
-			writel(CDNS_UART_IXR_TXEMPTY,
-					port->membase + CDNS_UART_IDR_OFFSET);
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
-					port->membase + CDNS_UART_FIFO_OFFSET);
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
+	if (isrstatus & CDNS_UART_IXR_TXEMPTY) {
+		cdns_uart_handle_tx(dev_id);
+		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
+	if (isrstatus & CDNS_UART_IXR_MASK)
+		cdns_uart_handle_rx(dev_id, isrstatus);
 
 	writel(isrstatus, port->membase + CDNS_UART_ISR_OFFSET);
 
@@ -408,6 +305,132 @@ static unsigned int cdns_uart_set_baud_rate(struct uart_port *port,
 	return calc_baud;
 }
 
+/**
+ * cdns_uart_handle_tx - Handle the bytes to be Txed.
+ * @dev_id: Id of the UART port
+ * Return: None
+ */
+static void cdns_uart_handle_tx(void *dev_id)
+{
+	struct uart_port *port = (struct uart_port *)dev_id;
+	unsigned int numbytes;
+
+	if (uart_circ_empty(&port->state->xmit)) {
+		writel(CDNS_UART_IXR_TXEMPTY,
+			port->membase + CDNS_UART_IDR_OFFSET);
+	} else {
+		numbytes = port->fifosize;
+		/* Break if no more data available in the UART buffer */
+		while (numbytes--) {
+			if (uart_circ_empty(&port->state->xmit))
+				break;
+			/* Get the data from the UART circular buffer
+			 * and write it to the cdns_uart's TX_FIFO
+			 * register.
+			 */
+			writel(port->state->xmit.buf[port->state->xmit.tail],
+				port->membase + CDNS_UART_FIFO_OFFSET);
+			port->icount.tx++;
+
+			/* Adjust the tail of the UART buffer and wrap
+			 * the buffer if it reaches limit.
+			 */
+			port->state->xmit.tail = (port->state->xmit.tail + 1) &
+							(UART_XMIT_SIZE - 1);
+		}
+
+		if (uart_circ_chars_pending(&port->state->xmit) < WAKEUP_CHARS)
+			uart_write_wakeup(port);
+	}
+}
+
+/**
+ * cdns_uart_handle_rx - Handle the received bytes along with Rx errors.
+ * @dev_id: Id of the UART port
+ * @isrstatus: The interrupt status register value as read
+ * Return: None
+ */
+static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
+{
+	struct uart_port *port = (struct uart_port *)dev_id;
+	unsigned int data;
+	char status = TTY_NORMAL;
+
+	/*
+	 * There is no hardware break detection, so we interpret framing
+	 * error with all-zeros data as a break sequence. Most of the time,
+	 * there's another non-zero byte at the end of the sequence.
+	 */
+	if (isrstatus & CDNS_UART_IXR_FRAMING) {
+		while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
+			CDNS_UART_SR_RXEMPTY)) {
+			if (!readl(port->membase + CDNS_UART_FIFO_OFFSET)) {
+				port->read_status_mask |= CDNS_UART_IXR_BRK;
+				isrstatus &= ~CDNS_UART_IXR_FRAMING;
+			}
+		}
+		writel(CDNS_UART_IXR_FRAMING,
+			port->membase + CDNS_UART_ISR_OFFSET);
+	}
+
+	/* drop byte with parity error if IGNPAR specified */
+	if (isrstatus & port->ignore_status_mask & CDNS_UART_IXR_PARITY)
+		isrstatus &= ~(CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT);
+
+	isrstatus &= port->read_status_mask;
+	isrstatus &= ~port->ignore_status_mask;
+	if ((isrstatus & CDNS_UART_IXR_TOUT) ||
+		(isrstatus & CDNS_UART_IXR_RXTRIG)) {
+		/* Receive Timeout Interrupt */
+		while ((readl(port->membase + CDNS_UART_SR_OFFSET) &
+			CDNS_UART_SR_RXEMPTY) != CDNS_UART_SR_RXEMPTY) {
+			data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
+
+			/* Non-NULL byte after BREAK is garbage (99%) */
+			if (data && (port->read_status_mask
+						&CDNS_UART_IXR_BRK)) {
+				port->read_status_mask &= ~CDNS_UART_IXR_BRK;
+				port->icount.brk++;
+				if (uart_handle_break(port))
+					continue;
+			}
+
+#ifdef SUPPORT_SYSRQ
+			/*
+			 * uart_handle_sysrq_char() doesn't work if
+			 * spinlocked, for some reason
+			 */
+			if (port->sysrq) {
+				spin_unlock(&port->lock);
+				if (uart_handle_sysrq_char(port,
+						(unsigned char)data)) {
+					spin_lock(&port->lock);
+					continue;
+				}
+				spin_lock(&port->lock);
+			}
+#endif
+
+			port->icount.rx++;
+
+			if (isrstatus & CDNS_UART_IXR_PARITY) {
+				port->icount.parity++;
+				status = TTY_PARITY;
+			} else if (isrstatus & CDNS_UART_IXR_FRAMING) {
+				port->icount.frame++;
+				status = TTY_FRAME;
+			} else if (isrstatus & CDNS_UART_IXR_OVERRUN) {
+				port->icount.overrun++;
+			}
+
+			uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
+								data, status);
+		}
+		spin_unlock(&port->lock);
+		tty_flip_buffer_push(&port->state->port);
+		spin_lock(&port->lock);
+}
+}
 #ifdef CONFIG_COMMON_CLK
 /**
  * cdns_uart_clk_notitifer_cb - Clock notifier callback
-- 
2.1.2
