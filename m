From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 04/11] tty: amba-pl011: prepare REG_* register indexes
Date: Tue, 03 Nov 2015 14:51:13 +0000
Message-ID: <E1ZtcvZ-0007CI-Q2@rmk-PC.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151103134349.GV8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>
List-Id: linux-serial@vger.kernel.org

Prepare for REG_* register accessors.  This change involves introducing
pl011_reg_to_offset() to convert REG_* to the hardware register offset,
and converting all call sites to use REG_* names.  We need to fix up
locations where we check for equivalence of register offsets as well.

Much of this change was made via these sed expressions:
s/ST_UART01[1x]\(_[^_]*\|_LCRH_[TR]X\)\>/REG_ST\1/
s/UART01[1x]_\(DR\|RSR\|ECR\|FR\|ILPR\|[IF]BRD\|LCRH\|CR\|IFLS\|IMSC\|RIS\|MIS\|ICR\|DMACR\)\>/REG_\1/g

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 205 +++++++++++++++++++++-------------------
 drivers/tty/serial/amba-pl011.h |  32 +++++++
 2 files changed, 140 insertions(+), 97 deletions(-)
 create mode 100644 drivers/tty/serial/amba-pl011.h

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 63a916bb76f1..b3a0956d8883 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -60,6 +60,8 @@
 #include <linux/io.h>
 #include <linux/acpi.h>
 
+#include "amba-pl011.h"
+
 #define UART_NR			14
 
 #define SERIAL_AMBA_MAJOR	204
@@ -92,8 +94,8 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
 
 static struct vendor_data vendor_arm = {
 	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
-	.lcrh_tx		= UART011_LCRH,
-	.lcrh_rx		= UART011_LCRH,
+	.lcrh_tx		= REG_LCRH,
+	.lcrh_rx		= REG_LCRH,
 	.oversampling		= false,
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
@@ -117,8 +119,8 @@ static unsigned int get_fifosize_st(struct amba_device *dev)
 
 static struct vendor_data vendor_st = {
 	.ifls			= UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
-	.lcrh_tx		= ST_UART011_LCRH_TX,
-	.lcrh_rx		= ST_UART011_LCRH_RX,
+	.lcrh_tx		= REG_ST_LCRH_TX,
+	.lcrh_rx		= REG_ST_LCRH_RX,
 	.oversampling		= true,
 	.dma_threshold		= true,
 	.cts_event_workaround	= true,
@@ -184,16 +186,22 @@ struct uart_amba_port {
 #endif
 };
 
+static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
+	unsigned int reg)
+{
+	return reg;
+}
+
 static unsigned int pl011_read(const struct uart_amba_port *uap,
 	unsigned int reg)
 {
-	return readw(uap->port.membase + reg);
+	return readw(uap->port.membase + pl011_reg_to_offset(uap, reg));
 }
 
 static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
 	unsigned int reg)
 {
-	writew(val, uap->port.membase + reg);
+	writew(val, uap->port.membase + pl011_reg_to_offset(uap, reg));
 }
 
 /*
@@ -208,12 +216,12 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 	int fifotaken = 0;
 
 	while (max_count--) {
-		status = pl011_read(uap, UART01x_FR);
+		status = pl011_read(uap, REG_FR);
 		if (status & UART01x_FR_RXFE)
 			break;
 
 		/* Take chars from the FIFO and update status */
-		ch = pl011_read(uap, UART01x_DR) | UART_DUMMY_DR_RX;
+		ch = pl011_read(uap, REG_DR) | UART_DUMMY_DR_RX;
 		flag = TTY_NORMAL;
 		uap->port.icount.rx++;
 		fifotaken++;
