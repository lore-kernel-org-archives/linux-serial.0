From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v3 07/10] tty: xuartps: Acquire port lock for shutdown
Date: Sat, 21 Nov 2015 18:59:29 -0800
Message-ID: <1448161172-19717-8-git-send-email-soren.brinkmann@xilinx.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Shutting down the UART port can happen while console operations are in
progress. Holding the port lock serializes these operations and avoids
the UART HW to be disabled in the middle of console prints.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index ab3995d00973..f3ac69387b0a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -826,6 +826,9 @@ static int cdns_uart_startup(struct uart_port *port)
 static void cdns_uart_shutdown(struct uart_port *port)
 {
 	int status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable interrupts */
 	status = readl(port->membase + CDNS_UART_IMR_OFFSET);
@@ -835,6 +838,9 @@ static void cdns_uart_shutdown(struct uart_port *port)
 	/* Disable the TX and RX */
 	writel(CDNS_UART_CR_TX_DIS | CDNS_UART_CR_RX_DIS,
 			port->membase + CDNS_UART_CR_OFFSET);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
 	free_irq(port->irq, port);
 }
 
-- 
2.6.3.3.g9bb996a
