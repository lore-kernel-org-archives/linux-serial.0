From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX 2/6] tty: xuartps: Refactor IRQ handling
Date: Mon, 11 Jan 2016 17:41:37 -0800
Message-ID: <1452562901-17848-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

The system could deadlock handling RX IRQs when RX-related IRQ
conditions became true while the receiver was disabled. To avoid this,
enable/disable the RX/TX IRQs together with the receiver/transmitter.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 5da1c51e9e40..a0039cbcf812 100644
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
 
@@ -272,7 +276,8 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	 */
 	isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
 
-	cdns_uart_handle_rx(port, isrstatus);
+	if (isrstatus & CDNS_UART_RX_IRQS)
+		cdns_uart_handle_rx(port, isrstatus);
 
 	/* Dispatch an appropriate handler */
 	if ((isrstatus & CDNS_UART_IXR_TXEMPTY) == CDNS_UART_IXR_TXEMPTY) {
@@ -580,9 +585,12 @@ static void cdns_uart_stop_rx(struct uart_port *port)
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
 
@@ -820,10 +828,7 @@ static int cdns_uart_startup(struct uart_port *port)
 	}
 
 	/* Set the Interrupt Registers with desired interrupts */
-	writel(CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_PARITY |
-		CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN |
-		CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT,
-		port->membase + CDNS_UART_IER_OFFSET);
+	writel(CDNS_UART_RX_IRQS, port->membase + CDNS_UART_IER_OFFSET);
 
 	return 0;
 }
-- 
2.7.0.3.g497ea1e
