From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH DRAFT 1/2] drivers: serial: PL011: refactor register access
Date: Mon,  2 Nov 2015 12:24:01 +0000
Message-ID: <1446467042-24494-2-git-send-email-andre.przywara@arm.com>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Nie <jun.nie@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Timur Tabi <timur@tabi.org>
Cc: Andrew.Jackson@arm.com, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Currently we call readw/writew directly each time we want to access
a PL011 register.
Wrap these calls in a function to simplify changes later, namely:
* to support UARTs with different register offsets (ZTE)
* to support a different bus access width (16 bits vs. 32 bits)
* to introduce readl_relaxed/writel_relaxed usage

This patch itself does not introduce any functional change.

This is based on code from Jun Nie <jun.nie@linaro.org>.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 209 +++++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 101 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index fd27e98..ef5d779 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -184,6 +184,16 @@ struct uart_amba_port {
 #endif
 };
 
+static unsigned int pl011_read(struct uart_amba_port *uap, int offset)
+{
+	return readw(uap->port.membase + offset);
+}
+
+static void pl011_write(struct uart_amba_port *uap, int val, int offset)
+{
+	writew(val, uap->port.membase + offset);
+}
+
 /*
  * Reads up to 256 characters from the FIFO or until it's empty and
  * inserts them into the TTY layer. Returns the number of characters
@@ -196,13 +206,12 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 	int fifotaken = 0;
 
 	while (max_count--) {
-		status = readw(uap->port.membase + UART01x_FR);
+		status = pl011_read(uap, UART01x_FR);
 		if (status & UART01x_FR_RXFE)
 			break;
 
 		/* Take chars from the FIFO and update status */
-		ch = readw(uap->port.membase + UART01x_DR) |
-			UART_DUMMY_DR_RX;
+		ch = pl011_read(uap, UART01x_DR) | UART_DUMMY_DR_RX;
 		flag = TTY_NORMAL;
 		uap->port.icount.rx++;
 		fifotaken++;
@@ -438,7 +447,7 @@ static void pl011_dma_tx_callback(void *data)
 
 	dmacr = uap->dmacr;
 	uap->dmacr = dmacr & ~UART011_TXDMAE;
-	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	pl011_write(uap, uap->dmacr, UART011_DMACR);
 
 	/*
 	 * If TX DMA was disabled, it means that we've stopped the DMA for
@@ -552,7 +561,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	dma_dev->device_issue_pending(chan);
 
 	uap->dmacr |= UART011_TXDMAE;
-	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	pl011_write(uap, uap->dmacr, UART011_DMACR);
 	uap->dmatx.queued = true;
 
 	/*
@@ -588,9 +597,9 @@ static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
 	 */
 	if (uap->dmatx.queued) {
 		uap->dmacr |= UART011_TXDMAE;
-		writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+		pl011_write(uap, uap->dmacr, UART011_DMACR);
 		uap->im &= ~UART011_TXIM;
-		writew(uap->im, uap->port.membase + UART011_IMSC);
+		pl011_write(uap, uap->im, UART011_IMSC);
 		return true;
 	}
 
@@ -600,7 +609,7 @@ static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
 	 */
 	if (pl011_dma_tx_refill(uap) > 0) {
 		uap->im &= ~UART011_TXIM;
-		writew(uap->im, uap->port.membase + UART011_IMSC);
+		pl011_write(uap, uap->im, UART011_IMSC);
 		return true;
 	}
 	return false;
@@ -614,7 +623,7 @@ static inline void pl011_dma_tx_stop(struct uart_amba_port *uap)
 {
 	if (uap->dmatx.queued) {
 		uap->dmacr &= ~UART011_TXDMAE;
-		writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+		pl011_write(uap, uap->dmacr, UART011_DMACR);
 	}
 }
 
