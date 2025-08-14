Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0C025C816;
	Thu, 14 Aug 2025 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156313; cv=none; b=LqR711NeGDgLH7fxgXQc1ybhtHZfqHu2VH4D30Y/PTUChSDOibLjCxZfeizADHhdsN2k5IK6edjteBQEdsJ7h0Ax3nxWnP7JGVcXl9UHP3A0AaHEUkNE91JgeQP0+s6LiM1H/VNmRkt43ukT9WtXcpyn90HJH0bOr9S2JxyyKKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156313; c=relaxed/simple;
	bh=fyOGyC7zfV6Z+z3/Hk6dYdPg+04GhhtJLqJqFI6bF9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNl2Aqhm4UUZF6pAvbYKTyE/aR8eMYHSFzqO5rnPTnlxvnuVTlHge0YpKBDvxtdO5I/lxHzpG7tUDSH1U/9SeM3gCdy2wUhgj1zCf6rRhaNsQMRibFOFH9FsY7Uii4NdHHRiOJmQWTq6ClPLWusZoyyPumTBJa7M0Fo8QjbSqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tf37YlSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tf37YlSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C9AC4CEF4;
	Thu, 14 Aug 2025 07:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156313;
	bh=fyOGyC7zfV6Z+z3/Hk6dYdPg+04GhhtJLqJqFI6bF9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tf37YlSgdwmuVDAoElLqGZcnQ+i5sJaYPMBXgMruwG5l2NOoIdVGfos7e2d9Qn2Uo
	 Ft079lbZ3m5JhzEIWk2IUj1c9nL3daZpb+26krXSFVeGaJ6vB3C6d2MqobtHpNTJa7
	 hrYQOpknJ/10h7qDMOVg4sZtZVf5vEJl9uXHPzSeYk8+YpL6hfR6OiUkfxKlKsB96i
	 p57oPLZKdMl1orAAGE1dN2TfXDZOB2LarOXU78oSoRZATOOojX85IGjayVWfRyWV8T
	 /zr0mc6K8I5DdR8GttySU9Bcjn2vzgbzot661dak8zz9za+Dvc/cZlNKeMR4+s4FTM
	 89k3hyKn/3iWg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/16] serial: 8250: use guard()s
Date: Thu, 14 Aug 2025 09:24:49 +0200
Message-ID: <20250814072456.182853-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having all the new guards, use them in the 8250 code. This improves
readability, makes error handling easier, and marks locked portions of
code explicit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_core.c |  71 +++----
 drivers/tty/serial/8250/8250_port.c | 292 +++++++++++-----------------
 2 files changed, 143 insertions(+), 220 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index feb920c5b2e8..82c3636451e5 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -72,7 +72,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 	struct list_head *l, *end = NULL;
 	int pass_counter = 0, handled = 0;
 
-	spin_lock(&i->lock);
+	guard(spinlock)(&i->lock);
 
 	l = i->head;
 	do {
@@ -91,8 +91,6 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 			break;
 	} while (l != end);
 
-	spin_unlock(&i->lock);
-
 	return IRQ_RETVAL(handled);
 }
 
@@ -132,22 +130,19 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 {
 	struct irq_info *i;
 
-	mutex_lock(&hash_mutex);
+	guard(mutex)(&hash_mutex);
 
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
-			goto unlock;
+			return i;
 
 	i = kzalloc(sizeof(*i), GFP_KERNEL);
-	if (i == NULL) {
-		i = ERR_PTR(-ENOMEM);
-		goto unlock;
-	}
+	if (i == NULL)
+		return ERR_PTR(-ENOMEM);
+
 	spin_lock_init(&i->lock);
 	i->irq = up->port.irq;
 	hash_add(irq_lists, &i->node, i->irq);
-unlock:
-	mutex_unlock(&hash_mutex);
 
 	return i;
 }
@@ -161,23 +156,21 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 	if (IS_ERR(i))
 		return PTR_ERR(i);
 
