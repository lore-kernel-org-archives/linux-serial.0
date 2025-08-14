Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89126B973;
	Thu, 14 Aug 2025 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156310; cv=none; b=A2Wis1xQyoIn/zOf4oJedsqx58qWmeJ3JulB/Zx8tfBaB4gotiG0DczPel97znJiqXxNrpVcYU98tqWu4mKB4Q1BTw8baGgWUiXjL1R9IjSd9pwalGExn8xJM3uPDSpEoU2ToV1VtT/z1tIGZ0TZeeiHwaVhZXlIT/2johGJKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156310; c=relaxed/simple;
	bh=jxmK01jIcUruME/7KPiUOrqBxkdlfWc2u7Wy+ABq91I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoHRLpwS3qYs0i1GckvkRHL8tv5t2buYhX16s+z4SvKFHk56dnvGDbSqWXpc3aZ6y9ksHDorvPAmo6JMptSBGseqdR4vmuw9737+/ZKxMg0BZSo0opZEb6LybGQAAE+8eOSOWsBMDdFI+OLPCj4mIPHyv/vUNkGalQH5w0OL9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5eYowzm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5eYowzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2CAC4CEEF;
	Thu, 14 Aug 2025 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156310;
	bh=jxmK01jIcUruME/7KPiUOrqBxkdlfWc2u7Wy+ABq91I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5eYowzm16qTjGq7vQw1+A7OJGRUdoQKBgo8Abj0E4btywSUthyjCU/qmZvzIsILV
	 KZqvkoiiRKMUprTAGLjLkvKi3A+ag86yoAo1wwrK+ZL0YO5NftvtZ/smAyM8Wk55DT
	 8H8bHwgu4LY0GefEVfyPi4loK2hbyAq2EcGNpkyYjC47Gq8iglhZ5cnbk2QPXbPj2y
	 RvPU+PMbR7aA8nuqUEPzwTT7X8GUfmctlZLmVATJ4qLOicZtXwL6N9zrCVCk6oYnPd
	 c1IEzOlYvN79J0pugFQCN3PqFcpeoAkei4i+qbhSz2+WSqTo471JjrSPaL/kaw9wwm
	 oZpjulxZBXRsA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/16] mxser: use guard()s
Date: Thu, 14 Aug 2025 09:24:47 +0200
Message-ID: <20250814072456.182853-8-jirislaby@kernel.org>
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

Having all the new guards, use them in the mxser code. This improves
readability, makes error handling easier, and marks locked portions of
code explicit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/mxser.c | 197 +++++++++++++++++---------------------------
 1 file changed, 74 insertions(+), 123 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index b070ebf9f51a..94677fec685e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -442,11 +442,8 @@ static void __mxser_start_tx(struct mxser_port *info)
 
 static void mxser_start_tx(struct mxser_port *info)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&info->slock, flags);
+	guard(spinlock_irqsave)(&info->slock);
 	__mxser_start_tx(info);
-	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static void __mxser_stop_tx(struct mxser_port *info)
@@ -465,17 +462,15 @@ static bool mxser_carrier_raised(struct tty_port *port)
 static void mxser_dtr_rts(struct tty_port *port, bool active)
 {
 	struct mxser_port *mp = container_of(port, struct mxser_port, port);
-	unsigned long flags;
 	u8 mcr;
 
-	spin_lock_irqsave(&mp->slock, flags);
+	guard(spinlock_irqsave)(&mp->slock);
 	mcr = inb(mp->ioaddr + UART_MCR);
 	if (active)
 		mcr |= UART_MCR_DTR | UART_MCR_RTS;
 	else
 		mcr &= ~(UART_MCR_DTR | UART_MCR_RTS);
 	outb(mcr, mp->ioaddr + UART_MCR);
-	spin_unlock_irqrestore(&mp->slock, flags);
 }
 
 static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