@@ -640,14 +649,12 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 		if (!uap->dmatx.queued) {
 			if (pl011_dma_tx_refill(uap) > 0) {
 				uap->im &= ~UART011_TXIM;
-				writew(uap->im, uap->port.membase +
-				       UART011_IMSC);
+				pl011_write(uap, uap->im, UART011_IMSC);
 			} else
 				ret = false;
 		} else if (!(uap->dmacr & UART011_TXDMAE)) {
 			uap->dmacr |= UART011_TXDMAE;
-			writew(uap->dmacr,
-				       uap->port.membase + UART011_DMACR);
+			pl011_write(uap, uap->dmacr, UART011_DMACR);
 		}
 		return ret;
 	}
@@ -658,9 +665,9 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 	 */
 	dmacr = uap->dmacr;
 	uap->dmacr &= ~UART011_TXDMAE;
-	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	pl011_write(uap, uap->dmacr, UART011_DMACR);
 
-	if (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF) {
+	if (pl011_read(uap, UART01x_FR) & UART01x_FR_TXFF) {
 		/*
 		 * No space in the FIFO, so enable the transmit interrupt
 		 * so we know when there is space.  Note that once we've
@@ -669,13 +676,13 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 		return false;
 	}
 
-	writew(uap->port.x_char, uap->port.membase + UART01x_DR);
+	pl011_write(uap, uap->port.x_char, UART01x_DR);
 	uap->port.icount.tx++;
 	uap->port.x_char = 0;
 
 	/* Success - restore the DMA state */
 	uap->dmacr = dmacr;
-	writew(dmacr, uap->port.membase + UART011_DMACR);
+	pl011_write(uap, dmacr, UART011_DMACR);
 
 	return true;
 }
@@ -703,7 +710,7 @@ __acquires(&uap->port.lock)
 			     DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
-		writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+		pl011_write(uap, uap->dmacr, UART011_DMACR);
 	}
 }
 
@@ -743,11 +750,11 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	dma_async_issue_pending(rxchan);
 
 	uap->dmacr |= UART011_RXDMAE;
-	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	pl011_write(uap, uap->dmacr, UART011_DMACR);
 	uap->dmarx.running = true;
 
 	uap->im &= ~UART011_RXIM;
-	writew(uap->im, uap->port.membase + UART011_IMSC);
+	pl011_write(uap, uap->im, UART011_IMSC);
 
 	return 0;
 }
@@ -805,8 +812,8 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 	 */
 	if (dma_count == pending && readfifo) {
 		/* Clear any error flags */
-		writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS,
-		       uap->port.membase + UART011_ICR);
+		pl011_write(uap, UART011_OEIS | UART011_BEIS | UART011_PEIS |
+			    UART011_FEIS, UART011_ICR);
 
 		/*
 		 * If we read all the DMA'd characters, and we had an
@@ -854,7 +861,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 
 	/* Disable RX DMA - incoming data will wait in the FIFO */
 	uap->dmacr &= ~UART011_RXDMAE;
-	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	pl011_write(uap, uap->dmacr, UART011_DMACR);
 	uap->dmarx.running = false;
 
 	pending = sgbuf->sg.length - state.residue;
@@ -874,7 +881,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
 			"fall back to interrupt mode\n");
 		uap->im |= UART011_RXIM;
-		writew(uap->im, uap->port.membase + UART011_IMSC);
+		pl011_write(uap, uap->im, UART011_IMSC);
 	}
 }
 
@@ -922,7 +929,7 @@ static void pl011_dma_rx_callback(void *data)
 		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
 			"fall back to interrupt mode\n");
 		uap->im |= UART011_RXIM;
-		writew(uap->im, uap->port.membase + UART011_IMSC);
+		pl011_write(uap, uap->im, UART011_IMSC);
 	}
 }
 
@@ -935,7 +942,7 @@ static inline void pl011_dma_rx_stop(struct uart_amba_port *uap)
 {
 	/* FIXME.  Just disable the DMA enable */
 	uap->dmacr &= ~UART011_RXDMAE;
-	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	pl011_write(uap, uap->dmacr, UART011_DMACR);
 }
 
 /*
@@ -979,7 +986,7 @@ static void pl011_dma_rx_poll(unsigned long args)
 		spin_lock_irqsave(&uap->port.lock, flags);
 		pl011_dma_rx_stop(uap);
 		uap->im |= UART011_RXIM;
-		writew(uap->im, uap->port.membase + UART011_IMSC);
+		pl011_write(uap, uap->im, UART011_IMSC);
 		spin_unlock_irqrestore(&uap->port.lock, flags);
 
 		uap->dmarx.running = false;
@@ -1041,7 +1048,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 skip_rx:
 	/* Turn on DMA error (RX/TX will be enabled on demand) */
 	uap->dmacr |= UART011_DMAONERR;
