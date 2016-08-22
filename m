From: Rob Herring <robh@kernel.org>
Subject: [PATCH 2/2] tty: serial_core: convert uart_close to use tty_port_close
Date: Mon, 22 Aug 2016 17:39:10 -0500
Message-ID: <20160822223910.24453-2-robh@kernel.org>
References: <20160822223910.24453-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822223910.24453-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty_port_close handles much of the common parts of tty close. Convert
uart_close to use it and move the serial_core specific parts into
tty_port.shutdown function. This will be needed to use tty_port functions
directly from in kernel clients.

This change causes ops->stop_rx() to be called after uart_wait_until_sent()
is called which I think should be fine. Otherwise, the sequence of the
close should be the same.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/serial_core.c | 56 ++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0468725..e183d2e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1461,7 +1461,6 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 {
 	struct uart_state *state = tty->driver_data;
 	struct tty_port *port;
-	struct uart_port *uport;
 
 	if (!state) {
 		struct uart_driver *drv = tty->driver->driver_state;
@@ -1477,56 +1476,36 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	port = &state->port;
 	pr_debug("uart_close(%d) called\n", tty->index);
 
-	if (tty_port_close_start(port, tty, filp) == 0)
-		return;
+	tty_port_close(tty->port, tty, filp);
+}
 
-	mutex_lock(&port->mutex);
-	uport = uart_port_check(state);
+static void uart_tty_port_shutdown(struct tty_port *port)
+{
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = uart_port_check(state);
 
+	spin_lock_irq(&uport->lock);
 	/*
 	 * At this point, we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts.
 	 */
-	if (tty_port_initialized(port) &&
-	    !WARN(!uport, "detached port still initialized!\n")) {
-		spin_lock_irq(&uport->lock);
-		uport->ops->stop_rx(uport);
-		spin_unlock_irq(&uport->lock);
-		/*
-		 * Before we drop DTR, make sure the UART transmitter
-		 * has completely drained; this is especially
-		 * important if there is a transmit FIFO!
-		 */
-		uart_wait_until_sent(tty, uport->timeout);
-	}
+	WARN(!uport, "detached port still initialized!\n");
 
-	uart_shutdown(tty, state);
-	tty_port_tty_set(port, NULL);
+	uport->ops->stop_rx(uport);
 
-	spin_lock_irq(&port->lock);
+	spin_unlock_irq(&uport->lock);
 
-	if (port->blocked_open) {
-		spin_unlock_irq(&port->lock);
-		if (port->close_delay)
-			msleep_interruptible(jiffies_to_msecs(port->close_delay));
-		spin_lock_irq(&port->lock);
-	} else if (uport && !uart_console(uport)) {
-		spin_unlock_irq(&port->lock);
-		uart_change_pm(state, UART_PM_STATE_OFF);
-		spin_lock_irq(&port->lock);
-	}
-	spin_unlock_irq(&port->lock);
-	tty_port_set_active(port, 0);
+	uart_port_shutdown(port);
 
 	/*
-	 * Wake up anyone trying to open this port.
+	 * It's possible for shutdown to be called after suspend if we get
+	 * a DCD drop (hangup) at just the right time.  Clear suspended bit so
+	 * we don't try to resume a port that has been shutdown.
 	 */
-	wake_up_interruptible(&port->open_wait);
+	tty_port_set_suspended(port, 0);
 
-	mutex_unlock(&port->mutex);
+	uart_change_pm(state, UART_PM_STATE_OFF);
 
-	tty_ldisc_flush(tty);
-	tty->closing = 0;
 }
 
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
@@ -2446,6 +2425,7 @@ static const struct tty_port_operations uart_port_ops = {
 	.carrier_raised = uart_carrier_raised,
 	.dtr_rts	= uart_dtr_rts,
 	.activate	= uart_port_activate,
+	.shutdown	= uart_tty_port_shutdown,
 };
 
 /**
@@ -2762,6 +2742,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	uport->cons = drv->cons;
 	uport->minor = drv->tty_driver->minor_start + uport->line;
 
+	port->console = uart_console(uport);
+
 	/*
 	 * If this port is a console, then the spinlock is already
 	 * initialised.
-- 
2.9.3
