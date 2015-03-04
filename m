From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 03/10] drivers: PL011: refactor pl011_shutdown()
Date: Wed,  4 Mar 2015 17:59:47 +0000
Message-ID: <1425491994-23913-4-git-send-email-andre.przywara@arm.com>
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

Split the pl011_shutdown() function into smaller chunks to allow
easier reuse later when adding SBSA support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   62 ++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index db2f90e..4e0036c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1733,36 +1733,15 @@ static void pl011_shutdown_channel(struct uart_amba_port *uap,
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
 
-	cancel_delayed_work_sync(&uap->tx_softirq_work);
-
-	/*
-	 * disable all interrupts
-	 */
-	spin_lock_irq(&uap->port.lock);
-	uap->im = 0;
-	writew(uap->im, uap->port.membase + UART011_IMSC);
-	writew(0xffff & ~UART011_TXIS, uap->port.membase + UART011_ICR);
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
@@ -1778,6 +1757,35 @@ static void pl011_shutdown(struct uart_port *port)
 	pl011_shutdown_channel(uap, uap->lcrh_rx);
 	if (uap->lcrh_rx != uap->lcrh_tx)
 		pl011_shutdown_channel(uap, uap->lcrh_tx);
+}
+
+static void pl011_disable_interrupts(struct uart_amba_port *uap)
+{
+	cancel_delayed_work_sync(&uap->tx_softirq_work);
+
+	spin_lock_irq(&uap->port.lock);
+	/*
+	 * mask all interrupts and clear all pending ones
+	 */
+	uap->im = 0;
+	writew(uap->im, uap->port.membase + UART011_IMSC);
+	writew(0xffff & ~UART011_TXIS, uap->port.membase + UART011_ICR);
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
