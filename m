From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 3/7] tty: Replace #ifdef TTY_DEBUG_HANGUP with tty_debug_hangup()
Date: Sun, 12 Jul 2015 22:49:09 -0400
Message-ID: <1436755753-7746-4-git-send-email-peter@hurleysoftware.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Add tty_debug_hangup() macro which uses tty_debug to print the
debug message; remove inlined #ifdefs.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 47 ++++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 6de2c36..acd6988 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -106,6 +106,11 @@
 #include <linux/nsproxy.h>
 
 #undef TTY_DEBUG_HANGUP
+#ifdef TTY_DEBUG_HANGUP
+# define tty_debug_hangup(tty, f, args...)	tty_debug(tty, f, ##args)
+#else
+# define tty_debug_hangup(tty, f, args...)	do { } while (0)
+#endif
 
 #define TTY_PARANOIA_CHECK 1
 #define CHECK_TTY_COUNT 1
@@ -767,9 +772,7 @@ static void do_tty_hangup(struct work_struct *work)
 
 void tty_hangup(struct tty_struct *tty)
 {
-#ifdef TTY_DEBUG_HANGUP
-	tty_debug(tty, "\n");
-#endif
+	tty_debug_hangup(tty, "\n");
 	schedule_work(&tty->hangup_work);
 }
 
@@ -786,9 +789,7 @@ EXPORT_SYMBOL(tty_hangup);
 
 void tty_vhangup(struct tty_struct *tty)
 {
-#ifdef TTY_DEBUG_HANGUP
-	tty_debug(tty, "\n")
-#endif
+	tty_debug_hangup(tty, "\n");
 	__tty_hangup(tty, 0);
 }
 
@@ -825,9 +826,7 @@ void tty_vhangup_self(void)
 
 static void tty_vhangup_session(struct tty_struct *tty)
 {
-#ifdef TTY_DEBUG_HANGUP
-	tty_debug(tty, "\n");
-#endif
+	tty_debug_hangup(tty, "\n");
 	__tty_hangup(tty, 1);
 }
 
@@ -921,11 +920,8 @@ void disassociate_ctty(int on_exit)
 		tty->pgrp = NULL;
 		spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 		tty_kref_put(tty);
-	} else {
-#ifdef TTY_DEBUG_HANGUP
-		tty_debug(tty, "no current tty\n");
-#endif
-	}
+	} else
+		tty_debug_hangup(tty, "no current tty\n");
 
 	spin_unlock_irq(&current->sighand->siglock);
 	/* Now clear signal->tty under the lock */
@@ -1781,9 +1777,7 @@ int tty_release(struct inode *inode, struct file *filp)
 		return 0;
 	}
 
-#ifdef TTY_DEBUG_HANGUP
-	tty_debug(tty, "(tty count=%d)...\n", tty->count);
-#endif
+	tty_debug_hangup(tty, "(tty count=%d)...\n", tty->count);
 
 	if (tty->ops->close)
 		tty->ops->close(tty, filp);
@@ -1893,9 +1887,7 @@ int tty_release(struct inode *inode, struct file *filp)
 	if (!final)
 		return 0;
 
-#ifdef TTY_DEBUG_HANGUP
-	tty_debug(tty, "final close\n");
-#endif
+	tty_debug_hangup(tty, "final close\n");
 	/*
 	 * Ask the line discipline code to release its structures
 	 */
@@ -1904,9 +1896,7 @@ int tty_release(struct inode *inode, struct file *filp)
 	/* Wait for pending work before tty destruction commmences */
 	tty_flush_works(tty);
 
-#ifdef TTY_DEBUG_HANGUP
-	tty_debug(tty, "freeing structure...\n");
-#endif
+	tty_debug_hangup(tty, "freeing structure...\n");
 	/*
 	 * The release_tty function takes care of the details of clearing
 	 * the slots and preserving the termios structure. The tty_unlock_pair
@@ -2095,9 +2085,9 @@ retry_open:
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver->subtype == PTY_TYPE_MASTER)
 		noctty = 1;
-#ifdef TTY_DEBUG_HANGUP
-	tty_debug(tty, "(tty count=%d)\n", tty->count);
-#endif
+
+	tty_debug_hangup(tty, "(tty count=%d)\n", tty->count);
+
 	if (tty->ops->open)
 		retval = tty->ops->open(tty, filp);
 	else
@@ -2105,9 +2095,8 @@ retry_open:
 	filp->f_flags = saved_flags;
 
 	if (retval) {
-#ifdef TTY_DEBUG_HANGUP
-		tty_debug(tty, "error %d, releasing...\n", retval);
-#endif
+		tty_debug_hangup(tty, "error %d, releasing...\n", retval);
+
 		tty_unlock(tty); /* need to call tty_release without BTM */
 		tty_release(inode, filp);
 		if (retval != -ERESTARTSYS)
-- 
2.4.5
