From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [REPOST-v2] sched: Prevent wakeup to enter critical section needlessly
Date: Mon, 19 Nov 2012 08:30:11 +0100
Message-ID: <1353310211-3011-1-git-send-email-meltedpianoman@gmail.com>
References: <1351159974-980-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:38302
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751620Ab2KSHac (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Nov 2012 02:30:32 -0500
In-Reply-To: <1351159974-980-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, Ivo Sieben <meltedpianoman@gmail.com>

Check the waitqueue task list to be non empty before entering the critical
section. This prevents locking the spin lock needlessly in case the queue
was empty, and therefor also prevent scheduling overhead on a PREEMPT_RT
system.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---

 a second repost of this patch v2: Can anyone respond?
 Did I apply the memory barrier correct?

 v2:
 - We don't need the "careful" list empty, a normal list empty is sufficient:
   if you miss an update it was just as it happened a little later.
 - Because of memory ordering problems we can observe an unupdated list
   administration. This can cause an wait_event-like code to miss an event.
   Adding a memory barrier befor checking the list to be empty will guarantee we
   evaluate a 100% updated list adminsitration.

 kernel/sched/core.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d8927f..168a9b2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3090,9 +3090,22 @@ void __wake_up(wait_queue_head_t *q, unsigned int mode,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&q->lock, flags);
-	__wake_up_common(q, mode, nr_exclusive, 0, key);
-	spin_unlock_irqrestore(&q->lock, flags);
+	/*
+	 * We check for list emptiness outside the lock. This prevents the wake
+	 * up to enter the critical section needlessly when the task list is
+	 * empty.
+	 *
+	 * Placed a full memory barrier before checking list emptiness to make
+	 * 100% sure this function sees an up-to-date list administration.
+	 * Note that other code that manipulates the list uses a spin_lock and
+	 * therefore doesn't need additional memory barriers.
+	 */
+	smp_mb();
+	if (!list_empty(&q->task_list)) {
+		spin_lock_irqsave(&q->lock, flags);
+		__wake_up_common(q, mode, nr_exclusive, 0, key);
+		spin_unlock_irqrestore(&q->lock, flags);
+	}
 }
 EXPORT_SYMBOL(__wake_up);
 
-- 
1.7.9.5


