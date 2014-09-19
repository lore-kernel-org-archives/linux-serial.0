From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 02/10] drivers: PL011: refactor pl011_startup()
Date: Fri, 19 Sep 2014 13:21:15 +0100
Message-ID: <1411129283-17219-3-git-send-email-andre.przywara@arm.com>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36074 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756113AbaISMWH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 08:22:07 -0400
In-Reply-To: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

Split the pl011_startup() function into smaller chunks to allow
easier reuse later when adding SBSA support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   51 +++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8fab985..22f113c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1524,6 +1524,32 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 	}
 }
 
+static int pl011_allocate_irq(struct uart_amba_port *uap)
+{
+	writew(uap->im, uap->port.membase + UART011_IMSC);
+
+	return request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
+}
+
+/*
+ * Enable interrupts, only timeouts when using DMA
+ * if initial RX DMA job failed, start in interrupt mode
+ * as well.
+ */
+static void pl011_enable_interrupts(struct uart_amba_port *uap)
+{
+	spin_lock_irq(&uap->port.lock);
+
+	/* Clear out any spuriously appearing RX interrupts */
+	writew(UART011_RTIS | UART011_RXIS,
+		uap->port.membase + UART011_ICR);
+	uap->im = UART011_RTIM;
+	if (!pl011_dma_rx_running(uap))
+		uap->im |= UART011_RXIM;
+	writew(uap->im, uap->port.membase + UART011_IMSC);
+	spin_unlock_irq(&uap->port.lock);
+}
+
 static int pl011_startup(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
@@ -1534,19 +1560,15 @@ static int pl011_startup(struct uart_port *port)
 	if (retval)
 		goto clk_dis;
 
-	writew(uap->im, uap->port.membase + UART011_IMSC);
-
-	/*
-	 * Allocate the IRQ
-	 */
-	retval = request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
+	retval = pl011_allocate_irq(uap);
 	if (retval)
 		goto clk_dis;
 
 	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
 
 	/*
-	 * Provoke TX FIFO interrupt into asserting. Taking care to preserve
+	 * Provoke TX FIFO interrupt into asserting by enabling loopback and
+	 * sending a dummy character. Taking care to preserve
 	 * baud rate and data format specified by FBRD, IBRD and LCRH as the
 	 * UART may already be in use as a console.
 	 */
@@ -1584,20 +1606,7 @@ static int pl011_startup(struct uart_port *port)
 	/* Startup DMA */
 	pl011_dma_startup(uap);
 
-	/*
-	 * Finally, enable interrupts, only timeouts when using DMA
-	 * if initial RX DMA job failed, start in interrupt mode
-	 * as well.
-	 */
-	spin_lock_irq(&uap->port.lock);
-	/* Clear out any spuriously appearing RX interrupts */
-	 writew(UART011_RTIS | UART011_RXIS,
-		uap->port.membase + UART011_ICR);
-	uap->im = UART011_RTIM;
-	if (!pl011_dma_rx_running(uap))
-		uap->im |= UART011_RXIM;
-	writew(uap->im, uap->port.membase + UART011_IMSC);
-	spin_unlock_irq(&uap->port.lock);
+	pl011_enable_interrupts(uap);
 
 	return 0;
 
-- 
1.7.9.5

