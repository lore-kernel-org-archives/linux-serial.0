From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 03/10] drivers: PL011: refactor pl011_shutdown()
Date: Fri, 19 Sep 2014 13:21:16 +0100
Message-ID: <1411129283-17219-4-git-send-email-andre.przywara@arm.com>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36065 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754306AbaISMWG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 08:22:06 -0400
In-Reply-To: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

Split the pl011_shutdown() function into smaller chunks to allow
easier reuse later when adding SBSA support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   57 ++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 22f113c..17ba997 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1625,33 +1625,15 @@ static void pl011_shutdown_channel(struct uart_amba_port *uap,
       writew(val, uap->port.membase + lcrh);
 }
 
-static void pl011_shutdown(struct uart_port *port)
+/*
+ * disable the port. It should not disable RTS and DTR.
+ * Also RTS and DTR state should be preserved to restore
+ * it during startup().
+ */
+static void pl011_disable_uart(struct uart_amba_port *uap)
 {
-	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int cr;
 
-	/*
-	 * disable all interrupts
-	 */
-	spin_lock_irq(&uap->port.lock);
-	uap->im = 0;
-	writew(uap->im, uap->port.membase + UART011_IMSC);
-	writew(0xffff, uap->port.membase + UART011_ICR);
-	spin_unlock_irq(&uap->port.lock);
-
-	pl011_dma_shutdown(uap);
-
-	/*
-	 * Free the interrupt
-	 */
-	free_irq(uap->port.irq, uap);
-
-	/*
-	 * disable the port
-	 * disable the port. It should not disable RTS and DTR.
-	 * Also RTS and DTR state should be preserved to restore
-	 * it during startup().
-	 */
 	uap->autorts = false;
 	spin_lock_irq(&uap->port.lock);
 	cr = readw(uap->port.membase + UART011_CR);
@@ -1667,6 +1649,33 @@ static void pl011_shutdown(struct uart_port *port)
 	pl011_shutdown_channel(uap, uap->lcrh_rx);
 	if (uap->lcrh_rx != uap->lcrh_tx)
 		pl011_shutdown_channel(uap, uap->lcrh_tx);
+}
+
+static void pl011_disable_interrupts(struct uart_amba_port *uap)
+{
+	spin_lock_irq(&uap->port.lock);
+
+	/*
+	 * mask all interrupts and clear all pending ones
+	 */
+	uap->im = 0;
+	writew(uap->im, uap->port.membase + UART011_IMSC);
+	writew(0xffff, uap->port.membase + UART011_ICR);
+
+	spin_unlock_irq(&uap->port.lock);
+}
+
+static void pl011_shutdown(struct uart_port *port)
+{
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
+
+	pl011_disable_interrupts(uap);
+
+	pl011_dma_shutdown(uap);
+
+	free_irq(uap->port.irq, uap);
+
+	pl011_disable_uart(uap);
 
 	/*
 	 * Shut down the clock producer
-- 
1.7.9.5

