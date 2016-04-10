From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 3/8] tty: Replace ASYNC_NORMAL_ACTIVE bit and update atomically
Date: Sat,  9 Apr 2016 17:53:22 -0700
Message-ID: <1460249607-8014-4-git-send-email-peter@hurleysoftware.com>
References: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Edwards <grant.b.edwards@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Replace ASYNC_NORMAL_ACTIVE bit in the tty_port::flags field with
TTY_PORT_ACTIVE bit in the tty_port::iflags field. Introduce helpers
tty_port_set_active() and tty_port_active() to abstract atomic bit ops.

Extract state changes from port lock sections, as this usage is
broken and confused; the state transitions are protected by the
tty lock (which mutually excludes parallel open/close/hangup),
and no user tests the active state while holding the port lock.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/isdn/i4l/isdn_tty.c      | 20 +++++++++-----------
 drivers/tty/amiserial.c          |  2 +-
 drivers/tty/rocket.c             |  5 +++--
 drivers/tty/serial/crisv10.c     |  8 ++++----
 drivers/tty/serial/serial_core.c |  8 ++++----
 drivers/tty/synclink.c           |  6 +++---
 drivers/tty/synclink_gt.c        |  6 +++---
 drivers/tty/synclinkmp.c         |  6 +++---
 drivers/tty/tty_port.c           | 12 ++++++------
 include/linux/tty.h              | 12 ++++++++++++
 net/irda/ircomm/ircomm_tty.c     | 10 +++++-----
 11 files changed, 53 insertions(+), 42 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index f1edc08..d8468f3 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1622,7 +1622,7 @@ isdn_tty_hangup(struct tty_struct *tty)
 		return;
 	isdn_tty_shutdown(info);
 	port->count = 0;
-	port->flags &= ~ASYNC_NORMAL_ACTIVE;
+	tty_port_set_active(port, 0);
 	port->tty = NULL;
 	wake_up_interruptible(&port->open_wait);
 }
@@ -1979,7 +1979,7 @@ isdn_tty_find_icall(int di, int ch, setup_parm *setup)
 #endif
 			if (
 #ifndef FIX_FILE_TRANSFER
-				(info->port.flags & ASYNC_NORMAL_ACTIVE) &&
+			    tty_port_active(&info->port) &&
 #endif
 				(info->isdn_driver == -1) &&
 				(info->isdn_channel == -1) &&
@@ -2018,8 +2018,6 @@ isdn_tty_find_icall(int di, int ch, setup_parm *setup)
 	return (wret == 2) ? 3 : 0;
 }
 
