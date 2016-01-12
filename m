From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX 1/6] tty: xuartps: Move request_irq to after setting up the HW
Date: Mon, 11 Jan 2016 17:41:36 -0800
Message-ID: <1452562901-17848-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452562901-17848-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

Request_irq() should be _after_ h/w programming, otherwise an
interrupt could be triggered and in-progress before the h/w has been
setup.

Reported-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index db9e23eaf300..5da1c51e9e40 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -762,13 +762,9 @@ static void cdns_uart_set_termios(struct uart_port *port,
  */
 static int cdns_uart_startup(struct uart_port *port)
 {
+	int ret;
 	unsigned long flags;
-	unsigned int retval = 0, status = 0;
-
-	retval = request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME,
-								(void *)port);
-	if (retval)
-		return retval;
+	unsigned int status = 0;
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -814,15 +810,22 @@ static int cdns_uart_startup(struct uart_port *port)
 	writel(readl(port->membase + CDNS_UART_ISR_OFFSET),
 			port->membase + CDNS_UART_ISR_OFFSET);
 
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	ret = request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME, port);
+	if (ret) {
+		dev_err(port->dev, "request_irq '%d' failed with %d\n",
+			port->irq, ret);
+		return ret;
+	}
+
 	/* Set the Interrupt Registers with desired interrupts */
 	writel(CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_PARITY |
 		CDNS_UART_IXR_FRAMING | CDNS_UART_IXR_OVERRUN |
 		CDNS_UART_IXR_RXTRIG | CDNS_UART_IXR_TOUT,
 		port->membase + CDNS_UART_IER_OFFSET);
 
-	spin_unlock_irqrestore(&port->lock, flags);
-
-	return retval;
+	return 0;
 }
 
 /**
-- 
2.7.0.3.g497ea1e
