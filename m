From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 39/75] tty: Introduce a tty_port generic block_til_ready
Date: Fri, 02 Jan 2009 13:46:10 +0000
Message-ID: <20090102134603.13472.34571.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37583 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756207AbZABNqG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:06 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Start sucking more commonality out of the drivers into a single piece of
core code.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/isicom.c   |   79 +----------------------------------
 drivers/char/mxser.c    |   71 --------------------------------
 drivers/char/riscom8.c  |   86 --------------------------------------
 drivers/char/synclink.c |    1 
 drivers/char/tty_port.c |  105 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/char/vme_scc.c  |    6 +--
 include/linux/tty.h     |    2 +
 7 files changed, 115 insertions(+), 235 deletions(-)


diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index db53db9..bac55cf 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -838,82 +838,6 @@ static int isicom_carrier_raised(struct tty_port *port)
 	return (ip->status & ISI_DCD)?1 : 0;
 }
 
-static int block_til_ready(struct tty_struct *tty, struct file *filp,
-	struct isi_port *ip)
-{
-	struct tty_port *port = &ip->port;
-	int do_clocal = 0, retval;
-	unsigned long flags;
-	DECLARE_WAITQUEUE(wait, current);
-	int cd;
-
-	/* block if port is in the process of being closed */
-
-	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
-		pr_dbg("block_til_ready: close in progress.\n");
-		interruptible_sleep_on(&port->close_wait);
-		if (port->flags & ASYNC_HUP_NOTIFY)
-			return -EAGAIN;
-		else
-			return -ERESTARTSYS;
-	}
-
-	/* if non-blocking mode is set ... */
-
-	if ((filp->f_flags & O_NONBLOCK) ||
-			(tty->flags & (1 << TTY_IO_ERROR))) {
-		pr_dbg("block_til_ready: non-block mode.\n");
-		port->flags |= ASYNC_NORMAL_ACTIVE;
-		return 0;
-	}
-
-	if (C_CLOCAL(tty))
-		do_clocal = 1;
-
-	/* block waiting for DCD to be asserted, and while
-						callout dev is busy */
-	retval = 0;
-	add_wait_queue(&port->open_wait, &wait);
-
-	spin_lock_irqsave(&port->lock, flags);
-	if (!tty_hung_up_p(filp))
-		port->count--;
-	port->blocked_open++;
-	spin_unlock_irqrestore(&port->lock, flags);
-
-	while (1) {
-		tty_port_raise_dtr_rts(port);
-
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
-			if (port->flags & ASYNC_HUP_NOTIFY)
-				retval = -EAGAIN;
-			else
-				retval = -ERESTARTSYS;
-			break;
-		}
-		cd = tty_port_carrier_raised(port);
-		if (!(port->flags & ASYNC_CLOSING) &&
-				(do_clocal || cd))
-			break;
-		if (signal_pending(current)) {
-			retval = -ERESTARTSYS;
-			break;
-		}
-		schedule();
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&port->open_wait, &wait);
-	spin_lock_irqsave(&port->lock, flags);
-	if (!tty_hung_up_p(filp))
-		port->count++;
-	port->blocked_open--;
-	if (retval == 0)
-		port->flags |= ASYNC_NORMAL_ACTIVE;
-	spin_unlock_irqrestore(&port->lock, flags);
-	return 0;
-}
-
 static int isicom_open(struct tty_struct *tty, struct file *filp)
 {
 	struct isi_port *port;
@@ -940,12 +864,13 @@ static int isicom_open(struct tty_struct *tty, struct file *filp)
 
 	isicom_setup_board(card);
 
+	/* FIXME: locking on port.count etc */
 	port->port.count++;
 	tty->driver_data = port;
 	tty_port_tty_set(&port->port, tty);
 	error = isicom_setup_port(tty);
 	if (error == 0)
-		error = block_til_ready(tty, filp, port);
+		error = tty_port_block_til_ready(&port->port, tty, filp);
 	return error;
 }
 
diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
index e2471cf..08ba6eb 100644
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -558,75 +558,6 @@ static void mxser_raise_dtr_rts(struct tty_port *port)
 	spin_unlock_irqrestore(&mp->slock, flags);
 }
 
-static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
-		struct mxser_port *mp)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	int retval;
-	int do_clocal = 0;
-	unsigned long flags;
-	int cd;
-	struct tty_port *port = &mp->port;
-
-	/*
-	 * If non-blocking mode is set, or the port is not enabled,
-	 * then make the check up front and then exit.
-	 */
-	if ((filp->f_flags & O_NONBLOCK) ||
-			test_bit(TTY_IO_ERROR, &tty->flags)) {
-		port->flags |= ASYNC_NORMAL_ACTIVE;
-		return 0;
-	}
-
-	if (tty->termios->c_cflag & CLOCAL)
-		do_clocal = 1;
-
-	/*
-	 * Block waiting for the carrier detect and the line to become
-	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, port->count is dropped by one, so that
-	 * mxser_close() knows when to free things.  We restore it upon
-	 * exit, either normal or abnormal.
-	 */
-	retval = 0;
-	add_wait_queue(&port->open_wait, &wait);
-
-	spin_lock_irqsave(&port->lock, flags);
-	if (!tty_hung_up_p(filp))
-		port->count--;
-	port->blocked_open++;
-	spin_unlock_irqrestore(&port->lock, flags);
-	while (1) {
-		tty_port_raise_dtr_rts(port);
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
-			if (port->flags & ASYNC_HUP_NOTIFY)
-				retval = -EAGAIN;
-			else
-				retval = -ERESTARTSYS;
-			break;
-		}
-		cd = tty_port_carrier_raised(port);
-		if (!(port->flags & ASYNC_CLOSING) && (do_clocal || cd))
-			break;
-		if (signal_pending(current)) {
-			retval = -ERESTARTSYS;
-			break;
-		}
-		schedule();
-	}
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&port->open_wait, &wait);
-	spin_lock_irqsave(&port->lock, flags);
-	if (!tty_hung_up_p(filp))
-		port->count++;
-	port->blocked_open--;
-	if (retval == 0)
-		port->flags |= ASYNC_NORMAL_ACTIVE;
-	spin_unlock_irqrestore(&port->lock, flags);
-	return 0;
-}
-
 static int mxser_set_baud(struct tty_struct *tty, long newspd)
 {
 	struct mxser_port *info = tty->driver_data;
@@ -1110,7 +1041,7 @@ static int mxser_open(struct tty_struct *tty, struct file *filp)
 	if (retval)
 		return retval;
 
-	retval = mxser_block_til_ready(tty, filp, info);
+	retval = tty_port_block_til_ready(&info->port, tty, filp);
 	if (retval)
 		return retval;
 
diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
index 14662d7..af34c20 100644
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -874,90 +874,6 @@ static int carrier_raised(struct tty_port *port)
 	return CD;
 }
 
