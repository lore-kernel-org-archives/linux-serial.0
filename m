From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 03/10] drivers: PL011: refactor pl011_shutdown()
Date: Fri, 16 Jan 2015 17:22:59 +0000
Message-ID: <1421428986-11300-4-git-send-email-andre.przywara@arm.com>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
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
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, arnd@arndb.de, linux-serial@vger.kernel.org, Dave Martin <dave.martin@arm.com>
List-Id: linux-serial@vger.kernel.org

Split the pl011_shutdown() function into smaller chunks to allow
easier reuse later when adding SBSA support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   59 ++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4be4c19..7373060 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1666,34 +1666,15 @@ static void pl011_shutdown_channel(struct uart_amba_port *uap,
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
-	struct uart_amba_port *uap =
-	    container_of(port, struct uart_amba_port, port);
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
@@ -1709,6 +1690,34 @@ static void pl011_shutdown(struct uart_port *port)
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
+	struct uart_amba_port *uap =
+		container_of(port, struct uart_amba_port, port);
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
