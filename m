Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33D34CFAA;
	Wed, 19 Nov 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546525; cv=none; b=M0asOk9XPD9TpfXt/VKiNpJciGOcUNpw7vHmYiCEoKTFlLU5/exYGbuK/iw3/zIGqYvgrh8UJ9CE89getdDSEWtd0phzAOxzsJ9zFl/Jxf0su4/tlTNHgRsDzWkHECD/RoZgYrQL6ygf5TlpwZB8l4WEJt42iBreFR49aKGKaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546525; c=relaxed/simple;
	bh=VrVDOIkLdN0ta2xc+kiqN5B8z01haIwwQGKYQ9hiPW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deCNvJmFCkqr7tmwkaiDdC9JmhXpT0mRK9xb6awrJMAFg9auCjDXEOlYqKK6qQS/kb/4vKabevVq33AMBXb41Gth+bpiJyY/XetZyErfCtyr3e7yPkYhzB5Mwa/xi2C3LEKOj/tZd03HoJz/7blHiHNLLQxxat2pbvOXlETbKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnrqw5U/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnrqw5U/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5280C2BCC4;
	Wed, 19 Nov 2025 10:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546524;
	bh=VrVDOIkLdN0ta2xc+kiqN5B8z01haIwwQGKYQ9hiPW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lnrqw5U/4xXhRRM8nY1fpD+L8kncv6UqWKdeWiRdR8ja+JOPUyz9CO4IBwROOOEC8
	 aSNPO9B3OdzJshDhMgSMvdOc9hy/62zMaBSva84bav/1l/ixD/USZpfv9fJIxFa2oz
	 dtuDEcCTxBWcLY1YjNM+TPJ12jwgdiZ0n5POxeJtBYxjBfQKrn1jhnlhQdy4fzS5XR
	 b7R/s3iCKdueySS095ibUfygnFT5L5IgDz1+sPwY/e2niiqB6PDszjAeoJGYdLURWj
	 4inrWqO2vs7wyNcqP/ib/SQacvJ2mzHyroFxNuryJsULvio8x5s6TzNc5BKQaiULQh
	 wqlihFKEon6dg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/10] serial: serial_core: use guard()s
Date: Wed, 19 Nov 2025 11:01:40 +0100
Message-ID: <20251119100140.830761-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119100140.830761-1-jirislaby@kernel.org>
References: <20251119100140.830761-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guards in the serial_core code. This improves readability, makes
error handling easier, and marks locked portions of code explicit. All
that while being sure the lock is unlocked.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 127 +++++++++++++------------------
 1 file changed, 55 insertions(+), 72 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 74018fb8a4e7..c532235f8d55 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1034,9 +1034,8 @@ static int uart_set_info_user(struct tty_struct *tty, struct serial_struct *ss)
 {
 	struct uart_state *state = tty->driver_data;
 	struct tty_port *port = &state->port;
-	int retval;
 
-	down_write(&tty->termios_rwsem);
+	guard(rwsem_write)(&tty->termios_rwsem);
 	/*
 	 * This semaphore protects port->count.  It is also
 	 * very useful to prevent opens.  Also, take the
@@ -1044,11 +1043,8 @@ static int uart_set_info_user(struct tty_struct *tty, struct serial_struct *ss)
 	 * module insertion/removal doesn't change anything
 	 * under us.
 	 */
-	mutex_lock(&port->mutex);
-	retval = uart_set_info(tty, port, state, ss);
-	mutex_unlock(&port->mutex);
-	up_write(&tty->termios_rwsem);
-	return retval;
+	guard(mutex)(&port->mutex);
+	return uart_set_info(tty, port, state, ss);
 }
 
 /**
@@ -1562,10 +1558,8 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 
 	/* This ioctl doesn't rely on the hardware to be present. */
 	if (cmd == TIOCSERCONFIG) {
-		down_write(&tty->termios_rwsem);
-		ret = uart_do_autoconfig(tty, state);
-		up_write(&tty->termios_rwsem);
-		return ret;
+		guard(rwsem_write)(&tty->termios_rwsem);
+		return uart_do_autoconfig(tty, state);
 	}
 
 	if (tty_io_error(tty))
@@ -1579,46 +1573,46 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	if (cmd == TIOCSRS485)
 		down_write(&tty->termios_rwsem);
 
