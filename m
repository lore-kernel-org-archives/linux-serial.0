From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] n_tty: signal and flush atomically
Date: Sat, 27 Jun 2015 09:21:32 -0400
Message-ID: <1435411292-3938-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

When handling signalling char, claim the termios write lock before
signalling waiting readers and writers to prevent further i/o
before flushing the echo and output buffers. This prevents a
userspace signal handler which may output from racing the terminal
flush.

Reference: Bugzilla #99351 ("Output truncated in ssh session after...")
Fixes: commit d2b6f44779d3 ("n_tty: Fix signal handling flushes")
Reported-by: Filipe Brandenburger <filbranden@google.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index c9c27f6..ee8bfac 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1108,19 +1108,29 @@ static void eraser(unsigned char c, struct tty_struct *tty)
  *	Locking: ctrl_lock
  */
 
-static void isig(int sig, struct tty_struct *tty)
+static void __isig(int sig, struct tty_struct *tty)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	struct pid *tty_pgrp = tty_get_pgrp(tty);
 	if (tty_pgrp) {
 		kill_pgrp(tty_pgrp, sig, 1);
 		put_pid(tty_pgrp);
 	}
+}
 
-	if (!L_NOFLSH(tty)) {
+static void isig(int sig, struct tty_struct *tty)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+
+	if (L_NOFLSH(tty)) {
+		/* signal only */
+		__isig(sig, tty);
+
+	} else { /* signal and flush */
 		up_read(&tty->termios_rwsem);
 		down_write(&tty->termios_rwsem);
 
+		__isig(sig, tty);
+
 		/* clear echo buffer */
 		mutex_lock(&ldata->output_lock);
 		ldata->echo_head = ldata->echo_tail = 0;
-- 
2.4.5
