From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 54/75] tty: relock epca
Date: Fri, 02 Jan 2009 13:47:58 +0000
Message-ID: <20090102134757.13472.77849.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37638 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757335AbZABNrp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:47:45 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Bring epca into line with the port locking.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/epca.c |  195 +++++++++++++++++++++++++++------------------------
 1 files changed, 104 insertions(+), 91 deletions(-)


diff --git a/drivers/char/epca.c b/drivers/char/epca.c
index da2d2cf..e07d792 100644
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -69,7 +69,9 @@ static int invalid_lilo_config;
 
 /*
  * The ISA boards do window flipping into the same spaces so its only sane with
- * a single lock. It's still pretty efficient.
+ * a single lock. It's still pretty efficient. This lock guards the hardware
+ * and the tty_port lock guards the kernel side stuff like use counts. Take
+ * this lock inside the port lock if you must take both.
  */
 static DEFINE_SPINLOCK(epca_lock);
 
@@ -156,7 +158,7 @@ static struct channel *verifyChannel(struct tty_struct *);
 static void pc_sched_event(struct channel *, int);
 static void epca_error(int, char *);
 static void pc_close(struct tty_struct *, struct file *);
-static void shutdown(struct channel *);
+static void shutdown(struct channel *, struct tty_struct *tty);
 static void pc_hangup(struct tty_struct *);
 static int pc_write_room(struct tty_struct *);
 static int pc_chars_in_buffer(struct tty_struct *);
@@ -419,76 +421,78 @@ static void epca_error(int line, char *msg)
 static void pc_close(struct tty_struct *tty, struct file *filp)
 {
 	struct channel *ch;
+	struct tty_port *port;
 	unsigned long flags;
 	/*
 	 * verifyChannel returns the channel from the tty struct if it is
 	 * valid. This serves as a sanity check.
 	 */
 	ch = verifyChannel(tty);
-	if (ch != NULL) {
-		spin_lock_irqsave(&epca_lock, flags);
-		if (tty_hung_up_p(filp)) {
-			spin_unlock_irqrestore(&epca_lock, flags);
-			return;
-		}
-		if (ch->port.count-- > 1)  {
-			/* Begin channel is open more than once */
-			/*
-			 * Return without doing anything. Someone might still
-			 * be using the channel.
-			 */
-			spin_unlock_irqrestore(&epca_lock, flags);
-			return;
-		}
-		/* Port open only once go ahead with shutdown & reset */
-		BUG_ON(ch->port.count < 0);
+	if (ch == NULL)
+		return;
+	port = &ch->port;
 
+	spin_lock_irqsave(&port->lock, flags);
+	if (tty_hung_up_p(filp)) {
+		spin_unlock_irqrestore(&port->lock, flags);
+		return;
+	}
+	if (port->count-- > 1)  {
+		/* Begin channel is open more than once */
 		/*
-		 * Let the rest of the driver know the channel is being closed.
-		 * This becomes important if an open is attempted before close
-		 * is finished.
+		 * Return without doing anything. Someone might still
+		 * be using the channel.
 		 */
-		ch->port.flags |= ASYNC_CLOSING;
-		tty->closing = 1;
-
-		spin_unlock_irqrestore(&epca_lock, flags);
-
-		if (ch->port.flags & ASYNC_INITIALIZED)  {
-			/* Setup an event to indicate when the
-			   transmit buffer empties */
-			setup_empty_event(tty, ch);
-			/* 30 seconds timeout */
-			tty_wait_until_sent(tty, 3000);
-		}
-		pc_flush_buffer(tty);
+		spin_unlock_irqrestore(&port->lock, flags);
+		return;
+	}
+	/* Port open only once go ahead with shutdown & reset */
+	WARN_ON(port->count < 0);
 
-		tty_ldisc_flush(tty);
-		shutdown(ch);
+	/*
+	 * Let the rest of the driver know the channel is being closed.
+	 * This becomes important if an open is attempted before close
+	 * is finished.
+	 */
+	port->flags |= ASYNC_CLOSING;
+	tty->closing = 1;
 
-		spin_lock_irqsave(&epca_lock, flags);
-		tty->closing = 0;
-		ch->event = 0;
-		ch->port.tty = NULL;
-		spin_unlock_irqrestore(&epca_lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 
-		if (ch->port.blocked_open) {
-			if (ch->close_delay)
-				msleep_interruptible(jiffies_to_msecs(ch->close_delay));
-			wake_up_interruptible(&ch->port.open_wait);
-		}
-		ch->port.flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_INITIALIZED |
-					ASYNC_CLOSING);
-		wake_up_interruptible(&ch->port.close_wait);
+	if (port->flags & ASYNC_INITIALIZED)  {
+		/* Setup an event to indicate when the
+		   transmit buffer empties */
+		setup_empty_event(tty, ch);
+		/* 30 seconds timeout */
+		tty_wait_until_sent(tty, 3000);
+	}
+	pc_flush_buffer(tty);
+	tty_ldisc_flush(tty);
+	shutdown(ch, tty);
+
+	spin_lock_irqsave(&port->lock, flags);
+	tty->closing = 0;
+	ch->event = 0;
+	port->tty = NULL;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (port->blocked_open) {
+		if (ch->close_delay)
+			msleep_interruptible(jiffies_to_msecs(ch->close_delay));
+		wake_up_interruptible(&port->open_wait);
 	}
+	port->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_INITIALIZED |
+							ASYNC_CLOSING);
+	wake_up_interruptible(&port->close_wait);
 }
 