@@ -295,7 +303,8 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 	struct amba_pl011_data *plat = dev_get_platdata(uap->port.dev);
 	struct device *dev = uap->port.dev;
 	struct dma_slave_config tx_conf = {
-		.dst_addr = uap->port.mapbase + UART01x_DR,
+		.dst_addr = uap->port.mapbase +
+				 pl011_reg_to_offset(uap, REG_DR),
 		.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
 		.direction = DMA_MEM_TO_DEV,
 		.dst_maxburst = uap->fifosize >> 1,
@@ -350,7 +359,8 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 
 	if (chan) {
 		struct dma_slave_config rx_conf = {
-			.src_addr = uap->port.mapbase + UART01x_DR,
+			.src_addr = uap->port.mapbase +
+				pl011_reg_to_offset(uap, REG_DR),
 			.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
 			.direction = DMA_DEV_TO_MEM,
 			.src_maxburst = uap->fifosize >> 2,
@@ -449,7 +459,7 @@ static void pl011_dma_tx_callback(void *data)
 
 	dmacr = uap->dmacr;
 	uap->dmacr = dmacr & ~UART011_TXDMAE;
-	pl011_write(uap->dmacr, uap, UART011_DMACR);
+	pl011_write(uap->dmacr, uap, REG_DMACR);
 
 	/*
 	 * If TX DMA was disabled, it means that we've stopped the DMA for
@@ -563,7 +573,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	dma_dev->device_issue_pending(chan);
 
 	uap->dmacr |= UART011_TXDMAE;
-	pl011_write(uap->dmacr, uap, UART011_DMACR);
+	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmatx.queued = true;
 
 	/*
@@ -599,9 +609,9 @@ static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
 	 */
 	if (uap->dmatx.queued) {
 		uap->dmacr |= UART011_TXDMAE;
-		pl011_write(uap->dmacr, uap, UART011_DMACR);
+		pl011_write(uap->dmacr, uap, REG_DMACR);
 		uap->im &= ~UART011_TXIM;
-		pl011_write(uap->im, uap, UART011_IMSC);
+		pl011_write(uap->im, uap, REG_IMSC);
 		return true;
 	}
 
@@ -611,7 +621,7 @@ static bool pl011_dma_tx_irq(struct uart_amba_port *uap)
 	 */
 	if (pl011_dma_tx_refill(uap) > 0) {
 		uap->im &= ~UART011_TXIM;
-		pl011_write(uap->im, uap, UART011_IMSC);
+		pl011_write(uap->im, uap, REG_IMSC);
 		return true;
 	}
 	return false;
@@ -625,7 +635,7 @@ static inline void pl011_dma_tx_stop(struct uart_amba_port *uap)
 {
 	if (uap->dmatx.queued) {
 		uap->dmacr &= ~UART011_TXDMAE;
-		pl011_write(uap->dmacr, uap, UART011_DMACR);
+		pl011_write(uap->dmacr, uap, REG_DMACR);
 	}
 }
 
@@ -651,12 +661,12 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 		if (!uap->dmatx.queued) {
 			if (pl011_dma_tx_refill(uap) > 0) {
 				uap->im &= ~UART011_TXIM;
-				pl011_write(uap->im, uap, UART011_IMSC);
+				pl011_write(uap->im, uap, REG_IMSC);
 			} else
 				ret = false;
 		} else if (!(uap->dmacr & UART011_TXDMAE)) {
 			uap->dmacr |= UART011_TXDMAE;
-			pl011_write(uap->dmacr, uap, UART011_DMACR);
+			pl011_write(uap->dmacr, uap, REG_DMACR);
 		}
 		return ret;
 	}
@@ -667,9 +677,9 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 	 */
 	dmacr = uap->dmacr;
 	uap->dmacr &= ~UART011_TXDMAE;
-	pl011_write(uap->dmacr, uap, UART011_DMACR);
+	pl011_write(uap->dmacr, uap, REG_DMACR);
 
-	if (pl011_read(uap, UART01x_FR) & UART01x_FR_TXFF) {
+	if (pl011_read(uap, REG_FR) & UART01x_FR_TXFF) {
 		/*
 		 * No space in the FIFO, so enable the transmit interrupt
 		 * so we know when there is space.  Note that once we've
@@ -678,13 +688,13 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
 		return false;
 	}
 
-	pl011_write(uap->port.x_char, uap, UART01x_DR);
+	pl011_write(uap->port.x_char, uap, REG_DR);
 	uap->port.icount.tx++;
 	uap->port.x_char = 0;
 
 	/* Success - restore the DMA state */
 	uap->dmacr = dmacr;
-	pl011_write(dmacr, uap, UART011_DMACR);
+	pl011_write(dmacr, uap, REG_DMACR);
 
 	return true;
 }
@@ -712,7 +722,7 @@ __acquires(&uap->port.lock)
 			     DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
-		pl011_write(uap->dmacr, uap, UART011_DMACR);
+		pl011_write(uap->dmacr, uap, REG_DMACR);
 	}
 }
 
@@ -752,11 +762,11 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	dma_async_issue_pending(rxchan);
 
 	uap->dmacr |= UART011_RXDMAE;
-	pl011_write(uap->dmacr, uap, UART011_DMACR);
+	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmarx.running = true;
 
 	uap->im &= ~UART011_RXIM;
-	pl011_write(uap->im, uap, UART011_IMSC);
+	pl011_write(uap->im, uap, REG_IMSC);
 
 	return 0;
 }
