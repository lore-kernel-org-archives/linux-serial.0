From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 08/12] tty: amba-pl011: clean up LCR register offsets
Date: Mon, 16 Nov 2015 17:40:41 +0000
Message-ID: <E1ZyNlh-0003jy-O4@rmk-PC.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
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

As we can detect when the LCR register is split between TX and RX,
we don't need three entries in the table to deal with this.  Reduce
this down to two entries by converting the REG_ST_LCRH_* entries to
standard REG_LCRH_* and remove REG_LCRH.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 40 ++++++++++++++--------------------------
 drivers/tty/serial/amba-pl011.h |  5 ++---
 2 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d822c5019927..f859aea50dbc 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -78,11 +78,10 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
 	[REG_ST_DMAWM] = ST_UART011_DMAWM,
 	[REG_ST_TIMEOUT] = ST_UART011_TIMEOUT,
 	[REG_FR] = UART01x_FR,
-	[REG_ST_LCRH_RX] = ST_UART011_LCRH_RX,
+	[REG_LCRH_RX] = UART011_LCRH,
+	[REG_LCRH_TX] = UART011_LCRH,
 	[REG_IBRD] = UART011_IBRD,
 	[REG_FBRD] = UART011_FBRD,
-	[REG_LCRH] = UART011_LCRH,
-	[REG_ST_LCRH_TX] = ST_UART011_LCRH_TX,
 	[REG_CR] = UART011_CR,
 	[REG_IFLS] = UART011_IFLS,
 	[REG_IMSC] = UART011_IMSC,
