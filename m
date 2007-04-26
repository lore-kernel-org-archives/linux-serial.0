From: Corey Minyard <minyard@acm.org>
Subject: [PATCH 8/8] serial: Add an upper level interface for the polled interface
Date: Thu, 26 Apr 2007 13:54:53 -0500
Message-ID: <20070426185452.GH25521@localdomain>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta3.adelphia.net ([68.168.78.181]:36400 "EHLO
	mta3.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbXDZTRW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2007 15:17:22 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Subject: serial: Add an upper level interface for the polled interface

Add an upper level interface so that an in-kernel use can direclty
grab a serial port for its own use.  This is the interface that the
IPMI serial driver and kgdb can share.

Signed-off-by: Corey Minyard <minyard@acm.org>

 drivers/serial/serial_core.c |  234 +++++++++++++++++++++++++++++++++++++++----
 include/linux/serial_core.h  |  115 ++++++++++++++++++++-
 2 files changed, 324 insertions(+), 25 deletions(-)

Index: linux-2.6.21/drivers/serial/serial_core.c
===================================================================
--- linux-2.6.21.orig/drivers/serial/serial_core.c
+++ linux-2.6.21/drivers/serial/serial_core.c
@@ -82,6 +82,13 @@ void uart_write_wakeup(struct uart_port 
 	 * closed.  No cookie for you.
 	 */
 	BUG_ON(!info);
+
+	if (info->direct) {
+		if (info->direct->tx_ready)
+			info->direct->tx_ready(port);
+		return;
+	}
+
 	tasklet_schedule(&info->tlet);
 }
 
@@ -487,6 +494,27 @@ static void uart_flush_chars(struct tty_
 	uart_start(tty);
 }
 
+static int uart_circ_write(struct circ_buf *circ, const unsigned char *buf,
+			   int count)
+{
+	int c, ret = 0;
+
+	while (1) {
+		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
+		if (count < c)
+			c = count;
+		if (c <= 0)
+			break;
+		memcpy(circ->buf + circ->head, buf, c);
+		circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
+		buf += c;
+		count -= c;
+		ret += c;
+	}
+
+	return ret;
+}
+
 static int
 uart_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
@@ -494,7 +522,7 @@ uart_write(struct tty_struct *tty, const
 	struct uart_port *port;
 	struct circ_buf *circ;
 	unsigned long flags;
-	int c, ret = 0;
+	int ret;
 
 	/*
 	 * This means you called this function _after_ the port was
@@ -512,18 +540,7 @@ uart_write(struct tty_struct *tty, const
 		return 0;
 
 	spin_lock_irqsave(&port->lock, flags);
-	while (1) {
-		c = CIRC_SPACE_TO_END(circ->head, circ->tail, UART_XMIT_SIZE);
-		if (count < c)
-			c = count;
-		if (c <= 0)
-			break;
-		memcpy(circ->buf + circ->head, buf, c);
-		circ->head = (circ->head + c) & (UART_XMIT_SIZE - 1);
-		buf += c;
-		count -= c;
-		ret += c;
-	}
+	ret = uart_circ_write(circ, buf, count);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	uart_start(tty);
@@ -1300,6 +1317,9 @@ static void uart_close(struct tty_struct
 	 * Wake up anyone trying to open this port.
 	 */
 	state->info->flags &= ~UIF_NORMAL_ACTIVE;
+	spin_lock_irq(&state->port->lock);
+	port->flags &= ~UPF_INUSE_NORMAL;
+	spin_unlock_irq(&state->port->lock);
 	wake_up_interruptible(&state->info->open_wait);
 
  done:
@@ -1436,6 +1456,7 @@ uart_block_til_ready(struct file *filp, 
 	struct uart_info *info = state->info;
 	struct uart_port *port = state->port;
 	unsigned int mctrl;
+	int retval = 0;
 
 	info->blocked_open++;
 	state->count--;
@@ -1496,6 +1517,22 @@ uart_block_til_ready(struct file *filp, 
 
 		if (signal_pending(current))
 			break;
+
+		/*
+		 * The UPF_INUSE_NORMAL flag may have been cleared
+		 * while we were waiting on the port.  Make sure the
+		 * that the port wasn't grabbed by a direct user and
+		 * that the UPF_INUSE_NORMAL flags is set if we are
+		 * trying to grab the port now.
+		 */
+		spin_lock_irq(&state->port->lock);
+		if (port->flags & UPF_INUSE_DIRECT) {
+			spin_unlock_irq(&state->port->lock);
+			retval = -EAGAIN;
+			break;
+		}
+		port->flags |= UPF_INUSE_NORMAL;
+		spin_unlock_irq(&state->port->lock);
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
@@ -1504,12 +1541,11 @@ uart_block_til_ready(struct file *filp, 
 	info->blocked_open--;
 
 	if (signal_pending(current))
-		return -ERESTARTSYS;
-
-	if (!info->tty || tty_hung_up_p(filp))
-		return -EAGAIN;
+		retval = -ERESTARTSYS;
+	else if (!info->tty || tty_hung_up_p(filp))
+		retval = -EAGAIN;
 
-	return 0;
+	return retval;
 }
 
 static struct uart_state *uart_get(struct uart_driver *drv, int line)
@@ -1529,6 +1565,15 @@ static struct uart_state *uart_get(struc
 		goto err_unlock;
 	}
 
+	spin_lock_irq(&state->port->lock);
+	if (state->port->flags & UPF_INUSE_DIRECT) {
+		spin_unlock_irq(&state->port->lock);
+		ret = -EAGAIN;
+		goto err_unlock;
+	}
+	state->port->flags |= UPF_INUSE_NORMAL;
+	spin_unlock_irq(&state->port->lock);
+
 	if (!state->info) {
 		/*
 		 * This code is convoluted because the console code
@@ -1543,7 +1588,7 @@ static struct uart_state *uart_get(struc
 					      GFP_KERNEL);
 			if (!state->info) {
 				ret = -ENOMEM;
-				goto err_unlock;
+				goto err_unlock_release;
 			}
 
 			init_waitqueue_head(&state->info->open_wait);
@@ -1564,6 +1609,10 @@ static struct uart_state *uart_get(struc
 	}
 	return state;
 
+ err_unlock_release:
+	spin_lock_irq(&state->port->lock);
+	state->port->flags &= ~UPF_INUSE_NORMAL;
+	spin_unlock_irq(&state->port->lock);
  err_unlock:
 	state->count--;
 	mutex_unlock(&state->mutex);
@@ -1648,6 +1697,16 @@ static int uart_open(struct tty_struct *
 	 */
 	if (retval == 0)
 		retval = uart_block_til_ready(filp, state);
+
+	spin_lock_irq(&state->port->lock);
+	if (retval && (state->port->flags & UPF_INUSE_NORMAL))
+		/*
+		 * The block failed, make sure that the inuse flag is
+		 * cleared.
+		 */
+		state->port->flags &= ~UPF_INUSE_NORMAL;
+	spin_unlock_irq(&state->port->lock);
+
 	mutex_unlock(&state->mutex);
 
 	/*
@@ -2337,6 +2396,132 @@ static const struct tty_operations uart_
 	.tiocmset	= uart_tiocmset,
 };
 
+/*
+ * Holds a list of poll-capable uart drivers, so that polled driver
+ * users can look them up.
+ */
+static LIST_HEAD(polled_list);
+static DEFINE_MUTEX(polled_list_lock);
+
+#define PORT_INUSE (UPF_INUSE_NORMAL | UPF_INUSE_DIRECT)
+
+/**
+ *	uart_get_direct_port - Directly get a port for use
+ *	@name: The name to search for
+ *	@line: The line number to reserve
+ *      @force: If true, get the port even if it is in use already.
+ *
+ *	Find and reserve (if found) a serial port.  This is so things
+ *	like device drivers and debuggers can directly reserve a
+ *	serial port.  The force options is the serial port can be
+ *	taken over even while in use.  If the force option is set, it
+ *	is assumed that the system is in a stopped state and nothing
+ *	else will be touching the port until the debugger returns it.
+ */
+struct uart_port *uart_get_direct_port(char *name, int line, int force)
+{
+	struct uart_driver *drv;
+	struct uart_port *port = NULL;
+	unsigned long flags = 0;
+
+	if (!force)
+		mutex_lock(&polled_list_lock);
+	list_for_each_entry(drv, &polled_list, polled_link) {
+		if (strcmp(drv->dev_name, name) == 0) {
+			if (line < drv->nr_pollable
+						&& drv->pollable_ports[line])
+				port = drv->pollable_ports[line];
+			else
+				break;
+			if (!try_module_get(drv->owner)) {
+				port = NULL;
+				break;
+			}
+			if (!force)
+				spin_lock_irqsave(&port->lock, flags);
+			if (!force && port->flags & PORT_INUSE) {
+				spin_unlock_irqrestore(&port->lock, flags);
+				module_put(drv->owner);
+				port = NULL;
+				break;
+			}
+			port->flags |= UPF_INUSE_DIRECT;
+			if (!force)
+				spin_unlock_irqrestore(&port->lock, flags);
+			break;
+		}
+	}
+	if (!force)
+		mutex_unlock(&polled_list_lock);
+
+	return port;
+}
+
+/**
+ *	uart_put_direct_port - Release a port reserved for direct use.
+ *	@port: The port to release
+ *      @force: If true, free the port even if it is in use already.
+ *
+ *	Free a port that was previously returned by uart_get_direct_port.
+ *	If you specified force in the get, you should do so in the put.
+ */
+int uart_put_direct_port(struct uart_port *port, int force)
+{
+	struct uart_driver *drv;
+	unsigned long flags = 0;
+	int i;
+	int retval = -EINVAL;
+
+	if (!force)
+		mutex_lock(&polled_list_lock);
+	list_for_each_entry(drv, &polled_list, polled_link) {
+		for (i = 0; i < drv->nr_pollable; i++) {
+			if (drv->pollable_ports[i] == port) {
+				if (!force)
+					spin_lock_irqsave(&port->lock, flags);
+				port->flags &= ~UPF_INUSE_DIRECT;
+				if (!force)
+					spin_unlock_irqrestore(&port->lock,
+							       flags);
+				module_put(drv->owner);
+				retval = 0;
+				goto out_unlock;
+			}
+		}
+	}
+ out_unlock:
+	if (!force)
+		mutex_unlock(&polled_list_lock);
+
+	return retval;
+}
+
+/**
+ *	uart_direct_write - Write data as a direct serial user
+ *	@port: The port to write on
+ *	@buf: The data to write
+ *	@count: The number of bytes to write.
+ *
+ *	Write bytes to a serial port that is reserved with the
+ *	uart_get_direct_port() function.  This is non-blocking and
+ *	will return the number of bytes actually written.
+ */
+int
+uart_direct_write(struct uart_port *port, const unsigned char *buf, int count)
+{
+	struct circ_buf *circ;
+	unsigned long flags;
+	int ret;
+
+	circ = &port->info->xmit;
+	spin_lock_irqsave(&port->lock, flags);
+	ret = uart_circ_write(circ, buf, count);
+	if (ret > 0)
+		port->ops->start_tx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
+	return ret;
+}
+
 /**
  *	uart_register_polled - register a driver to be used as a polled device
  *	@drv: low level driver structure
@@ -2347,6 +2532,10 @@ static const struct tty_operations uart_
  */
 void uart_register_polled(struct uart_driver *drv)
 {
+	mutex_lock(&polled_list_lock);
+	list_add_tail(&drv->polled_link, &polled_list);
+	mutex_unlock(&polled_list_lock);
+
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
 	if (drv->nr_pollable && drv->cons) {
 		/* We manage the consoles for this driver. */
@@ -2373,6 +2562,10 @@ void uart_unregister_polled(struct uart_
 		unregister_console(drv->cons);
 	}
 #endif
+
+	mutex_lock(&polled_list_lock);
+	list_del(&drv->polled_link);
+	mutex_unlock(&polled_list_lock);
 }
 
 /**
@@ -2656,6 +2849,9 @@ EXPORT_SYMBOL(uart_suspend_port);
 EXPORT_SYMBOL(uart_resume_port);
 EXPORT_SYMBOL(uart_add_one_port);
 EXPORT_SYMBOL(uart_remove_one_port);
+EXPORT_SYMBOL(uart_get_direct_port);
+EXPORT_SYMBOL(uart_put_direct_port);
+EXPORT_SYMBOL(uart_direct_write);
 
 MODULE_DESCRIPTION("Serial driver core");
 MODULE_LICENSE("GPL");
Index: linux-2.6.21/include/linux/serial_core.h
===================================================================
--- linux-2.6.21.orig/include/linux/serial_core.h
+++ linux-2.6.21/include/linux/serial_core.h
@@ -295,6 +295,11 @@ struct uart_port {
 
 	upf_t			flags;
 
+/*
+ * The port lock protects UPF_INUSE_DIRECT and UPF_INUSE_NORMAL.  One
+ * of those two bits must be set before any other bits can be changed
+ * in port->flags.
+ */
 #define UPF_FOURPORT		((__force upf_t) (1 << 1))
 #define UPF_SAK			((__force upf_t) (1 << 2))
 #define UPF_SPD_MASK		((__force upf_t) (0x1030))
@@ -311,7 +316,9 @@ struct uart_port {
 #define UPF_MAGIC_MULTIPLIER	((__force upf_t) (1 << 16))
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))
+#define UPF_INUSE_NORMAL	((__force uif_t) (1 << 27))
 #define UPF_BOOT_AUTOCONF	((__force upf_t) (1 << 28))
+#define UPF_INUSE_DIRECT	((__force uif_t) (1 << 29))
 #define UPF_DEAD		((__force upf_t) (1 << 30))
 #define UPF_IOREMAP		((__force upf_t) (1 << 31))
 
@@ -352,6 +359,44 @@ struct uart_state {
 
 #define UART_XMIT_SIZE	PAGE_SIZE
 
+/*
+ * Structure used by the direct uart driver.
+ */
+struct uart_direct {
+	/* Generic data for use by the layered driver. */
+	void *direct_data;
+
+	/*
+	 * Port status, called with the port lock held.
+	 */
+	int (*handle_break)(struct uart_port *port);
+	void (*handle_dcd_change)(struct uart_port *port, unsigned int status);
+	void (*handle_cts_change)(struct uart_port *port, unsigned int status);
+
+	/*
+	 * A receive character from the port.  Called with the port
+	 * lock held, buffer and use the "push" function to actually
+	 * handle the characters.
+	 */
+	void (*handle_char)(struct uart_port *port, unsigned int status,
+			    unsigned int overrun, unsigned int ch,
+			    unsigned int flag);
+
+	/*
+	 * Done receiving characters for now, called with the port
+	 * lock not held.
+	 */
+	void (*push)(struct uart_port *port);
+
+	/*
+	 * MSR values changed, called with the port lock not held.
+	 */
+	void (*push_msr)(struct uart_port *port);
+
+	/* Might be ready to transmit more characters. */
+	void (*tx_ready)(struct uart_port *port);
+};
+
 typedef unsigned int __bitwise__ uif_t;
 
 /*
@@ -383,6 +428,9 @@ struct uart_info {
 
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	delta_msr_wait;
+
+	/* For the direct serial interface */
+	struct uart_direct	*direct;
 };
 
 /* number of characters left in xmit buffer before we ask for more */
@@ -418,6 +466,7 @@ struct uart_driver {
 	 */
 	struct uart_state	*state;
 	struct tty_driver	*tty_driver;
+	struct list_head        polled_link;
 };
 
 void uart_write_wakeup(struct uart_port *port);
@@ -458,6 +507,14 @@ int uart_remove_one_port(struct uart_dri
 int uart_match_port(struct uart_port *port1, struct uart_port *port2);
 
 /*
+ * Direct serial port access.
+ */
+struct uart_port *uart_get_direct_port(char *name, int line, int force);
+int uart_put_direct_port(struct uart_port *port, int force);
+int uart_direct_write(struct uart_port *port, const unsigned char *buf,
+		      int count);
+
+/*
  * Power Management
  */
 int uart_suspend_port(struct uart_driver *reg, struct uart_port *port);
@@ -509,6 +566,13 @@ uart_handle_sysrq_char(struct uart_port 
 static inline int uart_handle_break(struct uart_port *port)
 {
 	struct uart_info *info = port->info;
+
+	if (info->direct) {
+		if (info->direct->handle_break)
+			info->direct->handle_break(port);
+		return 0;
+	}
+
 #ifdef SUPPORT_SYSRQ
 	if (port->cons && port->cons->index == port->line) {
 		if (!port->sysrq) {
@@ -531,7 +595,13 @@ static inline int uart_handle_break(stru
 static inline void
 uart_handle_dcd_change(struct uart_port *port, unsigned int status)
 {
-	struct uart_info *info = port->info;
+	struct uart_info *info = port->info;;
+
+	if (info->direct) {
+		if (info->direct->handle_dcd_change)
+			info->direct->handle_dcd_change(port, status);
+		return;
+	}
 
 	port->icount.dcd++;
 
@@ -557,7 +627,15 @@ static inline void
 uart_handle_cts_change(struct uart_port *port, unsigned int status)
 {
 	struct uart_info *info = port->info;
-	struct tty_struct *tty = info->tty;
+	struct tty_struct *tty;
+
+	if (info->direct) {
+		if (info->direct->handle_cts_change)
+			info->direct->handle_cts_change(port, status);
+		return;
+	}
+
+	tty = info->tty;
 
 	port->icount.cts++;
 
@@ -583,7 +661,17 @@ static inline void
 uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag)
 {
-	struct tty_struct *tty = port->info->tty;
+	struct uart_info *info = port->info;
+	struct tty_struct *tty;
+
+	if (info->direct) {
+		if (info->direct->handle_char)
+			info->direct->handle_char(port, status, overrun,
+						  ch, flag);
+		return;
+	}
+
+	tty = info->tty;
 
 	if (!tty)
 		return;
@@ -602,16 +690,31 @@ uart_insert_char(struct uart_port *port,
 static inline void
 uart_push(struct uart_port *port)
 {
-	if (!port->info->tty)
+	struct uart_info *info = port->info;
+
+	if (info->direct) {
+		if (info->direct->push)
+			info->direct->push(port);
+		return;
+	}
+
+	if (!info->tty)
 		return;
 
-	tty_flip_buffer_push(port->info->tty);
+	tty_flip_buffer_push(info->tty);
 }
 
 static inline void
 uart_msr_change(struct uart_port *port)
 {
-	wake_up_interruptible(&port->info->delta_msr_wait);
+	struct uart_info *info = port->info;
+
+	if (info->direct) {
+		if (info->direct->push_msr)
+			info->direct->push_msr(port);
+		return;
+	}
+	wake_up_interruptible(&info->delta_msr_wait);
 }
 
 /*
