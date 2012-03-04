From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: [PATCH 2/9] tty : make n_tty_receive_buf return bytes received in raw mode
Date: Sun,  4 Mar 2012 18:59:13 +0100
Message-ID: <1330883960-8563-3-git-send-email-castet.matthieu@free.fr>
References: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:51537 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab2CDR76 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 4 Mar 2012 12:59:58 -0500
Received: by wibhm2 with SMTP id hm2so1507626wib.19
        for <linux-serial@vger.kernel.org>; Sun, 04 Mar 2012 09:59:57 -0800 (PST)
In-Reply-To: <1330883960-8563-1-git-send-email-castet.matthieu@free.fr>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Toby Gray <toby.gray@realvnc.com>, Stefan Bigler <stefan.bigler@keymile.com>
Cc: Matthieu CASTET <castet.matthieu@free.fr>

Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
---
 drivers/tty/n_tty.c |   60 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index c47cd7e..ed5a976 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -113,13 +113,15 @@ static void n_tty_set_room(struct tty_struct *tty)
 		schedule_work(&tty->buf.work);
 }
 
-static void put_tty_queue_nolock(unsigned char c, struct tty_struct *tty)
+static int put_tty_queue_nolock(unsigned char c, struct tty_struct *tty)
 {
 	if (tty->read_cnt < N_TTY_BUF_SIZE) {
 		tty->read_buf[tty->read_head] = c;
 		tty->read_head = (tty->read_head + 1) & (N_TTY_BUF_SIZE-1);
 		tty->read_cnt++;
+		return 1;
 	}
+	return 0;
 }
 
 /**
@@ -127,21 +129,25 @@ static void put_tty_queue_nolock(unsigned char c, struct tty_struct *tty)
  *	@c: character
  *	@tty: tty device
  *
+ *  Report the number of character written
+ *
  *	Add a character to the tty read_buf queue. This is done under the
  *	read_lock to serialize character addition and also to protect us
  *	against parallel reads or flushes
  */
 
-static void put_tty_queue(unsigned char c, struct tty_struct *tty)
+static int put_tty_queue(unsigned char c, struct tty_struct *tty)
 {
 	unsigned long flags;
+	int ret;
 	/*
 	 *	The problem of stomping on the buffers ends here.
 	 *	Why didn't anyone see this one coming? --AJK
 	*/
 	spin_lock_irqsave(&tty->read_lock, flags);
-	put_tty_queue_nolock(c, tty);
+	ret = put_tty_queue_nolock(c, tty);
 	spin_unlock_irqrestore(&tty->read_lock, flags);
+	return ret;
 }
 
 /**
@@ -1082,26 +1088,12 @@ static inline void n_tty_receive_parity_error(struct tty_struct *tty,
 	wake_up_interruptible(&tty->read_wait);
 }
 
-/**
- *	n_tty_receive_char	-	perform processing
- *	@tty: terminal device
- *	@c: character
- *
- *	Process an individual character of input received from the driver.
- *	This is serialized with respect to itself by the rules for the
- *	driver above.
- */
-
-static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
+static inline void n_tty_receive_char_no_raw(struct tty_struct *tty,
+					      unsigned char c)
 {
 	unsigned long flags;
 	int parmrk;
 
-	if (tty->raw) {
-		put_tty_queue(c, tty);
-		return;
-	}
-
 	if (I_ISTRIP(tty))
 		c &= 0x7f;
 	if (I_IUCLC(tty) && L_IEXTEN(tty))
@@ -1330,6 +1322,25 @@ handle_newline:
 	put_tty_queue(c, tty);
 }
 
+/**
+ *	n_tty_receive_char	-	perform processing
+ *	@tty: terminal device
+ *	@c: character
+ *
+ *	Process an individual character of input received from the driver.
+ *	This is serialized with respect to itself by the rules for the
+ *	driver above.
+ */
+
+static inline int n_tty_receive_char(struct tty_struct *tty, unsigned char c)
+{
+	if (tty->raw) {
+		return put_tty_queue(c, tty);
+	}
+
+	n_tty_receive_char_no_raw(tty, c);
+	return 1;
+}
 
 /**
  *	n_tty_write_wakeup	-	asynchronous I/O notifier
@@ -1367,6 +1378,7 @@ static int n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	int	i;
 	char	buf[64];
 	unsigned long cpuflags;
+	int received = 0;
 
 	if (!tty->read_buf)
 		return count;
@@ -1381,6 +1393,7 @@ static int n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		tty->read_cnt += i;
 		cp += i;
 		count -= i;
+		received += i;
 
 		i = min(N_TTY_BUF_SIZE - tty->read_cnt,
 			N_TTY_BUF_SIZE - tty->read_head);
@@ -1388,14 +1401,16 @@ static int n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		memcpy(tty->read_buf + tty->read_head, cp, i);
 		tty->read_head = (tty->read_head + i) & (N_TTY_BUF_SIZE-1);
 		tty->read_cnt += i;
+		received += i;
 		spin_unlock_irqrestore(&tty->read_lock, cpuflags);
 	} else {
 		for (i = count, p = cp, f = fp; i; i--, p++) {
+			int ret = 1;
 			if (f)
 				flags = *f++;
 			switch (flags) {
 			case TTY_NORMAL:
-				n_tty_receive_char(tty, *p);
+				ret = n_tty_receive_char(tty, *p);
 				break;
 			case TTY_BREAK:
 				n_tty_receive_break(tty);
@@ -1412,6 +1427,9 @@ static int n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 				       tty_name(tty, buf), flags);
 				break;
 			}
+			if (ret == 0)
+				break;
+			received++;
 		}
 		if (tty->ops->flush_chars)
 			tty->ops->flush_chars(tty);
@@ -1434,7 +1452,7 @@ static int n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	if (tty->receive_room < TTY_THRESHOLD_THROTTLE)
 		tty_throttle(tty);
 
-	return count;
+	return received;
 }
 
 int is_ignored(int sig)
-- 
1.7.9.1

