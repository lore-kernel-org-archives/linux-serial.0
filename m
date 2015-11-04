From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH 7/9] tty: xuartps: Acquire port lock for shutdown
Date: Tue, 3 Nov 2015 16:20:48 -0800
Message-ID: <1446596450-20918-8-git-send-email-soren.brinkmann@xilinx.com>
References: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446596450-20918-1-git-send-email-soren.brinkmann@xilinx.com>
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

Shutting down the UART port can happen while console operations are in
progress. Holding the port lock serializes these operations and avoids
the UART HW to be disabled in the middle of console prints.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 544ea13e2e93..4904eec37621 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -823,6 +823,9 @@ static int cdns_uart_startup(struct uart_port *port)
 static void cdns_uart_shutdown(struct uart_port *port)
 {
 	int status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable interrupts */
 	status = readl(port->membase + CDNS_UART_IMR_OFFSET);
@@ -832,6 +835,9 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
 			port->membase + CDNS_UART_CR_OFFSET);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	free_irq(port->irq, port);
 }
 
-- 
2.6.2.3.ga463a5b
