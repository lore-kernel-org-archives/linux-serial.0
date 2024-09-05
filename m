Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94719D880;
	Thu,  5 Sep 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544044; cv=none; b=GXRJPxSU+eMyYVR7nI66zk+H1YvU+YbwxjYz31BY5aBbYq0Xo2AXmQi/IEYH8L5YIueEy0cFGz92y0KuGyS8MyVPvH3rxBLYkyDSL8O25ien+dFTs/kYiMYENGdLPpHe0kpzzCxRmB/UX8QzMFD8fDT1gjlwTKAAmz0JPy1qwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544044; c=relaxed/simple;
	bh=aR5pjljPwp0kbLSqiOuGbEUH2X/L4DTm/of8DR+TlD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDR6UyUfJwtFVRr4V2AOCQe4ZXwqjxGBykHSJZslHSvLXbcHB6akl6yNF/x5Xl2qo++fDFbILtdIPLqVQQmbB1TLgrQYVcpqDmVeOURukPzVsiHHoDws5IqngR11TFjWeIg13e0cHTxRGVpj27Nj4hsgv0+vIGJqAKF09clytZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VPJI4AGe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cn6wTWs9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VPJI4AGe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cn6wTWs9"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725544040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S05KVJ4znAxD+xloTyKCHCavGkPrewYRr3lg2CIe4Kk=;
	b=VPJI4AGe7BAn4yjJ9A9utltwjxGY66Zvjm1JP6a1jgRmnjisrIh66mFqAsAAvnJ8FwhYhi
	Js0nabVdBqBTYF8+wBLW2Mb5XxpsXNEaQwD0CABWfWAivoGV8zOKLzV8lbTmrYcfPFv+Mr
	E3v9/4uDPDekScrjVUoRZI6G+x7M1TzDAfcejCTeB8CJzKnPrG360SuR52hO3gUgNozMgF
	xRr+g8+51FjUp77LEU8nUTebijZePaOW+RaaF2zdLqYYQukk5IJ0gVsiGFcztqWVO2SkKm
	5BAE1NdMyuIUnbxLa+3VFi9+OIpQENYUUjNmLvrCynrUUWoYLXI2eNj8ix+ZoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725544040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S05KVJ4znAxD+xloTyKCHCavGkPrewYRr3lg2CIe4Kk=;
	b=Cn6wTWs9GS9LEgjAOUl3l/rIj3ywtGw8UlYX7CqJbHoXGPPaj4vNfFCwNAKvAqpZsfxFTQ
	590ysR4MOkGEMCCw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
Date: Thu,  5 Sep 2024 15:53:18 +0206
Message-Id: <20240905134719.142554-2-john.ogness@linutronix.de>
In-Reply-To: <20240905134719.142554-1-john.ogness@linutronix.de>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
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

