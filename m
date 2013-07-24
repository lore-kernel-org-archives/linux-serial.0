From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 1/9] n_tty: Factor standard per-char i/o into separate fn
Date: Wed, 24 Jul 2013 08:29:49 -0400
Message-ID: <1374668997-29726-1-git-send-email-peter@hurleysoftware.com>
References: <20130724001259.GA9239@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130724001259.GA9239@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Simplify __receive_buf() into a dispatch function; perform per-char
processing for all other modes not already handled.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ed6c4e4..15d95e4 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1568,6 +1568,22 @@ n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
 	}
 }
 
+static void
+n_tty_receive_buf_standard(struct tty_struct *tty, const unsigned char *cp,
+			   char *fp, int count)
+{
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
@@ -1581,16 +1597,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
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
