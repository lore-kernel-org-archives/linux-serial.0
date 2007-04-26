From: Corey Minyard <minyard@acm.org>
Subject: [PATCH 5/8] serial: Add a poll interface to the serial core
Date: Thu, 26 Apr 2007 13:51:41 -0500
Message-ID: <20070426185141.GE25521@localdomain>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta8.adelphia.net ([68.168.78.196]:33412 "EHLO
	mta8.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbXDZTXZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2007 15:23:25 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Subject: serial: Add a poll interface to the serial core

Add a poll interface to the serial code.  The interface is
unfortunately complex (more than just a new "poll" call in the
interface) because of several requirements of the console code.  This
interface adds the following function variables:

  poll_startup, poll_shutdown: Configure and release for polling.
  poll: The actual call to do polling.
  in_flow_control: Check CTS
  port_defaults: Return reasonable defaults.

With these added calls, it should be possible for the serial console,
kgdb, and the IPMI driver to share this interface to the serial port.

This patch adds the interfaces for the individual drivers, more to
come to add the console and upper layer interfaces.

Signed-off-by: Corey Minyard <minyard@acm.org>

 drivers/serial/serial_core.c |   64 +++++++++++++++++++++++++++++----
 include/linux/serial_core.h  |   81 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 135 insertions(+), 10 deletions(-)

Index: linux-2.6.21/include/linux/serial_core.h
===================================================================
--- linux-2.6.21.orig/include/linux/serial_core.h
+++ linux-2.6.21/include/linux/serial_core.h
@@ -151,6 +151,12 @@ struct uart_info;
 struct serial_struct;
 struct device;
 
+#define UART_POLL_FLAGS_RX	(1 << 0)	/* Poll Receiver */
+#define UART_POLL_FLAGS_TX	(1 << 1)	/* Poll Transmitter */
+#define UART_POLL_FLAGS_MCTRL	(1 << 2)	/* Poll modem control */
+
+#define UART_POLL_RETFLAGS_RX		(1 << 0) /* Poll received some chars */
+#define UART_POLL_RETFLAGS_MCTRL	(1 << 2) /* Poll got modem status */
 /*
  * This structure describes all the operations that can be
  * done on the physical hardware.
@@ -173,6 +179,51 @@ struct uart_ops {
 			      unsigned int oldstate);
 	int		(*set_wake)(struct uart_port *, unsigned int state);
 
+
+	/*
+	 * Note: Poll routines must be called with the port lock held and
+	 * interrupts off.
+	 */
+
+	/*
+	 * The startup and shutdown routines must be called before
+	 * poll is used and after done calling poll.  You cannot allow
+	 * the driver code to be run by interrupts (or anything else)
+	 * between this.  A state value is returned by the startup
+	 * routine in pstate, you must pass that to the shutdown
+	 * routine.
+	 */
+	int		(*poll_startup)(struct uart_port *,
+					unsigned long *pstate);
+	void		(*poll_shutdown)(struct uart_port *,
+					 unsigned long pstate);
+
+	/*
+	 * Check the serial chip for I/O.  Flags is used to specify
+	 * what to check, see UART_POLL_FLAGS_xxx above.  It returns
+	 * some status, if the UART_POLL_RETFLAGS_RECEIVED bit is
+	 * set in the return value, that means a receive character
+	 * was placed in the receive buffer and the receive buffer
+	 * needs to be processed.
+	 */
+	unsigned int	(*poll)(struct uart_port *, unsigned int flags);
+
+	/*
+	 * Is the port in flow-control (CTS is not asserted).  It is
+	 * optional an may be NULL and is only called if UPF_CONS_FLOW
+	 * is set in port->flags.
+	 */
+	int             (*in_flow_control)(struct uart_port *);
+
+	/*
+	 * Return reasonable settings for the port; it is primarily
+	 * there so firmware can pass console settings for the
+	 * console.
+	 */
+	int		(*port_defaults)(struct uart_port *,
+					 int *baud, int *parity, int *bits,
+					 int *flow);
+
 	/*
 	 * Return a string describing the type of the port
 	 */
@@ -318,6 +369,8 @@ struct uart_info {
  * Definitions for info->flags.  These are _private_ to serial_core, and
  * are specific to this structure.  They may be queried by low level drivers.
  */
+#define UIF_TASKLET_SETUP	((__force uif_t) (1 << 23))
+#define UIF_BOOT_ALLOCATED	((__force uif_t) (1 << 24))
 #define UIF_CHECK_CD		((__force uif_t) (1 << 25))
 #define UIF_CTS_FLOW		((__force uif_t) (1 << 26))
 #define UIF_NORMAL_ACTIVE	((__force uif_t) (1 << 29))
@@ -348,6 +401,18 @@ struct uart_driver {
 	struct console		*cons;
 
 	/*
+	 * If nr_pollable is non-zero, then pollable_ports is an array of uart
+	 * ports that can be used for polling.  The serial_core code
+	 * will assume two things:
+	 *   1) The driver has poll capability in the uart_ops.
+	 *   2) The driver wants the serial_core to manage the console
+	 *      pointed to by "cons" above.  It uses the poll capability
+	 *      to do this.
+	 */
+	int			 nr_pollable;
+	struct uart_port	**pollable_ports;
+
+	/*
 	 * these are private; the low level driver should not
 	 * touch these; they should be initialised to NULL
 	 */
@@ -384,6 +449,8 @@ void uart_console_write(struct uart_port
 /*
  * Port/driver registration/removal
  */
+void uart_register_polled(struct uart_driver *uart);
+void uart_unregister_polled(struct uart_driver *uart);
 int uart_register_driver(struct uart_driver *uart);
 void uart_unregister_driver(struct uart_driver *uart);
 int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
@@ -407,8 +474,12 @@ int uart_resume_port(struct uart_driver 
 #define uart_circ_chars_free(circ)	\
 	(CIRC_SPACE((circ)->head, (circ)->tail, UART_XMIT_SIZE))
 
-#define uart_tx_stopped(port)		\
-	((port)->info->tty->stopped || (port)->info->tty->hw_stopped)
+static inline int uart_tx_stopped(struct uart_port *port)
+{
+	if (!port->info->tty)
+		return 0;
+	return port->info->tty->stopped || port->info->tty->hw_stopped;
+}
 
 /*
  * The following are helper functions for the low level drivers.
@@ -514,6 +585,9 @@ uart_insert_char(struct uart_port *port,
 {
 	struct tty_struct *tty = port->info->tty;
 
+	if (!tty)
+		return;
+
 	if ((status & port->ignore_status_mask & ~overrun) == 0)
 		tty_insert_flip_char(tty, ch, flag);
 
@@ -528,6 +602,9 @@ uart_insert_char(struct uart_port *port,
 static inline void
 uart_push(struct uart_port *port)
 {
+	if (!port->info->tty)
+		return;
+
 	tty_flip_buffer_push(port->info->tty);
 }
 
Index: linux-2.6.21/drivers/serial/serial_core.c
===================================================================
--- linux-2.6.21.orig/drivers/serial/serial_core.c
+++ linux-2.6.21/drivers/serial/serial_core.c
@@ -263,7 +263,7 @@ static void uart_shutdown(struct uart_st
 	/*
 	 * Free the transmit buffer page.
 	 */
-	if (info->xmit.buf) {
+	if (info->xmit.buf && !(info->flags & UIF_BOOT_ALLOCATED)) {
 		free_page((unsigned long)info->xmit.buf);
 		info->xmit.buf = NULL;
 	}
@@ -1523,8 +1523,22 @@ static struct uart_state *uart_get(struc
 	}
 
 	if (!state->info) {
-		state->info = kzalloc(sizeof(struct uart_info), GFP_KERNEL);
-		if (state->info) {
+		/*
+		 * This code is convoluted because the console code
+		 * (and other polled users) needs to set up an info
+		 * structure, but it can't set up the tasklet.
+		 */
+		if (state->port->info)
+			/* Already there from the console code. */
+			state->info = state->port->info;
+		else {
+			state->info = kzalloc(sizeof(struct uart_info),
+					      GFP_KERNEL);
+			if (!state->info) {
+				ret = -ENOMEM;
+				goto err_unlock;
+			}
+
 			init_waitqueue_head(&state->info->open_wait);
 			init_waitqueue_head(&state->info->delta_msr_wait);
 
@@ -1533,11 +1547,12 @@ static struct uart_state *uart_get(struc
 			 */
 			state->port->info = state->info;
 
+		}
+
+		if (!(state->info->flags & UIF_TASKLET_SETUP)) {
 			tasklet_init(&state->info->tlet, uart_tasklet_action,
 				     (unsigned long)state);
-		} else {
-			ret = -ENOMEM;
-			goto err_unlock;
+			state->info->flags |= UIF_TASKLET_SETUP;
 		}
 	}
 	return state;
@@ -2154,6 +2169,27 @@ static const struct tty_operations uart_
 };
 
 /**
+ *	uart_register_polled - register a driver to be used as a polled device
+ *	@drv: low level driver structure
+ *
+ *	Register a uart driver with the polled driver interface.  This
+ *	means that things that need polled I/O can use the driver at this
+ *	point.
+ */
+void uart_register_polled(struct uart_driver *drv)
+{
+}
+
+/**
+ *	uart_unregister_polled - unregister a driver previously registered
+ *      as a polled device
+ *	@drv: low level driver structure
+ */
+void uart_unregister_polled(struct uart_driver *drv)
+{
+}
+
+/**
  *	uart_register_driver - register a driver with the uart core layer
  *	@drv: low level driver structure
  *
@@ -2280,7 +2316,16 @@ int uart_add_one_port(struct uart_driver
 	state->port = port;
 
 	port->cons = drv->cons;
-	port->info = state->info;
+
+	/*
+	 * Don't assign info if it has already been assigned.
+	 *
+	 * FIXME - is this assignment really necessary?  port->info
+	 * doesn't seem to be used until after an open, and that
+	 * assigns the value.
+	 */
+	if (!port->info)
+		port->info = state->info;
 
 	/*
 	 * If this port is a console, then the spinlock is already
@@ -2382,7 +2427,8 @@ int uart_remove_one_port(struct uart_dri
 	 */
 	if (info) {
 		tasklet_kill(&info->tlet);
-		kfree(info);
+		if (!(info->flags & UIF_BOOT_ALLOCATED))
+			kfree(info);
 	}
 
 	state->port = NULL;
@@ -2418,6 +2464,8 @@ EXPORT_SYMBOL(uart_match_port);
 EXPORT_SYMBOL(uart_write_wakeup);
 EXPORT_SYMBOL(uart_register_driver);
 EXPORT_SYMBOL(uart_unregister_driver);
+EXPORT_SYMBOL(uart_register_polled);
+EXPORT_SYMBOL(uart_unregister_polled);
 EXPORT_SYMBOL(uart_suspend_port);
 EXPORT_SYMBOL(uart_resume_port);
 EXPORT_SYMBOL(uart_add_one_port);
