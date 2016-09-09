From: Rob Herring <robh@kernel.org>
Subject: [PATCH 7/9] tty: serial_core: convert private functions to use tty_port instead of tty_struct
Date: Fri,  9 Sep 2016 17:37:08 -0500
Message-ID: <20160909223711.26238-8-robh@kernel.org>
References: <20160909223711.26238-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909223711.26238-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/serial_core.c | 72 +++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 29eef4644e98..8f2b52174263 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -51,8 +51,7 @@ static struct lock_class_key port_lock_key;
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
-static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
-					struct ktermios *old_termios);
+static void uart_change_speed(struct tty_port *port, struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
 static void uart_change_pm(struct uart_state *state,
 			   enum uart_pm_state pm_state);
@@ -131,11 +130,8 @@ static void uart_stop(struct tty_struct *tty)
 	uart_port_unlock(port, flags);
 }
 
-static void __uart_start(struct tty_struct *tty)
+static void __uart_start(struct uart_port *port)
 {
-	struct uart_state *state = tty->driver_data;
-	struct uart_port *port = state->uart_port;
-
 	if (port && !uart_tx_stopped(port))
 		port->ops->start_tx(port);
 }
@@ -147,7 +143,7 @@ static void uart_start(struct tty_struct *tty)
 	unsigned long flags;
 
 	port = uart_port_lock(state, flags);
-	__uart_start(tty);
+	__uart_start(port);
 	uart_port_unlock(port, flags);
 }
 
@@ -172,9 +168,10 @@ uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
  * Startup the port.  This will be called once per open.  All calls
  * will be serialised by the per-port mutex.
  */
-static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
-		int init_hw)
+static int uart_port_startup(struct tty_port *port, int init_hw)
 {
+	struct tty_struct *tty = port->tty;
+	struct uart_state *state = tty_port_to_uart_state(port);
 	struct uart_port *uport = uart_port_check(state);
 	unsigned long page;
 	int retval = 0;
@@ -210,7 +207,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		/*
 		 * Initialise the hardware port settings.
 		 */
-		uart_change_speed(tty, state, NULL);
+		uart_change_speed(port, NULL);
 
 		/*
 		 * Setup the RTS and DTR signals once the
@@ -231,16 +228,14 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	return retval;
 }
 
-static int uart_startup(struct tty_struct *tty, struct uart_state *state,
-		int init_hw)
+static int uart_startup(struct tty_port *port, int init_hw)
 {
-	struct tty_port *port = &state->port;
 	int retval;
 
 	if (tty_port_initialized(port))
 		return 0;
 
-	retval = uart_port_startup(tty, state, init_hw);
+	retval = uart_port_startup(port, init_hw);
 	if (retval)
 		set_bit(TTY_PORT_IO_ERROR, &port->iflags);
 
@@ -254,10 +249,11 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
  *
  * uport == NULL if uart_port has already been removed
  */
-static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
+static void uart_shutdown(struct tty_port *port)
 {
+	struct tty_struct *tty = port->tty;
+	struct uart_state *state = tty_port_to_uart_state(port);
 	struct uart_port *uport = uart_port_check(state);
-	struct tty_port *port = &state->port;
 
 	/*
 	 * Set the TTY IO error marker
@@ -473,9 +469,10 @@ uart_get_divisor(struct uart_port *port, unsigned int baud)
 EXPORT_SYMBOL(uart_get_divisor);
 
 /* Caller holds port mutex */
-static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
-					struct ktermios *old_termios)
+static void uart_change_speed(struct tty_port *port, struct ktermios *old_termios)
 {
+	struct tty_struct *tty = port->tty;
+	struct uart_state *state = tty_port_to_uart_state(port);
 	struct uart_port *uport = uart_port_check(state);
 	struct ktermios *termios;
 	int hw_stopped;
@@ -513,7 +510,7 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 			uport->ops->stop_tx(uport);
 	} else {
 		if (hw_stopped)
-			__uart_start(tty);
+			__uart_start(uport);
 	}
 	spin_unlock_irq(&uport->lock);
 }