-	spin_lock_irq(&i->lock);
+	scoped_guard(spinlock_irq, &i->lock) {
+		if (i->head) {
+			list_add(&up->list, i->head);
 
-	if (i->head) {
-		list_add(&up->list, i->head);
-		spin_unlock_irq(&i->lock);
+			return 0;
+		}
 
-		ret = 0;
-	} else {
 		INIT_LIST_HEAD(&up->list);
 		i->head = &up->list;
-		spin_unlock_irq(&i->lock);
-		ret = request_irq(up->port.irq, serial8250_interrupt,
-				  up->port.irqflags, up->port.name, i);
-		if (ret < 0)
-			serial_do_unlink(i, up);
 	}
 
+	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, up->port.name, i);
+	if (ret < 0)
+		serial_do_unlink(i, up);
+
 	return ret;
 }
 
@@ -670,16 +663,12 @@ static struct uart_8250_port *serial8250_find_match_or_unused(const struct uart_
 
 static void serial_8250_overrun_backoff_work(struct work_struct *work)
 {
-	struct uart_8250_port *up =
-	    container_of(to_delayed_work(work), struct uart_8250_port,
-			 overrun_backoff);
-	struct uart_port *port = &up->port;
-	unsigned long flags;
+	struct uart_8250_port *up = container_of(to_delayed_work(work), struct uart_8250_port,
+						 overrun_backoff);
 
-	uart_port_lock_irqsave(port, &flags);
+	guard(uart_port_lock_irqsave)(&up->port);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 /**
@@ -698,12 +687,12 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 int serial8250_register_8250_port(const struct uart_8250_port *up)
 {
 	struct uart_8250_port *uart;
-	int ret = -ENOSPC;
+	int ret;
 
 	if (up->port.uartclk == 0)
 		return -EINVAL;
 
-	mutex_lock(&serial_mutex);
+	guard(mutex)(&serial_mutex);
 
 	uart = serial8250_find_match_or_unused(&up->port);
 	if (!uart) {
@@ -713,15 +702,13 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		 */
 		uart = serial8250_setup_port(nr_uarts);
 		if (!uart)
-			goto unlock;
+			return -ENOSPC;
 		nr_uarts++;
 	}
 
 	/* Check if it is CIR already. We check this below again, see there why. */
-	if (uart->port.type == PORT_8250_CIR) {
-		ret = -ENODEV;
-		goto unlock;
-	}
+	if (uart->port.type == PORT_8250_CIR)
+		return -ENODEV;
 
 	if (uart->port.dev)
 		uart_remove_one_port(&serial8250_reg, &uart->port);
@@ -855,14 +842,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->overrun_backoff_time_ms = 0;
 	}
 
-unlock:
-	mutex_unlock(&serial_mutex);
-
 	return ret;
 
 err:
 	uart->port.dev = NULL;
-	mutex_unlock(&serial_mutex);
 	return ret;
 }
 EXPORT_SYMBOL(serial8250_register_8250_port);
@@ -878,14 +861,11 @@ void serial8250_unregister_port(int line)
 {
 	struct uart_8250_port *uart = &serial8250_ports[line];
 
-	mutex_lock(&serial_mutex);
+	guard(mutex)(&serial_mutex);
 
 	if (uart->em485) {
-		unsigned long flags;
-
-		uart_port_lock_irqsave(&uart->port, &flags);
+		guard(uart_port_lock_irqsave)(&uart->port);
 		serial8250_em485_destroy(uart);
-		uart_port_unlock_irqrestore(&uart->port, flags);
 	}
 
 	uart_remove_one_port(&serial8250_reg, &uart->port);
@@ -901,7 +881,6 @@ void serial8250_unregister_port(int line)
 	} else {
 		uart->port.dev = NULL;
 	}