-	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	pl011_write(uap, uap->dmacr, UART011_DMACR);
 
 	/*
 	 * ST Micro variants has some specific dma burst threshold
@@ -1049,8 +1056,9 @@ skip_rx:
 	 * be issued above/below 16 bytes.
 	 */
 	if (uap->vendor->dma_threshold)
-		writew(ST_UART011_DMAWM_RX_16 | ST_UART011_DMAWM_TX_16,
-			       uap->port.membase + ST_UART011_DMAWM);
+		pl011_write(uap,
+			    ST_UART011_DMAWM_RX_16 | ST_UART011_DMAWM_TX_16,
+			    ST_UART011_DMAWM);
 
 	if (uap->using_rx_dma) {
 		if (pl011_dma_rx_trigger_dma(uap))
@@ -1075,12 +1083,12 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		return;
 
 	/* Disable RX and TX DMA */
-	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
+	while (pl011_read(uap, UART01x_FR) & UART01x_FR_BUSY)
 		barrier();
 
 	spin_lock_irq(&uap->port.lock);
 	uap->dmacr &= ~(UART011_DMAONERR | UART011_RXDMAE | UART011_TXDMAE);
-	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
+	pl011_write(uap, uap->dmacr, UART011_DMACR);
 	spin_unlock_irq(&uap->port.lock);
 
 	if (uap->using_tx_dma) {
@@ -1181,7 +1189,7 @@ static void pl011_stop_tx(struct uart_port *port)
 	    container_of(port, struct uart_amba_port, port);
 
 	uap->im &= ~UART011_TXIM;
-	writew(uap->im, uap->port.membase + UART011_IMSC);
+	pl011_write(uap, uap->im, UART011_IMSC);
 	pl011_dma_tx_stop(uap);
 }
 
@@ -1191,7 +1199,7 @@ static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
 static void pl011_start_tx_pio(struct uart_amba_port *uap)
 {
 	uap->im |= UART011_TXIM;
-	writew(uap->im, uap->port.membase + UART011_IMSC);
+	pl011_write(uap, uap->im, UART011_IMSC);
 	pl011_tx_chars(uap, false);
 }
 
@@ -1211,7 +1219,7 @@ static void pl011_stop_rx(struct uart_port *port)
 
 	uap->im &= ~(UART011_RXIM|UART011_RTIM|UART011_FEIM|
 		     UART011_PEIM|UART011_BEIM|UART011_OEIM);
-	writew(uap->im, uap->port.membase + UART011_IMSC);
+	pl011_write(uap, uap->im, UART011_IMSC);
 
 	pl011_dma_rx_stop(uap);
 }
@@ -1222,7 +1230,7 @@ static void pl011_enable_ms(struct uart_port *port)
 	    container_of(port, struct uart_amba_port, port);
 
 	uap->im |= UART011_RIMIM|UART011_CTSMIM|UART011_DCDMIM|UART011_DSRMIM;
-	writew(uap->im, uap->port.membase + UART011_IMSC);
+	pl011_write(uap, uap->im, UART011_IMSC);
 }
 
 static void pl011_rx_chars(struct uart_amba_port *uap)
@@ -1242,7 +1250,7 @@ __acquires(&uap->port.lock)
 			dev_dbg(uap->port.dev, "could not trigger RX DMA job "
 				"fall back to interrupt mode again\n");
 			uap->im |= UART011_RXIM;
