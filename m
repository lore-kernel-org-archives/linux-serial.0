From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 07/10] tty: Fix multiple races when setting the controlling terminal
Date: Thu, 16 Oct 2014 14:59:47 -0400
Message-ID: <1413485990-16855-8-git-send-email-peter@hurleysoftware.com>
References: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Claim a read lock on the tasklist_lock while setting the controlling
terminal for the session leader. This fixes multiple races:
1. task_pgrp() and task_session() cannot be safely dereferenced, such
   as passing to get_pid(), without holding either rcu_read_lock() or
   tasklist_lock
2. setsid() unwisely allows any thread in the thread group to
   make the thread group leader the session leader; this makes the
   unlocked reads of ->signal->leader and signal->tty potentially
   unordered, stale or even have spurious values.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e33edfa..4226ae7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -502,8 +502,15 @@ void proc_clear_tty(struct task_struct *p)
 	tty_kref_put(tty);
 }
 
-/* Called under the sighand lock */
-
+/**
+ * proc_set_tty -  set the controlling terminal
+ *
+ * Only callable by the session leader and only if it does not already have
+ * a controlling terminal.
+ *
+ * Caller must hold:  a readlock on tasklist_lock
+ *		      sighand lock
+ */
 static void __proc_set_tty(struct tty_struct *tty)
 {
 	unsigned long flags;
@@ -2158,6 +2165,7 @@ retry_open:
 
 	mutex_lock(&tty_mutex);
 	tty_lock(tty);
+	read_lock(&tasklist_lock);
 	spin_lock_irq(&current->sighand->siglock);
 	if (!noctty &&
 	    current->signal->leader &&
@@ -2165,6 +2173,7 @@ retry_open:
 	    tty->session == NULL)
 		__proc_set_tty(tty);
 	spin_unlock_irq(&current->sighand->siglock);
+	read_unlock(&tasklist_lock);
 	tty_unlock(tty);
 	mutex_unlock(&tty_mutex);
 	return 0;
@@ -2454,10 +2463,13 @@ static int fionbio(struct file *file, int __user *p)
 static int tiocsctty(struct tty_struct *tty, int arg)
 {
 	int ret = 0;
-	if (current->signal->leader && (task_session(current) == tty->session))
-		return ret;
 
 	mutex_lock(&tty_mutex);
+	read_lock(&tasklist_lock);
+
+	if (current->signal->leader && (task_session(current) == tty->session))
+		goto unlock;
+
 	/*
 	 * The process must be a session leader and
 	 * not have a controlling tty already.
@@ -2476,9 +2488,7 @@ static int tiocsctty(struct tty_struct *tty, int arg)
 			/*
 			 * Steal it away
 			 */
-			read_lock(&tasklist_lock);
 			session_clear_tty(tty->session);
-			read_unlock(&tasklist_lock);
 		} else {
 			ret = -EPERM;
 			goto unlock;
@@ -2486,6 +2496,7 @@ static int tiocsctty(struct tty_struct *tty, int arg)
 	}
 	proc_set_tty(tty);
 unlock:
+	read_unlock(&tasklist_lock);
 	mutex_unlock(&tty_mutex);
 	return ret;
 }
-- 
2.1.1
