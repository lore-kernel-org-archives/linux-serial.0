From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v4 03/13] tty: xuartps: Don't consider circular buffer
 when enabling transmitter
Date: Sat, 5 Dec 2015 20:39:19 -0800
Message-ID: <1449376769-13369-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
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

Restarting the transmitter even if the circ buffer is empty may be
necessary to push out remaining data when the port is restarted after
being stopped.

Cc: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
v3:
 - changed this patch to not always enable the transmitter, but keep the
   check for uart_tx_stopped() in place, as suggested by Peter, whose
   explanation I also stole for the new commit message (thx)
---
 drivers/tty/serial/xilinx_uartps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2c98c357d9a0..6a7cd4e057ae 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -512,7 +512,7 @@ static void cdns_uart_start_tx(struct uart_port *port)
 {
 	unsigned int status, numbytes = port->fifosize;
 
-	if (uart_circ_empty(&port->state->xmit) || uart_tx_stopped(port))
+	if (uart_tx_stopped(port))
 		return;
 
 	/*
@@ -524,6 +524,9 @@ static void cdns_uart_start_tx(struct uart_port *port)
 	status |= CDNS_UART_CR_TX_EN;
 	writel(status, port->membase + CDNS_UART_CR_OFFSET);
 
+	if (uart_circ_empty(&port->state->xmit))
+		return;
+
 	while (numbytes-- && ((readl(port->membase + CDNS_UART_SR_OFFSET) &
 				CDNS_UART_SR_TXFULL)) != CDNS_UART_SR_TXFULL) {
 		/* Break if no more data available in the UART buffer */
-- 
2.6.3.3.g9bb996a
