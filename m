From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 13/20] n_tty: Eliminate char tests from IXANY restart test
Date: Mon, 15 Apr 2013 11:32:44 -0400
Message-ID: <1366039971-8770-14-git-send-email-peter@hurleysoftware.com>
References: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
 <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:48251 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3DOQCm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Apr 2013 12:02:42 -0400
In-Reply-To: <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

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
index 8808833..33994e6 100644
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

