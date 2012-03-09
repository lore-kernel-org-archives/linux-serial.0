From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 6/7] serial: use serial_port_in/out vs serial_in/out in 8250
Date: Thu,  8 Mar 2012 19:12:13 -0500
Message-ID: <1331251934-25540-7-git-send-email-paul.gortmaker@windriver.com>
References: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44823 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2CIAMa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 19:12:30 -0500
In-Reply-To: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

The serial_in and serial_out helpers are expecting to operate
on an 8250_port struct.  These in turn go after the contained
normal port struct which actually has the actual in/out accessors.

But what is happening in some cases, is that a function is passed
in a port struct, and it runs container_of to get the 8250_port
struct, and then it uses serial_in/out helpers on that.  But when
you do, it goes full circle, since it jumps back inside the 8250_port
to find the contained port struct (which we already knew!).

So, if we are operating in a scope where we know the struct port,
then use the serial_port_in/out helpers and avoid the bouncing
around.  If we don't have the struct port handy, and it isn't
worth making a local for it, then just leave things as-is which
uses the serial_in/out helpers that will resolve the 8250_port
onto the struct port.

Mostly, gcc figures this out on its own -- so this doesn't bring to
the table any revolutionary runtime delta.  However, it is somewhat
misleading to always hammer away on 8250 structs, when the actual
underlying property isn't at all 8250 specific -- and this change
makes that clear.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250/8250.c |  160 ++++++++++++++++++++--------------------
 1 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index a0d114d..7898295 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -1287,7 +1287,7 @@ static void serial8250_start_tx(struct uart_port *port)
 
 	if (!(up->ier & UART_IER_THRI)) {
 		up->ier |= UART_IER_THRI;
-		serial_out(up, UART_IER, up->ier);
+		serial_port_out(port, UART_IER, up->ier);
 
 		if (up->bugs & UART_BUG_TXEN) {
 			unsigned char lsr;
@@ -1316,7 +1316,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 
 	up->ier &= ~UART_IER_RLSI;
 	up->port.read_status_mask &= ~UART_LSR_DR;
-	serial_out(up, UART_IER, up->ier);
+	serial_port_out(port, UART_IER, up->ier);
 }
 
 static void serial8250_enable_ms(struct uart_port *port)
@@ -1329,7 +1329,7 @@ static void serial8250_enable_ms(struct uart_port *port)
 		return;
 
 	up->ier |= UART_IER_MSI;
-	serial_out(up, UART_IER, up->ier);
+	serial_port_out(port, UART_IER, up->ier);
 }
 
 /*
@@ -1523,7 +1523,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	status = serial_in(up, UART_LSR);
+	status = serial_port_in(port, UART_LSR);
 
 	DEBUG_INTR("status = %x...", status);
 
@@ -1540,9 +1540,7 @@ EXPORT_SYMBOL_GPL(serial8250_handle_irq);
 
 static int serial8250_default_handle_irq(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
-	unsigned int iir = serial_in(up, UART_IIR);
+	unsigned int iir = serial_port_in(port, UART_IIR);
 
 	return serial8250_handle_irq(port, iir);
 }
@@ -1776,7 +1774,7 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 	unsigned int lsr;
 
 	spin_lock_irqsave(&port->lock, flags);
-	lsr = serial_in(up, UART_LSR);
+	lsr = serial_port_in(port, UART_LSR);
 	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -1823,7 +1821,7 @@ static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
 
-	serial_out(up, UART_MCR, mcr);
+	serial_port_out(port, UART_MCR, mcr);
 }
 
 static void serial8250_break_ctl(struct uart_port *port, int break_state)
@@ -1837,7 +1835,7 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 		up->lcr |= UART_LCR_SBC;
 	else
 		up->lcr &= ~UART_LCR_SBC;
-	serial_out(up, UART_LCR, up->lcr);
+	serial_port_out(port, UART_LCR, up->lcr);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -1883,14 +1881,12 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 
 static int serial8250_get_poll_char(struct uart_port *port)
 {
-	struct uart_8250_port *up =
-		container_of(port, struct uart_8250_port, port);
-	unsigned char lsr = serial_in(up, UART_LSR);
+	unsigned char lsr = serial_port_in(port, UART_LSR);
 
 	if (!(lsr & UART_LSR_DR))
 		return NO_POLL_CHAR;
 
-	return serial_in(up, UART_RX);
+	return serial_port_in(port, UART_RX);
 }
 
 
@@ -1904,21 +1900,21 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
-	ier = serial_in(up, UART_IER);
+	ier = serial_port_in(port, UART_IER);
 	if (up->capabilities & UART_CAP_UUE)
-		serial_out(up, UART_IER, UART_IER_UUE);
+		serial_port_out(port, UART_IER, UART_IER_UUE);
 	else
-		serial_out(up, UART_IER, 0);
+		serial_port_out(port, UART_IER, 0);
 
 	wait_for_xmitr(up, BOTH_EMPTY);
 	/*
 	 *	Send the character out.
 	 *	If a LF, also do CR...
 	 */
