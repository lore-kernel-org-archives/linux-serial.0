From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATH RESEND v2 10/10] tty: xuartps: Cleanup: Reformat if-else
Date: Thu, 19 Nov 2015 12:02:24 -0800
Message-ID: <1447963344-16266-11-git-send-email-soren.brinkmann@xilinx.com>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
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

Convert an if-else into the more common early return on error, reducing
the indent level of the happy path.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v2:
 - added this patch
---
 drivers/tty/serial/xilinx_uartps.c | 124 ++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 413229661f5d..aed8a31f3399 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -203,58 +203,55 @@ static void cdns_uart_handle_rx(struct uart_port *port, unsigned int isrstatus)
 	isrstatus &= port->read_status_mask;
 	isrstatus &= ~port->ignore_status_mask;
 
-	if ((isrstatus & CDNS_UART_IXR_TOUT) ||
-		(isrstatus & CDNS_UART_IXR_RXTRIG)) {
-		/* Receive Timeout Interrupt */
-		while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
-					CDNS_UART_SR_RXEMPTY)) {
-			u32 data;
-			char status = TTY_NORMAL;
-
-			data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
-
-			/* Non-NULL byte after BREAK is garbage (99%) */
-			if (data && (port->read_status_mask &
-						CDNS_UART_IXR_BRK)) {
-				port->read_status_mask &= ~CDNS_UART_IXR_BRK;
-				port->icount.brk++;
-				if (uart_handle_break(port))
-					continue;
-			}
+	if (!(isrstatus & (CDNS_UART_IXR_TOUT | CDNS_UART_IXR_RXTRIG)))
+		return;
+
+	while (!(readl(port->membase + CDNS_UART_SR_OFFSET) &
+				CDNS_UART_SR_RXEMPTY)) {
+		u32 data;
+		char status = TTY_NORMAL;
+
+		data = readl(port->membase + CDNS_UART_FIFO_OFFSET);
+
+		/* Non-NULL byte after BREAK is garbage (99%) */
+		if (data && (port->read_status_mask & CDNS_UART_IXR_BRK)) {
+			port->read_status_mask &= ~CDNS_UART_IXR_BRK;
+			port->icount.brk++;
+			if (uart_handle_break(port))
+				continue;
+		}
 
 #ifdef SUPPORT_SYSRQ
-			/*
-			 * uart_handle_sysrq_char() doesn't work if
-			 * spinlocked, for some reason
-			 */
-			 if (port->sysrq) {
-				spin_unlock(&port->lock);
-				if (uart_handle_sysrq_char(port,
-							(unsigned char)data)) {
-					spin_lock(&port->lock);
-					continue;
-				}
+		/*
+		 * uart_handle_sysrq_char() doesn't work if
+		 * spinlocked, for some reason
+		 */
+		 if (port->sysrq) {
+			spin_unlock(&port->lock);
+			if (uart_handle_sysrq_char(port, data)) {
 				spin_lock(&port->lock);
+				continue;
 			}
+			spin_lock(&port->lock);
+		}
 #endif
 
-			port->icount.rx++;
-
-			if (isrstatus & CDNS_UART_IXR_PARITY) {
-				port->icount.parity++;
-				status = TTY_PARITY;
-			} else if (isrstatus & CDNS_UART_IXR_FRAMING) {
-				port->icount.frame++;
-				status = TTY_FRAME;
-			} else if (isrstatus & CDNS_UART_IXR_OVERRUN) {
-				port->icount.overrun++;
-			}
+		port->icount.rx++;
 
-			uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
-					 data, status);
+		if (isrstatus & CDNS_UART_IXR_PARITY) {
+			port->icount.parity++;
+			status = TTY_PARITY;
+		} else if (isrstatus & CDNS_UART_IXR_FRAMING) {
+			port->icount.frame++;
+			status = TTY_FRAME;
+		} else if (isrstatus & CDNS_UART_IXR_OVERRUN) {
+			port->icount.overrun++;
 		}
-		tty_flip_buffer_push(&port->state->port);
+
+		uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
+				 data, status);
 	}
+	tty_flip_buffer_push(&port->state->port);
 }
 
 /**
@@ -1431,27 +1428,30 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
 		rc = -ENODEV;
 		goto err_out_notif_unreg;
-	} else {
-		/* Register the port.
-		 * This function also registers this device with the tty layer
-		 * and triggers invocation of the config_port() entry point.
-		 */
-		port->mapbase = res->start;
-		port->irq = irq;
-		port->dev = &pdev->dev;
-		port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
-		port->private_data = cdns_uart_data;
-		cdns_uart_data->port = port;
-		platform_set_drvdata(pdev, port);
-		rc = uart_add_one_port(&cdns_uart_uart_driver, port);
-		if (rc) {
-			dev_err(&pdev->dev,
-				"uart_add_one_port() failed; err=%i\n", rc);
-			goto err_out_notif_unreg;
-		}
-		return 0;
 	}
 
+	/*
+	 * Register the port.
+	 * This function also registers this device with the tty layer
+	 * and triggers invocation of the config_port() entry point.
+	 */
+	port->mapbase = res->start;
+	port->irq = irq;
+	port->dev = &pdev->dev;
+	port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
+	port->private_data = cdns_uart_data;
+	cdns_uart_data->port = port;
+	platform_set_drvdata(pdev, port);
+
+	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
+	if (rc) {
+		dev_err(&pdev->dev,
+			"uart_add_one_port() failed; err=%i\n", rc);
+		goto err_out_notif_unreg;
+	}
+
+	return 0;
+
 err_out_notif_unreg:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
-- 
2.6.3.3.g9bb996a