@@ -828,32 +823,28 @@ static void mxser_stop_rx(struct mxser_port *info)
 static void mxser_shutdown_port(struct tty_port *port)
 {
 	struct mxser_port *info = container_of(port, struct mxser_port, port);
-	unsigned long flags;
 
-	spin_lock_irqsave(&info->slock, flags);
-
-	mxser_stop_rx(info);
-
-	/*
-	 * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
-	 * here so the queue might never be waken up
-	 */
-	wake_up_interruptible(&info->port.delta_msr_wait);
+	scoped_guard(spinlock_irqsave, &info->slock) {
+		mxser_stop_rx(info);
 
-	info->IER = 0;
-	outb(0x00, info->ioaddr + UART_IER);
-
-	/* clear Rx/Tx FIFO's */
-	mxser_disable_and_clear_FIFO(info);
+		/*
+		 * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
+		 * here so the queue might never be waken up
+		 */
+		wake_up_interruptible(&info->port.delta_msr_wait);
 
-	/* read data port to reset things */
-	(void) inb(info->ioaddr + UART_RX);
+		info->IER = 0;
+		outb(0x00, info->ioaddr + UART_IER);
 
+		/* clear Rx/Tx FIFO's */
+		mxser_disable_and_clear_FIFO(info);
 
-	if (info->board->must_hwid)
-		mxser_must_no_sw_flow_control(info->ioaddr);
+		/* read data port to reset things */
+		(void)inb(info->ioaddr + UART_RX);
 
-	spin_unlock_irqrestore(&info->slock, flags);
+		if (info->board->must_hwid)
+			mxser_must_no_sw_flow_control(info->ioaddr);
+	}
 
 	/* make sure ISR is not running while we free the buffer */
 	synchronize_irq(info->board->irq);
@@ -880,15 +871,13 @@ static int mxser_open(struct tty_struct *tty, struct file *filp)
 static void mxser_flush_buffer(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&info->slock, flags);
-	kfifo_reset(&info->port.xmit_fifo);
+	scoped_guard(spinlock_irqsave, &info->slock) {
+		kfifo_reset(&info->port.xmit_fifo);
 
-	outb(info->FCR | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
-		info->ioaddr + UART_FCR);
-
-	spin_unlock_irqrestore(&info->slock, flags);
+		outb(info->FCR | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+		     info->ioaddr + UART_FCR);
+	}
 
 	tty_wakeup(tty);
 }
@@ -901,14 +890,13 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 static ssize_t mxser_write(struct tty_struct *tty, const u8 *buf, size_t count)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
 	size_t written;
 	bool is_empty;
 
-	spin_lock_irqsave(&info->slock, flags);
-	written = kfifo_in(&info->port.xmit_fifo, buf, count);
-	is_empty = kfifo_is_empty(&info->port.xmit_fifo);
-	spin_unlock_irqrestore(&info->slock, flags);
+	scoped_guard(spinlock_irqsave, &info->slock) {
+		written = kfifo_in(&info->port.xmit_fifo, buf, count);
+		is_empty = kfifo_is_empty(&info->port.xmit_fifo);
+	}
 
 	if (!is_empty && !tty->flow.stopped)
 		if (!tty->hw_stopped || mxser_16550A_or_MUST(info))
@@ -920,14 +908,9 @@ static ssize_t mxser_write(struct tty_struct *tty, const u8 *buf, size_t count)
 static int mxser_put_char(struct tty_struct *tty, u8 ch)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&info->slock, flags);
-	ret = kfifo_put(&info->port.xmit_fifo, ch);
-	spin_unlock_irqrestore(&info->slock, flags);
 
-	return ret;
+	guard(spinlock_irqsave)(&info->slock);
+	return kfifo_put(&info->port.xmit_fifo, ch);
 }
 
 
