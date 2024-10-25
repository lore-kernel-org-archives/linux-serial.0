Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30F1FDF87;
	Fri, 25 Oct 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853858; cv=none; b=No1kiQsdNVlC+fkEB3uGOM5yqtD/WAXWUPF1QExM5mUtRnvfUaV1pztPsD3UhipPTF55tE1cXT8tVMDHxbuq4s8CO5UIAk4cT2JfRYuq69dSSneCZ84zfJjwYDi4A8FQKprHrIyeI9rpyiktWy3XBJPbR7W8cYtGFuPie6Lhpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853858; c=relaxed/simple;
	bh=3h+txqWzyjQpA7zaMYUC0Z5J9ymUMNDS1VQdHw/pS7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L39ZM8NpCvlogEdQE/DnW2bAf8G4X3ond41bW/+m8XUpTuPYKVhJ0R+2mBF1OignESk4DvI2Tn9rxt+u5aQFW4kLERGI0lPlgOsUp1XEQ+dXFgTawUNDLAYq/uKwIWraOrgNPQJVxSKg0AaDTfvn8F38DRK+XHjMPCwcctndHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m+7GBTgU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JpfBptI6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m+7GBTgU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JpfBptI6"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729853853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcQUijP5hAsE4CbjXcrwMKxgGZrjYODkUVfif5UcrIs=;
	b=m+7GBTgUwqEJjvIub/v3OqICAiG1GIHCYdH0eJqBAt99HhbHMKWjQp1MAaPZT8nhPIL8WS
	5g4N7lisjhZWt+EJ7v/evBZOtpSsmA8Kf6lbAc5n8efcwyZvOz8pYZfjor53+UxhOb+dmr
	VgzxfyRVf20ZA8hHLr+UQRlaIHFS6d0C8Ro3ZhvA+aTU9FZ0fexxLe4InivYjoNX87PrYD
	cNzVnqzUYYuq3MQaWM5Ugqb/qr6bw4YU/uRX3UrejBcNkeXrCyL5rghJUsSxzU7yhhMR7i
	nJnuGlu//Lb0JHcKFxN1LAJndTjCsYIJVNV4uV1HMBsMn9oPm/jNo4EFkMZHIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729853853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WcQUijP5hAsE4CbjXcrwMKxgGZrjYODkUVfif5UcrIs=;
	b=JpfBptI6BFNZWYGAELUhnPUEvGCHt/IQr72Vp41PhE6n3QomSN60EkyFevEH9+SuxLOWJJ
	LIqyMvg4iY319ICQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH tty-next v3 5/6] serial: 8250: Switch to nbcon console
Date: Fri, 25 Oct 2024 13:03:27 +0206
Message-Id: <20241025105728.602310-6-john.ogness@linutronix.de>
In-Reply-To: <20241025105728.602310-1-john.ogness@linutronix.de>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the necessary callbacks to switch the 8250 console driver
to perform as an nbcon console.

Add implementations for the nbcon console callbacks (write_atomic,
write_thread, device_lock, device_unlock) and add CON_NBCON to the
initial flags.

All register access in the callbacks are within unsafe sections.
The write callbacks allow safe handover/takeover per byte and add
a preceding newline if they take over mid-line.

For the write_atomic() case, a new irq_work is used to defer modem
control since it may be a context that does not allow waking up
tasks.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c |  35 +++++-
 drivers/tty/serial/8250/8250_port.c | 159 ++++++++++++++++++++++------
 include/linux/serial_8250.h         |   7 +-
 3 files changed, 164 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 5f9f06911795..7184100129bd 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -388,12 +388,34 @@ void __init serial8250_register_ports(struct uart_driver *drv, struct device *de
 
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
+static void univ8250_console_device_lock(struct console *con, unsigned long *flags)
+{
+	struct uart_port *up = &serial8250_ports[con->index].port;
+
+	__uart_port_lock_irqsave(up, flags);
+}
+
+static void univ8250_console_device_unlock(struct console *con, unsigned long flags)
+{
+	struct uart_port *up = &serial8250_ports[con->index].port;
+
+	__uart_port_unlock_irqrestore(up, flags);
 }
 
 static int univ8250_console_setup(struct console *co, char *options)
@@ -494,12 +516,15 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 
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
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7c50387194ad..0b3596fab061 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -691,7 +691,12 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 	serial8250_rpm_put(p);
 }
 
