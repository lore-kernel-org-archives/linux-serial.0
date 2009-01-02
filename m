From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 55/75] tty: refcount the epca driver
Date: Fri, 02 Jan 2009 13:48:04 +0000
Message-ID: <20090102134804.13472.83358.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37642 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757230AbZABNrv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:47:51 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/epca.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)


diff --git a/drivers/char/epca.c b/drivers/char/epca.c
index e07d792..7a69705 100644
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -175,7 +175,7 @@ static unsigned termios2digi_h(struct channel *ch, unsigned);
 static unsigned termios2digi_i(struct channel *ch, unsigned);
 static unsigned termios2digi_c(struct channel *ch, unsigned);
 static void epcaparam(struct tty_struct *, struct channel *);
-static void receive_data(struct channel *);
+static void receive_data(struct channel *, struct tty_struct *tty);
 static int pc_ioctl(struct tty_struct *, struct file *,
 			unsigned int, unsigned long);
 static int info_ioctl(struct tty_struct *, struct file *,
@@ -473,7 +473,7 @@ static void pc_close(struct tty_struct *tty, struct file *filp)
 	spin_lock_irqsave(&port->lock, flags);
 	tty->closing = 0;
 	ch->event = 0;
-	port->tty = NULL;
+	tty_port_tty_set(port, NULL);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	if (port->blocked_open) {
@@ -1029,8 +1029,11 @@ static void __exit epca_module_exit(void)
 		}
 		ch = card_ptr[crd];
 		for (count = 0; count < bd->numports; count++, ch++) {
-			if (ch && ch->port.tty)
-				tty_hangup(ch->port.tty);
+			struct tty_struct *tty = tty_port_tty_get(&ch->port);
+			if (tty) {
+				tty_hangup(tty);
+				tty_kref_put(tty);
+			}
 		}
 	}
 	pci_unregister_driver(&epca_driver);
@@ -1441,7 +1444,7 @@ static void post_fep_init(unsigned int crd)
 		ch->boardnum   = crd;
 		ch->channelnum = i;
 		ch->magic      = EPCA_MAGIC;
-		ch->port.tty        = NULL;
+		tty_port_tty_set(&ch->port, NULL);
 
 		if (shrinkmem) {
 			fepcmd(ch, SETBUFFER, 32, 0, 0, 0);
@@ -1635,8 +1638,9 @@ static void doevent(int crd)
 		if (bc == NULL)
 			goto next;
 
+		tty = tty_port_tty_get(&ch->port);
 		if (event & DATA_IND)  { /* Begin DATA_IND */
-			receive_data(ch);
+			receive_data(ch, tty);
 			assertgwinon(ch);
 		} /* End DATA_IND */
 		/* else *//* Fix for DCD transition missed bug */
@@ -1651,7 +1655,6 @@ static void doevent(int crd)
 					pc_sched_event(ch, EPCA_EVENT_HANGUP);
 			}
 		}
-		tty = ch->port.tty;
 		if (tty) {
 			if (event & BREAK_IND) {
 				/* A break has been indicated */
@@ -1671,6 +1674,7 @@ static void doevent(int crd)
 					tty_wakeup(tty);
 				}
 			}
+			tty_kref_put(tty);
 		}
 next:
 		globalwinon(ch);
@@ -1965,11 +1969,10 @@ static void epcaparam(struct tty_struct *tty, struct channel *ch)
 }
 
 /* Caller holds lock */
-static void receive_data(struct channel *ch)
+static void receive_data(struct channel *ch, struct tty_struct *tty)
 {
 	unchar *rptr;
 	struct ktermios *ts = NULL;
-	struct tty_struct *tty;
 	struct board_chan __iomem *bc;
 	int dataToRead, wrapgap, bytesAvailable;
 	unsigned int tail, head;
@@ -1982,7 +1985,6 @@ static void receive_data(struct channel *ch)
 	globalwinon(ch);
 	if (ch->statusflags & RXSTOPPED)
 		return;
-	tty = ch->port.tty;
 	if (tty)
 		ts = tty->termios;
 	bc = ch->brdchan;
@@ -2042,7 +2044,7 @@ static void receive_data(struct channel *ch)
 	globalwinon(ch);
 	writew(tail, &bc->rout);
 	/* Must be called with global data */
-	tty_schedule_flip(ch->port.tty);
+	tty_schedule_flip(tty);
 }
 
 static int info_ioctl(struct tty_struct *tty, struct file *file,
@@ -2365,7 +2367,7 @@ static void do_softint(struct work_struct *work)
 	struct channel *ch = container_of(work, struct channel, tqueue);
 	/* Called in response to a modem change event */
 	if (ch && ch->magic == EPCA_MAGIC) {
-		struct tty_struct *tty = ch->port.tty;
+		struct tty_struct *tty = tty_port_tty_get(&ch->port);;
 
 		if (tty && tty->driver_data) {
 			if (test_and_clear_bit(EPCA_EVENT_HANGUP, &ch->event)) {
@@ -2374,6 +2376,7 @@ static void do_softint(struct work_struct *work)
 				ch->port.flags &= ~ASYNC_NORMAL_ACTIVE;
 			}
 		}
+		tty_kref_put(tty);
 	}
 }
 

