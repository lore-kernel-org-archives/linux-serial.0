From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 59/75] tty: kref the rocket driver
Date: Fri, 02 Jan 2009 13:48:30 +0000
Message-ID: <20090102134829.13472.72723.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37658 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757289AbZABNsY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:48:24 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

We will need this kref fitted to make full use of the port operations.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/rocket.c |   78 ++++++++++++++++++++++++++-----------------------
 1 files changed, 41 insertions(+), 37 deletions(-)


diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
index ca6fcdc..b5e5e77 100644
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -436,15 +436,15 @@ static void rp_do_transmit(struct r_port *info)
 #endif
 	if (!info)
 		return;
-	if (!info->port.tty) {
-		printk(KERN_WARNING "rp: WARNING %s called with "
-				"info->port.tty==NULL\n", __func__);
+	tty = tty_port_tty_get(&info->port);
+
+	if (tty == NULL) {
+		printk(KERN_WARNING "rp: WARNING %s called with tty==NULL\n", __func__);
 		clear_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
 		return;
 	}
 
 	spin_lock_irqsave(&info->slock, flags);
-	tty = info->port.tty;
 	info->xmit_fifo_room = TXFIFO_SIZE - sGetTxCnt(cp);
 
 	/*  Loop sending data to FIFO until done or FIFO full */
@@ -478,6 +478,7 @@ static void rp_do_transmit(struct r_port *info)
 	}
 
 	spin_unlock_irqrestore(&info->slock, flags);
+	tty_kref_put(tty);
 
 #ifdef ROCKET_DEBUG_INTR
 	printk(KERN_DEBUG "(%d,%d,%d,%d)...\n", info->xmit_cnt, info->xmit_head,
@@ -504,13 +505,13 @@ static void rp_handle_port(struct r_port *info)
 				"info->flags & NOT_INIT\n");
 		return;
 	}
-	if (!info->port.tty) {
+	tty = tty_port_tty_get(&info->port);
+	if (!tty) {
 		printk(KERN_WARNING "rp: WARNING: rp_handle_port called with "
-				"info->port.tty==NULL\n");
+				"tty==NULL\n");
 		return;
 	}
 	cp = &info->channel;
-	tty = info->port.tty;
 
 	IntMask = sGetChanIntID(cp) & info->intmask;
 #ifdef ROCKET_DEBUG_INTR
@@ -542,6 +543,7 @@ static void rp_handle_port(struct r_port *info)
 		printk(KERN_INFO "DSR change...\n");
 	}
 #endif
+	tty_kref_put(tty);
 }
 
 /*
@@ -710,7 +712,7 @@ static void init_r_port(int board, int aiop, int chan, struct pci_dev *pci_dev)
  *  Configures a rocketport port according to its termio settings.  Called from 
  *  user mode into the driver (exception handler).  *info CD manipulation is spinlock protected.
  */
