From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: [PATCH 1/2] tty: move serial PM state to TTY driver interface
Date: Mon, 10 Dec 2012 13:34:17 +0100
Message-ID: <1355142858-11046-1-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:47910 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752539Ab2LJMef (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Dec 2012 07:34:35 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, linus.walleij@stericsson.com
Cc: alan@linux.intel.com, daniel.lezcano@linaro.org, rickard.andersson@stericsson.com

From: Linus Walleij <linus.walleij@linaro.org>

We want to make it possible for TTY drivers to control the
power state of the serial core, so as a first step make the
serial core power states generic and rename them TTY_*
so they can be used across all TTY drivers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/serial_core.c | 28 ++++++++++++++--------------
 include/linux/serial_core.h      | 14 +-------------
 include/linux/tty_driver.h       | 12 ++++++++++++
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 006c0ba..b2fc8d7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -60,7 +60,7 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 					struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
 static void uart_change_pm(struct uart_state *state,
-			   enum uart_pm_state pm_state);
+			   enum tty_pm_state pm_state);
 
 static void uart_port_shutdown(struct tty_port *port);
 
@@ -1319,7 +1319,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 		spin_lock_irqsave(&port->lock, flags);
 	} else if (!uart_console(uport)) {
 		spin_unlock_irqrestore(&port->lock, flags);
-		uart_change_pm(state, UART_PM_STATE_OFF);
+		uart_change_pm(state, TTY_PM_STATE_OFF);
 		spin_lock_irqsave(&port->lock, flags);
 	}
 
@@ -1533,7 +1533,7 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
 	 * Make sure the device is in D0 state.
 	 */
 	if (port->count == 1)
-		uart_change_pm(state, UART_PM_STATE_ON);
+		uart_change_pm(state, TTY_PM_STATE_ON);
 
 	/*
 	 * Start up the serial port.
@@ -1574,7 +1574,7 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 {
 	struct uart_state *state = drv->state + i;
 	struct tty_port *port = &state->port;
-	enum uart_pm_state pm_state;
+	enum tty_pm_state pm_state;
 	struct uart_port *uport = state->uart_port;
 	char stat_buf[32];
 	unsigned int status;
@@ -1599,12 +1599,12 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 	if (capable(CAP_SYS_ADMIN)) {
 		mutex_lock(&port->mutex);
 		pm_state = state->pm_state;
-		if (pm_state != UART_PM_STATE_ON)
-			uart_change_pm(state, UART_PM_STATE_ON);
+		if (pm_state != TTY_PM_STATE_ON)
+			uart_change_pm(state, TTY_PM_STATE_ON);
 		spin_lock_irq(&uport->lock);
 		status = uport->ops->get_mctrl(uport);
 		spin_unlock_irq(&uport->lock);
-		if (pm_state != UART_PM_STATE_ON)
+		if (pm_state != TTY_PM_STATE_ON)
 			uart_change_pm(state, pm_state);
 		mutex_unlock(&port->mutex);
 
@@ -1852,7 +1852,7 @@ EXPORT_SYMBOL_GPL(uart_set_options);
  * Locking: port->mutex has to be held
  */
 static void uart_change_pm(struct uart_state *state,
-			   enum uart_pm_state pm_state)
+			   enum tty_pm_state pm_state)
 {
 	struct uart_port *port = state->uart_port;
 
@@ -1937,7 +1937,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		console_stop(uport->cons);
 
 	if (console_suspend_enabled || !uart_console(uport))
-		uart_change_pm(state, UART_PM_STATE_OFF);
+		uart_change_pm(state, TTY_PM_STATE_OFF);
 
 	mutex_unlock(&port->mutex);
 
@@ -1982,7 +1982,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			termios = port->tty->termios;
 
 		if (console_suspend_enabled)
-			uart_change_pm(state, UART_PM_STATE_ON);
+			uart_change_pm(state, TTY_PM_STATE_ON);
 		uport->ops->set_termios(uport, &termios, NULL);
 		if (console_suspend_enabled)
 			console_start(uport->cons);
@@ -1992,7 +1992,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		const struct uart_ops *ops = uport->ops;
 		int ret;
 
-		uart_change_pm(state, UART_PM_STATE_ON);
+		uart_change_pm(state, TTY_PM_STATE_ON);
 		spin_lock_irq(&uport->lock);
 		ops->set_mctrl(uport, 0);
 		spin_unlock_irq(&uport->lock);
@@ -2092,7 +2092,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		uart_report_port(drv, port);
 
 		/* Power up port for set_mctrl() */
-		uart_change_pm(state, UART_PM_STATE_ON);
+		uart_change_pm(state, TTY_PM_STATE_ON);
 
 		/*
 		 * Ensure that the modem control lines are de-activated.
@@ -2116,7 +2116,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * console if we have one.
 		 */
 		if (!uart_console(port))
-			uart_change_pm(state, UART_PM_STATE_OFF);
+			uart_change_pm(state, TTY_PM_STATE_OFF);
 	}
 }
 
@@ -2391,7 +2391,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	}
 
 	state->uart_port = uport;
-	state->pm_state = UART_PM_STATE_UNDEFINED;
+	state->pm_state = TTY_PM_STATE_UNDEFINED;
 
 	uport->cons = drv->cons;
 	uport->state = state;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a83c5f6..75f89a7 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -202,25 +202,13 @@ static inline void serial_port_out(struct uart_port *up, int offset, int value)
 	up->serial_out(up, offset, value);
 }
 
-/**
- * enum uart_pm_state - power states for UARTs
- * @UART_PM_STATE_ON: UART is powered, up and operational
- * @UART_PM_STATE_OFF: UART is powered off
- * @UART_PM_STATE_UNDEFINED: sentinel
- */
-enum uart_pm_state {
-	UART_PM_STATE_ON = 0,
-	UART_PM_STATE_OFF = 3, /* number taken from ACPI */
-	UART_PM_STATE_UNDEFINED,
-};
-
 /*
  * This is the state information which is persistent across opens.
  */
 struct uart_state {
 	struct tty_port		port;
 
-	enum uart_pm_state	pm_state;
+	enum tty_pm_state	pm_state;
 	struct circ_buf		xmit;
 
 	struct uart_port	*uart_port;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index dd976cf..d150a6f 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -241,6 +241,18 @@ struct tty_struct;
 struct tty_driver;
 struct serial_icounter_struct;
 
+/**
+ * enum tty_pm_state - power states for TTYs
+ * @TTY_PM_STATE_ON: TTY is powered, up and operational
+ * @TTY_PM_STATE_OFF: TTY is powered off
+ * @TTY_PM_STATE_UNDEFINED: sentinel
+ */
+enum tty_pm_state {
+	TTY_PM_STATE_ON = 0,
+	TTY_PM_STATE_OFF = 3, /* number taken from ACPI */
+	TTY_PM_STATE_UNDEFINED,
+};
+
 struct tty_operations {
 	struct tty_struct * (*lookup)(struct tty_driver *driver,
 			struct inode *inode, int idx);
-- 
1.8.0

