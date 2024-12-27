Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F1158525;
	Fri, 27 Dec 2024 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735339536; cv=none; b=ET5xHiZPw3tBuwpmGLneXINxPhXu/d1Hm3ZF0ADwEhc5FCXWeWfeBfX/egSJEYdGU9ucB91vaElNtthfHvAPk5mN3HaTpXK6P/8OUu39rrlaT633/lsjQxg6X/TlxG0BBPyKVvLbbwTTAaMkqc3b2KIuxsL6gpZAtPHDJEFQgk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735339536; c=relaxed/simple;
	bh=2ZGiIUgMsPX77GCLFu0Uu1nElWI3oLL1xw1QVNOvoOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTpoRmXIyTuHWIQ31ljR9BBVGr2ZKGLx0tMxx0pkqrH4xbKrYYSkMeppcnGURw6LWC/fNA23oEpoyi9nvoenuzWBBEB2mAiFZ9/L1Qr3//JveoAopUj+BBf2PmJT5Rp3y/r+fJYwhM3wp/gduyan1pmdcIDyr4asaUL4g56RNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qb/StGQ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X4DP2cRt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qb/StGQ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X4DP2cRt"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735339527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkeDrc/RBAn/s0ivBR+9zpc2uVkypfbM9hDUcSXv7JU=;
	b=qb/StGQ+3taS87EFNEtTNh0s8xS6ZSp753xNzf5QuuKaLJtpblQ24jShwNC34o3qj4FIiE
	ZBvDmBw//JgUKa4ktx+5MTN6eGB8K5R5LfO/kkIU4NCsMiF6SDsPl95gk6AvCIiecFZz4t
	divwOJtahhkiXNMgKifaqf9zMkWYD27ZboKSRSuLP4ulVZdMvaA7Io3xedhPF9N7IQA38O
	mgqJqwMdyMJwaVocS+HypwKUP2HnWD9wI7V+jW45gPmNgLiysHJD3lXa1Q4MYB6qi7rTvb
	Et2f7wsxfaCP/c+MryMYjHylWyLLUPFpeITzbFcEnNZobJ/RWJQ9S5TEU7ZQ/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735339527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkeDrc/RBAn/s0ivBR+9zpc2uVkypfbM9hDUcSXv7JU=;
	b=X4DP2cRtTuqfiMxO0MKnTimCkQSAnH67BJEDtlW+W5wkPZ0aToyNLFpLpuMqX/qIkgQeGD
	3Nx6ObgCsmcf6BAg==
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
	Matt Turner <mattst88@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH tty-next v4 5/6] serial: 8250: Switch to nbcon console
Date: Fri, 27 Dec 2024 23:51:21 +0106
Message-Id: <20241227224523.28131-6-john.ogness@linutronix.de>
In-Reply-To: <20241227224523.28131-1-john.ogness@linutronix.de>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
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

All register access in the callbacks are within unsafe sections.
The ->write_atomic and ->write_therad() callbacks allow safe
handover/takeover per byte and add a preceding newline if they
take over from another context mid-line.

For the ->write_atomic() callback, a new irq_work is used to defer
modem control since it may be called from a context that does not
allow waking up tasks.

Note: A new __serial8250_clear_IER() is introduced for direct
clearing of UART_IER. This will allow to restore the lockdep
check to serial8250_clear_IER() in a follow-up commit.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c |  35 ++++++-
 drivers/tty/serial/8250/8250_port.c | 149 +++++++++++++++++++++-------
 include/linux/serial_8250.h         |   8 +-
 3 files changed, 150 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 2b70e82dffeb..3d5a2183ff13 100644
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
index e38271f477d1..fbba4746eccc 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -711,7 +711,12 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 	serial8250_rpm_put(p);
 }
 