-			writew(uap->im, uap->port.membase + UART011_IMSC);
+			pl011_write(uap, uap->im, UART011_IMSC);
 		} else {
 #ifdef CONFIG_DMA_ENGINE
 			/* Start Rx DMA poll */
@@ -1263,10 +1271,10 @@ static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
 			  bool from_irq)
 {
 	if (unlikely(!from_irq) &&
-	    readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
+	    pl011_read(uap, UART01x_FR) & UART01x_FR_TXFF)
 		return false; /* unable to transmit character */
 
-	writew(c, uap->port.membase + UART01x_DR);
+	pl011_write(uap, c, UART01x_DR);
 	uap->port.icount.tx++;
 
 	return true;
@@ -1313,7 +1321,7 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 {
 	unsigned int status, delta;
 
-	status = readw(uap->port.membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
+	status = pl011_read(uap, UART01x_FR) & UART01x_FR_MODEM_ANY;
 
 	delta = status ^ uap->old_status;
 	uap->old_status = status;
@@ -1341,15 +1349,15 @@ static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
 		return;
 
 	/* workaround to make sure that all bits are unlocked.. */
-	writew(0x00, uap->port.membase + UART011_ICR);
+	pl011_write(uap, 0x00, UART011_ICR);
 
 	/*
 	 * WA: introduce 26ns(1 uart clk) delay before W1C;
 	 * single apb access will incur 2 pclk(133.12Mhz) delay,
 	 * so add 2 dummy reads
 	 */
-	dummy_read = readw(uap->port.membase + UART011_ICR);
-	dummy_read = readw(uap->port.membase + UART011_ICR);
+	dummy_read = pl011_read(uap, UART011_ICR);
+	dummy_read = pl011_read(uap, UART011_ICR);
 }
 
 static irqreturn_t pl011_int(int irq, void *dev_id)
@@ -1361,15 +1369,14 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	int handled = 0;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
-	imsc = readw(uap->port.membase + UART011_IMSC);
-	status = readw(uap->port.membase + UART011_RIS) & imsc;
+	imsc = pl011_read(uap, UART011_IMSC);
+	status = pl011_read(uap, UART011_RIS) & imsc;
 	if (status) {
 		do {
 			check_apply_cts_event_workaround(uap);
 
-			writew(status & ~(UART011_TXIS|UART011_RTIS|
-					  UART011_RXIS),
-			       uap->port.membase + UART011_ICR);
+			pl011_write(uap, status & ~(UART011_TXIS|UART011_RTIS|
+				    UART011_RXIS), UART011_ICR);
 
 			if (status & (UART011_RTIS|UART011_RXIS)) {
 				if (pl011_dma_rx_running(uap))
@@ -1386,7 +1393,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 			if (pass_counter-- == 0)
 				break;
 
-			status = readw(uap->port.membase + UART011_RIS) & imsc;
+			status = pl011_read(uap, UART011_RIS) & imsc;
 		} while (status != 0);
 		handled = 1;
 	}
@@ -1400,7 +1407,7 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
-	unsigned int status = readw(uap->port.membase + UART01x_FR);
+	unsigned int status = pl011_read(uap, UART01x_FR);
 	return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
 }
 
@@ -1409,7 +1416,7 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 	unsigned int result = 0;
-	unsigned int status = readw(uap->port.membase + UART01x_FR);
+	unsigned int status = pl011_read(uap, UART01x_FR);
 
 #define TIOCMBIT(uartbit, tiocmbit)	\
 	if (status & uartbit)		\
@@ -1429,7 +1436,7 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	    container_of(port, struct uart_amba_port, port);
 	unsigned int cr;
 
-	cr = readw(uap->port.membase + UART011_CR);
+	cr = pl011_read(uap, UART011_CR);
 
 #define	TIOCMBIT(tiocmbit, uartbit)		\
 	if (mctrl & tiocmbit)		\
@@ -1449,7 +1456,7 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	}
 #undef TIOCMBIT
 
-	writew(cr, uap->port.membase + UART011_CR);
+	pl011_write(uap, cr, UART011_CR);
 }
 
 static void pl011_break_ctl(struct uart_port *port, int break_state)
