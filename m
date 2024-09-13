Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABD1DB95B;
	Fri, 13 Sep 2024 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236346; cv=none; b=I7AAyZ0RT6g+t7zD8myI+QYeV3ywS9Quq0GBpVftwFCO8ebss70JYYJyAHOPfzLESWD/N+3zNdAbUaRK8VXxz1k40X3Hd7fkm8vDgqABe7CA9N5xzOOMEmnFD5O+pHu4gIPRytPSr48Akr9XdbjCUDLe8Z9igtKaseexphYV75I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236346; c=relaxed/simple;
	bh=Z4P8fplRtRJxbblPa1IezvMhKSCwBWjB0dsIGXU/7MY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRUJ138/l3xb2Gj7tnHJFtT6p+2CoQ2df/gnMlSLCrVp0xEOwqXZSJ8KOuMCdJNmkx+FbCFktAX8Dv+OVWm4p/RCGGV6DAAdvx7pXC373MdTtQQrqdfPPNgK5moRBKwno87IL8poVGs/cnydagAdsuVeNvJD7G5zE2sQqXV4W94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NeCuqiOV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nROeLSSr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NeCuqiOV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nROeLSSr"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726236342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2qJgL7jg1r93GblbWHh8/o4/Jb12CtOJKsX7tOR3Bc=;
	b=NeCuqiOVND4UnhKFpsa1AgkLYbVfOSefh4BLd2tEJ6bOXBOkqoP1/j3J44eOJFq44/5UfM
	+zyvBSgyOZUb+KxGr/32trqsmbZvW3skCAkoaS07l48lfFMgYSqQNPgPZvEkaR6x2bhbFn
	vpksO1tksRWZKItTriqIbQMp2MKf2UQlgwU5aDQNYZoMLbiJ1wxY3tT8gNjcsYujtO8Ovy
	sTQkcnwxjaTTWuVjOCsUFevsmfFSZwDrj3oxz4Z0YVegqs0gj1pkAr+JBcMgHof0KQ6THx
	kfggRwItfDeEFJ8Gv6BmiZ6P2+GDnKgUokhpRnFYlTQ7RAV9elopeQ/PVIdVLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726236342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2qJgL7jg1r93GblbWHh8/o4/Jb12CtOJKsX7tOR3Bc=;
	b=nROeLSSrUbe8oNFFUkX9fFEEURLg7Lfi8keZGvr/Gju+haqhbWDlK+z4wLpKAYC8wO8FAl
	cDyXia57DzkcUZDg==
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
	Tony Lindgren <tony@atomide.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH next v2 3/4] serial: 8250: Switch to nbcon console
Date: Fri, 13 Sep 2024 16:11:37 +0206
Message-Id: <20240913140538.221708-4-john.ogness@linutronix.de>
In-Reply-To: <20240913140538.221708-1-john.ogness@linutronix.de>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
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
The write_thread() callback allows safe handover/takeover per byte.
The write_atomic() callback allows safe handover/takeover per
printk record and adds a preceding newline if it took over mid-line.

