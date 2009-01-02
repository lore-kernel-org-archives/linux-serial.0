From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 40/75] tty: Rework istallion to use the tty port changes
Date: Fri, 02 Jan 2009 13:46:18 +0000
Message-ID: <20090102134616.13472.88062.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37578 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756317AbZABNqI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:08 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/istallion.c  |  159 ++++++++++++---------------------------------
 include/linux/istallion.h |    1 
 2 files changed, 43 insertions(+), 117 deletions(-)


diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index c4682f9..4c69ab9 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -626,8 +626,6 @@ static int	stli_hostcmd(struct stlibrd *brdp, struct stliport *portp);
 static int	stli_initopen(struct tty_struct *tty, struct stlibrd *brdp, struct stliport *portp);
 static int	stli_rawopen(struct stlibrd *brdp, struct stliport *portp, unsigned long arg, int wait);
 static int	stli_rawclose(struct stlibrd *brdp, struct stliport *portp, unsigned long arg, int wait);
-static int	stli_waitcarrier(struct tty_struct *tty, struct stlibrd *brdp,
-				struct stliport *portp, struct file *filp);
 static int	stli_setport(struct tty_struct *tty);
 static int	stli_cmdwait(struct stlibrd *brdp, struct stliport *portp, unsigned long cmd, void *arg, int size, int copyback);
 static void	stli_sendcmd(struct stlibrd *brdp, struct stliport *portp, unsigned long cmd, void *arg, int size, int copyback);
@@ -787,6 +785,7 @@ static int stli_open(struct tty_struct *tty, struct file *filp)
 {
 	struct stlibrd *brdp;
 	struct stliport *portp;
+	struct tty_port *port;
 	unsigned int minordev, brdnr, portnr;
 	int rc;
 
@@ -808,30 +807,19 @@ static int stli_open(struct tty_struct *tty, struct file *filp)
 		return -ENODEV;
 	if (portp->devnr < 1)
 		return -ENODEV;
-
-
-/*
- *	Check if this port is in the middle of closing. If so then wait
- *	until it is closed then return error status based on flag settings.
- *	The sleep here does not need interrupt protection since the wakeup
- *	for it is done with the same context.
- */
-	if (portp->port.flags & ASYNC_CLOSING) {
-		interruptible_sleep_on(&portp->port.close_wait);
-		if (portp->port.flags & ASYNC_HUP_NOTIFY)
-			return -EAGAIN;
-		return -ERESTARTSYS;
-	}
+	port = &portp->port;
 
 /*
  *	On the first open of the device setup the port hardware, and
  *	initialize the per port data structure. Since initializing the port
  *	requires several commands to the board we will need to wait for any
  *	other open that is already initializing the port.
+ *
+ *	Review - locking
  */
-	tty_port_tty_set(&portp->port, tty);
+	tty_port_tty_set(port, tty);
 	tty->driver_data = portp;
-	portp->port.count++;
+	port->count++;
 
 	wait_event_interruptible(portp->raw_wait,
 			!test_bit(ST_INITIALIZING, &portp->state));
@@ -841,7 +829,8 @@ static int stli_open(struct tty_struct *tty, struct file *filp)
 	if ((portp->port.flags & ASYNC_INITIALIZED) == 0) {
 		set_bit(ST_INITIALIZING, &portp->state);
 		if ((rc = stli_initopen(tty, brdp, portp)) >= 0) {
-			portp->port.flags |= ASYNC_INITIALIZED;
+			/* Locking */
+			port->flags |= ASYNC_INITIALIZED;
 			clear_bit(TTY_IO_ERROR, &tty->flags);
 		}
 		clear_bit(ST_INITIALIZING, &portp->state);
@@ -849,31 +838,7 @@ static int stli_open(struct tty_struct *tty, struct file *filp)
 		if (rc < 0)
 			return rc;
 	}
-
-/*
- *	Check if this port is in the middle of closing. If so then wait
- *	until it is closed then return error status, based on flag settings.
- *	The sleep here does not need interrupt protection since the wakeup
- *	for it is done with the same context.
- */
-	if (portp->port.flags & ASYNC_CLOSING) {
-		interruptible_sleep_on(&portp->port.close_wait);
-		if (portp->port.flags & ASYNC_HUP_NOTIFY)
-			return -EAGAIN;
-		return -ERESTARTSYS;
-	}
-
-/*
- *	Based on type of open being done check if it can overlap with any
- *	previous opens still in effect. If we are a normal serial device
- *	then also we might have to wait for carrier.
- */
-	if (!(filp->f_flags & O_NONBLOCK)) {
-		if ((rc = stli_waitcarrier(tty, brdp, portp, filp)) != 0)
-			return rc;
-	}
-	portp->port.flags |= ASYNC_NORMAL_ACTIVE;
-	return 0;
+	return tty_port_block_til_ready(&portp->port, tty, filp);
 }
 
 /*****************************************************************************/