-	mutex_unlock(&serial_mutex);
 }
 EXPORT_SYMBOL(serial8250_unregister_port);
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5afae4025696..719faf92aa8a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -674,28 +674,27 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 {
 	unsigned char lcr = 0, efr = 0;
 
-	serial8250_rpm_get(p);
-
-	if (p->capabilities & UART_CAP_SLEEP) {
-		/* Synchronize UART_IER access against the console. */
-		uart_port_lock_irq(&p->port);
-		if (p->capabilities & UART_CAP_EFR) {
-			lcr = serial_in(p, UART_LCR);
-			efr = serial_in(p, UART_EFR);
-			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
-			serial_out(p, UART_EFR, UART_EFR_ECB);
-			serial_out(p, UART_LCR, 0);
-		}
-		serial_out(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
-		if (p->capabilities & UART_CAP_EFR) {
-			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
-			serial_out(p, UART_EFR, efr);
-			serial_out(p, UART_LCR, lcr);
-		}
-		uart_port_unlock_irq(&p->port);
-	}
+	guard(serial8250_rpm)(p);
+
+	if (!(p->capabilities & UART_CAP_SLEEP))
+		return;
+
+	/* Synchronize UART_IER access against the console. */
+	guard(uart_port_lock_irq)(&p->port);
 
-	serial8250_rpm_put(p);
+	if (p->capabilities & UART_CAP_EFR) {
+		lcr = serial_in(p, UART_LCR);
+		efr = serial_in(p, UART_EFR);
+		serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(p, UART_EFR, UART_EFR_ECB);
+		serial_out(p, UART_LCR, 0);
+	}
+	serial_out(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
+	if (p->capabilities & UART_CAP_EFR) {
+		serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(p, UART_EFR, efr);
+		serial_out(p, UART_LCR, lcr);
+	}
 }
 
 /* Clear the interrupt registers. */
@@ -1231,9 +1230,8 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	probe_irq_off(probe_irq_on());
 	save_mcr = serial8250_in_MCR(up);
 	/* Synchronize UART_IER access against the console. */
-	uart_port_lock_irq(port);
-	save_ier = serial_in(up, UART_IER);
-	uart_port_unlock_irq(port);
+	scoped_guard(uart_port_lock_irq, port)
+		save_ier = serial_in(up, UART_IER);
 	serial8250_out_MCR(up, UART_MCR_OUT1 | UART_MCR_OUT2);
 
 	irqs = probe_irq_on();
@@ -1246,9 +1244,8 @@ static void autoconfig_irq(struct uart_8250_port *up)
 			UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2);
 	}
 	/* Synchronize UART_IER access against the console. */
-	uart_port_lock_irq(port);
-	serial_out(up, UART_IER, UART_IER_ALL_INTR);
-	uart_port_unlock_irq(port);
+	scoped_guard(uart_port_lock_irq, port)
+		serial_out(up, UART_IER, UART_IER_ALL_INTR);
 	serial8250_clear_interrupts(port);
 	serial_out(up, UART_TX, 0xFF);
 	udelay(20);
@@ -1256,9 +1253,8 @@ static void autoconfig_irq(struct uart_8250_port *up)
 
 	serial8250_out_MCR(up, save_mcr);
 	/* Synchronize UART_IER access against the console. */
