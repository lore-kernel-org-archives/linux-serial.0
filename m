From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCHv2 4/4] tty: 8250: switch to uart_port locking helpers
Date: Tue, 16 Oct 2018 14:04:28 +0900
Message-ID: <20181016050428.17966-5-sergey.senozhatsky@gmail.com>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

Switch to uart_port_lock macros:

- use uart_port_lock_for_printk()/uart_port_unlock_after_printk() in
  serial8250_console_write().

- use uart_port_lock_*()/uart_port_unlock_*() elsewhere.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c |  8 +--
 drivers/tty/serial/8250/8250_dma.c  |  4 +-
 drivers/tty/serial/8250/8250_port.c | 81 +++++++++++++----------------
 3 files changed, 43 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 94f3e1c64490..34fe546260f6 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -268,7 +268,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	unsigned int iir, ier = 0, lsr;
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, flags);
 
 	/*
 	 * Must disable interrupts or else we risk racing with the interrupt
@@ -302,7 +302,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	if (up->port.irq)
 		serial_out(up, UART_IER, ier);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	/* Standard timer interval plus 0.2s to keep the port running */
 	mod_timer(&up->timer,
@@ -1078,9 +1078,9 @@ void serial8250_unregister_port(int line)
 	if (uart->em485) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&uart->port.lock, flags);
+		uart_port_lock_irqsave(&uart->port, flags);
 		serial8250_em485_destroy(uart);
-		spin_unlock_irqrestore(&uart->port.lock, flags);
+		uart_port_unlock_irqrestore(&uart->port, flags);
 	}
 
 	uart_remove_one_port(&serial8250_reg, &uart->port);
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index bfa1a857f3ff..a9255b4e9353 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -22,7 +22,7 @@ static void __dma_tx_complete(void *param)
 	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, flags);
 
 	dma->tx_running = 0;
 
@@ -39,7 +39,7 @@ static void __dma_tx_complete(void *param)
 		serial_port_out(&p->port, UART_IER, p->ier);
 	}
 
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 }
 
 static void __dma_rx_complete(void *param)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f776b3eafb96..340aecf23dc5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -790,9 +790,9 @@ static void enable_rsa(struct uart_8250_port *up)
 {
 	if (up->port.type == PORT_RSA) {
 		if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
-			spin_lock_irq(&up->port.lock);
+			uart_port_lock_irq(&up->port);
 			__enable_rsa(up);
-			spin_unlock_irq(&up->port.lock);
+			uart_port_unlock_irq(&up->port);
 		}
 		if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
 			serial_out(up, UART_RSA_FRR, 0);
@@ -812,7 +812,7 @@ static void disable_rsa(struct uart_8250_port *up)
 
 	if (up->port.type == PORT_RSA &&
 	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
-		spin_lock_irq(&up->port.lock);
+		uart_port_lock_irq(&up->port);
 
 		mode = serial_in(up, UART_RSA_MSR);
 		result = !(mode & UART_RSA_MSR_FIFO);
@@ -825,7 +825,7 @@ static void disable_rsa(struct uart_8250_port *up)
 
 		if (result)
 			up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-		spin_unlock_irq(&up->port.lock);
+		uart_port_unlock_irq(&up->port);
 	}
 }
 #endif /* CONFIG_SERIAL_8250_RSA */
@@ -1236,7 +1236,7 @@ static void autoconfig(struct uart_8250_port *up)
 	 * We really do need global IRQs disabled here - we're going to
 	 * be frobbing the chips IRQ enable register to see if it exists.
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 
 	up->capabilities = 0;
 	up->bugs = 0;
@@ -1275,7 +1275,7 @@ static void autoconfig(struct uart_8250_port *up)
 			/*
 			 * We failed; there's nothing here
 			 */
-			spin_unlock_irqrestore(&port->lock, flags);
+			uart_port_unlock_irqrestore(port, flags);
 			DEBUG_AUTOCONF("IER test failed (%02x, %02x) ",
 				       scratch2, scratch3);
 			goto out;
@@ -1299,7 +1299,7 @@ static void autoconfig(struct uart_8250_port *up)
 		status1 = serial_in(up, UART_MSR) & 0xF0;
 		serial8250_out_MCR(up, save_mcr);
 		if (status1 != 0x90) {
-			spin_unlock_irqrestore(&port->lock, flags);
+			uart_port_unlock_irqrestore(port, flags);
 			DEBUG_AUTOCONF("LOOP test failed (%02x) ",
 				       status1);
 			goto out;
@@ -1372,7 +1372,7 @@ static void autoconfig(struct uart_8250_port *up)
 		serial_out(up, UART_IER, 0);
 
 out_lock:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Check if the device is a Fintek F81216A
@@ -1483,12 +1483,12 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	p = em485->port;
 
 	serial8250_rpm_get(p);
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, flags);
 	if (em485->active_timer == &em485->stop_tx_timer) {
 		__do_stop_tx_rs485(p);
 		em485->active_timer = NULL;
 	}
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 	serial8250_rpm_put(p);
 	return HRTIMER_NORESTART;
 }
