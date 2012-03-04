From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: [PATCH 1/9] tty: make receive_buf() return the amout of bytes received
Date: Sun,  4 Mar 2012 18:59:12 +0100
Message-ID: <1330883960-8563-2-git-send-email-castet.matthieu@free.fr>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43602 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab2CDR76 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 12:59:58 -0500
Received: by wejx9 with SMTP id x9so1931855wej.19
        for <linux-serial@vger.kernel.org>; Sun, 04 Mar 2012 09:59:56 -0800 (PST)
In-Reply-To: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>

it makes it simpler to keep track of the amount of bytes received.

For a first step, will always return that we received everything.
This make sure to we don't break anything when we will check receive_buf
return value.

Some code is based on b1c43f82c5aa265442f82dba31ce985ebb7aa71c reverted
commit.

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
---
 drivers/bluetooth/hci_ldisc.c      |   11 +++++++----
 drivers/input/serio/serport.c      |    9 +++++++--
 drivers/isdn/gigaset/ser-gigaset.c |    8 +++++---
 drivers/misc/ti-st/st_core.c       |    6 ++++--
 drivers/net/caif/caif_serial.c     |   10 ++++++----
 drivers/net/can/slcan.c            |    9 ++++++---
 drivers/net/hamradio/6pack.c       |   11 ++++++-----
 drivers/net/hamradio/mkiss.c       |   11 +++++++----
 drivers/net/irda/irtty-sir.c       |   16 +++++++++-------
 drivers/net/ppp/ppp_async.c        |    6 ++++--
 drivers/net/ppp/ppp_synctty.c      |    6 ++++--
 drivers/net/slip/slip.c            |    7 +++++--
 drivers/net/wan/x25_asy.c          |    9 ++++++---
 drivers/tty/n_gsm.c                |    6 ++++--
 drivers/tty/n_hdlc.c               |   18 ++++++++++--------
 drivers/tty/n_r3964.c              |   10 ++++++----
 drivers/tty/n_tracerouter.c        |    4 +++-
 drivers/tty/n_tty.c                |    6 ++++--
 include/linux/tty_ldisc.h          |    9 +++++----
 sound/soc/omap/ams-delta.c         |    7 ++++---
 20 files changed, 112 insertions(+), 67 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 0711448..47b97a8 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -355,17 +355,18 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
  *             flags        pointer to flags for data
  *             count        count of received data in bytes
  *     
- * Return Value:    None
+ * Return Value:    bytes received.
  */
-static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *flags, int count)
+static int hci_uart_tty_receive(struct tty_struct *tty,
+		const u8 *data, char *flags, int count)
 {
 	struct hci_uart *hu = (void *)tty->disc_data;
 
 	if (!hu || tty != hu->tty)
-		return;
+		return count;
 
 	if (!test_bit(HCI_UART_PROTO_SET, &hu->flags))
-		return;
+		return count;
 
 	spin_lock(&hu->rx_lock);
 	hu->proto->recv(hu, (void *) data, count);
@@ -373,6 +374,8 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *f
 	spin_unlock(&hu->rx_lock);
 
 	tty_unthrottle(tty);
+
+	return count;
 }
 
 static int hci_uart_register_dev(struct hci_uart *hu)
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 8755f5f..657043a 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -120,17 +120,20 @@ static void serport_ldisc_close(struct tty_struct *tty)
  * 'interrupt' routine.
  */
 
-static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *cp, char *fp, int count)
+static int serport_ldisc_receive(struct tty_struct *tty,
+		const unsigned char *cp, char *fp, int count)
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
 	unsigned long flags;
 	unsigned int ch_flags;
+	int ret = 0;
 	int i;
 
 	spin_lock_irqsave(&serport->lock, flags);
 