-static void serial8250_clear_IER(struct uart_8250_port *up)
+/*
+ * Only to be used directly by the callback helper serial8250_console_write(),
+ * which may not require the port lock. Use serial8250_clear_IER() instead for
+ * all other cases.
+ */
+static void __serial8250_clear_IER(struct uart_8250_port *up)
 {
 	if (up->capabilities & UART_CAP_UUE)
 		serial_out(up, UART_IER, UART_IER_UUE);
@@ -719,6 +724,11 @@ static void serial8250_clear_IER(struct uart_8250_port *up)
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
@@ -1406,9 +1416,6 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
-	/* Port locked to synchronize UART_IER access against the console. */
-	lockdep_assert_held_once(&p->port.lock);
-
 	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
 		mcr |= UART_MCR_RTS;
 	else
@@ -1424,6 +1431,12 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 		serial8250_clear_and_reinit_fifos(p);
 
 		if (toggle_ier) {
+			/*
+			 * Port locked to synchronize UART_IER access
+			 * against the console
+			 */
+			lockdep_assert_held_once(&p->port.lock);
+
 			p->ier |= UART_IER_RLSI | UART_IER_RDI;
 			serial_port_out(&p->port, UART_IER, p->ier);
 		}
@@ -3302,7 +3315,11 @@ EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
 static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
+
 	serial_port_out(port, UART_TX, ch);
+
+	up->console_line_ended = (ch == '\n');
 }
 
 static void serial8250_console_wait_putchar(struct uart_port *port, unsigned char ch)
@@ -3339,14 +3356,21 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
-static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
+static int fifo_wait_for_lsr(struct uart_8250_port *up,
+			      struct nbcon_write_context *wctxt,
+			      unsigned int count)
 {
 	unsigned int i;
 
 	for (i = 0; i < count; i++) {
+		if (!nbcon_can_proceed(wctxt))
+			return -EPERM;
+
 		if (wait_for_lsr(up, UART_LSR_THRE))
-			return;
+			return 0;
 	}
+
+	return -ETIMEDOUT;
 }
 
 /*
@@ -3356,18 +3380,20 @@ static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
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
-		fifo_wait_for_lsr(up, fifosize);
+		if (fifo_wait_for_lsr(up, wctxt, fifosize) == -EPERM)
+			return;
 
 		for (i = 0; i < fifosize && s != end; ++i) {
 			if (*s == '\n' && !cr_sent) {
@@ -3385,39 +3411,51 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 	 * Allow timeout for each byte written since the caller will only wait
 	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
 	 */
-	fifo_wait_for_lsr(up, tx_count);
+	fifo_wait_for_lsr(up, wctxt, tx_count);
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
+	while (s != end && nbcon_can_proceed(wctxt))
+		uart_console_write(port, s++, 1, serial8250_console_wait_putchar);
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
+	 * First, save the IER, then disable the interrupts. The special
+	 * variant to clear the IER is used because console printing may
+	 * occur without holding the port lock.
 	 */
 	ier = serial_port_in(port, UART_IER);
-	serial8250_clear_IER(up);
+	__serial8250_clear_IER(up);
 
 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
@@ -3431,6 +3469,14 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
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
@@ -3452,9 +3498,16 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		!(up->port.flags & UPF_CONS_FLOW);
 
 	if (likely(use_fifo))
-		serial8250_console_fifo_write(up, s, count);
+		serial8250_console_fifo_write(up, wctxt);
 	else
-		uart_console_write(port, s, count, serial8250_console_wait_putchar);
+		serial8250_console_byte_write(up, wctxt);
+
+	/*
+	 * If ownership was lost, this context must reacquire ownership in
+	 * order to perform final actions (such as re-enabling interrupts).
+	 */
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire_nobuf(wctxt);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
@@ -3477,11 +3530,18 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
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
@@ -3499,8 +3559,24 @@ static unsigned int probe_baud(struct uart_port *port)
 	return (port->uartclk / 16) / quot;
 }
 
+/*
+ * irq_work handler to perform modem control. Only triggered via
+ * ->write_atomic() callback because it may be in a scheduler or
+ * NMI context, unable to wake tasks.
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
@@ -3510,6 +3586,9 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
+	up->console_line_ended = true;
+	init_irq_work(&up->modem_status_work, modem_status_handler);
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else if (probe)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 144de7a7948d..5a804dc5e05e 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -150,8 +150,12 @@ struct uart_8250_port {
 #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
 	u16			lsr_saved_flags;
 	u16			lsr_save_mask;
+
+	bool			console_line_ended;	/* line fully output */
+
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
+	struct irq_work		modem_status_work;
 
 	struct uart_8250_dma	*dma;
 	const struct uart_8250_ops *ops;
@@ -202,8 +206,8 @@ void serial8250_tx_chars(struct uart_8250_port *up);
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

