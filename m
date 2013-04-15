From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 23/24] n_tty: Special case pty flow control
Date: Mon, 15 Apr 2013 11:19:27 -0400
Message-ID: <1366039168-8510-24-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The pty driver forces ldisc flow control on, regardless of available
receive buffer space, so the writer can be woken whenever unthrottle
is called. However, this 'forced throttle' has performance
consequences, as multiple atomic operations are necessary to
unthrottle and perform the write wakeup for every input line (in
canonical mode).

Instead, short-circuit the unthrottle if the tty is a pty and perform
the write wakeup directly.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 00debd0..5211de2 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -231,6 +231,8 @@ static void n_tty_write_wakeup(struct tty_struct *tty)
 
 static inline void n_tty_check_throttle(struct tty_struct *tty)
 {
+	if (tty->driver->type == TTY_DRIVER_TYPE_PTY)
+		return;
 	/*
 	 * Check the remaining room for the input canonicalization
 	 * mode.  We don't want to throttle the driver if we're in
@@ -250,6 +252,17 @@ static inline void n_tty_check_throttle(struct tty_struct *tty)
 
 static inline void n_tty_check_unthrottle(struct tty_struct *tty)
 {
+	if (tty->driver->type == TTY_DRIVER_TYPE_PTY) {
+		if (chars_in_buffer(tty) > TTY_THRESHOLD_UNTHROTTLE)
+			return;
+		if (!tty->count)
+			return;
+		n_tty_set_room(tty);
+		n_tty_write_wakeup(tty->link);
+		wake_up_interruptible_poll(&tty->link->write_wait, POLLOUT);
+		return;
+	}
+
 	/* If there is enough space in the read buffer now, let the
 	 * low-level driver know. We use chars_in_buffer() to
 	 * check the buffer, as it now knows about canonical mode.
-- 
1.8.1.2
