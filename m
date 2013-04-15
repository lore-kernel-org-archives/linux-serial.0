From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 12/20] n_tty: Factor standard per-char i/o into separate fn
Date: Mon, 15 Apr 2013 11:32:43 -0400
Message-ID: <1366039971-8770-13-git-send-email-peter@hurleysoftware.com>
References: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
 <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Simplify __receive_buf() into a dispatch function; perform per-char
processing for all other modes not already handled.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 81e2bb3..8808833 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1568,6 +1568,23 @@ n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
 	}
 }
 
+static void
+n_tty_receive_buf_standard(struct tty_struct *tty, const unsigned char *cp,
+			   char *fp, int count)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	char flag = TTY_NORMAL;
+
+	while (count--) {
+		if (fp)
+			flag = *fp++;
+		if (likely(flag == TTY_NORMAL))
+			n_tty_receive_char(tty, *cp++);
+		else
+			n_tty_receive_char_flagged(tty, *cp++, flag);
+	}
+}
+
 static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			  char *fp, int count)
 {
@@ -1581,16 +1598,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	else if (tty->closing && !L_EXTPROC(tty))
 		n_tty_receive_buf_closing(tty, cp, fp, count);
 	else {
-		char flag = TTY_NORMAL;
-
-		while (count--) {
-			if (fp)
-				flag = *fp++;
-			if (likely(flag == TTY_NORMAL))
-				n_tty_receive_char(tty, *cp++);
-			else
-				n_tty_receive_char_flagged(tty, *cp++, flag);
-		}
+		n_tty_receive_buf_standard(tty, cp, fp, count);
 
 		flush_echoes(tty);
 		if (tty->ops->flush_chars)
-- 
1.8.1.2
