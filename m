From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 1/7] tty: core: Improve debug message content
Date: Sun, 12 Jul 2015 22:49:07 -0400
Message-ID: <1436755753-7746-2-git-send-email-peter@hurleysoftware.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Output the function name, tty name, and invariant failure (if applicable).
Add the tty count to the tty_open() message. Fix the disassociate_ctty()
message, which printed the NULL pointer and the wrong message.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 57fc6ee..2d9811a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -524,7 +524,8 @@ static void __proc_set_tty(struct tty_struct *tty)
 	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 	tty->session = get_pid(task_session(current));
 	if (current->signal->tty) {
-		printk(KERN_DEBUG "tty not NULL!!\n");
+		printk(KERN_DEBUG "%s: %s: current tty %s not NULL!!\n",
+		       __func__, tty->name, current->signal->tty->name);
 		tty_kref_put(current->signal->tty);
 	}
 	put_pid(current->signal->tty_old_pgrp);
@@ -922,8 +923,7 @@ void disassociate_ctty(int on_exit)
 		tty_kref_put(tty);
 	} else {
 #ifdef TTY_DEBUG_HANGUP
-		printk(KERN_DEBUG "error attempted to write to tty [0x%p]"
-		       " = NULL", tty);
+		printk(KERN_DEBUG "%s: no current tty\n", __func__);
 #endif
 	}
 
@@ -1705,8 +1705,8 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 {
 #ifdef TTY_PARANOIA_CHECK
 	if (idx < 0 || idx >= tty->driver->num) {
-		printk(KERN_DEBUG "%s: bad idx when trying to free (%s)\n",
-				__func__, tty->name);
+		printk(KERN_DEBUG "%s: %s: bad idx %d\n",
+				__func__, tty->name, idx);
 		return -1;
 	}
 
@@ -1715,20 +1715,22 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 		return 0;
 
 	if (tty != tty->driver->ttys[idx]) {
-		printk(KERN_DEBUG "%s: driver.table[%d] not tty for (%s)\n",
-				__func__, idx, tty->name);
+		printk(KERN_DEBUG "%s: %s: bad driver table[%d] = %p\n",
+		       __func__, tty->name, idx, tty->driver->ttys[idx]);
 		return -1;
 	}
 	if (tty->driver->other) {
 		struct tty_struct *o_tty = tty->link;
 
 		if (o_tty != tty->driver->other->ttys[idx]) {
-			printk(KERN_DEBUG "%s: other->table[%d] not o_tty for (%s)\n",
-					__func__, idx, tty->name);
+			printk(KERN_DEBUG "%s: %s: bad other table[%d] = %p\n",
+			       __func__, tty->name, idx,
+			       tty->driver->other->ttys[idx]);
 			return -1;
 		}
 		if (o_tty->link != tty) {
-			printk(KERN_DEBUG "%s: bad pty pointers\n", __func__);
+			printk(KERN_DEBUG "%s: %s: bad link = %p\n",
+			       __func__, tty->name, o_tty->link);
 			return -1;
 		}
 	}
@@ -2099,7 +2101,8 @@ retry_open:
 	    tty->driver->subtype == PTY_TYPE_MASTER)
 		noctty = 1;
 #ifdef TTY_DEBUG_HANGUP
-	printk(KERN_DEBUG "%s: opening %s...\n", __func__, tty->name);
+	printk(KERN_DEBUG "%s: %s: (tty count=%d)\n", __func__, tty->name,
+	       tty->count);
 #endif
 	if (tty->ops->open)
 		retval = tty->ops->open(tty, filp);
@@ -2109,8 +2112,8 @@ retry_open:
 
 	if (retval) {
 #ifdef TTY_DEBUG_HANGUP
-		printk(KERN_DEBUG "%s: error %d in opening %s...\n", __func__,
-				retval, tty->name);
+		printk(KERN_DEBUG "%s: %s: error %d, releasing...\n", __func__,
+		       tty->name, retval);
 #endif
 		tty_unlock(tty); /* need to call tty_release without BTM */
 		tty_release(inode, filp);
-- 
2.4.5
