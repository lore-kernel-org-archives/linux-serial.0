From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v5 03/11] drivers: PL011: refactor pl011_shutdown()
Date: Thu, 21 May 2015 17:26:16 +0100
Message-ID: <1432225584-4655-4-git-send-email-andre.przywara@arm.com>
References: <1432225584-4655-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432225584-4655-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rmk+kernel@arm.linux.org.uk, GregKH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Lorenzo.Pieralisi@arm.com, graeme.gregory@linaro.org, arnd@arndb.de, Jakub Kicinski <moorray3@wp.pl>, nareshgbhat@gmail.com, mlangsdo@redhat.com, linux-serial@vger.kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Split the pl011_shutdown() function into smaller chunks to allow
easier reuse later when adding SBSA support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 57 +++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 209aeb6..a43039d 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1635,34 +1635,15 @@ static void pl011_shutdown_channel(struct uart_amba_port *uap,
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
@@ -1678,6 +1659,32 @@ static void pl011_shutdown(struct uart_port *port)
 	pl011_shutdown_channel(uap, uap->lcrh_rx);
 	if (uap->lcrh_rx != uap->lcrh_tx)
 		pl011_shutdown_channel(uap, uap->lcrh_tx);
+}
+
+static void pl011_disable_interrupts(struct uart_amba_port *uap)
+{
+	spin_lock_irq(&uap->port.lock);
+
+	/* mask all interrupts and clear all pending ones */
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
2.3.5
