From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 3/9] tty: xuartps: Always enable transmitter in start_tx
Date: Tue, 3 Nov 2015 16:20:44 -0800
Message-ID: <1446596450-20918-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

start_tx must start transmitting characters. Regardless of the state of
the circular buffer, always enable the transmitter hardware.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index dc1987f3dc0a..5edd1efca015 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -512,9 +512,6 @@ static void cdns_uart_start_tx(struct uart_port *port)
 {
 	unsigned int status, numbytes = port->fifosize;
 
-	if (uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port))
-		return;
-
 	/*
 	 * Set the TX enable bit and clear the TX disable bit to enable the
 	 * transmitter.
@@ -524,6 +521,9 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	status |= CDNS_UART_CR_TX_EN;
 	writel(status, port->membase + CDNS_UART_CR_OFFSET);
 
+	if (uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port))
+		return;
+
 	while (numbytes-- && ((readl(port->membase + CDNS_UART_SR_OFFSET) &
 				CDNS_UART_SR_TXFULL)) != CDNS_UART_SR_TXFULL) {
 		/* Break if no more data available in the UART buffer */
-- 
2.6.2.3.ga463a5b
