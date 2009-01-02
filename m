From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 65/75] tty: We want the port object to be persistent
Date: Fri, 02 Jan 2009 13:49:21 +0000
Message-ID: <20090102134918.13472.41915.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37674 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755688AbZABNtL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:49:11 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Move the tty_port and uart_info bits around a little. By embedding the uart_info
into the uart_port we get rid of lots of corner case testing and also get the
ability to go port<->state<->info which is a bit more elegant than the current
data structures.

Downsides - we allocate a tiny bit more memory for unused ports, upside we've
removed as much code as it saved for most users..

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/serial/jsm/jsm_tty.c |    2 -
 drivers/serial/serial_core.c |  144 ++++++++++++++++++------------------------
 include/linux/serial_core.h  |   62 ++++++++++--------
 3 files changed, 96 insertions(+), 112 deletions(-)


diff --git a/drivers/serial/jsm/jsm_tty.c b/drivers/serial/jsm/jsm_tty.c
index a697914..3547558 100644
--- a/drivers/serial/jsm/jsm_tty.c
+++ b/drivers/serial/jsm/jsm_tty.c
@@ -272,7 +272,7 @@ static void jsm_tty_close(struct uart_port *port)
 	jsm_printk(CLOSE, INFO, &channel->ch_bd->pci_dev, "start\n");
 
 	bd = channel->ch_bd;
-	ts = channel->uart_port.info->port.tty->termios;
+	ts = port->info->port.tty->termios;
 
 	channel->ch_flags &= ~(CH_STOPI);
 
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 874786a..daeba1c 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -50,7 +50,7 @@ static struct lock_class_key port_lock_key;
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
-#define uart_users(state)	((state)->count + ((state)->info ? (state)->info->port.blocked_open : 0))
+#define uart_users(state)	((state)->count + (state)->info.port.blocked_open)
 
 #ifdef CONFIG_SERIAL_CORE_CONSOLE
 #define uart_console(port)	((port)->cons && (port)->cons->index == (port)->line)
@@ -94,7 +94,7 @@ static void __uart_start(struct tty_struct *tty)
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->port;
 
-	if (!uart_circ_empty(&state->info->xmit) && state->info->xmit.buf &&
+	if (!uart_circ_empty(&state->info.xmit) && state->info.xmit.buf &&
 	    !tty->stopped && !tty->hw_stopped)
 		port->ops->start_tx(port);
 }
@@ -113,7 +113,7 @@ static void uart_start(struct tty_struct *tty)
 static void uart_tasklet_action(unsigned long data)
 {
 	struct uart_state *state = (struct uart_state *)data;
-	tty_wakeup(state->info->port.tty);
+	tty_wakeup(state->info.port.tty);
 }
 
 static inline void
