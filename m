From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 15/20] n_tty: Factor ISTRIP and IUCLC receive_buf into separate fn
Date: Mon, 15 Apr 2013 11:32:46 -0400
Message-ID: <1366039971-8770-16-git-send-email-peter@hurleysoftware.com>
References: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
 <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Convert to modal receive_buf processing; factor char receive
processing for unusual termios settings out of normal per-char
i/o path.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 8601d6e..6316426 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1417,16 +1417,6 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	struct n_tty_data *ldata = tty->disc_data;
 	int parmrk;
 
-	if (I_ISTRIP(tty))
-		c &= 0x7f;
-	if (I_IUCLC(tty) && L_IEXTEN(tty))
-		c = tolower(c);
-
-	if (L_EXTPROC(tty)) {
-		put_tty_queue(c, ldata);
-		return;
-	}
-
 	/*
 	 * If the previous character was LNEXT, or we know that this
 	 * character is not one of the characters that we'll have to
@@ -1584,9 +1574,34 @@ n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
 
 static void
 n_tty_receive_buf_standard(struct tty_struct *tty, const unsigned char *cp,
-			   char *fp, int count)
+			  char *fp, int count)
+{
+	char flag = TTY_NORMAL;
+
+	while (count--) {
+		if (fp)
+			flag = *fp++;
+		if (likely(flag == TTY_NORMAL)) {
+			unsigned char c = *cp++;
+
+			if (I_ISTRIP(tty))
+				c &= 0x7f;
+			if (I_IUCLC(tty) && L_IEXTEN(tty))
+				c = tolower(c);
+			if (L_EXTPROC(tty)) {
+				put_tty_queue(c, ldata);
+				continue;
+			}
+			n_tty_receive_char(tty, c);
+		} else
+			n_tty_receive_char_flagged(tty, *cp++, flag);
+	}
+}
+
+static void
+n_tty_receive_buf_fast(struct tty_struct *tty, const unsigned char *cp,
+		       char *fp, int count)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	char flag = TTY_NORMAL;
 
 	while (count--) {
@@ -1612,7 +1627,10 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	else if (tty->closing && !L_EXTPROC(tty))
 		n_tty_receive_buf_closing(tty, cp, fp, count);
 	else {
-		n_tty_receive_buf_standard(tty, cp, fp, count);
+		if (!preops)
+			n_tty_receive_buf_fast(tty, cp, fp, count);
+		else
+			n_tty_receive_buf_standard(tty, cp, fp, count);
 
 		flush_echoes(tty);
 		if (tty->ops->flush_chars)
-- 
1.8.1.2