@@ -1460,12 +1467,12 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 	unsigned int lcr_h;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
-	lcr_h = readw(uap->port.membase + uap->lcrh_tx);
+	lcr_h = pl011_read(uap, uap->lcrh_tx);
 	if (break_state == -1)
 		lcr_h |= UART01x_LCRH_BRK;
 	else
 		lcr_h &= ~UART01x_LCRH_BRK;
-	writew(lcr_h, uap->port.membase + uap->lcrh_tx);
+	pl011_write(uap, lcr_h, uap->lcrh_tx);
 	spin_unlock_irqrestore(&uap->port.lock, flags);
 }
 
@@ -1477,7 +1484,7 @@ static void pl011_quiesce_irqs(struct uart_port *port)
 	    container_of(port, struct uart_amba_port, port);
 	unsigned char __iomem *regs = uap->port.membase;
 
-	writew(readw(regs + UART011_MIS), regs + UART011_ICR);
+	pl011_write(uap, pl011_read(uap, UART011_MIS), UART011_ICR);
 	/*
 	 * There is no way to clear TXIM as this is "ready to transmit IRQ", so
 	 * we simply mask it. start_tx() will unmask it.
@@ -1491,7 +1498,7 @@ static void pl011_quiesce_irqs(struct uart_port *port)
 	 * (including tx queue), so we're also fine with start_tx()'s caller
 	 * side.
 	 */
-	writew(readw(regs + UART011_IMSC) & ~UART011_TXIM, regs + UART011_IMSC);
+	pl011_write(pl011_read(uap, UART011_IMSC) & ~UART011_TXIM, UART011_IMSC);
 }
 
 static int pl011_get_poll_char(struct uart_port *port)
@@ -1506,11 +1513,11 @@ static int pl011_get_poll_char(struct uart_port *port)
 	 */
 	pl011_quiesce_irqs(port);
 
-	status = readw(uap->port.membase + UART01x_FR);
+	status = pl011_read(uap, UART01x_FR);
 	if (status & UART01x_FR_RXFE)
 		return NO_POLL_CHAR;
 
-	return readw(uap->port.membase + UART01x_DR);
+	return pl011_read(uap, UART01x_DR);
 }
 
 static void pl011_put_poll_char(struct uart_port *port,
@@ -1519,10 +1526,10 @@ static void pl011_put_poll_char(struct uart_port *port,
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
+	while (pl011_read(uap, UART01x_FR) & UART01x_FR_TXFF)
 		barrier();
 
-	writew(ch, uap->port.membase + UART01x_DR);
+	pl011_write(uap, ch, UART01x_DR);
 }
 
 #endif /* CONFIG_CONSOLE_POLL */
@@ -1546,15 +1553,16 @@ static int pl011_hwinit(struct uart_port *port)
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
 	/* Clear pending error and receive interrupts */
-	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
-	       UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
+	pl011_write(uap,
+		    UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
+		    UART011_RTIS | UART011_RXIS, UART011_ICR);
 
 	/*
 	 * Save interrupts enable mask, and enable RX interrupts in case if
 	 * the interrupt is used for NMI entry.
 	 */
-	uap->im = readw(uap->port.membase + UART011_IMSC);
-	writew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
+	uap->im = pl011_read(uap, UART011_IMSC);
+	pl011_write(uap, UART011_RTIM | UART011_RXIM, UART011_IMSC);
 
 	if (dev_get_platdata(uap->port.dev)) {
 		struct amba_pl011_data *plat;
@@ -1568,7 +1576,7 @@ static int pl011_hwinit(struct uart_port *port)
 
 static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 {
-	writew(lcr_h, uap->port.membase + uap->lcrh_rx);
+	pl011_write(uap, lcr_h, uap->lcrh_rx);
 	if (uap->lcrh_rx != uap->lcrh_tx) {
 		int i;
 		/*
@@ -1576,14 +1584,14 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 		 * to get this delay write read only register 10 times
 		 */
 		for (i = 0; i < 10; ++i)
-			writew(0xff, uap->port.membase + UART011_MIS);
-		writew(lcr_h, uap->port.membase + uap->lcrh_tx);
+			pl011_write(uap, 0xff, UART011_MIS);
+		pl011_write(uap, lcr_h, uap->lcrh_tx);
 	}
 }
 
 static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
-	writew(uap->im, uap->port.membase + UART011_IMSC);
+	pl011_write(uap, uap->im, UART011_IMSC);
 
 	return request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
 }
@@ -1598,12 +1606,11 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 	spin_lock_irq(&uap->port.lock);
 
 	/* Clear out any spuriously appearing RX interrupts */
-	writew(UART011_RTIS | UART011_RXIS,
-	       uap->port.membase + UART011_ICR);
+	pl011_write(uap, UART011_RTIS | UART011_RXIS, UART011_ICR);
 	uap->im = UART011_RTIM;
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
-	writew(uap->im, uap->port.membase + UART011_IMSC);
+	pl011_write(uap, uap->im, UART011_IMSC);
 	spin_unlock_irq(&uap->port.lock);
 }
 
