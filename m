From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 44/75] tty: Introduce some close helpers for ports
Date: Fri, 02 Jan 2009 13:46:50 +0000
Message-ID: <20090102134648.13472.10976.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37603 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757205AbZABNqm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:42 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Again this is a lot of common code we can unify

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/isicom.c      |   66 ++++++-------------------------------
 drivers/char/istallion.c   |   78 ++++++++++++++++----------------------------
 drivers/char/mxser.c       |   56 +++++---------------------------
 drivers/char/riscom8.c     |   49 +++-------------------------
 drivers/char/stallion.c    |   39 ++--------------------
 drivers/char/synclink.c    |   58 ++-------------------------------
 drivers/char/synclink_gt.c |   51 +----------------------------
 drivers/char/synclinkmp.c  |   58 ++-------------------------------
 drivers/char/tty_port.c    |   58 +++++++++++++++++++++++++++++++++
 include/linux/istallion.h  |    1 -
 include/linux/tty.h        |    3 ++
 11 files changed, 126 insertions(+), 391 deletions(-)


diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index bac55cf..24aa6e8 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -945,76 +945,30 @@ static void isicom_flush_buffer(struct tty_struct *tty)
 
 static void isicom_close(struct tty_struct *tty, struct file *filp)
 {
-	struct isi_port *port = tty->driver_data;
+	struct isi_port *ip = tty->driver_data;
+	struct tty_port *port = &ip->port;
 	struct isi_board *card;
 	unsigned long flags;
 
-	if (!port)
-		return;
-	card = port->card;
-	if (isicom_paranoia_check(port, tty->name, "isicom_close"))
-		return;
-
-	pr_dbg("Close start!!!.\n");
-
-	spin_lock_irqsave(&port->port.lock, flags);
-	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&port->port.lock, flags);
-		return;
-	}
-
-	if (tty->count == 1 && port->port.count != 1) {
-		printk(KERN_WARNING "ISICOM:(0x%lx) isicom_close: bad port "
-			"count tty->count = 1 port count = %d.\n",
-			card->base, port->port.count);
-		port->port.count = 1;
-	}
-	if (--port->port.count < 0) {
-		printk(KERN_WARNING "ISICOM:(0x%lx) isicom_close: bad port "
-			"count for channel%d = %d", card->base, port->channel,
-			port->port.count);
-		port->port.count = 0;
-	}
+	BUG_ON(!ip);
 
-	if (port->port.count) {
-		spin_unlock_irqrestore(&port->port.lock, flags);
+	card = ip->card;
+	if (isicom_paranoia_check(ip, tty->name, "isicom_close"))
 		return;
-	}
-	port->port.flags |= ASYNC_CLOSING;
-	tty->closing = 1;
-	spin_unlock_irqrestore(&port->port.lock, flags);
 
-	if (port->port.closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, port->port.closing_wait);
 	/* indicate to the card that no more data can be received
 	   on this port */
 	spin_lock_irqsave(&card->card_lock, flags);
-	if (port->port.flags & ASYNC_INITIALIZED) {
-		card->port_status &= ~(1 << port->channel);
+	if (port->flags & ASYNC_INITIALIZED) {
+		card->port_status &= ~(1 << ip->channel);
 		outw(card->port_status, card->base + 0x02);
 	}
-	isicom_shutdown_port(port);
+	isicom_shutdown_port(ip);
 	spin_unlock_irqrestore(&card->card_lock, flags);
 
 	isicom_flush_buffer(tty);
-	tty_ldisc_flush(tty);
-
-	spin_lock_irqsave(&port->port.lock, flags);
-	tty->closing = 0;
-
-	if (port->port.blocked_open) {
-		spin_unlock_irqrestore(&port->port.lock, flags);
-		if (port->port.close_delay) {
-			pr_dbg("scheduling until time out.\n");
-			msleep_interruptible(
-				jiffies_to_msecs(port->port.close_delay));
-		}
-		spin_lock_irqsave(&port->port.lock, flags);
-		wake_up_interruptible(&port->port.open_wait);
-	}
-	port->port.flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CLOSING);
-	wake_up_interruptible(&port->port.close_wait);
-	spin_unlock_irqrestore(&port->port.lock, flags);
+	
+	tty_port_close_end(port, tty);
 }
 
 /* write et all */
diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 4c69ab9..5c3dc6b 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -767,7 +767,7 @@ static int stli_parsebrd(struct stlconf *confp, char **argp)
 			break;
 	}
 	if (i == ARRAY_SIZE(stli_brdstr)) {
-		printk("STALLION: unknown board name, %s?\n", argp[0]);
+		printk(KERN_WARNING "istallion: unknown board name, %s?\n", argp[0]);
 		return 0;
 	}
 
