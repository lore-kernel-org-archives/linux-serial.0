From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 1/7] serial: core: Simplify console suspend logic in uart_suspend_port()
Date: Thu, 22 Jan 2015 12:24:25 -0500
Message-ID: <1421947471-6396-2-git-send-email-peter@hurleysoftware.com>
References: <1421947471-6396-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421947471-6396-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

When the uart port being suspended is a console and consoles are
not suspending (kernel command line contains no_console_suspend),
then no action is performed for that port, and the function can
return early.

If the function has not returned early, then one of the conditions
is not true, so the expression
   (console_suspend_enabled || !uart_console(uport))
must be true and can be eliminated.

Similarly, the expression
   (console_suspend_enabled && uart_console(uport))
simplifies to just uart_console(uport).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 57ca61b..37dc808 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2008,23 +2008,24 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	}
 	put_device(tty_dev);
 
-	if (console_suspend_enabled || !uart_console(uport))
-		uport->suspended = 1;
+	/* Nothing to do if the console is not suspending */
+	if (!console_suspend_enabled && uart_console(uport))
+		goto unlock;
+
+	uport->suspended = 1;
 
 	if (port->flags & ASYNC_INITIALIZED) {
 		const struct uart_ops *ops = uport->ops;
 		int tries;
 
-		if (console_suspend_enabled || !uart_console(uport)) {
-			set_bit(ASYNCB_SUSPENDED, &port->flags);
-			clear_bit(ASYNCB_INITIALIZED, &port->flags);
-
-			spin_lock_irq(&uport->lock);
-			ops->stop_tx(uport);
-			ops->set_mctrl(uport, 0);
-			ops->stop_rx(uport);
-			spin_unlock_irq(&uport->lock);
-		}
+		set_bit(ASYNCB_SUSPENDED, &port->flags);
+		clear_bit(ASYNCB_INITIALIZED, &port->flags);
+
+		spin_lock_irq(&uport->lock);
+		ops->stop_tx(uport);
+		ops->set_mctrl(uport, 0);
+		ops->stop_rx(uport);
+		spin_unlock_irq(&uport->lock);
 
 		/*
 		 * Wait for the transmitter to empty.
@@ -2036,19 +2037,17 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 				drv->dev_name,
 				drv->tty_driver->name_base + uport->line);
 
-		if (console_suspend_enabled || !uart_console(uport))
-			ops->shutdown(uport);
+		ops->shutdown(uport);
 	}
 
 	/*
 	 * Disable the console device before suspending.
 	 */
-	if (console_suspend_enabled && uart_console(uport))
+	if (uart_console(uport))
 		console_stop(uport->cons);
 
-	if (console_suspend_enabled || !uart_console(uport))
-		uart_change_pm(state, UART_PM_STATE_OFF);
-
+	uart_change_pm(state, UART_PM_STATE_OFF);
+unlock:
 	mutex_unlock(&port->mutex);
 
 	return 0;
-- 
2.2.2