@@ -815,7 +825,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 	if (dma_count == pending && readfifo) {
 		/* Clear any error flags */
 		pl011_write(UART011_OEIS | UART011_BEIS | UART011_PEIS |
-			    UART011_FEIS, uap, UART011_ICR);
+			    UART011_FEIS, uap, REG_ICR);
 
 		/*
 		 * If we read all the DMA'd characters, and we had an
@@ -863,7 +873,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 
 	/* Disable RX DMA - incoming data will wait in the FIFO */
 	uap->dmacr &= ~UART011_RXDMAE;
-	pl011_write(uap->dmacr, uap, UART011_DMACR);
+	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmarx.running = false;
 
 	pending = sgbuf->sg.length - state.residue;
@@ -883,7 +893,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
 			"fall back to interrupt mode\n");
 		uap->im |= UART011_RXIM;
-		pl011_write(uap->im, uap, UART011_IMSC);
+		pl011_write(uap->im, uap, REG_IMSC);
 	}
 }
 
@@ -931,7 +941,7 @@ static void pl011_dma_rx_callback(void *data)
 		dev_dbg(uap->port.dev, "could not retrigger RX DMA job "
 			"fall back to interrupt mode\n");
 		uap->im |= UART011_RXIM;
-		pl011_write(uap->im, uap, UART011_IMSC);
+		pl011_write(uap->im, uap, REG_IMSC);
 	}
 }
 
@@ -944,7 +954,7 @@ static inline void pl011_dma_rx_stop(struct uart_amba_port *uap)
 {
 	/* FIXME.  Just disable the DMA enable */
 	uap->dmacr &= ~UART011_RXDMAE;
-	pl011_write(uap->dmacr, uap, UART011_DMACR);
+	pl011_write(uap->dmacr, uap, REG_DMACR);
 }
 
 /*
@@ -988,7 +998,7 @@ static void pl011_dma_rx_poll(unsigned long args)
 		spin_lock_irqsave(&uap->port.lock, flags);
 		pl011_dma_rx_stop(uap);
 		uap->im |= UART011_RXIM;
-		pl011_write(uap->im, uap, UART011_IMSC);
+		pl011_write(uap->im, uap, REG_IMSC);
 		spin_unlock_irqrestore(&uap->port.lock, flags);
 
 		uap->dmarx.running = false;
@@ -1050,7 +1060,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 skip_rx:
 	/* Turn on DMA error (RX/TX will be enabled on demand) */
 	uap->dmacr |= UART011_DMAONERR;
