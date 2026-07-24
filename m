Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4E421233;
	Fri, 24 Jul 2026 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889419; cv=none; b=Tz9CpV6WpNZvEiVYHl6ad/nOSDNEcq3ZIK7AXxELZRfLb3qmpqM8lANVVoRhaO8CJ0bQG4BbPCUS+gEjP9DEm3uzOFtOvVs8TxK/s/ymTYE92O/Y69JmqH+zuLX2tJPZ4eiyHl/j+NR7uzaRHnNcqyjsukEbmtRkAAHcs+AU82o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889419; c=relaxed/simple;
	bh=KLCm4Hw+C7kc5ISWJSediHnrRizeZmL7i268NiZPuhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXaO9t0ocCuUXo5jdYjei2nAyOcn6++PZSplZ0gKeGJL9JoEmgbpydMbjup9Z+R0llh8rWjteW7RjP7BWoaKAWT90e56PjhbBletiEEw2pyOOwHJJ+jCmgelTpenn8tbMoY+nNVGI2/Zwpx50QatioZaRZqf/7cM2/8kEnK57F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cp9/AZh7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OaJuBVHh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cp9/AZh7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OaJuBVHh"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784889415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLhcyguVVQajts0Ty+zsyv7czAYp/hRQE/ngegnIYQo=;
	b=cp9/AZh7CbyDdRZ1gLqY0qz76EHe/wtOjlHgyHimH9D0fmOR31ruMFuVcBaM6ne9QB0pET
	OpcuFfyMMEtvEmJrtvKs4g5+mx6YzpjDqdGYebKnIT+GzjAlYj+U0W4TB1zs7nAF+Ct25Q
	CIuVgpQX7/jjPy7ifJ8BrGTzyReLXpAjk73ctfY52VVeGsZ6gdw2L88GmGDS7EU/iBIX5i
	j8kpvxtmbcUTKmHdFxpfW8hXOcIWHkKFEcMQ2ijSUSpIzVFq+u+PuDTuzLex55jm292PDD
	HIMyOnWWco6O1RUyx6xdaD0RldONoRea1JEeK0sV+yNhsSXVfpLATGBwt+6d9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784889415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLhcyguVVQajts0Ty+zsyv7czAYp/hRQE/ngegnIYQo=;
	b=OaJuBVHhWKG7ZgSSEPbWSlg5hGp5S1YW29cnux/OoSpYUpUT5F9IMrKBe5xvNvXIFEfaxp
	ymDqk5woBcrwLODw==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v9 1/2] serial: 8250: Switch to nbcon console, take 2
Date: Fri, 24 Jul 2026 12:42:51 +0206
Message-ID: <20260724103654.133654-2-john.ogness@linutronix.de>
In-Reply-To: <20260724103654.133654-1-john.ogness@linutronix.de>
References: <20260724103654.133654-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the necessary callbacks to switch the 8250 console driver
to perform as an nbcon console.

Add implementations for the nbcon console callbacks:

  ->write_atomic()
  ->write_thread()
  ->device_lock()
  ->device_unlock()

and add CON_NBCON to the initial @flags.

All hardware access in the callbacks is within unsafe sections.
The ->write_atomic() and ->write_thread() callbacks allow safe
handover/takeover per byte and add a preceding newline if they
take over from another context mid-line.

For the ->write_atomic() callback, a new irq_work is used to defer
modem control since it may be called from a context that does not
allow waking up tasks. During suspend/resume the irq_work is not
used as this has been shown to cause suspend problems for some
hardware. Upon resume, any pending modem control is performed.