-	serial_out(up, UART_TX, c);
+	serial_port_out(port, UART_TX, c);
 	if (c == 10) {
 		wait_for_xmitr(up, BOTH_EMPTY);
-		serial_out(up, UART_TX, 13);
+		serial_port_out(port, UART_TX, 13);
 	}
 
 	/*
@@ -1926,7 +1922,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	serial_out(up, UART_IER, ier);
+	serial_port_out(port, UART_IER, ier);
 }
 
 #endif /* CONFIG_CONSOLE_POLL */
@@ -1950,14 +1946,14 @@ static int serial8250_startup(struct uart_port *port)
 	if (port->type == PORT_16C950) {
 		/* Wake up and initialize UART */
 		up->acr = 0;
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		serial_out(up, UART_EFR, UART_EFR_ECB);
-		serial_out(up, UART_IER, 0);
-		serial_out(up, UART_LCR, 0);
+		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_port_out(port, UART_EFR, UART_EFR_ECB);
+		serial_port_out(port, UART_IER, 0);
+		serial_port_out(port, UART_LCR, 0);
 		serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		serial_out(up, UART_EFR, UART_EFR_ECB);
-		serial_out(up, UART_LCR, 0);
+		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_port_out(port, UART_EFR, UART_EFR_ECB);
+		serial_port_out(port, UART_LCR, 0);
 	}
 
 #ifdef CONFIG_SERIAL_8250_RSA
@@ -1977,10 +1973,10 @@ static int serial8250_startup(struct uart_port *port)
 	/*
 	 * Clear the interrupt registers.
 	 */