-	pl011_write(uap->dmacr, uap, UART011_DMACR);
+	pl011_write(uap->dmacr, uap, REG_DMACR);
 
 	/*
 	 * ST Micro variants has some specific dma burst threshold
@@ -1059,7 +1069,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 	 */
 	if (uap->vendor->dma_threshold)
 		pl011_write(ST_UART011_DMAWM_RX_16 | ST_UART011_DMAWM_TX_16,
-			    uap, ST_UART011_DMAWM);
+			    uap, REG_ST_DMAWM);
 
 	if (uap->using_rx_dma) {
 		if (pl011_dma_rx_trigger_dma(uap))
@@ -1084,12 +1094,12 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		return;
 
 	/* Disable RX and TX DMA */
-	while (pl011_read(uap, UART01x_FR) & UART01x_FR_BUSY)
+	while (pl011_read(uap, REG_FR) & UART01x_FR_BUSY)
 		barrier();
 
 	spin_lock_irq(&uap->port.lock);
 	uap->dmacr &= ~(UART011_DMAONERR | UART011_RXDMAE | UART011_TXDMAE);
-	pl011_write(uap->dmacr, uap, UART011_DMACR);
+	pl011_write(uap->dmacr, uap, REG_DMACR);
 	spin_unlock_irq(&uap->port.lock);
 
 	if (uap->using_tx_dma) {
@@ -1190,7 +1200,7 @@ static void pl011_stop_tx(struct uart_port *port)
 	    container_of(port, struct uart_amba_port, port);
 
 	uap->im &= ~UART011_TXIM;
-	pl011_write(uap->im, uap, UART011_IMSC);
+	pl011_write(uap->im, uap, REG_IMSC);
 	pl011_dma_tx_stop(uap);
 }
 
@@ -1200,7 +1210,7 @@ static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
 static void pl011_start_tx_pio(struct uart_amba_port *uap)
 {
 	uap->im |= UART011_TXIM;
-	pl011_write(uap->im, uap, UART011_IMSC);
+	pl011_write(uap->im, uap, REG_IMSC);
 	pl011_tx_chars(uap, false);
 }
 
@@ -1220,7 +1230,7 @@ static void pl011_stop_rx(struct uart_port *port)
 
 	uap->im &= ~(UART011_RXIM|UART011_RTIM|UART011_FEIM|
 		     UART011_PEIM|UART011_BEIM|UART011_OEIM);
-	pl011_write(uap->im, uap, UART011_IMSC);
+	pl011_write(uap->im, uap, REG_IMSC);
 
 	pl011_dma_rx_stop(uap);
 }
@@ -1231,7 +1241,7 @@ static void pl011_enable_ms(struct uart_port *port)
 	    container_of(port, struct uart_amba_port, port);
 
 	uap->im |= UART011_RIMIM|UART011_CTSMIM|UART011_DCDMIM|UART011_DSRMIM;
-	pl011_write(uap->im, uap, UART011_IMSC);
+	pl011_write(uap->im, uap, REG_IMSC);
 }
 
 static void pl011_rx_chars(struct uart_amba_port *uap)
@@ -1251,7 +1261,7 @@ __acquires(&uap->port.lock)
 			dev_dbg(uap->port.dev, "could not trigger RX DMA job "
 				"fall back to interrupt mode again\n");
 			uap->im |= UART011_RXIM;
