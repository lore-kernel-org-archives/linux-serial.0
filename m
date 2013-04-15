From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 08/20] n_tty: Factor flagged char handling into separate fn
Date: Mon, 15 Apr 2013 11:32:39 -0400
Message-ID: <1366039971-8770-9-git-send-email-peter@hurleysoftware.com>
References: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
 <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Prepare for modal receive_buf() handling; factor handling for
TTY_BREAK, TTY_PARITY, TTY_FRAME and TTY_OVERRUN into
n_tty_receive_char_flagged().

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e8df595..dce77cb 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1468,6 +1468,29 @@ handle_newline:
 	put_tty_queue(c, ldata);
 }
 
+static void
+n_tty_receive_char_flagged(struct tty_struct *tty, unsigned char c, char flag)
+{
+	char buf[64];
+
+	switch (flag) {
+	case TTY_BREAK:
+		n_tty_receive_break(tty);
+		break;
+	case TTY_PARITY:
+	case TTY_FRAME:
+		n_tty_receive_parity_error(tty, c);
+		break;
+	case TTY_OVERRUN:
+		n_tty_receive_overrun(tty);
+		break;
+	default:
+		printk(KERN_ERR "%s: unknown flag %d\n",
+		       tty_name(tty, buf), flag);
+		break;
+	}
+}
+
 /**
  *	n_tty_receive_buf	-	data receive
  *	@tty: terminal device
@@ -1511,34 +1534,19 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			  char *fp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	char	flags = TTY_NORMAL;
-	char	buf[64];
 
 	if (ldata->real_raw)
 		n_tty_receive_buf_real_raw(tty, cp, fp, count);
 	else {
+		char flag = TTY_NORMAL;
+
 		while (count--) {
 			if (fp)
-				flags = *fp++;
-			switch (flags) {
-			case TTY_NORMAL:
+				flag = *fp++;
+			if (likely(flag == TTY_NORMAL))
 				n_tty_receive_char(tty, *cp++);
-				break;
-			case TTY_BREAK:
-				n_tty_receive_break(tty);
-				break;
-			case TTY_PARITY:
-			case TTY_FRAME:
-				n_tty_receive_parity_error(tty, *cp++);
-				break;
-			case TTY_OVERRUN:
-				n_tty_receive_overrun(tty);
-				break;
-			default:
-				printk(KERN_ERR "%s: unknown flag %d\n",
-				       tty_name(tty, buf), flags);
-				break;
-			}
+			else
+				n_tty_receive_char_flagged(tty, *cp++, flag);
 		}
 
 		flush_echoes(tty);
-- 
1.8.1.2