-	uart_port_lock_irq(port);
-	serial_out(up, UART_IER, save_ier);
-	uart_port_unlock_irq(port);
+	scoped_guard(uart_port_lock_irq, port)
+		serial_out(up, UART_IER, save_ier);
 
 	if (port->flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
@@ -1273,12 +1269,10 @@ static void serial8250_stop_rx(struct uart_port *port)
 	/* Port locked to synchronize UART_IER access against the console. */
 	lockdep_assert_held_once(&port->lock);
 
-	serial8250_rpm_get(up);
+	guard(serial8250_rpm)(up);
 
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	serial_port_out(port, UART_IER, up->ier);
-
-	serial8250_rpm_put(up);
 }
 
 /**
@@ -1322,17 +1316,15 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	struct uart_8250_em485 *em485 = container_of(t, struct uart_8250_em485,
 			stop_tx_timer);
 	struct uart_8250_port *p = em485->port;
-	unsigned long flags;
 
-	serial8250_rpm_get(p);
-	uart_port_lock_irqsave(&p->port, &flags);
+	guard(serial8250_rpm)(p);
+	guard(uart_port_lock_irqsave)(&p->port);
+
 	if (em485->active_timer == &em485->stop_tx_timer) {
 		p->rs485_stop_tx(p, true);
 		em485->active_timer = NULL;
 		em485->tx_stopped = true;
 	}
-	uart_port_unlock_irqrestore(&p->port, flags);
-	serial8250_rpm_put(p);
 
 	return HRTIMER_NORESTART;
 }
@@ -1407,7 +1399,7 @@ static void serial8250_stop_tx(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
-	serial8250_rpm_get(up);
+	guard(serial8250_rpm)(up);
 	__stop_tx(up);
 
 	/*
@@ -1417,7 +1409,6 @@ static void serial8250_stop_tx(struct uart_port *port)
 		up->acr |= UART_ACR_TXDIS;
 		serial_icr_write(up, UART_ACR, up->acr);
 	}
-	serial8250_rpm_put(up);
 }
 
 static inline void __start_tx(struct uart_port *port)
@@ -1512,14 +1503,13 @@ static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 	struct uart_8250_em485 *em485 = container_of(t, struct uart_8250_em485,
 			start_tx_timer);
 	struct uart_8250_port *p = em485->port;
-	unsigned long flags;
 
-	uart_port_lock_irqsave(&p->port, &flags);
+	guard(uart_port_lock_irqsave)(&p->port);
+
 	if (em485->active_timer == &em485->start_tx_timer) {
 		__start_tx(&p->port);
 		em485->active_timer = NULL;
 	}
-	uart_port_unlock_irqrestore(&p->port, flags);
 
 	return HRTIMER_NORESTART;
 }
@@ -1587,9 +1577,8 @@ static void serial8250_enable_ms(struct uart_port *port)
 
 	up->ier |= UART_IER_MSI;
 
-	serial8250_rpm_get(up);
+	guard(serial8250_rpm)(up);
 	serial_port_out(port, UART_IER, up->ier);
-	serial8250_rpm_put(up);
 }
 
 void serial8250_read_char(struct uart_8250_port *up, u16 lsr)
@@ -1850,15 +1839,11 @@ static int serial8250_default_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int iir;
-	int ret;
 
-	serial8250_rpm_get(up);
+	guard(serial8250_rpm)(up);
 
 	iir = serial_port_in(port, UART_IIR);
-	ret = serial8250_handle_irq(port, iir);
-
-	serial8250_rpm_put(up);
-	return ret;
+	return serial8250_handle_irq(port, iir);
 }
 
 /*
@@ -1869,16 +1854,14 @@ static int serial8250_default_handle_irq(struct uart_port *port)
  */
 static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 {
-	unsigned long flags;
 	unsigned int iir = serial_port_in(port, UART_IIR);
 
 	/* TX Threshold IRQ triggered so load up FIFO */
 	if ((iir & UART_IIR_ID) == UART_IIR_THRI) {
 		struct uart_8250_port *up = up_to_u8250p(port);
 
-		uart_port_lock_irqsave(port, &flags);
+		guard(uart_port_lock_irqsave)(port);
 		serial8250_tx_chars(up);
-		uart_port_unlock_irqrestore(port, flags);
 	}
 
 	iir = serial_port_in(port, UART_IIR);
@@ -1888,19 +1871,14 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned int result = 0;
-	unsigned long flags;
 
-	serial8250_rpm_get(up);
+	guard(serial8250_rpm)(up);
+	guard(uart_port_lock_irqsave)(port);
 
-	uart_port_lock_irqsave(port, &flags);
 	if (!serial8250_tx_dma_running(up) && uart_lsr_tx_empty(serial_lsr_in(up)))
-		result = TIOCSER_TEMT;
-	uart_port_unlock_irqrestore(port, flags);
-
-	serial8250_rpm_put(up);
+		return TIOCSER_TEMT;
 
-	return result;
+	return 0;
 }
 
 unsigned int serial8250_do_get_mctrl(struct uart_port *port)
@@ -1909,9 +1887,8 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
 	unsigned int status;
 	unsigned int val;
 
-	serial8250_rpm_get(up);
-	status = serial8250_modem_status(up);
-	serial8250_rpm_put(up);
+	scoped_guard(serial8250_rpm, up)
+		status = serial8250_modem_status(up);
 
 	val = serial8250_MSR_to_TIOCM(status);
 	if (up->gpios)
@@ -1955,17 +1932,15 @@ static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 static void serial8250_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned long flags;
 