-			pl011_write(uap->im, uap, UART011_IMSC);
+			pl011_write(uap->im, uap, REG_IMSC);
 		} else {
 #ifdef CONFIG_DMA_ENGINE
 			/* Start Rx DMA poll */
@@ -1272,10 +1282,10 @@ static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
 			  bool from_irq)
 {
 	if (unlikely(!from_irq) &&
-	    pl011_read(uap, UART01x_FR) & UART01x_FR_TXFF)
+	    pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
 		return false; /* unable to transmit character */
 
-	pl011_write(c, uap, UART01x_DR);
+	pl011_write(c, uap, REG_DR);
 	uap->port.icount.tx++;
 
 	return true;
@@ -1322,7 +1332,7 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 {
 	unsigned int status, delta;
 
-	status = pl011_read(uap, UART01x_FR) & UART01x_FR_MODEM_ANY;
+	status = pl011_read(uap, REG_FR) & UART01x_FR_MODEM_ANY;
 
 	delta = status ^ uap->old_status;
 	uap->old_status = status;
@@ -1350,15 +1360,15 @@ static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
 		return;
 
 	/* workaround to make sure that all bits are unlocked.. */
-	pl011_write(0x00, uap, UART011_ICR);
+	pl011_write(0x00, uap, REG_ICR);
 
 	/*
 	 * WA: introduce 26ns(1 uart clk) delay before W1C;
 	 * single apb access will incur 2 pclk(133.12Mhz) delay,
 	 * so add 2 dummy reads
 	 */
-	dummy_read = pl011_read(uap, UART011_ICR);
-	dummy_read = pl011_read(uap, UART011_ICR);
+	dummy_read = pl011_read(uap, REG_ICR);
+	dummy_read = pl011_read(uap, REG_ICR);
 }
 
 static irqreturn_t pl011_int(int irq, void *dev_id)
@@ -1370,15 +1380,15 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	int handled = 0;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
-	imsc = pl011_read(uap, UART011_IMSC);
-	status = pl011_read(uap, UART011_RIS) & imsc;
+	imsc = pl011_read(uap, REG_IMSC);
+	status = pl011_read(uap, REG_RIS) & imsc;
 	if (status) {
 		do {
 			check_apply_cts_event_workaround(uap);
 
 			pl011_write(status & ~(UART011_TXIS|UART011_RTIS|
 					       UART011_RXIS),
-				    uap, UART011_ICR);
+				    uap, REG_ICR);
 
 			if (status & (UART011_RTIS|UART011_RXIS)) {
 				if (pl011_dma_rx_running(uap))
@@ -1395,7 +1405,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 			if (pass_counter-- == 0)
 				break;
 
-			status = pl011_read(uap, UART011_RIS) & imsc;
+			status = pl011_read(uap, REG_RIS) & imsc;
 		} while (status != 0);
 		handled = 1;
 	}
@@ -1409,7 +1419,7 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
-	unsigned int status = pl011_read(uap, UART01x_FR);
+	unsigned int status = pl011_read(uap, REG_FR);
 	return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
 }
 
@@ -1418,7 +1428,7 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 	unsigned int result = 0;
-	unsigned int status = pl011_read(uap, UART01x_FR);
+	unsigned int status = pl011_read(uap, REG_FR);
 
 #define TIOCMBIT(uartbit, tiocmbit)	\
 	if (status & uartbit)		\
@@ -1438,7 +1448,7 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	    container_of(port, struct uart_amba_port, port);
 	unsigned int cr;
 
-	cr = pl011_read(uap, UART011_CR);
+	cr = pl011_read(uap, REG_CR);
 
 #define	TIOCMBIT(tiocmbit, uartbit)		\
 	if (mctrl & tiocmbit)		\
@@ -1458,7 +1468,7 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	}
 #undef TIOCMBIT
 
-	pl011_write(cr, uap, UART011_CR);
+	pl011_write(cr, uap, REG_CR);
 }
 
 static void pl011_break_ctl(struct uart_port *port, int break_state)
@@ -1485,7 +1495,7 @@ static void pl011_quiesce_irqs(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	pl011_write(pl011_read(uap, UART011_MIS), uap, UART011_ICR);
+	pl011_write(pl011_read(uap, REG_MIS), uap, REG_ICR);
 	/*
 	 * There is no way to clear TXIM as this is "ready to transmit IRQ", so
 	 * we simply mask it. start_tx() will unmask it.
@@ -1499,8 +1509,8 @@ static void pl011_quiesce_irqs(struct uart_port *port)
 	 * (including tx queue), so we're also fine with start_tx()'s caller
 	 * side.
 	 */
-	pl011_write(pl011_read(uap, UART011_IMSC) & ~UART011_TXIM, uap,
-		    UART011_IMSC);
+	pl011_write(pl011_read(uap, REG_IMSC) & ~UART011_TXIM, uap,
+		    REG_IMSC);
 }
 
 static int pl011_get_poll_char(struct uart_port *port)