Note: A new __serial8250_clear_IER() is introduced for direct
clearing of UART_IER during console writing (which will not be
holding the port lock for atomic printing or KDB/KGDB). This
allows restoring a lockdep check to serial8250_clear_IER() in
a follow-up commit.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250.h      |   4 +-
 drivers/tty/serial/8250/8250_core.c |  65 +++++++--
 drivers/tty/serial/8250/8250_dw.c   |   2 +-
 drivers/tty/serial/8250/8250_port.c | 201 +++++++++++++++++++++++-----
 include/linux/serial_8250.h         |  16 ++-
 5 files changed, 237 insertions(+), 51 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b62f88eec881f..d672b014ade02 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -178,7 +178,9 @@ static unsigned int __maybe_unused serial_icr_read(struct uart_8250_port *up,
 
 void serial8250_clear_fifos(struct uart_8250_port *p);
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
-void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count);
+void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
+				       struct nbcon_write_context *wctxt,
+				       unsigned int count);
 
 void serial8250_rpm_get(struct uart_8250_port *p);
 void serial8250_rpm_put(struct uart_8250_port *p);
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index c0e8a4efbdcc8..5042a8e8c6fb1 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -390,12 +390,34 @@ void __init serial8250_register_ports(struct uart_driver *drv, struct device *de
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
-static void univ8250_console_write(struct console *co, const char *s,
-				   unsigned int count)
+static void univ8250_console_write_atomic(struct console *co,
+					  struct nbcon_write_context *wctxt)
 {
 	struct uart_8250_port *up = &serial8250_ports[co->index];
 
-	serial8250_console_write(up, s, count);
+	serial8250_console_write(up, wctxt, true);
+}
+
+static void univ8250_console_write_thread(struct console *co,
+					  struct nbcon_write_context *wctxt)
+{
+	struct uart_8250_port *up = &serial8250_ports[co->index];
+
+	serial8250_console_write(up, wctxt, false);
+}
+
+static void univ8250_console_device_lock(struct console *co, unsigned long *flags)
+{
+	struct uart_port *up = &serial8250_ports[co->index].port;
+
+	__uart_port_lock_irqsave(up, flags);
+}
+
+static void univ8250_console_device_unlock(struct console *co, unsigned long flags)
+{
+	struct uart_port *up = &serial8250_ports[co->index].port;
+
+	__uart_port_unlock_irqrestore(up, flags);
 }
 
 static int univ8250_console_setup(struct console *co, char *options)
@@ -496,12 +518,15 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 
 static struct console univ8250_console = {
 	.name		= "ttyS",
-	.write		= univ8250_console_write,
+	.write_atomic	= univ8250_console_write_atomic,
+	.write_thread	= univ8250_console_write_thread,
+	.device_lock	= univ8250_console_device_lock,
+	.device_unlock	= univ8250_console_device_unlock,
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
 	.exit		= univ8250_console_exit,
 	.match		= univ8250_console_match,
-	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
+	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
 	.index		= -1,
 	.data		= &serial8250_reg,
 };
@@ -584,13 +609,19 @@ void serial8250_suspend_port(int line)
 	struct uart_8250_port *up = &serial8250_ports[line];
 	struct uart_port *port = &up->port;
 
-	if (!console_suspend_enabled && uart_console(port) &&
-	    port->type != PORT_8250) {
-		unsigned char canary = 0xa5;
+	if (uart_console(port)) {
+		/* No irq_work may be queued when suspending */
+		scoped_guard(uart_port_lock_irq, port)
+			up->console_msr_work_allow = false;
+		irq_work_sync(&up->console_msr_work);
 
-		serial_out(up, UART_SCR, canary);
-		if (serial_in(up, UART_SCR) == canary)
-			up->canary = canary;
+		if (!console_suspend_enabled && port->type != PORT_8250) {
+			unsigned char canary = 0xa5;
+
+			serial_out(up, UART_SCR, canary);
+			if (serial_in(up, UART_SCR) == canary)
+				up->canary = canary;
+		}
 	}
 
 	uart_suspend_port(&serial8250_reg, port);
@@ -620,6 +651,18 @@ void serial8250_resume_port(int line)
 		port->uartclk = 921600*16;
 	}
 	uart_resume_port(&serial8250_reg, port);
+
+	if (uart_console(port)) {
+
+		guard(uart_port_lock_irq)(port);
+
+		/* irq_work allowed again */
+		up->console_msr_work_allow = true;
+
+		/* Handle any pending MSR changes */
+		if (up->msr_saved_flags)
+			serial8250_modem_status(up);
+	}
 }
 EXPORT_SYMBOL(serial8250_resume_port);
 
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 5fba913f33010..51d026f20825a 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -156,7 +156,7 @@ static int dw8250_idle_enter(struct uart_port *p)
 	 *
 	 * FIXME: frame_time delay is too long with very low baudrates.
 	 */
