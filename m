From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 31/75] tty_port: Add a port level carrier detect operation
Date: Fri, 02 Jan 2009 13:45:05 +0000
Message-ID: <20090102134501.13472.66364.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37591 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756974AbZABNqR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:17 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

This is the first step to generalising the various pieces of waiting logic
duplicated in all sorts of serial drivers.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/esp.c             |   61 +++++++++++++++++++++++---------------
 drivers/char/generic_serial.c  |   43 ++++++++++++++------------
 drivers/char/isicom.c          |   51 ++++++++++++++++++++-----------
 drivers/char/istallion.c       |   28 ++++++++++++-----
 drivers/char/moxa.c            |   26 +++++++++++++---
 drivers/char/mxser.c           |   54 ++++++++++++++++++++-------------
 drivers/char/rio/rio_linux.c   |   18 +++++------
 drivers/char/riscom8.c         |   65 +++++++++++++++++++++++++---------------
 drivers/char/rocket.c          |   40 ++++++++++++++++---------
 drivers/char/ser_a2232.c       |   19 ++++++------
 drivers/char/stallion.c        |   28 +++++++++++++----
 drivers/char/sx.c              |   27 +++++++++--------
 drivers/char/synclink.c        |   61 +++++++++++++++++++++++++-------------
 drivers/char/synclink_gt.c     |   48 +++++++++++++++++++-----------
 drivers/char/synclinkmp.c      |   55 ++++++++++++++++++++++------------
 drivers/char/tty_port.c        |   17 ++++++++++
 drivers/char/vme_scc.c         |   15 ++++++---
 include/linux/generic_serial.h |    1 -
 include/linux/tty.h            |    9 ++++++
 19 files changed, 427 insertions(+), 239 deletions(-)


diff --git a/drivers/char/esp.c b/drivers/char/esp.c
index 7f077c0..45ec263 100644
--- a/drivers/char/esp.c
+++ b/drivers/char/esp.c
@@ -2054,6 +2054,15 @@ static void esp_hangup(struct tty_struct *tty)
 	wake_up_interruptible(&info->port.open_wait);
 }
 
+static int esp_carrier_raised(struct tty_port *port)
+{
+	struct esp_struct *info = container_of(port, struct esp_struct, port);
+	serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
+	if (serial_in(info, UART_ESI_STAT2) & UART_MSR_DCD)
+		return 1;
+	return 0;
+}
+
 /*
  * ------------------------------------------------------------
  * esp_open() and friends
@@ -2066,17 +2075,19 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	int		retval;
 	int		do_clocal = 0;
 	unsigned long	flags;
+	int		cd;
+	struct tty_port *port = &info->port;
 
 	/*
 	 * If the device is in the middle of being closed, then block
 	 * until it's done, and then try again.
 	 */
 	if (tty_hung_up_p(filp) ||
-	    (info->port.flags & ASYNC_CLOSING)) {
-		if (info->port.flags & ASYNC_CLOSING)
-			interruptible_sleep_on(&info->port.close_wait);
+	    (port->flags & ASYNC_CLOSING)) {
+		if (port->flags & ASYNC_CLOSING)
+			interruptible_sleep_on(&port->close_wait);
 #ifdef SERIAL_DO_RESTART
-		if (info->port.flags & ASYNC_HUP_NOTIFY)
+		if (port->flags & ASYNC_HUP_NOTIFY)
 			return -EAGAIN;
 		else
 			return -ERESTARTSYS;
@@ -2091,7 +2102,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	 */
 	if ((filp->f_flags & O_NONBLOCK) ||
 	    (tty->flags & (1 << TTY_IO_ERROR))) {
-		info->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 
@@ -2101,20 +2112,20 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	/*
 	 * Block waiting for the carrier detect and the line to become
 	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, info->port.count is dropped by one, so that
+	 * this loop, port->count is dropped by one, so that
 	 * rs_close() knows when to free things.  We restore it upon
 	 * exit, either normal or abnormal.
 	 */
 	retval = 0;
-	add_wait_queue(&info->port.open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 #ifdef SERIAL_DEBUG_OPEN
 	printk(KERN_DEBUG "block_til_ready before block: ttys%d, count = %d\n",
-	       info->line, info->port.count);
+	       info->line, port->count);
 #endif
 	spin_lock_irqsave(&info->lock, flags);
 	if (!tty_hung_up_p(filp))
-		info->port.count--;
-	info->port.blocked_open++;
+		port->count--;
+	port->blocked_open++;
 	while (1) {
 		if ((tty->termios->c_cflag & CBAUD)) {
 			unsigned int scratch;
@@ -2129,9 +2140,9 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
-		    !(info->port.flags & ASYNC_INITIALIZED)) {
+		    !(port->flags & ASYNC_INITIALIZED)) {
 #ifdef SERIAL_DO_RESTART
-			if (info->port.flags & ASYNC_HUP_NOTIFY)
+			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
@@ -2141,11 +2152,9 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 			break;
 		}
 
-		serial_out(info, UART_ESI_CMD1, ESI_GET_UART_STAT);
-		if (serial_in(info, UART_ESI_STAT2) & UART_MSR_DCD)
-			do_clocal = 1;
+		cd = tty_port_carrier_raised(port);
 
-		if (!(info->port.flags & ASYNC_CLOSING) &&
+		if (!(port->flags & ASYNC_CLOSING) &&
 		    (do_clocal))
 			break;
 		if (signal_pending(current)) {
@@ -2154,25 +2163,25 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		}
 #ifdef SERIAL_DEBUG_OPEN
 		printk(KERN_DEBUG "block_til_ready blocking: ttys%d, count = %d\n",
-		       info->line, info->port.count);
+		       info->line, port->count);
 #endif
 		spin_unlock_irqrestore(&info->lock, flags);
 		schedule();
 		spin_lock_irqsave(&info->lock, flags);
 	}
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&info->port.open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
-		info->port.count++;
-	info->port.blocked_open--;
+		port->count++;
+	port->blocked_open--;
 	spin_unlock_irqrestore(&info->lock, flags);
 #ifdef SERIAL_DEBUG_OPEN
 	printk(KERN_DEBUG "block_til_ready after blocking: ttys%d, count = %d\n",
-	       info->line, info->port.count);
+	       info->line, port->count);
 #endif
 	if (retval)
 		return retval;
-	info->port.flags |= ASYNC_NORMAL_ACTIVE;
+	port->flags |= ASYNC_NORMAL_ACTIVE;
 	return 0;
 }
 
@@ -2329,6 +2338,10 @@ static const struct tty_operations esp_ops = {
 	.tiocmset = esp_tiocmset,
 };
 
+static const struct tty_port_operations esp_port_ops = {
+	.esp_carrier_raised,
+};
+
 /*
  * The serial driver boot-time initialization code!
  */
