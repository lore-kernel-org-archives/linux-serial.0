From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 6/9] tty: Unify receive_buf() code paths
Date: Sun, 10 Jan 2016 14:43:06 -0800
Message-ID: <1452465789-4039-6-git-send-email-peter@hurleysoftware.com>
References: <1452465789-4039-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452465789-4039-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Instead of two distinct code branches for receive_buf() handling,
use tty_ldisc_receive_buf() as the single code path.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_buffer.c | 39 ++++++++++++++++++++++++++++-----------
 include/linux/tty.h      | 16 ++--------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 3cd31e0..a946e49 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -435,25 +435,42 @@ int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
 }
 EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
 
+/**
+ *	tty_ldisc_receive_buf		-	forward data to line discipline
+ *	@ld:	line discipline to process input
+ *	@p:	char buffer
+ *	@f:	TTY_* flags buffer
+ *	@count:	number of bytes to process
+ *
+ *	Callers other than flush_to_ldisc() need to exclude the kworker
+ *	from concurrent use of the line discipline, see paste_selection().
+ *
+ *	Returns the number of bytes not processed
+ */
+int tty_ldisc_receive_buf(struct tty_ldisc *ld, unsigned char *p,
+			  char *f, int count)
+{
+	if (ld->ops->receive_buf2)
+		count = ld->ops->receive_buf2(ld->tty, p, f, count);
+	else {
+		count = min_t(int, count, ld->tty->receive_room);
+		if (count && ld->ops->receive_buf)
+			ld->ops->receive_buf(ld->tty, p, f, count);
+	}
+	return count;
+}
+EXPORT_SYMBOL_GPL(tty_ldisc_receive_buf);
 
 static int
-receive_buf(struct tty_struct *tty, struct tty_buffer *head, int count)
+receive_buf(struct tty_ldisc *ld, struct tty_buffer *head, int count)
 {
-	struct tty_ldisc *disc = tty->ldisc;
 	unsigned char *p = char_buf_ptr(head, head->read);
 	char	      *f = NULL;
 
 	if (~head->flags & TTYB_NORMAL)
 		f = flag_buf_ptr(head, head->read);
 
-	if (disc->ops->receive_buf2)
-		count = disc->ops->receive_buf2(tty, p, f, count);
-	else {
-		count = min_t(int, count, tty->receive_room);
-		if (count && disc->ops->receive_buf)
-			disc->ops->receive_buf(tty, p, f, count);
-	}
-	return count;
+	return tty_ldisc_receive_buf(ld, p, f, count);
 }
 
 /**
@@ -514,7 +531,7 @@ static void flush_to_ldisc(struct work_struct *work)
 			continue;
 		}
 
-		count = receive_buf(tty, head, count);
+		count = receive_buf(disc, head, count);
 		if (!count)
 			break;
 		head->read += count;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 03e4015..3b09f23 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -571,20 +571,8 @@ extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
 extern void tty_ldisc_release(struct tty_struct *tty);
 extern void tty_ldisc_init(struct tty_struct *tty);
 extern void tty_ldisc_deinit(struct tty_struct *tty);
-
-static inline int tty_ldisc_receive_buf(struct tty_ldisc *ld, unsigned char *p,
-					char *f, int count)
-{
-	if (ld->ops->receive_buf2)
-		count = ld->ops->receive_buf2(ld->tty, p, f, count);
-	else {
-		count = min_t(int, count, ld->tty->receive_room);
-		if (count && ld->ops->receive_buf)
-			ld->ops->receive_buf(ld->tty, p, f, count);
-	}
-	return count;
-}
-
+extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, unsigned char *p,
+				 char *f, int count);
 
 /* n_tty.c */
 extern void n_tty_inherit_ops(struct tty_ldisc_ops *ops);
-- 
2.7.0