@@ -1515,11 +1525,11 @@ static int pl011_get_poll_char(struct uart_port *port)
 	 */
 	pl011_quiesce_irqs(port);
 
-	status = pl011_read(uap, UART01x_FR);
+	status = pl011_read(uap, REG_FR);
 	if (status & UART01x_FR_RXFE)
 		return NO_POLL_CHAR;
 
-	return pl011_read(uap, UART01x_DR);
+	return pl011_read(uap, REG_DR);
 }
 
 static void pl011_put_poll_char(struct uart_port *port,
@@ -1528,10 +1538,10 @@ static void pl011_put_poll_char(struct uart_port *port,
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	while (pl011_read(uap, UART01x_FR) & UART01x_FR_TXFF)
+	while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
 		barrier();
 
-	pl011_write(ch, uap, UART01x_DR);
+	pl011_write(ch, uap, REG_DR);
 }
 
 #endif /* CONFIG_CONSOLE_POLL */
@@ -1557,14 +1567,14 @@ static int pl011_hwinit(struct uart_port *port)
 	/* Clear pending error and receive interrupts */
 	pl011_write(UART011_OEIS | UART011_BEIS | UART011_PEIS |
 		    UART011_FEIS | UART011_RTIS | UART011_RXIS,
-		    uap, UART011_ICR);
+		    uap, REG_ICR);
 
 	/*
 	 * Save interrupts enable mask, and enable RX interrupts in case if
 	 * the interrupt is used for NMI entry.
 	 */
-	uap->im = pl011_read(uap, UART011_IMSC);
-	pl011_write(UART011_RTIM | UART011_RXIM, uap, UART011_IMSC);
+	uap->im = pl011_read(uap, REG_IMSC);
+	pl011_write(UART011_RTIM | UART011_RXIM, uap, REG_IMSC);
 
 	if (dev_get_platdata(uap->port.dev)) {
 		struct amba_pl011_data *plat;
@@ -1578,7 +1588,8 @@ static int pl011_hwinit(struct uart_port *port)
 
 static bool pl011_split_lcrh(const struct uart_amba_port *uap)
 {
-	return uap->lcrh_rx != uap->lcrh_tx;
+	return pl011_reg_to_offset(uap, uap->lcrh_rx) !=
+	       pl011_reg_to_offset(uap, uap->lcrh_tx);
 }
 
 static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
@@ -1591,14 +1602,14 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 		 * to get this delay write read only register 10 times
 		 */
 		for (i = 0; i < 10; ++i)
-			pl011_write(0xff, uap, UART011_MIS);
+			pl011_write(0xff, uap, REG_MIS);
 		pl011_write(lcr_h, uap, uap->lcrh_tx);
 	}
 }
 
 static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
-	pl011_write(uap->im, uap, UART011_IMSC);
+	pl011_write(uap->im, uap, REG_IMSC);
 
 	return request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
 }
@@ -1613,11 +1624,11 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 	spin_lock_irq(&uap->port.lock);
 
 	/* Clear out any spuriously appearing RX interrupts */
-	pl011_write(UART011_RTIS | UART011_RXIS, uap, UART011_ICR);
+	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
 	uap->im = UART011_RTIM;
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
-	pl011_write(uap->im, uap, UART011_IMSC);
+	pl011_write(uap->im, uap, REG_IMSC);
 	spin_unlock_irq(&uap->port.lock);
 }
 
@@ -1636,21 +1647,21 @@ static int pl011_startup(struct uart_port *port)
 	if (retval)
 		goto clk_dis;
 
-	pl011_write(uap->vendor->ifls, uap, UART011_IFLS);
+	pl011_write(uap->vendor->ifls, uap, REG_IFLS);
 
 	spin_lock_irq(&uap->port.lock);
 
 	/* restore RTS and DTR */
 	cr = uap->old_cr & (UART011_CR_RTS | UART011_CR_DTR);
 	cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
-	pl011_write(cr, uap, UART011_CR);
+	pl011_write(cr, uap, REG_CR);
 
 	spin_unlock_irq(&uap->port.lock);
 
 	/*
 	 * initialise the old status of the modem signals
 	 */