-static int block_til_ready(struct tty_struct *tty, struct file *filp,
-			   struct riscom_port *rp)
-{
-	DECLARE_WAITQUEUE(wait, current);
-	int    retval;
-	int    do_clocal = 0;
-	int    CD;
-	unsigned long flags;
-	struct tty_port *port = &rp->port;
-
-	/*
-	 * If the device is in the middle of being closed, then block
-	 * until it's done, and then try again.
-	 */
-	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
-		interruptible_sleep_on(&port->close_wait);
-		if (port->flags & ASYNC_HUP_NOTIFY)
-			return -EAGAIN;
-		else
-			return -ERESTARTSYS;
-	}
-
-	/*
-	 * If non-blocking mode is set, or the port is not enabled,
-	 * then make the check up front and then exit.
-	 */
-	if ((filp->f_flags & O_NONBLOCK) ||
-	    (tty->flags & (1 << TTY_IO_ERROR))) {
-		port->flags |= ASYNC_NORMAL_ACTIVE;
-		return 0;
-	}
-
-	if (C_CLOCAL(tty))
-		do_clocal = 1;
-
-	/*
-	 * Block waiting for the carrier detect and the line to become
-	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, info->count is dropped by one, so that
-	 * rs_close() knows when to free things.  We restore it upon
-	 * exit, either normal or abnormal.
-	 */
-	retval = 0;
-	add_wait_queue(&port->open_wait, &wait);
-
-	spin_lock_irqsave(&port->lock, flags);
-	if (!tty_hung_up_p(filp))
-		port->count--;
-	port->blocked_open++;
-	spin_unlock_irqrestore(&port->lock, flags);
-
-	while (1) {
-
-		CD = tty_port_carrier_raised(port);
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) ||
-		    !(port->flags & ASYNC_INITIALIZED)) {
-			if (port->flags & ASYNC_HUP_NOTIFY)
-				retval = -EAGAIN;
-			else
-				retval = -ERESTARTSYS;
-			break;
-		}
-		if (!(port->flags & ASYNC_CLOSING) &&
-		    (do_clocal || CD))
-			break;
-		if (signal_pending(current)) {
-			retval = -ERESTARTSYS;
-			break;
-		}
-		schedule();
-	}
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&port->open_wait, &wait);
-	spin_lock_irqsave(&port->lock, flags);
-	if (!tty_hung_up_p(filp))
-		port->count++;
-	port->blocked_open--;
-	if (retval == 0)
-		port->flags |= ASYNC_NORMAL_ACTIVE;
-	spin_unlock_irqrestore(&port->lock, flags);
-	return 0;
-}
-
 static int rc_open(struct tty_struct *tty, struct file *filp)
 {
 	int board;
@@ -984,7 +900,7 @@ static int rc_open(struct tty_struct *tty, struct file *filp)
 
 	error = rc_setup_port(bp, port);
 	if (error == 0)
-		error = block_til_ready(tty, filp, port);
+		error = tty_port_block_til_ready(&port->port, tty, filp);
 	return error;
 }
 
diff --git a/drivers/char/synclink.c b/drivers/char/synclink.c
index ac9f21e..0ded4ed 100644
--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -3401,6 +3401,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
 	
+	/* FIXME: Racy on hangup during close wait */
 	if (extra_count)
 		port->count++;
 	port->blocked_open--;
