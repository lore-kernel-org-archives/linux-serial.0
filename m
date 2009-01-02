From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 60/75] tty: use port methods for the rocket driver
Date: Fri, 02 Jan 2009 13:48:39 +0000
Message-ID: <20090102134835.13472.22395.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37659 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757421AbZABNsZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:48:25 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Now we have our ducks in order we can begin switching to the port
operations

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/rocket.c   |  177 +++++------------------------------------------
 drivers/char/tty_port.c |    3 +
 2 files changed, 21 insertions(+), 159 deletions(-)


diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
index b5e5e77..f59fc5c 100644
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -879,108 +879,6 @@ static void raise_dtr_rts(struct tty_port *port)
 	sSetRTS(&info->channel);
 }
 
-/*  info->port.count is considered critical, protected by spinlocks.  */
-static int block_til_ready(struct tty_struct *tty, struct file *filp,
-			   struct r_port *info)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	struct tty_port *port = &info->port;
-	int retval;
-	int do_clocal = 0, extra_count = 0;
-	unsigned long flags;
-
-	/*
-	 * If the device is in the middle of being closed, then block
-	 * until it's done, and then try again.
-	 */
-	if (tty_hung_up_p(filp))
-		return ((info->port.flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
-	if (info->flags & ASYNC_CLOSING) {
-		if (wait_for_completion_interruptible(&info->close_wait))
-			return -ERESTARTSYS;
-		return ((info->port.flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
-	}
-
-	/*
-	 * If non-blocking mode is set, or the port is not enabled,
-	 * then make the check up front and then exit.
-	 */
-	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
-		info->port.flags |= ASYNC_NORMAL_ACTIVE;
-		return 0;
-	}
-	if (tty->termios->c_cflag & CLOCAL)
-		do_clocal = 1;
-
-	/*
-	 * Block waiting for the carrier detect and the line to become free.  While we are in
-	 * this loop, port->count is dropped by one, so that rp_close() knows when to free things.
-         * We restore it upon exit, either normal or abnormal.
-	 */
-	retval = 0;
-	add_wait_queue(&port->open_wait, &wait);
-#ifdef ROCKET_DEBUG_OPEN
-	printk(KERN_INFO "block_til_ready before block: ttyR%d, count = %d\n", info->line, port->count);
-#endif
-	spin_lock_irqsave(&port->lock, flags);
-
-#ifdef ROCKET_DISABLE_SIMUSAGE
-	info->port.flags |= ASYNC_NORMAL_ACTIVE;
-#else
-	if (!tty_hung_up_p(filp)) {
-		extra_count = 1;
-		port->count--;
-	}
-#endif
-	port->blocked_open++;
-
-	spin_unlock_irqrestore(&port->lock, flags);
-
-	while (1) {
-		if (tty->termios->c_cflag & CBAUD)
-			tty_port_raise_dtr_rts(port);
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) || !(info->port.flags & ASYNC_INITIALIZED)) {
-			if (info->port.flags & ASYNC_HUP_NOTIFY)
-				retval = -EAGAIN;
-			else
-				retval = -ERESTARTSYS;
-			break;
-		}
-		if (!(info->port.flags & ASYNC_CLOSING) &&
-			(do_clocal || tty_port_carrier_raised(port)))
-			break;
-		if (signal_pending(current)) {
-			retval = -ERESTARTSYS;
-			break;
-		}
-#ifdef ROCKET_DEBUG_OPEN
-		printk(KERN_INFO "block_til_ready blocking: ttyR%d, count = %d, flags=0x%0x\n",
-		     info->line, port->count, info->port.flags);
-#endif
-		schedule();	/*  Don't hold spinlock here, will hang PC */
-	}
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&port->open_wait, &wait);
-
-	spin_lock_irqsave(&port->lock, flags);
-
-	if (extra_count)
-		port->count++;
-	port->blocked_open--;
-
-	spin_unlock_irqrestore(&port->lock, flags);
-
-#ifdef ROCKET_DEBUG_OPEN
-	printk(KERN_INFO "block_til_ready after blocking: ttyR%d, count = %d\n",
-	       info->line, port->count);
-#endif
-	if (retval)
-		return retval;
-	info->port.flags |= ASYNC_NORMAL_ACTIVE;
-	return 0;
-}
-
 /*
  *  Exception handler that opens a serial port.  Creates xmit_buf storage, fills in 
  *  port's r_port struct.  Initializes the port hardware.  
@@ -988,24 +886,26 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 static int rp_open(struct tty_struct *tty, struct file *filp)
 {
 	struct r_port *info;
+	struct tty_port *port;
 	int line = 0, retval;
 	CHANNEL_t *cp;
 	unsigned long page;
 
 	line = tty->index;
-	if ((line < 0) || (line >= MAX_RP_PORTS) || ((info = rp_table[line]) == NULL))
+	if (line < 0 || line >= MAX_RP_PORTS || ((info = rp_table[line]) == NULL))
 		return -ENXIO;
-
+	port = &info->port;
+	
 	page = __get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 
-	if (info->port.flags & ASYNC_CLOSING) {
+	if (port->flags & ASYNC_CLOSING) {
 		retval = wait_for_completion_interruptible(&info->close_wait);
 		free_page(page);
 		if (retval)
 			return retval;
-		return ((info->port.flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
+		return ((port->flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
 	}
 
 	/*
@@ -1017,9 +917,9 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 		info->xmit_buf = (unsigned char *) page;
 
 	tty->driver_data = info;
-	tty_port_tty_set(&info->port, tty);
+	tty_port_tty_set(port, tty);
 
-	if (info->port.count++ == 0) {
+	if (port->count++ == 0) {
 		atomic_inc(&rp_num_ports_open);
 
 #ifdef ROCKET_DEBUG_OPEN
@@ -1034,7 +934,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 	/*
 	 * Info->count is now 1; so it's safe to sleep now.
 	 */
