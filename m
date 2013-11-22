From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 4/7] n_tty: Refactor PARMRK doubling checks
Date: Fri, 22 Nov 2013 10:59:22 -0500
Message-ID: <1385135965-4235-5-git-send-email-peter@hurleysoftware.com>
References: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385135965-4235-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Perform PARMRK doubling checks explicitly; remove ternary idiom
and local variable.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 61edeaf..9298b68 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1258,7 +1258,6 @@ static int
 n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int parmrk;
 
 	if (I_IXON(tty)) {
 		if (c == START_CHAR(tty)) {
@@ -1343,8 +1342,6 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 		}
 		if ((c == EOL_CHAR(tty)) ||
 		    (c == EOL2_CHAR(tty) && L_IEXTEN(tty))) {
-			parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty))
-				 ? 1 : 0;
 			/*
 			 * XXX are EOL_CHAR and EOL2_CHAR echoed?!?
 			 */
@@ -1359,7 +1356,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 			 * XXX does PARMRK doubling happen for
 			 * EOL_CHAR and EOL2_CHAR?
 			 */
-			if (parmrk)
+			if (c == (unsigned char) '\377' && I_PARMRK(tty))
 				put_tty_queue(c, ldata);
 
 handle_newline:
@@ -1373,7 +1370,6 @@ handle_newline:
 		}
 	}
 
-	parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty)) ? 1 : 0;
 	if (L_ECHO(tty)) {
 		finish_erasing(ldata);
 		if (c == '\n')
@@ -1387,7 +1383,8 @@ handle_newline:
 		commit_echoes(tty);
 	}
 
-	if (parmrk)
+	/* PARMRK doubling check */
+	if (c == (unsigned char) '\377' && I_PARMRK(tty))
 		put_tty_queue(c, ldata);
 
 	put_tty_queue(c, ldata);
@@ -1398,7 +1395,6 @@ static inline void
 n_tty_receive_char_inline(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int parmrk;
 
 	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
 		start_tty(tty);
@@ -1412,8 +1408,8 @@ n_tty_receive_char_inline(struct tty_struct *tty, unsigned char c)
 		echo_char(c, tty);
 		commit_echoes(tty);
 	}
-	parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty)) ? 1 : 0;
-	if (parmrk)
+	/* PARMRK doubling check */
+	if (c == (unsigned char) '\377' && I_PARMRK(tty))
 		put_tty_queue(c, ldata);
 	put_tty_queue(c, ldata);
 }
-- 
1.8.1.2
