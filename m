From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH v2 08/10] tty: xuartps: Move RX path into helper function
Date: Wed, 4 Nov 2015 23:21:17 -0800
Message-ID: <1446708079-1105-9-git-send-email-soren.brinkmann@xilinx.com>
References: <1446708079-1105-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446708079-1105-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Move RX-related IRQ handling into a helper function.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 50 +++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 7fd226d65496..aa1176e6661a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -172,28 +172,8 @@ struct cdns_uart {
 #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
 		clk_rate_change_nb);
 
-/**
- * cdns_uart_isr - Interrupt handler
- * @irq: Irq number
- * @dev_id: Id of the port
- *
- * Return: IRQHANDLED
- */
-static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
+static void cdns_uart_handle_rx(struct uart_port *port, unsigned int isrstatus)
 {
-	struct uart_port *port = (struct uart_port *)dev_id;
-	unsigned long flags;
-	unsigned int isrstatus, numbytes;
-	unsigned int data;
-	char status = TTY_NORMAL;
-
-	spin_lock_irqsave(&port->lock, flags);
-
-	/* Read the interrupt status register to determine which
-	 * interrupt(s) is/are active.
-	 */
-	isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
-
 	/*
 	 * There is no hardware break detection, so we interpret framing
 	 * error with all-zeros data as a break sequence. Most of the time,
@@ -223,6 +203,9 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 		/* Receive Timeout Interrupt */
 		while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
 					CDNS_UART_SR_RXEMPTY)) {
+			u32 data;
+			char status = TTY_NORMAL;
+
 			data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
 
 			/* Non-NULL byte after BREAK is garbage (99%) */
@@ -263,10 +246,33 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 			}
 
 			uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
-					data, status);
+					 data, status);
 		}
 		tty_flip_buffer_push(&port->state->port);
 	}
+}
+
+/**
+ * cdns_uart_isr - Interrupt handler
+ * @irq: Irq number
+ * @dev_id: Id of the port
+ *
+ * Return: IRQHANDLED
+ */
+static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
+{
+	struct uart_port *port = (struct uart_port *)dev_id;
+	unsigned long flags;
+	unsigned int isrstatus, numbytes;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* Read the interrupt status register to determine which
+	 * interrupt(s) is/are active.
+	 */
+	isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
+
+	cdns_uart_handle_rx(port, isrstatus);
 
 	/* Dispatch an appropriate handler */
 	if ((isrstatus & CDNS_UART_IXR_TXEMPTY) == CDNS_UART_IXR_TXEMPTY) {
-- 
2.6.2.3.ga463a5b