@@ -968,7 +951,7 @@ static int mxser_get_serial_info(struct tty_struct *tty,
 	struct tty_port *port = &info->port;
 	unsigned int closing_wait, close_delay;
 
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
 
 	close_delay = jiffies_to_msecs(info->port.close_delay) / 10;
 	closing_wait = info->port.closing_wait;
@@ -984,7 +967,7 @@ static int mxser_get_serial_info(struct tty_struct *tty,
 	ss->close_delay = close_delay;
 	ss->closing_wait = closing_wait;
 	ss->custom_divisor = MXSER_CUSTOM_DIVISOR;
-	mutex_unlock(&port->mutex);
+
 	return 0;
 }
 
@@ -994,20 +977,15 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 	struct mxser_port *info = tty->driver_data;
 	struct tty_port *port = &info->port;
 	speed_t baud;
-	unsigned long sl_flags;
 	unsigned int old_speed, close_delay, closing_wait;
-	int retval = 0;
 
 	if (tty_io_error(tty))
 		return -EIO;
 
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
 
-	if (ss->irq != info->board->irq ||
-			ss->port != info->ioaddr) {
-		mutex_unlock(&port->mutex);
+	if (ss->irq != info->board->irq || ss->port != info->ioaddr)
 		return -EINVAL;
-	}
 
 	old_speed = port->flags & ASYNC_SPD_MASK;
 
@@ -1020,10 +998,9 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 		if ((ss->baud_base != MXSER_BAUD_BASE) ||
 				(close_delay != port->close_delay) ||
 				(closing_wait != port->closing_wait) ||
-				((ss->flags & ~ASYNC_USR_MASK) != (port->flags & ~ASYNC_USR_MASK))) {
-			mutex_unlock(&port->mutex);
+				((ss->flags & ~ASYNC_USR_MASK) != (port->flags & ~ASYNC_USR_MASK)))
 			return -EPERM;
-		}
+
 		port->flags = (port->flags & ~ASYNC_USR_MASK) |
 				(ss->flags & ASYNC_USR_MASK);
 	} else {
@@ -1039,10 +1016,9 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 				(ss->baud_base != MXSER_BAUD_BASE ||
 				ss->custom_divisor !=
 				MXSER_CUSTOM_DIVISOR)) {
-			if (ss->custom_divisor == 0) {
-				mutex_unlock(&port->mutex);
+			if (ss->custom_divisor == 0)
 				return -EINVAL;
-			}
+
 			baud = ss->baud_base / ss->custom_divisor;
 			tty_encode_baud_rate(tty, baud, baud);
 		}
@@ -1054,16 +1030,17 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 
 	if (tty_port_initialized(port)) {
 		if (old_speed != (port->flags & ASYNC_SPD_MASK)) {
-			spin_lock_irqsave(&info->slock, sl_flags);
+			guard(spinlock_irqsave)(&info->slock);
 			mxser_change_speed(tty, NULL);
-			spin_unlock_irqrestore(&info->slock, sl_flags);
 		}
-	} else {
-		retval = mxser_activate(port, tty);
-		if (retval == 0)
-			tty_port_set_initialized(port, true);
+
+		return 0;
 	}
-	mutex_unlock(&port->mutex);
+
+	int retval = mxser_activate(port, tty);
+	if (retval == 0)
+		tty_port_set_initialized(port, true);
+
 	return retval;
 }
 
@@ -1080,13 +1057,11 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 static int mxser_get_lsr_info(struct mxser_port *info,
 		unsigned int __user *value)
 {
-	unsigned char status;
 	unsigned int result;
-	unsigned long flags;
+	u8 status;
 
-	spin_lock_irqsave(&info->slock, flags);
-	status = inb(info->ioaddr + UART_LSR);
-	spin_unlock_irqrestore(&info->slock, flags);
+	scoped_guard(spinlock_irqsave, &info->slock)
+		status = inb(info->ioaddr + UART_LSR);
 	result = ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
 	return put_user(result, value);
 }