-	if ((info->port.flags & ASYNC_INITIALIZED) == 0) {
+	if (!test_bit(ASYNC_INITIALIZED, &port->flags)) {
 		cp = &info->channel;
 		sSetRxTrigger(cp, TRIG_1);
 		if (sGetChanStatus(cp) & CD_ACT)
@@ -1058,7 +958,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 		sEnRxFIFO(cp);
 		sEnTransmit(cp);
 
-		info->port.flags |= ASYNC_INITIALIZED;
+		set_bit(ASYNC_INITIALIZED, &info->port.flags);
 
 		/*
 		 * Set up the tty->alt_speed kludge
@@ -1081,7 +981,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 	/*  Starts (or resets) the maint polling loop */
 	mod_timer(&rocket_timer, jiffies + POLL_PERIOD);
 
-	retval = block_til_ready(tty, filp, info);
+	retval = tty_port_block_til_ready(port, tty, filp);
 	if (retval) {
 #ifdef ROCKET_DEBUG_OPEN
 		printk(KERN_INFO "rp_open returning after block_til_ready with %d\n", retval);
@@ -1098,7 +998,6 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 {
 	struct r_port *info = tty->driver_data;
 	struct tty_port *port = &info->port;
-	unsigned long flags;
 	int timeout;
 	CHANNEL_t *cp;
 	
@@ -1109,53 +1008,10 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 	printk(KERN_INFO "rp_close ttyR%d, count = %d\n", info->line, info->port.count);
 #endif
 
-	if (tty_hung_up_p(filp))
+	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
-	spin_lock_irqsave(&port->lock, flags);
-
-	if (tty->count == 1 && port->count != 1) {
-		/*
-		 * Uh, oh.  tty->count is 1, which means that the tty
-		 * structure will be freed.  Info->count should always
-		 * be one in these conditions.  If it's greater than
-		 * one, we've got real problems, since it means the
-		 * serial port won't be shutdown.
-		 */
-		printk(KERN_WARNING "rp_close: bad serial port count; "
-			"tty->count is 1, info->port.count is %d\n", info->port.count);
-		port->count = 1;
-	}
-	if (--port->count < 0) {
-		printk(KERN_WARNING "rp_close: bad serial port count for "
-				"ttyR%d: %d\n", info->line, info->port.count);
-		port->count = 0;
-	}
-	if (port->count) {
-		spin_unlock_irqrestore(&port->lock, flags);
-		return;
-	}
-	info->port.flags |= ASYNC_CLOSING;
-	spin_unlock_irqrestore(&port->lock, flags);
 
 	cp = &info->channel;
-
-	/*
-	 * Notify the line discpline to only process XON/XOFF characters
-	 */
-	tty->closing = 1;
-
-	/*
-	 * If transmission was throttled by the application request,
-	 * just flush the xmit buffer.
-	 */
-	if (tty->flow_stopped)
-		rp_flush_buffer(tty);
-
-	/*
-	 * Wait for the transmit buffer to clear
-	 */
-	if (info->port.closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, port->closing_wait);
 	/*
 	 * Before we drop DTR, make sure the UART transmitter
 	 * has completely drained; this is especially
@@ -1184,6 +1040,9 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 
 	clear_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
 
+	/* We can't yet use tty_port_close_end as the buffer handling in this
+	   driver is a bit different to the usual */
+
 	if (port->blocked_open) {
 		if (port->close_delay) {
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
@@ -1197,6 +1056,8 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 	}
 	info->port.flags &= ~(ASYNC_INITIALIZED | ASYNC_CLOSING | ASYNC_NORMAL_ACTIVE);
 	tty->closing = 0;
+	tty_port_tty_set(port, NULL);
+	wake_up_interruptible(&port->close_wait);
 	complete_all(&info->close_wait);
 	atomic_dec(&rp_num_ports_open);
 
@@ -1659,9 +1520,7 @@ static void rp_hangup(struct tty_struct *tty)
 		atomic_dec(&rp_num_ports_open);
 	clear_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
 
-	info->port.count = 0;
-	info->port.flags &= ~ASYNC_NORMAL_ACTIVE;
-	tty_port_tty_set(&info->port, NULL);
+	tty_port_hangup(&info->port);
 
 	cp = &info->channel;
 	sDisRxFIFO(cp);
diff --git a/drivers/char/tty_port.c b/drivers/char/tty_port.c
index b580fcf..9b8004c 100644
--- a/drivers/char/tty_port.c
+++ b/drivers/char/tty_port.c
@@ -286,6 +286,9 @@ int tty_port_close_start(struct tty_port *port, struct tty_struct *tty, struct f
 	port->flags |= ASYNC_CLOSING;
 	tty->closing = 1;
 	spin_unlock_irqrestore(&port->lock, flags);
+	/* Don't block on a stalled port, just pull the chain */
+	if (tty->flow_stopped)
+		tty_driver_flush_buffer(tty);
 	if (port->flags & ASYNC_INITIALIZED &&
 			port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, port->closing_wait);