@@ -2415,6 +2428,8 @@ static int __init espserial_init(void)
 	offset = 0;
 
 	do {
+		tty_port_init(&info->port);
+		info->port.ops = &esp_port_ops;
 		info->io_port = esp[i] + offset;
 		info->irq = irq[i];
 		info->line = (i * 8) + (offset / 8);
@@ -2437,8 +2452,6 @@ static int __init espserial_init(void)
 		info->config.flow_off = flow_off;
 		info->config.pio_threshold = pio_threshold;
 		info->next_port = ports;
-		init_waitqueue_head(&info->port.open_wait);
-		init_waitqueue_head(&info->port.close_wait);
 		init_waitqueue_head(&info->delta_msr_wait);
 		init_waitqueue_head(&info->break_wait);
 		ports = info;
diff --git a/drivers/char/generic_serial.c b/drivers/char/generic_serial.c
index c6090f8..2356994 100644
--- a/drivers/char/generic_serial.c
+++ b/drivers/char/generic_serial.c
@@ -397,7 +397,8 @@ void gs_hangup(struct tty_struct *tty)
 
 int gs_block_til_ready(void *port_, struct file * filp)
 {
-	struct gs_port *port = port_;
+	struct gs_port *gp = port_;
+	struct tty_port *port = &gp->port;
 	DECLARE_WAITQUEUE(wait, current);
 	int    retval;
 	int    do_clocal = 0;
@@ -409,16 +410,16 @@ int gs_block_til_ready(void *port_, struct file * filp)
 
 	if (!port) return 0;
 
-	tty = port->port.tty;
+	tty = port->tty;
 
 	gs_dprintk (GS_DEBUG_BTR, "Entering gs_block_till_ready.\n"); 
 	/*
 	 * If the device is in the middle of being closed, then block
 	 * until it's done, and then try again.
 	 */
-	if (tty_hung_up_p(filp) || port->port.flags & ASYNC_CLOSING) {
-		interruptible_sleep_on(&port->port.close_wait);
-		if (port->port.flags & ASYNC_HUP_NOTIFY)
+	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
+		interruptible_sleep_on(&port->close_wait);
+		if (port->flags & ASYNC_HUP_NOTIFY)
 			return -EAGAIN;
 		else
 			return -ERESTARTSYS;
@@ -432,7 +433,7 @@ int gs_block_til_ready(void *port_, struct file * filp)
 	 */
 	if ((filp->f_flags & O_NONBLOCK) ||
 	    (tty->flags & (1 << TTY_IO_ERROR))) {
-		port->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 
@@ -444,34 +445,34 @@ int gs_block_til_ready(void *port_, struct file * filp)
 	/*
 	 * Block waiting for the carrier detect and the line to become
 	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, port->port.count is dropped by one, so that
+	 * this loop, port->count is dropped by one, so that
 	 * rs_close() knows when to free things.  We restore it upon
 	 * exit, either normal or abnormal.
 	 */
 	retval = 0;
 
-	add_wait_queue(&port->port.open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 
 	gs_dprintk (GS_DEBUG_BTR, "after add waitq.\n"); 
-	spin_lock_irqsave(&port->driver_lock, flags);
+	spin_lock_irqsave(&gp->driver_lock, flags);
 	if (!tty_hung_up_p(filp)) {
-		port->port.count--;
+		port->count--;
 	}
-	spin_unlock_irqrestore(&port->driver_lock, flags);
-	port->port.blocked_open++;
+	spin_unlock_irqrestore(&gp->driver_lock, flags);
+	port->blocked_open++;
 	while (1) {
-		CD = port->rd->get_CD (port);
+		CD = tty_port_carrier_raised(port);
 		gs_dprintk (GS_DEBUG_BTR, "CD is now %d.\n", CD);
 		set_current_state (TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
-		    !(port->port.flags & ASYNC_INITIALIZED)) {
-			if (port->port.flags & ASYNC_HUP_NOTIFY)
+		    !(port->flags & ASYNC_INITIALIZED)) {
+			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
 			break;
 		}
-		if (!(port->port.flags & ASYNC_CLOSING) &&
+		if (!(port->flags & ASYNC_CLOSING) &&
 		    (do_clocal || CD))
 			break;
 		gs_dprintk (GS_DEBUG_BTR, "signal_pending is now: %d (%lx)\n", 
@@ -483,17 +484,17 @@ int gs_block_til_ready(void *port_, struct file * filp)
 		schedule();
 	}
 	gs_dprintk (GS_DEBUG_BTR, "Got out of the loop. (%d)\n",
-		    port->port.blocked_open);
+		    port->blocked_open);
 	set_current_state (TASK_RUNNING);
-	remove_wait_queue(&port->port.open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 	if (!tty_hung_up_p(filp)) {
-		port->port.count++;
+		port->count++;
 	}
-	port->port.blocked_open--;
+	port->blocked_open--;
 	if (retval)
 		return retval;
 
-	port->port.flags |= ASYNC_NORMAL_ACTIVE;
+	port->flags |= ASYNC_NORMAL_ACTIVE;
 	func_exit ();
 	return 0;
 }			 
diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 04e4549..b3da485 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -830,20 +830,28 @@ static int isicom_setup_port(struct tty_struct *tty)
 	return 0;
 }
 
+static int isicom_carrier_raised(struct tty_port *port)
+{
+	struct isi_port *ip = container_of(port, struct isi_port, port);
+	return (ip->status & ISI_DCD)?1 : 0;
+}
+
 static int block_til_ready(struct tty_struct *tty, struct file *filp,
-	struct isi_port *port)
+	struct isi_port *ip)
 {
-	struct isi_board *card = port->card;
+	struct isi_board *card = ip->card;
+	struct tty_port *port = &ip->port;
 	int do_clocal = 0, retval;
 	unsigned long flags;
 	DECLARE_WAITQUEUE(wait, current);
+	int cd;
 
 	/* block if port is in the process of being closed */
 
-	if (tty_hung_up_p(filp) || port->port.flags & ASYNC_CLOSING) {
+	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
 		pr_dbg("block_til_ready: close in progress.\n");
-		interruptible_sleep_on(&port->port.close_wait);
-		if (port->port.flags & ASYNC_HUP_NOTIFY)
+		interruptible_sleep_on(&port->close_wait);
+		if (port->flags & ASYNC_HUP_NOTIFY)
 			return -EAGAIN;
 		else
 			return -ERESTARTSYS;
@@ -854,7 +862,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	if ((filp->f_flags & O_NONBLOCK) ||
 			(tty->flags & (1 << TTY_IO_ERROR))) {
 		pr_dbg("block_til_ready: non-block mode.\n");
-		port->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 
@@ -864,29 +872,29 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	/* block waiting for DCD to be asserted, and while
 						callout dev is busy */
 	retval = 0;
-	add_wait_queue(&port->port.open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 
 	spin_lock_irqsave(&card->card_lock, flags);
 	if (!tty_hung_up_p(filp))
-		port->port.count--;
-	port->port.blocked_open++;
+		port->count--;
+	port->blocked_open++;
 	spin_unlock_irqrestore(&card->card_lock, flags);
 
 	while (1) {
-		raise_dtr_rts(port);
+		raise_dtr_rts(ip);
 
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) || !(port->port.flags & ASYNC_INITIALIZED)) {
-			if (port->port.flags & ASYNC_HUP_NOTIFY)
+		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
+			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
 			break;
 		}
-		if (!(port->port.flags & ASYNC_CLOSING) &&
-				(do_clocal || (port->status & ISI_DCD))) {
+		cd = tty_port_carrier_raised(port);
+		if (!(port->flags & ASYNC_CLOSING) &&
+				(do_clocal || cd))
 			break;
-		}
 		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
 			break;
@@ -894,15 +902,15 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		schedule();
 	}
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&port->port.open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 	spin_lock_irqsave(&card->card_lock, flags);
 	if (!tty_hung_up_p(filp))
-		port->port.count++;
-	port->port.blocked_open--;
+		port->count++;
+	port->blocked_open--;
 	spin_unlock_irqrestore(&card->card_lock, flags);
 	if (retval)
 		return retval;
-	port->port.flags |= ASYNC_NORMAL_ACTIVE;
+	port->flags |= ASYNC_NORMAL_ACTIVE;
 	return 0;
 }
 
@@ -1452,6 +1460,10 @@ static const struct tty_operations isicom_ops = {
 	.break_ctl		= isicom_send_break,
 };
 
+static const struct tty_port_operations isicom_port_ops = {
+	.carrier_raised		= isicom_carrier_raised,
+};
+
 static int __devinit reset_card(struct pci_dev *pdev,
 	const unsigned int card, unsigned int *signature)
 {
@@ -1794,6 +1806,7 @@ static int __init isicom_init(void)
 		spin_lock_init(&isi_card[idx].card_lock);
 		for (channel = 0; channel < 16; channel++, port++) {
 			tty_port_init(&port->port);
+			port->port.ops = &isicom_port_ops;
 			port->magic = ISICOM_MAGIC;
 			port->card = &isi_card[idx];
 			port->channel = channel;
diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 4b10770..c4682f9 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -151,7 +151,7 @@ static char	*stli_drvversion = "5.6.0";
 static char	*stli_serialname = "ttyE";
 
 static struct tty_driver	*stli_serial;
-
+static const struct tty_port_operations stli_port_ops;
 
 #define	STLI_TXBUFSIZE		4096
 
@@ -1183,6 +1183,12 @@ static int stli_setport(struct tty_struct *tty)
 
 /*****************************************************************************/
 
+static int stli_carrier_raised(struct tty_port *port)
+{
+	struct stliport *portp = container_of(port, struct stliport, port);
+	return (portp->sigs & TIOCM_CD) ? 1 : 0;
+}
+
 /*
  *	Possibly need to wait for carrier (DCD signal) to come high. Say
  *	maybe because if we are clocal then we don't need to wait...
@@ -1193,6 +1199,7 @@ static int stli_waitcarrier(struct tty_struct *tty, struct stlibrd *brdp,
 {
 	unsigned long flags;
 	int rc, doclocal;
+	struct tty_port *port = &portp->port;
 
 	rc = 0;
 	doclocal = 0;
@@ -1203,7 +1210,7 @@ static int stli_waitcarrier(struct tty_struct *tty, struct stlibrd *brdp,
 	spin_lock_irqsave(&stli_lock, flags);
 	portp->openwaitcnt++;
 	if (! tty_hung_up_p(filp))
-		portp->port.count--;
+		port->count--;
 	spin_unlock_irqrestore(&stli_lock, flags);
 
 	for (;;) {
@@ -1212,27 +1219,27 @@ static int stli_waitcarrier(struct tty_struct *tty, struct stlibrd *brdp,
 		    &portp->asig, sizeof(asysigs_t), 0)) < 0)
 			break;
 		if (tty_hung_up_p(filp) ||
-		    ((portp->port.flags & ASYNC_INITIALIZED) == 0)) {
-			if (portp->port.flags & ASYNC_HUP_NOTIFY)
+		    ((port->flags & ASYNC_INITIALIZED) == 0)) {
+			if (port->flags & ASYNC_HUP_NOTIFY)
 				rc = -EBUSY;
 			else
 				rc = -ERESTARTSYS;
 			break;
 		}
-		if (((portp->port.flags & ASYNC_CLOSING) == 0) &&
-		    (doclocal || (portp->sigs & TIOCM_CD))) {
+		if (((port->flags & ASYNC_CLOSING) == 0) &&
+		    (doclocal || tty_port_carrier_raised(port))) {
 			break;
 		}
 		if (signal_pending(current)) {
 			rc = -ERESTARTSYS;
 			break;
 		}
-		interruptible_sleep_on(&portp->port.open_wait);
+		interruptible_sleep_on(&port->open_wait);
 	}
 
 	spin_lock_irqsave(&stli_lock, flags);
 	if (! tty_hung_up_p(filp))
-		portp->port.count++;
+		port->count++;
 	portp->openwaitcnt--;
 	spin_unlock_irqrestore(&stli_lock, flags);
 
@@ -2696,6 +2703,7 @@ static int stli_initports(struct stlibrd *brdp)
 			continue;
 		}
 		tty_port_init(&portp->port);
+		portp->port.ops = &stli_port_ops;
 		portp->magic = STLI_PORTMAGIC;
 		portp->portnr = i;
 		portp->brdnr = brdp->brdnr;
@@ -4518,6 +4526,10 @@ static const struct tty_operations stli_ops = {
 	.tiocmset = stli_tiocmset,
 };
 
+static const struct tty_port_operations stli_port_ops = {
+	.carrier_raised = stli_carrier_raised,
+};
+
 /*****************************************************************************/
 /*
  *	Loadable module initialization stuff.
diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index 12d327a..8b0da97 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -206,6 +206,7 @@ static void moxa_poll(unsigned long);
 static void moxa_set_tty_param(struct tty_struct *, struct ktermios *);
 static void moxa_setup_empty_event(struct tty_struct *);
 static void moxa_shut_down(struct tty_struct *);
+static int moxa_carrier_raised(struct tty_port *);
 /*
  * moxa board interface functions:
  */
@@ -405,6 +406,10 @@ static const struct tty_operations moxa_ops = {
 	.tiocmset = moxa_tiocmset,
 };
 
+static const struct tty_port_operations moxa_port_ops = {
+	.carrier_raised = moxa_carrier_raised,
+};
+
 static struct tty_driver *moxaDriver;
 static DEFINE_TIMER(moxaTimer, moxa_poll, 0, 0);
 static DEFINE_SPINLOCK(moxa_lock);
@@ -826,6 +831,7 @@ static int moxa_init_board(struct moxa_board_conf *brd, struct device *dev)
 
 	for (i = 0, p = brd->ports; i < MAX_PORTS_PER_BOARD; i++, p++) {
 		tty_port_init(&p->port);
+		p->port.ops = &moxa_port_ops;
 		p->type = PORT_16550A;
 		p->cflag = B9600 | CS8 | CREAD | CLOCAL | HUPCL;
 	}
@@ -1115,15 +1121,27 @@ static void moxa_close_port(struct tty_struct *tty)
 	tty_port_tty_set(&ch->port, NULL);
 }
 
+static int moxa_carrier_raised(struct tty_port *port)
+{
+	struct moxa_port *ch = container_of(port, struct moxa_port, port);
+	int dcd;
+
+	spin_lock_bh(&moxa_lock);
+	dcd = ch->DCDState;
+	spin_unlock_bh(&moxa_lock);
+	return dcd;
+}
+
 static int moxa_block_till_ready(struct tty_struct *tty, struct file *filp,
 			    struct moxa_port *ch)
 {
+	struct tty_port *port = &ch->port;
 	DEFINE_WAIT(wait);
 	int retval = 0;
 	u8 dcd;
 
 	while (1) {
-		prepare_to_wait(&ch->port.open_wait, &wait, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&port->open_wait, &wait, TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp)) {
 #ifdef SERIAL_DO_RESTART
 			retval = -ERESTARTSYS;
@@ -1132,9 +1150,7 @@ static int moxa_block_till_ready(struct tty_struct *tty, struct file *filp,
 #endif
 			break;
 		}
-		spin_lock_bh(&moxa_lock);
-		dcd = ch->DCDState;
-		spin_unlock_bh(&moxa_lock);
+		dcd = tty_port_carrier_raised(port);
 		if (dcd)
 			break;
 
@@ -1144,7 +1160,7 @@ static int moxa_block_till_ready(struct tty_struct *tty, struct file *filp,
 		}
 		schedule();
 	}
-	finish_wait(&ch->port.open_wait, &wait);
+	finish_wait(&port->open_wait, &wait);
 
 	return retval;
 }
diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
index 0477669..eafbbcf 100644
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -541,13 +541,21 @@ static unsigned char mxser_get_msr(int baseaddr, int mode, int port)
 	return status;
 }
 
+static int mxser_carrier_raised(struct tty_port *port)
+{
+	struct mxser_port *mp = container_of(port, struct mxser_port, port);
+	return (inb(mp->ioaddr + UART_MSR) & UART_MSR_DCD)?1:0;
+}
+
 static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
-		struct mxser_port *port)
+		struct mxser_port *mp)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int retval;
 	int do_clocal = 0;
 	unsigned long flags;
+	int cd;
+	struct tty_port *port = &mp->port;
 
 	/*
 	 * If non-blocking mode is set, or the port is not enabled,
@@ -555,7 +563,7 @@ static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
 	 */
 	if ((filp->f_flags & O_NONBLOCK) ||
 			test_bit(TTY_IO_ERROR, &tty->flags)) {
-		port->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 
@@ -565,34 +573,33 @@ static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
 	/*
 	 * Block waiting for the carrier detect and the line to become
 	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, port->port.count is dropped by one, so that
+	 * this loop, port->count is dropped by one, so that
 	 * mxser_close() knows when to free things.  We restore it upon
 	 * exit, either normal or abnormal.
 	 */
 	retval = 0;
-	add_wait_queue(&port->port.open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 
-	spin_lock_irqsave(&port->slock, flags);
+	spin_lock_irqsave(&mp->slock, flags);
 	if (!tty_hung_up_p(filp))
-		port->port.count--;
-	spin_unlock_irqrestore(&port->slock, flags);
-	port->port.blocked_open++;
+		port->count--;
+	spin_unlock_irqrestore(&mp->slock, flags);
+	port->blocked_open++;
 	while (1) {
-		spin_lock_irqsave(&port->slock, flags);
-		outb(inb(port->ioaddr + UART_MCR) |
-			UART_MCR_DTR | UART_MCR_RTS, port->ioaddr + UART_MCR);
-		spin_unlock_irqrestore(&port->slock, flags);
+		spin_lock_irqsave(&mp->slock, flags);
+		outb(inb(mp->ioaddr + UART_MCR) |
+			UART_MCR_DTR | UART_MCR_RTS, mp->ioaddr + UART_MCR);
+		spin_unlock_irqrestore(&mp->slock, flags);
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) || !(port->port.flags & ASYNC_INITIALIZED)) {
-			if (port->port.flags & ASYNC_HUP_NOTIFY)
+		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
+			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
 			break;
 		}
-		if (!(port->port.flags & ASYNC_CLOSING) &&
-				(do_clocal ||
-				(inb(port->ioaddr + UART_MSR) & UART_MSR_DCD)))
+		cd = tty_port_carrier_raised(port);
+		if (!(port->flags & ASYNC_CLOSING) && (do_clocal || cd))
 			break;
 		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
@@ -601,13 +608,13 @@ static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
 		schedule();
 	}
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&port->port.open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
-		port->port.count++;
-	port->port.blocked_open--;
+		port->count++;
+	port->blocked_open--;
 	if (retval)
 		return retval;
-	port->port.flags |= ASYNC_NORMAL_ACTIVE;
+	port->flags |= ASYNC_NORMAL_ACTIVE;
 	return 0;
 }
 
@@ -2449,6 +2456,10 @@ static const struct tty_operations mxser_ops = {
 	.tiocmset = mxser_tiocmset,
 };
 
+struct tty_port_operations mxser_port_ops = {
+	.carrier_raised = mxser_carrier_raised,
+};
+
 /*
  * The MOXA Smartio/Industio serial driver boot-time initialization code!
  */
@@ -2482,6 +2493,7 @@ static int __devinit mxser_initbrd(struct mxser_board *brd,
 	for (i = 0; i < brd->info->nports; i++) {
 		info = &brd->ports[i];
 		tty_port_init(&info->port);
+		info->port.ops = &mxser_port_ops;
 		info->board = brd;
 		info->stop_rx = 0;
 		info->ldisc_stop_rx = 0;
diff --git a/drivers/char/rio/rio_linux.c b/drivers/char/rio/rio_linux.c
index a8f68a3..ec2afd1 100644
--- a/drivers/char/rio/rio_linux.c
+++ b/drivers/char/rio/rio_linux.c
@@ -173,7 +173,7 @@ static void rio_disable_tx_interrupts(void *ptr);
 static void rio_enable_tx_interrupts(void *ptr);
 static void rio_disable_rx_interrupts(void *ptr);
 static void rio_enable_rx_interrupts(void *ptr);
-static int rio_get_CD(void *ptr);
+static int rio_carrier_raised(struct tty_port *port);
 static void rio_shutdown_port(void *ptr);
 static int rio_set_real_termios(void *ptr);
 static void rio_hungup(void *ptr);
@@ -224,7 +224,6 @@ static struct real_driver rio_real_driver = {
 	rio_enable_tx_interrupts,
 	rio_disable_rx_interrupts,
 	rio_enable_rx_interrupts,
-	rio_get_CD,
 	rio_shutdown_port,
 	rio_set_real_termios,
 	rio_chars_in_buffer,
@@ -476,9 +475,9 @@ static void rio_enable_rx_interrupts(void *ptr)
 
 
 /* Jeez. Isn't this simple?  */
-static int rio_get_CD(void *ptr)
+static int rio_carrier_raised(struct tty_port *port)
 {
-	struct Port *PortP = ptr;
+	struct Port *PortP = container_of(port, struct Port, gs.port);
 	int rv;
 
 	func_enter();
@@ -806,7 +805,9 @@ static void *ckmalloc(int size)
 	return p;
 }
 
-
+static const struct tty_port_operations rio_port_ops = {
+	.carrier_raised = rio_carrier_raised,
+};
 
 static int rio_init_datastructures(void)
 {
@@ -842,17 +843,14 @@ static int rio_init_datastructures(void)
 			goto free6;
 		}
 		rio_dprintk(RIO_DEBUG_INIT, "initing port %d (%d)\n", i, port->Mapped);
+		tty_port_init(&port->gs.port);
+		port->gs.port.ops = &rio_port_ops;
 		port->PortNum = i;
 		port->gs.magic = RIO_MAGIC;
 		port->gs.close_delay = HZ / 2;
 		port->gs.closing_wait = 30 * HZ;
 		port->gs.rd = &rio_real_driver;
 		spin_lock_init(&port->portSem);
-		/*
-		 * Initializing wait queue
-		 */
-		init_waitqueue_head(&port->gs.port.open_wait);
-		init_waitqueue_head(&port->gs.port.close_wait);
 	}
 #else
 	/* We could postpone initializing them to when they are configured. */
diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
index 2c6c8f3..6ad1c2a 100644
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -857,23 +857,40 @@ static void rc_shutdown_port(struct tty_struct *tty,
 		rc_shutdown_board(bp);
 }
 
+static int carrier_raised(struct tty_port *port)
+{
+	struct riscom_port *p = container_of(port, struct riscom_port, port);
+	struct riscom_board *bp = port_Board(p);
+	unsigned long flags;
+	int CD;
+	
+	spin_lock_irqsave(&riscom_lock, flags);
+	rc_out(bp, CD180_CAR, port_No(p));
+	CD = rc_in(bp, CD180_MSVR) & MSVR_CD;
+	rc_out(bp, CD180_MSVR, MSVR_RTS);
+	bp->DTR &= ~(1u << port_No(p));
+	rc_out(bp, RC_DTR, bp->DTR);
+	spin_unlock_irqrestore(&riscom_lock, flags);
+	return CD;
+}
+
 static int block_til_ready(struct tty_struct *tty, struct file *filp,
-			   struct riscom_port *port)
+			   struct riscom_port *rp)
 {
 	DECLARE_WAITQUEUE(wait, current);
-	struct riscom_board *bp = port_Board(port);
 	int    retval;
 	int    do_clocal = 0;
 	int    CD;
 	unsigned long flags;
+	struct tty_port *port = &rp->port;
 
 	/*
 	 * If the device is in the middle of being closed, then block
 	 * until it's done, and then try again.
 	 */
-	if (tty_hung_up_p(filp) || port->port.flags & ASYNC_CLOSING) {
-		interruptible_sleep_on(&port->port.close_wait);
-		if (port->port.flags & ASYNC_HUP_NOTIFY)
+	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
+		interruptible_sleep_on(&port->close_wait);
+		if (port->flags & ASYNC_HUP_NOTIFY)
 			return -EAGAIN;
 		else
 			return -ERESTARTSYS;
@@ -885,7 +902,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	 */
 	if ((filp->f_flags & O_NONBLOCK) ||
 	    (tty->flags & (1 << TTY_IO_ERROR))) {
-		port->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 
@@ -900,37 +917,29 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	 * exit, either normal or abnormal.
 	 */
 	retval = 0;
-	add_wait_queue(&port->port.open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 
 	spin_lock_irqsave(&riscom_lock, flags);
 
 	if (!tty_hung_up_p(filp))
-		port->port.count--;
+		port->count--;
 
 	spin_unlock_irqrestore(&riscom_lock, flags);
 
-	port->port.blocked_open++;
+	port->blocked_open++;
 	while (1) {
-		spin_lock_irqsave(&riscom_lock, flags);
-
-		rc_out(bp, CD180_CAR, port_No(port));
-		CD = rc_in(bp, CD180_MSVR) & MSVR_CD;
-		rc_out(bp, CD180_MSVR, MSVR_RTS);
-		bp->DTR &= ~(1u << port_No(port));
-		rc_out(bp, RC_DTR, bp->DTR);
-
-		spin_unlock_irqrestore(&riscom_lock, flags);
 
+		CD = tty_port_carrier_raised(port);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
-		    !(port->port.flags & ASYNC_INITIALIZED)) {
-			if (port->port.flags & ASYNC_HUP_NOTIFY)
+		    !(port->flags & ASYNC_INITIALIZED)) {
+			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
 			break;
 		}
-		if (!(port->port.flags & ASYNC_CLOSING) &&
+		if (!(port->flags & ASYNC_CLOSING) &&
 		    (do_clocal || CD))
 			break;
 		if (signal_pending(current)) {
@@ -940,14 +949,14 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&port->port.open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
-		port->port.count++;
-	port->port.blocked_open--;
+		port->count++;
+	port->blocked_open--;
 	if (retval)
 		return retval;
 
-	port->port.flags |= ASYNC_NORMAL_ACTIVE;
+	port->flags |= ASYNC_NORMAL_ACTIVE;
 	return 0;
 }
 
@@ -1510,6 +1519,11 @@ static const struct tty_operations riscom_ops = {
 	.break_ctl = rc_send_break,
 };
 
+static const struct tty_port_operations riscom_port_ops = {
+	.carrier_raised = carrier_raised,
+};
+
+
 static int __init rc_init_drivers(void)
 {
 	int error;
@@ -1541,6 +1555,7 @@ static int __init rc_init_drivers(void)
 	memset(rc_port, 0, sizeof(rc_port));
 	for (i = 0; i < RC_NPORT * RC_NBOARD; i++)  {
 		tty_port_init(&rc_port[i].port);
+		rc_port[i].port.ops = &riscom_port_ops;
 		rc_port[i].magic = RISCOM8_MAGIC;
 	}
 	return 0;
diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
index 584d791..4a4110e 100644
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -135,6 +135,7 @@ static int rcktpt_type[NUM_BOARDS];
 static int is_PCI[NUM_BOARDS];
 static rocketModel_t rocketModel[NUM_BOARDS];
 static int max_board;
+static const struct tty_port_operations rocket_port_ops;
 
 /*
  * The following arrays define the interrupt bits corresponding to each AIOP.
@@ -649,9 +650,8 @@ static void init_r_port(int board, int aiop, int chan, struct pci_dev *pci_dev)
 	info->board = board;
 	info->aiop = aiop;
 	info->chan = chan;
-	info->port.closing_wait = 3000;
-	info->port.close_delay = 50;
-	init_waitqueue_head(&info->port.open_wait);
+	tty_port_init(&info->port);
+	info->port.ops = &rocket_port_ops;
 	init_completion(&info->close_wait);
 	info->flags &= ~ROCKET_MODE_MASK;
 	switch (pc104[board][line]) {
@@ -864,11 +864,18 @@ static void configure_r_port(struct r_port *info,
 	}
 }
 
+static int carrier_raised(struct tty_port *port)
+{
+	struct r_port *info = container_of(port, struct r_port, port);
+	return (sGetChanStatusLo(&info->channel) & CD_ACT) ? 1 : 0;
+}
+
 /*  info->port.count is considered critical, protected by spinlocks.  */
 static int block_til_ready(struct tty_struct *tty, struct file *filp,
 			   struct r_port *info)
 {
 	DECLARE_WAITQUEUE(wait, current);
+	struct tty_port *port = &info->port;
 	int retval;
 	int do_clocal = 0, extra_count = 0;
 	unsigned long flags;
@@ -898,13 +905,13 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 
 	/*
 	 * Block waiting for the carrier detect and the line to become free.  While we are in
-	 * this loop, info->port.count is dropped by one, so that rp_close() knows when to free things.
+	 * this loop, port->count is dropped by one, so that rp_close() knows when to free things.
          * We restore it upon exit, either normal or abnormal.
 	 */
 	retval = 0;
-	add_wait_queue(&info->port.open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 #ifdef ROCKET_DEBUG_OPEN
-	printk(KERN_INFO "block_til_ready before block: ttyR%d, count = %d\n", info->line, info->port.count);
+	printk(KERN_INFO "block_til_ready before block: ttyR%d, count = %d\n", info->line, port->count);
 #endif
 	spin_lock_irqsave(&info->slock, flags);
 
@@ -913,10 +920,10 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 #else
 	if (!tty_hung_up_p(filp)) {
 		extra_count = 1;
-		info->port.count--;
+		port->count--;
 	}
 #endif
-	info->port.blocked_open++;
+	port->blocked_open++;
 
 	spin_unlock_irqrestore(&info->slock, flags);
 
@@ -933,7 +940,8 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 				retval = -ERESTARTSYS;
 			break;
 		}
-		if (!(info->flags & ROCKET_CLOSING) && (do_clocal || (sGetChanStatusLo(&info->channel) & CD_ACT)))
+		if (!(info->flags & ROCKET_CLOSING) &&
+			(do_clocal || tty_port_carrier_raised(port)))
 			break;
 		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
@@ -941,24 +949,24 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		}
 #ifdef ROCKET_DEBUG_OPEN
 		printk(KERN_INFO "block_til_ready blocking: ttyR%d, count = %d, flags=0x%0x\n",
-		     info->line, info->port.count, info->flags);
+		     info->line, port->count, info->flags);
 #endif
 		schedule();	/*  Don't hold spinlock here, will hang PC */
 	}
 	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&info->port.open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 
 	spin_lock_irqsave(&info->slock, flags);
 
 	if (extra_count)
-		info->port.count++;
-	info->port.blocked_open--;
+		port->count++;
+	port->blocked_open--;
 
 	spin_unlock_irqrestore(&info->slock, flags);
 
 #ifdef ROCKET_DEBUG_OPEN
 	printk(KERN_INFO "block_til_ready after blocking: ttyR%d, count = %d\n",
-	       info->line, info->port.count);
+	       info->line, port->count);
 #endif
 	if (retval)
 		return retval;
@@ -2371,6 +2379,10 @@ static const struct tty_operations rocket_ops = {
 	.tiocmset = rp_tiocmset,
 };
 
+static const struct tty_port_operations rocket_port_ops = {
+	.carrier_raised = carrier_raised,
+};
+
 /*
  * The module "startup" routine; it's run when the module is loaded.
  */
diff --git a/drivers/char/ser_a2232.c b/drivers/char/ser_a2232.c
index 7b0c352..0c97f34 100644
--- a/drivers/char/ser_a2232.c
+++ b/drivers/char/ser_a2232.c
@@ -122,7 +122,7 @@ static void a2232_disable_tx_interrupts(void *ptr);
 static void a2232_enable_tx_interrupts(void *ptr);
 static void a2232_disable_rx_interrupts(void *ptr);
 static void a2232_enable_rx_interrupts(void *ptr);
-static int  a2232_get_CD(void *ptr);
+static int  a2232_carrier_raised(struct tty_port *port);
 static void a2232_shutdown_port(void *ptr);
 static int  a2232_set_real_termios(void *ptr);
 static int  a2232_chars_in_buffer(void *ptr);
@@ -148,7 +148,6 @@ static struct real_driver a2232_real_driver = {
         a2232_enable_tx_interrupts,
         a2232_disable_rx_interrupts,
         a2232_enable_rx_interrupts,
-        a2232_get_CD,
         a2232_shutdown_port,
         a2232_set_real_termios,
         a2232_chars_in_buffer,
@@ -260,9 +259,10 @@ static void a2232_enable_rx_interrupts(void *ptr)
 	port->disable_rx = 0;
 }
 
-static int  a2232_get_CD(void *ptr)
+static int  a2232_carrier_raised(struct tty_port *port)
 {
-	return ((struct a2232_port *) ptr)->cd_status;
+	struct a2232_port *ap = container_of(port, struct a2232_port, gs.port);
+	return ap->cd_status;
 }
 
 static void a2232_shutdown_port(void *ptr)
@@ -638,6 +638,10 @@ int ch, err, n, p;
 	return IRQ_HANDLED;
 }
 
+static const struct tty_port_operations a2232_port_ops = {
+	.carrier_raised = a2232_carrier_raised,
+};
+
 static void a2232_init_portstructs(void)
 {
 	struct a2232_port *port;
@@ -645,6 +649,8 @@ static void a2232_init_portstructs(void)
 
 	for (i = 0; i < MAX_A2232_BOARDS*NUMLINES; i++) {
 		port = a2232_ports + i;
+		tty_port_init(&port->gs.port);
+		port->gs.port.ops = &a2232_port_ops;
 		port->which_a2232 = i/NUMLINES;
 		port->which_port_on_a2232 = i%NUMLINES;
 		port->disable_rx = port->throttle_input = port->cd_status = 0;
@@ -652,11 +658,6 @@ static void a2232_init_portstructs(void)
 		port->gs.close_delay = HZ/2;
 		port->gs.closing_wait = 30 * HZ;
 		port->gs.rd = &a2232_real_driver;
-#ifdef NEW_WRITE_LOCKING
-		mutex_init(&(port->gs.port_write_mutex));
-#endif
-		init_waitqueue_head(&port->gs.port.open_wait);
-		init_waitqueue_head(&port->gs.port.close_wait);
 	}
 }
 
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 963b03f..12aecda 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -130,6 +130,8 @@ static char		stl_unwanted[SC26198_RXFIFOSIZE];
 static DEFINE_MUTEX(stl_brdslock);
 static struct stlbrd		*stl_brds[STL_MAXBRDS];
 
+static const struct tty_port_operations stl_port_ops;
+
 /*
  *	Per board state flags. Used with the state field of the board struct.
  *	Not really much here!
@@ -786,6 +788,12 @@ static int stl_open(struct tty_struct *tty, struct file *filp)
 
 /*****************************************************************************/
 
+static int stl_carrier_raised(struct tty_port *port)
+{
+	struct stlport *portp = container_of(port, struct stlport, port);
+	return (portp->sigs & TIOCM_CD) ? 1 : 0;
+}
+
 /*
  *	Possibly need to wait for carrier (DCD signal) to come high. Say
  *	maybe because if we are clocal then we don't need to wait...
@@ -796,6 +804,7 @@ static int stl_waitcarrier(struct tty_struct *tty, struct stlport *portp,
 {
 	unsigned long	flags;
 	int		rc, doclocal;
+	struct tty_port *port = &portp->port;
 
 	pr_debug("stl_waitcarrier(portp=%p,filp=%p)\n", portp, filp);
 
@@ -809,32 +818,32 @@ static int stl_waitcarrier(struct tty_struct *tty, struct stlport *portp,
 
 	portp->openwaitcnt++;
 	if (! tty_hung_up_p(filp))
-		portp->port.count--;
+		port->count--;
 
 	for (;;) {
 		/* Takes brd_lock internally */
 		stl_setsignals(portp, 1, 1);
 		if (tty_hung_up_p(filp) ||
-		    ((portp->port.flags & ASYNC_INITIALIZED) == 0)) {
-			if (portp->port.flags & ASYNC_HUP_NOTIFY)
+		    ((port->flags & ASYNC_INITIALIZED) == 0)) {
+			if (port->flags & ASYNC_HUP_NOTIFY)
 				rc = -EBUSY;
 			else
 				rc = -ERESTARTSYS;
 			break;
 		}
-		if (((portp->port.flags & ASYNC_CLOSING) == 0) &&
-		    (doclocal || (portp->sigs & TIOCM_CD)))
+		if (((port->flags & ASYNC_CLOSING) == 0) &&
+		    (doclocal || tty_port_carrier_raised(port)))
 			break;
 		if (signal_pending(current)) {
 			rc = -ERESTARTSYS;
 			break;
 		}
 		/* FIXME */
-		interruptible_sleep_on(&portp->port.open_wait);
+		interruptible_sleep_on(&port->open_wait);
 	}
 
 	if (! tty_hung_up_p(filp))
-		portp->port.count++;
+		port->count++;
 	portp->openwaitcnt--;
 	spin_unlock_irqrestore(&stallion_lock, flags);
 
@@ -1776,6 +1785,7 @@ static int __devinit stl_initports(struct stlbrd *brdp, struct stlpanel *panelp)
 			break;
 		}
 		tty_port_init(&portp->port);
+		portp->port.ops = &stl_port_ops;
 		portp->magic = STL_PORTMAGIC;
 		portp->portnr = i;
 		portp->brdnr = panelp->brdnr;
@@ -2659,6 +2669,10 @@ static const struct tty_operations stl_ops = {
 	.tiocmset = stl_tiocmset,
 };
 
+static const struct tty_port_operations stl_port_ops = {
+	.carrier_raised = stl_carrier_raised,
+};
+
 /*****************************************************************************/
 /*                       CD1400 HARDWARE FUNCTIONS                           */
 /*****************************************************************************/
diff --git a/drivers/char/sx.c b/drivers/char/sx.c
index ba4e862..a71bc58 100644
--- a/drivers/char/sx.c
+++ b/drivers/char/sx.c
@@ -279,7 +279,7 @@ static void sx_disable_tx_interrupts(void *ptr);
 static void sx_enable_tx_interrupts(void *ptr);
 static void sx_disable_rx_interrupts(void *ptr);
 static void sx_enable_rx_interrupts(void *ptr);
-static int sx_get_CD(void *ptr);
+static int sx_carrier_raised(struct tty_port *port);
 static void sx_shutdown_port(void *ptr);
 static int sx_set_real_termios(void *ptr);
 static void sx_close(void *ptr);
@@ -360,7 +360,6 @@ static struct real_driver sx_real_driver = {
 	sx_enable_tx_interrupts,
 	sx_disable_rx_interrupts,
 	sx_enable_rx_interrupts,
-	sx_get_CD,
 	sx_shutdown_port,
 	sx_set_real_termios,
 	sx_chars_in_buffer,
@@ -791,7 +790,7 @@ static int sx_getsignals(struct sx_port *port)
 	sx_dprintk(SX_DEBUG_MODEMSIGNALS, "getsignals: %d/%d  (%d/%d) "
 			"%02x/%02x\n",
 			(o_stat & OP_DTR) != 0, (o_stat & OP_RTS) != 0,
-			port->c_dcd, sx_get_CD(port),
+			port->c_dcd, tty_port_carrier_raised(&port->gs.port),
 			sx_read_channel_byte(port, hi_ip),
 			sx_read_channel_byte(port, hi_state));
 
@@ -1190,7 +1189,7 @@ static inline void sx_check_modem_signals(struct sx_port *port)
 
 	hi_state = sx_read_channel_byte(port, hi_state);
 	sx_dprintk(SX_DEBUG_MODEMSIGNALS, "Checking modem signals (%d/%d)\n",
-			port->c_dcd, sx_get_CD(port));
+			port->c_dcd, tty_port_carrier_raised(&port->gs.port));
 
 	if (hi_state & ST_BREAK) {
 		hi_state &= ~ST_BREAK;
@@ -1202,11 +1201,11 @@ static inline void sx_check_modem_signals(struct sx_port *port)
 		hi_state &= ~ST_DCD;
 		sx_dprintk(SX_DEBUG_MODEMSIGNALS, "got a DCD change.\n");
 		sx_write_channel_byte(port, hi_state, hi_state);
-		c_dcd = sx_get_CD(port);
+		c_dcd = tty_port_carrier_raised(&port->gs.port);
 		sx_dprintk(SX_DEBUG_MODEMSIGNALS, "DCD is now %d\n", c_dcd);
 		if (c_dcd != port->c_dcd) {
 			port->c_dcd = c_dcd;
-			if (sx_get_CD(port)) {
+			if (tty_port_carrier_raised(&port->gs.port)) {
 				/* DCD went UP */
 				if ((sx_read_channel_byte(port, hi_hstat) !=
 						HS_IDLE_CLOSED) &&
@@ -1415,13 +1414,10 @@ static void sx_enable_rx_interrupts(void *ptr)
 }
 
 /* Jeez. Isn't this simple? */
-static int sx_get_CD(void *ptr)
+static int sx_carrier_raised(struct tty_port *port)
 {
-	struct sx_port *port = ptr;
-	func_enter2();
-
-	func_exit();
-	return ((sx_read_channel_byte(port, hi_ip) & IP_DCD) != 0);
+	struct sx_port *sp = container_of(port, struct sx_port, gs.port);
+	return ((sx_read_channel_byte(sp, hi_ip) & IP_DCD) != 0);
 }
 
 /* Jeez. Isn't this simple? */
@@ -1536,7 +1532,7 @@ static int sx_open(struct tty_struct *tty, struct file *filp)
 	}
 	/* tty->low_latency = 1; */
 
-	port->c_dcd = sx_get_CD(port);
+	port->c_dcd = sx_carrier_raised(&port->gs.port);
 	sx_dprintk(SX_DEBUG_OPEN, "at open: cd=%d\n", port->c_dcd);
 
 	func_exit();
@@ -2354,6 +2350,10 @@ static const struct tty_operations sx_ops = {
 	.tiocmset = sx_tiocmset,
 };
 
+static const struct tty_port_operations sx_port_ops = {
+	.carrier_raised = sx_carrier_raised,
+};
+
 static int sx_init_drivers(void)
 {
 	int error;
@@ -2410,6 +2410,7 @@ static int sx_init_portstructs(int nboards, int nports)
 		for (j = 0; j < boards[i].nports; j++) {
 			sx_dprintk(SX_DEBUG_INIT, "initing port %d\n", j);
 			tty_port_init(&port->gs.port);
+			port->gs.port.ops = &sx_port_ops;
 			port->gs.magic = SX_MAGIC;
 			port->gs.close_delay = HZ / 2;
 			port->gs.closing_wait = 30 * HZ;
diff --git a/drivers/char/synclink.c b/drivers/char/synclink.c
index 500f517..fb2e6b5 100644
--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -3281,6 +3281,23 @@ static void mgsl_hangup(struct tty_struct *tty)
 	
 }	/* end of mgsl_hangup() */
 
+/*
+ * carrier_raised()
+ *
+ *	Return true if carrier is raised
+ */
+
+static int carrier_raised(struct tty_port *port)
+{
+	unsigned long flags;
+	struct mgsl_struct *info = container_of(port, struct mgsl_struct, port);
+	
+	spin_lock_irqsave(&info->irq_spinlock, flags);
+ 	usc_get_serial_signals(info);
+	spin_unlock_irqrestore(&info->irq_spinlock, flags);
+	return (info->serial_signals & SerialSignal_DCD) ? 1 : 0;
+}
+
 /* block_til_ready()
  * 
  * 	Block the current process until the specified port
@@ -3302,6 +3319,8 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 	bool		do_clocal = false;
 	bool		extra_count = false;
 	unsigned long	flags;
+	int		dcd;
+	struct tty_port *port = &info->port;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):block_til_ready on %s\n",
@@ -3309,7 +3328,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 
 	if (filp->f_flags & O_NONBLOCK || tty->flags & (1 << TTY_IO_ERROR)){
 		/* nonblock mode is set or port is not enabled */
-		info->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 
@@ -3318,25 +3337,25 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 
 	/* Wait for carrier detect and the line to become
 	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, info->port.count is dropped by one, so that
+	 * this loop, port->count is dropped by one, so that
 	 * mgsl_close() knows when to free things.  We restore it upon
 	 * exit, either normal or abnormal.
 	 */
 	 
 	retval = 0;
-	add_wait_queue(&info->port.open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):block_til_ready before block on %s count=%d\n",
-			 __FILE__,__LINE__, tty->driver->name, info->port.count );
+			 __FILE__,__LINE__, tty->driver->name, port->count );
 
 	spin_lock_irqsave(&info->irq_spinlock, flags);
 	if (!tty_hung_up_p(filp)) {
 		extra_count = true;
-		info->port.count--;
+		port->count--;
 	}
 	spin_unlock_irqrestore(&info->irq_spinlock, flags);
-	info->port.blocked_open++;
+	port->blocked_open++;
 	
 	while (1) {
 		if (tty->termios->c_cflag & CBAUD) {
@@ -3348,20 +3367,16 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 		
 		set_current_state(TASK_INTERRUPTIBLE);
 		
-		if (tty_hung_up_p(filp) || !(info->port.flags & ASYNC_INITIALIZED)){
-			retval = (info->port.flags & ASYNC_HUP_NOTIFY) ?
+		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)){
+			retval = (port->flags & ASYNC_HUP_NOTIFY) ?
 					-EAGAIN : -ERESTARTSYS;
 			break;
 		}
 		
-		spin_lock_irqsave(&info->irq_spinlock,flags);
-	 	usc_get_serial_signals(info);
-		spin_unlock_irqrestore(&info->irq_spinlock,flags);
+		dcd = tty_port_carrier_raised(&info->port);
 		
- 		if (!(info->port.flags & ASYNC_CLOSING) &&
- 		    (do_clocal || (info->serial_signals & SerialSignal_DCD)) ) {
+ 		if (!(port->flags & ASYNC_CLOSING) && (do_clocal || dcd))
  			break;
-		}
 			
 		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
@@ -3370,24 +3385,24 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 		
 		if (debug_level >= DEBUG_LEVEL_INFO)
 			printk("%s(%d):block_til_ready blocking on %s count=%d\n",
-				 __FILE__,__LINE__, tty->driver->name, info->port.count );
+				 __FILE__,__LINE__, tty->driver->name, port->count );
 				 
 		schedule();
 	}
 	
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&info->port.open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 	
 	if (extra_count)
-		info->port.count++;
-	info->port.blocked_open--;
+		port->count++;
+	port->blocked_open--;
 	
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):block_til_ready after blocking on %s count=%d\n",
-			 __FILE__,__LINE__, tty->driver->name, info->port.count );
+			 __FILE__,__LINE__, tty->driver->name, port->count );
 			 
 	if (!retval)
-		info->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		
 	return retval;
 	
@@ -4304,6 +4319,11 @@ static void mgsl_add_device( struct mgsl_struct *info )
 
 }	/* end of mgsl_add_device() */
 