@@ -1095,16 +1070,15 @@ static int mxser_tiocmget(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned char control;
-	unsigned long flags;
 	u8 msr;
 
 	if (tty_io_error(tty))
 		return -EIO;
 
-	spin_lock_irqsave(&info->slock, flags);
-	control = info->MCR;
-	msr = mxser_check_modem_status(tty, info);
-	spin_unlock_irqrestore(&info->slock, flags);
+	scoped_guard(spinlock_irqsave, &info->slock) {
+		control = info->MCR;
+		msr = mxser_check_modem_status(tty, info);
+	}
 
 	return ((control & UART_MCR_RTS) ? TIOCM_RTS : 0) |
 		    ((control & UART_MCR_DTR) ? TIOCM_DTR : 0) |
@@ -1118,12 +1092,11 @@ static int mxser_tiocmset(struct tty_struct *tty,
 		unsigned int set, unsigned int clear)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
 
 	if (tty_io_error(tty))
 		return -EIO;
 
-	spin_lock_irqsave(&info->slock, flags);
+	guard(spinlock_irqsave)(&info->slock);
 
 	if (set & TIOCM_RTS)
 		info->MCR |= UART_MCR_RTS;
@@ -1136,7 +1109,7 @@ static int mxser_tiocmset(struct tty_struct *tty,
 		info->MCR &= ~UART_MCR_DTR;
 
 	outb(info->MCR, info->ioaddr + UART_MCR);
-	spin_unlock_irqrestore(&info->slock, flags);
+
 	return 0;
 }
 
@@ -1144,12 +1117,11 @@ static int mxser_cflags_changed(struct mxser_port *info, unsigned long arg,
 		struct async_icount *cprev)
 {
 	struct async_icount cnow;
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&info->slock, flags);
-	cnow = info->icount;	/* atomic copy */
-	spin_unlock_irqrestore(&info->slock, flags);
+	/* atomic copy */
+	scoped_guard(spinlock_irqsave, &info->slock)
+		cnow = info->icount;
 
 	ret =	((arg & TIOCM_RNG) && (cnow.rng != cprev->rng)) ||
 		((arg & TIOCM_DSR) && (cnow.dsr != cprev->dsr)) ||
@@ -1179,19 +1151,17 @@ static int mxser_ioctl_op_mode(struct mxser_port *port, int index, bool set,
 		if (opmode & ~OP_MODE_MASK)
 			return -EINVAL;
 
-		spin_lock_irq(&port->slock);
+		guard(spinlock_irq)(&port->slock);
 		val = inb(port->opmode_ioaddr);
 		val &= ~(OP_MODE_MASK << shiftbit);
 		val |= (opmode << shiftbit);
 		outb(val, port->opmode_ioaddr);
-		spin_unlock_irq(&port->slock);
 
 		return 0;
 	}
 
-	spin_lock_irq(&port->slock);
-	opmode = inb(port->opmode_ioaddr) >> shiftbit;
-	spin_unlock_irq(&port->slock);
+	scoped_guard(spinlock_irq, &port->slock)
+		opmode = inb(port->opmode_ioaddr) >> shiftbit;
 
 	return put_user(opmode & OP_MODE_MASK, u_opmode);
 }
