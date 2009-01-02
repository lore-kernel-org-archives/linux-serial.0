From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 56/75] tty: Make epca use the port helpers
Date: Fri, 02 Jan 2009 13:48:11 +0000
Message-ID: <20090102134810.13472.36014.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37646 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757361AbZABNr5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:47:57 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Now the locking is straight and the port kref usage is straight we can
replace lots of chunks of code with the standard port helpers

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/epca.c     |  172 +++++++----------------------------------------
 drivers/char/tty_port.c |    3 +
 2 files changed, 26 insertions(+), 149 deletions(-)


diff --git a/drivers/char/epca.c b/drivers/char/epca.c
index 7a69705..71225d1 100644
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -432,58 +432,15 @@ static void pc_close(struct tty_struct *tty, struct file *filp)
 		return;
 	port = &ch->port;
 
-	spin_lock_irqsave(&port->lock, flags);
-	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&port->lock, flags);
-		return;
-	}
-	if (port->count-- > 1)  {
-		/* Begin channel is open more than once */
-		/*
-		 * Return without doing anything. Someone might still
-		 * be using the channel.
-		 */
-		spin_unlock_irqrestore(&port->lock, flags);
+	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
-	}
-	/* Port open only once go ahead with shutdown & reset */
-	WARN_ON(port->count < 0);
 
-	/*
-	 * Let the rest of the driver know the channel is being closed.
-	 * This becomes important if an open is attempted before close
-	 * is finished.
-	 */
-	port->flags |= ASYNC_CLOSING;
-	tty->closing = 1;
-
-	spin_unlock_irqrestore(&port->lock, flags);
-
-	if (port->flags & ASYNC_INITIALIZED)  {
-		/* Setup an event to indicate when the
-		   transmit buffer empties */
-		setup_empty_event(tty, ch);
-		/* 30 seconds timeout */
-		tty_wait_until_sent(tty, 3000);
-	}
 	pc_flush_buffer(tty);
-	tty_ldisc_flush(tty);
 	shutdown(ch, tty);
 
-	spin_lock_irqsave(&port->lock, flags);
-	tty->closing = 0;
-	ch->event = 0;
+	tty_port_close_end(port, tty);
+	ch->event = 0;	/* FIXME: review ch->event locking */
 	tty_port_tty_set(port, NULL);
-	spin_unlock_irqrestore(&port->lock, flags);
-
-	if (port->blocked_open) {
-		if (ch->close_delay)
-			msleep_interruptible(jiffies_to_msecs(ch->close_delay));
-		wake_up_interruptible(&port->open_wait);
-	}
-	port->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_INITIALIZED |
-							ASYNC_CLOSING);
-	wake_up_interruptible(&port->close_wait);
 }
 
 static void shutdown(struct channel *ch, struct tty_struct *tty)
@@ -527,7 +484,6 @@ static void shutdown(struct channel *ch, struct tty_struct *tty)
 static void pc_hangup(struct tty_struct *tty)
 {
 	struct channel *ch;
-	struct tty_port *port;
 
 	/*
 	 * verifyChannel returns the channel from the tty struct if it is
@@ -536,19 +492,13 @@ static void pc_hangup(struct tty_struct *tty)
 	ch = verifyChannel(tty);
 	if (ch != NULL) {
 		unsigned long flags;
-		port = &ch->port;
 
 		pc_flush_buffer(tty);
 		tty_ldisc_flush(tty);
 		shutdown(ch, tty);
 
-		spin_lock_irqsave(&port->lock, flags);
-		port->tty = NULL;
 		ch->event = 0;	/* FIXME: review locking of ch->event */
-		port->count = 0;
-		port->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_INITIALIZED);
-		spin_unlock_irqrestore(&port->lock, flags);
-		wake_up_interruptible(&port->open_wait);
+		tty_port_hangup(&ch->port);
 	}
 }
 
@@ -792,98 +742,18 @@ static void pc_flush_chars(struct tty_struct *tty)
 	}
 }
 
