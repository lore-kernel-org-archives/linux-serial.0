From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 09/20] n_tty: Factor raw mode receive_buf() into separate fn
Date: Sat, 15 Jun 2013 10:21:25 -0400
Message-ID: <1371306096-5571-10-git-send-email-peter@hurleysoftware.com>
References: <1371305069-5366-1-git-send-email-peter@hurleysoftware.com>
 <1371306096-5571-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371306096-5571-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Convert to modal receive_buf() processing; factor raw mode
per-char i/o into n_tty_receive_buf_raw().

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index b7c5ab3..40cc0a5 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1258,11 +1258,6 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	struct n_tty_data *ldata = tty->disc_data;
 	int parmrk;
 
-	if (ldata->raw) {
-		put_tty_queue(c, ldata);
-		return;
-	}
-
 	if (I_ISTRIP(tty))
 		c &= 0x7f;
 	if (I_IUCLC(tty) && L_IEXTEN(tty))
@@ -1529,6 +1524,23 @@ n_tty_receive_buf_real_raw(struct tty_struct *tty, const unsigned char *cp,
 	ldata->read_head += n;
 }
 
+static void
+n_tty_receive_buf_raw(struct tty_struct *tty, const unsigned char *cp,
+		      char *fp, int count)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	char flag = TTY_NORMAL;
+
+	while (count--) {
+		if (fp)
+			flag = *fp++;
+		if (likely(flag == TTY_NORMAL))
+			put_tty_queue(*cp++, ldata);
+		else
+			n_tty_receive_char_flagged(tty, *cp++, flag);
+	}
+}
+
 static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			  char *fp, int count)
 {
@@ -1536,6 +1548,8 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 
 	if (ldata->real_raw)
 		n_tty_receive_buf_real_raw(tty, cp, fp, count);
+	else if (ldata->raw)
+		n_tty_receive_buf_raw(tty, cp, fp, count);
 	else {
 		char flag = TTY_NORMAL;
 
-- 
1.8.1.2
