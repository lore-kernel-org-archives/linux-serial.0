From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 1/9] tty: xuartps: Beautify read-modify writes
Date: Tue, 3 Nov 2015 16:20:42 -0800
Message-ID: <1446596450-20918-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Non-functional, formatting changes to ease reading the code.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
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
2.6.2.3.ga463a5b
