From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 2/7] tty: core: Add tty_debug() for printk(KERN_DEBUG) messages
Date: Sun, 12 Jul 2015 22:49:08 -0400
Message-ID: <1436755753-7746-3-git-send-email-peter@hurleysoftware.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Introduce tty_debug() macro to output uniform debug information for
tty core debug messages (function name and tty name).

Note: printk(KERN_DEBUG) is retained here over pr_debug() since
messages can be enabled in non-DEBUG builds.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 41 +++++++++++++++++------------------------
 include/linux/tty.h  |  6 ++++++
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 2d9811a..6de2c36 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -524,8 +524,8 @@ static void __proc_set_tty(struct tty_struct *tty)
 	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 	tty->session = get_pid(task_session(current));
 	if (current->signal->tty) {
-		printk(KERN_DEBUG "%s: %s: current tty %s not NULL!!\n",
-		       __func__, tty->name, current->signal->tty->name);
+		tty_debug(tty, "current tty %s not NULL!!\n",
+			  current->signal->tty->name);
 		tty_kref_put(current->signal->tty);
 	}
 	put_pid(current->signal->tty_old_pgrp);
@@ -768,7 +768,7 @@ static void do_tty_hangup(struct work_struct *work)
 void tty_hangup(struct tty_struct *tty)
 {
 #ifdef TTY_DEBUG_HANGUP
-	printk(KERN_DEBUG "%s hangup...\n", tty_name(tty));
+	tty_debug(tty, "\n");
 #endif
 	schedule_work(&tty->hangup_work);
 }
@@ -787,7 +787,7 @@ EXPORT_SYMBOL(tty_hangup);
 void tty_vhangup(struct tty_struct *tty)
 {
 #ifdef TTY_DEBUG_HANGUP
-	printk(KERN_DEBUG "%s vhangup...\n", tty_name(tty));
+	tty_debug(tty, "\n")
 #endif
 	__tty_hangup(tty, 0);
 }
@@ -826,7 +826,7 @@ void tty_vhangup_self(void)
 static void tty_vhangup_session(struct tty_struct *tty)
 {
 #ifdef TTY_DEBUG_HANGUP
-	printk(KERN_DEBUG "%s vhangup session...\n", tty_name(tty));
+	tty_debug(tty, "\n");
 #endif
 	__tty_hangup(tty, 1);
 }
@@ -923,7 +923,7 @@ void disassociate_ctty(int on_exit)
 		tty_kref_put(tty);
 	} else {
 #ifdef TTY_DEBUG_HANGUP
-		printk(KERN_DEBUG "%s: no current tty\n", __func__);
+		tty_debug(tty, "no current tty\n");
 #endif
 	}
 
@@ -1705,8 +1705,7 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 {
 #ifdef TTY_PARANOIA_CHECK
 	if (idx < 0 || idx >= tty->driver->num) {
-		printk(KERN_DEBUG "%s: %s: bad idx %d\n",
-				__func__, tty->name, idx);
+		tty_debug(tty, "bad idx %d\n", idx);
 		return -1;
 	}
 
@@ -1715,22 +1714,20 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 		return 0;
 
 	if (tty != tty->driver->ttys[idx]) {
-		printk(KERN_DEBUG "%s: %s: bad driver table[%d] = %p\n",
-		       __func__, tty->name, idx, tty->driver->ttys[idx]);
+		tty_debug(tty, "bad driver table[%d] = %p\n",
+			  idx, tty->driver->ttys[idx]);
 		return -1;
 	}
 	if (tty->driver->other) {
 		struct tty_struct *o_tty = tty->link;
 
 		if (o_tty != tty->driver->other->ttys[idx]) {
-			printk(KERN_DEBUG "%s: %s: bad other table[%d] = %p\n",
-			       __func__, tty->name, idx,
-			       tty->driver->other->ttys[idx]);
+			tty_debug(tty, "bad other table[%d] = %p\n",
+				  idx, tty->driver->other->ttys[idx]);
 			return -1;
 		}
 		if (o_tty->link != tty) {
-			printk(KERN_DEBUG "%s: %s: bad link = %p\n",
-			       __func__, tty->name, o_tty->link);
+			tty_debug(tty, "bad link = %p\n", o_tty->link);
 			return -1;
 		}
 	}
@@ -1785,8 +1782,7 @@ int tty_release(struct inode *inode, struct file *filp)
 	}
 
 #ifdef TTY_DEBUG_HANGUP
-	printk(KERN_DEBUG "%s: %s (tty count=%d)...\n", __func__,
-			tty_name(tty), tty->count);
+	tty_debug(tty, "(tty count=%d)...\n", tty->count);
 #endif
 
 	if (tty->ops->close)
@@ -1898,7 +1894,7 @@ int tty_release(struct inode *inode, struct file *filp)
 		return 0;
 
 #ifdef TTY_DEBUG_HANGUP
-	printk(KERN_DEBUG "%s: %s: final close\n", __func__, tty_name(tty));
+	tty_debug(tty, "final close\n");
 #endif
 	/*
 	 * Ask the line discipline code to release its structures
@@ -1909,8 +1905,7 @@ int tty_release(struct inode *inode, struct file *filp)
 	tty_flush_works(tty);
 
 #ifdef TTY_DEBUG_HANGUP
-	printk(KERN_DEBUG "%s: %s: freeing structure...\n", __func__,
-	       tty_name(tty));
+	tty_debug(tty, "freeing structure...\n");
 #endif
 	/*
 	 * The release_tty function takes care of the details of clearing
@@ -2101,8 +2096,7 @@ retry_open:
 	    tty->driver->subtype == PTY_TYPE_MASTER)
 		noctty = 1;
 #ifdef TTY_DEBUG_HANGUP
-	printk(KERN_DEBUG "%s: %s: (tty count=%d)\n", __func__, tty->name,
-	       tty->count);
+	tty_debug(tty, "(tty count=%d)\n", tty->count);
 #endif
 	if (tty->ops->open)
 		retval = tty->ops->open(tty, filp);
@@ -2112,8 +2106,7 @@ retry_open:
 
 	if (retval) {
 #ifdef TTY_DEBUG_HANGUP
-		printk(KERN_DEBUG "%s: %s: error %d, releasing...\n", __func__,
-		       tty->name, retval);
+		tty_debug(tty, "error %d, releasing...\n", retval);
 #endif
 		tty_unlock(tty); /* need to call tty_release without BTM */
 		tty_release(inode, filp);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index ad6c891..d072ded 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -709,4 +709,10 @@ static inline void proc_tty_register_driver(struct tty_driver *d) {}
 static inline void proc_tty_unregister_driver(struct tty_driver *d) {}
 #endif
 
+#define tty_debug(tty, f, args...)					\
+	do {								\
+		printk(KERN_DEBUG "%s: %s: " f, __func__,		\
+		       tty_name(tty), ##args);				\
+	} while (0)
+
 #endif
-- 
2.4.5