-	serial8250_fifo_wait_for_lsr_thre(up, p->fifosize);
+	serial8250_fifo_wait_for_lsr_thre(up, NULL, p->fifosize);
 	ndelay(p->frame_time);
 
 	serial_port_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8c241ec7f4f29..855a7aa48c2d2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -704,7 +704,12 @@ static void serial8250_clear_interrupts(struct uart_port *port)
 	serial_port_in(port, UART_MSR);
 }
 
-static void serial8250_clear_IER(struct uart_8250_port *up)
+/*
+ * Only to be directly used by serial8250_console_write() and
+ * serial8250_put_poll_char(), which do not require the port lock.
+ * Use serial8250_clear_IER() instead for all other cases.
+ */
+static void __serial8250_clear_IER(struct uart_8250_port *up)
 {
 	if (up->capabilities & UART_CAP_UUE)
 		serial_out(up, UART_IER, UART_IER_UUE);
@@ -712,6 +717,11 @@ static void serial8250_clear_IER(struct uart_8250_port *up)
 		serial_out(up, UART_IER, 0);
 }
 
+static inline void serial8250_clear_IER(struct uart_8250_port *up)
+{
+	__serial8250_clear_IER(up);
+}
+
 /*
  * This is a quickie test to see how big the FIFO is.
  * It doesn't work at all the time, more's the pity.
@@ -1284,9 +1294,6 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
-	/* Port locked to synchronize UART_IER access against the console. */
-	lockdep_assert_held_once(&p->port.lock);
-
 	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
 		mcr |= UART_MCR_RTS;
 	else
@@ -1302,6 +1309,16 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 		serial8250_clear_and_reinit_fifos(p);
 
 		if (toggle_ier) {
+			/*
+			 * Port locked to synchronize UART_IER access against
+			 * the console. The lockdep_assert must be restricted
+			 * to this condition because only here is it
+			 * guaranteed that the port lock is held. The other
+			 * hardware access in this function is synchronized
+			 * by console ownership.
+			 */
+			lockdep_assert_held_once(&p->port.lock);
+
 			p->ier |= UART_IER_RLSI | UART_IER_RDI;
 			serial_port_out(&p->port, UART_IER, p->ier);
 		}
@@ -2053,10 +2070,13 @@ static void serial8250_put_poll_char(struct uart_port *port,
 
 	guard(serial8250_rpm)(up);
 	/*
-	 *	First save the IER then disable the interrupts
+	 * First, save the IER, then disable the interrupts. The special
+	 * variant to clear the IER is used because KDB/KGDB printing
+	 * is synchronized via CPU quiescence without holding the port
+	 * lock.
 	 */
 	ier = serial_port_in(port, UART_IER);
-	serial8250_clear_IER(up);
+	__serial8250_clear_IER(up);
 
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	/*
@@ -3198,13 +3218,28 @@ void serial8250_set_defaults(struct uart_8250_port *up)
 }
 EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
-void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
+void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up,
+				       struct nbcon_write_context *wctxt,
+				       unsigned int count)
 {
 	unsigned int i;
 
+	/*
+	 * For console writing, enter/exit an unsafe section for each byte
+	 * in order to pass the ownership as quickly as possible if a higher
+	 * priority context wants ownership. Otherwise, an attempt to take
+	 * over the ownership might timeout. The new owner will wait for
+	 * UART_LSR_THRE before reusing the fifo.
+	 */
 	for (i = 0; i < count; i++) {
+		if (wctxt && !nbcon_enter_unsafe(wctxt))
+			return;
+
 		if (wait_for_lsr(up, UART_LSR_THRE))
 			return;
+
+		if (wctxt)
+			nbcon_exit_unsafe(wctxt);
 	}
 }
 EXPORT_SYMBOL_NS_GPL(serial8250_fifo_wait_for_lsr_thre, "SERIAL_8250");
@@ -3213,7 +3248,11 @@ EXPORT_SYMBOL_NS_GPL(serial8250_fifo_wait_for_lsr_thre, "SERIAL_8250");
 
 static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
+
 	serial_port_out(port, UART_TX, ch);
+
+	up->console_line_ended = (ch == '\n');
 }
 
 static void serial8250_console_wait_putchar(struct uart_port *port, unsigned char ch)
