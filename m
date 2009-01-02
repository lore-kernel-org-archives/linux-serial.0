From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 41/75] tty: rework stallion to use the tty_port bits
Date: Fri, 02 Jan 2009 13:46:24 +0000
Message-ID: <20090102134623.13472.30528.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37587 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756868AbZABNqK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:10 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/stallion.c |  142 +++++++++++++----------------------------------
 1 files changed, 38 insertions(+), 104 deletions(-)


diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 12aecda..77eef61 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -409,7 +409,6 @@ static int	stl_memioctl(struct inode *ip, struct file *fp, unsigned int cmd, uns
 static int	stl_brdinit(struct stlbrd *brdp);
 static int	stl_getportstats(struct tty_struct *tty, struct stlport *portp, comstats_t __user *cp);
 static int	stl_clrportstats(struct stlport *portp, comstats_t __user *cp);
-static int	stl_waitcarrier(struct tty_struct *tty, struct stlport *portp, struct file *filp);
 
 /*
  *	CD1400 uart specific handling functions.
@@ -705,8 +704,9 @@ static int stl_open(struct tty_struct *tty, struct file *filp)
 {
 	struct stlport	*portp;
 	struct stlbrd	*brdp;
+	struct tty_port *port;
 	unsigned int	minordev, brdnr, panelnr;
-	int		portnr, rc;
+	int		portnr;
 
 	pr_debug("stl_open(tty=%p,filp=%p): device=%s\n", tty, filp, tty->name);
 
@@ -717,6 +717,7 @@ static int stl_open(struct tty_struct *tty, struct file *filp)
 	brdp = stl_brds[brdnr];
 	if (brdp == NULL)
 		return -ENODEV;
+
 	minordev = MINOR2PORT(minordev);
 	for (portnr = -1, panelnr = 0; panelnr < STL_MAXPANELS; panelnr++) {
 		if (brdp->panels[panelnr] == NULL)
@@ -733,16 +734,17 @@ static int stl_open(struct tty_struct *tty, struct file *filp)
 	portp = brdp->panels[panelnr]->ports[portnr];
 	if (portp == NULL)
 		return -ENODEV;
+	port = &portp->port;
 
 /*
  *	On the first open of the device setup the port hardware, and
  *	initialize the per port data structure.
  */
-	tty_port_tty_set(&portp->port, tty);
+	tty_port_tty_set(port, tty);
 	tty->driver_data = portp;
-	portp->port.count++;
+	port->count++;
 
-	if ((portp->port.flags & ASYNC_INITIALIZED) == 0) {
+	if ((port->flags & ASYNC_INITIALIZED) == 0) {
 		if (!portp->tx.buf) {
 			portp->tx.buf = kmalloc(STL_TXBUFSIZE, GFP_KERNEL);
 			if (!portp->tx.buf)
@@ -756,34 +758,9 @@ static int stl_open(struct tty_struct *tty, struct file *filp)
 		stl_enablerxtx(portp, 1, 1);
 		stl_startrxtx(portp, 1, 0);
 		clear_bit(TTY_IO_ERROR, &tty->flags);
-		portp->port.flags |= ASYNC_INITIALIZED;
-	}
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
+		port->flags |= ASYNC_INITIALIZED;
 	}
-
-/*
- *	Based on type of open being done check if it can overlap with any
- *	previous opens still in effect. If we are a normal serial device
- *	then also we might have to wait for carrier.
- */
-	if (!(filp->f_flags & O_NONBLOCK))
-		if ((rc = stl_waitcarrier(tty, portp, filp)) != 0)
-			return rc;
-
-	portp->port.flags |= ASYNC_NORMAL_ACTIVE;
-
-	return 0;
+	return tty_port_block_til_ready(port, tty, filp);
 }
 
 /*****************************************************************************/
@@ -794,60 +771,11 @@ static int stl_carrier_raised(struct tty_port *port)
 	return (portp->sigs & TIOCM_CD) ? 1 : 0;
 }
 
-/*
- *	Possibly need to wait for carrier (DCD signal) to come high. Say
- *	maybe because if we are clocal then we don't need to wait...
- */
-
-static int stl_waitcarrier(struct tty_struct *tty, struct stlport *portp,
-							struct file *filp)
+static void stl_raise_dtr_rts(struct tty_port *port)
 {
-	unsigned long	flags;
-	int		rc, doclocal;
-	struct tty_port *port = &portp->port;
-
-	pr_debug("stl_waitcarrier(portp=%p,filp=%p)\n", portp, filp);
-
-	rc = 0;
-	doclocal = 0;
-
-	spin_lock_irqsave(&stallion_lock, flags);
-
-	if (tty->termios->c_cflag & CLOCAL)
-		doclocal++;
-
-	portp->openwaitcnt++;
-	if (! tty_hung_up_p(filp))
-		port->count--;
-
-	for (;;) {
-		/* Takes brd_lock internally */
-		stl_setsignals(portp, 1, 1);
-		if (tty_hung_up_p(filp) ||
-		    ((port->flags & ASYNC_INITIALIZED) == 0)) {
-			if (port->flags & ASYNC_HUP_NOTIFY)
-				rc = -EBUSY;
-			else
-				rc = -ERESTARTSYS;
-			break;
-		}
-		if (((port->flags & ASYNC_CLOSING) == 0) &&
-		    (doclocal || tty_port_carrier_raised(port)))
-			break;
-		if (signal_pending(current)) {
-			rc = -ERESTARTSYS;
-			break;
-		}
-		/* FIXME */
-		interruptible_sleep_on(&port->open_wait);
-	}
-
-	if (! tty_hung_up_p(filp))
-		port->count++;
-	portp->openwaitcnt--;
-	spin_unlock_irqrestore(&stallion_lock, flags);
-
-	return rc;
+	struct stlport *portp = container_of(port, struct stlport, port);
+	/* Takes brd_lock internally */
+	stl_setsignals(portp, 1, 1);
 }
 
 /*****************************************************************************/