@@ -855,21 +855,8 @@ static void stli_close(struct tty_struct *tty, struct file *filp)
 		return;
 	port = &portp->port;
 
-	spin_lock_irqsave(&port->lock, flags);
-	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&port->lock, flags);
-		return;
-	}
-	if (tty->count == 1 && port->count != 1)
-		port->count = 1;
-	if (port->count-- > 1) {
-		spin_unlock_irqrestore(&port->lock, flags);
+	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
-	}
-
-	port->flags |= ASYNC_CLOSING;
-	tty->closing = 1;
-	spin_unlock_irqrestore(&port->lock, flags);
 
 /*
  *	May want to wait for data to drain before closing. The BUSY flag
@@ -882,6 +869,8 @@ static void stli_close(struct tty_struct *tty, struct file *filp)
 		stli_flushchars(tty);
 	spin_unlock_irqrestore(&stli_lock, flags);
 
+	/* We end up doing this twice for the moment. This needs looking at
+	   eventually. Note we still use portp->closing_wait as a result */
 	if (portp->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, portp->closing_wait);
 
@@ -905,17 +894,8 @@ static void stli_close(struct tty_struct *tty, struct file *filp)
 	set_bit(ST_DOFLUSHRX, &portp->state);
 	stli_flushbuffer(tty);
 
-	tty->closing = 0;
-	tty_port_tty_set(&portp->port, NULL);
-
-	if (port->blocked_open) {
-		if (portp->close_delay)
-			msleep_interruptible(jiffies_to_msecs(portp->close_delay));
-		wake_up_interruptible(&port->open_wait);
-	}
-
-	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
-	wake_up_interruptible(&port->close_wait);
+	tty_port_close_end(port, tty);
+	tty_port_tty_set(port, NULL);
 }
 
 /*****************************************************************************/