+static const struct tty_port_operations mgsl_port_ops = {
+	.carrier_raised = carrier_raised,
+};
+
+
 /* mgsl_allocate_device()
  * 
  * 	Allocate and initialize a device instance structure
@@ -4322,6 +4342,7 @@ static struct mgsl_struct* mgsl_allocate_device(void)
 		printk("Error can't allocate device instance data\n");
 	} else {
 		tty_port_init(&info->port);
+		info->port.ops = &mgsl_port_ops;
 		info->magic = MGSL_MAGIC;
 		INIT_WORK(&info->task, mgsl_bh_handler);
 		info->max_frame_size = 4096;
diff --git a/drivers/char/synclink_gt.c b/drivers/char/synclink_gt.c
index 08911ed..39ccaba 100644
--- a/drivers/char/synclink_gt.c
+++ b/drivers/char/synclink_gt.c
@@ -3132,6 +3132,17 @@ static int tiocmset(struct tty_struct *tty, struct file *file,
 	return 0;
 }
 
+static int carrier_raised(struct tty_port *port)
+{
+	unsigned long flags;
+	struct slgt_info *info = container_of(port, struct slgt_info, port);
+
+	spin_lock_irqsave(&info->lock,flags);
+ 	get_signals(info);
+	spin_unlock_irqrestore(&info->lock,flags);
+	return (info->signals & SerialSignal_DCD) ? 1 : 0;
+}
+
 /*
  *  block current process until the device is ready to open
  */