@@ -1622,21 +1629,21 @@ static int pl011_startup(struct uart_port *port)
 	if (retval)
 		goto clk_dis;
 
-	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
+	pl011_write(uap, uap->vendor->ifls, UART011_IFLS);
 
 	spin_lock_irq(&uap->port.lock);
 
 	/* restore RTS and DTR */
 	cr = uap->old_cr & (UART011_CR_RTS | UART011_CR_DTR);
 	cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
-	writew(cr, uap->port.membase + UART011_CR);
+	pl011_write(uap, cr, UART011_CR);
 
 	spin_unlock_irq(&uap->port.lock);
 
 	/*
 	 * initialise the old status of the modem signals
 	 */
-	uap->old_status = readw(uap->port.membase + UART01x_FR) & UART01x_FR_MODEM_ANY;
+	uap->old_status = pl011_read(uap, UART01x_FR) & UART01x_FR_MODEM_ANY;
 
 	/* Startup DMA */
 	pl011_dma_startup(uap);
@@ -1675,11 +1682,11 @@ static int sbsa_uart_startup(struct uart_port *port)
 static void pl011_shutdown_channel(struct uart_amba_port *uap,
 					unsigned int lcrh)
 {
-      unsigned long val;
+	unsigned long val;
 
-      val = readw(uap->port.membase + lcrh);
-      val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
-      writew(val, uap->port.membase + lcrh);
+	val = pl011_read(uap, lcrh);
+	val &= ~(UART01x_LCRH_BRK | UART01x_LCRH_FEN);
+	pl011_write(uap, val, lcrh);
 }
 
 /*
@@ -1693,11 +1700,11 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
 
 	uap->autorts = false;
 	spin_lock_irq(&uap->port.lock);
-	cr = readw(uap->port.membase + UART011_CR);
+	cr = pl011_read(uap, UART011_CR);
 	uap->old_cr = cr;
 	cr &= UART011_CR_RTS | UART011_CR_DTR;
 	cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
-	writew(cr, uap->port.membase + UART011_CR);
+	pl011_write(uap, cr, UART011_CR);
 	spin_unlock_irq(&uap->port.lock);
 
 	/*
@@ -1714,8 +1721,8 @@ static void pl011_disable_interrupts(struct uart_amba_port *uap)
 
 	/* mask all interrupts and clear all pending ones */
 	uap->im = 0;
-	writew(uap->im, uap->port.membase + UART011_IMSC);
-	writew(0xffff, uap->port.membase + UART011_ICR);
+	pl011_write(uap, uap->im, UART011_IMSC);
+	pl011_write(uap, 0xffff, UART011_ICR);
 
 	spin_unlock_irq(&uap->port.lock);
 }
@@ -1867,8 +1874,8 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		pl011_enable_ms(port);
 
 	/* first, disable everything */
-	old_cr = readw(port->membase + UART011_CR);
-	writew(0, port->membase + UART011_CR);
+	old_cr = pl011_read(uap, UART011_CR);
+	pl011_write(uap, 0, UART011_CR);
 
 	if (termios->c_cflag & CRTSCTS) {
 		if (old_cr & UART011_CR_RTS)
@@ -1901,8 +1908,8 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 			quot -= 2;
 	}
 	/* Set baud rate */