-static void configure_r_port(struct r_port *info,
+static void configure_r_port(struct tty_struct *tty, struct r_port *info,
 			     struct ktermios *old_termios)
 {
 	unsigned cflag;
@@ -718,7 +720,7 @@ static void configure_r_port(struct r_port *info,
 	unsigned rocketMode;
 	int bits, baud, divisor;
 	CHANNEL_t *cp;
-	struct ktermios *t = info->port.tty->termios;
+	struct ktermios *t = tty->termios;
 
 	cp = &info->channel;
 	cflag = t->c_cflag;
@@ -751,7 +753,7 @@ static void configure_r_port(struct r_port *info,
 	}
 
 	/* baud rate */
-	baud = tty_get_baud_rate(info->port.tty);
+	baud = tty_get_baud_rate(tty);
 	if (!baud)
 		baud = 9600;
 	divisor = ((rp_baud_base[info->board] + (baud >> 1)) / baud) - 1;
@@ -769,7 +771,7 @@ static void configure_r_port(struct r_port *info,
 	sSetBaud(cp, divisor);
 
 	/* FIXME: Should really back compute a baud rate from the divisor */
-	tty_encode_baud_rate(info->port.tty, baud, baud);
+	tty_encode_baud_rate(tty, baud, baud);
 
 	if (cflag & CRTSCTS) {
 		info->intmask |= DELTA_CTS;
@@ -794,15 +796,15 @@ static void configure_r_port(struct r_port *info,
 	 * Handle software flow control in the board
 	 */
 #ifdef ROCKET_SOFT_FLOW
-	if (I_IXON(info->port.tty)) {
+	if (I_IXON(tty)) {
 		sEnTxSoftFlowCtl(cp);
-		if (I_IXANY(info->port.tty)) {
+		if (I_IXANY(tty)) {
 			sEnIXANY(cp);
 		} else {
 			sDisIXANY(cp);
 		}
-		sSetTxXONChar(cp, START_CHAR(info->port.tty));
-		sSetTxXOFFChar(cp, STOP_CHAR(info->port.tty));
+		sSetTxXONChar(cp, START_CHAR(tty));
+		sSetTxXOFFChar(cp, STOP_CHAR(tty));
 	} else {
 		sDisTxSoftFlowCtl(cp);
 		sDisIXANY(cp);
@@ -814,24 +816,24 @@ static void configure_r_port(struct r_port *info,
 	 * Set up ignore/read mask words
 	 */
 	info->read_status_mask = STMRCVROVRH | 0xFF;
-	if (I_INPCK(info->port.tty))
+	if (I_INPCK(tty))
 		info->read_status_mask |= STMFRAMEH | STMPARITYH;
-	if (I_BRKINT(info->port.tty) || I_PARMRK(info->port.tty))
+	if (I_BRKINT(tty) || I_PARMRK(tty))
 		info->read_status_mask |= STMBREAKH;
 
 	/*
 	 * Characters to ignore
 	 */
 	info->ignore_status_mask = 0;
-	if (I_IGNPAR(info->port.tty))
+	if (I_IGNPAR(tty))
 		info->ignore_status_mask |= STMFRAMEH | STMPARITYH;
-	if (I_IGNBRK(info->port.tty)) {
+	if (I_IGNBRK(tty)) {
 		info->ignore_status_mask |= STMBREAKH;
 		/*
 		 * If we're ignoring parity and break indicators,
 		 * ignore overruns too.  (For real raw support).
 		 */
-		if (I_IGNPAR(info->port.tty))
+		if (I_IGNPAR(tty))
 			info->ignore_status_mask |= STMRCVROVRH;
 	}
 
@@ -1015,7 +1017,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 		info->xmit_buf = (unsigned char *) page;
 
 	tty->driver_data = info;
-	info->port.tty = tty;
+	tty_port_tty_set(&info->port, tty);
 
 	if (info->port.count++ == 0) {
 		atomic_inc(&rp_num_ports_open);
@@ -1062,15 +1064,15 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 		 * Set up the tty->alt_speed kludge
 		 */
 		if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_HI)
-			info->port.tty->alt_speed = 57600;
+			tty->alt_speed = 57600;
 		if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_VHI)
-			info->port.tty->alt_speed = 115200;
+			tty->alt_speed = 115200;
 		if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_SHI)
-			info->port.tty->alt_speed = 230400;
+			tty->alt_speed = 230400;
 		if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_WARP)
-			info->port.tty->alt_speed = 460800;
+			tty->alt_speed = 460800;
 
-		configure_r_port(info, NULL);
+		configure_r_port(tty, info, NULL);
 		if (tty->termios->c_cflag & CBAUD) {
 			sSetDTR(cp);
 			sSetRTS(cp);
@@ -1227,7 +1229,7 @@ static void rp_set_termios(struct tty_struct *tty,
 	/* Or CMSPAR */
 	tty->termios->c_cflag &= ~CMSPAR;
 
-	configure_r_port(info, old_termios);
+	configure_r_port(tty, info, old_termios);
 
 	cp = &info->channel;
 
@@ -1352,7 +1354,8 @@ static int get_config(struct r_port *info, struct rocket_config __user *retinfo)
 	return 0;
 }
 
-static int set_config(struct r_port *info, struct rocket_config __user *new_info)
+static int set_config(struct tty_struct *tty, struct r_port *info,
+					struct rocket_config __user *new_info)
 {
 	struct rocket_config new_serial;
 
@@ -1364,7 +1367,7 @@ static int set_config(struct r_port *info, struct rocket_config __user *new_info
 		if ((new_serial.flags & ~ROCKET_USR_MASK) != (info->flags & ~ROCKET_USR_MASK))
 			return -EPERM;
 		info->flags = ((info->flags & ~ROCKET_USR_MASK) | (new_serial.flags & ROCKET_USR_MASK));
-		configure_r_port(info, NULL);
+		configure_r_port(tty, info, NULL);
 		return 0;
 	}
 
@@ -1373,15 +1376,15 @@ static int set_config(struct r_port *info, struct rocket_config __user *new_info
 	info->port.closing_wait = new_serial.closing_wait;
 
 	if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_HI)
-		info->port.tty->alt_speed = 57600;
+		tty->alt_speed = 57600;
 	if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_VHI)
-		info->port.tty->alt_speed = 115200;
+		tty->alt_speed = 115200;
 	if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_SHI)
-		info->port.tty->alt_speed = 230400;
+		tty->alt_speed = 230400;
 	if ((info->flags & ROCKET_SPD_MASK) == ROCKET_SPD_WARP)
-		info->port.tty->alt_speed = 460800;
+		tty->alt_speed = 460800;
 
-	configure_r_port(info, NULL);
+	configure_r_port(tty, info, NULL);
 	return 0;
 }
 
@@ -1466,7 +1469,7 @@ static int rp_ioctl(struct tty_struct *tty, struct file *file,
 		ret = get_config(info, argp);
 		break;
 	case RCKP_SET_CONFIG:
-		ret = set_config(info, argp);
+		ret = set_config(tty, info, argp);
 		break;
 	case RCKP_GET_PORTS:
 		ret = get_ports(info, argp);
@@ -1658,7 +1661,7 @@ static void rp_hangup(struct tty_struct *tty)
 
 	info->port.count = 0;
 	info->port.flags &= ~ASYNC_NORMAL_ACTIVE;
-	info->port.tty = NULL;
+	tty_port_tty_set(&info->port, NULL);
 
 	cp = &info->channel;
 	sDisRxFIFO(cp);
@@ -1778,7 +1781,8 @@ static int rp_write(struct tty_struct *tty,
 
 	/*  Write remaining data into the port's xmit_buf */
 	while (1) {
-		if (!info->port.tty)		/* Seemingly obligatory check... */
+		/* Hung up ? */
+		if (!test_bit(ASYNC_NORMAL_ACTIVE, &info->port.flags))
 			goto end;
 		c = min(count, XMIT_BUF_SIZE - info->xmit_cnt - 1);
 		c = min(c, XMIT_BUF_SIZE - info->xmit_head);

