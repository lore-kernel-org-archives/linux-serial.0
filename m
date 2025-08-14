Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E55259C83;
	Thu, 14 Aug 2025 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156312; cv=none; b=DjM/pBSbrUkZJSd75PHruyqPX/H1LY1pWlnIqVJq0OBg+6jcO5JVrA1/3BimzPmqiIr2Q9+aSaXU8R7s5rTUAjrF8EN6um8dtdgseIX76LBzmO9e/D2jrVMaTfqNQol3tliSLpRCVGjED9sUBZGjChm0Fh4CRKUjU5fCBXSyBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156312; c=relaxed/simple;
	bh=8zCnvPjqso/GFN1c03Ur2Li/eUCKsRNs48dvx1To+O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4xF8B6KF/gLB6oXPmqYxC7CmlUSPYFL//A7mPGwuG+aV5sGYTjhSRjD3WD6MxY/5aiKfJi3pjEsIm4RRD4bHZWngk9WOxlRxEOGKKczAPsVL6Hl1UKePbYHyu5p7IWtXc69CEhggduQd/0B5PLrUhFMh+M+ZmkVpd82WIGiw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8YPhHLj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8YPhHLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5E8C4CEF9;
	Thu, 14 Aug 2025 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156311;
	bh=8zCnvPjqso/GFN1c03Ur2Li/eUCKsRNs48dvx1To+O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8YPhHLjgoN9rqQOJGykoSQ/ndoJM0dBk0RgZ/p2dOvS8fzGE5X7XGEW7xb7/zyp+
	 21URlmB8sEAy3/PsGVXOei3quGUzDh8rSA0/GXMzI5P26zHmee+jb9t7InFPV3iTqP
	 J1eYFa8gJDMbwNb6DuQzCVhx427i/XGkSupyIjdCQUfouLJyl1UlETNqeRby5ZGUSl
	 FDmrkeIWRu1YPVCcIbMjw/VBatUz40ZQmkCFUcXdLoUWRvp3kmi3tsWpJIKL0yaVEN
	 dA7nxp4m5yDLFB65SuEobAnoqr4yzLljyYWCmU8Hmh3TXpXFq13YrYuj2oEuDRUmr6
	 uZvAZV+qs+xZA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/16] serial: serial_core: use guard()s
Date: Thu, 14 Aug 2025 09:24:48 +0200
Message-ID: <20250814072456.182853-9-jirislaby@kernel.org>
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

Having all the new guards, use them in the serial_core code. This
improves readability, makes error handling easier, and marks locked
portions of code explicit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 143 +++++++++++++------------------
 1 file changed, 59 insertions(+), 84 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 86d404d649a3..4757293ece8c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -177,15 +177,13 @@ static void uart_start(struct tty_struct *tty)
 static void
 uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
 {
-	unsigned long flags;
 	unsigned int old;
 
-	uart_port_lock_irqsave(port, &flags);
+	guard(uart_port_lock_irqsave)(port);
 	old = port->mctrl;
 	port->mctrl = (old & ~clear) | set;
 	if (old != port->mctrl && !(port->rs485.flags & SER_RS485_ENABLED))
 		port->ops->set_mctrl(port, port->mctrl);
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 #define uart_set_mctrl(port, set)	uart_update_mctrl(port, set, 0)
@@ -220,7 +218,7 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 	/*
 	 * Set modem status enables based on termios cflag
 	 */
-	uart_port_lock_irq(uport);
+	guard(uart_port_lock_irq)(uport);
 	if (termios->c_cflag & CRTSCTS)
 		uport->status |= UPSTAT_CTS_ENABLE;
 	else
@@ -241,7 +239,6 @@ static void uart_change_line_settings(struct tty_struct *tty, struct uart_state
 		else
 			__uart_start(state);
 	}
-	uart_port_unlock_irq(uport);
 }
 
 static int uart_alloc_xmit_buf(struct tty_port *port)
@@ -711,7 +708,6 @@ static void uart_send_xchar(struct tty_struct *tty, u8 ch)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port;
-	unsigned long flags;
 
 	port = uart_port_ref(state);
 	if (!port)