-	uap->old_status = pl011_read(uap, UART01x_FR) & UART01x_FR_MODEM_ANY;
+	uap->old_status = pl011_read(uap, REG_FR) & UART01x_FR_MODEM_ANY;
 
 	/* Startup DMA */
 	pl011_dma_startup(uap);
@@ -1707,11 +1718,11 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
 
 	uap->autorts = false;
 	spin_lock_irq(&uap->port.lock);
-	cr = pl011_read(uap, UART011_CR);
+	cr = pl011_read(uap, REG_CR);
 	uap->old_cr = cr;
 	cr &= UART011_CR_RTS | UART011_CR_DTR;
 	cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
-	pl011_write(cr, uap, UART011_CR);
+	pl011_write(cr, uap, REG_CR);
 	spin_unlock_irq(&uap->port.lock);
 
 	/*
@@ -1728,8 +1739,8 @@ static void pl011_disable_interrupts(struct uart_amba_port *uap)
 
 	/* mask all interrupts and clear all pending ones */
 	uap->im = 0;
-	pl011_write(uap->im, uap, UART011_IMSC);
-	pl011_write(0xffff, uap, UART011_ICR);
+	pl011_write(uap->im, uap, REG_IMSC);
+	pl011_write(0xffff, uap, REG_ICR);
 
 	spin_unlock_irq(&uap->port.lock);
 }
@@ -1881,8 +1892,8 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		pl011_enable_ms(port);
 
 	/* first, disable everything */
-	old_cr = pl011_read(uap, UART011_CR);
-	pl011_write(0, uap, UART011_CR);
+	old_cr = pl011_read(uap, REG_CR);
+	pl011_write(0, uap, REG_CR);
 
 	if (termios->c_cflag & CRTSCTS) {
 		if (old_cr & UART011_CR_RTS)
@@ -1915,17 +1926,17 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 			quot -= 2;
 	}
 	/* Set baud rate */
-	pl011_write(quot & 0x3f, uap, UART011_FBRD);
-	pl011_write(quot >> 6, uap, UART011_IBRD);
+	pl011_write(quot & 0x3f, uap, REG_FBRD);
+	pl011_write(quot >> 6, uap, REG_IBRD);
 
 	/*
 	 * ----------v----------v----------v----------v-----
 	 * NOTE: lcrh_tx and lcrh_rx MUST BE WRITTEN AFTER
-	 * UART011_FBRD & UART011_IBRD.
+	 * REG_FBRD & REG_IBRD.
 	 * ----------^----------^----------^----------^-----
 	 */
 	pl011_write_lcr_h(uap, lcr_h);
-	pl011_write(old_cr, uap, UART011_CR);
+	pl011_write(old_cr, uap, REG_CR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -2066,9 +2077,9 @@ static void pl011_console_putchar(struct uart_port *port, int ch)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
-	while (pl011_read(uap, UART01x_FR) & UART01x_FR_TXFF)
+	while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
 		barrier();
-	pl011_write(ch, uap, UART01x_DR);
+	pl011_write(ch, uap, REG_DR);
 }
 
 static void
@@ -2093,10 +2104,10 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	 *	First save the CR then disable the interrupts
 	 */
 	if (!uap->vendor->always_enabled) {
-		old_cr = pl011_read(uap, UART011_CR);
+		old_cr = pl011_read(uap, REG_CR);
 		new_cr = old_cr & ~UART011_CR_CTSEN;
 		new_cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
-		pl011_write(new_cr, uap, UART011_CR);
+		pl011_write(new_cr, uap, REG_CR);
 	}
 
 	uart_console_write(&uap->port, s, count, pl011_console_putchar);
@@ -2106,10 +2117,10 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	 *	and restore the TCR
 	 */
 	do {
-		status = pl011_read(uap, UART01x_FR);
+		status = pl011_read(uap, REG_FR);
 	} while (status & UART01x_FR_BUSY);
 	if (!uap->vendor->always_enabled)