@@ -3143,12 +3154,14 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	bool		do_clocal = false;
 	bool		extra_count = false;
 	unsigned long	flags;
+	int		cd;
+	struct tty_port *port = &info->port;
 
 	DBGINFO(("%s block_til_ready\n", tty->driver->name));
 
 	if (filp->f_flags & O_NONBLOCK || tty->flags & (1 << TTY_IO_ERROR)){
 		/* nonblock mode is set or port is not enabled */
-		info->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 
@@ -3157,21 +3170,21 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 
 	/* Wait for carrier detect and the line to become
 	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, info->port.count is dropped by one, so that
+	 * this loop, port->count is dropped by one, so that
 	 * close() knows when to free things.  We restore it upon
 	 * exit, either normal or abnormal.
 	 */
 
 	retval = 0;
-	add_wait_queue(&info->port.open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 
 	spin_lock_irqsave(&info->lock, flags);
 	if (!tty_hung_up_p(filp)) {
 		extra_count = true;
-		info->port.count--;
+		port->count--;
 	}
 	spin_unlock_irqrestore(&info->lock, flags);
-	info->port.blocked_open++;
+	port->blocked_open++;
 
 	while (1) {
 		if ((tty->termios->c_cflag & CBAUD)) {
@@ -3183,20 +3196,16 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (tty_hung_up_p(filp) || !(info->port.flags & ASYNC_INITIALIZED)){
-			retval = (info->port.flags & ASYNC_HUP_NOTIFY) ?
+		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)){
+			retval = (port->flags & ASYNC_HUP_NOTIFY) ?
 					-EAGAIN : -ERESTARTSYS;
 			break;
 		}
 
-		spin_lock_irqsave(&info->lock,flags);
-	 	get_signals(info);
-		spin_unlock_irqrestore(&info->lock,flags);
+		cd = tty_port_carrier_raised(port);
 
- 		if (!(info->port.flags & ASYNC_CLOSING) &&
- 		    (do_clocal || (info->signals & SerialSignal_DCD)) ) {
+ 		if (!(port->flags & ASYNC_CLOSING) && (do_clocal || cd ))
  			break;
-		}
 
 		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
@@ -3208,14 +3217,14 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	}
 
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&info->port.open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 
 	if (extra_count)
-		info->port.count++;
-	info->port.blocked_open--;
+		port->count++;
+	port->blocked_open--;
 
 	if (!retval)
-		info->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 
 	DBGINFO(("%s block_til_ready ready, rc=%d\n", tty->driver->name, retval));
 	return retval;
@@ -3444,6 +3453,10 @@ static void add_device(struct slgt_info *info)
 #endif
 }
 
+static const struct tty_port_operations slgt_port_ops = {
+	.carrier_raised = carrier_raised,
+};
+
 /*
  *  allocate device instance structure, return NULL on failure
  */
@@ -3458,6 +3471,7 @@ static struct slgt_info *alloc_dev(int adapter_num, int port_num, struct pci_dev
 			driver_name, adapter_num, port_num));
 	} else {
 		tty_port_init(&info->port);
+		info->port.ops = &slgt_port_ops;
 		info->magic = MGSL_MAGIC;
 		INIT_WORK(&info->task, bh_handler);
 		info->max_frame_size = 4096;
diff --git a/drivers/char/synclinkmp.c b/drivers/char/synclinkmp.c
index 6bdb44f..fcf1ec7 100644
--- a/drivers/char/synclinkmp.c
+++ b/drivers/char/synclinkmp.c
@@ -558,6 +558,7 @@ static void release_resources(SLMP_INFO *info);
 
 static int  startup(SLMP_INFO *info);
 static int  block_til_ready(struct tty_struct *tty, struct file * filp,SLMP_INFO *info);
+static int carrier_raised(struct tty_port *port);
 static void shutdown(SLMP_INFO *info);
 static void program_hw(SLMP_INFO *info);
 static void change_params(SLMP_INFO *info);
@@ -3318,7 +3319,17 @@ static int tiocmset(struct tty_struct *tty, struct file *file,
 	return 0;
 }
 
+static int carrier_raised(struct tty_port *port)
+{
+	SLMP_INFO *info = container_of(port, SLMP_INFO, port);
+	unsigned long flags;
 
+	spin_lock_irqsave(&info->lock,flags);
+ 	get_signals(info);
+	spin_unlock_irqrestore(&info->lock,flags);
+
+	return (info->serial_signals & SerialSignal_DCD) ? 1 : 0;
+}
 
 /* Block the current process until the specified port is ready to open.
  */
@@ -3330,6 +3341,8 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	bool		do_clocal = false;
 	bool		extra_count = false;
 	unsigned long	flags;
+	int		cd;
+	struct tty_port *port = &info->port;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):%s block_til_ready()\n",
@@ -3338,7 +3351,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	if (filp->f_flags & O_NONBLOCK || tty->flags & (1 << TTY_IO_ERROR)){
 		/* nonblock mode is set or port is not enabled */
 		/* just verify that callout device is not active */
-		info->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
 
@@ -3347,25 +3360,25 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 
 	/* Wait for carrier detect and the line to become
 	 * free (i.e., not in use by the callout).  While we are in
-	 * this loop, info->port.count is dropped by one, so that
+	 * this loop, port->count is dropped by one, so that
 	 * close() knows when to free things.  We restore it upon
 	 * exit, either normal or abnormal.
 	 */
 
 	retval = 0;
-	add_wait_queue(&info->port.open_wait, &wait);
+	add_wait_queue(&port->open_wait, &wait);
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):%s block_til_ready() before block, count=%d\n",
-			 __FILE__,__LINE__, tty->driver->name, info->port.count );
+			 __FILE__,__LINE__, tty->driver->name, port->count );
 
 	spin_lock_irqsave(&info->lock, flags);
 	if (!tty_hung_up_p(filp)) {
 		extra_count = true;
-		info->port.count--;
+		port->count--;
 	}
 	spin_unlock_irqrestore(&info->lock, flags);
