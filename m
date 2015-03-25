From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v3] serial/amba-pl011: Activate TX IRQ passively
Date: Wed, 25 Mar 2015 18:25:57 +0000
Message-ID: <1427307957-2904-2-git-send-email-Dave.Martin@arm.com>
References: <1427307746-2811-1-git-send-email-Dave.Martin@arm.com>
 <1427307957-2904-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427307957-2904-1-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Jakub=20Kici=C5=84ski?= <moorray3@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
List-Id: linux-serial@vger.kernel.org

The current PL011 driver transmits a dummy character when the UART
is opened, to assert the TX IRQ for the first time
(see pl011_startup()).  The UART is put in loopback mode temporarily,
so the receiver presumably shouldn't see anything.

However...

At least some platforms containing a PL011 send characters down the
wire even when loopback mode is enabled.  This means that a
spurious NUL character may be seen at the receiver when the PL011 is
opened through the TTY layer.

The current code also temporarily sets the baud rate to maximum and
the character width to the minimum, to that the dummy TX completes
as quickly as possible.  If this is seen by the receiver it will
result in a framing error and can knock the receiver out of sync --
turning subsequent output into garbage until synchronisation
is reestablished.  (Particularly problematic during boot with systemd.)

To avoid spurious transmissions, this patch removes assumptions about
whether the TX IRQ will fire until the FIFO has been filled.

This should also mean that the driver works on the SBSA Generic
UART[1] (a cut-down PL011) without invasive changes.  The Generic
UART lacks some features needed for the dummy TX approach to work
(FIFO disabling and loopback).

[1] Server Base System Architecture (ARM-DEN-0029-v2.3)
    http://infocenter.arm.com/
    (click-thru required :/)

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   88 +++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8d94c19..180b1d2 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -440,8 +440,9 @@ static void pl011_dma_remove(struct uart_amba_port *uap)
 		dma_release_channel(uap->dmarx.chan);
 }
 
-/* Forward declare this for the refill routine */
+/* Forward declare these for the refill routine */
 static int pl011_dma_tx_refill(struct uart_amba_port *uap);
+static void pl011_start_tx_pio(struct uart_amba_port *uap);
 
 /*
  * The current DMA TX buffer has been sent.
@@ -479,14 +480,13 @@ static void pl011_dma_tx_callback(void *data)
 		return;
 	}
 
-	if (pl011_dma_tx_refill(uap) <= 0) {
+	if (pl011_dma_tx_refill(uap) <= 0)
 		/*
 		 * We didn't queue a DMA buffer for some reason, but we
 		 * have data pending to be sent.  Re-enable the TX IRQ.
 		 */
-		uap->im |= UART011_TXIM;
-		writew(uap->im, uap->port.membase + UART011_IMSC);
-	}
+		pl011_start_tx_pio(uap);
+
 	spin_unlock_irqrestore(&uap->port.lock, flags);
 }
 
@@ -1208,15 +1208,23 @@ static void pl011_stop_tx(struct uart_port *port)
 	pl011_dma_tx_stop(uap);
 }
 
+static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
+
+/* Start TX with programmed I/O only (no DMA) */
+static void pl011_start_tx_pio(struct uart_amba_port *uap)
+{
+	uap->im |= UART011_TXIM;
+	writew(uap->im, uap->port.membase + UART011_IMSC);
+	pl011_tx_chars(uap, false);
+}
+
 static void pl011_start_tx(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	if (!pl011_dma_tx_start(uap)) {
-		uap->im |= UART011_TXIM;
-		writew(uap->im, uap->port.membase + UART011_IMSC);
-	}
+	if (!pl011_dma_tx_start(uap))
+		pl011_start_tx_pio(uap);
 }
 
 static void pl011_stop_rx(struct uart_port *port)
@@ -1274,16 +1282,29 @@ __acquires(&uap->port.lock)
 	spin_lock(&uap->port.lock);
 }
 
-static void pl011_tx_chars(struct uart_amba_port *uap)
+static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
+			  bool from_irq)
+{
+	if (unlikely(!from_irq) &&
+	    readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
+		return false; /* unable to transmit character */
+
+	writew(c, uap->port.membase + UART01x_DR);
+	uap->port.icount.tx++;
+
+	return true;
+}
+
+static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
 {
 	struct circ_buf *xmit = &uap->port.state->xmit;
-	int count;
+	int count = uap->fifosize >> 1;
 
 	if (uap->port.x_char) {
-		writew(uap->port.x_char, uap->port.membase + UART01x_DR);
-		uap->port.icount.tx++;
+		if (!pl011_tx_char(uap, uap->port.x_char, from_irq))
+			return;
 		uap->port.x_char = 0;
-		return;
+		--count;
 	}
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port)) {
 		pl011_stop_tx(&uap->port);
@@ -1294,14 +1315,15 @@ static void pl011_tx_chars(struct uart_amba_port *uap)
 	if (pl011_dma_tx_irq(uap))
 		return;
 
-	count = uap->fifosize >> 1;
 	do {
-		writew(xmit->buf[xmit->tail], uap->port.membase + UART01x_DR);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		uap->port.icount.tx++;
-		if (uart_circ_empty(xmit))
+		if (likely(from_irq) && count-- == 0)
+			break;
+
+		if (!pl011_tx_char(uap, xmit->buf[xmit->tail], from_irq))
 			break;
-	} while (--count > 0);
+
+		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+	} while (!uart_circ_empty(xmit));
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&uap->port);
@@ -1373,7 +1395,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 				      UART011_CTSMIS|UART011_RIMIS))
 				pl011_modem_status(uap);
 			if (status & UART011_TXIS)
-				pl011_tx_chars(uap);
+				pl011_tx_chars(uap, true);
 
 			if (pass_counter-- == 0)
 				break;
@@ -1577,7 +1599,7 @@ static int pl011_startup(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
-	unsigned int cr, lcr_h, fbrd, ibrd;
+	unsigned int cr;
 	int retval;
 
 	retval = pl011_hwinit(port);
@@ -1595,30 +1617,8 @@ static int pl011_startup(struct uart_port *port)
 
 	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
 
-	/*
-	 * Provoke TX FIFO interrupt into asserting. Taking care to preserve
-	 * baud rate and data format specified by FBRD, IBRD and LCRH as the
-	 * UART may already be in use as a console.
-	 */
 	spin_lock_irq(&uap->port.lock);
 
-	fbrd = readw(uap->port.membase + UART011_FBRD);
-	ibrd = readw(uap->port.membase + UART011_IBRD);
-	lcr_h = readw(uap->port.membase + uap->lcrh_rx);
-
-	cr = UART01x_CR_UARTEN | UART011_CR_TXE | UART011_CR_LBE;
-	writew(cr, uap->port.membase + UART011_CR);
-	writew(0, uap->port.membase + UART011_FBRD);
-	writew(1, uap->port.membase + UART011_IBRD);
-	pl011_write_lcr_h(uap, 0);
-	writew(0, uap->port.membase + UART01x_DR);
-	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
-		barrier();
-
-	writew(fbrd, uap->port.membase + UART011_FBRD);
-	writew(ibrd, uap->port.membase + UART011_IBRD);
-	pl011_write_lcr_h(uap, lcr_h);
-
 	/* restore RTS and DTR */
 	cr = uap->old_cr & (UART011_CR_RTS | UART011_CR_DTR);
 	cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
-- 
1.7.10.4
