From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 2/7] n_tty: Lock access to tty->pgrp for POSIX job control
Date: Wed,  6 Mar 2013 08:38:20 -0500
Message-ID: <1362577105-19757-3-git-send-email-peter@hurleysoftware.com>
References: <1362577105-19757-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362577105-19757-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Concurrent access to tty->pgrp must be protected with tty->ctrl_lock.
Also, as noted in the comments, reading current->signal->tty is
safe because either,
  1) current->signal->tty is assigned by current, or
  2) current->signal->tty is set to NULL.

NB: for reference, tty_check_change() implements a similar POSIX
check for the ioctls corresponding to tcflush(), tcdrain(),
tcsetattr(), tcsetpgrp(), tcflow() and tcsendbreak().

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index cd9ba3d..61797c4 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1744,10 +1744,9 @@ extern ssize_t redirected_tty_write(struct file *, const char __user *,
  *	and if appropriate send any needed signals and return a negative
  *	error code if action should be taken.
  *
- *	FIXME:
- *	Locking: None - redirected write test is safe, testing
- *	current->signal should possibly lock current->sighand
- *	pgrp locking ?
+ *	Locking: redirected write test is safe
+ *		 current->signal->tty check is safe
+ *		 ctrl_lock to safely reference tty->pgrp
  */
 
 static int job_control(struct tty_struct *tty, struct file *file)
@@ -1757,19 +1756,22 @@ static int job_control(struct tty_struct *tty, struct file *file)
 	/* NOTE: not yet done after every sleep pending a thorough
 	   check of the logic of this change. -- jlc */
 	/* don't stop on /dev/console */
-	if (file->f_op->write != redirected_tty_write &&
-	    current->signal->tty == tty) {
-		if (!tty->pgrp)
-			printk(KERN_ERR "n_tty_read: no tty->pgrp!\n");
-		else if (task_pgrp(current) != tty->pgrp) {
-			if (is_ignored(SIGTTIN) ||
-			    is_current_pgrp_orphaned())
-				return -EIO;
-			kill_pgrp(task_pgrp(current), SIGTTIN, 1);
-			set_thread_flag(TIF_SIGPENDING);
-			return -ERESTARTSYS;
-		}
+	if (file->f_op->write == redirected_tty_write ||
+	    current->signal->tty != tty)
+		return 0;
+
+	spin_lock_irq(&tty->ctrl_lock);
+	if (!tty->pgrp)
+		printk(KERN_ERR "n_tty_read: no tty->pgrp!\n");
+	else if (task_pgrp(current) != tty->pgrp) {
+		spin_unlock_irq(&tty->ctrl_lock);
+		if (is_ignored(SIGTTIN) || is_current_pgrp_orphaned())
+			return -EIO;
+		kill_pgrp(task_pgrp(current), SIGTTIN, 1);
+		set_thread_flag(TIF_SIGPENDING);
+		return -ERESTARTSYS;
 	}
+	spin_unlock_irq(&tty->ctrl_lock);
 	return 0;
 }
 
-- 
1.8.1.2
