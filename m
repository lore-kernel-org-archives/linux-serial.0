From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 tty-next 6/8] n_tty: Only perform wakeups for waiters
Date: Mon,  2 Dec 2013 14:24:46 -0500
Message-ID: <1386012288-5079-7-git-send-email-peter@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
 <1386012288-5079-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:44392 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab3LBTZx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Dec 2013 14:25:53 -0500
In-Reply-To: <1386012288-5079-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>

Only wakeup the _waiting_ reader, polls and/or writer(s).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index aae171e..5254082 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -275,7 +275,8 @@ static void n_tty_check_unthrottle(struct tty_struct *tty)
 			return;
 		n_tty_set_room(tty);
 		n_tty_write_wakeup(tty->link);
-		wake_up_interruptible_poll(&tty->link->write_wait, POLLOUT);
+		if (waitqueue_active(&tty->link->write_wait))
+			wake_up_interruptible_poll(&tty->link->write_wait, POLLOUT);
 		return;
 	}
 
@@ -350,7 +351,8 @@ static void n_tty_packet_mode_flush(struct tty_struct *tty)
 	spin_lock_irqsave(&tty->ctrl_lock, flags);
 	if (tty->link->packet) {
 		tty->ctrl_status |= TIOCPKT_FLUSHREAD;
-		wake_up_interruptible(&tty->link->read_wait);
+		if (waitqueue_active(&tty->link->read_wait))
+			wake_up_interruptible(&tty->link->read_wait);
 	}
 	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 }
@@ -1158,7 +1160,8 @@ static void n_tty_receive_break(struct tty_struct *tty)
 		put_tty_queue('\0', ldata);
 	}
 	put_tty_queue('\0', ldata);
-	wake_up_interruptible(&tty->read_wait);
+	if (waitqueue_active(&tty->read_wait))
+		wake_up_interruptible(&tty->read_wait);
 }
 
 /**
@@ -1216,7 +1219,8 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 		put_tty_queue('\0', ldata);
 	else
 		put_tty_queue(c, ldata);
-	wake_up_interruptible(&tty->read_wait);
+	if (waitqueue_active(&tty->read_wait))
+		wake_up_interruptible(&tty->read_wait);
 }
 
 static void
@@ -1811,8 +1815,10 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 		start_tty(tty);
 
 	/* The termios change make the tty ready for I/O */
-	wake_up_interruptible(&tty->write_wait);
-	wake_up_interruptible(&tty->read_wait);
+	if (waitqueue_active(&tty->write_wait))
+		wake_up_interruptible(&tty->write_wait);
+	if (waitqueue_active(&tty->read_wait))
+		wake_up_interruptible(&tty->read_wait);
 }
 
 /**
-- 
1.8.1.2

