From: Gianluca Anzolin <gianluca@sottospazio.it>
Subject: [RFC] PATCH: rfcomm tty refcount fixes
Date: Sat, 6 Jul 2013 10:43:43 +0200
Message-ID: <20130706084343.GA10500@debian.seek.priv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:47426 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab3GFInz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 6 Jul 2013 04:43:55 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-bluetooth@vger.kernel.org
Cc: linux-serial@vger.kernel.org, holler@ahsoftware.de, peter@hurleysoftware.com


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm getting panics and OOPS with the vanilla kernel 3.10 using rfcomm with a
bluetooth module connected to a microcontroller: this occurs when I poweroff
the microcontroller without closing first the rfcomm device.

Searching the web I found that I'm not alone with this issue:

http://marc.info/?l=linux-bluetooth&m=136868678418771&w=2

In the thread the issue seems to be a refcounting problem.

Indeed looking at the source there are places where dev->port.tty is accessed
directly without taking references of the tty_struct.

So I inspected every dev->port.tty access and changed the code to use
tty_port_tty_get which gets the references properly.

In other places I used directly the tty_port_* helpers already in place.

I the process I changed also the tty_port_hangup helper because it seems to me
that it could leak references in some cases (I sent another email for that).

I attach the patch against net/bluetooth/rfcomm/tty.c and
drivers/tty/tty_port.c

With this patch I cannot reproduce the oopses I was getting before: I was able
to trigger the panics very easily and now I cannot trigger them anymore.

I cannot tell however if the problem is really fixed so I'm here request for
comments from people who know this code better than me.

To them I'd like also to have a look at rfcomm_tty_close: in some situations
tty_port_put could be called two times: is that right?

Thank you,

Gianluca

--qDbXVdCdHGoSgWSk
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="rfcomm.patch"

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 121aeb9..2198f7d 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -256,8 +256,9 @@ void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 {
 	struct tty_struct *tty = tty_port_tty_get(port);
 
-	if (tty && (!check_clocal || !C_CLOCAL(tty))) {
-		tty_hangup(tty);
+	if (tty) {
+		if (!check_clocal || !C_CLOCAL(tty))
+			tty_hangup(tty);
 		tty_kref_put(tty);
 	}
 }
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index b6e44ad..f657aa2 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -333,10 +333,11 @@ static inline unsigned int rfcomm_room(struct rfcomm_dlc *dlc)
 static void rfcomm_wfree(struct sk_buff *skb)
 {
 	struct rfcomm_dev *dev = (void *) skb->sk;
-	struct tty_struct *tty = dev->port.tty;
+
 	atomic_sub(skb->truesize, &dev->wmem_alloc);
-	if (test_bit(RFCOMM_TTY_ATTACHED, &dev->flags) && tty)
-		tty_wakeup(tty);
+	if (test_bit(RFCOMM_TTY_ATTACHED, &dev->flags))
+		tty_port_tty_wakeup(&dev->port);
+
 	tty_port_put(&dev->port);
 }
 
@@ -410,6 +411,7 @@ static int rfcomm_release_dev(void __user *arg)
 {
 	struct rfcomm_dev_req req;
 	struct rfcomm_dev *dev;
+	struct tty_struct *tty;
 
 	if (copy_from_user(&req, arg, sizeof(req)))
 		return -EFAULT;
@@ -429,11 +431,15 @@ static int rfcomm_release_dev(void __user *arg)
 		rfcomm_dlc_close(dev->dlc, 0);
 
 	/* Shut down TTY synchronously before freeing rfcomm_dev */
-	if (dev->port.tty)
-		tty_vhangup(dev->port.tty);
+	tty = tty_port_tty_get(&dev->port);
+	if (tty) {
+		tty_vhangup(tty);
+		tty_kref_put(tty);
+	}
 
 	if (!test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
 		rfcomm_dev_del(dev);
+
 	tty_port_put(&dev->port);
 	return 0;
 }
@@ -563,6 +569,7 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
 static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 {
 	struct rfcomm_dev *dev = dlc->owner;
+	struct tty_struct *tty;
 	if (!dev)
 		return;
 
@@ -572,7 +579,8 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 	wake_up_interruptible(&dev->wait);
 
 	if (dlc->state == BT_CLOSED) {
-		if (!dev->port.tty) {
+		tty = tty_port_tty_get(&dev->port);
+		if (!tty) {
 			if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
 				/* Drop DLC lock here to avoid deadlock
 				 * 1. rfcomm_dev_get will take rfcomm_dev_lock
@@ -591,8 +599,10 @@ static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
 				tty_port_put(&dev->port);
 				rfcomm_dlc_lock(dlc);
 			}
-		} else
-			tty_hangup(dev->port.tty);
+		} else {
+			tty_hangup(tty);
+			tty_kref_put(tty);
+		}
 	}
 }
 
@@ -604,10 +614,8 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
 
 	BT_DBG("dlc %p dev %p v24_sig 0x%02x", dlc, dev, v24_sig);
 
-	if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV)) {
-		if (dev->port.tty && !C_CLOCAL(dev->port.tty))
-			tty_hangup(dev->port.tty);
-	}
+	if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV))
+		tty_port_tty_hangup(&dev->port, true);
 
 	dev->modem_status =
 		((v24_sig & RFCOMM_V24_RTC) ? (TIOCM_DSR | TIOCM_DTR) : 0) |

--qDbXVdCdHGoSgWSk--
