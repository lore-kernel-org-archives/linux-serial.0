Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2A15B107;
	Mon,  5 Aug 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853261; cv=none; b=KPf0UE0Dx6ZyQMrYSlSwaXOutYiY6hWFRa1AIR7cYxfvpKRp0ePeT7RsQQJIodLYkQXTpt5JdGkJ8giR4AE0F8VwEn0sbDBTogqOfUde5I6BMUqlBaMjPCqDls+CFIZGghuBFPzIebZ1TQzmhAXKoLs0rja9wK/tfsdeBjf8F9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853261; c=relaxed/simple;
	bh=/UDtlDDaO6xaKNk6bwmSQ1jG91hzPcY2kjgBsyxYblM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGEkpgxNm2qQRpdKgbFz2lke/7P57SjK/qb1+y1pBSP/WA+1hCvT8fHPQbn1QAHSRxfKE9x5cb2b5UIcN4VViASfMQG3FVN6XDUJfKdglnBfTVPuDa3lzXyzl8dG/IqH0q0R63z+b20Zl+ae2UoJT71zrDfBoNCUeo5rMjfXUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnvY6WmM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnvY6WmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD6EC4AF0D;
	Mon,  5 Aug 2024 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722853260;
	bh=/UDtlDDaO6xaKNk6bwmSQ1jG91hzPcY2kjgBsyxYblM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MnvY6WmM6Nm8+7yvH46ze/JLkbHzyJKPRaQVXXQQU74TyDSHHgnwV0VU7Au2micqj
	 Hhm5O/QAMHcoxyzNR8ncAcPRrFfo7chPtpG2d/X5zm6hztstT5gyTbD0cmA5BgqIep
	 OMOj26xmqAx8a6txvaU8W9Ie1QdbdC3rJ67xRLV7asbvLvQwl780wBp4Gyf1qCLjdm
	 5AR2h3Q77B+s9b+E+szvKciJd2SP/SqnR1hDoK7VdW5ttV2mbLVfzpvDv2M24VhpHE
	 kw5i1xWGi4tS/+tC8f6lwBkvD+XYWwZtpguHtW30SuZ0G4JCwgXl8ZqUMoPxhz/yDI
	 kXQCeCTIGoNFQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/13] serial: use guards for simple mutex locks
Date: Mon,  5 Aug 2024 12:20:38 +0200
Message-ID: <20240805102046.307511-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805102046.307511-1-jirislaby@kernel.org>
References: <20240805102046.307511-1-jirislaby@kernel.org>
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
 drivers/tty/serial/serial_core.c | 111 +++++++++++++------------------
 1 file changed, 46 insertions(+), 65 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d63e9b636e02..0e6c1e51da99 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1096,21 +1096,19 @@ static int uart_tiocmget(struct tty_struct *tty)
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
 
@@ -1120,20 +1118,16 @@ uart_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
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
@@ -1141,19 +1135,17 @@ static int uart_break_ctl(struct tty_struct *tty, int break_state)
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
@@ -1170,17 +1162,14 @@ static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
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
@@ -1201,14 +1190,15 @@ static int uart_do_autoconfig(struct tty_struct *tty, struct uart_state *state)
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
@@ -1703,10 +1693,11 @@ static void uart_set_termios(struct tty_struct *tty,
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
@@ -1729,9 +1720,8 @@ static void uart_set_termios(struct tty_struct *tty,
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
@@ -1748,8 +1738,6 @@ static void uart_set_termios(struct tty_struct *tty,
 			mask |= TIOCM_RTS;
 		uart_set_mctrl(uport, mask);
 	}
-out:
-	mutex_unlock(&state->port.mutex);
 }
 
 /*
@@ -2043,10 +2031,11 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
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
@@ -2058,7 +2047,7 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 
 	if (uport->type == PORT_UNKNOWN) {
 		seq_putc(m, '\n');
-		goto out;
+		return;
 	}
 
 	if (capable(CAP_SYS_ADMIN)) {
@@ -2109,8 +2098,6 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 	seq_putc(m, '\n');
 #undef STATBIT
 #undef INFOBIT
-out:
-	mutex_unlock(&port->mutex);
 }
 
 static int uart_proc_show(struct seq_file *m, void *v)
@@ -2387,13 +2374,12 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
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
@@ -2454,8 +2440,6 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		console_stop(uport->cons);
 
 	uart_change_pm(state, UART_PM_STATE_OFF);
-unlock:
-	mutex_unlock(&port->mutex);
 
 	return 0;
 }
@@ -2469,14 +2453,13 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
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
@@ -2549,8 +2532,6 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		tty_port_set_suspended(port, false);
 	}
 
-	mutex_unlock(&port->mutex);
-
 	return 0;
 }
 EXPORT_SYMBOL(uart_resume_port);
-- 
2.46.0