-static void shutdown(struct channel *ch)
+static void shutdown(struct channel *ch, struct tty_struct *tty)
 {
 	unsigned long flags;
-	struct tty_struct *tty;
 	struct board_chan __iomem *bc;
+	struct tty_port *port = &ch->port;
 
-	if (!(ch->port.flags & ASYNC_INITIALIZED))
+	if (!(port->flags & ASYNC_INITIALIZED))
 		return;
 
 	spin_lock_irqsave(&epca_lock, flags);
@@ -503,7 +507,6 @@ static void shutdown(struct channel *ch)
 	 */
 	if (bc)
 		writeb(0, &bc->idata);
-	tty = ch->port.tty;
 
 	/* If we're a modem control device and HUPCL is on, drop RTS & DTR. */
 	if (tty->termios->c_cflag & HUPCL)  {
@@ -517,13 +520,15 @@ static void shutdown(struct channel *ch)
 	 * will have to reinitialized. Set a flag to indicate this.
 	 */
 	/* Prevent future Digi programmed interrupts from coming active */
-	ch->port.flags &= ~ASYNC_INITIALIZED;
+	port->flags &= ~ASYNC_INITIALIZED;
 	spin_unlock_irqrestore(&epca_lock, flags);
 }
 
 static void pc_hangup(struct tty_struct *tty)
 {
 	struct channel *ch;
+	struct tty_port *port;
+
 	/*
 	 * verifyChannel returns the channel from the tty struct if it is
 	 * valid. This serves as a sanity check.
@@ -531,18 +536,19 @@ static void pc_hangup(struct tty_struct *tty)
 	ch = verifyChannel(tty);
 	if (ch != NULL) {
 		unsigned long flags;
+		port = &ch->port;
 
 		pc_flush_buffer(tty);
 		tty_ldisc_flush(tty);
-		shutdown(ch);
-
-		spin_lock_irqsave(&epca_lock, flags);
-		ch->port.tty   = NULL;
-		ch->event = 0;
-		ch->port.count = 0;
-		ch->port.flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_INITIALIZED);
-		spin_unlock_irqrestore(&epca_lock, flags);
-		wake_up_interruptible(&ch->port.open_wait);
+		shutdown(ch, tty);
+
+		spin_lock_irqsave(&port->lock, flags);
+		port->tty = NULL;
+		ch->event = 0;	/* FIXME: review locking of ch->event */
+		port->count = 0;
+		port->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_INITIALIZED);
+		spin_unlock_irqrestore(&port->lock, flags);
+		wake_up_interruptible(&port->open_wait);
 	}
 }
 
