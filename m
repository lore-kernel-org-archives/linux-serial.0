From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v5 1/8] tty: xuartps: Beautify read-modify writes
Date: Sat, 26 Dec 2015 02:43:49 -0800
Message-ID: <1451126636-13699-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1451126636-13699-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1451126636-13699-1-git-send-email-soren.brinkmann@xilinx.com>
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

Non-functional, formatting changes to ease reading the code.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 drivers/tty/serial/xilinx_uartps.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 009e0dbc12d2..50d4082d2354 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -515,12 +515,14 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	if (uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port))
 		return;
 
-	status = readl(port->membase + CDNS_UART_CR_OFFSET);
-	/* Set the TX enable bit and clear the TX disable bit to enable the
+	/*
+	 * Set the TX enable bit and clear the TX disable bit to enable the
 	 * transmitter.
 	 */
-	writel((status & ~CDNS_UART_CR_TX_DIS) | CDNS_UART_CR_TX_EN,
-			port->membase + CDNS_UART_CR_OFFSET);
+	status = readl(port->membase + CDNS_UART_CR_OFFSET);
+	status &= ~CDNS_UART_CR_TX_DIS;
+	status |= CDNS_UART_CR_TX_EN;
+	writel(status, port->membase + CDNS_UART_CR_OFFSET);
 
 	while (numbytes-- && ((readl(port->membase + CDNS_UART_SR_OFFSET) &
 				CDNS_UART_SR_TXFULL)) != CDNS_UART_SR_TXFULL) {
@@ -1123,8 +1125,9 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 	 * clear the TX disable bit to enable the transmitter.
 	 */
 	ctrl = readl(port->membase + CDNS_UART_CR_OFFSET);
-	writel((ctrl & ~CDNS_UART_CR_TX_DIS) | CDNS_UART_CR_TX_EN,
-			port->membase + CDNS_UART_CR_OFFSET);
+	ctrl &= ~CDNS_UART_CR_TX_DIS;
+	ctrl |= CDNS_UART_CR_TX_EN;
+	writel(ctrl, port->membase + CDNS_UART_CR_OFFSET);
 
 	uart_console_write(port, s, count, cdns_uart_console_putchar);
 	cdns_uart_console_wait_tx(port);
-- 
2.6.3.3.g9bb996a