-#define TTY_IS_ACTIVE(info)	(info->port.flags & ASYNC_NORMAL_ACTIVE)
-
 int
 isdn_tty_stat_callback(int i, isdn_ctrl *c)
 {
@@ -2077,7 +2075,7 @@ isdn_tty_stat_callback(int i, isdn_ctrl *c)
 #ifdef ISDN_TTY_STAT_DEBUG
 			printk(KERN_DEBUG "tty_STAT_DCONN ttyI%d\n", info->line);
 #endif
-			if (TTY_IS_ACTIVE(info)) {
+			if (tty_port_active(&info->port)) {
 				if (info->dialing == 1) {
 					info->dialing = 2;
 					return 1;
@@ -2088,7 +2086,7 @@ isdn_tty_stat_callback(int i, isdn_ctrl *c)
 #ifdef ISDN_TTY_STAT_DEBUG
 			printk(KERN_DEBUG "tty_STAT_DHUP ttyI%d\n", info->line);
 #endif
-			if (TTY_IS_ACTIVE(info)) {
+			if (tty_port_active(&info->port)) {
 				if (info->dialing == 1)
 					isdn_tty_modem_result(RESULT_BUSY, info);
 				if (info->dialing > 1)
@@ -2118,7 +2116,7 @@ isdn_tty_stat_callback(int i, isdn_ctrl *c)
 			 * waiting for it and
 			 * set DCD-bit of its modem-status.
 			 */
-			if (TTY_IS_ACTIVE(info) ||
+			if (tty_port_active(&info->port) ||
 			    (info->port.blocked_open &&
 			     (info->emu.mdmreg[REG_DCD] & BIT_DCD))) {
 				info->msr |= UART_MSR_DCD;
@@ -2145,7 +2143,7 @@ isdn_tty_stat_callback(int i, isdn_ctrl *c)
 #ifdef ISDN_TTY_STAT_DEBUG
 			printk(KERN_DEBUG "tty_STAT_BHUP ttyI%d\n", info->line);
 #endif
-			if (TTY_IS_ACTIVE(info)) {
+			if (tty_port_active(&info->port)) {
 #ifdef ISDN_DEBUG_MODEM_HUP
 				printk(KERN_DEBUG "Mhup in ISDN_STAT_BHUP\n");
 #endif
@@ -2157,7 +2155,7 @@ isdn_tty_stat_callback(int i, isdn_ctrl *c)
 #ifdef ISDN_TTY_STAT_DEBUG
 			printk(KERN_DEBUG "tty_STAT_NODCH ttyI%d\n", info->line);
 #endif
-			if (TTY_IS_ACTIVE(info)) {
+			if (tty_port_active(&info->port)) {
 				if (info->dialing) {
 					info->dialing = 0;
 					info->last_l2 = -1;
@@ -2183,14 +2181,14 @@ isdn_tty_stat_callback(int i, isdn_ctrl *c)
 			return 1;
 #ifdef CONFIG_ISDN_TTY_FAX
 		case ISDN_STAT_FAXIND:
-			if (TTY_IS_ACTIVE(info)) {
+			if (tty_port_active(&info->port)) {
 				isdn_tty_fax_command(info, c);
 			}
 			break;
 #endif
 #ifdef CONFIG_ISDN_AUDIO
 		case ISDN_STAT_AUDIO:
-			if (TTY_IS_ACTIVE(info)) {
+			if (tty_port_active(&info->port)) {
 				switch (c->parm.num[0]) {
 				case ISDN_AUDIO_DTMF:
 					if (info->vonline) {
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 92717b0..80d6165 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1493,7 +1493,7 @@ static void rs_hangup(struct tty_struct *tty)
 	rs_flush_buffer(tty);
 	shutdown(tty, info);
 	info->tport.count = 0;
-	info->tport.flags &= ~ASYNC_NORMAL_ACTIVE;
+	tty_port_set_active(&info->tport, 0);
 	info->tport.tty = NULL;
 	wake_up_interruptible(&info->tport.open_wait);
 }
diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 0b802cd..eb8311b 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1042,9 +1042,10 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 		}
 	}
 	spin_lock_irq(&port->lock);
-	info->port.flags &= ~(ASYNC_INITIALIZED | ASYNC_NORMAL_ACTIVE);
+	port->flags &= ~ASYNC_INITIALIZED;
 	tty->closing = 0;
 	spin_unlock_irq(&port->lock);
+	tty_port_set_active(port, 0);
 	mutex_unlock(&port->mutex);
 	tty_port_tty_set(port, NULL);
 
@@ -1624,7 +1625,7 @@ static int rp_write(struct tty_struct *tty,
 	/*  Write remaining data into the port's xmit_buf */
 	while (1) {
 		/* Hung up ? */
-		if (!test_bit(ASYNCB_NORMAL_ACTIVE, &info->port.flags))
+		if (!tty_port_active(&info->port))
 			goto end;
 		c = min(count, XMIT_BUF_SIZE - info->xmit_cnt - 1);
 		c = min(c, XMIT_BUF_SIZE - info->xmit_head);
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 5469903..92c8c62 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -3648,8 +3648,8 @@ rs_close(struct tty_struct *tty, struct file * filp)
 			schedule_timeout_interruptible(info->port.close_delay);
 		wake_up_interruptible(&info->port.open_wait);
 	}
-	info->port.flags &= ~ASYNC_NORMAL_ACTIVE;
 	local_irq_restore(flags);
+	tty_port_set_active(&info->port, 0);
 
 	/* port closed */
 
@@ -3732,7 +3732,7 @@ rs_hangup(struct tty_struct *tty)
 	shutdown(info);
 	info->event = 0;
 	info->port.count = 0;
-	info->port.flags &= ~ASYNC_NORMAL_ACTIVE;
+	tty_port_set_active(&info->port, 0);
 	info->port.tty = NULL;
 	wake_up_interruptible(&info->port.open_wait);
 }
@@ -3756,7 +3756,7 @@ block_til_ready(struct tty_struct *tty, struct file * filp,
 	 * then make the check up front and then exit.
 	 */
 	if ((filp->f_flags & O_NONBLOCK) || tty_io_error(tty)) {
-		info->port.flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(&info->port, 1);
 		return 0;
 	}
 
@@ -3825,7 +3825,7 @@ block_til_ready(struct tty_struct *tty, struct file * filp,
 #endif
 	if (retval)
 		return retval;
-	info->port.flags |= ASYNC_NORMAL_ACTIVE;
+	tty_port_set_active(&info->port, 1);
 	return 0;
 }
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 64a5c00..2471380 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1418,12 +1418,12 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 		uart_change_pm(state, UART_PM_STATE_OFF);
 		spin_lock_irq(&port->lock);
 	}
+	spin_unlock_irq(&port->lock);
+	tty_port_set_active(port, 0);
 
 	/*
 	 * Wake up anyone trying to open this port.
 	 */
-	clear_bit(ASYNCB_NORMAL_ACTIVE, &port->flags);
-	spin_unlock_irq(&port->lock);
 	wake_up_interruptible(&port->open_wait);
 
 	mutex_unlock(&port->mutex);
@@ -1501,13 +1501,13 @@ static void uart_hangup(struct tty_struct *tty)
 	pr_debug("uart_hangup(%d)\n", tty->index);
 
 	mutex_lock(&port->mutex);
-	if (port->flags & ASYNC_NORMAL_ACTIVE) {
+	if (tty_port_active(port)) {
 		uart_flush_buffer(tty);
 		uart_shutdown(tty, state);
 		spin_lock_irqsave(&port->lock, flags);
 		port->count = 0;
-		clear_bit(ASYNCB_NORMAL_ACTIVE, &port->flags);
 		spin_unlock_irqrestore(&port->lock, flags);
+		tty_port_set_active(port, 0);
 		tty_port_tty_set(port, NULL);
 		if (!uart_console(state->uart_port))
 			uart_change_pm(state, UART_PM_STATE_OFF);
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 0e42901..b55f846 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -3201,7 +3201,7 @@ static void mgsl_hangup(struct tty_struct *tty)
 	shutdown(info);
 	
 	info->port.count = 0;	
-	info->port.flags &= ~ASYNC_NORMAL_ACTIVE;
+	tty_port_set_active(&info->port, 0);
 	info->port.tty = NULL;
 
 	wake_up_interruptible(&info->port.open_wait);
@@ -3269,7 +3269,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 
 	if (filp->f_flags & O_NONBLOCK || tty_io_error(tty)) {
 		/* nonblock mode is set or port is not enabled */
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 		return 0;
 	}
 
@@ -3338,7 +3338,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 			 __FILE__,__LINE__, tty->driver->name, port->count );
 			 
 	if (!retval)
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 		
 	return retval;
 	
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 5da69d3..c76f546 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -756,9 +756,9 @@ static void hangup(struct tty_struct *tty)
 
 	spin_lock_irqsave(&info->port.lock, flags);
 	info->port.count = 0;
-	info->port.flags &= ~ASYNC_NORMAL_ACTIVE;
 	info->port.tty = NULL;
 	spin_unlock_irqrestore(&info->port.lock, flags);
+	tty_port_set_active(&info->port, 0);
 	mutex_unlock(&info->port.mutex);
 
 	wake_up_interruptible(&info->port.open_wait);
@@ -3268,7 +3268,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 
 	if (filp->f_flags & O_NONBLOCK || tty_io_error(tty)) {
 		/* nonblock mode is set or port is not enabled */
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 		return 0;
 	}
 
@@ -3325,7 +3325,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	port->blocked_open--;
 
 	if (!retval)
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 
 	DBGINFO(("%s block_til_ready ready, rc=%d\n", tty->driver->name, retval));
 	return retval;
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 7a21491..95eddc4 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -849,9 +849,9 @@ static void hangup(struct tty_struct *tty)
 
 	spin_lock_irqsave(&info->port.lock, flags);
 	info->port.count = 0;
-	info->port.flags &= ~ASYNC_NORMAL_ACTIVE;
 	info->port.tty = NULL;
 	spin_unlock_irqrestore(&info->port.lock, flags);
+	tty_port_set_active(&info->port, 1);
 	mutex_unlock(&info->port.mutex);
 
 	wake_up_interruptible(&info->port.open_wait);
@@ -3285,7 +3285,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	if (filp->f_flags & O_NONBLOCK || tty_io_error(tty)) {
 		/* nonblock mode is set or port is not enabled */
 		/* just verify that callout device is not active */
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 		return 0;
 	}
 
@@ -3352,7 +3352,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 			 __FILE__,__LINE__, tty->driver->name, port->count );
 
 	if (!retval)
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 
 	return retval;
 }
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 9127c54..130c8cf 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -236,12 +236,12 @@ void tty_port_hangup(struct tty_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 	port->count = 0;
-	port->flags &= ~ASYNC_NORMAL_ACTIVE;
 	tty = port->tty;
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 	port->tty = NULL;
 	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_set_active(port, 0);
 	tty_port_shutdown(port, tty);
 	tty_kref_put(tty);
 	wake_up_interruptible(&port->open_wait);
@@ -365,14 +365,14 @@ int tty_port_block_til_ready(struct tty_port *port,
 	/* if non-blocking mode is set we can pass directly to open unless
 	   the port has just hung up or is in another error state */
 	if (tty_io_error(tty)) {
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 		return 0;
 	}
 	if (filp->f_flags & O_NONBLOCK) {
 		/* Indicate we are open */
 		if (C_BAUD(tty))
 			tty_port_raise_dtr_rts(port);
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 		return 0;
 	}
 
@@ -430,9 +430,9 @@ int tty_port_block_til_ready(struct tty_port *port,
 	if (!tty_hung_up_p(filp))
 		port->count++;
 	port->blocked_open--;
-	if (retval == 0)
-		port->flags |= ASYNC_NORMAL_ACTIVE;
 	spin_unlock_irqrestore(&port->lock, flags);
+	if (retval == 0)
+		tty_port_set_active(port, 1);
 	return retval;
 }
 EXPORT_SYMBOL(tty_port_block_til_ready);
@@ -514,8 +514,8 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 		spin_lock_irqsave(&port->lock, flags);
 		wake_up_interruptible(&port->open_wait);
 	}
-	port->flags &= ~ASYNC_NORMAL_ACTIVE;
 	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_set_active(port, 0);
 }
 EXPORT_SYMBOL(tty_port_close_end);
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 989d755b..dbeeb86 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -571,6 +571,18 @@ static inline void tty_port_set_cts_flow(struct tty_port *port, bool val)
 		clear_bit(TTY_PORT_CTS_FLOW, &port->iflags);
 }
 
+static inline bool tty_port_active(struct tty_port *port)
+{
+	return test_bit(TTY_PORT_ACTIVE, &port->iflags);
+}
+
+static inline void tty_port_set_active(struct tty_port *port, bool val)
+{
+	if (val)
+		set_bit(TTY_PORT_ACTIVE, &port->iflags);
+	else
+		clear_bit(TTY_PORT_ACTIVE, &port->iflags);
+}
 
 extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
 extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index 840b82f..681fe0b 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -281,7 +281,7 @@ static int ircomm_tty_block_til_ready(struct ircomm_tty_cb *self,
 	 * then make the check up front and then exit.
 	 */
 	if (tty_io_error(tty)) {
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 		return 0;
 	}
 
@@ -289,7 +289,7 @@ static int ircomm_tty_block_til_ready(struct ircomm_tty_cb *self,
 		/* nonblock mode is set */
 		if (C_BAUD(tty))
 			tty_port_raise_dtr_rts(port);
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 		pr_debug("%s(), O_NONBLOCK requested!\n", __func__);
 		return 0;
 	}
@@ -365,7 +365,7 @@ static int ircomm_tty_block_til_ready(struct ircomm_tty_cb *self,
 		 __FILE__, __LINE__, tty->driver->name, port->count);
 
 	if (!retval)
-		port->flags |= ASYNC_NORMAL_ACTIVE;
+		tty_port_set_active(port, 1);
 
 	return retval;
 }
@@ -925,7 +925,6 @@ static void ircomm_tty_hangup(struct tty_struct *tty)
 	ircomm_tty_shutdown(self);
 
 	spin_lock_irqsave(&port->lock, flags);
-	port->flags &= ~ASYNC_NORMAL_ACTIVE;
 	if (port->tty) {
 		set_bit(TTY_IO_ERROR, &port->tty->flags);
 		tty_kref_put(port->tty);
@@ -933,6 +932,7 @@ static void ircomm_tty_hangup(struct tty_struct *tty)
 	port->tty = NULL;
 	port->count = 0;
 	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_set_active(port, 0);
 
 	wake_up_interruptible(&port->open_wait);
 }
@@ -1267,7 +1267,7 @@ static void ircomm_tty_line_info(struct ircomm_tty_cb *self, struct seq_file *m)
 		seq_printf(m, "%cASYNC_LOW_LATENCY", sep);
 		sep = '|';
 	}
-	if (self->port.flags & ASYNC_NORMAL_ACTIVE) {
+	if (tty_port_active(&self->port)) {
 		seq_printf(m, "%cASYNC_NORMAL_ACTIVE", sep);
 		sep = '|';
 	}
-- 
2.8.1