The legacy code is kept in order to easily switch back to legacy mode
by defining USE_SERIAL_8250_LEGACY_CONSOLE.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c |  42 +++++++-
 drivers/tty/serial/8250/8250_port.c | 148 +++++++++++++++++++++++++++-
 include/linux/serial_8250.h         |   6 ++
 3 files changed, 193 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 29e4b83e0376..d7079931dd7e 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -388,6 +388,7 @@ void __init serial8250_register_ports(struct uart_driver *drv, struct device *de
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
+#ifdef USE_SERIAL_8250_LEGACY_CONSOLE
 static void univ8250_console_write(struct console *co, const char *s,
 				   unsigned int count)
 {
@@ -395,6 +396,37 @@ static void univ8250_console_write(struct console *co, const char *s,
 
 	serial8250_console_write(up, s, count);
 }
+#else
+static void univ8250_console_write_atomic(struct console *co,
+					  struct nbcon_write_context *wctxt)
+{
+	struct uart_8250_port *up = &serial8250_ports[co->index];
+
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
+}
+#endif /* USE_SERIAL_8250_LEGACY_CONSOLE */
 
 static int univ8250_console_setup(struct console *co, char *options)
 {
@@ -494,12 +526,20 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 
 static struct console univ8250_console = {
 	.name		= "ttyS",
+#ifdef USE_SERIAL_8250_LEGACY_CONSOLE
 	.write		= univ8250_console_write,
+	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
+#else
+	.write_atomic	= univ8250_console_write_atomic,
+	.write_thread	= univ8250_console_write_thread,
+	.device_lock	= univ8250_console_device_lock,
+	.device_unlock	= univ8250_console_device_unlock,
+	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
+#endif
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
 	.exit		= univ8250_console_exit,
 	.match		= univ8250_console_match,
-	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
 	.index		= -1,
 	.data		= &serial8250_reg,
 };
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3509af7dc52b..ce841c62900d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -546,6 +546,13 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 	if (!p->em485)
 		return -ENOMEM;
 
+#ifndef USE_SERIAL_8250_LEGACY_CONSOLE
+	if (uart_console(&p->port)) {
+		dev_warn(p->port.dev, "no atomic printing for rs485 consoles\n");
+		p->port.cons->write_atomic = NULL;
+	}
+#endif
+
 	hrtimer_init(&p->em485->stop_tx_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
 	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
@@ -691,7 +698,11 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 	serial8250_rpm_put(p);
 }
 
-static void serial8250_clear_IER(struct uart_8250_port *up)
+/*
+ * Only to be used by write_atomic() and the legacy write(), which do not
+ * require port lock.
+ */
+static void __serial8250_clear_IER(struct uart_8250_port *up)
 {
 	if (up->capabilities & UART_CAP_UUE)
 		serial_out(up, UART_IER, UART_IER_UUE);
@@ -699,6 +710,11 @@ static void serial8250_clear_IER(struct uart_8250_port *up)
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
@@ -3269,6 +3285,11 @@ static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
 
 	wait_for_xmitr(up, UART_LSR_THRE);
 	serial_port_out(port, UART_TX, ch);
+
+	if (ch == '\n')
+		up->console_newline_needed = false;
+	else
+		up->console_newline_needed = true;
 }
 
 /*
@@ -3297,6 +3318,7 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
+#ifdef USE_SERIAL_8250_LEGACY_CONSOLE
 /*
  * Print a string to the serial port using the device FIFO
  *
@@ -3355,7 +3377,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	 *	First save the IER then disable the interrupts
 	 */
 	ier = serial_port_in(port, UART_IER);
-	serial8250_clear_IER(up);
+	__serial8250_clear_IER(up);
 
 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
@@ -3421,6 +3443,125 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (locked)
 		uart_port_unlock_irqrestore(port, flags);
 }
+#else
+void serial8250_console_write_thread(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt)
+{
+	struct uart_8250_em485 *em485 = up->em485;
+	struct uart_port *port = &up->port;
+	unsigned int ier;
+
+	touch_nmi_watchdog();
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
+
+	/* First save IER then disable the interrupts. */
+	ier = serial_port_in(port, UART_IER);
+	serial8250_clear_IER(up);
+
+	/* Check scratch reg if port powered off during system sleep. */
+	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
+		serial8250_console_restore(up);
+		up->canary = 0;
+	}
+
+	if (em485) {
+		if (em485->tx_stopped)
+			up->rs485_start_tx(up);
+		mdelay(port->rs485.delay_rts_before_send);
+	}
+
+	if (nbcon_exit_unsafe(wctxt)) {
+		int len = READ_ONCE(wctxt->len);
+		int i;
+
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
+		}
+	}
+
+	/*
+	 * If ownership was lost, this context must reacquire ownership in
+	 * order to perform final actions (such as re-enabling interrupts).
+	 */
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire_nobuf(wctxt);
+
+	/* Finally, wait for transmitter to become empty and restore IER. */
+	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
+	if (em485) {
+		mdelay(port->rs485.delay_rts_after_send);
+		if (em485->tx_stopped)
+			up->rs485_stop_tx(up);
+	}
+	serial_port_out(port, UART_IER, ier);
+
+	/*
+	 * The receive handling will happen properly because the receive ready
+	 * bit will still be set; it is not cleared on read.  However, modem
+	 * control will not, we must call it if we have saved something in the
+	 * saved flags while processing with interrupts off.
+	 */
+	if (up->msr_saved_flags)
+		serial8250_modem_status(up);
+
+	nbcon_exit_unsafe(wctxt);
+}
+
+void serial8250_console_write_atomic(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt)
+{
+	struct uart_port *port = &up->port;
+	unsigned int ier;
+
+	/* Atomic console not supported for rs485 mode. */
+	if (WARN_ON_ONCE(up->em485))
+		return;
+
+	touch_nmi_watchdog();
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return;
+
+	/*
+	 * First save IER then disable the interrupts. The special variant to
+	 * clear IER is used because atomic printing may occur without holding
+	 * the port lock.
+	 */
+	ier = serial_port_in(port, UART_IER);
+	__serial8250_clear_IER(up);
+
+	/* Check scratch reg if port powered off during system sleep. */
+	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
+		serial8250_console_restore(up);
+		up->canary = 0;
+	}
+
+	if (up->console_newline_needed)
+		uart_console_write(port, "\n", 1, serial8250_console_putchar);
+	uart_console_write(port, wctxt->outbuf, wctxt->len, serial8250_console_putchar);
+
+	/* Finally, wait for transmitter to become empty and restore IER. */
+	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
+	serial_port_out(port, UART_IER, ier);
+
+	nbcon_exit_unsafe(wctxt);
+}
+#endif /* USE_SERIAL_8250_LEGACY_CONSOLE */
 
 static unsigned int probe_baud(struct uart_port *port)
 {
@@ -3439,6 +3580,7 @@ static unsigned int probe_baud(struct uart_port *port)
 
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
@@ -3448,6 +3590,8 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
+	up->console_newline_needed = false;
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else if (probe)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index e0717c8393d7..a968e6941237 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -153,6 +153,8 @@ struct uart_8250_port {
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
 
+	bool			console_newline_needed;
+
 	struct uart_8250_dma	*dma;
 	const struct uart_8250_ops *ops;
 
@@ -204,6 +206,10 @@ void serial8250_init_port(struct uart_8250_port *up);
 void serial8250_set_defaults(struct uart_8250_port *up);
 void serial8250_console_write(struct uart_8250_port *up, const char *s,
 			      unsigned int count);
+void serial8250_console_write_atomic(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt);
+void serial8250_console_write_thread(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt);
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe);
 int serial8250_console_exit(struct uart_port *port);
 
-- 
2.39.2

