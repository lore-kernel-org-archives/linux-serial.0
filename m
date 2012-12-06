From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/2] tty: serial core: use the ACPI PM state defines
Date: Thu, 6 Dec 2012 19:46:52 +0100
Message-ID: <1354819612-2401-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:41468 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964882Ab2LFSr0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Dec 2012 13:47:26 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, "Rafael J.  Wysocki" <rjw@sisk.pl>
Cc: Alan Cox <alan@linux.intel.com>, Rickard Andersson <rickard.andersson@stericsson.com>, linux-acpi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

From: Linus Walleij <linus.walleij@linaro.org>

The Documentation/serial/driver file defines that:

  State indicates the new state (defined by ACPI D0-D3),
  oldstate indicates the previous state.  Essentially, D0
  means fully on, D3 means powered down.

So let's change the code to actually using the defined ACPI
states instead of using magic numbers. Further it is clear
from the ACPI definitions that the state is a u8 so use this
data type.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/serial_core.c | 26 ++++++++++++++------------
 include/linux/serial_core.h      |  2 +-
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2c7230a..f327115 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -34,6 +34,8 @@
 #include <linux/delay.h>
 #include <linux/mutex.h>
 
+#include <acpi/acstates.h> /* for power states */
+
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
@@ -59,7 +61,7 @@ static struct lock_class_key port_lock_key;
 static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 					struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
-static void uart_change_pm(struct uart_state *state, int pm_state);
+static void uart_change_pm(struct uart_state *state, u8 pm_state);
 
 static void uart_port_shutdown(struct tty_port *port);
 
@@ -1365,7 +1367,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 		spin_lock_irqsave(&port->lock, flags);
 	} else if (!uart_console(uport)) {
 		spin_unlock_irqrestore(&port->lock, flags);
-		uart_change_pm(state, 3);
+		uart_change_pm(state, ACPI_STATE_D3_HOT);
 		spin_lock_irqsave(&port->lock, flags);
 	}
 
@@ -1579,7 +1581,7 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
 	 * Make sure the device is in D0 state.
 	 */
 	if (port->count == 1)
-		uart_change_pm(state, 0);
+		uart_change_pm(state, ACPI_STATE_D0);
 
 	/*
 	 * Start up the serial port.
@@ -1620,7 +1622,7 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 {
 	struct uart_state *state = drv->state + i;
 	struct tty_port *port = &state->port;
-	int pm_state;
+	u8 pm_state;
 	struct uart_port *uport = state->uart_port;
 	char stat_buf[32];
 	unsigned int status;
@@ -1646,7 +1648,7 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 		mutex_lock(&port->mutex);
 		pm_state = state->pm_state;
 		if (pm_state)
-			uart_change_pm(state, 0);
+			uart_change_pm(state, ACPI_STATE_D0);
 		spin_lock_irq(&uport->lock);
 		status = uport->ops->get_mctrl(uport);
 		spin_unlock_irq(&uport->lock);
@@ -1897,7 +1899,7 @@ EXPORT_SYMBOL_GPL(uart_set_options);
  *
  * Locking: port->mutex has to be held
  */
-static void uart_change_pm(struct uart_state *state, int pm_state)
+static void uart_change_pm(struct uart_state *state, u8 pm_state)
 {
 	struct uart_port *port = state->uart_port;
 
@@ -1982,7 +1984,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		console_stop(uport->cons);
 
 	if (console_suspend_enabled || !uart_console(uport))
-		uart_change_pm(state, 3);
+		uart_change_pm(state, ACPI_STATE_D3_HOT);
 
 	mutex_unlock(&port->mutex);
 
@@ -2027,7 +2029,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			termios = port->tty->termios;
 
 		if (console_suspend_enabled)
-			uart_change_pm(state, 0);
+			uart_change_pm(state, ACPI_STATE_D0);
 		uport->ops->set_termios(uport, &termios, NULL);
 		if (console_suspend_enabled)
 			console_start(uport->cons);
@@ -2037,7 +2039,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		const struct uart_ops *ops = uport->ops;
 		int ret;
 
-		uart_change_pm(state, 0);
+		uart_change_pm(state, ACPI_STATE_D0);
 		spin_lock_irq(&uport->lock);
 		ops->set_mctrl(uport, 0);
 		spin_unlock_irq(&uport->lock);
@@ -2137,7 +2139,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		uart_report_port(drv, port);
 
 		/* Power up port for set_mctrl() */
-		uart_change_pm(state, 0);
+		uart_change_pm(state, ACPI_STATE_D0);
 
 		/*
 		 * Ensure that the modem control lines are de-activated.
@@ -2161,7 +2163,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * console if we have one.
 		 */
 		if (!uart_console(port))
-			uart_change_pm(state, 3);
+			uart_change_pm(state, ACPI_STATE_D3_HOT);
 	}
 }
 
@@ -2588,7 +2590,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	}
 
 	state->uart_port = uport;
-	state->pm_state = -1;
+	state->pm_state = ACPI_STATE_UNKNOWN;
 
 	uport->cons = drv->cons;
 	uport->state = state;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c6690a2..43e8d87 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -214,7 +214,7 @@ static inline void serial_port_out(struct uart_port *up, int offset, int value)
 struct uart_state {
 	struct tty_port		port;
 
-	int			pm_state;
+	u8			pm_state;
 	struct circ_buf		xmit;
 
 	struct uart_port	*uart_port;
-- 
1.7.11.3

