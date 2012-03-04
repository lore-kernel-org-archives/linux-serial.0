From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: [PATCH 9/9] tty : make receive_room internal to N_TTY line discipline
Date: Sun,  4 Mar 2012 18:59:20 +0100
Message-ID: <1330883960-8563-10-git-send-email-castet.matthieu@free.fr>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37396 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab2CDSAE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 13:00:04 -0500
Received: by wibhm2 with SMTP id hm2so1507676wib.19
        for <linux-serial@vger.kernel.org>; Sun, 04 Mar 2012 10:00:03 -0800 (PST)
In-Reply-To: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>

NOTE : capi need fixing

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
---
 drivers/bluetooth/hci_ldisc.c  |    1 -
 drivers/input/serio/serport.c  |    1 -
 drivers/isdn/capi/capi.c       |    1 +
 drivers/misc/ti-st/st_core.c   |    3 ---
 drivers/net/caif/caif_serial.c |    1 -
 drivers/net/can/slcan.c        |    1 -
 drivers/net/hamradio/6pack.c   |    1 -
 drivers/net/hamradio/mkiss.c   |    1 -
 drivers/net/irda/irtty-sir.c   |    1 -
 drivers/net/ppp/ppp_async.c    |    1 -
 drivers/net/ppp/ppp_synctty.c  |    1 -
 drivers/net/slip/slip.c        |    1 -
 drivers/net/wan/x25_asy.c      |    1 -
 drivers/tty/n_gsm.c            |    1 -
 drivers/tty/n_hdlc.c           |    1 -
 drivers/tty/n_r3964.c          |    1 -
 drivers/tty/n_tracerouter.c    |    7 -------
 drivers/tty/n_tty.c            |    9 ++++++---
 include/linux/tty.h            |    2 +-
 19 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 588656e..24872dc 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -273,7 +273,6 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 
 	tty->disc_data = hu;
 	hu->tty = tty;
-	tty->receive_room = 65536;
 
 	spin_lock_init(&hu->rx_lock);
 
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 657043a..1bf1e71 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -97,7 +97,6 @@ static int serport_ldisc_open(struct tty_struct *tty)
 	init_waitqueue_head(&serport->wait);
 
 	tty->disc_data = serport;
-	tty->receive_room = 256;
 	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 
 	return 0;
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index e44933d..70f892f 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -437,6 +437,7 @@ static int handle_recv_skb(struct capiminor *mp, struct sk_buff *skb)
 		goto deref_ldisc;
 	}
 