-	info->port.blocked_open++;
+	port->blocked_open++;
 
 	while (1) {
 		if ((tty->termios->c_cflag & CBAUD)) {
@@ -3377,20 +3390,16 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (tty_hung_up_p(filp) || !(info->port.flags & ASYNC_INITIALIZED)){
-			retval = (info->port.flags & ASYNC_HUP_NOTIFY) ?
+		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)){
+			retval = (port->flags & ASYNC_HUP_NOTIFY) ?
 					-EAGAIN : -ERESTARTSYS;
 			break;
 		}
 
-		spin_lock_irqsave(&info->lock,flags);
-	 	get_signals(info);
-		spin_unlock_irqrestore(&info->lock,flags);
+		cd = tty_port_carrier_raised(port);
 
- 		if (!(info->port.flags & ASYNC_CLOSING) &&
- 		    (do_clocal || (info->serial_signals & SerialSignal_DCD)) ) {
+ 		if (!(port->flags & ASYNC_CLOSING) && (do_clocal || cd))
  			break;
-		}
 
 		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
@@ -3399,24 +3408,24 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 
 		if (debug_level >= DEBUG_LEVEL_INFO)
 			printk("%s(%d):%s block_til_ready() count=%d\n",
-				 __FILE__,__LINE__, tty->driver->name, info->port.count );
+				 __FILE__,__LINE__, tty->driver->name, port->count );
 
 		schedule();
 	}
 
 	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&info->port.open_wait, &wait);