@@ -720,11 +716,10 @@ static void uart_send_xchar(struct tty_struct *tty, u8 ch)
 	if (port->ops->send_xchar)
 		port->ops->send_xchar(port, ch);
 	else {
-		uart_port_lock_irqsave(port, &flags);
+		guard(uart_port_lock_irqsave)(port);
 		port->x_char = ch;
 		if (ch)
 			port->ops->start_tx(port);
-		uart_port_unlock_irqrestore(port, flags);
 	}
 	uart_port_deref(port);
 }
@@ -1089,7 +1084,6 @@ static int uart_tiocmget(struct tty_struct *tty)
 	struct uart_state *state = tty->driver_data;
 	struct tty_port *port = &state->port;
 	struct uart_port *uport;
-	int result;
 
 	guard(mutex)(&port->mutex);
 
@@ -1097,12 +1091,9 @@ static int uart_tiocmget(struct tty_struct *tty)
 	if (!uport || tty_io_error(tty))
 		return -EIO;
 
-	uart_port_lock_irq(uport);
-	result = uport->mctrl;
-	result |= uport->ops->get_mctrl(uport);
-	uart_port_unlock_irq(uport);
+	guard(uart_port_lock_irq)(uport);
 
-	return result;
+	return uport->mctrl | uport->ops->get_mctrl(uport);
 }
 
 static int
@@ -1226,16 +1217,15 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	uport = uart_port_ref(state);
 	if (!uport)
 		return -EIO;
