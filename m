From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 58/75] tty: make rocketport use standard port->flags
Date: Fri, 02 Jan 2009 13:48:23 +0000
Message-ID: <20090102134822.13472.77165.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37653 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754562AbZABNsT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:48:19 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

We need to this ready for using the standard helpers

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/rocket.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)


diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
index efc3e5c..ca6fcdc 100644
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -499,7 +499,7 @@ static void rp_handle_port(struct r_port *info)
 	if (!info)
 		return;
 
-	if ((info->flags & ASYNC_INITIALIZED) == 0) {
+	if ((info->port.flags & ASYNC_INITIALIZED) == 0) {
 		printk(KERN_WARNING "rp: WARNING: rp_handle_port called with "
 				"info->flags & NOT_INIT\n");
 		return;
@@ -892,11 +892,11 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	 * until it's done, and then try again.
 	 */
 	if (tty_hung_up_p(filp))
-		return ((info->flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
+		return ((info->port.flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
 	if (info->flags & ASYNC_CLOSING) {
 		if (wait_for_completion_interruptible(&info->close_wait))
 			return -ERESTARTSYS;
-		return ((info->flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
+		return ((info->port.flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
 	}
 
 	/*
@@ -904,7 +904,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	 * then make the check up front and then exit.
 	 */
 	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
-		info->flags |= ASYNC_NORMAL_ACTIVE;
+		info->port.flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 	if (tty->termios->c_cflag & CLOCAL)
@@ -923,7 +923,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	spin_lock_irqsave(&port->lock, flags);
 
 #ifdef ROCKET_DISABLE_SIMUSAGE
-	info->flags |= ASYNC_NORMAL_ACTIVE;
+	info->port.flags |= ASYNC_NORMAL_ACTIVE;
 #else
 	if (!tty_hung_up_p(filp)) {
 		extra_count = 1;
@@ -938,14 +938,14 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		if (tty->termios->c_cflag & CBAUD)
 			tty_port_raise_dtr_rts(port);
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) || !(info->flags & ASYNC_INITIALIZED)) {
-			if (info->flags & ASYNC_HUP_NOTIFY)
+		if (tty_hung_up_p(filp) || !(info->port.flags & ASYNC_INITIALIZED)) {
+			if (info->port.flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
 			break;
 		}
-		if (!(info->flags & ASYNC_CLOSING) &&
+		if (!(info->port.flags & ASYNC_CLOSING) &&
 			(do_clocal || tty_port_carrier_raised(port)))
 			break;
 		if (signal_pending(current)) {
@@ -954,7 +954,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		}
 #ifdef ROCKET_DEBUG_OPEN
 		printk(KERN_INFO "block_til_ready blocking: ttyR%d, count = %d, flags=0x%0x\n",
-		     info->line, port->count, info->flags);
+		     info->line, port->count, info->port.flags);
 #endif
 		schedule();	/*  Don't hold spinlock here, will hang PC */
 	}
@@ -975,7 +975,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 #endif
 	if (retval)
 		return retval;
-	info->flags |= ASYNC_NORMAL_ACTIVE;
+	info->port.flags |= ASYNC_NORMAL_ACTIVE;
 	return 0;
 }
 
@@ -998,12 +998,12 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 	if (!page)
 		return -ENOMEM;
 
-	if (info->flags & ASYNC_CLOSING) {
+	if (info->port.flags & ASYNC_CLOSING) {
 		retval = wait_for_completion_interruptible(&info->close_wait);
 		free_page(page);
 		if (retval)
 			return retval;
-		return ((info->flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
+		return ((info->port.flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
 	}
 
 	/*
@@ -1032,7 +1032,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 	/*
 	 * Info->count is now 1; so it's safe to sleep now.
 	 */
-	if ((info->flags & ASYNC_INITIALIZED) == 0) {
+	if ((info->port.flags & ASYNC_INITIALIZED) == 0) {
 		cp = &info->channel;
 		sSetRxTrigger(cp, TRIG_1);
 		if (sGetChanStatus(cp) & CD_ACT)
@@ -1056,7 +1056,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 		sEnRxFIFO(cp);
 		sEnTransmit(cp);
 
-		info->flags |= ASYNC_INITIALIZED;
+		info->port.flags |= ASYNC_INITIALIZED;
 
 		/*
 		 * Set up the tty->alt_speed kludge
@@ -1132,7 +1132,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 		spin_unlock_irqrestore(&port->lock, flags);
 		return;
 	}
-	info->flags |= ASYNC_CLOSING;
+	info->port.flags |= ASYNC_CLOSING;
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	cp = &info->channel;
@@ -1193,7 +1193,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 			info->xmit_buf = NULL;
 		}
 	}
-	info->flags &= ~(ASYNC_INITIALIZED | ASYNC_CLOSING | ASYNC_NORMAL_ACTIVE);
+	info->port.flags &= ~(ASYNC_INITIALIZED | ASYNC_CLOSING | ASYNC_NORMAL_ACTIVE);
 	tty->closing = 0;
 	complete_all(&info->close_wait);
 	atomic_dec(&rp_num_ports_open);
@@ -1650,14 +1650,14 @@ static void rp_hangup(struct tty_struct *tty)
 	printk(KERN_INFO "rp_hangup of ttyR%d...\n", info->line);
 #endif
 	rp_flush_buffer(tty);
-	if (info->flags & ASYNC_CLOSING)
+	if (info->port.flags & ASYNC_CLOSING)
 		return;
 	if (info->port.count)
 		atomic_dec(&rp_num_ports_open);
 	clear_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
 
 	info->port.count = 0;
-	info->flags &= ~ASYNC_NORMAL_ACTIVE;
+	info->port.flags &= ~ASYNC_NORMAL_ACTIVE;
 	info->port.tty = NULL;
 
 	cp = &info->channel;
@@ -1667,7 +1667,7 @@ static void rp_hangup(struct tty_struct *tty)
 	sDisCTSFlowCtl(cp);
 	sDisTxSoftFlowCtl(cp);
 	sClrTxXOFF(cp);
-	info->flags &= ~ASYNC_INITIALIZED;
+	info->port.flags &= ~ASYNC_INITIALIZED;
 
 	wake_up_interruptible(&info->port.open_wait);
 }