@@ -1201,7 +1171,6 @@ static int mxser_ioctl(struct tty_struct *tty,
 {
 	struct mxser_port *info = tty->driver_data;
 	struct async_icount cnow;
-	unsigned long flags;
 	void __user *argp = (void __user *)arg;
 
 	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE)
@@ -1221,9 +1190,9 @@ static int mxser_ioctl(struct tty_struct *tty,
 		 * Caller should use TIOCGICOUNT to see which one it was
 		 */
 	case TIOCMIWAIT:
-		spin_lock_irqsave(&info->slock, flags);
-		cnow = info->icount;	/* note the counters on entry */
-		spin_unlock_irqrestore(&info->slock, flags);
+		/* note the counters on entry */
+		scoped_guard(spinlock_irqsave, &info->slock)
+			cnow = info->icount;
 
 		return wait_event_interruptible(info->port.delta_msr_wait,
 				mxser_cflags_changed(info, arg, &cnow));
@@ -1246,11 +1215,9 @@ static int mxser_get_icount(struct tty_struct *tty,
 {
 	struct mxser_port *info = tty->driver_data;
 	struct async_icount cnow;
-	unsigned long flags;
 
-	spin_lock_irqsave(&info->slock, flags);
-	cnow = info->icount;
-	spin_unlock_irqrestore(&info->slock, flags);
+	scoped_guard(spinlock_irqsave, &info->slock)
+		cnow = info->icount;
 
 	icount->frame = cnow.frame;
 	icount->brk = cnow.brk;
@@ -1328,34 +1295,28 @@ static void mxser_unthrottle(struct tty_struct *tty)
 static void mxser_stop(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&info->slock, flags);
+	guard(spinlock_irqsave)(&info->slock);
 	if (info->IER & UART_IER_THRI)
 		__mxser_stop_tx(info);
-	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static void mxser_start(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&info->slock, flags);
+	guard(spinlock_irqsave)(&info->slock);
 	if (!kfifo_is_empty(&info->port.xmit_fifo))
 		__mxser_start_tx(info);
-	spin_unlock_irqrestore(&info->slock, flags);
 }
 
 static void mxser_set_termios(struct tty_struct *tty,
 			      const struct ktermios *old_termios)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&info->slock, flags);
-	mxser_change_speed(tty, old_termios);
-	spin_unlock_irqrestore(&info->slock, flags);
+	scoped_guard(spinlock_irqsave, &info->slock)
+		mxser_change_speed(tty, old_termios);
 
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
 		tty->hw_stopped = false;
@@ -1367,9 +1328,8 @@ static void mxser_set_termios(struct tty_struct *tty,
 		tty->flow.stopped = 0;
 
 		if (info->board->must_hwid) {
-			spin_lock_irqsave(&info->slock, flags);
+			guard(spinlock_irqsave)(&info->slock);
 			mxser_must_set_rx_sw_flow_control(info->ioaddr, false);
-			spin_unlock_irqrestore(&info->slock, flags);
 		}
 
 		mxser_start(tty);
@@ -1378,14 +1338,8 @@ static void mxser_set_termios(struct tty_struct *tty,
 
 static bool mxser_tx_empty(struct mxser_port *info)
 {
-	unsigned long flags;
-	u8 lsr;
-
-	spin_lock_irqsave(&info->slock, flags);
-	lsr = inb(info->ioaddr + UART_LSR);
-	spin_unlock_irqrestore(&info->slock, flags);
-
-	return !(lsr & UART_LSR_TEMT);
+	guard(spinlock_irqsave)(&info->slock);
+	return !(inb(info->ioaddr + UART_LSR) & UART_LSR_TEMT);
 }
 
 /*
@@ -1459,17 +1413,15 @@ static void mxser_hangup(struct tty_struct *tty)
 static int mxser_rs_break(struct tty_struct *tty, int break_state)
 {
 	struct mxser_port *info = tty->driver_data;
-	unsigned long flags;
 	u8 lcr;
 
-	spin_lock_irqsave(&info->slock, flags);
+	guard(spinlock_irqsave)(&info->slock);
 	lcr = inb(info->ioaddr + UART_LCR);
 	if (break_state == -1)
 		lcr |= UART_LCR_SBC;
 	else
 		lcr &= ~UART_LCR_SBC;
 	outb(lcr, info->ioaddr + UART_LCR);
-	spin_unlock_irqrestore(&info->slock, flags);
 
 	return 0;
 }
@@ -1672,12 +1624,11 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
 			port = &brd->ports[i];
 
 			int_cnt = 0;
-			spin_lock(&port->slock);
+			guard(spinlock)(&port->slock);
 			do {
 				if (mxser_port_isr(port))
 					break;
 			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
-			spin_unlock(&port->slock);
 		}
 	}
 
-- 
2.50.1