-static void serial8250_clear_IER(struct uart_8250_port *up)
+/*
+ * Only to be used directly by the console write callbacks, which may not
+ * require the port lock. Use serial8250_clear_IER() instead for all other
+ * cases.
+ */
+static void __serial8250_clear_IER(struct uart_8250_port *up)
 {
 	if (up->capabilities & UART_CAP_UUE)
 		serial_out(up, UART_IER, UART_IER_UUE);
@@ -699,6 +704,11 @@ static void serial8250_clear_IER(struct uart_8250_port *up)
 		serial_out(up, UART_IER, 0);
 }
 
+static inline void serial8250_clear_IER(struct uart_8250_port *up)
+{
+	__serial8250_clear_IER(up);
+}
+
 #ifdef CONFIG_SERIAL_8250_RSA
 /*
  * Attempts to turn on the RSA FIFO.  Returns zero on failure.
@@ -3296,7 +3306,14 @@ EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
 static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
+
 	serial_port_out(port, UART_TX, ch);
+
+	if (ch == '\n')
+		up->console_line_ended = true;
+	else
+		up->console_line_ended = false;
 }
 
 static void serial8250_console_wait_putchar(struct uart_port *port, unsigned char ch)
@@ -3340,9 +3357,10 @@ static void serial8250_console_restore(struct uart_8250_port *up)
  * to get empty.
  */
 static void serial8250_console_fifo_write(struct uart_8250_port *up,
-					  const char *s, unsigned int count)
+					  struct nbcon_write_context *wctxt)
 {
-	const char *end = s + count;
+	const char *s = READ_ONCE(wctxt->outbuf);
+	const char *end = s + READ_ONCE(wctxt->len);
 	unsigned int fifosize = up->tx_loadsz;
 	struct uart_port *port = &up->port;
 	unsigned int tx_count = 0;
@@ -3352,10 +3370,19 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 	while (s != end) {
 		/* Allow timeout for each byte of a possibly full FIFO. */
 		for (i = 0; i < fifosize; i++) {
+			if (!nbcon_enter_unsafe(wctxt))
+				return;
+
 			if (wait_for_lsr(up, UART_LSR_THRE))
 				break;
+
+			if (!nbcon_exit_unsafe(wctxt))
+				return;
 		}
 
+		if (!nbcon_enter_unsafe(wctxt))
+			return;
+
 		for (i = 0; i < fifosize && s != end; ++i) {
 			if (*s == '\n' && !cr_sent) {
 				serial8250_console_putchar(port, '\r');
@@ -3366,45 +3393,74 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 			}
 		}
 		tx_count = i;
+
+		if (!nbcon_exit_unsafe(wctxt))
+			return;
 	}
 
 	/* Allow timeout for each byte written. */
 	for (i = 0; i < tx_count; i++) {
+		if (!nbcon_enter_unsafe(wctxt))
+			return;
+
 		if (wait_for_lsr(up, UART_LSR_THRE))
 			break;
+
+		if (!nbcon_exit_unsafe(wctxt))
+			return;
+	}
+}
+
+static void serial8250_console_byte_write(struct uart_8250_port *up,
+					  struct nbcon_write_context *wctxt)
+{
+	const char *s = READ_ONCE(wctxt->outbuf);
+	const char *end = s + READ_ONCE(wctxt->len);
+	struct uart_port *port = &up->port;
+
+	/*
+	 * Write out the message. Toggle unsafe for each byte in order to give
+	 * another (higher priority) context the opportunity for a friendly
+	 * takeover. If such a takeover occurs, this must abort writing since
+	 * wctxt->outbuf and wctxt->len are no longer valid.
+	 */
+	while (s != end) {
+		if (!nbcon_enter_unsafe(wctxt))
+			return;
+
+		uart_console_write(port, s++, 1, serial8250_console_wait_putchar);
+
+		if (!nbcon_exit_unsafe(wctxt))
+			return;
 	}
 }
 
 /*
- *	Print a string to the serial port trying not to disturb
- *	any possible real use of the port...
+ * Print a string to the serial port trying not to disturb
+ * any possible real use of the port...
  *
- *	The console_lock must be held when we get here.
- *
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
+	 * First save IER then disable the interrupts. The special variant
+	 * to clear IER is used because console printing may occur without
+	 * holding the port lock.
 	 */
 	ier = serial_port_in(port, UART_IER);