diff --git a/drivers/char/tty_port.c b/drivers/char/tty_port.c
index 9f418bc..ff94182 100644
--- a/drivers/char/tty_port.c
+++ b/drivers/char/tty_port.c
@@ -151,3 +151,108 @@ void tty_port_raise_dtr_rts(struct tty_port *port)
 		port->ops->raise_dtr_rts(port);
 }
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
+
+/**
+ *	tty_port_block_til_ready	-	Waiting logic for tty open
+ *	@port: the tty port being opened
+ *	@tty: the tty device being bound
+ *	@filp: the file pointer of the opener
+ *
+ *	Implement the core POSIX/SuS tty behaviour when opening a tty device.
+ *	Handles:
+ *		- hangup (both before and during)
+ *		- non blocking open
+ *		- rts/dtr/dcd
+ *		- signals
+ *		- port flags and counts
+ *
+ *	The passed tty_port must implement the carrier_raised method if it can
+ *	do carrier detect and the raise_dtr_rts method if it supports software
+ *	management of these lines. Note that the dtr/rts raise is done each
+ *	iteration as a hangup may have previously dropped them while we wait.
+ */
+ 
+int tty_port_block_til_ready(struct tty_port *port,
+				struct tty_struct *tty, struct file *filp)
+{
+	int do_clocal = 0, retval;
+	unsigned long flags;
+	DECLARE_WAITQUEUE(wait, current);
+	int cd;
+
+	/* block if port is in the process of being closed */
+	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
+		interruptible_sleep_on(&port->close_wait);
+		if (port->flags & ASYNC_HUP_NOTIFY)
+			return -EAGAIN;
+		else
+			return -ERESTARTSYS;
+	}
+
+	/* if non-blocking mode is set we can pass directly to open unless
+	   the port has just hung up or is in another error state */
+	if ((filp->f_flags & O_NONBLOCK) ||
+			(tty->flags & (1 << TTY_IO_ERROR))) {
+		port->flags |= ASYNC_NORMAL_ACTIVE;
+		return 0;
+	}
+
+	if (C_CLOCAL(tty))
+		do_clocal = 1;
+
+	/* Block waiting until we can proceed. We may need to wait for the
+	   carrier, but we must also wait for any close that is in progress
+	   before the next open may complete */
+
+	retval = 0;
+	add_wait_queue(&port->open_wait, &wait);
+
+	/* The port lock protects the port counts */
+	spin_lock_irqsave(&port->lock, flags);
+	if (!tty_hung_up_p(filp))
+		port->count--;
+	port->blocked_open++;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	while (1) {
+		/* Indicate we are open */
+		tty_port_raise_dtr_rts(port);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		/* Check for a hangup or uninitialised port. Return accordingly */
+		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
+			if (port->flags & ASYNC_HUP_NOTIFY)
+				retval = -EAGAIN;
+			else
+				retval = -ERESTARTSYS;
+			break;
+		}
+		/* Probe the carrier. For devices with no carrier detect this
+		   will always return true */
+		cd = tty_port_carrier_raised(port);
+		if (!(port->flags & ASYNC_CLOSING) &&
+				(do_clocal || cd))
+			break;
+		if (signal_pending(current)) {
+			retval = -ERESTARTSYS;
+			break;
+		}
+		schedule();
+	}
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&port->open_wait, &wait);
+
+	/* Update counts. A parallel hangup will have set count to zero and
+	   we must not mess that up further */
+	spin_lock_irqsave(&port->lock, flags);
+	if (!tty_hung_up_p(filp))
+		port->count++;
+	port->blocked_open--;
+	if (retval == 0)
+		port->flags |= ASYNC_NORMAL_ACTIVE;
+	spin_unlock_irqrestore(&port->lock, flags);
+	return 0;
+	
+}
+EXPORT_SYMBOL(tty_port_block_til_ready);
+
diff --git a/drivers/char/vme_scc.c b/drivers/char/vme_scc.c
index d4e1534..2d9242a 100644
--- a/drivers/char/vme_scc.c
+++ b/drivers/char/vme_scc.c
@@ -631,8 +631,8 @@ static void scc_enable_rx_interrupts(void *ptr)
 
 static int scc_carrier_raised(struct tty_port *port)
 {
-	struct scc_port *scc = container_of(port, struct scc_port, gs.port);
-	unsigned channel = port->channel;
+	struct scc_port *sc = container_of(port, struct scc_port, gs.port);
+	unsigned channel = sc->channel;
 
 	return !!(scc_last_status_reg[channel] & SR_DCD);
 }
@@ -643,7 +643,7 @@ static void scc_shutdown_port(void *ptr)
 	struct scc_port *port = ptr;
 
 	port->gs.port.flags &= ~ GS_ACTIVE;
-	if (port->gs.port.tty && port->gs.port.tty->termios->c_cflag & HUPCL) {
+	if (port->gs.port.tty && (port->gs.port.tty->termios->c_cflag & HUPCL)) {
 		scc_setsignals (port, 0, 0);
 	}
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index a1a9314..61a0ab3 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -439,6 +439,8 @@ extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
 extern int tty_port_carrier_raised(struct tty_port *port);
 extern void tty_port_raise_dtr_rts(struct tty_port *port);
 extern void tty_port_hangup(struct tty_port *port);
+extern int tty_port_block_til_ready(struct tty_port *port,
+				struct tty_struct *tty, struct file *filp);
 
 extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);

