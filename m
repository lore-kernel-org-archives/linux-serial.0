Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3481AC458
	for <linux-serial@vger.kernel.org>; Wed, 14 May 2025 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244146; cv=none; b=oQPa8ANcdt14Jt8Ae3xl40ZwaOrmwqXKM/z3oF757BcpcTY0LYqCkHa5Zo5yjzTj9gFlxkWlF1pwCvusFfyRmuVKtPuKb/Oi6IEUdI/tUlcX4qidT+ZHjBfLnKBqBHBqnyXtIcYXwPmpteHJS9j4T6+9U5vcJ3UAF/xu/5MMw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244146; c=relaxed/simple;
	bh=cOsZR9eki30BBPWxobe0xKRagLlB6AxRlUo7QoJMw0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvDzdxfEh15T0JnAXxbkDSdKarSYu3XUwBTqAnXJLLw9GcY92HFZZvYcbQAMPOxEg7ZC+VCW/FyCfrdAsgUygLQxqP8+pbOdRqc4f2iIn0wCMxGT16mq6PCFDAmiRoLNXJK7ikmT7BVozVvc3tL4r3Ei4jtc8n4fWPe3ghndl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=s8nt/BeN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="s8nt/BeN"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0adcc3e54so26626f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 14 May 2025 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1747244143; x=1747848943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r36cirOSSd3SJ2MZHyiDUu05apYQtaDziygpXY/veNU=;
        b=s8nt/BeNGHvJnUVJidHZHPOXGKPWBMDM0uuhumLPtYg6HJ8kdFR0Itfe/M6LZJUQWX
         5U5ZD81ViuImCPwioap7MkReC1OuqgiOsC5GoXHN/e7NeE7rtIW/d+TTrNaGssUvxBFz
         Cj/KSUS5PDRenc6iJt+59NPVC/Bj226ZJayLtt3bxSDZ4C5ULTo3nlb/hnrxVzjHtx+R
         RwlYfaNpdsACG4/zxgp8XvGjUeUqGGqlxmfwUD8dpZ2864N/ukU2fGvX6UNlqS5Y+29B
         6IMINCdiw7exqVIt56J/+6+ecp2oOiOOXhDaaVgY8T7yYTuSUA692WqPTPco1Qkbr5kP
         9UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244143; x=1747848943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r36cirOSSd3SJ2MZHyiDUu05apYQtaDziygpXY/veNU=;
        b=tHAwmsFyEooFKIHQoaNbjBd/wxB0o5ffhLlT5JpWmrhJ8eBevfk4X4HMJTYo1NVByS
         nq7uhOE1zP4AyqS4a/yMg/vNuEQgWxSsLmdPbCJ5Yg3xEOQ2WIkdDFa9s6wL0ytoZLcL
         +0pP+U78ZDWCNDNU0NLn/+W0iDlUePINjv/y2HC9n6eTGrrO4pkO34j75P6wxgXF5b3g
         Y7i+/H/2JX4o1UY3WWQbS7NPujt8d26tiOCPvqc0wvQA0DEzzK8teU6T5OvTq2Yhq1sZ
         VKBiaQy6Ug2MBCHi0/qymN+xVYxcSFS4/itVimwrhxlND4CWqA9OorMOD/im6Q0WQ3Nl
         dNPg==
X-Gm-Message-State: AOJu0Yxo1L7tM74Qq7w+QGk+MMHkasGvUoxmCP/LMr5W/5jVJkDvkxfB
	kIS2KMZEPTrmw0txcSpCrxVaGKBInWoVBkHK+x3QQO0BQmVu5IbKn6gDXkz6hRs=
X-Gm-Gg: ASbGncu3YQSDxkgkRSmZg7Y6CNCAKW8BLDzWgmHtjIlcK/f6LWglRl1WzOGg2Uj1pUV
	K7zlX4iMed7S9V4fj175ovCdqI1mkrWV5nCtWjQ3XIf40yUPA+YiSL6BbdjhZiRfnX/N4JlojU+
	w6A2bBnITSkl40SIh75UhVE62mPKAwQDgHeS/vOThrtH0YmkV86B3rKIbMrVGL5Tm0F2yi47KzE
	Rul8JzUu7zK2CznDLsSvIB/4RBlTHl/wbJuzNDkiEhwFC7097Sj/jhXeNZuOZEuB0wEEwE+CK9P
	FlwrqetkXoIj7gKInuGcoxqSnvIm51XOV6Fl9PwHYbCVXfc946rkPCS/QNZ6KB9TezN4ut6RaB1
	QYVsyMwCIrlDjTFWjnh4xGFNmxAFo2XITTjRIGBDfZmwj5NLmKzq7lYpFXWCXC4rL5Z04
