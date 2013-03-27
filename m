From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 10/18] n_tty: Remove read_cnt
Date: Wed, 27 Mar 2013 07:44:00 -0400
Message-ID: <1364384648-6636-11-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1364384648-6636-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364384648-6636-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Min Zhang <mzhang@mvista.com>, Ilya Zykov <linux@izyk.ru>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Storing the read_cnt creates an unnecessary shared variable
between the single-producer (n_tty_receive_buf()) and the
single-consumer (n_tty_read()).

Compute read_cnt from head & tail instead of storing.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 2b38bb2..f777ec6 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -101,7 +101,6 @@ struct n_tty_data {
 	char *read_buf;
 	size_t read_head;
 	size_t read_tail;
-	int read_cnt;
 	int minimum_to_wake;
 
 	unsigned char *echo_buf;
@@ -120,7 +119,7 @@ struct n_tty_data {
 
 static inline size_t read_cnt(struct n_tty_data *ldata)
 {
-	return ldata->read_cnt;
+	return ldata->read_head - ldata->read_tail;
 }
 
 static inline unsigned char read_buf(struct n_tty_data *ldata, size_t i)
@@ -220,7 +219,6 @@ static void put_tty_queue_nolock(unsigned char c, struct n_tty_data *ldata)
 	if (read_cnt(ldata) < N_TTY_BUF_SIZE) {
 		*read_buf_addr(ldata, ldata->read_head) = c;
 		ldata->read_head++;
-		ldata->read_cnt++;
 	}
 }
 
@@ -261,7 +259,7 @@ static void reset_buffer_flags(struct n_tty_data *ldata)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&ldata->read_lock, flags);
-	ldata->read_head = ldata->read_tail = ldata->read_cnt = 0;
+	ldata->read_head = ldata->read_tail = 0;
 	raw_spin_unlock_irqrestore(&ldata->read_lock, flags);
 
 	mutex_lock(&ldata->echo_lock);
@@ -965,16 +963,12 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 	else {
 		if (!L_ECHO(tty)) {
 			raw_spin_lock_irqsave(&ldata->read_lock, flags);
-			ldata->read_cnt -= ((ldata->read_head - ldata->canon_head) &
-					  (N_TTY_BUF_SIZE - 1));
 			ldata->read_head = ldata->canon_head;
 			raw_spin_unlock_irqrestore(&ldata->read_lock, flags);
 			return;
 		}
 		if (!L_ECHOK(tty) || !L_ECHOKE(tty) || !L_ECHOE(tty)) {
 			raw_spin_lock_irqsave(&ldata->read_lock, flags);
-			ldata->read_cnt -= ((ldata->read_head - ldata->canon_head) &
-					  (N_TTY_BUF_SIZE - 1));
 			ldata->read_head = ldata->canon_head;
 			raw_spin_unlock_irqrestore(&ldata->read_lock, flags);
 			finish_erasing(ldata);
@@ -1012,7 +1006,6 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 		cnt = ldata->read_head - head;
 		raw_spin_lock_irqsave(&ldata->read_lock, flags);
 		ldata->read_head = head;
-		ldata->read_cnt -= cnt;
 		raw_spin_unlock_irqrestore(&ldata->read_lock, flags);
 		if (L_ECHO(tty)) {
 			if (L_ECHOPRT(tty)) {
@@ -1471,7 +1464,6 @@ static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		i = min(count, i);
 		memcpy(read_buf_addr(ldata, ldata->read_head), cp, i);
 		ldata->read_head += i;
-		ldata->read_cnt += i;
 		cp += i;
 		count -= i;
 
@@ -1480,7 +1472,6 @@ static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		i = min(count, i);
 		memcpy(read_buf_addr(ldata, ldata->read_head), cp, i);
 		ldata->read_head += i;
-		ldata->read_cnt += i;
 		raw_spin_unlock_irqrestore(&ldata->read_lock, cpuflags);
 	} else {
 		for (i = count, p = cp, f = fp; i; i--, p++) {
@@ -1760,7 +1751,6 @@ static int copy_from_read_buf(struct tty_struct *tty,
 				ldata->icanon);
 		raw_spin_lock_irqsave(&ldata->read_lock, flags);
 		ldata->read_tail += n;
-		ldata->read_cnt -= n;
 		/* Turn single EOF into zero-length read */
 		if (L_EXTPROC(tty) && ldata->icanon && is_eof && !read_cnt(ldata))
 			n = 0;
@@ -1848,7 +1838,6 @@ static int canon_copy_from_read_buf(struct tty_struct *tty,
 
 	raw_spin_lock_irqsave(&ldata->read_lock, flags);
 	ldata->read_tail += c;
-	ldata->read_cnt -= c;
 	if (found) {
 		__clear_bit(eol, ldata->read_flags);
 		/* this test should be redundant:
-- 
1.8.1.2