For the write_atomic() case, a new irq_work is used to defer modem
control since it may be a context that does not allow waking up
tasks.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c |  35 +++++-
 drivers/tty/serial/8250/8250_port.c | 188 +++++++++++++++++-----------
 include/linux/serial_8250.h         |   9 +-
 3 files changed, 151 insertions(+), 81 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 5f9f06911795..2d690ff32a32 100644
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
+	serial8250_console_write_atomic(up, wctxt);
+}
+
+static void univ8250_console_write_thread(struct console *co,
+					  struct nbcon_write_context *wctxt)
+{
+	struct uart_8250_port *up = &serial8250_ports[co->index];
+
+	serial8250_console_write_thread(up, wctxt);
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
index 7ee74ec944d2..d58a0fa95e3b 100644
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
@@ -1864,6 +1874,8 @@ unsigned int serial8250_modem_status(struct uart_8250_port *up)
 	struct uart_port *port = &up->port;
 	unsigned int status = serial_in(up, UART_MSR);
 
+	lockdep_assert_held_once(&port->lock);
+
 	status |= up->msr_saved_flags;
 	up->msr_saved_flags = 0;
 	if (status & UART_MSR_ANY_DELTA && up->ier & UART_IER_MSI &&
@@ -1884,6 +1896,21 @@ unsigned int serial8250_modem_status(struct uart_8250_port *up)
 }
 EXPORT_SYMBOL_GPL(serial8250_modem_status);
 
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
 static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 {
 	switch (iir & 0x3f) {
@@ -3296,6 +3323,11 @@ static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
 
 	wait_for_xmitr(up, UART_LSR_THRE);
 	serial_port_out(port, UART_TX, ch);
+
+	if (ch == '\n')
+		up->console_line_ended = true;
+	else
+		up->console_line_ended = false;
 }
 
 /*
@@ -3324,65 +3356,68 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
-/*
- * Print a string to the serial port using the device FIFO
- *
- * It sends fifosize bytes and then waits for the fifo
- * to get empty.
- */
-static void serial8250_console_fifo_write(struct uart_8250_port *up,
-					  const char *s, unsigned int count)
+static void __serial8250_console_write_thread(struct uart_8250_port *up,
+					      struct nbcon_write_context *wctxt)
 {
-	int i;
-	const char *end = s + count;
-	unsigned int fifosize = up->tx_loadsz;
-	bool cr_sent = false;
-
-	while (s != end) {
-		wait_for_lsr(up, UART_LSR_THRE);
-
-		for (i = 0; i < fifosize && s != end; ++i) {
-			if (*s == '\n' && !cr_sent) {
-				serial_out(up, UART_TX, '\r');
-				cr_sent = true;
-			} else {
-				serial_out(up, UART_TX, *s++);
-				cr_sent = false;
-			}
+	unsigned int len = READ_ONCE(wctxt->len);
+	struct uart_port *port = &up->port;
+	unsigned int i;
+
+	if (nbcon_exit_unsafe(wctxt)) {
+		/*
+		 * Write out the message. Toggle unsafe for each byte in order
+		 * to give another (higher priority) context the opportunity
+		 * for a friendly takeover. If such a takeover occurs, this
+		 * must abort writing since wctxt->outbuf and wctxt->len are
+		 * no longer valid.
+		 */
+		for (i = 0; i < len; i++) {
+			if (!nbcon_enter_unsafe(wctxt))
+				break;
+
+			uart_console_write(port, wctxt->outbuf + i, 1, serial8250_console_putchar);
+
+			if (!nbcon_exit_unsafe(wctxt))
+				break;
 		}
 	}
+
+	/*
+	 * If ownership was lost, this context must reacquire ownership in
+	 * order to perform final actions (such as re-enabling interrupts).
+	 */
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire_nobuf(wctxt);
 }
 
-/*
- *	Print a string to the serial port trying not to disturb
- *	any possible real use of the port...
- *
- *	The console_lock must be held when we get here.
- *
- *	Doing runtime PM is really a bad idea for the kernel console.
- *	Thus, we assume the function is called when device is powered up.
- */
-void serial8250_console_write(struct uart_8250_port *up, const char *s,
-			      unsigned int count)
+static void __serial8250_console_write_atomic(struct uart_8250_port *up,
+					      struct nbcon_write_context *wctxt)
 {
-	struct uart_8250_em485 *em485 = up->em485;
 	struct uart_port *port = &up->port;
-	unsigned long flags;
-	unsigned int ier, use_fifo;
-	int locked = 1;
 
-	touch_nmi_watchdog();
+	if (!up->console_line_ended)
+		uart_console_write(port, "\n", 1, serial8250_console_putchar);
+	uart_console_write(port, wctxt->outbuf, wctxt->len, serial8250_console_putchar);
+}
 
-	if (oops_in_progress)
-		locked = uart_port_trylock_irqsave(port, &flags);
-	else
-		uart_port_lock_irqsave(port, &flags);
+static void serial8250_console_write(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt,
+				     bool is_atomic)
+{
+	struct uart_8250_em485 *em485 = up->em485;
+	struct uart_port *port = &up->port;
+	unsigned int ier;
+
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
@@ -3396,30 +3431,10 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		mdelay(port->rs485.delay_rts_before_send);
 	}
 
-	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
-		/*
-		 * BCM283x requires to check the fifo
-		 * after each byte.
-		 */
-		!(up->capabilities & UART_CAP_MINI) &&
-		/*
-		 * tx_loadsz contains the transmit fifo size
-		 */
-		up->tx_loadsz > 1 &&
-		(up->fcr & UART_FCR_ENABLE_FIFO) &&
-		port->state &&
-		test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&
-		/*
-		 * After we put a data in the fifo, the controller will send
-		 * it regardless of the CTS state. Therefore, only use fifo
-		 * if we don't use control flow.
-		 */
-		!(up->port.flags & UPF_CONS_FLOW);
-
-	if (likely(use_fifo))
-		serial8250_console_fifo_write(up, s, count);
+	if (is_atomic)
+		__serial8250_console_write_atomic(up, wctxt);
 	else
-		uart_console_write(port, s, count, serial8250_console_putchar);
+		__serial8250_console_write_thread(up, wctxt);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
@@ -3442,11 +3457,32 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
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
+}
+
+void serial8250_console_write_thread(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt)
+{
+	serial8250_console_write(up, wctxt, false);
+}
+
+void serial8250_console_write_atomic(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt)
+{
+	touch_nmi_watchdog();
+
+	serial8250_console_write(up, wctxt, true);
 }
 
 static unsigned int probe_baud(struct uart_port *port)
@@ -3466,6 +3502,7 @@ static unsigned int probe_baud(struct uart_port *port)
 
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
@@ -3475,6 +3512,9 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
+	up->console_line_ended = true;
+	up->modem_status_work = IRQ_WORK_INIT(modem_status_handler);
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else if (probe)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index fd59ed2cca53..75c1f93fec73 100644
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
@@ -202,8 +205,10 @@ void serial8250_tx_chars(struct uart_8250_port *up);
 unsigned int serial8250_modem_status(struct uart_8250_port *up);
 void serial8250_init_port(struct uart_8250_port *up);
 void serial8250_set_defaults(struct uart_8250_port *up);
-void serial8250_console_write(struct uart_8250_port *up, const char *s,
-			      unsigned int count);
+void serial8250_console_write_atomic(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt);
+void serial8250_console_write_thread(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt);
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe);
 int serial8250_console_exit(struct uart_port *port);
 
-- 
2.39.2