-	uart_port_lock_irq(uport);
-	memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
-	uart_enable_ms(uport);
-	uart_port_unlock_irq(uport);
+	scoped_guard(uart_port_lock_irq, uport) {
+		memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
+		uart_enable_ms(uport);
+	}
 
 	add_wait_queue(&port->delta_msr_wait, &wait);
 	for (;;) {
-		uart_port_lock_irq(uport);
-		memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
-		uart_port_unlock_irq(uport);
+		scoped_guard(uart_port_lock_irq, uport)
+			memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -1430,7 +1420,6 @@ static void uart_set_rs485_rx_during_tx(struct uart_port *port,
 static int uart_rs485_config(struct uart_port *port)
 {
 	struct serial_rs485 *rs485 = &port->rs485;
-	unsigned long flags;
 	int ret;
 
 	if (!(rs485->flags & SER_RS485_ENABLED))
@@ -1440,9 +1429,8 @@ static int uart_rs485_config(struct uart_port *port)
 	uart_set_rs485_termination(port, rs485);
 	uart_set_rs485_rx_during_tx(port, rs485);
 
-	uart_port_lock_irqsave(port, &flags);
-	ret = port->rs485_config(port, NULL, rs485);
-	uart_port_unlock_irqrestore(port, flags);
+	scoped_guard(uart_port_lock_irqsave, port)
+		ret = port->rs485_config(port, NULL, rs485);
 	if (ret) {
 		memset(rs485, 0, sizeof(*rs485));
 		/* unset GPIOs */
@@ -1456,12 +1444,10 @@ static int uart_rs485_config(struct uart_port *port)
 static int uart_get_rs485_config(struct uart_port *port,
 			 struct serial_rs485 __user *rs485)
 {
-	unsigned long flags;
 	struct serial_rs485 aux;
 
-	uart_port_lock_irqsave(port, &flags);
-	aux = port->rs485;
-	uart_port_unlock_irqrestore(port, flags);
+	scoped_guard(uart_port_lock_irqsave, port)
+		aux = port->rs485;
 
 	if (copy_to_user(rs485, &aux, sizeof(aux)))
 		return -EFAULT;
@@ -1474,7 +1460,6 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 {
 	struct serial_rs485 rs485;
 	int ret;
-	unsigned long flags;
 
 	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
 		return -ENOTTY;
@@ -1489,16 +1474,16 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 	uart_set_rs485_termination(port, &rs485);
 	uart_set_rs485_rx_during_tx(port, &rs485);
 
-	uart_port_lock_irqsave(port, &flags);
-	ret = port->rs485_config(port, &tty->termios, &rs485);
-	if (!ret) {
-		port->rs485 = rs485;
+	scoped_guard(uart_port_lock_irqsave, port) {
+		ret = port->rs485_config(port, &tty->termios, &rs485);
+		if (!ret) {
+			port->rs485 = rs485;
 
-		/* Reset RTS and other mctrl lines when disabling RS485 */
-		if (!(rs485.flags & SER_RS485_ENABLED))
-			port->ops->set_mctrl(port, port->mctrl);
+			/* Reset RTS and other mctrl lines when disabling RS485 */
+			if (!(rs485.flags & SER_RS485_ENABLED))
+				port->ops->set_mctrl(port, port->mctrl);
+		}
 	}
-	uart_port_unlock_irqrestore(port, flags);
 	if (ret) {
 		/* restore old GPIO settings */
 		gpiod_set_value_cansleep(port->rs485_term_gpio,
@@ -1517,15 +1502,13 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 static int uart_get_iso7816_config(struct uart_port *port,
 				   struct serial_iso7816 __user *iso7816)
 {
-	unsigned long flags;
 	struct serial_iso7816 aux;
 
 	if (!port->iso7816_config)
 		return -ENOTTY;
 
-	uart_port_lock_irqsave(port, &flags);
-	aux = port->iso7816;
-	uart_port_unlock_irqrestore(port, flags);
+	scoped_guard(uart_port_lock_irqsave, port)
+		aux = port->iso7816;
 
 	if (copy_to_user(iso7816, &aux, sizeof(aux)))
 		return -EFAULT;
@@ -1537,8 +1520,7 @@ static int uart_set_iso7816_config(struct uart_port *port,
 				   struct serial_iso7816 __user *iso7816_user)
 {
 	struct serial_iso7816 iso7816;
-	int i, ret;
-	unsigned long flags;
+	int i;
 
 	if (!port->iso7816_config)
 		return -ENOTTY;
@@ -1554,11 +1536,11 @@ static int uart_set_iso7816_config(struct uart_port *port,
 		if (iso7816.reserved[i])
 			return -EINVAL;
 
-	uart_port_lock_irqsave(port, &flags);
-	ret = port->iso7816_config(port, &iso7816);
-	uart_port_unlock_irqrestore(port, flags);
-	if (ret)
-		return ret;
+	scoped_guard(uart_port_lock_irqsave, port) {
+		int ret = port->iso7816_config(port, &iso7816);
+		if (ret)
+			return ret;
+	}
 
 	if (copy_to_user(iso7816_user, &port->iso7816, sizeof(port->iso7816)))
 		return -EFAULT;
@@ -1770,9 +1752,8 @@ static void uart_tty_port_shutdown(struct tty_port *port)
 	if (WARN(!uport, "detached port still initialized!\n"))
 		return;
 
-	uart_port_lock_irq(uport);
-	uport->ops->stop_rx(uport);
-	uart_port_unlock_irq(uport);
+	scoped_guard(uart_port_lock_irq, uport)
+		uport->ops->stop_rx(uport);
 
 	serial_base_port_shutdown(uport);
 	uart_port_shutdown(port);
@@ -2044,9 +2025,8 @@ static void uart_line_info(struct seq_file *m, struct uart_state *state)
 		pm_state = state->pm_state;
 		if (pm_state != UART_PM_STATE_ON)
 			uart_change_pm(state, UART_PM_STATE_ON);
-		uart_port_lock_irq(uport);
-		status = uport->ops->get_mctrl(uport);
-		uart_port_unlock_irq(uport);
+		scoped_guard(uart_port_lock_irq, uport)
+			status = uport->ops->get_mctrl(uport);
 		if (pm_state != UART_PM_STATE_ON)
 			uart_change_pm(state, pm_state);
 
@@ -2355,9 +2335,8 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	 */
 	if (!console_suspend_enabled && uart_console(uport)) {
 		if (uport->ops->start_rx) {
-			uart_port_lock_irq(uport);
+			guard(uart_port_lock_irq)(uport);
 			uport->ops->stop_rx(uport);
-			uart_port_unlock_irq(uport);
 		}
 		device_set_awake_path(uport->dev);
 		return 0;
@@ -2373,15 +2352,15 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		tty_port_set_suspended(port, true);
 		tty_port_set_initialized(port, false);
 
-		uart_port_lock_irq(uport);
-		ops->stop_tx(uport);
-		if (!(uport->rs485.flags & SER_RS485_ENABLED))
-			ops->set_mctrl(uport, 0);
-		/* save mctrl so it can be restored on resume */
-		mctrl = uport->mctrl;
-		uport->mctrl = 0;
-		ops->stop_rx(uport);
-		uart_port_unlock_irq(uport);
+		scoped_guard(uart_port_lock_irq, uport) {
+			ops->stop_tx(uport);
+			if (!(uport->rs485.flags & SER_RS485_ENABLED))
+				ops->set_mctrl(uport, 0);
+			/* save mctrl so it can be restored on resume */
+			mctrl = uport->mctrl;
+			uport->mctrl = 0;
+			ops->stop_rx(uport);
+		}
 
 		/*
 		 * Wait for the transmitter to empty.
@@ -2450,9 +2429,8 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			uart_change_pm(state, UART_PM_STATE_ON);
 		uport->ops->set_termios(uport, &termios, NULL);
 		if (!console_suspend_enabled && uport->ops->start_rx) {
-			uart_port_lock_irq(uport);
+			guard(uart_port_lock_irq)(uport);
 			uport->ops->start_rx(uport);
-			uart_port_unlock_irq(uport);
 		}
 		if (console_suspend_enabled)
 			console_resume(uport->cons);
@@ -2463,10 +2441,9 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		int ret;
 
 		uart_change_pm(state, UART_PM_STATE_ON);
-		uart_port_lock_irq(uport);
-		if (!(uport->rs485.flags & SER_RS485_ENABLED))
-			ops->set_mctrl(uport, 0);
-		uart_port_unlock_irq(uport);
+		scoped_guard(uart_port_lock_irq, uport)
+			if (!(uport->rs485.flags & SER_RS485_ENABLED))
+				ops->set_mctrl(uport, 0);
 		if (console_suspend_enabled || !uart_console(uport)) {
 			/* Protected by port mutex for now */
 			struct tty_struct *tty = port->tty;
@@ -2476,11 +2453,11 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 				if (tty)
 					uart_change_line_settings(tty, state, NULL);
 				uart_rs485_config(uport);
-				uart_port_lock_irq(uport);
-				if (!(uport->rs485.flags & SER_RS485_ENABLED))
-					ops->set_mctrl(uport, uport->mctrl);
-				ops->start_tx(uport);
-				uart_port_unlock_irq(uport);
+				scoped_guard(uart_port_lock_irq, uport) {
+					if (!(uport->rs485.flags & SER_RS485_ENABLED))
+						ops->set_mctrl(uport, uport->mctrl);
+					ops->start_tx(uport);
+				}
 				tty_port_set_initialized(port, true);
 			} else {
 				/*
@@ -2574,8 +2551,6 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 	}
 
 	if (port->type != PORT_UNKNOWN) {
-		unsigned long flags;
-
 		uart_report_port(drv, port);
 
 		/* Synchronize with possible boot console. */
@@ -2590,11 +2565,11 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * keep the DTR setting that is set in uart_set_options()
 		 * We probably don't need a spinlock around this, but
 		 */
-		uart_port_lock_irqsave(port, &flags);
-		port->mctrl &= TIOCM_DTR;
-		if (!(port->rs485.flags & SER_RS485_ENABLED))
-			port->ops->set_mctrl(port, port->mctrl);
-		uart_port_unlock_irqrestore(port, flags);
+		scoped_guard(uart_port_lock_irqsave, port) {
+			port->mctrl &= TIOCM_DTR;
+			if (!(port->rs485.flags & SER_RS485_ENABLED))
+				port->ops->set_mctrl(port, port->mctrl);
+		}
 
 		uart_rs485_config(port);
 
-- 
2.50.1

