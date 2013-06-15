From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 13/20] n_tty: Eliminate char tests from IXANY restart test
Date: Sat, 15 Jun 2013 10:21:29 -0400
Message-ID: <1371306096-5571-14-git-send-email-peter@hurleysoftware.com>
References: <1371305069-5366-1-git-send-email-peter@hurleysoftware.com>
 <1371306096-5571-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371306096-5571-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Relocate the IXANY restart tty test to code paths where the
the received char is not START_CHAR, STOP_CHAR, INTR_CHAR,
QUIT_CHAR or SUSP_CHAR.

Fixes the condition when ISIG if off and one of INTR_CHAR,
QUIT_CHAR or SUSP_CHAR does not restart i/o.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 785def1..1f21c97 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1268,13 +1268,6 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 		return;
 	}
 
-	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) &&
-	    I_IXANY(tty) && c != START_CHAR(tty) && c != STOP_CHAR(tty) &&
-	    c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) && c != SUSP_CHAR(tty)) {
-		start_tty(tty);
-		process_echoes(tty);
-	}
-
 	/*
 	 * If the previous character was LNEXT, or we know that this
 	 * character is not one of the characters that we'll have to
@@ -1283,6 +1276,13 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	 */
 	if (!test_bit(c, ldata->char_map) || ldata->lnext) {
 		ldata->lnext = 0;
+
+		if (tty->stopped && !tty->flow_stopped && I_IXON(tty) &&
+		    I_IXANY(tty)) {
+			start_tty(tty);
+			process_echoes(tty);
+		}
+
 		parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty)) ? 1 : 0;
 		if (read_cnt(ldata) >= (N_TTY_BUF_SIZE - parmrk - 1)) {
 			/* beep if no space */
@@ -1329,6 +1329,11 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 		}
 	}
 
+	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
+		start_tty(tty);
+		process_echoes(tty);
+	}
+
 	if (c == '\r') {
 		if (I_IGNCR(tty))
 			return;
-- 
1.8.1.2
