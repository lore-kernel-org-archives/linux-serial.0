From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 1/3] tty: Make lock subclasses available for other tty locks
Date: Sat, 17 Jan 2015 15:42:04 -0500
Message-ID: <1421527326-4368-2-git-send-email-peter@hurleysoftware.com>
References: <1421527326-4368-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421527326-4368-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Besides nested legacy_mutex locking which is required on pty pair
teardown, other nested pty operations require lock subclassing.

Move lock subclass definition to tty interface header, include/linux/tty.h,
and document its use.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_mutex.c | 12 +-----------
 include/linux/tty.h     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_mutex.c b/drivers/tty/tty_mutex.c
index a872389..0efcf71 100644
--- a/drivers/tty/tty_mutex.c
+++ b/drivers/tty/tty_mutex.c
@@ -4,18 +4,8 @@
 #include <linux/semaphore.h>
 #include <linux/sched.h>
 
-/*
- * Nested tty locks are necessary for releasing pty pairs.
- * The stable lock order is master pty first, then slave pty.
- */
-
 /* Legacy tty mutex glue */
 
-enum {
-	TTY_MUTEX_NORMAL,
-	TTY_MUTEX_SLAVE,
-};
-
 /*
  * Getting the big tty mutex.
  */
@@ -58,5 +48,5 @@ void __lockfunc tty_unlock_slave(struct tty_struct *tty)
 
 void tty_set_lock_subclass(struct tty_struct *tty)
 {
-	lockdep_set_subclass(&tty->legacy_mutex, TTY_MUTEX_SLAVE);
+	lockdep_set_subclass(&tty->legacy_mutex, TTY_LOCK_SLAVE);
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 09da425..4c1c453 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -14,6 +14,23 @@
 #include <linux/llist.h>
 
 
+/*
+ * Lock subclasses for tty locks
+ *
+ * TTY_LOCK_NORMAL is for normal ttys and master ptys.
+ * TTY_LOCK_SLAVE is for slave ptys only.
+ *
+ * Lock subclasses are necessary for handling nested locking with pty pairs.
+ * tty locks which use nested locking:
+ *
+ * legacy_mutex - Nested tty locks are necessary for releasing pty pairs.
+ *		  The stable lock order is master pty first, then slave pty.
+ */
+
+enum {
+	TTY_LOCK_NORMAL = 0,
+	TTY_LOCK_SLAVE,
+};
 
 /*
  * (Note: the *_driver.minor_start values 1, 64, 128, 192 are
-- 
2.2.2
