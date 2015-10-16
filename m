From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 2/3] tty: serial_core: add hooks for uart slave drivers
Date: Fri, 16 Oct 2015 20:08:34 +0200
Message-ID: <484d4e18f849a4a1083862e604e81bf1a396fb7f.1445018913.git.hns@goldelico.com>
References: <cover.1445018912.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1445018912.git.hns@goldelico.com>
In-Reply-To: <cover.1445018912.git.hns@goldelico.com>
References: <cover.1445018912.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Sergei Zviagintsev <sergei@s15v.net>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, NeilBrown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Marek Belisko <marek@goldelico.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-serial@vger.kernel.org

1. allow drivers to get notified about mctrl changes
2. allow drivers to get notified about rx data (indicating to the
   driver that the connected chip is active)
3. the driver also has the option to modify or block the
   received character instead of passing to the tty layer

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/tty/serial/serial_core.c | 104 +++++++++++++++++++++++++++++++++++++--
 include/linux/serial_core.h      |  15 +++++-
 2 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9caa33e..b731100 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -166,6 +166,86 @@ err0:
 }
 EXPORT_SYMBOL_GPL(devm_serial_get_uart_by_phandle);
 
+void uart_register_slave(struct uart_port *uport, void *slave)
+{
+	if (!slave) {
+		uart_register_mctrl_notification(uport, NULL);
+		uart_register_rx_notification(uport, NULL, NULL);
+	}
+	uport->slave = slave;
+}
+EXPORT_SYMBOL_GPL(uart_register_slave);
+
+void uart_register_mctrl_notification(struct uart_port *uport,
+		int (*function)(void *slave, int state))
+{
+	uport->mctrl_notification = function;
+}
+EXPORT_SYMBOL_GPL(uart_register_mctrl_notification);
+
+static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
+		int init_hw);
+
+static void uart_port_shutdown(struct tty_port *port);
+
+void uart_register_rx_notification(struct uart_port *uport,
+		int (*function)(void *slave, unsigned int *c),
+				struct ktermios *termios)
+{
+	struct uart_state *state = uport->state;
+	struct tty_port *tty_port = &state->port;
+
+	if (!uport->slave)
+		return;	/* slave must be registered first */
+
+	uport->rx_notification = function;
+
+	if (tty_port->count == 0) {
+		if (function) {
+			int retval = 0;
+
+			uart_change_pm(state, UART_PM_STATE_ON);
+			retval = uport->ops->startup(uport);
+			if (retval == 0 && termios) {
+				int hw_stopped;
+				/*
+				 * Initialise the hardware port settings.
+				 */
+				uport->ops->set_termios(uport, termios, NULL);
+
+				/*
+				 * Set modem status enables based on termios cflag
+				 */
+				spin_lock_irq(&uport->lock);
+				if (termios->c_cflag & CRTSCTS)
+					uport->status |= UPSTAT_CTS_ENABLE;
+				else
+					uport->status &= ~UPSTAT_CTS_ENABLE;
+
+				if (termios->c_cflag & CLOCAL)
+					uport->status &= ~UPSTAT_DCD_ENABLE;
+				else
+					uport->status |= UPSTAT_DCD_ENABLE;
+
+				/* reset sw-assisted CTS flow control based on (possibly) new mode */
+				hw_stopped = uport->hw_stopped;
+				uport->hw_stopped = uart_softcts_mode(uport) &&
+					!(uport->ops->get_mctrl(uport)
+						& TIOCM_CTS);
+				if (uport->hw_stopped) {
+					if (!hw_stopped)
+						uport->ops->stop_tx(uport);
+				} else {
+					if (hw_stopped)
+						uport->ops->start_tx(uport);
+				}
+				spin_unlock_irq(&uport->lock);
+			}
+		} else
+			uart_port_shutdown(tty_port);
+	}
+}
+EXPORT_SYMBOL_GPL(uart_register_rx_notification);
 
 /*
  * This routine is used by the interrupt handler to schedule processing in
@@ -224,6 +304,10 @@ uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
 	port->mctrl = (old & ~clear) | set;
 	if (old != port->mctrl)
 		port->ops->set_mctrl(port, port->mctrl);
+
+	if (port->mctrl_notification)
+		(*port->mctrl_notification)(port->slave, port->mctrl);
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -263,7 +347,8 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		uart_circ_clear(&state->xmit);
 	}
 
-	retval = uport->ops->startup(uport);
+	if (!state->uart_port->rx_notification)
+		retval = uport->ops->startup(uport);
 	if (retval == 0) {
 		if (uart_console(uport) && uport->cons->cflag) {
 			tty->termios.c_cflag = uport->cons->cflag;
@@ -299,7 +384,7 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state,
 		int init_hw)
 {
 	struct tty_port *port = &state->port;
-	int retval;
+	int retval = 0;
 
 	if (port->flags & ASYNC_INITIALIZED)
 		return 0;
@@ -345,8 +430,12 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 
 		if (!tty || (tty->termios.c_cflag & HUPCL))
 			uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
-
-		uart_port_shutdown(port);
+		/*
+		 * if we have a slave that has registered for rx_notifications
+		 * we do not shut down the uart port to be able to monitor the device
+		 */
+		if (!uport->rx_notification)
+			uart_port_shutdown(port);
 	}
 
 	/*
@@ -1503,8 +1592,9 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	/*
 	 * At this point, we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts.
+	 * Unless a slave driver wants to keep input running
 	 */
-	if (port->flags & ASYNC_INITIALIZED) {
+	if (!uport->rx_notification && (port->flags & ASYNC_INITIALIZED)) {
 		spin_lock_irq(&uport->lock);
 		uport->ops->stop_rx(uport);
 		spin_unlock_irq(&uport->lock);
@@ -3028,6 +3118,10 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
 {
 	struct tty_port *tport = &port->state->port;
 
+	if (port->rx_notification)
+		if ((*port->rx_notification)(port->slave, &ch))
+			return;	/* slave told us to ignore character */
+
 	if ((status & port->ignore_status_mask & ~overrun) == 0)
 		if (tty_insert_flip_char(tport, ch, flag) == 0)
 			++port->icount.buf_overrun;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d7a2e15..af90800 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -35,7 +35,7 @@
 #define uart_console(port) \
 	((port)->cons && (port)->cons->index == (port)->line)
 #else
-#define uart_console(port)      ({ (void)port; 0; })
+#define uart_console(port)      (0)
 #endif
 
 struct uart_port;
@@ -247,7 +247,13 @@ struct uart_port {
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
 	void			*private_data;		/* generic platform data pointer */
+	/* UART slave support */
 	struct list_head	head;			/* uarts list (lookup by phandle) */
+	void			*slave;			/* optional slave (there can be only one) */
+	int			(*mctrl_notification)(void *slave,
+						      int state);
+	int			(*rx_notification)(void *slave,
+						      unsigned int *c);
 };
 
 static inline int serial_port_in(struct uart_port *up, int offset)
@@ -485,4 +491,11 @@ static inline int uart_handle_break(struct uart_port *port)
  */
 extern struct uart_port *devm_serial_get_uart_by_phandle(struct device *dev,
 		const char *phandle, u8 index);
+/* register to receive notifications */
+extern void uart_register_slave(struct uart_port *uart, void *slave);
+extern void uart_register_mctrl_notification(struct uart_port *uart,
+		int (*function)(void *slave, int state));
+extern void uart_register_rx_notification(struct uart_port *uart,
+		int (*function)(void *slave, unsigned int *c), struct ktermios *termios);
+
 #endif /* LINUX_SERIAL_CORE_H */
-- 
2.5.1
