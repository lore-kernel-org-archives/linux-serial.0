Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF818B467;
	Thu,  8 Aug 2024 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113356; cv=none; b=Xwvam2sx2Qmr+TfLllue7WlC+m5Wo9sPqizBPRuM2dpkLFwHkCJ3lJw6RoNHmLV+Z3Q8FVtyEiaFc/gr8IsNti2kSajE1CxHaAukkyqaZbgZYEqKisNh4TQeBVDGLLR8o4wem495yrkVp3rGxOiLFrk6n3lbkZAaJYjoAFu5JD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113356; c=relaxed/simple;
	bh=RXcV0a+kBZVxm5D+WPYM/cDAOg+s5oWBjdfF9Soc7As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRf/WKkKbg0vuY12OI/UgstRGMw+/2nn/YIphmjRWErTxgrgtOoExF9O2gmLyGhqDacCYJMuqNYdHlklUdKgi341rU3OxsQWDYQiWhgmEsrjVwa21bLwu2RjG3RbHGvUFkqrN2Vy+9E+RO3nCjbPehU8u+CVpdNoh8rJZmaf60c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNOfla1L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNOfla1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57100C4AF0E;
	Thu,  8 Aug 2024 10:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723113356;
	bh=RXcV0a+kBZVxm5D+WPYM/cDAOg+s5oWBjdfF9Soc7As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNOfla1L+iXl5mb/RH8wJSedeN79N18cRBmfbZ7l5q/5OCh99u8Tdu+RJ+0C24SL2
	 ISM8ZzpGF9HB2ElHKCYdLKZJxRcFWI616WdNpcnem7YghffTu24V1Mam/T3AervDrG
	 hz4ZQT0qbOnApVjvMllLr3p8W10hTGSRK6MJfizRPRfMh5kQhGLz8vXL6sGO11H58T
	 tb0mKyI2Y4TQ2Iw11Mxp7rBMMbpTCrgosOpejI9cnXs+ONv/IGjVhf4QRyLd2kh+Dh
	 gr8C82/cfrIlC5iUQ1YmeEFwGzRYU3zcqHhwkAxI1Z1ehA9M/Gn9pyyh80q5ipeHZE
	 FDLugDUsFLqCw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 01/11] serial: use guards for simple mutex locks
Date: Thu,  8 Aug 2024 12:35:37 +0200
Message-ID: <20240808103549.429349-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808103549.429349-1-jirislaby@kernel.org>
References: <20240808103549.429349-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guards can help to make the code more readable. So use it wherever they
do so.

On many places labels and 'ret' locals are eliminated completely.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

---
[v2] change also the third goto in uart_suspend_port().
     How could this only slip through?
---
 drivers/tty/serial/serial_core.c | 113 +++++++++++++------------------
 1 file changed, 47 insertions(+), 66 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 61fbc730c01b..d94d73e45fb6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1104,21 +1104,19 @@ static int uart_tiocmget(struct tty_struct *tty)
 	struct uart_state *state = tty->driver_data;
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
-	int result = -EIO;
+	int result;
+
+	guard(mutex)(&port->mutex);
 
-	mutex_lock(&port->mutex);
 	uport = uart_port_check(state);
-	if (!uport)
-		goto out;
+	if (!uport || tty_io_error(tty))
+		return -EIO;
+
+	uart_port_lock_irq(uport);
+	result = uport->mctrl;
+	result |= uport->ops->get_mctrl(uport);
+	uart_port_unlock_irq(uport);
 
-	if (!tty_io_error(tty)) {
-		uart_port_lock_irq(uport);
-		result = uport->mctrl;
-		result |= uport->ops->get_mctrl(uport);
-		uart_port_unlock_irq(uport);
-	}
-out:
-	mutex_unlock(&port->mutex);
 	return result;
 }
 
@@ -1128,20 +1126,16 @@ uart_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
 	struct uart_state *state = tty->driver_data;
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
-	int ret = -EIO;
 
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
+
 	uport = uart_port_check(state);
-	if (!uport)
-		goto out;
+	if (!uport || tty_io_error(tty))
+		return -EIO;
 
-	if (!tty_io_error(tty)) {
-		uart_update_mctrl(uport, set, clear);
-		ret = 0;
-	}
-out:
-	mutex_unlock(&port->mutex);
-	return ret;
+	uart_update_mctrl(uport, set, clear);
+
+	return 0;
 }
 
 static int uart_break_ctl(struct tty_struct *tty, int break_state)
@@ -1149,19 +1143,17 @@ static int uart_break_ctl(struct tty_struct *tty, int break_state)
 	struct uart_state *state = tty->driver_data;
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
-	int ret = -EIO;
 
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
+
 	uport = uart_port_check(state);
 	if (!uport)
-		goto out;
+		return -EIO;
 
 	if (uport->type != PORT_UNKNOWN && uport->ops->break_ctl)
 		uport->ops->break_ctl(uport, break_state);
-	ret = 0;
-out:
-	mutex_unlock(&port->mutex);
-	return ret;
+
+	return 0;
 }
 
 static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
