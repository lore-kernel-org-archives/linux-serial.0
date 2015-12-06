From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v4 08/13] tty: xuartps: Acquire port lock for shutdown
Date: Sat, 5 Dec 2015 20:39:24 -0800
Message-ID: <1449376769-13369-9-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Moritz Fischer <moritz.fischer@ettus.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Shutting down the UART port can happen while console operations are in
progress. Holding the port lock serializes these operations and avoids
the UART HW to be disabled in the middle of console prints.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/xilinx_uartps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 62224a58056b..80248cb46bf6 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -821,6 +821,9 @@ static int cdns_uart_startup(struct uart_port *port)
 static void cdns_uart_shutdown(struct uart_port *port)
 {
 	int status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable interrupts */
 	status = readl(port->membase + CDNS_UART_IMR_OFFSET);
@@ -830,6 +833,9 @@ static void cdns_uart_shutdown(struct uart_port *port)
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
