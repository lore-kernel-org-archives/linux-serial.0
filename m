From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 57/75] tty: Redo the rocket driver locking
Date: Fri, 02 Jan 2009 13:48:17 +0000
Message-ID: <20090102134816.13472.35452.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37650 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757405AbZABNsD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:48:03 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Bring this driver into the port locking model

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/epca.c   |    9 ++-------
 drivers/char/rocket.c |   35 ++++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 24 deletions(-)


diff --git a/drivers/char/epca.c b/drivers/char/epca.c
index 71225d1..39ad820 100644
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -164,8 +164,6 @@ static int pc_write_room(struct tty_struct *);
 static int pc_chars_in_buffer(struct tty_struct *);
 static void pc_flush_buffer(struct tty_struct *);
 static void pc_flush_chars(struct tty_struct *);
-static int block_til_ready(struct tty_struct *, struct file *,
-			struct channel *);
 static int pc_open(struct tty_struct *, struct file *);
 static void post_fep_init(unsigned int crd);
 static void epcapoll(unsigned long);
@@ -422,7 +420,6 @@ static void pc_close(struct tty_struct *tty, struct file *filp)
 {
 	struct channel *ch;
 	struct tty_port *port;
-	unsigned long flags;
 	/*
 	 * verifyChannel returns the channel from the tty struct if it is
 	 * valid. This serves as a sanity check.
@@ -491,8 +488,6 @@ static void pc_hangup(struct tty_struct *tty)
 	 */
 	ch = verifyChannel(tty);
 	if (ch != NULL) {
-		unsigned long flags;
-
 		pc_flush_buffer(tty);
 		tty_ldisc_flush(tty);
 		shutdown(ch, tty);
@@ -750,7 +745,7 @@ static int epca_carrier_raised(struct tty_port *port)
 	return 0;
 }
 
-static void epca_raise_dtr_rts(struct tty_port *port0
+static void epca_raise_dtr_rts(struct tty_port *port)
 {
 }
 
@@ -1268,7 +1263,7 @@ static void post_fep_init(unsigned int crd)
 		u16 tseg, rseg;
 
 		tty_port_init(&ch->port);
-		ch->port.ops - &epca_port_ops;
+		ch->port.ops = &epca_port_ops;
 		ch->brdchan = bc;
 		ch->mailbox = gd;
 		INIT_WORK(&ch->tqueue, do_softint);
diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
index 1e68cc2..efc3e5c 100644
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -920,7 +920,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 #ifdef ROCKET_DEBUG_OPEN
 	printk(KERN_INFO "block_til_ready before block: ttyR%d, count = %d\n", info->line, port->count);
 #endif
-	spin_lock_irqsave(&info->slock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 
 #ifdef ROCKET_DISABLE_SIMUSAGE
 	info->flags |= ASYNC_NORMAL_ACTIVE;
@@ -932,7 +932,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 #endif
 	port->blocked_open++;
 
-	spin_unlock_irqrestore(&info->slock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	while (1) {
 		if (tty->termios->c_cflag & CBAUD)
@@ -961,13 +961,13 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
 
-	spin_lock_irqsave(&info->slock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 
 	if (extra_count)
 		port->count++;
 	port->blocked_open--;
 
-	spin_unlock_irqrestore(&info->slock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 #ifdef ROCKET_DEBUG_OPEN
 	printk(KERN_INFO "block_til_ready after blocking: ttyR%d, count = %d\n",
@@ -1095,6 +1095,7 @@ static int rp_open(struct tty_struct *tty, struct file *filp)
 static void rp_close(struct tty_struct *tty, struct file *filp)
 {
 	struct r_port *info = tty->driver_data;
+	struct tty_port *port = &info->port;
 	unsigned long flags;
 	int timeout;
 	CHANNEL_t *cp;
@@ -1108,9 +1109,9 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 
 	if (tty_hung_up_p(filp))
 		return;
-	spin_lock_irqsave(&info->slock, flags);
+	spin_lock_irqsave(&port->lock, flags);
 
-	if ((tty->count == 1) && (info->port.count != 1)) {
+	if (tty->count == 1 && port->count != 1) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always
@@ -1120,19 +1121,19 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 		 */
 		printk(KERN_WARNING "rp_close: bad serial port count; "
 			"tty->count is 1, info->port.count is %d\n", info->port.count);
-		info->port.count = 1;
+		port->count = 1;
 	}
-	if (--info->port.count < 0) {
+	if (--port->count < 0) {
 		printk(KERN_WARNING "rp_close: bad serial port count for "
 				"ttyR%d: %d\n", info->line, info->port.count);
-		info->port.count = 0;
+		port->count = 0;
 	}
-	if (info->port.count) {
-		spin_unlock_irqrestore(&info->slock, flags);
+	if (port->count) {
+		spin_unlock_irqrestore(&port->lock, flags);
 		return;
 	}
 	info->flags |= ASYNC_CLOSING;
-	spin_unlock_irqrestore(&info->slock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	cp = &info->channel;
 
@@ -1152,7 +1153,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 	 * Wait for the transmit buffer to clear
 	 */
 	if (info->port.closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->port.closing_wait);
+		tty_wait_until_sent(tty, port->closing_wait);
 	/*
 	 * Before we drop DTR, make sure the UART transmitter
 	 * has completely drained; this is especially
@@ -1181,11 +1182,11 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 
 	clear_bit((info->aiop * 8) + info->chan, (void *) &xmit_flags[info->board]);
 
-	if (info->port.blocked_open) {
-		if (info->port.close_delay) {
-			msleep_interruptible(jiffies_to_msecs(info->port.close_delay));
+	if (port->blocked_open) {
+		if (port->close_delay) {
+			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		}
-		wake_up_interruptible(&info->port.open_wait);
+		wake_up_interruptible(&port->open_wait);
 	} else {
 		if (info->xmit_buf) {
 			free_page((unsigned long) info->xmit_buf);

