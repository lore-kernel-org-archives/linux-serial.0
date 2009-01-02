From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 07/75] n_tty: clean up coding style
Date: Fri, 02 Jan 2009 13:41:04 +0000
Message-ID: <20090102134058.13472.59066.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60284 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754755AbZABNku (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:40:50 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Now the main work is done its polishing time

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/n_tty.c |   29 +++++++++++++----------------
 1 files changed, 13 insertions(+), 16 deletions(-)


diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
index a9bc576..a223823 100644
--- a/drivers/char/n_tty.c
+++ b/drivers/char/n_tty.c
@@ -47,8 +47,8 @@
 #include <linux/bitops.h>
 #include <linux/audit.h>
 #include <linux/file.h>
+#include <linux/uaccess.h>
 
-#include <asm/uaccess.h>
 #include <asm/system.h>
 
 /* number of characters left in xmit buffer before select has we have room */
@@ -309,7 +309,7 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 
 	if (!space)
 		return -1;
-	
+
 	switch (c) {
 	case '\n':
 		if (O_ONLRET(tty))
@@ -417,8 +417,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
 	mutex_lock(&tty->output_lock);
 
 	space = tty_write_room(tty);
-	if (!space)
-	{
+	if (!space) {
 		mutex_unlock(&tty->output_lock);
 		return 0;
 	}
@@ -521,7 +520,7 @@ static void process_echoes(struct tty_struct *tty)
 			if (opp == buf_end)
 				opp -= N_TTY_BUF_SIZE;
 			op = *opp;
-			
+
 			switch (op) {
 				unsigned int num_chars, num_bs;
 
@@ -621,7 +620,8 @@ static void process_echoes(struct tty_struct *tty)
 		} else {
 			int retval;
 
-			if ((retval = do_output_char(c, tty, space)) < 0)
+			retval = do_output_char(c, tty, space);
+			if (retval < 0)
 				break;
 			space -= retval;
 			cp += 1;
@@ -675,8 +675,7 @@ static void add_echo_byte(unsigned char c, struct tty_struct *tty)
 		 * Since the buffer start position needs to be advanced,
 		 * be sure to step by a whole operation byte group.
 		 */
-		if (tty->echo_buf[tty->echo_pos] == ECHO_OP_START)
-		{
+		if (tty->echo_buf[tty->echo_pos] == ECHO_OP_START) {
 			if (tty->echo_buf[(tty->echo_pos + 1) &
 					  (N_TTY_BUF_SIZE - 1)] ==
 						ECHO_OP_ERASE_TAB) {
@@ -771,7 +770,7 @@ static void echo_erase_tab(unsigned int num_chars, int after_tab,
 	/* Set the high bit as a flag if num_chars is after a previous tab */
 	if (after_tab)
 		num_chars |= 0x80;
-	
+
 	add_echo_byte(num_chars, tty);
 
 	mutex_unlock(&tty->echo_lock);
@@ -959,8 +958,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 					if (c == '\t') {
 						after_tab = 1;
 						break;
-					}
-					else if (iscntrl(c)) {
+					} else if (iscntrl(c)) {
 						if (L_ECHOCTL(tty))
 							num_chars += 2;
 					} else if (!is_continuation(c, tty)) {
@@ -1112,7 +1110,7 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	if (I_ISTRIP(tty))
 		c &= 0x7f;
 	if (I_IUCLC(tty) && L_IEXTEN(tty))
-		c=tolower(c);
+		c = tolower(c);
 
 	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) &&
 	    I_IXANY(tty) && c != START_CHAR(tty) && c != STOP_CHAR(tty) &&
@@ -1126,8 +1124,7 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 			if (c == START_CHAR(tty)) {
 				start_tty(tty);
 				process_echoes(tty);
-			}
-			else if (c == STOP_CHAR(tty))
+			} else if (c == STOP_CHAR(tty))
 				stop_tty(tty);
 		}
 		return;
@@ -1335,7 +1332,7 @@ static void n_tty_write_wakeup(struct tty_struct *tty)
 {
 	/* Write out any echoed characters that are still pending */
 	process_echoes(tty);
-	
+
 	if (tty->fasync) {
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 		kill_fasync(&tty->fasync, SIGIO, POLL_OUT);
@@ -1942,7 +1939,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 
 	/* Write out any echoed characters that are still pending */
 	process_echoes(tty);
-	
+
 	add_wait_queue(&tty->write_wait, &wait);
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);

