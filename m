From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 02/10] drivers: PL011: refactor pl011_startup()
Date: Wed,  4 Mar 2015 17:59:46 +0000
Message-ID: <1425491994-23913-3-git-send-email-andre.przywara@arm.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, arnd@arndb.de, linux-serial@vger.kernel.org, Dave.Martin@arm.com
List-Id: linux-serial@vger.kernel.org

Split the pl011_startup() function into smaller chunks to allow
easier reuse later when adding SBSA support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   48 +++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 961f9b0..db2f90e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1654,6 +1654,32 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
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
 	struct uart_amba_port *uap =
@@ -1665,12 +1691,7 @@ static int pl011_startup(struct uart_port *port)
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
 
@@ -1693,20 +1714,7 @@ static int pl011_startup(struct uart_port *port)
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
