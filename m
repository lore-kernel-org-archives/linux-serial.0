From: Brian Murphy <brian@murphy.dk>
Subject: [PATCH] 8250 interrupt handling redesign and consequent removal of
	special bug handling
Date: Tue, 5 Jan 2010 13:13:44 +0100
Message-ID: <b41414a41001050413u7c0b2b91rd39de3f033589ff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:50557 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0AEMNr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Jan 2010 07:13:47 -0500
Received: by ey-out-2122.google.com with SMTP id 22so378956eye.19
        for <linux-serial@vger.kernel.org>; Tue, 05 Jan 2010 04:13:45 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This patch changes the standard 8250 serial driver which
so that if the uart is not active filling the fifo begins
immediately. This is the opposite of the current principal
where the driver waits for the fifo empty interrupt before
beginning transmission.

This change means that uarts which do not signal fifo empty
on enabling interrupts work without any special handling.
"Standard" uarts should still work fine.

The patch removes the two UART_BUGs UART_BUG_TXEN and UART_BUG_THRE
and replaces the code which handled them by a simple check on whether
we have already started the transmit process and if not start writing
directly to the fifo in all cases.

The patch also removes the no longer necessary fake interrupt/poll
function serial8250_backup_timeout and the probe code for detecting
the two bugs named above.

Signed-off-by: Brian Murphy <brian@murphy.dk>
---
 drivers/serial/8250.c |  153 ++++++++++---------------------------------------
 drivers/serial/8250.h |    4 +-
 2 files changed, 31 insertions(+), 126 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 737b4c9..ca2962c 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -150,6 +150,7 @@ struct uart_8250_port {
 	unsigned char		lsr_saved_flags;
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
+	unsigned char		tx_active;

 	/*
 	 * We provide a per-port pm hook.
@@ -524,25 +525,6 @@ static void set_io_from_upio(struct uart_port *p)
 	up->cur_iotype = p->iotype;
 }

-static void
-serial_out_sync(struct uart_8250_port *up, int offset, int value)
-{
-	struct uart_port *p = &up->port;
-	switch (p->iotype) {
-	case UPIO_MEM:
-	case UPIO_MEM32:
-#ifdef CONFIG_SERIAL_8250_AU1X00
-	case UPIO_AU:
-#endif
-	case UPIO_DWAPB:
-		p->serial_out(p, offset, value);
-		p->serial_in(p, UART_LCR);	/* safe, no side-effects */
-		break;
-	default:
-		p->serial_out(p, offset, value);
-	}
-}
-
 #define serial_in(up, offset)		\
 	(up->port.serial_in(&(up)->port, (offset)))
 #define serial_out(up, offset, value)	\
@@ -1311,14 +1293,20 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		p->ier &= ~UART_IER_THRI;
 		serial_out(p, UART_IER, p->ier);
 	}
+	p->tx_active = 0;
 }

 static void serial8250_stop_tx(struct uart_port *port)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&up->port.lock, flags);

 	__stop_tx(up);

+	spin_unlock_irqrestore(&up->port.lock, flags);
+
 	/*
 	 * We really want to stop the transmitter from sending.
 	 */
@@ -1333,24 +1321,23 @@ static void transmit_chars(struct uart_8250_port *up);
 static void serial8250_start_tx(struct uart_port *port)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&up->port.lock, flags);

 	if (!(up->ier & UART_IER_THRI)) {
 		up->ier |= UART_IER_THRI;
 		serial_out(up, UART_IER, up->ier);
+	}

-		if (up->bugs & UART_BUG_TXEN) {
-			unsigned char lsr, iir;
-			lsr = serial_in(up, UART_LSR);
-			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-			iir = serial_in(up, UART_IIR) & 0x0f;
-			if ((up->port.type == PORT_RM9000) ?
-				(lsr & UART_LSR_THRE &&
-				(iir == UART_IIR_NO_INT || iir == UART_IIR_THRI)) :
-				(lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT))
-				transmit_chars(up);
-		}
+	if (!up->tx_active)
+	{
+		up->tx_active = 1;
+		transmit_chars(up);
 	}

+	spin_unlock_irqrestore(&up->port.lock, flags);
+
 	/*
 	 * Re-enable the transmitter if we disabled it.
 	 */
@@ -1490,9 +1477,6 @@ static void transmit_chars(struct uart_8250_port *up)
 		uart_write_wakeup(&up->port);

 	DEBUG_INTR("THRE...");
-
-	if (uart_circ_empty(xmit))
-		__stop_tx(up);
 }

 static unsigned int check_modem_status(struct uart_8250_port *up)
@@ -1521,12 +1505,9 @@ static unsigned int check_modem_status(struct
uart_8250_port *up)
 /*
  * This handles the interrupt from one port.
  */
-static void serial8250_handle_port(struct uart_8250_port *up)
+static void __serial8250_handle_port(struct uart_8250_port *up)
 {
 	unsigned int status;
-	unsigned long flags;
-
-	spin_lock_irqsave(&up->port.lock, flags);

 	status = serial_inp(up, UART_LSR);

@@ -1536,8 +1517,18 @@ static void serial8250_handle_port(struct
uart_8250_port *up)
 		receive_chars(up, &status);
 	check_modem_status(up);
 	if (status & UART_LSR_THRE)
+	{
+		up->tx_active = 1;
 		transmit_chars(up);
+	}
+}