@@ -3257,20 +3296,29 @@ static void serial8250_console_restore(struct uart_8250_port *up)
  * to get empty.
  */
 static void serial8250_console_fifo_write(struct uart_8250_port *up,
-					  const char *s, unsigned int count)
+					  struct nbcon_write_context *wctxt)
 {
-	const char *end = s + count;
 	unsigned int fifosize = up->tx_loadsz;
 	struct uart_port *port = &up->port;
+	const char *s = wctxt->outbuf;
+	const char *end = s + wctxt->len;
 	unsigned int tx_count = 0;
 	bool cr_sent = false;
 	unsigned int i;
 
 	while (s != end) {
 		/* Allow timeout for each byte of a possibly full FIFO */
-		serial8250_fifo_wait_for_lsr_thre(up, fifosize);
+		serial8250_fifo_wait_for_lsr_thre(up, wctxt, fifosize);
 
+		/*
+		 * Fill the FIFO. If a handover or takeover occurs, writing
+		 * must be aborted since wctxt->outbuf and wctxt->len are no
+		 * longer valid.
+		 */
 		for (i = 0; i < fifosize && s != end; ++i) {
+			if (!nbcon_enter_unsafe(wctxt))
+				return;
+
 			if (*s == '\n' && !cr_sent) {
 				serial8250_console_putchar(port, '\r');
 				cr_sent = true;
@@ -3278,6 +3326,8 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 				serial8250_console_putchar(port, *s++);
 				cr_sent = false;
 			}
+
+			nbcon_exit_unsafe(wctxt);
 		}
 		tx_count = i;
 	}
@@ -3286,39 +3336,58 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 	 * Allow timeout for each byte written since the caller will only wait
 	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
 	 */
-	serial8250_fifo_wait_for_lsr_thre(up, tx_count);
+	serial8250_fifo_wait_for_lsr_thre(up, wctxt, tx_count);
+}
+
+static void serial8250_console_byte_write(struct uart_8250_port *up,
+					  struct nbcon_write_context *wctxt)
+{
+	struct uart_port *port = &up->port;
+	const char *s = wctxt->outbuf;
+	const char *end = s + wctxt->len;
+
+	/*
+	 * Write out the message. If a handover or takeover occurs, writing
+	 * must be aborted since wctxt->outbuf and wctxt->len are no longer
+	 * valid.
+	 */
+	while (s != end) {
+		if (!nbcon_enter_unsafe(wctxt))
+			return;
+
+		uart_console_write(port, s++, 1, serial8250_console_wait_putchar);
+
+		nbcon_exit_unsafe(wctxt);
+	}
 }
 
 /*
- *	Print a string to the serial port trying not to disturb
- *	any possible real use of the port...
- *
- *	The console_lock must be held when we get here.
+ * Print a string to the serial port trying not to disturb
+ * any possible real use of the port...
  *
- *	Doing runtime PM is really a bad idea for the kernel console.
- *	Thus, we assume the function is called when device is powered up.
+ * Doing runtime PM is really a bad idea for the kernel console.
+ * Thus, assume it is called when device is powered up.
  */
-void serial8250_console_write(struct uart_8250_port *up, const char *s,
-			      unsigned int count)
+void serial8250_console_write(struct uart_8250_port *up,
+			      struct nbcon_write_context *wctxt,
+			      bool is_atomic)
 {
 	struct uart_8250_em485 *em485 = up->em485;
 	struct uart_port *port = &up->port;
-	unsigned long flags;
-	unsigned int ier, use_fifo;
-	int locked = 1;
-
-	touch_nmi_watchdog();
+	unsigned int ier;
+	bool use_fifo;
 
-	if (oops_in_progress)
-		locked = uart_port_trylock_irqsave(port, &flags);
-	else
-		uart_port_lock_irqsave(port, &flags);
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
 
 	/*
-	 *	First save the IER then disable the interrupts
+	 * First, save the IER, then disable the interrupts. The special
+	 * variant to clear the IER is used because emergency and panic
+	 * printing is synchronized only by nbcon ownership without
+	 * holding the port lock.
 	 */
 	ier = serial_port_in(port, UART_IER);
-	serial8250_clear_IER(up);
+	__serial8250_clear_IER(up);
 
 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
@@ -3332,6 +3401,18 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		mdelay(port->rs485.delay_rts_before_send);
 	}
 