@@ -1178,17 +1170,14 @@ static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
 	 * changing, and hence any extra opens of the port while
 	 * we're auto-configuring.
 	 */
-	if (mutex_lock_interruptible(&port->mutex))
-		return -ERESTARTSYS;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->mutex) {
+		uport = uart_port_check(state);
+		if (!uport)
+			return -EIO;
 
-	uport = uart_port_check(state);
-	if (!uport) {
-		ret = -EIO;
-		goto out;
-	}
+		if (tty_port_users(port) != 1)
+			return -EBUSY;
 
-	ret = -EBUSY;
-	if (tty_port_users(port) == 1) {
 		uart_shutdown(tty, state);
 
 		/*
@@ -1209,14 +1198,15 @@ static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
 		uport->ops->config_port(uport, flags);
 
 		ret = uart_startup(tty, state, true);
-		if (ret == 0)
-			tty_port_set_initialized(port, true);
+		if (ret < 0)
+			return ret;
 		if (ret > 0)
-			ret = 0;
+			return 0;
+
+		tty_port_set_initialized(port, true);
 	}
-out:
-	mutex_unlock(&port->mutex);
-	return ret;
+
+	return 0;
 }
 
 static void uart_enable_ms(struct uart_port *uport)
@@ -1711,10 +1701,11 @@ static void uart_set_termios(struct tty_struct *tty,
 	unsigned int iflag_mask = IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK;
 	bool sw_changed = false;
 
-	mutex_lock(&state->port.mutex);
+	guard(mutex)(&state->port.mutex);
+
 	uport = uart_port_check(state);
 	if (!uport)
-		goto out;
+		return;
 
 	/*
 	 * Drivers doing software flow control also need to know
@@ -1737,9 +1728,8 @@ static void uart_set_termios(struct tty_struct *tty,
 	    tty->termios.c_ospeed == old_termios->c_ospeed &&
 	    tty->termios.c_ispeed == old_termios->c_ispeed &&
 	    ((tty->termios.c_iflag ^ old_termios->c_iflag) & iflag_mask) == 0 &&
-	    !sw_changed) {
-		goto out;
-	}
+	    !sw_changed)
+		return;
 
 	uart_change_line_settings(tty, state, old_termios);
 	/* reload cflag from termios; port driver may have overridden flags */
@@ -1756,8 +1746,6 @@ static void uart_set_termios(struct tty_struct *tty,
 			mask |= TIOCM_RTS;
 		uart_set_mctrl(uport, mask);
 	}
-out:
-	mutex_unlock(&state->port.mutex);
 }
 
 /*
@@ -2051,10 +2039,11 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 	unsigned int status;
 	int mmio;
 
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
+
 	uport = uart_port_check(state);
 	if (!uport)
-		goto out;
+		return;
 
 	mmio = uport->iotype >= UPIO_MEM;
 	seq_printf(m, "%d: uart:%s %s%08llX irq:%d",
@@ -2066,7 +2055,7 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 
 	if (uport->type == PORT_UNKNOWN) {
 		seq_putc(m, '\n');
-		goto out;
+		return;
 	}
 
 	if (capable(CAP_SYS_ADMIN)) {
@@ -2117,8 +2106,6 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 	seq_putc(m, '\n');
 #undef STATBIT
 #undef INFOBIT
-out:
-	mutex_unlock(&port->mutex);
 }
 
 static int uart_proc_show(struct seq_file *m, void *v)
@@ -2395,13 +2382,12 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	struct device *tty_dev;
 	struct uart_match match = {uport, drv};
 
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
 
 	tty_dev = device_find_child(&uport->port_dev->dev, &match, serial_match_port);
 	if (tty_dev && device_may_wakeup(tty_dev)) {
 		enable_irq_wake(uport->irq);
 		put_device(tty_dev);
-		mutex_unlock(&port->mutex);
 		return 0;
 	}
 	put_device(tty_dev);
@@ -2419,7 +2405,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 			uart_port_unlock_irq(uport);
 		}
 		device_set_awake_path(uport->dev);
-		goto unlock;
+		return 0;
 	}
 
 	uport->suspended = 1;
@@ -2462,8 +2448,6 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		console_stop(uport->cons);
 
 	uart_change_pm(state, UART_PM_STATE_OFF);
-unlock:
-	mutex_unlock(&port->mutex);
 
 	return 0;
 }
@@ -2477,14 +2461,13 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 	struct uart_match match = {uport, drv};
 	struct ktermios termios;
 
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
 
 	tty_dev = device_find_child(&uport->port_dev->dev, &match, serial_match_port);
 	if (!uport->suspended && device_may_wakeup(tty_dev)) {
 		if (irqd_is_wakeup_set(irq_get_irq_data((uport->irq))))
 			disable_irq_wake(uport->irq);
 		put_device(tty_dev);
-		mutex_unlock(&port->mutex);
 		return 0;
 	}
 	put_device(tty_dev);
@@ -2557,8 +2540,6 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		tty_port_set_suspended(port, false);
 	}
 
-	mutex_unlock(&port->mutex);
-
 	return 0;
 }
 EXPORT_SYMBOL(uart_resume_port);
-- 
2.46.0