-static int block_til_ready(struct tty_struct *tty,
-				struct file *filp, struct channel *ch)
+static int epca_carrier_raised(struct tty_port *port)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	int retval, do_clocal = 0;
-	unsigned long flags;
-	struct tty_port *port = &ch->port;
-
-	if (tty_hung_up_p(filp)) {
-		if (port->flags & ASYNC_HUP_NOTIFY)
-			retval = -EAGAIN;
-		else
-			retval = -ERESTARTSYS;
-		return retval;
-	}
-
-	/*
-	 * If the device is in the middle of being closed, then block until
-	 * it's done, and then try again.
-	 */
-	if (port->flags & ASYNC_CLOSING) {
-		interruptible_sleep_on(&port->close_wait);
-
-		if (port->flags & ASYNC_HUP_NOTIFY)
-			return -EAGAIN;
-		else
-			return -ERESTARTSYS;
-	}
-
-	if (filp->f_flags & O_NONBLOCK)  {
-		/*
-		 * If non-blocking mode is set, then make the check up front
-		 * and then exit.
-		 */
-		port->flags |= ASYNC_NORMAL_ACTIVE;
-		return 0;
-	}
-	if (tty->termios->c_cflag & CLOCAL)
-		do_clocal = 1;
-	/* Block waiting for the carrier detect and the line to become free */
-
-	retval = 0;
-	add_wait_queue(&port->open_wait, &wait);
-
-	spin_lock_irqsave(&port->lock, flags);
-	/* We dec count so that pc_close will know when to free things */
-	if (!tty_hung_up_p(filp))
-		port->count--;
-	port->blocked_open++;
-	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) ||
-				!(port->flags & ASYNC_INITIALIZED)) {
-			if (port->flags & ASYNC_HUP_NOTIFY)
-				retval = -EAGAIN;
-			else
-				retval = -ERESTARTSYS;
-			break;
-		}
-		if (!(port->flags & ASYNC_CLOSING) &&
-			  (do_clocal || (ch->imodem & ch->dcd)))
-			break;
-		if (signal_pending(current)) {
-			retval = -ERESTARTSYS;
-			break;
-		}
-		spin_unlock_irqrestore(&port->lock, flags);
-		/*
-		 * Allow someone else to be scheduled. We will occasionally go
-		 * through this loop until one of the above conditions change.
-		 * The below schedule call will allow other processes to enter
-		 * and prevent this loop from hogging the cpu.
-		 */
-		schedule();
-		spin_lock_irqsave(&port->lock, flags);
-	}
-
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&port->open_wait, &wait);
-	if (!tty_hung_up_p(filp))
-		port->count++;
-	port->blocked_open--;
-
-	spin_unlock_irqrestore(&port->lock, flags);
-
-	if (retval)
-		return retval;
-
-	port->flags |= ASYNC_NORMAL_ACTIVE;
+	struct channel *ch = container_of(port, struct channel, port);
+	if (ch->imodem & ch->dcd)
+		return 1;
 	return 0;
 }
 
+static void epca_raise_dtr_rts(struct tty_port *port0
+{
+}
+
 static int pc_open(struct tty_struct *tty, struct file *filp)
 {
 	struct channel *ch;
@@ -978,7 +848,7 @@ static int pc_open(struct tty_struct *tty, struct file *filp)
 	port->flags |= ASYNC_INITIALIZED;
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	retval = block_til_ready(tty, filp, ch);
+	retval = tty_port_block_til_ready(port, tty, filp);
 	if (retval)
 		return retval;
 	/*
@@ -1058,6 +928,11 @@ static const struct tty_operations pc_ops = {
 	.break_ctl = pc_send_break
 };
 
+static const struct tty_port_operations epca_port_ops = {
+	.carrier_raised = epca_carrier_raised,
+	.raise_dtr_rts = epca_raise_dtr_rts,
+};
+
 static int info_open(struct tty_struct *tty, struct file *filp)
 {
 	return 0;
@@ -1393,6 +1268,7 @@ static void post_fep_init(unsigned int crd)
 		u16 tseg, rseg;
 
 		tty_port_init(&ch->port);
+		ch->port.ops - &epca_port_ops;
 		ch->brdchan = bc;
 		ch->mailbox = gd;
 		INIT_WORK(&ch->tqueue, do_softint);
@@ -1526,7 +1402,7 @@ static void post_fep_init(unsigned int crd)
 		ch->fepstartca = 0;
 		ch->fepstopca = 0;
 
-		ch->close_delay = 50;
+		ch->port.close_delay = 50;
 
 		spin_unlock_irqrestore(&epca_lock, flags);
 	}
@@ -1647,7 +1523,7 @@ static void doevent(int crd)
 		if (event & MODEMCHG_IND) {
 			/* A modem signal change has been indicated */
 			ch->imodem = mstat;
-			if (ch->port.flags & ASYNC_CHECK_CD) {
+			if (test_bit(ASYNC_CHECK_CD, &ch->port.flags)) {
 				/* We are now receiving dcd */
 				if (mstat & ch->dcd)
 					wake_up_interruptible(&ch->port.open_wait);
@@ -1894,9 +1770,9 @@ static void epcaparam(struct tty_struct *tty, struct channel *ch)
 		 * that the driver will wait on carrier detect.
 		 */
 		if (ts->c_cflag & CLOCAL)
-			ch->port.flags &= ~ASYNC_CHECK_CD;
+			clear_bit(ASYNC_CHECK_CD, &ch->port.flags);
 		else
-			ch->port.flags |= ASYNC_CHECK_CD;
+			set_bit(ASYNC_CHECK_CD, &ch->port.flags);
 		mval = ch->m_dtr | ch->m_rts;
 	} /* End CBAUD not detected */
 	iflag = termios2digi_i(ch, ts->c_iflag);
@@ -2373,7 +2249,7 @@ static void do_softint(struct work_struct *work)
 			if (test_and_clear_bit(EPCA_EVENT_HANGUP, &ch->event)) {
 				tty_hangup(tty);
 				wake_up_interruptible(&ch->port.open_wait);
-				ch->port.flags &= ~ASYNC_NORMAL_ACTIVE;
+				clear_bit(ASYNC_NORMAL_ACTIVE, &ch->port.flags);
 			}
 		}
 		tty_kref_put(tty);
diff --git a/drivers/char/tty_port.c b/drivers/char/tty_port.c
index b3175f5..b580fcf 100644
--- a/drivers/char/tty_port.c
+++ b/drivers/char/tty_port.c
@@ -286,7 +286,8 @@ int tty_port_close_start(struct tty_port *port, struct tty_struct *tty, struct f
 	port->flags |= ASYNC_CLOSING;
 	tty->closing = 1;
 	spin_unlock_irqrestore(&port->lock, flags);
-	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+	if (port->flags & ASYNC_INITIALIZED &&
+			port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, port->closing_wait);
 	return 1;
 }

