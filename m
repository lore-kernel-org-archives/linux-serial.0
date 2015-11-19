From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATH RESEND v2 09/10] tty: xuartps: Only handle RX IRQs when RX is
 enabled
Date: Thu, 19 Nov 2015 12:02:23 -0800
Message-ID: <1447963344-16266-10-git-send-email-soren.brinkmann@xilinx.com>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
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
Cc: linux-arm-kernel@lists.infradead.org, Soren Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Ignore RX-related interrupts if RX is not enabled.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index aa1176e6661a..413229661f5d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -161,6 +161,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @pclk:		APB clock
  * @baud:		Current baud rate
  * @clk_rate_change_nb:	Notifier block for clock changes
+ * @flags:		Driver flags
  */
 struct cdns_uart {
 	struct uart_port	*port;
@@ -168,7 +169,11 @@ struct cdns_uart {
 	struct clk		*pclk;
 	unsigned int		baud;
 	struct notifier_block	clk_rate_change_nb;
+	u32			flags;
 };
+
+#define CDNS_FLAG_RX_ENABLED	BIT(0)
+
 #define to_cdns_uart(_nb) container_of(_nb, struct cdns_uart, \
 		clk_rate_change_nb);
 
@@ -262,6 +267,7 @@ static void cdns_uart_handle_rx(struct uart_port *port, unsigned int isrstatus)
 static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 {
 	struct uart_port *port = (struct uart_port *)dev_id;
+	struct cdns_uart *cdns_uart = port->private_data;
 	unsigned long flags;
 	unsigned int isrstatus, numbytes;
 
@@ -272,7 +278,8 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	 */
 	isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
 
-	cdns_uart_handle_rx(port, isrstatus);
+	if (cdns_uart->flags & CDNS_FLAG_RX_ENABLED)
+		cdns_uart_handle_rx(port, isrstatus);
 
 	/* Dispatch an appropriate handler */
 	if ((isrstatus & CDNS_UART_IXR_TXEMPTY) == CDNS_UART_IXR_TXEMPTY) {
@@ -576,11 +583,13 @@ static void cdns_uart_stop_tx(struct uart_port *port)
 static void cdns_uart_stop_rx(struct uart_port *port)
 {
 	unsigned int regval;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	regval = readl(port->membase + CDNS_UART_CR_OFFSET);
 	regval |= CDNS_UART_CR_RX_DIS;
 	/* Disable the receiver */
 	writel(regval, port->membase + CDNS_UART_CR_OFFSET);
+	cdns_uart->flags &= ~CDNS_FLAG_RX_ENABLED;
 }
 
 /**
@@ -761,6 +770,7 @@ static int cdns_uart_startup(struct uart_port *port)
 {
 	unsigned long flags;
 	unsigned int retval = 0, status = 0;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	retval = request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME,
 								(void *)port);
@@ -787,6 +797,7 @@ static int cdns_uart_startup(struct uart_port *port)
 	status &= CDNS_UART_CR_RX_DIS;
 	status |= CDNS_UART_CR_RX_EN;
 	writel(status, port->membase + CDNS_UART_CR_OFFSET);
+	cdns_uart->flags |= CDNS_FLAG_RX_ENABLED;
 
 	/* Set the Mode Register with normal mode,8 data bits,1 stop bit,
 	 * no parity.
@@ -830,6 +841,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
 {
 	int status;
 	unsigned long flags;
+	struct cdns_uart *cdns_uart = port->private_data;
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -841,6 +853,7 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
 			port->membase + CDNS_UART_CR_OFFSET);
+	cdns_uart->flags &= ~CDNS_FLAG_RX_ENABLED;
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.6.3.3.g9bb996a