+static void serial8250_handle_port(struct uart_8250_port *up)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	__serial8250_handle_port(up);
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }

@@ -1574,7 +1565,7 @@ static irqreturn_t serial8250_interrupt(int irq,
void *dev_id)

 		iir = serial_in(up, UART_IIR);
 		if (!(iir & UART_IIR_NO_INT)) {
-			serial8250_handle_port(up);
+			__serial8250_handle_port(up);

 			handled = 1;

@@ -1944,9 +1935,9 @@ static int serial8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned long flags;
-	unsigned char lsr, iir;
 	int retval;

+	up->tx_active = 0;
 	up->capabilities = uart_config[up->port.type].flags;
 	up->mcr = 0;

@@ -2017,56 +2008,6 @@ static int serial8250_startup(struct uart_port *port)
 		serial_outp(up, UART_LCR, 0);
 	}

-	if (is_real_interrupt(up->port.irq)) {
-		unsigned char iir1;
-		/*
-		 * Test for UARTs that do not reassert THRE when the
-		 * transmitter is idle and the interrupt has already
-		 * been cleared.  Real 16550s should always reassert
-		 * this interrupt whenever the transmitter is idle and
-		 * the interrupt is enabled.  Delays are necessary to
-		 * allow register changes to become visible.
-		 */
-		spin_lock_irqsave(&up->port.lock, flags);
-		if (up->port.irqflags & IRQF_SHARED)
-			disable_irq_nosync(up->port.irq);
-
-		wait_for_xmitr(up, UART_LSR_THRE);
-		serial_out_sync(up, UART_IER, UART_IER_THRI);
-		udelay(1); /* allow THRE to set */
-		iir1 = serial_in(up, UART_IIR);
-		serial_out(up, UART_IER, 0);
-		serial_out_sync(up, UART_IER, UART_IER_THRI);
-		udelay(1); /* allow a working UART time to re-assert THRE */
-		iir = serial_in(up, UART_IIR);
-		serial_out(up, UART_IER, 0);
-
-		if (up->port.irqflags & IRQF_SHARED)
-			enable_irq(up->port.irq);
-		spin_unlock_irqrestore(&up->port.lock, flags);
-
-		/*
-		 * If the interrupt is not reasserted, setup a timer to
-		 * kick the UART on a regular basis.
-		 */
-		if (!(iir1 & UART_IIR_NO_INT) && (iir & UART_IIR_NO_INT)) {
-			up->bugs |= UART_BUG_THRE;
-			pr_debug("ttyS%d - using backup timer\n",
-				 serial_index(port));
-		}
-	}
-
-	/*
-	 * The above check will only give an accurate result the first time
-	 * the port is opened so this value needs to be preserved.
-	 */
-	if (up->bugs & UART_BUG_THRE) {
-		up->timer.function = serial8250_backup_timeout;
-		up->timer.data = (unsigned long)up;
-		mod_timer(&up->timer, jiffies +
-			  poll_timeout(up->port.timeout) + HZ / 5);
-	}
-
 	/*
 	 * If the "interrupt" for this port doesn't correspond with any
 	 * hardware interrupt, we use a timer-based system.  The original
@@ -2099,40 +2040,6 @@ static int serial8250_startup(struct uart_port *port)

 	serial8250_set_mctrl(&up->port, up->port.mctrl);

-	/* Serial over Lan (SoL) hack:
-	   Intel 8257x Gigabit ethernet chips have a
-	   16550 emulation, to be used for Serial Over Lan.
-	   Those chips take a longer time than a normal
-	   serial device to signalize that a transmission
-	   data was queued. Due to that, the above test generally
-	   fails. One solution would be to delay the reading of
-	   iir. However, this is not reliable, since the timeout
-	   is variable. So, let's just don't test if we receive
-	   TX irq. This way, we'll never enable UART_BUG_TXEN.
-	 */
-	if (skip_txen_test || up->port.flags & UPF_NO_TXEN_TEST)
-		goto dont_test_tx_en;
-
-	/*
-	 * Do a quick test to see if we receive an
-	 * interrupt when we enable the TX irq.
-	 */
-	serial_outp(up, UART_IER, UART_IER_THRI);
-	lsr = serial_in(up, UART_LSR);
-	iir = serial_in(up, UART_IIR);
-	serial_outp(up, UART_IER, 0);
-
-	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
-		if (!(up->bugs & UART_BUG_TXEN)) {
-			up->bugs |= UART_BUG_TXEN;
-			pr_debug("ttyS%d - enabling bad tx status workarounds\n",
-				 serial_index(port));
-		}
-	} else {
-		up->bugs &= ~UART_BUG_TXEN;
-	}
-
-dont_test_tx_en:
 	spin_unlock_irqrestore(&up->port.lock, flags);

 	/*
diff --git a/drivers/serial/8250.h b/drivers/serial/8250.h
index 6e19ea3..770a0e2 100644
--- a/drivers/serial/8250.h
+++ b/drivers/serial/8250.h
@@ -46,9 +46,7 @@ struct serial8250_config {
 #define UART_CAP_UUE	(1 << 12)	/* UART needs IER bit 6 set (Xscale) */

 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
-#define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
-#define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
-#define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
+#define UART_BUG_NOMSR	(1 << 1)	/* UART has buggy MSR status bits (Au1x00) */

 #define PROBE_RSA	(1 << 0)
 #define PROBE_ANY	(~0)
-- 
1.6.5.3
