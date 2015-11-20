From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 2/3] serial: xuartps: Rewrite the interrupt handling logic
Date: Fri, 20 Nov 2015 19:04:37 +0530
Message-ID: <1448026478-22131-2-git-send-email-navam@xilinx.com>
References: <1448026478-22131-1-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448026478-22131-1-git-send-email-navam@xilinx.com>
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

The existing interrupt handling logic has followins issues.
- Upon a parity error with default configuration, the control
  never comes out of the ISR thereby hanging Linux.
- The error handling logic around framing and parity error are buggy.
  There are chances that the errors will never be captured.
This patch fixes all these concerns.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v2:
	--Add required changes after spliting the ISR as suggested by
	Peter Hurley.

 drivers/tty/serial/xilinx_uartps.c | 64 ++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2e1b0a8..4d71478 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -191,9 +191,10 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Read the interrupt status register to determine which
-	 * interrupt(s) is/are active.
+	 * interrupt(s) is/are active and clear them.
 	 */
 	isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
+	writel(isrstatus, port->membase + CDNS_UART_ISR_OFFSET);
 
 	if (isrstatus & CDNS_UART_IXR_TXEMPTY) {
 		cdns_uart_handle_tx(dev_id);
@@ -202,8 +203,6 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	if (isrstatus & CDNS_UART_IXR_MASK)
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
-	writel(isrstatus, port->membase + CDNS_UART_ISR_OFFSET);
-
 	/* be sure to release the lock and tty before leaving */
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -354,37 +353,32 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
 	unsigned int data;
+	unsigned int framerrprocessed = 0;
 	char status = TTY_NORMAL;
 
-	/*
-	 * There is no hardware break detection, so we interpret framing
-	 * error with all-zeros data as a break sequence. Most of the time,
-	 * there's another non-zero byte at the end of the sequence.
-	 */
-	if (isrstatus & CDNS_UART_IXR_FRAMING) {
-		while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
-			CDNS_UART_SR_RXEMPTY)) {
-			if (!readl(port->membase + CDNS_UART_FIFO_OFFSET)) {
+	while ((readl(port->membase + CDNS_UART_SR_OFFSET) &
+		CDNS_UART_SR_RXEMPTY) != CDNS_UART_SR_RXEMPTY) {
+		data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
+		port->icount.rx++;
+
+		/*
+		 * There is no hardware break detection, so we interpret framing
+		 * error with all-zeros data as a break sequence. Most of the
+		 * time, there's another non-zero byte at the end of the
+		 * sequence.
+		 */
+		if (isrstatus & CDNS_UART_IXR_FRAMING) {
+			if (!data) {
 				port->read_status_mask |= CDNS_UART_IXR_BRK;
-				isrstatus &= ~CDNS_UART_IXR_FRAMING;
+				framerrprocessed = 1;
+				continue;
 			}
 		}
-		writel(CDNS_UART_IXR_FRAMING,
-			port->membase + CDNS_UART_ISR_OFFSET);
-	}
 
-	/* drop byte with parity error if IGNPAR specified */
-	if (isrstatus & port->ignore_status_mask & CDNS_UART_IXR_PARITY)
-		isrstatus &= ~(CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT);
-
-	isrstatus &= port->read_status_mask;
-	isrstatus &= ~port->ignore_status_mask;
-	if ((isrstatus & CDNS_UART_IXR_TOUT) ||
-		(isrstatus & CDNS_UART_IXR_RXTRIG)) {
-		/* Receive Timeout Interrupt */
-		while ((readl(port->membase + CDNS_UART_SR_OFFSET) &
-			CDNS_UART_SR_RXEMPTY) != CDNS_UART_SR_RXEMPTY) {
-			data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
+		isrstatus &= port->read_status_mask;
+		isrstatus &= ~port->ignore_status_mask;
+		if ((isrstatus & CDNS_UART_IXR_TOUT) ||
+			(isrstatus & CDNS_UART_IXR_RXTRIG)) {
 
 			/* Non-NULL byte after BREAK is garbage (99%) */
 			if (data && (port->read_status_mask
@@ -416,21 +410,25 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 			if (isrstatus & CDNS_UART_IXR_PARITY) {
 				port->icount.parity++;
 				status = TTY_PARITY;
-			} else if (isrstatus & CDNS_UART_IXR_FRAMING) {
+			}
+			if (isrstatus & CDNS_UART_IXR_FRAMING) {
 				port->icount.frame++;
 				status = TTY_FRAME;
-			} else if (isrstatus & CDNS_UART_IXR_OVERRUN) {
+			}
+			if (isrstatus & CDNS_UART_IXR_OVERRUN) {
 				port->icount.overrun++;
+				tty_insert_flip_char(&port->state->port, 0,
+								TTY_OVERRUN);
 			}
 
-			uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
-								data, status);
+			tty_insert_flip_char(&port->state->port, data, status);
 		}
+	}
 		spin_unlock(&port->lock);
 		tty_flip_buffer_push(&port->state->port);
 		spin_lock(&port->lock);
 }
-}
+
 #ifdef CONFIG_COMMON_CLK
 /**
  * cdns_uart_clk_notitifer_cb - Clock notifier callback
-- 
2.1.2
