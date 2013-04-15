From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 04/20] n_tty: Rename process_char_map to char_map
Date: Mon, 15 Apr 2013 11:32:35 -0400
Message-ID: <1366039971-8770-5-git-send-email-peter@hurleysoftware.com>
References: <1366039787-8719-1-git-send-email-peter@hurleysoftware.com>
 <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:45990 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359Ab3DOPd2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Apr 2013 11:33:28 -0400
In-Reply-To: <1366039971-8770-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>


Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 8aac758..d6997de 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -92,7 +92,7 @@ struct n_tty_data {
 	size_t canon_head;
 	size_t echo_head;
 	size_t echo_commit;
-	DECLARE_BITMAP(process_char_map, 256);
+	DECLARE_BITMAP(char_map, 256);
 
 	/* private to n_tty_receive_overrun (single-threaded) */
 	unsigned long overrun_time;
@@ -1278,7 +1278,7 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	 * handle specially, do shortcut processing to speed things
 	 * up.
 	 */
-	if (!test_bit(c, ldata->process_char_map) || ldata->lnext) {
+	if (!test_bit(c, ldata->char_map) || ldata->lnext) {
 		ldata->lnext = 0;
 		parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty)) ? 1 : 0;
 		if (read_cnt(ldata) >= (N_TTY_BUF_SIZE - parmrk - 1)) {
@@ -1623,41 +1623,38 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	    I_ICRNL(tty) || I_INLCR(tty) || L_ICANON(tty) ||
 	    I_IXON(tty) || L_ISIG(tty) || L_ECHO(tty) ||
 	    I_PARMRK(tty)) {
-		bitmap_zero(ldata->process_char_map, 256);
+		bitmap_zero(ldata->char_map, 256);
 
 		if (I_IGNCR(tty) || I_ICRNL(tty))
-			set_bit('\r', ldata->process_char_map);
+			set_bit('\r', ldata->char_map);
 		if (I_INLCR(tty))
-			set_bit('\n', ldata->process_char_map);
+			set_bit('\n', ldata->char_map);
 
 		if (L_ICANON(tty)) {
-			set_bit(ERASE_CHAR(tty), ldata->process_char_map);
-			set_bit(KILL_CHAR(tty), ldata->process_char_map);
-			set_bit(EOF_CHAR(tty), ldata->process_char_map);
-			set_bit('\n', ldata->process_char_map);
-			set_bit(EOL_CHAR(tty), ldata->process_char_map);
+			set_bit(ERASE_CHAR(tty), ldata->char_map);
+			set_bit(KILL_CHAR(tty), ldata->char_map);
+			set_bit(EOF_CHAR(tty), ldata->char_map);
+			set_bit('\n', ldata->char_map);
+			set_bit(EOL_CHAR(tty), ldata->char_map);
 			if (L_IEXTEN(tty)) {
-				set_bit(WERASE_CHAR(tty),
-					ldata->process_char_map);
-				set_bit(LNEXT_CHAR(tty),
-					ldata->process_char_map);
-				set_bit(EOL2_CHAR(tty),
-					ldata->process_char_map);
+				set_bit(WERASE_CHAR(tty), ldata->char_map);
+				set_bit(LNEXT_CHAR(tty), ldata->char_map);
+				set_bit(EOL2_CHAR(tty), ldata->char_map);
 				if (L_ECHO(tty))
 					set_bit(REPRINT_CHAR(tty),
-						ldata->process_char_map);
+						ldata->char_map);
 			}
 		}
 		if (I_IXON(tty)) {
-			set_bit(START_CHAR(tty), ldata->process_char_map);
-			set_bit(STOP_CHAR(tty), ldata->process_char_map);
+			set_bit(START_CHAR(tty), ldata->char_map);
+			set_bit(STOP_CHAR(tty), ldata->char_map);
 		}
 		if (L_ISIG(tty)) {
-			set_bit(INTR_CHAR(tty), ldata->process_char_map);
-			set_bit(QUIT_CHAR(tty), ldata->process_char_map);
-			set_bit(SUSP_CHAR(tty), ldata->process_char_map);
+			set_bit(INTR_CHAR(tty), ldata->char_map);
+			set_bit(QUIT_CHAR(tty), ldata->char_map);
+			set_bit(SUSP_CHAR(tty), ldata->char_map);
 		}
-		clear_bit(__DISABLED_CHAR, ldata->process_char_map);
+		clear_bit(__DISABLED_CHAR, ldata->char_map);
 		ldata->raw = 0;
 		ldata->real_raw = 0;
 	} else {
-- 
1.8.1.2