@@ -1482,7 +1462,7 @@ static int stli_getserial(struct stliport *portp, struct serial_struct __user *s
 	sio.irq = 0;
 	sio.flags = portp->port.flags;
 	sio.baud_base = portp->baud_base;
-	sio.close_delay = portp->close_delay;
+	sio.close_delay = portp->port.close_delay;
 	sio.closing_wait = portp->closing_wait;
 	sio.custom_divisor = portp->custom_divisor;
 	sio.xmit_fifo_size = 0;
@@ -1514,7 +1494,7 @@ static int stli_setserial(struct tty_struct *tty, struct serial_struct __user *s
 		return -EFAULT;
 	if (!capable(CAP_SYS_ADMIN)) {
 		if ((sio.baud_base != portp->baud_base) ||
-		    (sio.close_delay != portp->close_delay) ||
+		    (sio.close_delay != portp->port.close_delay) ||
 		    ((sio.flags & ~ASYNC_USR_MASK) !=
 		    (portp->port.flags & ~ASYNC_USR_MASK)))
 			return -EPERM;
@@ -1523,7 +1503,7 @@ static int stli_setserial(struct tty_struct *tty, struct serial_struct __user *s
 	portp->port.flags = (portp->port.flags & ~ASYNC_USR_MASK) |
 		(sio.flags & ASYNC_USR_MASK);
 	portp->baud_base = sio.baud_base;
-	portp->close_delay = sio.close_delay;
+	portp->port.close_delay = sio.close_delay;
 	portp->closing_wait = sio.closing_wait;
 	portp->custom_divisor = sio.custom_divisor;
 
@@ -2065,7 +2045,7 @@ static void __stli_sendcmd(struct stlibrd *brdp, struct stliport *portp, unsigne
 	unsigned char __iomem *bits;
 
 	if (test_bit(ST_CMDING, &portp->state)) {
-		printk(KERN_ERR "STALLION: command already busy, cmd=%x!\n",
+		printk(KERN_ERR "istallion: command already busy, cmd=%x!\n",
 				(int) cmd);
 		return;
 	}
@@ -2625,7 +2605,7 @@ static int stli_initports(struct stlibrd *brdp)
 	for (i = 0, panelnr = 0, panelport = 0; (i < brdp->nrports); i++) {
 		portp = kzalloc(sizeof(struct stliport), GFP_KERNEL);
 		if (!portp) {
-			printk("STALLION: failed to allocate port structure\n");
+			printk(KERN_WARNING "istallion: failed to allocate port structure\n");
 			continue;
 		}
 		tty_port_init(&portp->port);
@@ -2635,7 +2615,7 @@ static int stli_initports(struct stlibrd *brdp)
 		portp->brdnr = brdp->brdnr;
 		portp->panelnr = panelnr;
 		portp->baud_base = STL_BAUDBASE;
-		portp->close_delay = STL_CLOSEDELAY;
+		portp->port.close_delay = STL_CLOSEDELAY;
 		portp->closing_wait = 30 * HZ;
 		init_waitqueue_head(&portp->port.open_wait);
 		init_waitqueue_head(&portp->port.close_wait);
@@ -2692,7 +2672,7 @@ static void __iomem *stli_ecpgetmemptr(struct stlibrd *brdp, unsigned long offse
 	unsigned char val;
 
 	if (offset > brdp->memsize) {
-		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
+		printk(KERN_ERR "istallion: shared memory pointer=%x out of "
 				"range at line=%d(%d), brd=%d\n",
 			(int) offset, line, __LINE__, brdp->brdnr);
 		ptr = NULL;
@@ -2766,7 +2746,7 @@ static void __iomem *stli_ecpeigetmemptr(struct stlibrd *brdp, unsigned long off
 	unsigned char	val;
 
 	if (offset > brdp->memsize) {
-		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
+		printk(KERN_ERR "istallion: shared memory pointer=%x out of "
 				"range at line=%d(%d), brd=%d\n",
 			(int) offset, line, __LINE__, brdp->brdnr);
 		ptr = NULL;
@@ -2818,7 +2798,7 @@ static void __iomem *stli_ecpmcgetmemptr(struct stlibrd *brdp, unsigned long off
 	unsigned char val;
 
 	if (offset > brdp->memsize) {
-		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
+		printk(KERN_ERR "istallion: shared memory pointer=%x out of "
 				"range at line=%d(%d), brd=%d\n",
 			(int) offset, line, __LINE__, brdp->brdnr);
 		ptr = NULL;
@@ -2863,7 +2843,7 @@ static void __iomem *stli_ecppcigetmemptr(struct stlibrd *brdp, unsigned long of
 	unsigned char	val;
 
 	if (offset > brdp->memsize) {
-		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
+		printk(KERN_ERR "istallion: shared memory pointer=%x out of "
 				"range at line=%d(%d), board=%d\n",
 				(int) offset, line, __LINE__, brdp->brdnr);
 		ptr = NULL;
@@ -2928,7 +2908,7 @@ static void __iomem *stli_onbgetmemptr(struct stlibrd *brdp, unsigned long offse
 	void __iomem *ptr;
 
 	if (offset > brdp->memsize) {
-		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
+		printk(KERN_ERR "istallion: shared memory pointer=%x out of "
 				"range at line=%d(%d), brd=%d\n",
 				(int) offset, line, __LINE__, brdp->brdnr);
 		ptr = NULL;
@@ -2994,7 +2974,7 @@ static void __iomem *stli_onbegetmemptr(struct stlibrd *brdp, unsigned long offs
 	unsigned char val;
 
 	if (offset > brdp->memsize) {
-		printk(KERN_ERR "STALLION: shared memory pointer=%x out of "
+		printk(KERN_ERR "istallion: shared memory pointer=%x out of "
 				"range at line=%d(%d), brd=%d\n",
 			(int) offset, line, __LINE__, brdp->brdnr);
 		ptr = NULL;
@@ -3433,7 +3413,7 @@ static int stli_startbrd(struct stlibrd *brdp)
 #endif
 
 	if (nrdevs < (brdp->nrports + 1)) {
-		printk(KERN_ERR "STALLION: slave failed to allocate memory for "
+		printk(KERN_ERR "istallion: slave failed to allocate memory for "
 				"all devices, devices=%d\n", nrdevs);
 		brdp->nrports = nrdevs - 1;
 	}
@@ -3443,13 +3423,13 @@ static int stli_startbrd(struct stlibrd *brdp)
 	brdp->bitsize = (nrdevs + 7) / 8;
 	memoff = readl(&hdrp->memp);
 	if (memoff > brdp->memsize) {
-		printk(KERN_ERR "STALLION: corrupted shared memory region?\n");
+		printk(KERN_ERR "istallion: corrupted shared memory region?\n");
 		rc = -EIO;
 		goto stli_donestartup;
 	}
 	memp = (cdkmem_t __iomem *) EBRDGETMEMPTR(brdp, memoff);
 	if (readw(&memp->dtype) != TYP_ASYNCTRL) {
-		printk(KERN_ERR "STALLION: no slave control device found\n");
+		printk(KERN_ERR "istallion: no slave control device found\n");
 		goto stli_donestartup;
 	}
 	memp++;
@@ -3534,7 +3514,7 @@ static int __devinit stli_brdinit(struct stlibrd *brdp)
 		retval = stli_initonb(brdp);
 		break;
 	default:
-		printk(KERN_ERR "STALLION: board=%d is unknown board "
+		printk(KERN_ERR "istallion: board=%d is unknown board "
 				"type=%d\n", brdp->brdnr, brdp->brdtype);
 		retval = -ENODEV;
 	}
@@ -3543,7 +3523,7 @@ static int __devinit stli_brdinit(struct stlibrd *brdp)
 		return retval;
 
 	stli_initports(brdp);
-	printk(KERN_INFO "STALLION: %s found, board=%d io=%x mem=%x "
+	printk(KERN_INFO "istallion: %s found, board=%d io=%x mem=%x "
 		"nrpanels=%d nrports=%d\n", stli_brdnames[brdp->brdtype],
 		brdp->brdnr, brdp->iobase, (int) brdp->memaddr,
 		brdp->nrpanels, brdp->nrports);
@@ -3637,7 +3617,7 @@ static int stli_eisamemprobe(struct stlibrd *brdp)
 	if (! foundit) {
 		brdp->memaddr = 0;
 		brdp->membase = NULL;
-		printk(KERN_ERR "STALLION: failed to probe shared memory "
+		printk(KERN_ERR "istallion: failed to probe shared memory "
 				"region for %s in EISA slot=%d\n",
 			stli_brdnames[brdp->brdtype], (brdp->iobase >> 12));
 		return -ENODEV;
@@ -3782,7 +3762,7 @@ static int __devinit stli_pciprobe(struct pci_dev *pdev,
 	mutex_lock(&stli_brdslock);
 	brdnr = stli_getbrdnr();
 	if (brdnr < 0) {
-		printk(KERN_INFO "STALLION: too many boards found, "
+		printk(KERN_INFO "istallion: too many boards found, "
 			"maximum supported %d\n", STL_MAXBRDS);
 		mutex_unlock(&stli_brdslock);
 		retval = -EIO;
@@ -3854,7 +3834,7 @@ static struct stlibrd *stli_allocbrd(void)
 
 	brdp = kzalloc(sizeof(struct stlibrd), GFP_KERNEL);
 	if (!brdp) {
-		printk(KERN_ERR "STALLION: failed to allocate memory "
+		printk(KERN_ERR "istallion: failed to allocate memory "
 				"(size=%Zd)\n", sizeof(struct stlibrd));
 		return NULL;
 	}
@@ -4493,7 +4473,7 @@ static int __init istallion_module_init(void)
 
 	stli_txcookbuf = kmalloc(STLI_TXBUFSIZE, GFP_KERNEL);
 	if (!stli_txcookbuf) {
-		printk(KERN_ERR "STALLION: failed to allocate memory "
+		printk(KERN_ERR "istallion: failed to allocate memory "
 				"(size=%d)\n", STLI_TXBUFSIZE);
 		retval = -ENOMEM;
 		goto err;
@@ -4518,7 +4498,7 @@ static int __init istallion_module_init(void)
 
 	retval = tty_register_driver(stli_serial);
 	if (retval) {
-		printk(KERN_ERR "STALLION: failed to register serial driver\n");
+		printk(KERN_ERR "istallion: failed to register serial driver\n");
 		goto err_ttyput;
 	}
 
@@ -4532,7 +4512,7 @@ static int __init istallion_module_init(void)
  */
 	retval = register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stli_fsiomem);
 	if (retval) {
-		printk(KERN_ERR "STALLION: failed to register serial memory "
+		printk(KERN_ERR "istallion: failed to register serial memory "
 				"device\n");
 		goto err_deinit;
 	}
diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
index 08ba6eb..402c9f2 100644
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -1080,58 +1080,27 @@ static void mxser_flush_buffer(struct tty_struct *tty)
 static void mxser_close(struct tty_struct *tty, struct file *filp)
 {
 	struct mxser_port *info = tty->driver_data;
+	struct tty_port *port = &info->port;
 
 	unsigned long timeout;
-	unsigned long flags;
 
 	if (tty->index == MXSER_PORTS)
 		return;
 	if (!info)
 		return;
 
-	spin_lock_irqsave(&info->port.lock, flags);
-
-	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&info->port.lock, flags);
-		return;
-	}
-	if ((tty->count == 1) && (info->port.count != 1)) {
-		/*
-		 * Uh, oh.  tty->count is 1, which means that the tty
-		 * structure will be freed.  Info->port.count should always
-		 * be one in these conditions.  If it's greater than
-		 * one, we've got real problems, since it means the
-		 * serial port won't be shutdown.
-		 */
-		printk(KERN_ERR "mxser_close: bad serial port count; "
-			"tty->count is 1, info->port.count is %d\n", info->port.count);
-		info->port.count = 1;
-	}
-	if (--info->port.count < 0) {
-		printk(KERN_ERR "mxser_close: bad serial port count for "
-			"ttys%d: %d\n", tty->index, info->port.count);
-		info->port.count = 0;
-	}
-	if (info->port.count) {
-		spin_unlock_irqrestore(&info->port.lock, flags);
+	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
-	}
-	info->port.flags |= ASYNC_CLOSING;
-	spin_unlock_irqrestore(&info->port.lock, flags);
+
 	/*
 	 * Save the termios structure, since this port may have
 	 * separate termios for callout and dialin.
+	 *
+	 * FIXME: Can this go ?
 	 */
 	if (info->port.flags & ASYNC_NORMAL_ACTIVE)
 		info->normal_termios = *tty->termios;
 	/*
-	 * Now we wait for the transmit buffer to clear; and we notify
-	 * the line discipline to only process XON/XOFF characters.
-	 */
-	tty->closing = 1;
-	if (info->port.closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->port.closing_wait);
-	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
 	 * interrupt driver to stop checking the data ready bit in the
@@ -1156,19 +1125,12 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 		}
 	}
 	mxser_shutdown(tty);
-
 	mxser_flush_buffer(tty);
-	tty_ldisc_flush(tty);
-
-	tty->closing = 0;
-	tty_port_tty_set(&info->port, NULL);
-	if (info->port.blocked_open) {
-		if (info->port.close_delay)
-			schedule_timeout_interruptible(info->port.close_delay);
-		wake_up_interruptible(&info->port.open_wait);
-	}
 
-	info->port.flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CLOSING);
+	/* Right now the tty_port set is done outside of the close_end helper
+	   as we don't yet have everyone using refcounts */	
+	tty_port_close_end(port, tty);
+	tty_port_tty_set(port, NULL);
 }
 
 static int mxser_write(struct tty_struct *tty, const unsigned char *buf, int count)
diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
index af34c20..9ac5feb 100644
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -929,35 +929,11 @@ static void rc_close(struct tty_struct *tty, struct file *filp)
 	if (!port || rc_paranoia_check(port, tty->name, "close"))
 		return;
 
-	spin_lock_irqsave(&port->port.lock, flags);
-
-	if (tty_hung_up_p(filp))
-		goto out;
-
 	bp = port_Board(port);
-	if ((tty->count == 1) && (port->port.count != 1))  {
-		printk(KERN_INFO "rc%d: rc_close: bad port count;"
-		       " tty->count is 1, port count is %d\n",
-		       board_No(bp), port->port.count);
-		port->port.count = 1;
-	}
-	if (--port->port.count < 0)  {
-		printk(KERN_INFO "rc%d: rc_close: bad port count "
-				 "for tty%d: %d\n",
-		       board_No(bp), port_No(port), port->port.count);
-		port->port.count = 0;
-	}
-	if (port->port.count)
-		goto out;
-	port->port.flags |= ASYNC_CLOSING;
-	/*
-	 * Now we wait for the transmit buffer to clear; and we notify
-	 * the line discipline to only process XON/XOFF characters.
-	 */
-	tty->closing = 1;
-	spin_unlock_irqrestore(&port->port.lock, flags);
-	if (port->port.closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, port->port.closing_wait);
+	
+	if (tty_port_close_start(&port->port, tty, filp) == 0)
+		return;
+	
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -989,23 +965,8 @@ static void rc_close(struct tty_struct *tty, struct file *filp)
 	rc_shutdown_port(tty, bp, port);
 	rc_flush_buffer(tty);
 	spin_unlock_irqrestore(&riscom_lock, flags);
-	tty_ldisc_flush(tty);
 
-	spin_lock_irqsave(&port->port.lock, flags);
-	tty->closing = 0;
-	port->port.tty = NULL;
-	if (port->port.blocked_open) {
-		spin_unlock_irqrestore(&port->port.lock, flags);
-		if (port->port.close_delay)
-			msleep_interruptible(jiffies_to_msecs(port->port.close_delay));
-		wake_up_interruptible(&port->port.open_wait);
-		spin_lock_irqsave(&port->port.lock, flags);
-	}
-	port->port.flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
-	wake_up_interruptible(&port->port.close_wait);
-
-out:
-	spin_unlock_irqrestore(&riscom_lock, flags);
+	tty_port_close_end(&port->port, tty);
 }
 
 static int rc_write(struct tty_struct *tty,
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 77eef61..e1e0dd8 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -833,40 +833,20 @@ static void stl_close(struct tty_struct *tty, struct file *filp)
 	pr_debug("stl_close(tty=%p,filp=%p)\n", tty, filp);
 
 	portp = tty->driver_data;
-	if (portp == NULL)
-		return;
+	BUG_ON(portp == NULL);
+
 	port = &portp->port;
 
-	spin_lock_irqsave(&port->lock, flags);
-	if (tty_hung_up_p(filp)) {
-		spin_unlock_irqrestore(&port->lock, flags);
+	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
-	}
-	if (tty->count == 1 && port->count != 1)
-		port->count = 1;
-	if (port->count-- > 1) {
-		spin_unlock_irqrestore(&port->lock, flags);
-		return;
-	}
-
-	port->count = 0;
-	port->flags |= ASYNC_CLOSING;
-
 /*
  *	May want to wait for any data to drain before closing. The BUSY
  *	flag keeps track of whether we are still sending or not - it is
  *	very accurate for the cd1400, not quite so for the sc26198.
  *	(The sc26198 has no "end-of-data" interrupt only empty FIFO)
  */
-	tty->closing = 1;
-
-	spin_unlock_irqrestore(&port->lock, flags);
-
-	if (portp->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, portp->closing_wait);
 	stl_waituntilsent(tty, (HZ / 2));
 
-
 	spin_lock_irqsave(&port->lock, flags);
 	portp->port.flags &= ~ASYNC_INITIALIZED;
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -883,20 +863,9 @@ static void stl_close(struct tty_struct *tty, struct file *filp)
 		portp->tx.head = NULL;
 		portp->tx.tail = NULL;
 	}
-	set_bit(TTY_IO_ERROR, &tty->flags);
-	tty_ldisc_flush(tty);
 
-	tty->closing = 0;
+	tty_port_close_end(port, tty);
 	tty_port_tty_set(port, NULL);
-
-	if (port->blocked_open) {
-		if (portp->close_delay)
-			msleep_interruptible(jiffies_to_msecs(portp->close_delay));
-		wake_up_interruptible(&portp->port.open_wait);
-	}
-
-	portp->port.flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
-	wake_up_interruptible(&port->close_wait);
 }
 
 /*****************************************************************************/
diff --git a/drivers/char/synclink.c b/drivers/char/synclink.c
index 0ded4ed..fbd5a5c 100644
--- a/drivers/char/synclink.c
+++ b/drivers/char/synclink.c
@@ -3104,70 +3104,18 @@ static void mgsl_close(struct tty_struct *tty, struct file * filp)
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_close(%s) entry, count=%d\n",
 			 __FILE__,__LINE__, info->device_name, info->port.count);
-			 
-	if (!info->port.count)
-		return;
 
-	if (tty_hung_up_p(filp))
+	if (tty_port_close_start(&info->port, tty, filp) == 0)			 
 		goto cleanup;
 			
-	if ((tty->count == 1) && (info->port.count != 1)) {
-		/*
-		 * tty->count is 1 and the tty structure will be freed.
-		 * info->port.count should be one in this case.
-		 * if it's not, correct it so that the port is shutdown.
-		 */
-		printk("mgsl_close: bad refcount; tty->count is 1, "
-		       "info->port.count is %d\n", info->port.count);
-		info->port.count = 1;
-	}
-	
-	info->port.count--;
-	
-	/* if at least one open remaining, leave hardware active */
-	if (info->port.count)
-		goto cleanup;
-	
-	info->port.flags |= ASYNC_CLOSING;
-	
-	/* set tty->closing to notify line discipline to 
-	 * only process XON/XOFF characters. Only the N_TTY
-	 * discipline appears to use this (ppp does not).
-	 */
-	tty->closing = 1;
-	
-	/* wait for transmit data to clear all layers */
-	
-	if (info->port.closing_wait != ASYNC_CLOSING_WAIT_NONE) {
-		if (debug_level >= DEBUG_LEVEL_INFO)
-			printk("%s(%d):mgsl_close(%s) calling tty_wait_until_sent\n",
-				 __FILE__,__LINE__, info->device_name );
-		tty_wait_until_sent(tty, info->port.closing_wait);
-	}
-		
  	if (info->port.flags & ASYNC_INITIALIZED)
  		mgsl_wait_until_sent(tty, info->timeout);
-
 	mgsl_flush_buffer(tty);
-
 	tty_ldisc_flush(tty);
-		
 	shutdown(info);
-	
-	tty->closing = 0;
+
+	tty_port_close_end(&info->port, tty);	
 	info->port.tty = NULL;
-	
-	if (info->port.blocked_open) {
-		if (info->port.close_delay) {
-			msleep_interruptible(jiffies_to_msecs(info->port.close_delay));
-		}
-		wake_up_interruptible(&info->port.open_wait);
-	}
-	
-	info->port.flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
-			 
-	wake_up_interruptible(&info->port.close_wait);
-	
 cleanup:			
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_close(%s) exit, count=%d\n", __FILE__,__LINE__,
diff --git a/drivers/char/synclink_gt.c b/drivers/char/synclink_gt.c
index 625c9bd..53544e2 100644
--- a/drivers/char/synclink_gt.c
+++ b/drivers/char/synclink_gt.c
@@ -720,44 +720,9 @@ static void close(struct tty_struct *tty, struct file *filp)
 		return;
 	DBGINFO(("%s close entry, count=%d\n", info->device_name, info->port.count));
 
-	if (!info->port.count)
-		return;
-
-	if (tty_hung_up_p(filp))
+	if (tty_port_close_start(&info->port, tty, filp) == 0)
 		goto cleanup;
 
-	if ((tty->count == 1) && (info->port.count != 1)) {
-		/*
-		 * tty->count is 1 and the tty structure will be freed.
-		 * info->port.count should be one in this case.
-		 * if it's not, correct it so that the port is shutdown.
-		 */
-		DBGERR(("%s close: bad refcount; tty->count=1, "
-		       "info->port.count=%d\n", info->device_name, info->port.count));
-		info->port.count = 1;
-	}
-
-	info->port.count--;
-
-	/* if at least one open remaining, leave hardware active */
-	if (info->port.count)
-		goto cleanup;
-
-	info->port.flags |= ASYNC_CLOSING;
-
-	/* set tty->closing to notify line discipline to
-	 * only process XON/XOFF characters. Only the N_TTY
-	 * discipline appears to use this (ppp does not).
-	 */
-	tty->closing = 1;
-
-	/* wait for transmit data to clear all layers */
-
-	if (info->port.closing_wait != ASYNC_CLOSING_WAIT_NONE) {
-		DBGINFO(("%s call tty_wait_until_sent\n", info->device_name));
-		tty_wait_until_sent(tty, info->port.closing_wait);
-	}
-
  	if (info->port.flags & ASYNC_INITIALIZED)
  		wait_until_sent(tty, info->timeout);
 	flush_buffer(tty);
@@ -765,20 +730,8 @@ static void close(struct tty_struct *tty, struct file *filp)
 
 	shutdown(info);
 
-	tty->closing = 0;
+	tty_port_close_end(&info->port, tty);
 	info->port.tty = NULL;
-
-	if (info->port.blocked_open) {
-		if (info->port.close_delay) {
-			msleep_interruptible(jiffies_to_msecs(info->port.close_delay));
-		}
-		wake_up_interruptible(&info->port.open_wait);
-	}
-
-	info->port.flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
-
-	wake_up_interruptible(&info->port.close_wait);
-
 cleanup:
 	DBGINFO(("%s close exit, count=%d\n", tty->driver->name, info->port.count));
 }
diff --git a/drivers/char/synclinkmp.c b/drivers/char/synclinkmp.c
index 1f5c21e..2aac55b 100644
--- a/drivers/char/synclinkmp.c
+++ b/drivers/char/synclinkmp.c
@@ -810,70 +810,18 @@ static void close(struct tty_struct *tty, struct file *filp)
 		printk("%s(%d):%s close() entry, count=%d\n",
 			 __FILE__,__LINE__, info->device_name, info->port.count);
 
-	if (!info->port.count)
-		return;
-
-	if (tty_hung_up_p(filp))
-		goto cleanup;
-
-	if ((tty->count == 1) && (info->port.count != 1)) {
-		/*
-		 * tty->count is 1 and the tty structure will be freed.
-		 * info->port.count should be one in this case.
-		 * if it's not, correct it so that the port is shutdown.
-		 */
-		printk("%s(%d):%s close: bad refcount; tty->count is 1, "
-		       "info->port.count is %d\n",
-			 __FILE__,__LINE__, info->device_name, info->port.count);
-		info->port.count = 1;
-	}
-
-	info->port.count--;
-
-	/* if at least one open remaining, leave hardware active */
-	if (info->port.count)
+	if (tty_port_close_start(&info->port, tty, filp) == 0)
 		goto cleanup;
-
-	info->port.flags |= ASYNC_CLOSING;
-
-	/* set tty->closing to notify line discipline to
-	 * only process XON/XOFF characters. Only the N_TTY
-	 * discipline appears to use this (ppp does not).
-	 */
-	tty->closing = 1;
-
-	/* wait for transmit data to clear all layers */
-
-	if (info->port.closing_wait != ASYNC_CLOSING_WAIT_NONE) {
-		if (debug_level >= DEBUG_LEVEL_INFO)
-			printk("%s(%d):%s close() calling tty_wait_until_sent\n",
-				 __FILE__,__LINE__, info->device_name );
-		tty_wait_until_sent(tty, info->port.closing_wait);
-	}
-
+		
  	if (info->port.flags & ASYNC_INITIALIZED)
  		wait_until_sent(tty, info->timeout);
 
 	flush_buffer(tty);
-
 	tty_ldisc_flush(tty);
-
 	shutdown(info);
 
-	tty->closing = 0;
+	tty_port_close_end(&info->port, tty);
 	info->port.tty = NULL;
-
-	if (info->port.blocked_open) {
-		if (info->port.close_delay) {
-			msleep_interruptible(jiffies_to_msecs(info->port.close_delay));
-		}
-		wake_up_interruptible(&info->port.open_wait);
-	}
-
-	info->port.flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
-
-	wake_up_interruptible(&info->port.close_wait);
-
 cleanup:
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):%s close() exit, count=%d\n", __FILE__,__LINE__,
diff --git a/drivers/char/tty_port.c b/drivers/char/tty_port.c
index 0723664..b3175f5 100644
--- a/drivers/char/tty_port.c
+++ b/drivers/char/tty_port.c
@@ -257,3 +257,61 @@ int tty_port_block_til_ready(struct tty_port *port,
 }
 EXPORT_SYMBOL(tty_port_block_til_ready);
 
+int tty_port_close_start(struct tty_port *port, struct tty_struct *tty, struct file *filp)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	if (tty_hung_up_p(filp)) {
+		spin_unlock_irqrestore(&port->lock, flags);
+		return 0;
+	}
+
+	if( tty->count == 1 && port->count != 1) {
+		printk(KERN_WARNING
+		    "tty_port_close_start: tty->count = 1 port count = %d.\n",
+								port->count);
+		port->count = 1;
+	}
+	if (--port->count < 0) {
+		printk(KERN_WARNING "tty_port_close_start: count = %d\n",
+								port->count);
+		port->count = 0;
+	}
+
+	if (port->count) {
+		spin_unlock_irqrestore(&port->lock, flags);
+		return 0;
+	}
+	port->flags |= ASYNC_CLOSING;
+	tty->closing = 1;
+	spin_unlock_irqrestore(&port->lock, flags);
+	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, port->closing_wait);
+	return 1;
+}
+EXPORT_SYMBOL(tty_port_close_start);
+
+void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
+{
+	unsigned long flags;
+
+	tty_ldisc_flush(tty);
+
+	spin_lock_irqsave(&port->lock, flags);
+	tty->closing = 0;
+
+	if (port->blocked_open) {
+		spin_unlock_irqrestore(&port->lock, flags);
+		if (port->close_delay) {
+			msleep_interruptible(
+				jiffies_to_msecs(port->close_delay));
+		}
+		spin_lock_irqsave(&port->lock, flags);
+		wake_up_interruptible(&port->open_wait);
+	}
+	port->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CLOSING);
+	wake_up_interruptible(&port->close_wait);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+EXPORT_SYMBOL(tty_port_close_end);
diff --git a/include/linux/istallion.h b/include/linux/istallion.h
index 053d5ae..7faca98 100644
--- a/include/linux/istallion.h
+++ b/include/linux/istallion.h
@@ -59,7 +59,6 @@ struct stliport {
 	unsigned int		devnr;
 	int			baud_base;
 	int			custom_divisor;
-	int			close_delay;
 	int			closing_wait;
 	int			rc;
 	int			argsize;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 61a0ab3..fc39db9 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -441,6 +441,9 @@ extern void tty_port_raise_dtr_rts(struct tty_port *port);
 extern void tty_port_hangup(struct tty_port *port);
 extern int tty_port_block_til_ready(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp);
+extern int tty_port_close_start(struct tty_port *port,
+				struct tty_struct *tty, struct file *filp);
+extern void tty_port_close_end(struct tty_port *port, struct tty_struct *tty);
 
 extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);