@@ -1637,12 +1637,12 @@ static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 	em485 = container_of(t, struct uart_8250_em485, start_tx_timer);
 	p = em485->port;
 
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, flags);
 	if (em485->active_timer == &em485->start_tx_timer) {
 		__start_tx(&p->port);
 		em485->active_timer = NULL;
 	}
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 	return HRTIMER_NORESTART;
 }
 
@@ -1884,7 +1884,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 
 	status = serial_port_in(port, UART_LSR);
 
@@ -1897,7 +1897,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE))
 		serial8250_tx_chars(up);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	return 1;
 }
 EXPORT_SYMBOL_GPL(serial8250_handle_irq);
@@ -1932,9 +1932,9 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 	if ((iir & UART_IIR_ID) == UART_IIR_THRI) {
 		struct uart_8250_port *up = up_to_u8250p(port);
 
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, flags);
 		serial8250_tx_chars(up);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 	}
 
 	iir = serial_port_in(port, UART_IIR);
@@ -1949,10 +1949,10 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 
 	serial8250_rpm_get(up);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 	lsr = serial_port_in(port, UART_LSR);
 	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	serial8250_rpm_put(up);
 
@@ -2025,13 +2025,13 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 
 	serial8250_rpm_get(up);
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 	if (break_state == -1)
 		up->lcr |= UART_LCR_SBC;
 	else
 		up->lcr &= ~UART_LCR_SBC;
 	serial_port_out(port, UART_LCR, up->lcr);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 }
 
@@ -2282,7 +2282,7 @@ int serial8250_do_startup(struct uart_port *port)
 		 * the interrupt is enabled.  Delays are necessary to
 		 * allow register changes to become visible.
 		 */
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, flags);
 		if (up->port.irqflags & IRQF_SHARED)
 			disable_irq_nosync(port->irq);
 
@@ -2298,7 +2298,7 @@ int serial8250_do_startup(struct uart_port *port)
 
 		if (port->irqflags & IRQF_SHARED)
 			enable_irq(port->irq);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 
 		/*
 		 * If the interrupt is not reasserted, or we otherwise
@@ -2320,7 +2320,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
@@ -2367,7 +2367,7 @@ int serial8250_do_startup(struct uart_port *port)
 	}
 
 dont_test_tx_en:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Clear the interrupt registers again for luck, and clear the
@@ -2434,17 +2434,17 @@ void serial8250_do_shutdown(struct uart_port *port)
 	/*
 	 * Disable interrupts from this port
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 	up->ier = 0;
 	serial_port_out(port, UART_IER, 0);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	synchronize_irq(port->irq);
 
 	if (up->dma)
 		serial8250_release_dma(up);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 	if (port->flags & UPF_FOURPORT) {
 		/* reset interrupts on the AST Fourport board */
 		inb((port->iobase & 0xfe0) | 0x1f);
@@ -2453,7 +2453,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2679,7 +2679,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * interrupts disabled.
 	 */
 	serial8250_rpm_get(up);
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, flags);
 
 	up->lcr = cval;					/* Save computed LCR */
 
@@ -2783,7 +2783,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_port_out(port, UART_FCR, up->fcr);	/* set fcr */
 	}
 	serial8250_set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 
 	/* Don't rewrite B0 */
@@ -2806,15 +2806,15 @@ void serial8250_do_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
-		spin_lock_irq(&port->lock);
+		uart_port_lock_irq(port);
 		serial8250_enable_ms(port);
-		spin_unlock_irq(&port->lock);
+		uart_port_unlock_irq(port);
 	} else {
 		port->flags &= ~UPF_HARDPPS_CD;
 		if (!UART_ENABLE_MS(port, termios->c_cflag)) {
-			spin_lock_irq(&port->lock);
+			uart_port_lock_irq(port);
 			serial8250_disable_ms(port);
-			spin_unlock_irq(&port->lock);
+			uart_port_unlock_irq(port);
 		}
 	}
 }
@@ -3252,19 +3252,13 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	struct uart_port *port = &up->port;
 	unsigned long flags;
 	unsigned int ier;
-	int locked = 1;
+	bool locked;
 
 	touch_nmi_watchdog();
 
 	serial8250_rpm_get(up);
 
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
-	else
-		spin_lock_irqsave(&port->lock, flags);
-
+	uart_port_lock_for_printk(port, flags, locked);
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
@@ -3300,8 +3294,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (up->msr_saved_flags)
 		serial8250_modem_status(up);
 
-	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_after_printk(port, flags, locked);
 	serial8250_rpm_put(up);
 }
 
-- 
2.19.1