-		pl011_write(old_cr, uap, UART011_CR);
+		pl011_write(old_cr, uap, REG_CR);
 
 	if (locked)
 		spin_unlock(&uap->port.lock);
@@ -2122,7 +2133,7 @@ static void __init
 pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 			     int *parity, int *bits)
 {
-	if (pl011_read(uap, UART011_CR) & UART01x_CR_UARTEN) {
+	if (pl011_read(uap, REG_CR) & UART01x_CR_UARTEN) {
 		unsigned int lcr_h, ibrd, fbrd;
 
 		lcr_h = pl011_read(uap, uap->lcrh_tx);
@@ -2140,13 +2151,13 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 		else
 			*bits = 8;
 
-		ibrd = pl011_read(uap, UART011_IBRD);
-		fbrd = pl011_read(uap, UART011_FBRD);
+		ibrd = pl011_read(uap, REG_IBRD);
+		fbrd = pl011_read(uap, REG_FBRD);
 
 		*baud = uap->port.uartclk * 4 / (64 * ibrd + fbrd);
 
 		if (uap->vendor->oversampling) {
-			if (pl011_read(uap, UART011_CR)
+			if (pl011_read(uap, REG_CR)
 				  & ST_UART011_CR_OVSFACT)
 				*baud *= 2;
 		}
@@ -2218,10 +2229,10 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
-	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+	while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
 		;
-	writeb(c, port->membase + UART01x_DR);
-	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
+	writeb(c, port->membase + REG_DR);
+	while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
 		;
 }
 
@@ -2348,8 +2359,8 @@ static int pl011_register_port(struct uart_amba_port *uap)
 	int ret;
 
 	/* Ensure interrupts from this UART are masked and cleared */
-	pl011_write(0, uap, UART011_IMSC);
-	pl011_write(0xffff, uap, UART011_ICR);
+	pl011_write(0, uap, REG_IMSC);
+	pl011_write(0xffff, uap, REG_ICR);
 
 	if (!amba_reg.state) {
 		ret = uart_register_driver(&amba_reg);
diff --git a/drivers/tty/serial/amba-pl011.h b/drivers/tty/serial/amba-pl011.h
new file mode 100644
index 000000000000..b7eb1bc2fab9
--- /dev/null
+++ b/drivers/tty/serial/amba-pl011.h
@@ -0,0 +1,32 @@
+#ifndef AMBA_PL011_H
+#define AMBA_PL011_H
+
+enum {
+	REG_DR = UART01x_DR,
+	REG_ST_DMAWM = ST_UART011_DMAWM,
+	REG_ST_TIMEOUT = ST_UART011_TIMEOUT,
+	REG_FR = UART01x_FR,
+	REG_ST_LCRH_RX = ST_UART011_LCRH_RX,
+	REG_IBRD = UART011_IBRD,
+	REG_FBRD = UART011_FBRD,
+	REG_LCRH = UART011_LCRH,
+	REG_ST_LCRH_TX = ST_UART011_LCRH_TX,
+	REG_CR = UART011_CR,
+	REG_IFLS = UART011_IFLS,
+	REG_IMSC = UART011_IMSC,
+	REG_RIS = UART011_RIS,
+	REG_MIS = UART011_MIS,
+	REG_ICR = UART011_ICR,
+	REG_DMACR = UART011_DMACR,
+	REG_ST_XFCR = ST_UART011_XFCR,
+	REG_ST_XON1 = ST_UART011_XON1,
+	REG_ST_XON2 = ST_UART011_XON2,
+	REG_ST_XOFF1 = ST_UART011_XOFF1,
+	REG_ST_XOFF2 = ST_UART011_XOFF2,
+	REG_ST_ITCR = ST_UART011_ITCR,
+	REG_ST_ITIP = ST_UART011_ITIP,
+	REG_ST_ABCR = ST_UART011_ABCR,
+	REG_ST_ABIMSC = ST_UART011_ABIMSC,
+};
+
+#endif
-- 
2.1.0