+	/* FIXME this is internal to N_TTY */
 	if (tty->receive_room < datalen) {
 		pr_debug("capi: no room in tty\n");
 		goto deref_ldisc;
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index bc3f61c..c4259fb 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -705,9 +705,6 @@ static int st_tty_open(struct tty_struct *tty)
 	/* don't do an wakeup for now */
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 
-	/* mem already allocated
-	 */
-	tty->receive_room = 65536;
 	/* Flush any pending characters in the driver and discipline. */
 	tty_ldisc_flush(tty);
 	tty_driver_flush_buffer(tty);
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index d801d6e..5bb1411 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -331,7 +331,6 @@ static int ldisc_open(struct tty_struct *tty)
 	ser->tty = tty_kref_get(tty);
 	ser->dev = dev;
 	debugfs_init(ser, tty);
-	tty->receive_room = N_TTY_BUF_SIZE;
 	tty->disc_data = ser;
 	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	rtnl_lock();
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 3229e30..f3ef7ba 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -546,7 +546,6 @@ static int slcan_open(struct tty_struct *tty)
 
 	/* Done.  We have linked the TTY line to a channel. */
 	rtnl_unlock();
-	tty->receive_room = 65536;	/* We don't flow control */
 
 	/* TTY layer expects 0 on success */
 	return 0;
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 39ad8fe..ae3f24d 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -661,7 +661,6 @@ static int sixpack_open(struct tty_struct *tty)
 
 	/* Done.  We have linked the TTY line to a channel. */
 	tty->disc_data = sp;
-	tty->receive_room = 65536;
 
 	/* Now we're ready to register. */
 	if (register_netdev(dev))
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index 75173ca..85f3682 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -751,7 +751,6 @@ static int mkiss_open(struct tty_struct *tty)
 
 	ax->tty = tty;
 	tty->disc_data = ax;
-	tty->receive_room = 65535;
 
 	tty_driver_flush_buffer(tty);
 
diff --git a/drivers/net/irda/irtty-sir.c b/drivers/net/irda/irtty-sir.c
index 3166e91..4a5a3af 100644
--- a/drivers/net/irda/irtty-sir.c
+++ b/drivers/net/irda/irtty-sir.c
@@ -473,7 +473,6 @@ static int irtty_open(struct tty_struct *tty)
 
 	dev->priv = priv;
 	tty->disc_data = priv;
-	tty->receive_room = 65536;
 
 	mutex_unlock(&irtty_mutex);
 
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index aefd499..213d9a2 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -198,7 +198,6 @@ ppp_asynctty_open(struct tty_struct *tty)
 		goto out_free;
 
 	tty->disc_data = ap;
-	tty->receive_room = 65536;
 	return 0;
 
  out_free:
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 248ece3..c2dff73 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -245,7 +245,6 @@ ppp_sync_open(struct tty_struct *tty)
 		goto out_free;
 
 	tty->disc_data = ap;
-	tty->receive_room = 65536;
 	return 0;
 
  out_free:
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index b9e7156..466c0e8 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -837,7 +837,6 @@ static int slip_open(struct tty_struct *tty)
 
 	/* Done.  We have linked the TTY line to a channel. */
 	rtnl_unlock();
-	tty->receive_room = 65536;	/* We don't flow control */
 
 	/* TTY layer expects 0 on success */
 	return 0;
diff --git a/drivers/net/wan/x25_asy.c b/drivers/net/wan/x25_asy.c
index 3b07835..7adb510 100644
--- a/drivers/net/wan/x25_asy.c
+++ b/drivers/net/wan/x25_asy.c
@@ -567,7 +567,6 @@ static int x25_asy_open_tty(struct tty_struct *tty)
 
 	sl->tty = tty;
 	tty->disc_data = sl;
-	tty->receive_room = 65536;
 	tty_driver_flush_buffer(tty);
 	tty_ldisc_flush(tty);
 
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index f8133a4..f605163 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2356,7 +2356,6 @@ static int gsmld_open(struct tty_struct *tty)
 		return -ENOMEM;
 
 	tty->disc_data = gsm;
-	tty->receive_room = 65536;
 
 	/* Attach the initial passive connection */
 	gsm->encoding = 1;
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index f74ef15..747f38a 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -358,7 +358,6 @@ static int n_hdlc_tty_open (struct tty_struct *tty)
 		
 	tty->disc_data = n_hdlc;
 	n_hdlc->tty    = tty;
-	tty->receive_room = 65536;
 	
 #if defined(TTY_NO_WRITE_SPLIT)
 	/* change tty_io write() to not split large writes into 8K chunks */
diff --git a/drivers/tty/n_r3964.c b/drivers/tty/n_r3964.c
index 43384b3..2519200 100644
--- a/drivers/tty/n_r3964.c
+++ b/drivers/tty/n_r3964.c
@@ -993,7 +993,6 @@ static int r3964_open(struct tty_struct *tty)
 	pInfo->nRetry = 0;
 
 	tty->disc_data = pInfo;
-	tty->receive_room = 65536;
 
 	setup_timer(&pInfo->tmr, on_timeout, (unsigned long)pInfo);
 
diff --git a/drivers/tty/n_tracerouter.c b/drivers/tty/n_tracerouter.c
index 22130db..5882264 100644
--- a/drivers/tty/n_tracerouter.c
+++ b/drivers/tty/n_tracerouter.c
@@ -37,12 +37,6 @@
 #include <asm-generic/bug.h>
 #include "n_tracesink.h"
 
-/*
- * Other ldisc drivers use 65536 which basically means,
- * 'I can always accept 64k' and flow control is off.
- * This number is deemed appropriate for this driver.
- */
-#define RECEIVE_ROOM	65536
 #define DRIVERNAME	"n_tracerouter"
 
 /*
@@ -81,7 +75,6 @@ static int n_tracerouter_open(struct tty_struct *tty)
 		} else {
 			tr_data->opencalled = 1;
 			tty->disc_data      = tr_data;
-			tty->receive_room   = RECEIVE_ROOM;
 			tty_driver_flush_buffer(tty);
 			retval = 0;
 		}
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 5ef5a22..cda8fd9 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -91,7 +91,7 @@ static inline int tty_put_user(struct tty_struct *tty, unsigned char x,
  *	"instant".
  */
 
-static void n_tty_set_room(struct tty_struct *tty)
+static int n_tty_set_room(struct tty_struct *tty)
 {
 	/* tty->read_cnt is not read locked ? */
 	int	left = N_TTY_BUF_SIZE - tty->read_cnt - 1;
@@ -111,6 +111,8 @@ static void n_tty_set_room(struct tty_struct *tty)
 	/* Did this open up the receive buffer? We may need to flip */
 	if (left && !old_left)
 		schedule_work(&tty->buf.work);
+
+	return left;
 }
 
 static int put_tty_queue_nolock(unsigned char c, struct tty_struct *tty)
@@ -1380,6 +1382,7 @@ static int n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	char	buf[64];
 	unsigned long cpuflags;
 	int received = 0;
+	int left;
 
 	if (!tty->read_buf)
 		return count;
@@ -1436,7 +1439,7 @@ static int n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			tty->ops->flush_chars(tty);
 	}
 
-	n_tty_set_room(tty);
+	left = n_tty_set_room(tty);
 
 	if ((!tty->icanon && (tty->read_cnt >= tty->minimum_to_wake)) ||
 		L_EXTPROC(tty)) {
@@ -1450,7 +1453,7 @@ static int n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	 * mode.  We don't want to throttle the driver if we're in
 	 * canonical mode and don't have a newline yet!
 	 */
-	if (tty->receive_room < TTY_THRESHOLD_THROTTLE)
+	if (left < TTY_THRESHOLD_THROTTLE)
 		tty_throttle(tty);
 
 	return received;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 5dbb3cb..42accf6 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -282,7 +282,6 @@ struct tty_struct {
 	unsigned char stopped:1, hw_stopped:1, flow_stopped:1, packet:1;
 	unsigned char low_latency:1, warned:1;
 	unsigned char ctrl_status;	/* ctrl_lock */
-	unsigned int receive_room;	/* Bytes free for queue */
 
 	struct tty_struct *link;
 	struct fasync_struct *fasync;
@@ -310,6 +309,7 @@ struct tty_struct {
 	unsigned long overrun_time;
 	int num_overrun;
 	unsigned long process_char_map[256/(8*sizeof(unsigned long))];
+	unsigned int receive_room;	/* Bytes free for queue */
 	char *read_buf;
 	int read_head;
 	int read_tail;
-- 
1.7.9.1

