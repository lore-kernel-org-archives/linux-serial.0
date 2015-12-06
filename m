From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v4 10/13] tty: xuartps: Refactor IRQ handling
Date: Sat, 5 Dec 2015 20:39:26 -0800
Message-ID: <1449376769-13369-11-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Moritz Fischer <moritz.fischer@ettus.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

The system could deadlock handling RX IRQs when RX-related IRQ
conditions became true while the receiver was disabled. To avoid this,
enable/disable the RX/TX IRQs together with the receiver/transmitter.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 3780d1cf207e..1229bb3a275e 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -126,6 +126,10 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 #define CDNS_UART_IXR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt. */
 #define CDNS_UART_IXR_MASK	0x00001FFF /* Valid bit mask */
 
+#define CDNS_UART_RX_IRQS	(CDNS_UART_IXR_PARITY | CDNS_UART_IXR_FRAMING | \
+				 CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_RXTRIG | \
+				 CDNS_UART_IXR_TOUT)
+
 /* Goes in read_status_mask for break detection as the HW doesn't do it*/
 #define CDNS_UART_IXR_BRK	0x80000000
 
@@ -169,6 +173,7 @@ struct cdns_uart {
 	unsigned int		baud;
 	struct notifier_block	clk_rate_change_nb;
 };
+
 #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
 		clk_rate_change_nb);
 
@@ -272,7 +277,8 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	 */
 	isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
 
-	cdns_uart_handle_rx(port, isrstatus);
+	if (isrstatus & CDNS_UART_RX_IRQS)
+		cdns_uart_handle_rx(port, isrstatus);
 
 	/* Dispatch an appropriate handler */
 	if ((isrstatus & CDNS_UART_IXR_TXEMPTY) == CDNS_UART_IXR_TXEMPTY) {
@@ -580,9 +586,12 @@ static void cdns_uart_stop_rx(struct uart_port *port)
 {
 	unsigned int regval;
 
+	/* Disable RX IRQs */
+	writel(CDNS_UART_RX_IRQS, port->membase + CDNS_UART_IDR_OFFSET);
+
+	/* Disable the receiver */
 	regval = readl(port->membase + CDNS_UART_CR_OFFSET);
 	regval |= CDNS_UART_CR_RX_DIS;
-	/* Disable the receiver */
 	writel(regval, port->membase + CDNS_UART_CR_OFFSET);
 }
 
@@ -810,10 +819,7 @@ static int cdns_uart_startup(struct uart_port *port)
 			port->membase + CDNS_UART_ISR_OFFSET);
 
 	/* Set the Interrupt Registers with desired interrupts */
-	writel(CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_PARITY |
-		CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN |
-		CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT,
-		port->membase + CDNS_UART_IER_OFFSET);
+	writel(CDNS_UART_RX_IRQS, port->membase + CDNS_UART_IER_OFFSET);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.6.3.3.g9bb996a
