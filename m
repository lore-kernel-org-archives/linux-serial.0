From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 6/7] n_tty: Only perform wakeups for waiters
Date: Fri, 22 Nov 2013 10:59:24 -0500
Message-ID: <1385135965-4235-7-git-send-email-peter@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Only wakeup the _waiting_ reader, polls and/or writer(s).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 8f2356e..aae28a6 100644
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
@@ -1156,7 +1158,8 @@ static void n_tty_receive_break(struct tty_struct *tty)
 		put_tty_queue('\0', ldata);
 	}
 	put_tty_queue('\0', ldata);
-	wake_up_interruptible(&tty->read_wait);
+	if (waitqueue_active(&tty->read_wait))
+		wake_up_interruptible(&tty->read_wait);
 }
 
 /**
@@ -1214,7 +1217,8 @@ static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 		put_tty_queue('\0', ldata);
 	else
 		put_tty_queue(c, ldata);
-	wake_up_interruptible(&tty->read_wait);
+	if (waitqueue_active(&tty->read_wait))
+		wake_up_interruptible(&tty->read_wait);
 }
 
 static void
@@ -1808,8 +1812,10 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
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
