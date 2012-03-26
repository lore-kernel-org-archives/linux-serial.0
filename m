From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH v2] serial: pl011: implement workaround for CTS clear event
 issue
Date: Mon, 26 Mar 2012 11:17:02 +0200
Message-ID: <1332753422-12178-1-git-send-email-linus.walleij@stericsson.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Christophe Arnal <christophe.arnal@stericsson.com>, Guillaume Jaunet <guillaume.jaunet@stericsson.com>, Matthias Locher <Matthias.Locher@stericsson.com>, Chanho Min <chanho0207@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>
List-Id: linux-serial@vger.kernel.org

From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

Problem Observed:
- interrupt status is set by rising or falling edge on CTS line
- interrupt status is cleared on a .0. to .1. transition of the
  interrupt-clear register bit 1.
- interrupt-clear register is reset by hardware once the interrupt
  status is .0..
  Remark: It seems not possible to read this register back by the
  CPU though, but internally this register exists.
- when simultaneous set and reset event on the interrupt status
  happens, then the set-event has priority and the status remains
  .1.. As a result the interrupt-clear register is not reset to
  .0., and no new .0. to .1. transition can be detected on it when
  writing a .1. to it.
  This implies race condition, the clear must be performed at least
  one UARTCLK the riding edge of CTS RIS interrupt.

Fix:
  Instead of resetting UART as done in commit
  c16d51a32bbb61ac8fd96f78b5ce2fccfe0fb4c3
  "amba pl011: workaround for uart registers lockup" do the
  following:

  write .0. and then  .1. to the interrupt-clear register to make
  sure that this transition is detected. According to the datasheet
  writing a .0. does not have any effect, but actually it allows to
  reset the internal interrupt-clear register.

  Take into account:
  The .0. needs to last at least for one clk_uart clock period
  (~ 38 MHz, 26.08ns)

This way we can do away with the tasklet and keep only a tiny
fix triggered by the variant flag introduced in this patch.

Signed-off-by: Guillaume Jaunet <guillaume.jaunet@stericsson.com>
Signed-off-by: Christophe Arnal <christophe.arnal@stericsson.com>
Signed-off-by: Matthias Locher  <Matthias.Locher@stericsson.com>
Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Restore the ISR loop lockup guard pass_counter to what it was
  before the lockup fix tasklet was introduced.
---
 drivers/tty/serial/amba-pl011.c |  109 +++++++--------------------------------
 1 file changed, 18 insertions(+), 91 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4ed35c5..5001a88 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -66,30 +66,6 @@
 #define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
 #define UART_DUMMY_DR_RX	(1 << 16)
 