-	serial8250_clear_IER(up);
+	__serial8250_clear_IER(up);
 
 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
@@ -3418,6 +3474,14 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		mdelay(port->rs485.delay_rts_before_send);
 	}
 
+	/*
+	 * If console printer did not fully output the previous line, it must
+	 * have been handed or taken over. Insert a newline in order to
+	 * maintain clean output.
+	 */
+	if (!up->console_line_ended && nbcon_can_proceed(wctxt))
+		uart_console_write(port, "\n", 1, serial8250_console_wait_putchar);
+
 	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
 		/*
 		 * BCM283x requires to check the fifo
@@ -3438,10 +3502,19 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		 */
 		!(up->port.flags & UPF_CONS_FLOW);
 
-	if (likely(use_fifo))
-		serial8250_console_fifo_write(up, s, count);
-	else
-		uart_console_write(port, s, count, serial8250_console_wait_putchar);
+	if (nbcon_exit_unsafe(wctxt)) {
+		if (likely(use_fifo))
+			serial8250_console_fifo_write(up, wctxt);
+		else
+			serial8250_console_byte_write(up, wctxt);
+	}
+
+	/*
+	 * If ownership was lost, this context must reacquire ownership in
+	 * order to perform final actions (such as re-enabling interrupts).
+	 */
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire_nobuf(wctxt);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
@@ -3464,11 +3537,18 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	 *	call it if we have saved something in the saved flags
 	 *	while processing with interrupts off.
 	 */
-	if (up->msr_saved_flags)
-		serial8250_modem_status(up);
+	if (up->msr_saved_flags) {
+		/*
+		 * For atomic, it must be deferred to irq_work because this
+		 * may be a context that does not permit waking up tasks.
+		 */
+		if (is_atomic)
+			irq_work_queue(&up->modem_status_work);
+		else
+			serial8250_modem_status(up);
+	}
 
-	if (locked)
-		uart_port_unlock_irqrestore(port, flags);
+	nbcon_exit_unsafe(wctxt);
 }
 
 static unsigned int probe_baud(struct uart_port *port)
@@ -3486,8 +3566,24 @@ static unsigned int probe_baud(struct uart_port *port)
 	return (port->uartclk / 16) / quot;
 }
 
+/*
+ * irq_work handler to perform modem control. Only triggered via
+ * write_atomic() callback because it may be in a scheduler or NMI
+ * context, unable to wake tasks.
+ */
+static void modem_status_handler(struct irq_work *iwp)
+{
+	struct uart_8250_port *up = container_of(iwp, struct uart_8250_port, modem_status_work);
+	struct uart_port *port = &up->port;
+
+	uart_port_lock(port);
+	serial8250_modem_status(up);
+	uart_port_unlock(port);
+}
+
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
@@ -3497,6 +3593,9 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
+	up->console_line_ended = true;
+	up->modem_status_work = IRQ_WORK_INIT(modem_status_handler);
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else if (probe)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index c25c026d173d..c6c391b15efc 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -152,6 +152,9 @@ struct uart_8250_port {
 	u16			lsr_save_mask;
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
+	struct irq_work		modem_status_work;
+
+	bool			console_line_ended;	/* line fully output */
 
 	struct uart_8250_dma	*dma;
 	const struct uart_8250_ops *ops;
@@ -202,8 +205,8 @@ void serial8250_tx_chars(struct uart_8250_port *up);
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
2.39.5

