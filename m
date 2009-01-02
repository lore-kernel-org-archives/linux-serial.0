From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 36/75] tty: rocketport uses different port flags to everyone
	else
Date: Fri, 02 Jan 2009 13:45:44 +0000
Message-ID: <20090102134541.13472.29005.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37590 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756961AbZABNqP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:15 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Normalise them so we can use the common helpers later on

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/rocket.c     |   40 ++++++++++++++++++++--------------------
 drivers/char/rocket.h     |    2 +-
 drivers/char/rocket_int.h |    5 -----
 3 files changed, 21 insertions(+), 26 deletions(-)


diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
index f4d9c39..9d81980 100644
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -499,7 +499,7 @@ static void rp_handle_port(struct r_port *info)
 	if (!info)
 		return;
 
-	if ((info->flags & ROCKET_INITIALIZED) == 0) {
+	if ((info->flags & ASYNC_INITIALIZED) == 0) {
 		printk(KERN_WARNING "rp: WARNING: rp_handle_port called with "
 				"info->flags & NOT_INIT\n");
 		return;
@@ -892,11 +892,11 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	 * until it's done, and then try again.
 	 */
 	if (tty_hung_up_p(filp))
-		return ((info->flags & ROCKET_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
-	if (info->flags & ROCKET_CLOSING) {
+		return ((info->flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
+	if (info->flags & ASYNC_CLOSING) {
 		if (wait_for_completion_interruptible(&info->close_wait))
 			return -ERESTARTSYS;
-		return ((info->flags & ROCKET_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
+		return ((info->flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
 	}
 
 	/*
@@ -904,7 +904,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	 * then make the check up front and then exit.
 	 */
 	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
-		info->flags |= ROCKET_NORMAL_ACTIVE;
+		info->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 	if (tty->termios->c_cflag & CLOCAL)
@@ -923,7 +923,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	spin_lock_irqsave(&info->slock, flags);
 
 #ifdef ROCKET_DISABLE_SIMUSAGE
-	info->flags |= ROCKET_NORMAL_ACTIVE;
+	info->flags |= ASYNC_NORMAL_ACTIVE;
 #else
 	if (!tty_hung_up_p(filp)) {
 		extra_count = 1;
@@ -938,14 +938,14 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		if (tty->termios->c_cflag & CBAUD)
 			tty_port_raise_dtr_rts(port);
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) || !(info->flags & ROCKET_INITIALIZED)) {
-			if (info->flags & ROCKET_HUP_NOTIFY)
+		if (tty_hung_up_p(filp) || !(info->flags & ASYNC_INITIALIZED)) {
+			if (info->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
 			break;
 		}
-		if (!(info->flags & ROCKET_CLOSING) &&
+		if (!(info->flags & ASYNC_CLOSING) &&
 			(do_clocal || tty_port_carrier_raised(port)))
 			break;
 		if (signal_pending(current)) {
@@ -975,7 +975,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 #endif
 	if (retval)
 		return retval;
-	info->flags |= ROCKET_NORMAL_ACTIVE;
+	info->flags |= ASYNC_NORMAL_ACTIVE;
 	return 0;
 }
 
@@ -998,12 +998,12 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 	if (!page)
 		return -ENOMEM;
 
-	if (info->flags & ROCKET_CLOSING) {
+	if (info->flags & ASYNC_CLOSING) {
 		retval = wait_for_completion_interruptible(&info->close_wait);
 		free_page(page);
 		if (retval)
 			return retval;
-		return ((info->flags & ROCKET_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
+		return ((info->flags & ASYNC_HUP_NOTIFY) ? -EAGAIN : -ERESTARTSYS);
 	}
 
 	/*
@@ -1032,7 +1032,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 	/*
 	 * Info->count is now 1; so it's safe to sleep now.
 	 */
-	if ((info->flags & ROCKET_INITIALIZED) == 0) {
+	if ((info->flags & ASYNC_INITIALIZED) == 0) {
 		cp = &info->channel;
 		sSetRxTrigger(cp, TRIG_1);
 		if (sGetChanStatus(cp) & CD_ACT)
@@ -1056,7 +1056,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 		sEnRxFIFO(cp);
 		sEnTransmit(cp);
 
-		info->flags |= ROCKET_INITIALIZED;
+		info->flags |= ASYNC_INITIALIZED;
 
 		/*
 		 * Set up the tty->alt_speed kludge
@@ -1131,7 +1131,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 		spin_unlock_irqrestore(&info->slock, flags);
 		return;
 	}
-	info->flags |= ROCKET_CLOSING;
+	info->flags |= ASYNC_CLOSING;
 	spin_unlock_irqrestore(&info->slock, flags);
 
 	cp = &info->channel;
@@ -1151,7 +1151,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 	/*
 	 * Wait for the transmit buffer to clear
 	 */
-	if (info->port.closing_wait != ROCKET_CLOSING_WAIT_NONE)
+	if (info->port.closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, info->port.closing_wait);
 	/*
 	 * Before we drop DTR, make sure the UART transmitter
@@ -1192,7 +1192,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 			info->xmit_buf = NULL;
 		}
 	}
-	info->flags &= ~(ROCKET_INITIALIZED | ROCKET_CLOSING | ROCKET_NORMAL_ACTIVE);
+	info->flags &= ~(ASYNC_INITIALIZED | ASYNC_CLOSING | ASYNC_NORMAL_ACTIVE);
 	tty->closing = 0;
 	complete_all(&info->close_wait);
 	atomic_dec(&rp_num_ports_open);
@@ -1649,14 +1649,14 @@ static void rp_hangup(struct tty_struct *tty)
 	printk(KERN_INFO "rp_hangup of ttyR%d...\n", info->line);
 #endif
 	rp_flush_buffer(tty);
-	if (info->flags & ROCKET_CLOSING)
+	if (info->flags & ASYNC_CLOSING)
 		return;
 	if (info->port.count)
 		atomic_dec(&rp_num_ports_open);
 	clear_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
 
 	info->port.count = 0;
-	info->flags &= ~ROCKET_NORMAL_ACTIVE;
+	info->flags &= ~ASYNC_NORMAL_ACTIVE;
 	info->port.tty = NULL;
 
 	cp = &info->channel;
@@ -1666,7 +1666,7 @@ static void rp_hangup(struct tty_struct *tty)
 	sDisCTSFlowCtl(cp);
 	sDisTxSoftFlowCtl(cp);
 	sClrTxXOFF(cp);
-	info->flags &= ~ROCKET_INITIALIZED;
+	info->flags &= ~ASYNC_INITIALIZED;
 
 	wake_up_interruptible(&info->port.open_wait);
 }
diff --git a/drivers/char/rocket.h b/drivers/char/rocket.h
index a8b0919..ec863f3 100644
--- a/drivers/char/rocket.h
+++ b/drivers/char/rocket.h
@@ -39,7 +39,7 @@ struct rocket_version {
 /*
  * Rocketport flags
  */
-#define ROCKET_CALLOUT_NOHUP    0x00000001
+/*#define ROCKET_CALLOUT_NOHUP    0x00000001 */
 #define ROCKET_FORCE_CD		0x00000002
 #define ROCKET_HUP_NOTIFY	0x00000004
 #define ROCKET_SPLIT_TERMIOS	0x00000008
diff --git a/drivers/char/rocket_int.h b/drivers/char/rocket_int.h
index 21f3ff5..67e0f1e 100644
--- a/drivers/char/rocket_int.h
+++ b/drivers/char/rocket_int.h
@@ -1162,11 +1162,6 @@ struct r_port {
 /* number of characters left in xmit buffer before we ask for more */
 #define WAKEUP_CHARS 256
 
-/* Internal flags used only by the rocketport driver */
-#define ROCKET_INITIALIZED	0x80000000	/* Port is active */
-#define ROCKET_CLOSING		0x40000000	/* Serial port is closing */
-#define ROCKET_NORMAL_ACTIVE	0x20000000	/* Normal port is active */
-
 /*
  * Assigned major numbers for the Comtrol Rocketport
  */