@@ -139,7 +139,7 @@ uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
  */
 static int uart_startup(struct uart_state *state, int init_hw)
 {
-	struct uart_info *info = state->info;
+	struct uart_info *info = &state->info;
 	struct uart_port *port = state->port;
 	unsigned long page;
 	int retval = 0;
@@ -212,14 +212,15 @@ static int uart_startup(struct uart_state *state, int init_hw)
  */
 static void uart_shutdown(struct uart_state *state)
 {
-	struct uart_info *info = state->info;
+	struct uart_info *info = &state->info;
 	struct uart_port *port = state->port;
+	struct tty_struct *tty = info->port.tty;
 
 	/*
 	 * Set the TTY IO error marker
 	 */
-	if (info->port.tty)
-		set_bit(TTY_IO_ERROR, &info->port.tty->flags);
+	if (tty)
+		set_bit(TTY_IO_ERROR, &tty->flags);
 
 	if (info->flags & UIF_INITIALIZED) {
 		info->flags &= ~UIF_INITIALIZED;
@@ -227,7 +228,7 @@ static void uart_shutdown(struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
-		if (!info->port.tty || (info->port.tty->termios->c_cflag & HUPCL))
+		if (!tty || (tty->termios->c_cflag & HUPCL))
 			uart_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 
 		/*
@@ -427,7 +428,7 @@ EXPORT_SYMBOL(uart_get_divisor);
 static void
 uart_change_speed(struct uart_state *state, struct ktermios *old_termios)
 {
-	struct tty_struct *tty = state->info->port.tty;
+	struct tty_struct *tty = state->info.port.tty;
 	struct uart_port *port = state->port;
 	struct ktermios *termios;
 
@@ -444,14 +445,14 @@ uart_change_speed(struct uart_state *state, struct ktermios *old_termios)
 	 * Set flags based on termios cflag
 	 */
 	if (termios->c_cflag & CRTSCTS)
-		state->info->flags |= UIF_CTS_FLOW;
+		state->info.flags |= UIF_CTS_FLOW;
 	else
-		state->info->flags &= ~UIF_CTS_FLOW;
+		state->info.flags &= ~UIF_CTS_FLOW;
 
 	if (termios->c_cflag & CLOCAL)
-		state->info->flags &= ~UIF_CHECK_CD;
+		state->info.flags &= ~UIF_CHECK_CD;
 	else
-		state->info->flags |= UIF_CHECK_CD;
+		state->info.flags |= UIF_CHECK_CD;
 
 	port->ops->set_termios(port, termios, old_termios);
 }
@@ -479,7 +480,7 @@ static int uart_put_char(struct tty_struct *tty, unsigned char ch)
 {
 	struct uart_state *state = tty->driver_data;
 
-	return __uart_put_char(state->port, &state->info->xmit, ch);
+	return __uart_put_char(state->port, &state->info.xmit, ch);
 }
 
 static void uart_flush_chars(struct tty_struct *tty)
@@ -500,13 +501,13 @@ uart_write(struct tty_struct *tty, const unsigned char *buf, int count)
 	 * This means you called this function _after_ the port was
 	 * closed.  No cookie for you.
 	 */
-	if (!state || !state->info) {
+	if (!state) {
 		WARN_ON(1);
 		return -EL3HLT;
 	}
 
 	port = state->port;
-	circ = &state->info->xmit;
+	circ = &state->info.xmit;
 
 	if (!circ->buf)
 		return 0;
@@ -537,7 +538,7 @@ static int uart_write_room(struct tty_struct *tty)
 	int ret;
 
 	spin_lock_irqsave(&state->port->lock, flags);
-	ret = uart_circ_chars_free(&state->info->xmit);
+	ret = uart_circ_chars_free(&state->info.xmit);
 	spin_unlock_irqrestore(&state->port->lock, flags);
 	return ret;
 }
@@ -549,7 +550,7 @@ static int uart_chars_in_buffer(struct tty_struct *tty)
 	int ret;
 
 	spin_lock_irqsave(&state->port->lock, flags);
-	ret = uart_circ_chars_pending(&state->info->xmit);
+	ret = uart_circ_chars_pending(&state->info.xmit);
 	spin_unlock_irqrestore(&state->port->lock, flags);
 	return ret;
 }
@@ -564,7 +565,7 @@ static void uart_flush_buffer(struct tty_struct *tty)
 	 * This means you called this function _after_ the port was
 	 * closed.  No cookie for you.
 	 */
-	if (!state || !state->info) {
+	if (!state) {
 		WARN_ON(1);
 		return;
 	}
@@ -573,7 +574,7 @@ static void uart_flush_buffer(struct tty_struct *tty)
 	pr_debug("uart_flush_buffer(%d) called\n", tty->index);
 
 	spin_lock_irqsave(&port->lock, flags);
-	uart_circ_clear(&state->info->xmit);
+	uart_circ_clear(&state->info.xmit);
 	if (port->ops->flush_buffer)
 		port->ops->flush_buffer(port);
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -837,15 +838,15 @@ static int uart_set_info(struct uart_state *state,
 	state->closing_wait    = closing_wait;
 	if (new_serial.xmit_fifo_size)
 		port->fifosize = new_serial.xmit_fifo_size;
-	if (state->info->port.tty)
-		state->info->port.tty->low_latency =
+	if (state->info.port.tty)
+		state->info.port.tty->low_latency =
 			(port->flags & UPF_LOW_LATENCY) ? 1 : 0;
 
  check_and_exit:
 	retval = 0;
 	if (port->type == PORT_UNKNOWN)
 		goto exit;
-	if (state->info->flags & UIF_INITIALIZED) {
+	if (state->info.flags & UIF_INITIALIZED) {
 		if (((old_flags ^ port->flags) & UPF_SPD_MASK) ||
 		    old_custom_divisor != port->custom_divisor) {
 			/*
@@ -858,7 +859,7 @@ static int uart_set_info(struct uart_state *state,
 				printk(KERN_NOTICE
 				       "%s sets custom speed on %s. This "
 				       "is deprecated.\n", current->comm,
-				       tty_name(state->info->port.tty, buf));
+				       tty_name(state->info.port.tty, buf));
 			}
 			uart_change_speed(state, NULL);
 		}
@@ -889,8 +890,8 @@ static int uart_get_lsr_info(struct uart_state *state,
 	 * interrupt happens).
 	 */
 	if (port->x_char ||
-	    ((uart_circ_chars_pending(&state->info->xmit) > 0) &&
-	     !state->info->port.tty->stopped && !state->info->port.tty->hw_stopped))
+	    ((uart_circ_chars_pending(&state->info.xmit) > 0) &&
+	     !state->info.port.tty->stopped && !state->info.port.tty->hw_stopped))
 		result &= ~TIOCSER_TEMT;
 
 	return put_user(result, value);
@@ -1017,7 +1018,7 @@ uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	port->ops->enable_ms(port);
 	spin_unlock_irq(&port->lock);
 
-	add_wait_queue(&state->info->delta_msr_wait, &wait);
+	add_wait_queue(&state->info.delta_msr_wait, &wait);
 	for (;;) {
 		spin_lock_irq(&port->lock);
 		memcpy(&cnow, &port->icount, sizeof(struct uart_icount));
@@ -1045,7 +1046,7 @@ uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	}
 
 	current->state = TASK_RUNNING;
-	remove_wait_queue(&state->info->delta_msr_wait, &wait);
+	remove_wait_queue(&state->info.delta_msr_wait, &wait);
 
 	return ret;
 }
@@ -1241,7 +1242,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	 */
 	if (!(old_termios->c_cflag & CLOCAL) &&
 	    (tty->termios->c_cflag & CLOCAL))
-		wake_up_interruptible(&state->info->port.open_wait);
+		wake_up_interruptible(&info->port.open_wait);
 #endif
 }
 
@@ -1303,7 +1304,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	 * At this point, we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts.
 	 */
-	if (state->info->flags & UIF_INITIALIZED) {
+	if (state->info.flags & UIF_INITIALIZED) {
 		unsigned long flags;
 		spin_lock_irqsave(&port->lock, flags);
 		port->ops->stop_rx(port);
@@ -1322,9 +1323,9 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	tty_ldisc_flush(tty);
 
 	tty->closing = 0;
-	state->info->port.tty = NULL;
+	state->info.port.tty = NULL;
 
-	if (state->info->port.blocked_open) {
+	if (state->info.port.blocked_open) {
 		if (state->close_delay)
 			msleep_interruptible(state->close_delay);
 	} else if (!uart_console(port)) {
@@ -1334,8 +1335,8 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	/*
 	 * Wake up anyone trying to open this port.
 	 */
-	state->info->flags &= ~UIF_NORMAL_ACTIVE;
-	wake_up_interruptible(&state->info->port.open_wait);
+	state->info.flags &= ~UIF_NORMAL_ACTIVE;
+	wake_up_interruptible(&state->info.port.open_wait);
 
  done:
 	mutex_unlock(&state->mutex);
@@ -1409,19 +1410,20 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 static void uart_hangup(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
+	struct uart_info *info = &state->info;
 
 	BUG_ON(!kernel_locked());
 	pr_debug("uart_hangup(%d)\n", state->port->line);
 
 	mutex_lock(&state->mutex);
-	if (state->info && state->info->flags & UIF_NORMAL_ACTIVE) {
+	if (info->flags & UIF_NORMAL_ACTIVE) {
 		uart_flush_buffer(tty);
 		uart_shutdown(state);
 		state->count = 0;
-		state->info->flags &= ~UIF_NORMAL_ACTIVE;
-		state->info->port.tty = NULL;
-		wake_up_interruptible(&state->info->port.open_wait);
-		wake_up_interruptible(&state->info->delta_msr_wait);
+		info->flags &= ~UIF_NORMAL_ACTIVE;
+		info->port.tty = NULL;
+		wake_up_interruptible(&info->port.open_wait);
+		wake_up_interruptible(&info->delta_msr_wait);
 	}
 	mutex_unlock(&state->mutex);
 }
@@ -1434,7 +1436,7 @@ static void uart_hangup(struct tty_struct *tty)
  */
 static void uart_update_termios(struct uart_state *state)
 {
-	struct tty_struct *tty = state->info->port.tty;
+	struct tty_struct *tty = state->info.port.tty;
 	struct uart_port *port = state->port;
 
 	if (uart_console(port) && port->cons->cflag) {
@@ -1469,7 +1471,7 @@ static int
 uart_block_til_ready(struct file *filp, struct uart_state *state)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	struct uart_info *info = state->info;
+	struct uart_info *info = &state->info;
 	struct uart_port *port = state->port;
 	unsigned int mctrl;
 
@@ -1563,28 +1565,6 @@ static struct uart_state *uart_get(struct uart_driver *drv, int line)
 		ret = -ENXIO;
 		goto err_unlock;
 	}
-
-	/* BKL: RACE HERE - LEAK */
-	/* We should move this into the uart_state structure and kill off
-	   this whole complexity */
-	if (!state->info) {
-		state->info = kzalloc(sizeof(struct uart_info), GFP_KERNEL);
-		if (state->info) {
-			init_waitqueue_head(&state->info->port.open_wait);
-			init_waitqueue_head(&state->info->delta_msr_wait);
-
-			/*
-			 * Link the info into the other structures.
-			 */
-			state->port->info = state->info;
-
-			tasklet_init(&state->info->tlet, uart_tasklet_action,
-				     (unsigned long)state);
-		} else {
-			ret = -ENOMEM;
-			goto err_unlock;
-		}
-	}
 	return state;
 
  err_unlock:
@@ -1641,9 +1621,10 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
 	 * Any failures from here onwards should not touch the count.
 	 */
 	tty->driver_data = state;
+	state->port->info = &state->info;
 	tty->low_latency = (state->port->flags & UPF_LOW_LATENCY) ? 1 : 0;
 	tty->alt_speed = 0;
-	state->info->port.tty = tty;
+	state->info.port.tty = tty;
 
 	/*
 	 * If the port is in the middle of closing, bail out now.
@@ -1676,8 +1657,8 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
 	/*
 	 * If this is the first open to succeed, adjust things to suit.
 	 */
-	if (retval == 0 && !(state->info->flags & UIF_NORMAL_ACTIVE)) {
-		state->info->flags |= UIF_NORMAL_ACTIVE;
+	if (retval == 0 && !(state->info.flags & UIF_NORMAL_ACTIVE)) {
+		state->info.flags |= UIF_NORMAL_ACTIVE;
 
 		uart_update_termios(state);
 	}
@@ -2028,11 +2009,11 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *port)
 	}
 	port->suspended = 1;
 
-	if (state->info && state->info->flags & UIF_INITIALIZED) {
+	if (state->info.flags & UIF_INITIALIZED) {
 		const struct uart_ops *ops = port->ops;
 		int tries;
 
-		state->info->flags = (state->info->flags & ~UIF_INITIALIZED)
+		state->info.flags = (state->info.flags & ~UIF_INITIALIZED)
 				     | UIF_SUSPENDED;
 
 		spin_lock_irq(&port->lock);
@@ -2107,15 +2088,15 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *port)
 		/*
 		 * If that's unset, use the tty termios setting.
 		 */
-		if (state->info && state->info->port.tty && termios.c_cflag == 0)
-			termios = *state->info->port.tty->termios;
+		if (state->info.port.tty && termios.c_cflag == 0)
+			termios = *state->info.port.tty->termios;
 
 		uart_change_pm(state, 0);
 		port->ops->set_termios(port, &termios, NULL);
 		console_start(port->cons);
 	}
 
-	if (state->info && state->info->flags & UIF_SUSPENDED) {
+	if (state->info.flags & UIF_SUSPENDED) {
 		const struct uart_ops *ops = port->ops;
 		int ret;
 
@@ -2130,7 +2111,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *port)
 			ops->set_mctrl(port, port->mctrl);
 			ops->start_tx(port);
 			spin_unlock_irq(&port->lock);
-			state->info->flags |= UIF_INITIALIZED;
+			state->info.flags |= UIF_INITIALIZED;
 		} else {
 			/*
 			 * Failed to resume - maybe hardware went away?
@@ -2140,7 +2121,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *port)
 			uart_shutdown(state);
 		}
 
-		state->info->flags &= ~UIF_SUSPENDED;
+		state->info.flags &= ~UIF_SUSPENDED;
 	}
 
 	mutex_unlock(&state->mutex);
@@ -2383,8 +2364,12 @@ int uart_register_driver(struct uart_driver *drv)
 
 		state->close_delay     = 500;	/* .5 seconds */
 		state->closing_wait    = 30000;	/* 30 seconds */
-
 		mutex_init(&state->mutex);
+
+		tty_port_init(&state->info.port);
+		init_waitqueue_head(&state->info.delta_msr_wait);
+		tasklet_init(&state->info.tlet, uart_tasklet_action,
+			     (unsigned long)state);
 	}
 
 	retval = tty_register_driver(normal);
@@ -2455,7 +2440,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *port)
 	state->pm_state = -1;
 
 	port->cons = drv->cons;
-	port->info = state->info;
+	port->info = &state->info;
 
 	/*
 	 * If this port is a console, then the spinlock is already
@@ -2527,18 +2512,11 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *port)
 	 */
 	tty_unregister_device(drv->tty_driver, port->line);
 
-	info = state->info;
+	info = &state->info;
 	if (info && info->port.tty)
 		tty_vhangup(info->port.tty);
 
 	/*
-	 * All users of this port should now be disconnected from
-	 * this driver, and the port shut down.  We should be the
-	 * only thread fiddling with this port from now on.
-	 */
-	state->info = NULL;
-
-	/*
 	 * Free the port IO and memory resources, if any.
 	 */
 	if (port->type != PORT_UNKNOWN)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index feb3b93..2395969 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -316,35 +316,13 @@ struct uart_port {
 };
 
 /*
- * This is the state information which is persistent across opens.
- * The low level driver must not to touch any elements contained
- * within.
- */
-struct uart_state {
-	unsigned int		close_delay;		/* msec */
-	unsigned int		closing_wait;		/* msec */
-
-#define USF_CLOSING_WAIT_INF	(0)
-#define USF_CLOSING_WAIT_NONE	(~0U)
-
-	int			count;
-	int			pm_state;
-	struct uart_info	*info;
-	struct uart_port	*port;
-
-	struct mutex		mutex;
-};
-
-#define UART_XMIT_SIZE	PAGE_SIZE
-
-typedef unsigned int __bitwise__ uif_t;
-
-/*
  * This is the state information which is only valid when the port
- * is open; it may be freed by the core driver once the device has
+ * is open; it may be cleared the core driver once the device has
  * been closed.  Either the low level driver or the core can modify
  * stuff here.
  */
+typedef unsigned int __bitwise__ uif_t;
+
 struct uart_info {
 	struct tty_port		port;
 	struct circ_buf		xmit;
@@ -366,6 +344,29 @@ struct uart_info {
 	wait_queue_head_t	delta_msr_wait;
 };
 
+/*
+ * This is the state information which is persistent across opens.
+ * The low level driver must not to touch any elements contained
+ * within.
+ */
+struct uart_state {
+	unsigned int		close_delay;		/* msec */
+	unsigned int		closing_wait;		/* msec */
+
+#define USF_CLOSING_WAIT_INF	(0)
+#define USF_CLOSING_WAIT_NONE	(~0U)
+
+	int			count;
+	int			pm_state;
+	struct uart_info	info;
+	struct uart_port	*port;
+
+	struct mutex		mutex;
+};
+
+#define UART_XMIT_SIZE	PAGE_SIZE
+
+
 /* number of characters left in xmit buffer before we ask for more */
 #define WAKEUP_CHARS		256
 
@@ -439,8 +440,13 @@ int uart_resume_port(struct uart_driver *reg, struct uart_port *port);
 #define uart_circ_chars_free(circ)	\
 	(CIRC_SPACE((circ)->head, (circ)->tail, UART_XMIT_SIZE))
 
-#define uart_tx_stopped(portp)		\
-	((portp)->info->port.tty->stopped || (portp)->info->port.tty->hw_stopped)
+static inline int uart_tx_stopped(struct uart_port *port)
+{
+	struct tty_struct *tty = port->info->port.tty;
+	if(tty->stopped || tty->hw_stopped)
+		return 1;
+	return 0;
+}
 
 /*
  * The following are helper functions for the low level drivers.
@@ -451,7 +457,7 @@ uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 #ifdef SUPPORT_SYSRQ
 	if (port->sysrq) {
 		if (ch && time_before(jiffies, port->sysrq)) {
-			handle_sysrq(ch, port->info ? port->info->port.tty : NULL);
+			handle_sysrq(ch, port->info->port.tty);
 			port->sysrq = 0;
 			return 1;
 		}