-	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
+	if (!test_bit(SERPORT_ACTIVE, &serport->flags)) {
 		goto out;
+	}
 
 	for (i = 0; i < count; i++) {
 		switch (fp[i]) {
@@ -152,6 +155,8 @@ static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *c
 
 out:
 	spin_unlock_irqrestore(&serport->lock, flags);
+
+	return count;
 }
 
 /*
diff --git a/drivers/isdn/gigaset/ser-gigaset.c b/drivers/isdn/gigaset/ser-gigaset.c
index 86a5c4f..569712a 100644
--- a/drivers/isdn/gigaset/ser-gigaset.c
+++ b/drivers/isdn/gigaset/ser-gigaset.c
@@ -674,7 +674,7 @@ gigaset_tty_ioctl(struct tty_struct *tty, struct file *file,
  *	cflags	buffer containing error flags for received characters (ignored)
  *	count	number of received characters
  */
-static void
+static int
 gigaset_tty_receive(struct tty_struct *tty, const unsigned char *buf,
 		    char *cflags, int count)
 {
@@ -683,12 +683,12 @@ gigaset_tty_receive(struct tty_struct *tty, const unsigned char *buf,
 	struct inbuf_t *inbuf;
 
 	if (!cs)
-		return;
+		return count;
 	inbuf = cs->inbuf;
 	if (!inbuf) {
 		dev_err(cs->dev, "%s: no inbuf\n", __func__);
 		cs_put(cs);
-		return;
+		return count;
 	}
 
 	tail = inbuf->tail;
@@ -725,6 +725,8 @@ gigaset_tty_receive(struct tty_struct *tty, const unsigned char *buf,
 	gig_dbg(DEBUG_INTR, "%s-->BH", __func__);
 	gigaset_schedule_event(cs);
 	cs_put(cs);
+
+	return count;
 }
 
 /*
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 2b62232..bc3f61c 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -765,8 +765,8 @@ static void st_tty_close(struct tty_struct *tty)
 	pr_debug("%s: done ", __func__);
 }
 
-static void st_tty_receive(struct tty_struct *tty, const unsigned char *data,
-			   char *tty_flags, int count)
+static int st_tty_receive(struct tty_struct *tty,
+		const unsigned char *data, char *tty_flags, int count)
 {
 #ifdef VERBOSE
 	print_hex_dump(KERN_DEBUG, ">in>", DUMP_PREFIX_NONE,
@@ -779,6 +779,8 @@ static void st_tty_receive(struct tty_struct *tty, const unsigned char *data,
 	 */
 	st_recv(tty->disc_data, data, count);
 	pr_debug("done %s", __func__);
+
+	return count;
 }
 
 /* wake-up function called in from the TTY layer
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index 8a3054b..d801d6e 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -167,8 +167,8 @@ static inline void debugfs_tx(struct ser_device *ser, const u8 *data, int size)
 
 #endif
 
-static void ldisc_receive(struct tty_struct *tty, const u8 *data,
-			char *flags, int count)
+static int ldisc_receive(struct tty_struct *tty,
+		const u8 *data, char *flags, int count)
 {
 	struct sk_buff *skb = NULL;
 	struct ser_device *ser;
@@ -191,7 +191,7 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
 		dev_info(&ser->dev->dev,
 			"Bytes received before initial transmission -"
 			"bytes discarded.\n");
-		return;
+		return count;
 	}
 
 	BUG_ON(ser->dev == NULL);
@@ -199,7 +199,7 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
 	/* Get a suitable caif packet and copy in data. */
 	skb = netdev_alloc_skb(ser->dev, count+1);
 	if (skb == NULL)
-		return;
+		return count;
 	p = skb_put(skb, count);
 	memcpy(p, data, count);
 
@@ -215,6 +215,8 @@ static void ldisc_receive(struct tty_struct *tty, const u8 *data,
 	} else
 		++ser->dev->stats.rx_dropped;
 	update_tty_status(ser);
+
+	return count;
 }
 
 static int handle_tx(struct ser_device *ser)
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 3f1ebcc..3229e30 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -403,16 +403,17 @@ static void slc_setup(struct net_device *dev)
  * in parallel
  */
 
-static void slcan_receive_buf(struct tty_struct *tty,
+static int slcan_receive_buf(struct tty_struct *tty,
 			      const unsigned char *cp, char *fp, int count)
 {
 	struct slcan *sl = (struct slcan *) tty->disc_data;
+	int bytes = count;
 
 	if (!sl || sl->magic != SLCAN_MAGIC || !netif_running(sl->dev))
-		return;
+		return count;
 
 	/* Read the characters out of the buffer */
-	while (count--) {
+	while (bytes--) {
 		if (fp && *fp++) {
 			if (!test_and_set_bit(SLF_ERROR, &sl->flags))
 				sl->dev->stats.rx_errors++;
@@ -421,6 +422,8 @@ static void slcan_receive_buf(struct tty_struct *tty,
 		}
 		slcan_unesc(sl, *cp++);
 	}
+
+	return count;
 }
 
 /************************************
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 2a5a34d..39ad8fe 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -456,25 +456,24 @@ out:
  * a block of 6pack data has been received, which can now be decapsulated
  * and sent on to some IP layer for further processing.
  */
-static void sixpack_receive_buf(struct tty_struct *tty,
+static int sixpack_receive_buf(struct tty_struct *tty,
 	const unsigned char *cp, char *fp, int count)
 {
 	struct sixpack *sp;
 	unsigned char buf[512];
-	int count1;
+	int received = count;
 
 	if (!count)
-		return;
+		return 0;
 
 	sp = sp_get(tty);
 	if (!sp)
-		return;
+		return count;
 
 	memcpy(buf, cp, count < sizeof(buf) ? count : sizeof(buf));
 
 	/* Read the characters out of the buffer */
 
-	count1 = count;
 	while (count) {
 		count--;
 		if (fp && *fp++) {
@@ -487,6 +486,8 @@ static void sixpack_receive_buf(struct tty_struct *tty,
 
 	sp_put(sp);
 	tty_unthrottle(tty);
+
+	return received;
 }
 
 /*
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index bc02968..75173ca 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -923,13 +923,14 @@ static long mkiss_compat_ioctl(struct tty_struct *tty, struct file *file,
  * a block of data has been received, which can now be decapsulated
  * and sent on to the AX.25 layer for further processing.
  */
-static void mkiss_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-	char *fp, int count)
+static int mkiss_receive_buf(struct tty_struct *tty,
+		const unsigned char *cp, char *fp, int count)
 {
 	struct mkiss *ax = mkiss_get(tty);
+	int bytes = count;
 
 	if (!ax)
-		return;
+		return count;
 
 	/*
 	 * Argh! mtu change time! - costs us the packet part received
@@ -939,7 +940,7 @@ static void mkiss_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		ax_changedmtu(ax);
 
 	/* Read the characters out of the buffer */
-	while (count--) {
+	while (bytes--) {
 		if (fp != NULL && *fp++) {
 			if (!test_and_set_bit(AXF_ERROR, &ax->flags))
 				ax->dev->stats.rx_errors++;
@@ -952,6 +953,8 @@ static void mkiss_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 
 	mkiss_put(ax);
 	tty_unthrottle(tty);
+
+	return count;
 }
 
 /*
diff --git a/drivers/net/irda/irtty-sir.c b/drivers/net/irda/irtty-sir.c
index 3352b24..3166e91 100644
--- a/drivers/net/irda/irtty-sir.c
+++ b/drivers/net/irda/irtty-sir.c
@@ -216,23 +216,23 @@ static int irtty_do_write(struct sir_dev *dev, const unsigned char *ptr, size_t
  * usbserial:	urb-complete-interrupt / softint
  */
 
-static void irtty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			      char *fp, int count) 
+static int irtty_receive_buf(struct tty_struct *tty,
+		const unsigned char *cp, char *fp, int count)
 {
 	struct sir_dev *dev;
 	struct sirtty_cb *priv = tty->disc_data;
 	int	i;
 
-	IRDA_ASSERT(priv != NULL, return;);
-	IRDA_ASSERT(priv->magic == IRTTY_MAGIC, return;);
+	IRDA_ASSERT(priv != NULL, return count;);
+	IRDA_ASSERT(priv->magic == IRTTY_MAGIC, return count;);
 
 	if (unlikely(count==0))		/* yes, this happens */
-		return;
+		return 0;
 
 	dev = priv->dev;
 	if (!dev) {
 		IRDA_WARNING("%s(), not ready yet!\n", __func__);
-		return;
+		return count;
 	}
 
 	for (i = 0; i < count; i++) {
@@ -242,11 +242,13 @@ static void irtty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
  		if (fp && *fp++) { 
 			IRDA_DEBUG(0, "Framing or parity error!\n");
 			sirdev_receive(dev, NULL, 0);	/* notify sir_dev (updating stats) */
-			return;
+			return count;
  		}
 	}
 
 	sirdev_receive(dev, cp, count);
+
+	return count;
 }
 
 /*
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index c6ba643..aefd499 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -341,7 +341,7 @@ ppp_asynctty_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
 }
 
 /* May sleep, don't call from interrupt level or with interrupts disabled */
-static void
+static int
 ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
 		  char *cflags, int count)
 {
@@ -349,7 +349,7 @@ ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
 	unsigned long flags;
 
 	if (!ap)
-		return;
+		return count;
 	spin_lock_irqsave(&ap->recv_lock, flags);
 	ppp_async_input(ap, buf, cflags, count);
 	spin_unlock_irqrestore(&ap->recv_lock, flags);
@@ -357,6 +357,8 @@ ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
 		tasklet_schedule(&ap->tsk);
 	ap_put(ap);
 	tty_unthrottle(tty);
+
+	return count;
 }
 
 static void
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 736a39e..248ece3 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -382,7 +382,7 @@ ppp_sync_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
 }
 
 /* May sleep, don't call from interrupt level or with interrupts disabled */
-static void
+static int
 ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
 		  char *cflags, int count)
 {
@@ -390,7 +390,7 @@ ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
 	unsigned long flags;
 
 	if (!ap)
-		return;
+		return count;
 	spin_lock_irqsave(&ap->recv_lock, flags);
 	ppp_sync_input(ap, buf, cflags, count);
 	spin_unlock_irqrestore(&ap->recv_lock, flags);
@@ -398,6 +398,8 @@ ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
 		tasklet_schedule(&ap->tsk);
 	sp_put(ap);
 	tty_unthrottle(tty);
+
+	return count;
 }
 
 static void
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index ba08341..b9e7156 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -668,13 +668,14 @@ static void sl_setup(struct net_device *dev)
  * in parallel
  */
 
-static void slip_receive_buf(struct tty_struct *tty, const unsigned char *cp,
+static int slip_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 							char *fp, int count)
 {
 	struct slip *sl = tty->disc_data;
+	int received = count;
 
 	if (!sl || sl->magic != SLIP_MAGIC || !netif_running(sl->dev))
-		return;
+		return count;
 
 	/* Read the characters out of the buffer */
 	while (count--) {
@@ -691,6 +692,8 @@ static void slip_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 #endif
 			slip_unesc(sl, *cp++);
 	}
+
+	return received;
 }
 
 /************************************
diff --git a/drivers/net/wan/x25_asy.c b/drivers/net/wan/x25_asy.c
index 8a10bb7..3b07835 100644
--- a/drivers/net/wan/x25_asy.c
+++ b/drivers/net/wan/x25_asy.c
@@ -516,17 +516,18 @@ static int x25_asy_close(struct net_device *dev)
  * and sent on to some IP layer for further processing.
  */
 
-static void x25_asy_receive_buf(struct tty_struct *tty,
+static int x25_asy_receive_buf(struct tty_struct *tty,
 				const unsigned char *cp, char *fp, int count)
 {
 	struct x25_asy *sl = tty->disc_data;
+	int bytes = count;
 
 	if (!sl || sl->magic != X25_ASY_MAGIC || !netif_running(sl->dev))
-		return;
+		return count;
 
 
 	/* Read the characters out of the buffer */
-	while (count--) {
+	while (bytes--) {
 		if (fp && *fp++) {
 			if (!test_and_set_bit(SLF_ERROR, &sl->flags))
 				sl->dev->stats.rx_errors++;
@@ -535,6 +536,8 @@ static void x25_asy_receive_buf(struct tty_struct *tty,
 		}
 		x25_asy_unesc(sl, *cp++);
 	}
+
+	return count;
 }
 
 /*
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index fc7bbba..f8133a4 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2246,8 +2246,8 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 	gsm->tty = NULL;
 }
 
-static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			      char *fp, int count)
+static int gsmld_receive_buf(struct tty_struct *tty,
+		const unsigned char *cp, char *fp, int count)
 {
 	struct gsm_mux *gsm = tty->disc_data;
 	const unsigned char *dp;
@@ -2280,6 +2280,8 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	}
 	/* FASYNC if needed ? */
 	/* If clogged call tty_throttle(tty); */
+
+	return count;
 }
 
 /**
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index a09ce3e..f74ef15 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -188,8 +188,8 @@ static unsigned int n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 				    poll_table *wait);
 static int n_hdlc_tty_open(struct tty_struct *tty);
 static void n_hdlc_tty_close(struct tty_struct *tty);
-static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *cp,
-			       char *fp, int count);
+static int n_hdlc_tty_receive(struct tty_struct *tty,
+		const __u8 *cp, char *fp, int count);
 static void n_hdlc_tty_wakeup(struct tty_struct *tty);
 
 #define bset(p,b)	((p)[(b) >> 5] |= (1 << ((b) & 0x1f)))
@@ -509,8 +509,8 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
  * Called by tty low level driver when receive data is available. Data is
  * interpreted as one HDLC frame.
  */
-static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
-			       char *flags, int count)
+static int n_hdlc_tty_receive(struct tty_struct *tty,
+		const __u8 *data, char *flags, int count)
 {
 	register struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 	register struct n_hdlc_buf *buf;
@@ -521,20 +521,20 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 		
 	/* This can happen if stuff comes in on the backup tty */
 	if (!n_hdlc || tty != n_hdlc->tty)
-		return;
+		return count;
 		
 	/* verify line is using HDLC discipline */
 	if (n_hdlc->magic != HDLC_MAGIC) {
 		printk("%s(%d) line not using HDLC discipline\n",
 			__FILE__,__LINE__);
-		return;
+		return count;
 	}
 	
 	if ( count>maxframe ) {
 		if (debuglevel >= DEBUG_LEVEL_INFO)	
 			printk("%s(%d) rx count>maxframesize, data discarded\n",
 			       __FILE__,__LINE__);
-		return;
+		return count;
 	}
 
 	/* get a free HDLC buffer */	
@@ -550,7 +550,7 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 		if (debuglevel >= DEBUG_LEVEL_INFO)	
 			printk("%s(%d) no more rx buffers, data discarded\n",
 			       __FILE__,__LINE__);
-		return;
+		return count;
 	}
 		
 	/* copy received data to HDLC buffer */
@@ -565,6 +565,8 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 	if (n_hdlc->tty->fasync != NULL)
 		kill_fasync (&n_hdlc->tty->fasync, SIGIO, POLL_IN);
 
+	return count;
+
 }	/* end of n_hdlc_tty_receive() */
 
 /**
diff --git a/drivers/tty/n_r3964.c b/drivers/tty/n_r3964.c
index 5c6c314..43384b3 100644
--- a/drivers/tty/n_r3964.c
+++ b/drivers/tty/n_r3964.c
@@ -139,8 +139,8 @@ static int r3964_ioctl(struct tty_struct *tty, struct file *file,
 static void r3964_set_termios(struct tty_struct *tty, struct ktermios *old);
 static unsigned int r3964_poll(struct tty_struct *tty, struct file *file,
 		struct poll_table_struct *wait);
-static void r3964_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-		char *fp, int count);
+static int r3964_receive_buf(struct tty_struct *tty,
+		const unsigned char *cp, char *fp, int count);
 
 static struct tty_ldisc_ops tty_ldisc_N_R3964 = {
 	.owner = THIS_MODULE,
@@ -1239,8 +1239,8 @@ static unsigned int r3964_poll(struct tty_struct *tty, struct file *file,
 	return result;
 }
 
-static void r3964_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			char *fp, int count)
+static int r3964_receive_buf(struct tty_struct *tty,
+		const unsigned char *cp, char *fp, int count)
 {
 	struct r3964_info *pInfo = tty->disc_data;
 	const unsigned char *p;
@@ -1257,6 +1257,8 @@ static void r3964_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		}
 
 	}
+
+	return count;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/n_tracerouter.c b/drivers/tty/n_tracerouter.c
index 1f063d3..22130db 100644
--- a/drivers/tty/n_tracerouter.c
+++ b/drivers/tty/n_tracerouter.c
@@ -168,13 +168,15 @@ static ssize_t n_tracerouter_write(struct tty_struct *tty, struct file *file,
  * This function takes the input buffer, cp, and passes it to
  * an external API function for processing.
  */
-static void n_tracerouter_receivebuf(struct tty_struct *tty,
+static int n_tracerouter_receivebuf(struct tty_struct *tty,
 					const unsigned char *cp,
 					char *fp, int count)
 {
 	mutex_lock(&routelock);
 	n_tracesink_datadrain((u8 *) cp, count);
 	mutex_unlock(&routelock);
+
+	return count;
 }
 
 /*
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index d2256d0..c47cd7e 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1359,7 +1359,7 @@ static void n_tty_write_wakeup(struct tty_struct *tty)
  *	calls one at a time and in order (or using flush_to_ldisc)
  */
 
-static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
+static int n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			      char *fp, int count)
 {
 	const unsigned char *p;
@@ -1369,7 +1369,7 @@ static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	unsigned long cpuflags;
 
 	if (!tty->read_buf)
-		return;
+		return count;
 
 	if (tty->real_raw) {
 		spin_lock_irqsave(&tty->read_lock, cpuflags);
@@ -1433,6 +1433,8 @@ static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	 */
 	if (tty->receive_room < TTY_THRESHOLD_THROTTLE)
 		tty_throttle(tty);
+
+	return count;
 }
 
 int is_ignored(int sig)
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index ff7dc08..e251028 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -76,7 +76,7 @@
  * 	tty device.  It is solely the responsibility of the line
  * 	discipline to handle poll requests.
  *
- * void	(*receive_buf)(struct tty_struct *, const unsigned char *cp,
+ * int (*receive_buf)(struct tty_struct *, const unsigned char *cp,
  * 		       char *fp, int count);
  *
  * 	This function is called by the low-level tty driver to send
@@ -84,7 +84,8 @@
  * 	processing.  <cp> is a pointer to the buffer of input
  * 	character received by the device.  <fp> is a pointer to a
  * 	pointer of flag bytes which indicate whether a character was
- * 	received with a parity error, etc.
+ * 	received with a parity error, etc. Returns the amount of bytes
+ * 	received.
  * 
  * void	(*write_wakeup)(struct tty_struct *);
  *
@@ -140,8 +141,8 @@ struct tty_ldisc_ops {
 	/*
 	 * The following routines are called from below.
 	 */
-	void	(*receive_buf)(struct tty_struct *, const unsigned char *cp,
-			       char *fp, int count);
+	int (*receive_buf)(struct tty_struct *,
+			const unsigned char *cp, char *fp, int count);
 	void	(*write_wakeup)(struct tty_struct *);
 	void	(*dcd_change)(struct tty_struct *, unsigned int,
 				struct pps_event_time *);
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index a67f437..559dc29 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -332,7 +332,7 @@ static int cx81801_hangup(struct tty_struct *tty)
 }
 
 /* Line discipline .receive_buf() */
-static void cx81801_receive(struct tty_struct *tty,
+static int cx81801_receive(struct tty_struct *tty,
 				const unsigned char *cp, char *fp, int count)
 {
 	struct snd_soc_codec *codec = tty->disc_data;
@@ -340,7 +340,7 @@ static void cx81801_receive(struct tty_struct *tty,
 	int apply, ret;
 
 	if (!codec)
-		return;
+		return count;
 
 	if (!codec->hw_write) {
 		/* First modem response, complete setup procedure */
@@ -359,7 +359,7 @@ static void cx81801_receive(struct tty_struct *tty,
 				"Failed to link hook switch to DAPM pins, "
 				"will continue with hook switch unlinked.\n");
 
-		return;
+		return count;
 	}
 
 	v253_ops.receive_buf(tty, cp, fp, count);
@@ -382,6 +382,7 @@ static void cx81801_receive(struct tty_struct *tty,
 						AMS_DELTA_LATCH2_MODEM_CODEC);
 		break;
 	}
+	return count;
 }
 
 /* Line discipline .write_wakeup() */
-- 
1.7.9.1

