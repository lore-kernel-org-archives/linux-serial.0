From: Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] tty: serial_core: convert uart_open to use tty_port_open
Date: Mon, 22 Aug 2016 17:39:09 -0500
Message-ID: <20160822223910.24453-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty_port_open handles much of the common parts of tty opening. Convert
uart_open to use it and move the serial_core specific parts into
tty_port.activate function. This will be needed to use tty_port functions
directly from in kernel clients.

The tricky part is uart_port_startup can return positive values to allow
setserial to configure the port. We now return the positive value to
tty_port_open so that the tty is not marked as initialized and then set the
return value in uart_open to 0.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
In looking at using tty_port for uart slaves, this is the first thing I 
hit. serial_core doesn't even use the 2 functions that already exist for 
tty_port and are needed.

I've tested this on QEMU with pl011 and 8250 UARTs using setserial, but 
I'm not sure what are all the tricky cases to handle.

Greg, Don't apply these without comment from Alan and Peter.

Rob

 drivers/tty/serial/serial_core.c | 70 +++++++++++++---------------------------
 1 file changed, 23 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9fc1533..0468725 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -235,18 +235,9 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
 	if (tty_port_initialized(port))
 		return 0;
 
-	/*
-	 * Set the TTY IO error marker - we will only clear this
-	 * once we have successfully opened the port.
-	 */
-	set_bit(TTY_IO_ERROR, &tty->flags);
-
 	retval = uart_port_startup(tty, state, init_hw);
-	if (!retval) {
-		tty_port_set_initialized(port, 1);
-		clear_bit(TTY_IO_ERROR, &tty->flags);
-	} else if (retval > 0)
-		retval = 0;
+	if (retval)
+		set_bit(TTY_IO_ERROR, &tty->flags);
 
 	return retval;
 }
@@ -972,8 +963,11 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 			}
 			uart_change_speed(tty, state, NULL);
 		}
-	} else
+	} else {
 		retval = uart_startup(tty, state, 1);
+		if (retval > 0)
+			retval = 0;
+	}
  exit:
 	return retval;
 }
@@ -1139,6 +1133,8 @@ static int uart_do_autoconfig(struct tty_struct *tty,struct uart_state *state)
 		uport->ops->config_port(uport, flags);
 
 		ret = uart_startup(tty, state, 1);
+		if (ret > 0)
+			ret = 0;
 	}
 out:
 	mutex_unlock(&port->mutex);
@@ -1711,52 +1707,31 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
 	struct uart_driver *drv = tty->driver->driver_state;
 	int retval, line = tty->index;
 	struct uart_state *state = drv->state + line;
-	struct tty_port *port = &state->port;
-	struct uart_port *uport;
 
-	pr_debug("uart_open(%d) called\n", line);
+	tty->driver_data = state;
 
-	spin_lock_irq(&port->lock);
-	++port->count;
-	spin_unlock_irq(&port->lock);
+	retval = tty_port_open(&state->port, tty, filp);
+	if (retval > 0)
+		retval = 0;
 
-	/*
-	 * We take the semaphore here to guarantee that we won't be re-entered
-	 * while allocating the state structure, or while we request any IRQs
-	 * that the driver may need.  This also has the nice side-effect that
-	 * it delays the action of uart_hangup, so we can guarantee that
-	 * state->port.tty will always contain something reasonable.
-	 */
-	if (mutex_lock_interruptible(&port->mutex)) {
-		retval = -ERESTARTSYS;
-		goto end;
-	}
+	return retval;
+}
+
+static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport;
 
 	uport = uart_port_check(state);
-	if (!uport || uport->flags & UPF_DEAD) {
-		retval = -ENXIO;
-		goto err_unlock;
-	}
+	if (!uport || uport->flags & UPF_DEAD)
+		return -ENXIO;
 
-	tty->driver_data = state;
-	uport->state = state;
 	port->low_latency = (uport->flags & UPF_LOW_LATENCY) ? 1 : 0;
-	tty_port_tty_set(port, tty);
 
 	/*
 	 * Start up the serial port.
 	 */
-	retval = uart_startup(tty, state, 0);
-
-	/*
-	 * If we succeeded, wait until the port is ready.
-	 */
-err_unlock:
-	mutex_unlock(&port->mutex);
-	if (retval == 0)
-		retval = tty_port_block_til_ready(port, tty, filp);
-end:
-	return retval;
+	return uart_startup(tty, state, 0);
 }
 
 static const char *uart_type(struct uart_port *port)
@@ -2470,6 +2445,7 @@ static const struct tty_operations uart_ops = {
 static const struct tty_port_operations uart_port_ops = {
 	.carrier_raised = uart_carrier_raised,
 	.dtr_rts	= uart_dtr_rts,
+	.activate	= uart_port_activate,
 };
 
 /**
-- 
2.9.3