-
-#define UART_WA_SAVE_NR 14
-
-static void pl011_lockup_wa(unsigned long data);
-static const u32 uart_wa_reg[UART_WA_SAVE_NR] = {
-	ST_UART011_DMAWM,
-	ST_UART011_TIMEOUT,
-	ST_UART011_LCRH_RX,
-	UART011_IBRD,
-	UART011_FBRD,
-	ST_UART011_LCRH_TX,
-	UART011_IFLS,
-	ST_UART011_XFCR,
-	ST_UART011_XON1,
-	ST_UART011_XON2,
-	ST_UART011_XOFF1,
-	ST_UART011_XOFF2,
-	UART011_CR,
-	UART011_IMSC
-};
-
-static u32 uart_wa_regdata[UART_WA_SAVE_NR];
-static DECLARE_TASKLET(pl011_lockup_tlet, pl011_lockup_wa, 0);
-
 /* There is by now at least one vendor with differing details, so handle it */
 struct vendor_data {
 	unsigned int		ifls;
@@ -99,6 +75,7 @@ struct vendor_data {
 	bool			oversampling;
 	bool			interrupt_may_hang;   /* vendor-specific */
 	bool			dma_threshold;
+	bool			cts_event_workaround;
 };
 
 static struct vendor_data vendor_arm = {
@@ -108,6 +85,7 @@ static struct vendor_data vendor_arm = {
 	.lcrh_rx		= UART011_LCRH,
 	.oversampling		= false,
 	.dma_threshold		= false,
+	.cts_event_workaround	= false,
 };
 
 static struct vendor_data vendor_st = {
@@ -118,6 +96,7 @@ static struct vendor_data vendor_st = {
 	.oversampling		= true,
 	.interrupt_may_hang	= true,
 	.dma_threshold		= true,
+	.cts_event_workaround	= true,
 };
 
 static struct uart_amba_port *amba_ports[UART_NR];
@@ -1038,69 +1017,6 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 #define pl011_dma_flush_buffer	NULL
 #endif
 
-
-/*
- * pl011_lockup_wa
- * This workaround aims to break the deadlock situation
- * when after long transfer over uart in hardware flow
- * control, uart interrupt registers cannot be cleared.
- * Hence uart transfer gets blocked.
- *
- * It is seen that during such deadlock condition ICR
- * don't get cleared even on multiple write. This leads
- * pass_counter to decrease and finally reach zero. This
- * can be taken as trigger point to run this UART_BT_WA.
- *
- */
-static void pl011_lockup_wa(unsigned long data)
-{
-	struct uart_amba_port *uap = amba_ports[0];
-	void __iomem *base = uap->port.membase;
-	struct circ_buf *xmit = &uap->port.state->xmit;
-	struct tty_struct *tty = uap->port.state->port.tty;
-	int buf_empty_retries = 200;
-	int loop;
-
-	/* Stop HCI layer from submitting data for tx */
-	tty->hw_stopped = 1;
-	while (!uart_circ_empty(xmit)) {
-		if (buf_empty_retries-- == 0)
-			break;
-		udelay(100);
-	}
-
-	/* Backup registers */
-	for (loop = 0; loop < UART_WA_SAVE_NR; loop++)
-		uart_wa_regdata[loop] = readl(base + uart_wa_reg[loop]);
-
-	/* Disable UART so that FIFO data is flushed out */
-	writew(0x00, uap->port.membase + UART011_CR);
-
-	/* Soft reset UART module */
-	if (uap->port.dev->platform_data) {
-		struct amba_pl011_data *plat;
-
-		plat = uap->port.dev->platform_data;
-		if (plat->reset)
-			plat->reset();
-	}
-
-	/* Restore registers */
-	for (loop = 0; loop < UART_WA_SAVE_NR; loop++)
-		writew(uart_wa_regdata[loop] ,
-				uap->port.membase + uart_wa_reg[loop]);
-
-	/* Initialise the old status of the modem signals */
-	uap->old_status = readw(uap->port.membase + UART01x_FR) &
-		UART01x_FR_MODEM_ANY;
-
-	if (readl(base + UART011_MIS) & 0x2)
-		printk(KERN_EMERG "UART_BT_WA: ***FAILED***\n");
-
-	/* Start Tx/Rx */
-	tty->hw_stopped = 0;
-}
-
 static void pl011_stop_tx(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
@@ -1229,12 +1145,26 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	unsigned long flags;
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
 	int handled = 0;
+	unsigned int dummy_read;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
 
 	status = readw(uap->port.membase + UART011_MIS);
 	if (status) {
 		do {
+			if (uap->vendor->cts_event_workaround) {
+				/* workaround to make sure that all bits are unlocked.. */
+				writew(0x00, uap->port.membase + UART011_ICR);
+
+				/*
+				 * WA: introduce 26ns(1 uart clk) delay before W1C;
+				 * single apb access will incur 2 pclk(133.12Mhz) delay,
+				 * so add 2 dummy reads
+				 */
+				dummy_read = readw(uap->port.membase + UART011_ICR);
+				dummy_read = readw(uap->port.membase + UART011_ICR);
+			}
+
 			writew(status & ~(UART011_TXIS|UART011_RTIS|
 					  UART011_RXIS),
 			       uap->port.membase + UART011_ICR);
@@ -1251,11 +1181,8 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 			if (status & UART011_TXIS)
 				pl011_tx_chars(uap);
 
-			if (pass_counter-- == 0) {
-				if (uap->interrupt_may_hang)
-					tasklet_schedule(&pl011_lockup_tlet);
+			if (pass_counter-- == 0)
 				break;
-			}
 
 			status = readw(uap->port.membase + UART011_MIS);
 		} while (status != 0);
-- 
1.7.9.2
