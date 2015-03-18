From: Jakub Kicinski <moorray3@wp.pl>
Subject: [PATCH v2] amba-pl011: simplify TX handling
Date: Wed, 18 Mar 2015 01:02:47 +0100
Message-ID: <1426636967-9124-1-git-send-email-moorray3@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kubakici@wp.pl>, Andre Przywara <andre.przywara@arm.com>, =?UTF-8?q?Karol=20D=C4=99bog=C3=B3rski?= <k.debogorski@a2s.pl>, linux-serial@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Jakub Kicinski <kubakici@wp.pl>

Since pre-git era PL011 used an elaborate scheme to load data
to TX FIFO.  Only TX IRQ handler was loading data into the FIFO,
which required the IRQ to fire before any transmission started
(to load the first batch of characters).  Initial IRQ was fired
by putting UART into loopback mode and writing an arbitrary
character during .startup().

Unfortunately some PL011-compatible UART (most notably BCM2708
in Raspberry Pi) would transmit the arbitrary character even
though the device was in loopback mode.  Commit 734745caeb9f
("serial/amba-pl011: Activate TX IRQ passively") solved this
issue by loading the first batch explicitly from .start_tx()
handler.  It employed quite a complex scheme involving IRQ
counting and a delayed work.

f2ee6dfa0e85 ("serial/amba-pl011: Leave the TX IRQ alone when
the UART is not open") was an attempt to optimise the loading
by assuming that when the device is opened second time TX IRQ
from the previous transmission will still be pending.  This
assumption is incorrect if the device is closed with FIFO full
because FIFO will be programmatically flushed and therefore no
IRQ will be pending on next .open().

This patch simplifies the code and fixes above problem. It should
also make things a bit more efficient as the FIFO was not filled
properly after the driver seen more than two IRQs.

Fixes: f2ee6dfa0e85 ("serial/amba-pl011: Leave the TX IRQ alone when the UART is not open")
Signed-off-by: Jakub Kicinski <kubakici@wp.pl>
---
v2:
 - don't try to load FIFO from outside of IRQ handler
   if IRQ is unmasked (change to pl011_start_tx_pio());
 - don't check for FIFO_FULL at the end of load from IRQ;
 - remove unnecessary newlines.
---
 drivers/tty/serial/amba-pl011.c | 113 +++++++++++++---------------------------
 1 file changed, 35 insertions(+), 78 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5a4e9d579585..39993dc874cc 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -73,7 +73,7 @@
 
 /* There is by now at least one vendor with differing details, so handle it */
 struct vendor_data {
-	unsigned int		ifls;
+	unsigned int		ifls; /* Note: TX depends on IRQ at 1/2 FIFO */
 	unsigned int		lcrh_tx;
 	unsigned int		lcrh_rx;
 	bool			oversampling;
@@ -157,9 +157,8 @@ struct uart_amba_port {
 	unsigned int		lcrh_tx;	/* vendor-specific */
 	unsigned int		lcrh_rx;	/* vendor-specific */
 	unsigned int		old_cr;		/* state during shutdown */
-	struct delayed_work	tx_softirq_work;
 	bool			autorts;
-	unsigned int		tx_irq_seen;	/* 0=none, 1=1, 2=2 or more */
+	bool			prev_load_from_irq;
 	char			type[12];
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
@@ -1172,15 +1171,17 @@ static void pl011_stop_tx(struct uart_port *port)
 	pl011_dma_tx_stop(uap);
 }
 
-static bool pl011_tx_chars(struct uart_amba_port *uap);
+static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
 
 /* Start TX with programmed I/O only (no DMA) */
 static void pl011_start_tx_pio(struct uart_amba_port *uap)
 {
+	/* IRQ is on - it will load the data */
+	if (uap->im & UART011_TXIM)
+		return;
 	uap->im |= UART011_TXIM;
 	writew(uap->im, uap->port.membase + UART011_IMSC);
-	if (!uap->tx_irq_seen)
-		pl011_tx_chars(uap);
+	pl011_tx_chars(uap, false);
 }
 
 static void pl011_start_tx(struct uart_port *port)
@@ -1249,67 +1250,56 @@ __acquires(&uap->port.lock)
 
 /*
  * Transmit a character
- * There must be at least one free entry in the TX FIFO to accept the char.
  *
- * Returns true if the FIFO might have space in it afterwards;
- * returns false if the FIFO definitely became full.
+ * Returns true if character was transmitted;
+ * returns false if character was not transmitted.
  */
-static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c)
+static bool pl011_tx_char(struct uart_amba_port *uap,
+			  int *count, unsigned char c)
 {
+	if (*count > 0)
+		(*count)--;
+	else if (!*count)
+		return false;
+	else if (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
+		return false;
+
 	writew(c, uap->port.membase + UART01x_DR);
 	uap->port.icount.tx++;
 
-	if (likely(uap->tx_irq_seen > 1))
-		return true;
-
-	return !(readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF);
+	return true;
 }
 
-static bool pl011_tx_chars(struct uart_amba_port *uap)
+static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
 {
 	struct circ_buf *xmit = &uap->port.state->xmit;
 	int count;
 
-	if (unlikely(uap->tx_irq_seen < 2))
-		/*
-		 * Initial FIFO fill level unknown: we must check TXFF
-		 * after each write, so just try to fill up the FIFO.
-		 */
-		count = uap->fifosize;
-	else /* tx_irq_seen >= 2 */
-		/*
-		 * FIFO initially at least half-empty, so we can simply
-		 * write half the FIFO without polling TXFF.
-
-		 * Note: the *first* TX IRQ can still race with
-		 * pl011_start_tx_pio(), which can result in the FIFO
-		 * being fuller than expected in that case.
-		 */
-		count = uap->fifosize >> 1;
-
 	/*
-	 * If the FIFO is full we're guaranteed a TX IRQ at some later point,
-	 * and can't transmit immediately in any case:
+	 * If we are loading from IRQs only we are guaranteed at least
+	 * half of the FIFO to be empty.
 	 */
-	if (unlikely(uap->tx_irq_seen < 2 &&
-		     readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF))
-		return false;
+	if (from_irq && uap->prev_load_from_irq)
+		count = uap->fifosize >> 1;
+	else
+		count = -1;
+	uap->prev_load_from_irq = from_irq;
 
 	if (uap->port.x_char) {
-		pl011_tx_char(uap, uap->port.x_char);
+		if (!pl011_tx_char(uap, &count, uap->port.x_char))
+			return;
 		uap->port.x_char = 0;
-		--count;
 	}
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port)) {
 		pl011_stop_tx(&uap->port);
-		goto done;
+		return;
 	}
 
 	/* If we are using DMA mode, try to send some characters. */
 	if (pl011_dma_tx_irq(uap))
-		goto done;
+		return;
 
-	while (count-- > 0 && pl011_tx_char(uap, xmit->buf[xmit->tail])) {
+	while (pl011_tx_char(uap, &count, xmit->buf[xmit->tail])) {
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		if (uart_circ_empty(xmit))
 			break;
@@ -1320,14 +1310,8 @@ static bool pl011_tx_chars(struct uart_amba_port *uap)
 
 	if (uart_circ_empty(xmit)) {
 		pl011_stop_tx(&uap->port);
-		goto done;
+		return;
 	}
-
-	if (unlikely(!uap->tx_irq_seen))
-		schedule_delayed_work(&uap->tx_softirq_work, uap->port.timeout);
-
-done:
-	return false;
 }
 
 static void pl011_modem_status(struct uart_amba_port *uap)
@@ -1354,28 +1338,6 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 	wake_up_interruptible(&uap->port.state->port.delta_msr_wait);
 }
 
-static void pl011_tx_softirq(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct uart_amba_port *uap =
-		container_of(dwork, struct uart_amba_port, tx_softirq_work);
-
-	spin_lock(&uap->port.lock);
-	while (pl011_tx_chars(uap)) ;
-	spin_unlock(&uap->port.lock);
-}
-
-static void pl011_tx_irq_seen(struct uart_amba_port *uap)
-{
-	if (likely(uap->tx_irq_seen > 1))
-		return;
-
-	uap->tx_irq_seen++;
-	if (uap->tx_irq_seen < 2)
-		/* first TX IRQ */
-		cancel_delayed_work(&uap->tx_softirq_work);
-}
-
 static irqreturn_t pl011_int(int irq, void *dev_id)
 {
 	struct uart_amba_port *uap = dev_id;
@@ -1414,10 +1376,8 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 			if (status & (UART011_DSRMIS|UART011_DCDMIS|
 				      UART011_CTSMIS|UART011_RIMIS))
 				pl011_modem_status(uap);
-			if (status & UART011_TXIS) {
-				pl011_tx_irq_seen(uap);
-				pl011_tx_chars(uap);
-			}
+			if (status & UART011_TXIS)
+				pl011_tx_chars(uap, true);
 
 			if (pass_counter-- == 0)
 				break;
@@ -1694,8 +1654,6 @@ static void pl011_shutdown(struct uart_port *port)
 	    container_of(port, struct uart_amba_port, port);
 	unsigned int cr;
 
-	cancel_delayed_work_sync(&uap->tx_softirq_work);
-
 	/*
 	 * disable all interrupts
 	 */
@@ -2242,7 +2200,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.ops = &amba_pl011_pops;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
-	INIT_DELAYED_WORK(&uap->tx_softirq_work, pl011_tx_softirq);
 
 	/* Ensure interrupts from this UART are masked and cleared */
 	writew(0, uap->port.membase + UART011_IMSC);
-- 
2.1.0
