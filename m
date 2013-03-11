From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5 37/44] tty: Drop ldsem wait type
Date: Mon, 11 Mar 2013 16:44:57 -0400
Message-ID: <1363034704-28036-38-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
 <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Now the lock failures are handled independently for reads and
writes, the wait flags are no longer necessary.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldsem.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index d849fb85..ddfbdfe 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -76,9 +76,6 @@
 struct ldsem_waiter {
 	struct list_head list;
 	struct task_struct *task;
-	unsigned int flags;
-#define LDSEM_READ_WAIT		0x00000001
-#define LDSEM_WRITE_WAIT	0x00000002
 };
 
 /* Wake types for __ldsem_wake().  Note: RWSEM_WAKE_NO_CHECK implies
@@ -226,19 +223,13 @@ static struct ld_semaphore __sched *
 down_read_failed(struct ld_semaphore *sem, long timeout)
 {
 	struct ldsem_waiter waiter;
-	long flags = LDSEM_READ_WAIT;
 	long adjust = -LDSEM_ACTIVE_BIAS + LDSEM_WAIT_BIAS;
 
 	/* set up my own style of waitqueue */
 	raw_spin_lock_irq(&sem->wait_lock);
-
-	if (flags & LDSEM_READ_WAIT)
-		list_add_tail(&waiter.list, &sem->read_wait);
-	else
-		list_add_tail(&waiter.list, &sem->write_wait);
+	list_add_tail(&waiter.list, &sem->read_wait);
 
 	waiter.task = current;
-	waiter.flags = flags;
 	get_task_struct(current);
 
 	/* change the lock attempt to a wait --
@@ -287,19 +278,13 @@ static struct ld_semaphore __sched *
 down_write_failed(struct ld_semaphore *sem, long timeout)
 {
 	struct ldsem_waiter waiter;
-	long flags = LDSEM_WRITE_WAIT;
 	long adjust = -LDSEM_ACTIVE_BIAS;
 
 	/* set up my own style of waitqueue */
 	raw_spin_lock_irq(&sem->wait_lock);
-
-	if (flags & LDSEM_READ_WAIT)
-		list_add_tail(&waiter.list, &sem->read_wait);
-	else
-		list_add_tail(&waiter.list, &sem->write_wait);
+	list_add_tail(&waiter.list, &sem->write_wait);
 
 	waiter.task = current;
-	waiter.flags = flags;
 	get_task_struct(current);
 
 	/* change the lock attempt to a wait --
-- 
1.8.1.2