+	remove_wait_queue(&port->open_wait, &wait);
 
 	if (extra_count)
-		info->port.count++;
-	info->port.blocked_open--;
+		port->count++;
+	port->blocked_open--;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):%s block_til_ready() after, count=%d\n",
-			 __FILE__,__LINE__, tty->driver->name, info->port.count );
+			 __FILE__,__LINE__, tty->driver->name, port->count );
 
 	if (!retval)
-		info->port.flags |= ASYNC_NORMAL_ACTIVE;
+		port->flags |= ASYNC_NORMAL_ACTIVE;
 
 	return retval;
 }
@@ -3782,6 +3791,10 @@ static void add_device(SLMP_INFO *info)
 #endif
 }
 
+static const struct tty_port_operations port_ops = {
+	.carrier_raised = carrier_raised,
+};
+
 /* Allocate and initialize a device instance structure
  *
  * Return Value:	pointer to SLMP_INFO if success, otherwise NULL
@@ -3798,6 +3811,7 @@ static SLMP_INFO *alloc_dev(int adapter_num, int port_num, struct pci_dev *pdev)
 			__FILE__,__LINE__, adapter_num, port_num);
 	} else {
 		tty_port_init(&info->port);
+		info->port.ops = &port_ops;
 		info->magic = MGSL_MAGIC;
 		INIT_WORK(&info->task, bh_handler);
 		info->max_frame_size = 4096;
@@ -3940,6 +3954,7 @@ static const struct tty_operations ops = {
 	.tiocmset = tiocmset,
 };
 
+
 static void synclinkmp_cleanup(void)
 {
 	int rc;
diff --git a/drivers/char/tty_port.c b/drivers/char/tty_port.c
index c8f8024..f54e40c 100644
--- a/drivers/char/tty_port.c
+++ b/drivers/char/tty_port.c
@@ -94,3 +94,20 @@ void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 EXPORT_SYMBOL(tty_port_tty_set);
+
+/**
+ *	tty_port_carrier_raised	-	carrier raised check
+ *	@port: tty port
+ *
+ *	Wrapper for the carrier detect logic. For the moment this is used
+ *	to hide some internal details. This will eventually become entirely
+ *	internal to the tty port.
+ */
+
+int tty_port_carrier_raised(struct tty_port *port)
+{
+	if (port->ops->carrier_raised == NULL)
+		return 1;
+	return port->ops->carrier_raised(port);
+}
+EXPORT_SYMBOL(tty_port_carrier_raised);
diff --git a/drivers/char/vme_scc.c b/drivers/char/vme_scc.c
index 1718b3c..d4e1534 100644
--- a/drivers/char/vme_scc.c
+++ b/drivers/char/vme_scc.c
@@ -69,7 +69,7 @@ static void scc_disable_tx_interrupts(void * ptr);
 static void scc_enable_tx_interrupts(void * ptr);
 static void scc_disable_rx_interrupts(void * ptr);
 static void scc_enable_rx_interrupts(void * ptr);