@@ -549,7 +546,7 @@ static int uart_write(struct tty_struct *tty,
 					const unsigned char *buf, int count)
 {
 	struct uart_state *state = tty->driver_data;
-	struct uart_port *port;
+	struct uart_port *uport;
 	struct circ_buf *circ;
 	unsigned long flags;
 	int c, ret = 0;
@@ -567,8 +564,8 @@ static int uart_write(struct tty_struct *tty,
 	if (!circ->buf)
 		return 0;
 
-	port = uart_port_lock(state, flags);
-	while (port) {
+	uport = uart_port_lock(state, flags);
+	while (uport) {
 		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
 		if (count < c)
 			c = count;
@@ -581,8 +578,8 @@ static int uart_write(struct tty_struct *tty,
 		ret += c;
 	}
 
-	__uart_start(tty);
-	uart_port_unlock(port, flags);
+	__uart_start(uport);
+	uart_port_unlock(uport, flags);
 	return ret;
 }
 
@@ -778,7 +775,7 @@ static int uart_get_info_user(struct tty_port *port,
 	return 0;
 }
 
-static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
+static int uart_set_info(struct tty_port *port,
 			 struct uart_state *state,
 			 struct serial_struct *new_info)
 {
@@ -865,7 +862,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		 * We need to shutdown the serial port at the old
 		 * port/type/irq combination.
 		 */
-		uart_shutdown(tty, state);
+		uart_shutdown(port);
 	}
 
 	if (change_port) {
@@ -965,10 +962,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 				      current->comm,
 				      tty_name(port->tty));
 			}
-			uart_change_speed(tty, state, NULL);
+			uart_change_speed(port, NULL);
 		}
 	} else {
-		retval = uart_startup(tty, state, 1);
+		retval = uart_startup(port, 1);
 		if (retval > 0)
 			retval = 0;
 	}
@@ -994,7 +991,7 @@ static int uart_set_info_user(struct tty_struct *tty, struct uart_state *state,
 	 * under us.
 	 */
 	mutex_lock(&port->mutex);
-	retval = uart_set_info(tty, port, state, &new_serial);
+	retval = uart_set_info(port, state, &new_serial);
 	mutex_unlock(&port->mutex);
 	return retval;
 }
@@ -1117,7 +1114,7 @@ static int uart_do_autoconfig(struct tty_struct *tty,struct uart_state *state)
 
 	ret = -EBUSY;
 	if (tty_port_users(port) == 1) {
-		uart_shutdown(tty, state);
+		uart_shutdown(port);
 
 		/*
 		 * If we already have a port type configured,
@@ -1136,7 +1133,7 @@ static int uart_do_autoconfig(struct tty_struct *tty,struct uart_state *state)
 		 */
 		uport->ops->config_port(uport, flags);
 
-		ret = uart_startup(tty, state, 1);
+		ret = uart_startup(port, 1);
 		if (ret > 0)
 			ret = 0;
 	}
@@ -1402,6 +1399,7 @@ static void uart_set_ldisc(struct tty_struct *tty)
 static void uart_set_termios(struct tty_struct *tty,
 						struct ktermios *old_termios)
 {
+	struct tty_port *port = tty->port;
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *uport;
 	unsigned int cflag = tty->termios.c_cflag;
@@ -1438,7 +1436,7 @@ static void uart_set_termios(struct tty_struct *tty,
 		goto out;
 	}
 
-	uart_change_speed(tty, state, old_termios);
+	uart_change_speed(port, old_termios);
 	/* reload cflag from termios; port driver may have overriden flags */
 	cflag = tty->termios.c_cflag;
 
@@ -1591,7 +1589,7 @@ static void uart_hangup(struct tty_struct *tty)
 
 	if (tty_port_active(port)) {
 		uart_flush_buffer(tty);
-		uart_shutdown(tty, state);
+		uart_shutdown(port);
 		spin_lock_irqsave(&port->lock, flags);
 		port->count = 0;
 		spin_unlock_irqrestore(&port->lock, flags);
@@ -1714,7 +1712,7 @@ static int uart_port_activate(struct tty_port *port, struct tty_struct *tty)
 	/*
 	 * Start up the serial port.
 	 */
-	return uart_startup(tty, state, 0);
+	return uart_startup(port, 0);
 }
 
 static const char *uart_type(struct uart_port *port)
@@ -2194,11 +2192,9 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		spin_unlock_irq(&uport->lock);
 		if (console_suspend_enabled || !uart_console(uport)) {
 			/* Protected by port mutex for now */
-			struct tty_struct *tty = port->tty;
 			ret = ops->startup(uport);
 			if (ret == 0) {
-				if (tty)
-					uart_change_speed(tty, state, NULL);
+				uart_change_speed(port, NULL);
 				spin_lock_irq(&uport->lock);
 				ops->set_mctrl(uport, uport->mctrl);
 				ops->start_tx(uport);
@@ -2210,7 +2206,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 				 * Clear the "initialized" flag so we won't try
 				 * to call the low level drivers shutdown method.
 				 */
-				uart_shutdown(tty, state);
+				uart_shutdown(port);
 			}
 		}
 
-- 
2.9.3
