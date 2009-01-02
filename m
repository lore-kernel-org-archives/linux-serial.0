From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 22/75] n_tty: Fix hanfling of buffer full corner cases
Date: Fri, 02 Jan 2009 13:43:32 +0000
Message-ID: <20090102134330.13472.33109.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60329 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756056AbZABNnS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:43:18 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Joe Peterson <joe@skyrush.com>

Fix the handling of input characters when the tty buffer is full or nearly
full.  This includes tests that are done in n_tty_receive_char() and handling
of PARMRK.

Problems with the buffer-full tests done in receive_char() caused characters to
be lost at times when the buffer(s) filled.  Also, these full conditions
would often only be detected with echo on, and PARMRK was not accounted for
properly in all cases.  One symptom of these problems, in addition to lost
characters, was early termination from unix commands like tr and cat when
^Q was used to break from a stopped tty with full buffers (note that breaking
out was often previously not possible, due to the pty getting in "gridlock",
which will be addressed in another patch).  Note space is always reserved
at the end of the buffer for a newline (or EOF/EOL) in canonical mode.

Signed-off-by: Joe Peterson <joe@skyrush.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/n_tty.c |   55 +++++++++++++++++++++++++++++++++++---------------
 1 files changed, 38 insertions(+), 17 deletions(-)


diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
index 30b0426..4b1e96b 100644
--- a/drivers/char/n_tty.c
+++ b/drivers/char/n_tty.c
@@ -1107,6 +1107,7 @@ static inline void n_tty_receive_parity_error(struct tty_struct *tty,
 static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
 	unsigned long flags;
+	int parmrk;
 
 	if (tty->raw) {
 		put_tty_queue(c, tty);
@@ -1144,21 +1145,24 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	 */
 	if (!test_bit(c, tty->process_char_map) || tty->lnext) {
 		tty->lnext = 0;
-		if (L_ECHO(tty)) {
-			finish_erasing(tty);
-			if (tty->read_cnt >= N_TTY_BUF_SIZE-1) {
-				/* beep if no space */
+		parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty)) ? 1 : 0;
+		if (tty->read_cnt >= (N_TTY_BUF_SIZE - parmrk - 1)) {
+			/* beep if no space */
+			if (L_ECHO(tty)) {
 				echo_char_raw('\a', tty);
 				process_echoes(tty);
-				return;
 			}
+			return;
+		}
+		if (L_ECHO(tty)) {
+			finish_erasing(tty);
 			/* Record the column of first canon char. */
 			if (tty->canon_head == tty->read_head)
 				echo_set_canon_col(tty);
 			echo_char(c, tty);
 			process_echoes(tty);
 		}
-		if (I_PARMRK(tty) && c == (unsigned char) '\377')
+		if (parmrk)
 			put_tty_queue(c, tty);
 		put_tty_queue(c, tty);
 		return;
@@ -1250,15 +1254,22 @@ send_signal:
 			return;
 		}
 		if (c == '\n') {
-			if (L_ECHO(tty) || L_ECHONL(tty)) {
-				if (tty->read_cnt >= N_TTY_BUF_SIZE-1)
+			if (tty->read_cnt >= N_TTY_BUF_SIZE) {
+				if (L_ECHO(tty)) {
 					echo_char_raw('\a', tty);
+					process_echoes(tty);
+				}
+				return;
+			}
+			if (L_ECHO(tty) || L_ECHONL(tty)) {
 				echo_char_raw('\n', tty);
 				process_echoes(tty);
 			}
 			goto handle_newline;
 		}
 		if (c == EOF_CHAR(tty)) {
+			if (tty->read_cnt >= N_TTY_BUF_SIZE)
+				return;
 			if (tty->canon_head != tty->read_head)
 				set_bit(TTY_PUSH, &tty->flags);
 			c = __DISABLED_CHAR;
@@ -1266,12 +1277,19 @@ send_signal:
 		}
 		if ((c == EOL_CHAR(tty)) ||
 		    (c == EOL2_CHAR(tty) && L_IEXTEN(tty))) {
+			parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty))
+				 ? 1 : 0;
+			if (tty->read_cnt >= (N_TTY_BUF_SIZE - parmrk)) {
+				if (L_ECHO(tty)) {
+					echo_char_raw('\a', tty);
+					process_echoes(tty);
+				}
+				return;
+			}
 			/*
 			 * XXX are EOL_CHAR and EOL2_CHAR echoed?!?
 			 */
 			if (L_ECHO(tty)) {
-				if (tty->read_cnt >= N_TTY_BUF_SIZE-1)
-					echo_char_raw('\a', tty);
 				/* Record the column of first canon char. */
 				if (tty->canon_head == tty->read_head)
 					echo_set_canon_col(tty);
@@ -1282,7 +1300,7 @@ send_signal:
 			 * XXX does PARMRK doubling happen for
 			 * EOL_CHAR and EOL2_CHAR?
 			 */
-			if (I_PARMRK(tty) && c == (unsigned char) '\377')
+			if (parmrk)
 				put_tty_queue(c, tty);
 
 handle_newline:
@@ -1299,14 +1317,17 @@ handle_newline:
 		}
 	}
 
-	if (L_ECHO(tty)) {
-		finish_erasing(tty);
-		if (tty->read_cnt >= N_TTY_BUF_SIZE-1) {
-			/* beep if no space */
+	parmrk = (c == (unsigned char) '\377' && I_PARMRK(tty)) ? 1 : 0;
+	if (tty->read_cnt >= (N_TTY_BUF_SIZE - parmrk - 1)) {
+		/* beep if no space */
+		if (L_ECHO(tty)) {
 			echo_char_raw('\a', tty);
 			process_echoes(tty);
-			return;
 		}
+		return;
+	}
+	if (L_ECHO(tty)) {
+		finish_erasing(tty);
 		if (c == '\n')
 			echo_char_raw('\n', tty);
 		else {
@@ -1318,7 +1339,7 @@ handle_newline:
 		process_echoes(tty);
 	}
 
-	if (I_PARMRK(tty) && c == (unsigned char) '\377')
+	if (parmrk)
 		put_tty_queue(c, tty);
 
 	put_tty_queue(c, tty);

