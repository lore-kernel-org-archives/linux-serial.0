From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 06/24] n_tty: Split n_tty_chars_in_buffer() for reader-only interface
Date: Sat, 15 Jun 2013 09:14:18 -0400
Message-ID: <1371302076-4688-7-git-send-email-peter@hurleysoftware.com>
References: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
 <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

N_TTY .chars_in_buffer() method requires serialized access if
the current thread is not the single-consumer, n_tty_read().

Separate the internal interface; prepare for lockless read-side.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 74dcedd..594a3c1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -277,7 +277,7 @@ static void n_tty_flush_buffer(struct tty_struct *tty)
  *	Locking: read_lock
  */
 
-static ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
+static ssize_t chars_in_buffer(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	unsigned long flags;
@@ -295,6 +295,11 @@ static ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
 	return n;
 }
 
+static ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
+{
+	return chars_in_buffer(tty);
+}
+
 /**
  *	is_utf8_continuation	-	utf8 multibyte check
  *	@c: byte to check
@@ -2032,7 +2037,7 @@ do_it_again:
 		}
 
 		/* If there is enough space in the read buffer now, let the
-		 * low-level driver know. We use n_tty_chars_in_buffer() to
+		 * low-level driver know. We use chars_in_buffer() to
 		 * check the buffer, as it now knows about canonical mode.
 		 * Otherwise, if the driver is throttled and the line is
 		 * longer than TTY_THRESHOLD_UNTHROTTLE in canonical mode,
@@ -2040,7 +2045,7 @@ do_it_again:
 		 */
 		while (1) {
 			tty_set_flow_change(tty, TTY_UNTHROTTLE_SAFE);
-			if (n_tty_chars_in_buffer(tty) > TTY_THRESHOLD_UNTHROTTLE)
+			if (chars_in_buffer(tty) > TTY_THRESHOLD_UNTHROTTLE)
 				break;
 			if (!tty->count)
 				break;
-- 
1.8.1.2
