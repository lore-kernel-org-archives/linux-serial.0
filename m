From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 3/3] serial: xuartps: Do not enable parity error interrupt
Date: Fri, 20 Nov 2015 19:04:38 +0530
Message-ID: <1448026478-22131-3-git-send-email-navam@xilinx.com>
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

The patch makes changes not to enable parity error interrupt.
With the current implementation, each parity error results in
two distinct interrupts (almost always). The first one is normal
parity error interrupt with no data in the fifo and the second one
is a proper Rx interrupt with the received data in the fifo. By
disabling parity error interrupt we still ensure handling of
parity errors as for the Rx fifo interrupt the parity error still
shows up in the interrupt status register. Considering the fact
that the by default INPCK and IGNPAR are not set, this is the
optimal implementation for parity error handling.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v2:
		--None

 drivers/tty/serial/xilinx_uartps.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4d71478..082e7f7 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -824,8 +824,18 @@ static int cdns_uart_startup(struct uart_port *port)
 	writel(readl(port->membase + CDNS_UART_ISR_OFFSET),
 			port->membase + CDNS_UART_ISR_OFFSET);
 
-	/* Set the Interrupt Registers with desired interrupts */
-	writel(CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_PARITY |
+	/*
+	 * Set the Interrupt Registers with desired interrupts. Do not
+	 * enable parity error interrupt for the following reason:
+	 * When parity error interrupt is enabled, each Rx parity error always
+	 * results in 2 events. The first one being parity error interrupt
+	 * and the second one with a proper Rx interrupt with the incoming data.
+	 * Disabling parity error interrupt ensures better handling of parity
+	 * error events. With this change, for a parity error case, we get a
+	 * Rx interrupt with parity error set in ISR register and we still
+	 * handle parity errors in the desired way.
+	 */
+	writel(CDNS_UART_IXR_TXEMPTY |
 		CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN |
 		CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT,
 		port->membase + CDNS_UART_IER_OFFSET);
-- 
2.1.2
