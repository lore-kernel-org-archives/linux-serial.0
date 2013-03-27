From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 13/18] n_tty: Replace canon_data with index comparison
Date: Wed, 27 Mar 2013 07:44:03 -0400
Message-ID: <1364384648-6636-14-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1364384648-6636-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364384648-6636-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Min Zhang <mzhang@mvista.com>, Ilya Zykov <linux@izyk.ru>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

canon_data represented the # of lines which had been copied
to the receive buffer but not yet copied to the user buffer.
The value was tested to determine if input was available in
canonical mode (and also to force input overrun if the
receive buffer was full but a newline had not been received).

However, the actual count was irrelevent; only whether it was
non-zero (meaning 'is there any input to transfer?'). This
shared count is unnecessary and unsafe with a lockless algorithm.
The same check is made by comparing canon_head with read_tail instead.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 985e0a3..2a3ab63 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -107,7 +107,6 @@ struct n_tty_data {
 	unsigned int echo_pos;
 	unsigned int echo_cnt;
 
-	int canon_data;
 	size_t canon_head;
 	unsigned int canon_column;
 
@@ -161,7 +160,7 @@ static ssize_t receive_room(struct tty_struct *tty)
 	 * characters will be beeped.
 	 */
 	if (left <= 0)
-		left = ldata->icanon && !ldata->canon_data;
+		left = ldata->icanon && ldata->canon_head == ldata->read_tail;
 
 	return left;
 }
@@ -259,14 +258,14 @@ static void reset_buffer_flags(struct n_tty_data *ldata)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&ldata->read_lock, flags);
-	ldata->read_head = ldata->read_tail = 0;
+	ldata->read_head = ldata->canon_head = ldata->read_tail = 0;
 	raw_spin_unlock_irqrestore(&ldata->read_lock, flags);
 
 	mutex_lock(&ldata->echo_lock);
 	ldata->echo_pos = ldata->echo_cnt = ldata->echo_overrun = 0;
 	mutex_unlock(&ldata->echo_lock);
 
-	ldata->canon_head = ldata->canon_data = ldata->erasing = 0;
+	ldata->erasing = 0;
 	bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
 }
 
@@ -1383,7 +1382,6 @@ handle_newline:
 			set_bit(ldata->read_head & (N_TTY_BUF_SIZE - 1), ldata->read_flags);
 			put_tty_queue_nolock(c, ldata);
 			ldata->canon_head = ldata->read_head;
-			ldata->canon_data++;
 			raw_spin_unlock_irqrestore(&ldata->read_lock, flags);
 			kill_fasync(&tty->fasync, SIGIO, POLL_IN);
 			if (waitqueue_active(&tty->read_wait))
@@ -1561,7 +1559,6 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	if (canon_change) {
 		bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
 		ldata->canon_head = ldata->read_tail;
-		ldata->canon_data = 0;
 		ldata->erasing = 0;
 	}
 
@@ -1709,7 +1706,7 @@ static inline int input_available_p(struct tty_struct *tty, int amt)
 
 	tty_flush_to_ldisc(tty);
 	if (ldata->icanon && !L_EXTPROC(tty)) {
-		if (ldata->canon_data)
+		if (ldata->canon_head != ldata->read_tail)
 			return 1;
 	} else if (read_cnt(ldata) >= (amt ? amt : 1))
 		return 1;
@@ -1846,15 +1843,8 @@ static int canon_copy_from_read_buf(struct tty_struct *tty,
 
 	raw_spin_lock_irqsave(&ldata->read_lock, flags);
 	ldata->read_tail += c;
-	if (found) {
+	if (found)
 		__clear_bit(eol, ldata->read_flags);
-		/* this test should be redundant:
-		 * we shouldn't be reading data if
-		 * canon_data is 0
-		 */
-		if (--ldata->canon_data < 0)
-			ldata->canon_data = 0;
-	}
 	raw_spin_unlock_irqrestore(&ldata->read_lock, flags);
 
 	if (found)
@@ -2253,7 +2243,7 @@ static unsigned long inq_canon(struct n_tty_data *ldata)
 {
 	size_t nr, head, tail;
 
-	if (!ldata->canon_data)
+	if (ldata->canon_head == ldata->read_tail)
 		return 0;
 	head = ldata->canon_head;
 	tail = ldata->read_tail;
-- 
1.8.1.2