-	writew(quot & 0x3f, port->membase + UART011_FBRD);
-	writew(quot >> 6, port->membase + UART011_IBRD);
+	pl011_write(uap, quot & 0x3f, UART011_FBRD);
+	pl011_write(uap, quot >> 6, UART011_IBRD);
 
 	/*
 	 * ----------v----------v----------v----------v-----
@@ -1911,7 +1918,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * ----------^----------^----------^----------^-----
 	 */
 	pl011_write_lcr_h(uap, lcr_h);
-	writew(old_cr, port->membase + UART011_CR);
+	pl011_write(uap, old_cr, UART011_CR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -2052,9 +2059,9 @@ static void pl011_console_putchar(struct uart_port *port, int ch)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
+	while (pl011_read(uap, UART01x_FR) & UART01x_FR_TXFF)
 		barrier();
-	writew(ch, uap->port.membase + UART01x_DR);
+	pl011_write(uap, ch, UART01x_DR);
 }
 
 static void
@@ -2079,10 +2086,10 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	 *	First save the CR then disable the interrupts
 	 */
 	if (!uap->vendor->always_enabled) {
-		old_cr = readw(uap->port.membase + UART011_CR);
+		old_cr = pl011_read(uap, UART011_CR);
 		new_cr = old_cr & ~UART011_CR_CTSEN;
 		new_cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
-		writew(new_cr, uap->port.membase + UART011_CR);
+		pl011_write(uap, new_cr, UART011_CR);
 	}
 
 	uart_console_write(&uap->port, s, count, pl011_console_putchar);
@@ -2092,10 +2099,10 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	 *	and restore the TCR
 	 */
 	do {
-		status = readw(uap->port.membase + UART01x_FR);
+		status = pl011_read(uap, UART01x_FR);
 	} while (status & UART01x_FR_BUSY);
 	if (!uap->vendor->always_enabled)
-		writew(old_cr, uap->port.membase + UART011_CR);
+		pl011_write(uap, old_cr, UART011_CR);
 
 	if (locked)
 		spin_unlock(&uap->port.lock);
@@ -2108,10 +2115,10 @@ static void __init
 pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 			     int *parity, int *bits)
 {
-	if (readw(uap->port.membase + UART011_CR) & UART01x_CR_UARTEN) {
+	if (pl011_read(uap, UART011_CR) & UART01x_CR_UARTEN) {
 		unsigned int lcr_h, ibrd, fbrd;
 
-		lcr_h = readw(uap->port.membase + uap->lcrh_tx);
+		lcr_h = pl011_read(uap, uap->lcrh_tx);
 
 		*parity = 'n';
 		if (lcr_h & UART01x_LCRH_PEN) {
@@ -2126,13 +2133,13 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 		else
 			*bits = 8;
 
-		ibrd = readw(uap->port.membase + UART011_IBRD);
-		fbrd = readw(uap->port.membase + UART011_FBRD);
+		ibrd = pl011_read(uap, UART011_IBRD);
+		fbrd = pl011_read(uap, UART011_FBRD);
 
 		*baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
 
 		if (uap->vendor->oversampling) {
-			if (readw(uap->port.membase + UART011_CR)
+			if (pl011_read(uap, UART011_CR)
 				  & ST_UART011_CR_OVSFACT)
 				*baud *= 2;
 		}
@@ -2334,8 +2341,8 @@ static int pl011_register_port(struct uart_amba_port *uap)
 	int ret;
 
 	/* Ensure interrupts from this UART are masked and cleared */
-	writew(0, uap->port.membase + UART011_IMSC);
-	writew(0xffff, uap->port.membase + UART011_ICR);
+	pl011_write(uap, 0, UART011_IMSC);
+	pl011_write(uap, 0xffff, UART011_ICR);
 
 	if (!amba_reg.state) {
 		ret = uart_register_driver(&amba_reg);
-- 
2.5.1