-	mutex_lock(&port->mutex);
-	uport = uart_port_check(state);
+	scoped_guard(mutex, &port->mutex) {
+		uport = uart_port_check(state);
 
-	if (!uport || tty_io_error(tty)) {
-		ret = -EIO;
-		goto out_up;
-	}
+		if (!uport || tty_io_error(tty)) {
+			ret = -EIO;
+			break;
+		}
 
-	/*
-	 * All these rely on hardware being present and need to be
-	 * protected against the tty being hung up.
-	 */
+		/*
+		 * All these rely on hardware being present and need to be
+		 * protected against the tty being hung up.
+		 */
 
-	switch (cmd) {
-	case TIOCSERGETLSR: /* Get line status register */
-		ret = uart_get_lsr_info(tty, state, uarg);
-		break;
+		switch (cmd) {
+		case TIOCSERGETLSR: /* Get line status register */
+			ret = uart_get_lsr_info(tty, state, uarg);
+			break;
 
-	case TIOCGRS485:
-		ret = uart_get_rs485_config(uport, uarg);
-		break;
+		case TIOCGRS485:
+			ret = uart_get_rs485_config(uport, uarg);
+			break;
 
-	case TIOCSRS485:
-		ret = uart_set_rs485_config(tty, uport, uarg);
-		break;
+		case TIOCSRS485:
+			ret = uart_set_rs485_config(tty, uport, uarg);
+			break;
 
-	case TIOCSISO7816:
-		ret = uart_set_iso7816_config(state->uart_port, uarg);
-		break;
+		case TIOCSISO7816:
+			ret = uart_set_iso7816_config(state->uart_port, uarg);
+			break;
 
-	case TIOCGISO7816:
-		ret = uart_get_iso7816_config(state->uart_port, uarg);
-		break;
-	default:
-		if (uport->ops->ioctl)
-			ret = uport->ops->ioctl(uport, cmd, arg);
-		break;
+		case TIOCGISO7816:
+			ret = uart_get_iso7816_config(state->uart_port, uarg);
+			break;
+		default:
+			if (uport->ops->ioctl)
+				ret = uport->ops->ioctl(uport, cmd, arg);
+			break;
+		}
 	}
-out_up:
-	mutex_unlock(&port->mutex);
+
 	if (cmd == TIOCSRS485)
 		up_write(&tty->termios_rwsem);
 
@@ -1634,11 +1628,10 @@ static void uart_set_ldisc(struct tty_struct *tty)
 	if (!tty_port_initialized(port))
 		return;
 
-	mutex_lock(&state->port.mutex);
+	guard(mutex)(&state->port.mutex);
 	uport = uart_port_check(state);
 	if (uport && uport->ops->set_ldisc)
 		uport->ops->set_ldisc(uport, &tty->termios);
-	mutex_unlock(&state->port.mutex);
 }
 
 static void uart_set_termios(struct tty_struct *tty,
@@ -1712,9 +1705,8 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 		state = drv->state + tty->index;
 		port = &state->port;
-		spin_lock_irq(&port->lock);
+		guard(spinlock_irq)(&port->lock);
 		--port->count;
-		spin_unlock_irq(&port->lock);
 		return;
 	}
 
@@ -1826,20 +1818,18 @@ static void uart_hangup(struct tty_struct *tty)
 	struct uart_state *state = tty->driver_data;
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
-	unsigned long flags;
 
 	pr_debug("uart_hangup(%d)\n", tty->index);
 
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
 	uport = uart_port_check(state);
 	WARN(!uport, "hangup of detached port!\n");
 
 	if (tty_port_active(port)) {
 		uart_flush_buffer(tty);
 		uart_shutdown(tty, state);
-		spin_lock_irqsave(&port->lock, flags);
-		port->count = 0;
-		spin_unlock_irqrestore(&port->lock, flags);
+		scoped_guard(spinlock_irqsave, &port->lock)
+			port->count = 0;
 		tty_port_set_active(port, false);
 		tty_port_tty_set(port, NULL);
 		if (uport && !uart_console(uport))
@@ -1847,7 +1837,6 @@ static void uart_hangup(struct tty_struct *tty)
 		wake_up_interruptible(&port->open_wait);
 		wake_up_interruptible(&port->delta_msr_wait);
 	}
-	mutex_unlock(&port->mutex);
 }
 
 /* uport == NULL if uart_port has already been removed */
@@ -2952,11 +2941,11 @@ static ssize_t console_show(struct device *dev,
 	struct uart_port *uport;
 	bool console = false;
 
-	mutex_lock(&port->mutex);
-	uport = uart_port_check(state);
-	if (uport)
-		console = uart_console_registered(uport);
-	mutex_unlock(&port->mutex);
+	scoped_guard(mutex, &port->mutex) {
+		uport = uart_port_check(state);
+		if (uport)
+			console = uart_console_registered(uport);
+	}
 
 	return sprintf(buf, "%c\n", console ? 'Y' : 'N');
 }
@@ -3141,17 +3130,14 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	struct tty_port *port = &state->port;
 	struct uart_port *uart_port;
 
-	mutex_lock(&port->mutex);
-	uart_port = uart_port_check(state);
-	if (uart_port != uport)
-		dev_alert(uport->dev, "Removing wrong port: %p != %p\n",
-			  uart_port, uport);
+	scoped_guard(mutex, &port->mutex) {
+		uart_port = uart_port_check(state);
+		if (uart_port != uport)
+			dev_alert(uport->dev, "Removing wrong port: %p != %p\n", uart_port, uport);
 
-	if (!uart_port) {
-		mutex_unlock(&port->mutex);
-		return;
+		if (!uart_port)
+			return;
 	}
-	mutex_unlock(&port->mutex);
 
 	/*
 	 * Remove the devices from the tty layer
@@ -3180,11 +3166,10 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	uport->type = PORT_UNKNOWN;
 	uport->port_dev = NULL;
 
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
 	WARN_ON(atomic_dec_return(&state->refcount) < 0);
 	wait_event(state->remove_wait, !atomic_read(&state->refcount));
 	state->uart_port = NULL;
-	mutex_unlock(&port->mutex);
 }
 
 /**
@@ -3337,7 +3322,7 @@ void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port
 	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
 	int ctrl_id = port->ctrl_id;
 
-	mutex_lock(&port_mutex);
+	guard(mutex)(&port_mutex);
 
 	port->flags |= UPF_DEAD;
 
@@ -3349,8 +3334,6 @@ void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port
 	/* Drop the serial core controller device if no ports are using it */
 	if (!serial_core_ctrl_find(drv, phys_dev, ctrl_id))
 		serial_base_ctrl_device_remove(ctrl_dev);
-
-	mutex_unlock(&port_mutex);
 }
 
 /**
-- 
2.51.1

