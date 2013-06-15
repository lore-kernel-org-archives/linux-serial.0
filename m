From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 21/24] n_tty: Factor throttle/unthrottle into helper functions
Date: Sat, 15 Jun 2013 09:14:33 -0400
Message-ID: <1371302076-4688-22-git-send-email-peter@hurleysoftware.com>
References: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
 <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Prepare for special handling of pty throttle/unthrottle; factor
flow control into helper functions.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 81 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 9ec0c68..9e13c80 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -214,6 +214,50 @@ static ssize_t chars_in_buffer(struct tty_struct *tty)
 	return n;
 }
 
+static inline void n_tty_check_throttle(struct tty_struct *tty)
+{
+	/*
+	 * Check the remaining room for the input canonicalization
+	 * mode.  We don't want to throttle the driver if we're in
+	 * canonical mode and don't have a newline yet!
+	 */
+	while (1) {
+		int throttled;
+		tty_set_flow_change(tty, TTY_THROTTLE_SAFE);
+		if (receive_room(tty) >= TTY_THRESHOLD_THROTTLE)
+			break;
+		throttled = tty_throttle_safe(tty);
+		if (!throttled)
+			break;
+	}
+	__tty_set_flow_change(tty, 0);
+}
+
+static inline void n_tty_check_unthrottle(struct tty_struct *tty)
+{
+	/* If there is enough space in the read buffer now, let the
+	 * low-level driver know. We use chars_in_buffer() to
+	 * check the buffer, as it now knows about canonical mode.
+	 * Otherwise, if the driver is throttled and the line is
+	 * longer than TTY_THRESHOLD_UNTHROTTLE in canonical mode,
+	 * we won't get any more characters.
+	 */
+
+	while (1) {
+		int unthrottled;
+		tty_set_flow_change(tty, TTY_UNTHROTTLE_SAFE);
+		if (chars_in_buffer(tty) > TTY_THRESHOLD_UNTHROTTLE)
+			break;
+		if (!tty->count)
+			break;
+		n_tty_set_room(tty);
+		unthrottled = tty_unthrottle_safe(tty);
+		if (!unthrottled)
+			break;
+	}
+	__tty_set_flow_change(tty, 0);
+}
+
 /**
  *	put_tty_queue		-	add character to tty
  *	@c: character
@@ -1508,21 +1552,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			wake_up_interruptible(&tty->read_wait);
 	}
 
-	/*
-	 * Check the remaining room for the input canonicalization
-	 * mode.  We don't want to throttle the driver if we're in
-	 * canonical mode and don't have a newline yet!
-	 */
-	while (1) {
-		int throttled;
-		tty_set_flow_change(tty, TTY_THROTTLE_SAFE);
-		if (receive_room(tty) >= TTY_THRESHOLD_THROTTLE)
-			break;
-		throttled = tty_throttle_safe(tty);
-		if (!throttled)
-			break;
-	}
-	__tty_set_flow_change(tty, 0);
+	n_tty_check_throttle(tty);
 }
 
 static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
@@ -2069,26 +2099,7 @@ do_it_again:
 			}
 		}
 
-		/* If there is enough space in the read buffer now, let the
-		 * low-level driver know. We use chars_in_buffer() to
-		 * check the buffer, as it now knows about canonical mode.
-		 * Otherwise, if the driver is throttled and the line is
-		 * longer than TTY_THRESHOLD_UNTHROTTLE in canonical mode,
-		 * we won't get any more characters.
-		 */
-		while (1) {
-			int unthrottled;
-			tty_set_flow_change(tty, TTY_UNTHROTTLE_SAFE);
-			if (chars_in_buffer(tty) > TTY_THRESHOLD_UNTHROTTLE)
-				break;
-			if (!tty->count)
-				break;
-			n_tty_set_room(tty);
-			unthrottled = tty_unthrottle_safe(tty);
-			if (!unthrottled)
-				break;
-		}
-		__tty_set_flow_change(tty, 0);
+		n_tty_check_unthrottle(tty);
 
 		if (b - buf >= minimum)
 			break;
-- 
1.8.1.2
