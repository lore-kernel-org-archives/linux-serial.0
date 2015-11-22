From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v3 02/10] tty: xuartps: Use spinlock to serialize HW
 access
Date: Sat, 21 Nov 2015 18:59:24 -0800
Message-ID: <1448161172-19717-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
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

Instead of disabling the IRQ, use the spin lock to serialize accesses to
the HW. This protects the driver from interference of non-IRQ callbacks
with each other and makes the driver more consistent in its
serialization method.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 50d4082d2354..2c98c357d9a0 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -945,12 +945,10 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 #ifdef CONFIG_CONSOLE_POLL
 static int cdns_uart_poll_get_char(struct uart_port *port)
 {
-	u32 imr;
 	int c;
+	unsigned long flags;
 
-	/* Disable all interrupts */
-	imr = readl(port->membase + CDNS_UART_IMR_OFFSET);
-	writel(imr, port->membase + CDNS_UART_IDR_OFFSET);
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Check if FIFO is empty */
 	if (readl(port->membase + CDNS_UART_SR_OFFSET) & CDNS_UART_SR_RXEMPTY)
@@ -959,19 +957,16 @@ static int cdns_uart_poll_get_char(struct uart_port *port)
 		c = (unsigned char) readl(
 					port->membase + CDNS_UART_FIFO_OFFSET);
 
-	/* Enable interrupts */
-	writel(imr, port->membase + CDNS_UART_IER_OFFSET);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	return c;
 }
 
 static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	u32 imr;
+	unsigned long flags;
 
-	/* Disable all interrupts */
-	imr = readl(port->membase + CDNS_UART_IMR_OFFSET);
-	writel(imr, port->membase + CDNS_UART_IDR_OFFSET);
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Wait until FIFO is empty */
 	while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
@@ -986,8 +981,7 @@ static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 				CDNS_UART_SR_TXEMPTY))
 		cpu_relax();
 
-	/* Enable interrupts */
-	writel(imr, port->membase + CDNS_UART_IER_OFFSET);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	return;
 }
-- 
2.6.3.3.g9bb996a