-	serial8250_rpm_get(up);
-	uart_port_lock_irqsave(port, &flags);
+	guard(serial8250_rpm)(up);
+	guard(uart_port_lock_irqsave)(port);
+
 	if (break_state == -1)
 		up->lcr |= UART_LCR_SBC;
 	else
 		up->lcr &= ~UART_LCR_SBC;
 	serial_port_out(port, UART_LCR, up->lcr);
-	uart_port_unlock_irqrestore(port, flags);
-	serial8250_rpm_put(up);
 }
 
 /* Returns true if @bits were set, false on timeout */
@@ -2025,22 +2000,15 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 static int serial8250_get_poll_char(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	int status;
 	u16 lsr;
 
-	serial8250_rpm_get(up);
+	guard(serial8250_rpm)(up);
 
 	lsr = serial_port_in(port, UART_LSR);
+	if (!(lsr & UART_LSR_DR))
+		return NO_POLL_CHAR;
 
-	if (!(lsr & UART_LSR_DR)) {
-		status = NO_POLL_CHAR;
-		goto out;
-	}
-
-	status = serial_port_in(port, UART_RX);
-out:
-	serial8250_rpm_put(up);
-	return status;
+	return serial_port_in(port, UART_RX);
 }
 
 
@@ -2058,7 +2026,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	 * should allow safe lockless usage here.
 	 */
 
-	serial8250_rpm_get(up);
+	guard(serial8250_rpm)(up);
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
@@ -2077,7 +2045,6 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	 */
 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
 	serial_port_out(port, UART_IER, ier);
-	serial8250_rpm_put(up);
 }
 
 #endif /* CONFIG_CONSOLE_POLL */