@@ -105,8 +104,6 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
 struct vendor_data {
 	const u16		*reg_offset;
 	unsigned int		ifls;
-	unsigned int		lcrh_tx;
-	unsigned int		lcrh_rx;
 	bool			oversampling;
 	bool			dma_threshold;
 	bool			cts_event_workaround;
@@ -124,8 +121,6 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
 static struct vendor_data vendor_arm = {
 	.reg_offset		= pl011_std_offsets,
 	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
-	.lcrh_tx		= REG_LCRH,
-	.lcrh_rx		= REG_LCRH,
 	.oversampling		= false,
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
@@ -148,11 +143,10 @@ static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
 	[REG_ST_DMAWM] = ST_UART011_DMAWM,
 	[REG_ST_TIMEOUT] = ST_UART011_TIMEOUT,
 	[REG_FR] = UART01x_FR,
-	[REG_ST_LCRH_RX] = ST_UART011_LCRH_RX,
+	[REG_LCRH_RX] = ST_UART011_LCRH_RX,
+	[REG_LCRH_TX] = ST_UART011_LCRH_TX,
 	[REG_IBRD] = UART011_IBRD,
 	[REG_FBRD] = UART011_FBRD,
-	[REG_LCRH] = UART011_LCRH,
-	[REG_ST_LCRH_TX] = ST_UART011_LCRH_TX,
 	[REG_CR] = UART011_CR,
 	[REG_IFLS] = UART011_IFLS,
 	[REG_IMSC] = UART011_IMSC,
@@ -179,8 +173,6 @@ static unsigned int get_fifosize_st(struct amba_device *dev)
 static struct vendor_data vendor_st = {
 	.reg_offset		= pl011_st_offsets,
 	.ifls			= UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
-	.lcrh_tx		= REG_ST_LCRH_TX,
-	.lcrh_rx		= REG_ST_LCRH_RX,
 	.oversampling		= true,
 	.dma_threshold		= true,
 	.cts_event_workaround	= true,
@@ -231,8 +223,6 @@ struct uart_amba_port {
 	unsigned int		im;		/* interrupt mask */
 	unsigned int		old_status;
 	unsigned int		fifosize;	/* vendor-specific */
-	unsigned int		lcrh_tx;	/* vendor-specific */
-	unsigned int		lcrh_rx;	/* vendor-specific */
 	unsigned int		old_cr;		/* state during shutdown */
 	bool			autorts;
 	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
@@ -1540,12 +1530,12 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 	unsigned int lcr_h;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
-	lcr_h = pl011_read(uap, uap->lcrh_tx);
+	lcr_h = pl011_read(uap, REG_LCRH_TX);
 	if (break_state == -1)
 		lcr_h |= UART01x_LCRH_BRK;
 	else
 		lcr_h &= ~UART01x_LCRH_BRK;
-	pl011_write(lcr_h, uap, uap->lcrh_tx);
+	pl011_write(lcr_h, uap, REG_LCRH_TX);
 	spin_unlock_irqrestore(&uap->port.lock, flags);
 }
 
@@ -1649,13 +1639,13 @@ static int pl011_hwinit(struct uart_port *port)
 
 static bool pl011_split_lcrh(const struct uart_amba_port *uap)
 {
-	return pl011_reg_to_offset(uap, uap->lcrh_rx) !=
-	       pl011_reg_to_offset(uap, uap->lcrh_tx);
+	return pl011_reg_to_offset(uap, REG_LCRH_RX) !=
+	       pl011_reg_to_offset(uap, REG_LCRH_TX);
 }
 
 static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 {
-	pl011_write(lcr_h, uap, uap->lcrh_rx);
+	pl011_write(lcr_h, uap, REG_LCRH_RX);
 	if (pl011_split_lcrh(uap)) {
 		int i;
 		/*
@@ -1664,7 +1654,7 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 		 */
 		for (i = 0; i < 10; ++i)
 			pl011_write(0xff, uap, REG_MIS);
-		pl011_write(lcr_h, uap, uap->lcrh_tx);
+		pl011_write(lcr_h, uap, REG_LCRH_TX);
 	}
 }
 
@@ -1789,9 +1779,9 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
 	/*
 	 * disable break condition and fifos
 	 */
-	pl011_shutdown_channel(uap, uap->lcrh_rx);
+	pl011_shutdown_channel(uap, REG_LCRH_RX);
 	if (pl011_split_lcrh(uap))
-		pl011_shutdown_channel(uap, uap->lcrh_tx);
+		pl011_shutdown_channel(uap, REG_LCRH_TX);
 }
 
 static void pl011_disable_interrupts(struct uart_amba_port *uap)
@@ -1992,7 +1982,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/*
 	 * ----------v----------v----------v----------v-----
-	 * NOTE: lcrh_tx and lcrh_rx MUST BE WRITTEN AFTER
+	 * NOTE: REG_LCRH_TX and REG_LCRH_RX MUST BE WRITTEN AFTER
 	 * REG_FBRD & REG_IBRD.
 	 * ----------^----------^----------^----------^-----
 	 */
@@ -2197,7 +2187,7 @@ pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 	if (pl011_read(uap, REG_CR) & UART01x_CR_UARTEN) {
 		unsigned int lcr_h, ibrd, fbrd;
 
-		lcr_h = pl011_read(uap, uap->lcrh_tx);
+		lcr_h = pl011_read(uap, REG_LCRH_TX);
 
 		*parity = 'n';
 		if (lcr_h & UART01x_LCRH_PEN) {
@@ -2460,8 +2450,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 
 	uap->reg_offset = vendor->reg_offset;
 	uap->vendor = vendor;
-	uap->lcrh_rx = vendor->lcrh_rx;
-	uap->lcrh_tx = vendor->lcrh_tx;
 	uap->fifosize = vendor->get_fifosize(dev);
 	uap->port.irq = dev->irq[0];
 	uap->port.ops = &amba_pl011_pops;
diff --git a/drivers/tty/serial/amba-pl011.h b/drivers/tty/serial/amba-pl011.h
index 0c6756dba2fe..411c60e1f9a4 100644
--- a/drivers/tty/serial/amba-pl011.h
+++ b/drivers/tty/serial/amba-pl011.h
@@ -6,11 +6,10 @@ enum {
 	REG_ST_DMAWM,
 	REG_ST_TIMEOUT,
 	REG_FR,
-	REG_ST_LCRH_RX,
+	REG_LCRH_RX,
+	REG_LCRH_TX,
 	REG_IBRD,
 	REG_FBRD,
-	REG_LCRH,
-	REG_ST_LCRH_TX,
 	REG_CR,
 	REG_IFLS,
 	REG_IMSC,
-- 
2.1.0