-	serial_in(up, UART_LSR);
-	serial_in(up, UART_RX);
-	serial_in(up, UART_IIR);
-	serial_in(up, UART_MSR);
+	serial_port_in(port, UART_LSR);
+	serial_port_in(port, UART_RX);
+	serial_port_in(port, UART_IIR);
+	serial_port_in(port, UART_MSR);
 
 	/*
 	 * At this point, there's no way the LSR could still be 0xff;
@@ -1988,7 +1984,7 @@ static int serial8250_startup(struct uart_port *port)
 	 * here.
 	 */
 	if (!(port->flags & UPF_BUGGY_UART) &&
-	    (serial_in(up, UART_LSR) == 0xff)) {
+	    (serial_port_in(port, UART_LSR) == 0xff)) {
 		printk_ratelimited(KERN_INFO "ttyS%d: LSR safety check engaged!\n",
 				   serial_index(port));
 		return -ENODEV;
@@ -2003,12 +1999,14 @@ static int serial8250_startup(struct uart_port *port)
 		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 		fctr = serial_in(up, UART_FCTR) & ~(UART_FCTR_RX|UART_FCTR_TX);
-		serial_out(up, UART_FCTR, fctr | UART_FCTR_TRGD | UART_FCTR_RX);
-		serial_out(up, UART_TRG, UART_TRG_96);
-		serial_out(up, UART_FCTR, fctr | UART_FCTR_TRGD | UART_FCTR_TX);
-		serial_out(up, UART_TRG, UART_TRG_96);
+		serial_port_out(port, UART_FCTR,
+				fctr | UART_FCTR_TRGD | UART_FCTR_RX);
+		serial_port_out(port, UART_TRG, UART_TRG_96);
+		serial_port_out(port, UART_FCTR,
+				fctr | UART_FCTR_TRGD | UART_FCTR_TX);
+		serial_port_out(port, UART_TRG, UART_TRG_96);
 
-		serial_out(up, UART_LCR, 0);
+		serial_port_out(port, UART_LCR, 0);
 	}
 
 	if (port->irq) {
@@ -2028,12 +2026,12 @@ static int serial8250_startup(struct uart_port *port)
 		wait_for_xmitr(up, UART_LSR_THRE);
 		serial_out_sync(up, UART_IER, UART_IER_THRI);
 		udelay(1); /* allow THRE to set */
-		iir1 = serial_in(up, UART_IIR);
-		serial_out(up, UART_IER, 0);
+		iir1 = serial_port_in(port, UART_IIR);
+		serial_port_out(port, UART_IER, 0);
 		serial_out_sync(up, UART_IER, UART_IER_THRI);
 		udelay(1); /* allow a working UART time to re-assert THRE */
-		iir = serial_in(up, UART_IIR);
-		serial_out(up, UART_IER, 0);
+		iir = serial_port_in(port, UART_IIR);
+		serial_port_out(port, UART_IER, 0);
 
 		if (port->irqflags & IRQF_SHARED)
 			enable_irq(port->irq);
@@ -2078,7 +2076,7 @@ static int serial8250_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_out(up, UART_LCR, UART_LCR_WLEN8);
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
 	spin_lock_irqsave(&port->lock, flags);
 	if (up->port.flags & UPF_FOURPORT) {
@@ -2111,10 +2109,10 @@ static int serial8250_startup(struct uart_port *port)
 	 * Do a quick test to see if we receive an
 	 * interrupt when we enable the TX irq.
 	 */
-	serial_out(up, UART_IER, UART_IER_THRI);
-	lsr = serial_in(up, UART_LSR);
-	iir = serial_in(up, UART_IIR);
-	serial_out(up, UART_IER, 0);
+	serial_port_out(port, UART_IER, UART_IER_THRI);
+	lsr = serial_port_in(port, UART_LSR);
+	iir = serial_port_in(port, UART_IIR);
+	serial_port_out(port, UART_IER, 0);
 
 	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
@@ -2134,10 +2132,10 @@ dont_test_tx_en:
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	serial_in(up, UART_LSR);
-	serial_in(up, UART_RX);
-	serial_in(up, UART_IIR);
-	serial_in(up, UART_MSR);
+	serial_port_in(port, UART_LSR);
+	serial_port_in(port, UART_RX);
+	serial_port_in(port, UART_IIR);
+	serial_port_in(port, UART_MSR);
 	up->lsr_saved_flags = 0;
 	up->msr_saved_flags = 0;
 
@@ -2147,7 +2145,7 @@ dont_test_tx_en:
 	 * anyway, so we don't enable them here.
 	 */
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
-	serial_out(up, UART_IER, up->ier);
+	serial_port_out(port, UART_IER, up->ier);
 
 	if (port->flags & UPF_FOURPORT) {
 		unsigned int icp;
@@ -2172,7 +2170,7 @@ static void serial8250_shutdown(struct uart_port *port)
 	 * Disable interrupts from this port
 	 */
 	up->ier = 0;
-	serial_out(up, UART_IER, 0);
+	serial_port_out(port, UART_IER, 0);
 
 	spin_lock_irqsave(&port->lock, flags);
 	if (port->flags & UPF_FOURPORT) {
@@ -2188,7 +2186,8 @@ static void serial8250_shutdown(struct uart_port *port)
 	/*
 	 * Disable break condition and FIFOs
 	 */
-	serial_out(up, UART_LCR, serial_in(up, UART_LCR) & ~UART_LCR_SBC);
+	serial_port_out(port, UART_LCR,
+			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
 
 #ifdef CONFIG_SERIAL_8250_RSA
@@ -2202,7 +2201,7 @@ static void serial8250_shutdown(struct uart_port *port)
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
 	 */
-	serial_in(up, UART_RX);
+	serial_port_in(port, UART_RX);
 
 	del_timer_sync(&up->timer);
 	up->timer.function = serial8250_timeout;
@@ -2353,7 +2352,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (up->capabilities & UART_CAP_RTOIE)
 		up->ier |= UART_IER_RTOIE;
 
-	serial_out(up, UART_IER, up->ier);
+	serial_port_out(port, UART_IER, up->ier);
 
 	if (up->capabilities & UART_CAP_EFR) {
 		unsigned char efr = 0;
@@ -2365,11 +2364,11 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (termios->c_cflag & CRTSCTS)
 			efr |= UART_EFR_CTS;
 
-		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		if (port->flags & UPF_EXAR_EFR)
-			serial_out(up, UART_XR_EFR, efr);
+			serial_port_out(port, UART_XR_EFR, efr);
 		else
-			serial_out(up, UART_EFR, efr);
+			serial_port_out(port, UART_EFR, efr);
 	}
 
 #ifdef CONFIG_ARCH_OMAP
@@ -2377,18 +2376,20 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (cpu_is_omap1510() && is_omap_port(up)) {
 		if (baud == 115200) {
 			quot = 1;
-			serial_out(up, UART_OMAP_OSC_12M_SEL, 1);
+			serial_port_out(port, UART_OMAP_OSC_12M_SEL, 1);
 		} else
-			serial_out(up, UART_OMAP_OSC_12M_SEL, 0);
+			serial_port_out(port, UART_OMAP_OSC_12M_SEL, 0);
 	}
 #endif
 
-	if (up->capabilities & UART_NATSEMI) {
-		/* Switch to bank 2 not bank 1, to avoid resetting EXCR2 */
-		serial_out(up, UART_LCR, 0xe0);
-	} else {
-		serial_out(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
-	}
+	/*
+	 * For NatSemi, switch to bank 2 not bank 1, to avoid resetting EXCR2,
+	 * otherwise just set DLAB
+	 */
+	if (up->capabilities & UART_NATSEMI)
+		serial_port_out(port, UART_LCR, 0xe0);
+	else
+		serial_port_out(port, UART_LCR, cval | UART_LCR_DLAB);
 
 	serial_dl_write(up, quot);
 
@@ -2397,16 +2398,15 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * is written without DLAB set, this mode will be disabled.
 	 */
 	if (port->type == PORT_16750)
-		serial_out(up, UART_FCR, fcr);
+		serial_port_out(port, UART_FCR, fcr);
 
-	serial_out(up, UART_LCR, cval);			/* reset DLAB */
+	serial_port_out(port, UART_LCR, cval);		/* reset DLAB */
 	up->lcr = cval;					/* Save LCR */
 	if (port->type != PORT_16750) {
-		if (fcr & UART_FCR_ENABLE_FIFO) {
-			/* emulated UARTs (Lucent Venus 167x) need two steps */
-			serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
-		}
-		serial_out(up, UART_FCR, fcr);		/* set fcr */
+		/* emulated UARTs (Lucent Venus 167x) need two steps */
+		if (fcr & UART_FCR_ENABLE_FIFO)
+			serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial_port_out(port, UART_FCR, fcr);		/* set fcr */
 	}
 	serial8250_set_mctrl(port, port->mctrl);
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -2788,7 +2788,7 @@ static void serial8250_console_putchar(struct uart_port *port, int ch)
 		container_of(port, struct uart_8250_port, port);
 
 	wait_for_xmitr(up, UART_LSR_THRE);
-	serial_out(up, UART_TX, ch);
+	serial_port_out(port, UART_TX, ch);
 }
 
 /*
@@ -2820,12 +2820,12 @@ serial8250_console_write(struct console *co, const char *s, unsigned int count)
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
-	ier = serial_in(up, UART_IER);
+	ier = serial_port_in(port, UART_IER);
 
 	if (up->capabilities & UART_CAP_UUE)
-		serial_out(up, UART_IER, UART_IER_UUE);
+		serial_port_out(port, UART_IER, UART_IER_UUE);
 	else
-		serial_out(up, UART_IER, 0);
+		serial_port_out(port, UART_IER, 0);
 
 	uart_console_write(port, s, count, serial8250_console_putchar);
 
@@ -2834,7 +2834,7 @@ serial8250_console_write(struct console *co, const char *s, unsigned int count)
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	serial_out(up, UART_IER, ier);
+	serial_port_out(port, UART_IER, ier);
 
 	/*
 	 *	The receive handling will happen properly because the
@@ -2996,11 +2996,11 @@ void serial8250_resume_port(int line)
 
 	if (up->capabilities & UART_NATSEMI) {
 		/* Ensure it's still in high speed mode */
-		serial_out(up, UART_LCR, 0xE0);
+		serial_port_out(port, UART_LCR, 0xE0);
 
 		ns16550a_goto_highspeed(up);
 
-		serial_out(up, UART_LCR, 0);
+		serial_port_out(port, UART_LCR, 0);
 		port->uartclk = 921600*16;
 	}
 	uart_resume_port(&serial8250_reg, port);
-- 
1.7.9.1