X-Google-Smtp-Source: AGHT+IGKgJ6epA44I+AuI+kNN3v/KxxsnzXt6vNmIIi3S0Ij3XqckSoAkIhXjfCWH5wKtIGmN662lg==
X-Received: by 2002:a5d:588a:0:b0:391:4873:7943 with SMTP id ffacd0b85a97d-3a3496cfee1mr3722817f8f.32.1747244142609;
        Wed, 14 May 2025 10:35:42 -0700 (PDT)
Received: from ubuntu-dell-xps.thegp.cloud (shef-16-b2-v4wan-169484-cust3641.vm3.cable.virginm.net. [92.236.206.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2a79sm20058436f8f.48.2025.05.14.10.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:35:41 -0700 (PDT)
From: Michael Cobb <mcobb@thegoodpenguin.co.uk>
To: pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org
Cc: linux-serial@vger.kernel.org,
	Michael Cobb <mcobb@thegoodpenguin.co.uk>
Subject: [PATCH RFC 2/3] Reapply "serial: 8250: Switch to nbcon console"
Date: Wed, 14 May 2025 18:35:13 +0100
Message-ID: <20250514173514.2117832-3-mcobb@thegoodpenguin.co.uk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
References: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f79b163c42314a1f46f4bcc40a19c8a75cf1e7a3.
---
 drivers/tty/serial/8250/8250_core.c |  35 +++++-
 drivers/tty/serial/8250/8250_port.c | 180 ++++++++++++++++++++++------
 include/linux/serial_8250.h         |  13 +-
 3 files changed, 187 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 6f676bb37ac3..3ab372b28cf3 100644
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
index c57f44882abb..ef7dfab908d8 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -709,7 +709,12 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
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
@@ -717,6 +722,11 @@ static void serial8250_clear_IER(struct uart_8250_port *up)
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
@@ -1404,9 +1414,6 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
 {
 	unsigned char mcr = serial8250_in_MCR(p);
 
-	/* Port locked to synchronize UART_IER access against the console. */
-	lockdep_assert_held_once(&p->port.lock);
-
 	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
 		mcr |= UART_MCR_RTS;
 	else
@@ -1422,6 +1429,16 @@ void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier)
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
@@ -3310,7 +3327,11 @@ EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
 static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
+
 	serial_port_out(port, UART_TX, ch);
+
+	up->console_line_ended = (ch == '\n');
 }
 
 static void serial8250_console_wait_putchar(struct uart_port *port, unsigned char ch)
@@ -3347,11 +3368,22 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
-static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
+static void fifo_wait_for_lsr(struct uart_8250_port *up,
+			      struct nbcon_write_context *wctxt,
+			      unsigned int count)
 {
 	unsigned int i;
 
 	for (i = 0; i < count; i++) {
+		/*
+		 * Pass the ownership as quickly as possible to a higher
+		 * priority context. Otherwise, its attempt to take over
+		 * the ownership might timeout. The new owner will wait
+		 * for UART_LSR_THRE before reusing the fifo.
+		 */
+		if (!nbcon_can_proceed(wctxt))
+			return;
+
 		if (wait_for_lsr(up, UART_LSR_THRE))
 			return;
 	}
@@ -3364,20 +3396,29 @@ static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
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
+		fifo_wait_for_lsr(up, wctxt, fifosize);
 
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
@@ -3385,6 +3426,8 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 				serial8250_console_putchar(port, *s++);
 				cr_sent = false;
 			}
+
+			nbcon_exit_unsafe(wctxt);
 		}
 		tx_count = i;
 	}
@@ -3393,39 +3436,57 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
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
+	 * variant to clear the IER is used because console printing may
+	 * occur without holding the port lock.
 	 */
 	ier = serial_port_in(port, UART_IER);
-	serial8250_clear_IER(up);
+	__serial8250_clear_IER(up);
 
 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
@@ -3439,6 +3500,18 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
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
@@ -3459,10 +3532,23 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		 */
 		!(up->port.flags & UPF_CONS_FLOW);
 
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
+	 * If ownership was lost, this context must reacquire ownership and
+	 * re-enter the unsafe section in order to perform final actions
+	 * (such as re-enabling interrupts).
+	 */
+	if (!nbcon_can_proceed(wctxt)) {
+		do {
+			nbcon_reacquire_nobuf(wctxt);
+		} while (!nbcon_enter_unsafe(wctxt));
+	}
 
 	/*
 	 *	Finally, wait for transmitter to become empty
@@ -3485,11 +3571,18 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
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
@@ -3507,8 +3600,24 @@ static unsigned int probe_baud(struct uart_port *port)
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
@@ -3518,6 +3627,9 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
+	up->console_line_ended = true;
+	init_irq_work(&up->modem_status_work, modem_status_handler);
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else if (probe)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 144de7a7948d..57875c37023a 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -150,8 +150,17 @@ struct uart_8250_port {
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
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
+	struct irq_work		modem_status_work;
 
 	struct uart_8250_dma	*dma;
 	const struct uart_8250_ops *ops;
@@ -202,8 +211,8 @@ void serial8250_tx_chars(struct uart_8250_port *up);
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
2.45.2