@@ -2085,16 +2052,15 @@ static void serial8250_put_poll_char(struct uart_port *port,
 static void serial8250_startup_special(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned long flags;
 
 	switch (port->type) {
-	case PORT_16C950:
+	case PORT_16C950: {
 		/*
 		 * Wake up and initialize UART
 		 *
 		 * Synchronize UART_IER access against the console.
 		 */
-		uart_port_lock_irqsave(port, &flags);
+		guard(uart_port_lock_irqsave)(port);
 		up->acr = 0;
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
@@ -2104,18 +2070,18 @@ static void serial8250_startup_special(struct uart_port *port)
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
 		serial_port_out(port, UART_LCR, 0);
-		uart_port_unlock_irqrestore(port, flags);
 		break;
+	}
 	case PORT_DA830:
 		/*
 		 * Reset the port
 		 *
 		 * Synchronize UART_IER access against the console.
 		 */
-		uart_port_lock_irqsave(port, &flags);
-		serial_port_out(port, UART_IER, 0);
-		serial_port_out(port, UART_DA830_PWREMU_MGMT, 0);
-		uart_port_unlock_irqrestore(port, flags);
+		scoped_guard(uart_port_lock_irqsave, port) {
+			serial_port_out(port, UART_IER, 0);
+			serial_port_out(port, UART_DA830_PWREMU_MGMT, 0);
+		}
 		mdelay(10);
 
 		/* Enable Tx, Rx and free run mode */
@@ -2173,7 +2139,6 @@ static void serial8250_set_TRG_levels(struct uart_port *port)
 static void serial8250_THRE_test(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned long flags;
 	bool iir_noint1, iir_noint2;
 
 	if (!port->irq)
@@ -2193,19 +2158,17 @@ static void serial8250_THRE_test(struct uart_port *port)
 	 *
 	 * Synchronize UART_IER access against the console.
 	 */
-	uart_port_lock_irqsave(port, &flags);
-
-	wait_for_xmitr(up, UART_LSR_THRE);
-	serial_port_out_sync(port, UART_IER, UART_IER_THRI);
-	udelay(1); /* allow THRE to set */
-	iir_noint1 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
-	serial_port_out(port, UART_IER, 0);
-	serial_port_out_sync(port, UART_IER, UART_IER_THRI);
-	udelay(1); /* allow a working UART time to re-assert THRE */
-	iir_noint2 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
-	serial_port_out(port, UART_IER, 0);
-
-	uart_port_unlock_irqrestore(port, flags);
+	scoped_guard(uart_port_lock_irqsave, port) {
+		wait_for_xmitr(up, UART_LSR_THRE);
+		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
+		udelay(1); /* allow THRE to set */
+		iir_noint1 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
+		serial_port_out(port, UART_IER, 0);
+		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
+		udelay(1); /* allow a working UART time to re-assert THRE */
+		iir_noint2 = serial_port_in(port, UART_IIR) & UART_IIR_NO_INT;
+		serial_port_out(port, UART_IER, 0);
+	}
 
 	if (port->irqflags & IRQF_SHARED)
 		enable_irq(port->irq);
@@ -2269,14 +2232,11 @@ static void serial8250_iir_txen_test(struct uart_port *port)
 
 static void serial8250_initialize(struct uart_port *port)
 {
-	unsigned long flags;
-
-	uart_port_lock_irqsave(port, &flags);
+	guard(uart_port_lock_irqsave)(port);
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
 	serial8250_init_mctrl(port);
 	serial8250_iir_txen_test(port);
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 int serial8250_do_startup(struct uart_port *port)
@@ -2295,7 +2255,7 @@ int serial8250_do_startup(struct uart_port *port)
 	if (port->iotype != up->cur_iotype)
 		set_io_from_upio(port);
 
-	serial8250_rpm_get(up);
+	guard(serial8250_rpm)(up);
 
 	serial8250_startup_special(port);
 
@@ -2315,8 +2275,7 @@ int serial8250_do_startup(struct uart_port *port)
 	if (!(port->flags & UPF_BUGGY_UART) &&
 	    (serial_port_in(port, UART_LSR) == 0xff)) {
 		dev_info_ratelimited(port->dev, "LSR safety check engaged!\n");
-		retval = -ENODEV;
-		goto out;
+		return -ENODEV;
 	}
 
 	serial8250_set_TRG_levels(port);
@@ -2327,7 +2286,7 @@ int serial8250_do_startup(struct uart_port *port)
 
 	retval = up->ops->setup_irq(up);
 	if (retval)
-		goto out;
+		return retval;
 
 	serial8250_THRE_test(port);
 
@@ -2376,10 +2335,8 @@ int serial8250_do_startup(struct uart_port *port)
 		outb_p(0x80, icp);
 		inb_p(icp);
 	}
-	retval = 0;
-out:
-	serial8250_rpm_put(up);
-	return retval;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(serial8250_do_startup);
 
@@ -2393,7 +2350,6 @@ static int serial8250_startup(struct uart_port *port)
 void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned long flags;
 
 	serial8250_rpm_get(up);
 	/*
@@ -2401,26 +2357,26 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 *
 	 * Synchronize UART_IER access against the console.
 	 */
-	uart_port_lock_irqsave(port, &flags);
-	up->ier = 0;
-	serial_port_out(port, UART_IER, 0);
-	uart_port_unlock_irqrestore(port, flags);
+	scoped_guard(uart_port_lock_irqsave, port) {
+		up->ier = 0;
+		serial_port_out(port, UART_IER, 0);
+	}
 
 	synchronize_irq(port->irq);
 
 	if (up->dma)
 		serial8250_release_dma(up);
 
-	uart_port_lock_irqsave(port, &flags);
-	if (port->flags & UPF_FOURPORT) {
-		/* reset interrupts on the AST Fourport board */
-		inb((port->iobase & 0xfe0) | 0x1f);
-		port->mctrl |= TIOCM_OUT1;
-	} else
-		port->mctrl &= ~TIOCM_OUT2;
+	scoped_guard(uart_port_lock_irqsave, port) {
+		if (port->flags & UPF_FOURPORT) {
+			/* reset interrupts on the AST Fourport board */
+			inb((port->iobase & 0xfe0) | 0x1f);
+			port->mctrl |= TIOCM_OUT1;
+		} else
+			port->mctrl &= ~TIOCM_OUT2;
 
-	serial8250_set_mctrl(port, port->mctrl);
-	uart_port_unlock_irqrestore(port, flags);
+		serial8250_set_mctrl(port, port->mctrl);
+	}
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2612,33 +2568,27 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 {
 	struct tty_port *tport = &port->state->port;
-	struct tty_struct *tty;
 
-	tty = tty_port_tty_get(tport);
-	if (!tty) {
-		mutex_lock(&tport->mutex);
-		port->uartclk = uartclk;
-		mutex_unlock(&tport->mutex);
-		return;
-	}
+	scoped_guard(tty_port_tty, tport) {
+		struct tty_struct *tty = scoped_tty();
 
-	down_write(&tty->termios_rwsem);
-	mutex_lock(&tport->mutex);
+		guard(rwsem_write)(&tty->termios_rwsem);
+		guard(mutex)(&tport->mutex);
 
-	if (port->uartclk == uartclk)
-		goto out_unlock;
+		if (port->uartclk == uartclk)
+			return;
 
-	port->uartclk = uartclk;
+		port->uartclk = uartclk;
 
-	if (!tty_port_initialized(tport))
-		goto out_unlock;
+		if (!tty_port_initialized(tport))
+			return;
 
-	serial8250_do_set_termios(port, &tty->termios, NULL);
+		serial8250_do_set_termios(port, &tty->termios, NULL);
 
-out_unlock:
-	mutex_unlock(&tport->mutex);
-	up_write(&tty->termios_rwsem);
-	tty_kref_put(tty);
+		return;
+	}
+	guard(mutex)(&tport->mutex);
+	port->uartclk = uartclk;
 }
 EXPORT_SYMBOL_GPL(serial8250_update_uartclk);
 
@@ -2793,7 +2743,6 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		          const struct ktermios *old)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
-	unsigned long flags;
 	unsigned int baud, quot, frac = 0;
 	u8 lcr;
 
@@ -2803,27 +2752,24 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	quot = serial8250_get_divisor(port, baud, &frac);
 
 	/*
-	 * Ok, we're now changing the port state.  Do it with
-	 * interrupts disabled.
+	 * Ok, we're now changing the port state. Do it with interrupts disabled.
 	 *
 	 * Synchronize UART_IER access against the console.
 	 */
-	serial8250_rpm_get(up);
-	uart_port_lock_irqsave(port, &flags);
-
-	up->lcr = lcr;
-	serial8250_set_trigger_for_slow_speed(port, termios, baud);
-	serial8250_set_afe(port, termios);
-	uart_update_timeout(port, termios->c_cflag, baud);
-	serial8250_set_errors_and_ignores(port, termios);
-	serial8250_set_ier(port, termios);
-	serial8250_set_efr(port, termios);
-	serial8250_set_divisor(port, baud, quot, frac);
-	serial8250_set_fcr(port, termios);
-	serial8250_set_mctrl(port, port->mctrl);
+	scoped_guard(serial8250_rpm, up) {
+		guard(uart_port_lock_irqsave)(port);
 
-	uart_port_unlock_irqrestore(port, flags);
-	serial8250_rpm_put(up);
+		up->lcr = lcr;
+		serial8250_set_trigger_for_slow_speed(port, termios, baud);
+		serial8250_set_afe(port, termios);
+		uart_update_timeout(port, termios->c_cflag, baud);
+		serial8250_set_errors_and_ignores(port, termios);
+		serial8250_set_ier(port, termios);
+		serial8250_set_efr(port, termios);
+		serial8250_set_divisor(port, baud, quot, frac);
+		serial8250_set_fcr(port, termios);
+		serial8250_set_mctrl(port, port->mctrl);
+	}
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
@@ -2845,15 +2791,13 @@ void serial8250_do_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
-		uart_port_lock_irq(port);
+		guard(uart_port_lock_irq)(port);
 		serial8250_enable_ms(port);
-		uart_port_unlock_irq(port);
 	} else {
 		port->flags &= ~UPF_HARDPPS_CD;
 		if (!UART_ENABLE_MS(port, termios->c_cflag)) {
-			uart_port_lock_irq(port);
+			guard(uart_port_lock_irq)(port);
 			serial8250_disable_ms(port);
-			uart_port_unlock_irq(port);
 		}
 	}
 }
-- 
2.50.1