@@ -792,9 +798,10 @@ static int block_til_ready(struct tty_struct *tty,
 	DECLARE_WAITQUEUE(wait, current);
 	int retval, do_clocal = 0;
 	unsigned long flags;
+	struct tty_port *port = &ch->port;
 
 	if (tty_hung_up_p(filp)) {
-		if (ch->port.flags & ASYNC_HUP_NOTIFY)
+		if (port->flags & ASYNC_HUP_NOTIFY)
 			retval = -EAGAIN;
 		else
 			retval = -ERESTARTSYS;
@@ -805,10 +812,10 @@ static int block_til_ready(struct tty_struct *tty,
 	 * If the device is in the middle of being closed, then block until
 	 * it's done, and then try again.
 	 */
-	if (ch->port.flags & ASYNC_CLOSING) {
-		interruptible_sleep_on(&ch->port.close_wait);
+	if (port->flags & ASYNC_CLOSING) {
+		interruptible_sleep_on(&port->close_wait);
 
-		if (ch->port.flags & ASYNC_HUP_NOTIFY)
+		if (port->flags & ASYNC_HUP_NOTIFY)
 			return -EAGAIN;
 		else
 			return -ERESTARTSYS;
@@ -819,7 +826,7 @@ static int block_til_ready(struct tty_struct *tty,
 		 * If non-blocking mode is set, then make the check up front
 		 * and then exit.
 		 */
-		ch->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 	if (tty->termios->c_cflag & CLOCAL)
@@ -827,31 +834,31 @@ static int block_til_ready(struct tty_struct *tty,
 	/* Block waiting for the carrier detect and the line to become free */
 
 	retval = 0;
-	add_wait_queue(&ch->port.open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 
-	spin_lock_irqsave(&epca_lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	/* We dec count so that pc_close will know when to free things */
 	if (!tty_hung_up_p(filp))
-		ch->port.count--;
-	ch->port.blocked_open++;
+		port->count--;
+	port->blocked_open++;
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
-				!(ch->port.flags & ASYNC_INITIALIZED)) {
-			if (ch->port.flags & ASYNC_HUP_NOTIFY)
+				!(port->flags & ASYNC_INITIALIZED)) {
+			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
 			break;
 		}
-		if (!(ch->port.flags & ASYNC_CLOSING) &&
+		if (!(port->flags & ASYNC_CLOSING) &&
 			  (do_clocal || (ch->imodem & ch->dcd)))
 			break;
 		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
 			break;
 		}
-		spin_unlock_irqrestore(&epca_lock, flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 		/*
 		 * Allow someone else to be scheduled. We will occasionally go
 		 * through this loop until one of the above conditions change.
@@ -859,27 +866,28 @@ static int block_til_ready(struct tty_struct *tty,
 		 * and prevent this loop from hogging the cpu.
 		 */
 		schedule();
-		spin_lock_irqsave(&epca_lock, flags);
+		spin_lock_irqsave(&port->lock, flags);
 	}
 
 	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&ch->port.open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
-		ch->port.count++;
-	ch->port.blocked_open--;
+		port->count++;
+	port->blocked_open--;
 
-	spin_unlock_irqrestore(&epca_lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	if (retval)
 		return retval;
 
-	ch->port.flags |= ASYNC_NORMAL_ACTIVE;
+	port->flags |= ASYNC_NORMAL_ACTIVE;
 	return 0;
 }
 
 static int pc_open(struct tty_struct *tty, struct file *filp)
 {
 	struct channel *ch;
+	struct tty_port *port;
 	unsigned long flags;
 	int line, retval, boardnum;
 	struct board_chan __iomem *bc;
@@ -890,6 +898,7 @@ static int pc_open(struct tty_struct *tty, struct file *filp)
 		return -ENODEV;
 
 	ch = &digi_channels[line];
+	port = &ch->port;
 	boardnum = ch->boardnum;
 
 	/* Check status of board configured in system.  */
@@ -926,22 +935,24 @@ static int pc_open(struct tty_struct *tty, struct file *filp)
 		return -ENODEV;
 	}
 
-	spin_lock_irqsave(&epca_lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	/*
 	 * Every time a channel is opened, increment a counter. This is
 	 * necessary because we do not wish to flush and shutdown the channel
 	 * until the last app holding the channel open, closes it.
 	 */
-	ch->port.count++;
+	port->count++;
 	/*
 	 * Set a kernel structures pointer to our local channel structure. This
 	 * way we can get to it when passed only a tty struct.
 	 */
 	tty->driver_data = ch;
+	port->tty = tty;
 	/*
 	 * If this is the first time the channel has been opened, initialize
 	 * the tty->termios struct otherwise let pc_close handle it.
 	 */
+	spin_lock(&epca_lock);
 	globalwinon(ch);
 	ch->statusflags = 0;
 
@@ -956,16 +967,16 @@ static int pc_open(struct tty_struct *tty, struct file *filp)
 	writew(head, &bc->rout);
 
 	/* Set the channels associated tty structure */
-	ch->port.tty = tty;
 
 	/*
 	 * The below routine generally sets up parity, baud, flow control
 	 * issues, etc.... It effect both control flags and input flags.
 	 */
 	epcaparam(tty, ch);
-	ch->port.flags |= ASYNC_INITIALIZED;
 	memoff(ch);
-	spin_unlock_irqrestore(&epca_lock, flags);
+	spin_unlock(&epca_lock);
+	port->flags |= ASYNC_INITIALIZED;
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	retval = block_til_ready(tty, filp, ch);
 	if (retval)
@@ -974,13 +985,15 @@ static int pc_open(struct tty_struct *tty, struct file *filp)
 	 * Set this again in case a hangup set it to zero while this open() was
 	 * waiting for the line...
 	 */
-	spin_lock_irqsave(&epca_lock, flags);
-	ch->port.tty = tty;
+	spin_lock_irqsave(&port->lock, flags);
+	port->tty = tty;
+	spin_lock(&epca_lock);
 	globalwinon(ch);
 	/* Enable Digi Data events */
 	writeb(1, &bc->idata);
 	memoff(ch);
-	spin_unlock_irqrestore(&epca_lock, flags);
+	spin_unlock(&epca_lock);
+	spin_unlock_irqrestore(&port->lock, flags);
 	return 0;
 }
 