@@ -899,6 +827,7 @@ static void stl_waituntilsent(struct tty_struct *tty, int timeout)
 static void stl_close(struct tty_struct *tty, struct file *filp)
 {
 	struct stlport	*portp;
+	struct tty_port *port;
 	unsigned long	flags;
 
 	pr_debug("stl_close(tty=%p,filp=%p)\n", tty, filp);
@@ -906,21 +835,22 @@ static void stl_close(struct tty_struct *tty, struct file *filp)
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return;
+	port = &portp->port;
 
-	spin_lock_irqsave(&stallion_lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&stallion_lock, flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 		return;
 	}
-	if ((tty->count == 1) && (portp->port.count != 1))
-		portp->port.count = 1;
-	if (portp->port.count-- > 1) {
-		spin_unlock_irqrestore(&stallion_lock, flags);
+	if (tty->count == 1 && port->count != 1)
+		port->count = 1;
+	if (port->count-- > 1) {
+		spin_unlock_irqrestore(&port->lock, flags);
 		return;
 	}
 
-	portp->port.count = 0;
-	portp->port.flags |= ASYNC_CLOSING;
+	port->count = 0;
+	port->flags |= ASYNC_CLOSING;
 
 /*
  *	May want to wait for any data to drain before closing. The BUSY
@@ -930,16 +860,16 @@ static void stl_close(struct tty_struct *tty, struct file *filp)
  */
 	tty->closing = 1;
 
-	spin_unlock_irqrestore(&stallion_lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	if (portp->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, portp->closing_wait);
 	stl_waituntilsent(tty, (HZ / 2));
 
 
-	spin_lock_irqsave(&stallion_lock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 	portp->port.flags &= ~ASYNC_INITIALIZED;
-	spin_unlock_irqrestore(&stallion_lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	stl_disableintrs(portp);
 	if (tty->termios->c_cflag & HUPCL)
@@ -957,16 +887,16 @@ static void stl_close(struct tty_struct *tty, struct file *filp)
 	tty_ldisc_flush(tty);
 
 	tty->closing = 0;
-	tty_port_tty_set(&portp->port, NULL);
+	tty_port_tty_set(port, NULL);
 
-	if (portp->openwaitcnt) {
+	if (port->blocked_open) {
 		if (portp->close_delay)
 			msleep_interruptible(jiffies_to_msecs(portp->close_delay));
 		wake_up_interruptible(&portp->port.open_wait);
 	}
 
 	portp->port.flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
-	wake_up_interruptible(&portp->port.close_wait);
+	wake_up_interruptible(&port->close_wait);
 }
 
 /*****************************************************************************/
@@ -1414,14 +1344,20 @@ static void stl_stop(struct tty_struct *tty)
 static void stl_hangup(struct tty_struct *tty)
 {
 	struct stlport	*portp;
+	struct tty_port *port;
+	unsigned long flags;
 
 	pr_debug("stl_hangup(tty=%p)\n", tty);
 
 	portp = tty->driver_data;
 	if (portp == NULL)
 		return;
+	port = &portp->port;
+
+	spin_lock_irqsave(&port->lock, flags);
+	port->flags &= ~ASYNC_INITIALIZED;
+	spin_unlock_irqrestore(&port->lock, flags);
 
-	portp->port.flags &= ~ASYNC_INITIALIZED;
 	stl_disableintrs(portp);
 	if (tty->termios->c_cflag & HUPCL)
 		stl_setsignals(portp, 0, 0);
@@ -1435,10 +1371,7 @@ static void stl_hangup(struct tty_struct *tty)
 		portp->tx.head = NULL;
 		portp->tx.tail = NULL;
 	}
-	tty_port_tty_set(&portp->port, NULL);
-	portp->port.flags &= ~ASYNC_NORMAL_ACTIVE;
-	portp->port.count = 0;
-	wake_up_interruptible(&portp->port.open_wait);
+	tty_port_hangup(port);
 }
 
 /*****************************************************************************/
@@ -2671,6 +2604,7 @@ static const struct tty_operations stl_ops = {
 
 static const struct tty_port_operations stl_port_ops = {
 	.carrier_raised = stl_carrier_raised,
+	.raise_dtr_rts = stl_raise_dtr_rts,
 };
 
 /*****************************************************************************/