-static int  scc_get_CD(void * ptr);
+static int  scc_carrier_raised(struct tty_port *port);
 static void scc_shutdown_port(void * ptr);
 static int scc_set_real_termios(void  *ptr);
 static void scc_hungup(void  *ptr);
@@ -100,7 +100,6 @@ static struct real_driver scc_real_driver = {
         scc_enable_tx_interrupts,
         scc_disable_rx_interrupts,
         scc_enable_rx_interrupts,
-        scc_get_CD,
         scc_shutdown_port,
         scc_set_real_termios,
         scc_chars_in_buffer,
@@ -129,6 +128,10 @@ static const struct tty_operations scc_ops = {
 	.break_ctl = scc_break_ctl,
 };
 
+static const struct tty_port_operations scc_port_ops = {
+	.carrier_raised = scc_carrier_raised,
+};
+
 /*----------------------------------------------------------------------------
  * vme_scc_init() and support functions
  *---------------------------------------------------------------------------*/
@@ -176,6 +179,8 @@ static void scc_init_portstructs(void)
 
 	for (i = 0; i < 2; i++) {
 		port = scc_ports + i;
+		tty_port_init(&port->gs.port);
+		port->gs.port.ops = &scc_port_ops;
 		port->gs.magic = SCC_MAGIC;
 		port->gs.close_delay = HZ/2;
 		port->gs.closing_wait = 30 * HZ;
@@ -624,9 +629,9 @@ static void scc_enable_rx_interrupts(void *ptr)
 }
 
 
-static int scc_get_CD(void *ptr)
+static int scc_carrier_raised(struct tty_port *port)
 {
-	struct scc_port *port = ptr;
+	struct scc_port *scc = container_of(port, struct scc_port, gs.port);
 	unsigned channel = port->channel;
 
 	return !!(scc_last_status_reg[channel] & SR_DCD);
@@ -896,7 +901,7 @@ static int scc_open (struct tty_struct * tty, struct file * filp)
 		return retval;
 	}
 
-	port->c_dcd = scc_get_CD (port);
+	port->c_dcd = tty_port_carrier_raised(&port->gs.port);
 
 	scc_enable_rx_interrupts(port);
 
diff --git a/include/linux/generic_serial.h b/include/linux/generic_serial.h
index 4cc9139..fadff28 100644
--- a/include/linux/generic_serial.h
+++ b/include/linux/generic_serial.h
@@ -21,7 +21,6 @@ struct real_driver {
   void                    (*enable_tx_interrupts) (void *);
   void                    (*disable_rx_interrupts) (void *);
   void                    (*enable_rx_interrupts) (void *);
-  int                     (*get_CD) (void *);
   void                    (*shutdown_port) (void*);
   int                     (*set_real_termios) (void*);
   int                     (*chars_in_buffer) (void*);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index bbbeaef..bc7bae7 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -180,8 +180,16 @@ struct signal_struct;
  * until a hangup so don't use the wrong path.
  */
 
+struct tty_port;
+
+struct tty_port_operations {
+	/* Return 1 if the carrier is raised */
+	int (*carrier_raised)(struct tty_port *port);
+};
+	
 struct tty_port {
 	struct tty_struct	*tty;		/* Back pointer */
+	const struct tty_port_operations *ops;	/* Port operations */
 	spinlock_t		lock;		/* Lock protecting tty field */
 	int			blocked_open;	/* Waiting to open */
 	int			count;		/* Usage count */
@@ -427,6 +435,7 @@ extern int tty_port_alloc_xmit_buf(struct tty_port *port);
 extern void tty_port_free_xmit_buf(struct tty_port *port);
 extern struct tty_struct *tty_port_tty_get(struct tty_port *port);
 extern void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty);
+extern int tty_port_carrier_raised(struct tty_port *port);
 
 extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);

