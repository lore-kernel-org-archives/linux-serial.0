From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 2/9] n_tty: Eliminate char tests from IXANY restart test
Date: Wed, 24 Jul 2013 08:29:50 -0400
Message-ID: <1374668997-29726-2-git-send-email-peter@hurleysoftware.com>
References: <20130724001259.GA9239@kroah.com>
 <1374668997-29726-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374668997-29726-1-git-send-email-peter@hurleysoftware.com>
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
index 15d95e4..d3b4129 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1269,13 +1269,6 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
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
@@ -1284,6 +1277,13 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
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
@@ -1330,6 +1330,11 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
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