+	/* If ownership was lost, no writing is allowed */
+	if (!nbcon_can_proceed(wctxt))
+		goto skip_write;
+
+	/*
+	 * If console printer did not fully output the previous line, it must
+	 * have been handed or taken over. Insert a newline in order to
+	 * maintain clean output.
+	 */
+	if (!up->console_line_ended)
+		uart_console_write(port, "\n", 1, serial8250_console_wait_putchar);
+
 	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
 		/*
 		 * BCM283x requires to check the fifo
@@ -3352,10 +3433,20 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		 */
 		!uart_console_hwflow_active(&up->port);
 
+	nbcon_exit_unsafe(wctxt);
+
 	if (likely(use_fifo))
-		serial8250_console_fifo_write(up, s, count);
+		serial8250_console_fifo_write(up, wctxt);
 	else
-		uart_console_write(port, s, count, serial8250_console_wait_putchar);
+		serial8250_console_byte_write(up, wctxt);
+skip_write:
+	/*
+	 * Re-enter an unsafe section in order to perform final actions
+	 * (such as re-enabling interrupts). If ownership was lost, this
+	 * context must reacquire ownership.
+	 */
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire_nobuf(wctxt);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
@@ -3378,11 +3469,25 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	 *	call it if we have saved something in the saved flags
 	 *	while processing with interrupts off.
 	 */
-	if (up->msr_saved_flags)
-		serial8250_modem_status(up);
+	if (up->msr_saved_flags) {
+		if (is_atomic) {
+			/*
+			 * For atomic, MSR handling must be deferred to
+			 * irq_work because this may be a context that does
+			 * not permit waking up tasks.
+			 *
+			 * But no irq_work may be queued when suspending.
+			 * In that case, the MSR handling will occur during
+			 * resume in serial8250_resume_port().
+			 */
+			if (up->console_msr_work_allow)
+				irq_work_queue(&up->console_msr_work);
+		} else {
+			serial8250_modem_status(up);
+		}
+	}
 
-	if (locked)
-		uart_port_unlock_irqrestore(port, flags);
+	nbcon_exit_unsafe(wctxt);
 }
 
 static unsigned int probe_baud(struct uart_port *port)
@@ -3400,8 +3505,24 @@ static unsigned int probe_baud(struct uart_port *port)
 	return (port->uartclk / 16) / quot;
 }
 
+/*
+ * irq_work handler to perform modem control during console output.
+ * Only triggered via ->write_atomic() callback because it may be
+ * in a scheduler or NMI context, unable to wake tasks.
+ */
+static void console_msr_handler(struct irq_work *iwp)
+{
+	struct uart_8250_port *up = container_of(iwp, struct uart_8250_port, console_msr_work);
+	struct uart_port *port = &up->port;
+
+	guard(uart_port_lock)(port);
+
+	serial8250_modem_status(up);
+}
+
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
@@ -3411,6 +3532,10 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
+	up->console_line_ended = true;
+	up->console_msr_work_allow = true;
+	init_irq_work(&up->console_msr_work, console_msr_handler);
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else if (probe)
@@ -3431,6 +3556,10 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 
 int serial8250_console_exit(struct uart_port *port)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	irq_work_sync(&up->console_msr_work);
+
 	if (port->dev)
 		pm_runtime_put_sync(port->dev);
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index a95b2d143d248..eba36710bc476 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -150,8 +150,20 @@ struct uart_8250_port {
 #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
 	u16			lsr_saved_flags;
 	u16			lsr_save_mask;
+
+	/*
+	 * Track when a console line has been fully written to the
+	 * hardware, i.e. true when the most recent byte written to
+	 * UART_TX by the console was '\n'.
+	 */
+	bool			console_line_ended;
+
+	/* Allow queuing irq_work for MSR handling */
+	bool			console_msr_work_allow;
+
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
+	struct irq_work		console_msr_work;
 
 	struct uart_8250_dma	*dma;
 	const struct uart_8250_ops *ops;
@@ -203,8 +215,8 @@ void serial8250_tx_chars(struct uart_8250_port *up);
 unsigned int serial8250_modem_status(struct uart_8250_port *up);
 void serial8250_init_port(struct uart_8250_port *up);
 void serial8250_set_defaults(struct uart_8250_port *up);
-void serial8250_console_write(struct uart_8250_port *up, const char *s,
-			      unsigned int count);
+void serial8250_console_write(struct uart_8250_port *up,
+			      struct nbcon_write_context *wctxt, bool in_atomic);
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe);
 int serial8250_console_exit(struct uart_port *port);
 
-- 
2.47.3