@@ -882,25 +847,29 @@ static void stli_close(struct tty_struct *tty, struct file *filp)
 {
 	struct stlibrd *brdp;
 	struct stliport *portp;
+	struct tty_port *port;
 	unsigned long flags;
 
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return;
+	port = &portp->port;
 
-	spin_lock_irqsave(&stli_lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&stli_lock, flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 		return;
 	}
-	if ((tty->count == 1) && (portp->port.count != 1))
-		portp->port.count = 1;
-	if (portp->port.count-- > 1) {
-		spin_unlock_irqrestore(&stli_lock, flags);
+	if (tty->count == 1 && port->count != 1)
+		port->count = 1;
+	if (port->count-- > 1) {
+		spin_unlock_irqrestore(&port->lock, flags);
 		return;
 	}
 
-	portp->port.flags |= ASYNC_CLOSING;
+	port->flags |= ASYNC_CLOSING;
+	tty->closing = 1;
+	spin_unlock_irqrestore(&port->lock, flags);
 
 /*
  *	May want to wait for data to drain before closing. The BUSY flag
@@ -908,15 +877,17 @@ static void stli_close(struct tty_struct *tty, struct file *filp)
  *	updated by messages from the slave - indicating when all chars
  *	really have drained.
  */
+ 	spin_lock_irqsave(&stli_lock, flags);
 	if (tty == stli_txcooktty)
 		stli_flushchars(tty);
-	tty->closing = 1;
 	spin_unlock_irqrestore(&stli_lock, flags);
 
 	if (portp->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, portp->closing_wait);
 
-	portp->port.flags &= ~ASYNC_INITIALIZED;
+	/* FIXME: port locking here needs attending to */
+	port->flags &= ~ASYNC_INITIALIZED;
+
 	brdp = stli_brds[portp->brdnr];
 	stli_rawclose(brdp, portp, 0, 0);
 	if (tty->termios->c_cflag & HUPCL) {
@@ -937,14 +908,14 @@ static void stli_close(struct tty_struct *tty, struct file *filp)
 	tty->closing = 0;
 	tty_port_tty_set(&portp->port, NULL);
 
-	if (portp->openwaitcnt) {
+	if (port->blocked_open) {
 		if (portp->close_delay)
 			msleep_interruptible(jiffies_to_msecs(portp->close_delay));
-		wake_up_interruptible(&portp->port.open_wait);
+		wake_up_interruptible(&port->open_wait);
 	}
 
-	portp->port.flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
-	wake_up_interruptible(&portp->port.close_wait);
+	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
+	wake_up_interruptible(&port->close_wait);
 }
 
 /*****************************************************************************/
@@ -1189,63 +1160,17 @@ static int stli_carrier_raised(struct tty_port *port)
 	return (portp->sigs & TIOCM_CD) ? 1 : 0;
 }
 
-/*
- *	Possibly need to wait for carrier (DCD signal) to come high. Say
- *	maybe because if we are clocal then we don't need to wait...
- */
-
-static int stli_waitcarrier(struct tty_struct *tty, struct stlibrd *brdp,
-				struct stliport *portp, struct file *filp)
+static void stli_raise_dtr_rts(struct tty_port *port)
 {
-	unsigned long flags;
-	int rc, doclocal;
-	struct tty_port *port = &portp->port;
-
-	rc = 0;
-	doclocal = 0;
-
-	if (tty->termios->c_cflag & CLOCAL)
-		doclocal++;
-
-	spin_lock_irqsave(&stli_lock, flags);
-	portp->openwaitcnt++;
-	if (! tty_hung_up_p(filp))
-		port->count--;
-	spin_unlock_irqrestore(&stli_lock, flags);
-
-	for (;;) {
-		stli_mkasysigs(&portp->asig, 1, 1);
-		if ((rc = stli_cmdwait(brdp, portp, A_SETSIGNALS,
-		    &portp->asig, sizeof(asysigs_t), 0)) < 0)
-			break;
-		if (tty_hung_up_p(filp) ||
-		    ((port->flags & ASYNC_INITIALIZED) == 0)) {
-			if (port->flags & ASYNC_HUP_NOTIFY)
-				rc = -EBUSY;
-			else
-				rc = -ERESTARTSYS;
-			break;
-		}
-		if (((port->flags & ASYNC_CLOSING) == 0) &&
-		    (doclocal || tty_port_carrier_raised(port))) {
-			break;
-		}
-		if (signal_pending(current)) {
-			rc = -ERESTARTSYS;
-			break;
-		}
-		interruptible_sleep_on(&port->open_wait);
-	}
-
-	spin_lock_irqsave(&stli_lock, flags);
-	if (! tty_hung_up_p(filp))
-		port->count++;
-	portp->openwaitcnt--;
-	spin_unlock_irqrestore(&stli_lock, flags);
-
-	return rc;
+	struct stliport *portp = container_of(port, struct stliport, port);
+	struct stlibrd *brdp = stli_brds[portp->brdnr];
+	stli_mkasysigs(&portp->asig, 1, 1);
+	if (stli_cmdwait(brdp, portp, A_SETSIGNALS, &portp->asig,
+		sizeof(asysigs_t), 0) < 0)
+			printk(KERN_WARNING "istallion: dtr raise failed.\n");
 }
 
+
 /*****************************************************************************/
 
 /*
@@ -1828,6 +1753,7 @@ static void stli_hangup(struct tty_struct *tty)
 {
 	struct stliport *portp;
 	struct stlibrd *brdp;
+	struct tty_port *port;
 	unsigned long flags;
 
 	portp = tty->driver_data;
@@ -1838,8 +1764,11 @@ static void stli_hangup(struct tty_struct *tty)
 	brdp = stli_brds[portp->brdnr];
 	if (brdp == NULL)
 		return;
+	port = &portp->port;
 
-	portp->port.flags &= ~ASYNC_INITIALIZED;
+	spin_lock_irqsave(&port->lock, flags);
+	port->flags &= ~ASYNC_INITIALIZED;
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	if (!test_bit(ST_CLOSING, &portp->state))
 		stli_rawclose(brdp, portp, 0, 0);
@@ -1860,12 +1789,9 @@ static void stli_hangup(struct tty_struct *tty)
 	clear_bit(ST_TXBUSY, &portp->state);
 	clear_bit(ST_RXSTOP, &portp->state);
 	set_bit(TTY_IO_ERROR, &tty->flags);
-	tty_port_tty_set(&portp->port, NULL);
-	portp->port.flags &= ~ASYNC_NORMAL_ACTIVE;
-	portp->port.count = 0;
 	spin_unlock_irqrestore(&stli_lock, flags);
 
-	wake_up_interruptible(&portp->port.open_wait);
+	tty_port_hangup(port);
 }
 
 /*****************************************************************************/
@@ -4528,6 +4454,7 @@ static const struct tty_operations stli_ops = {
 
 static const struct tty_port_operations stli_port_ops = {
 	.carrier_raised = stli_carrier_raised,
+	.raise_dtr_rts = stli_raise_dtr_rts,
 };
 
 /*****************************************************************************/
diff --git a/include/linux/istallion.h b/include/linux/istallion.h
index 0d18407..053d5ae 100644
--- a/include/linux/istallion.h
+++ b/include/linux/istallion.h
@@ -61,7 +61,6 @@ struct stliport {
 	int			custom_divisor;
 	int			close_delay;
 	int			closing_wait;
-	int			openwaitcnt;
 	int			rc;
 	int			argsize;
 	void			*argp;

