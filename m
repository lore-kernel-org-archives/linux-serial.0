From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 08/10] tty: Move session_of_pgrp() and make static
Date: Thu, 16 Oct 2014 14:59:48 -0400
Message-ID: <1413485990-16855-9-git-send-email-peter@hurleysoftware.com>
References: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tiocspgrp() is the lone caller of session_of_pgrp(); relocate and
limit to file scope.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c   | 21 +++++++++++++++++++++
 include/linux/kernel.h |  3 ---
 kernel/exit.c          | 21 ---------------------
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 4226ae7..c15421df 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2522,6 +2522,27 @@ struct pid *tty_get_pgrp(struct tty_struct *tty)
 }
 EXPORT_SYMBOL_GPL(tty_get_pgrp);
 
+/*
+ * This checks not only the pgrp, but falls back on the pid if no
+ * satisfactory pgrp is found. I dunno - gdb doesn't work correctly
+ * without this...
+ *
+ * The caller must hold rcu lock or the tasklist lock.
+ */
+static struct pid *session_of_pgrp(struct pid *pgrp)
+{
+	struct task_struct *p;
+	struct pid *sid = NULL;
+
+	p = pid_task(pgrp, PIDTYPE_PGID);
+	if (p == NULL)
+		p = pid_task(pgrp, PIDTYPE_PID);
+	if (p != NULL)
+		sid = task_session(p);
+
+	return sid;
+}
+
 /**
  *	tiocgpgrp		-	get process group
  *	@tty: tty passed by user
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 95624be..70c1e12 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -414,9 +414,6 @@ extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
 
-struct pid;
-extern struct pid *session_of_pgrp(struct pid *pgrp);
-
 unsigned long int_sqrt(unsigned long);
 
 extern void bust_spinlocks(int yes);
diff --git a/kernel/exit.c b/kernel/exit.c
index 32c58f7..0973f4c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -214,27 +214,6 @@ repeat:
 }
 
 /*
- * This checks not only the pgrp, but falls back on the pid if no
- * satisfactory pgrp is found. I dunno - gdb doesn't work correctly
- * without this...
- *
- * The caller must hold rcu lock or the tasklist lock.
- */
-struct pid *session_of_pgrp(struct pid *pgrp)
-{
-	struct task_struct *p;
-	struct pid *sid = NULL;
-
-	p = pid_task(pgrp, PIDTYPE_PGID);
-	if (p == NULL)
-		p = pid_task(pgrp, PIDTYPE_PID);
-	if (p != NULL)
-		sid = task_session(p);
-
-	return sid;
-}
-
-/*
  * Determine if a process group is "orphaned", according to the POSIX
  * definition in 2.2.2.52.  Orphaned process groups are not to be affected
  * by terminal-generated stop signals.  Newly orphaned process groups are
-- 
2.1.1
