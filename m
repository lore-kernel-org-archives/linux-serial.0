From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH] tty: Only wakeup the line discipline idle queue when queue is active
Date: Tue, 18 Dec 2012 15:48:50 +0100
Message-ID: <1355842130-15482-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:50207
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932095Ab2LROs7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Dec 2012 09:48:59 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Ivo Sieben <meltedpianoman@gmail.com>

Before waking up the tty line discipline idle queue first check if the queue is
active (non empty). This prevents unnecessary entering the critical section in
the wake_up() function and therefore avoid needless scheduling overhead on a
PREEMPT_RT system caused by two processes being in the same critical section.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---

 Remark:
 This patch has kind of a long history... I first tried to prevent the critical
 section in the wakeup() function itself by a change in the scheduler. But after
 review remarks from Oleg Nesterov it turned out that using the
 waitqueue_active() was a much nicer way to prevent it. See also
 https://lkml.org/lkml/2012/10/25/159

 drivers/tty/tty_ldisc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index c578229..e96d187 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -64,7 +64,9 @@ static void put_ldisc(struct tty_ldisc *ld)
 		return;
 	}
 	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
-	wake_up(&ld->wq_idle);
+
+	if (waitqueue_active(&ld->wq_idle))
+		wake_up(&ld->wq_idle);
 }
 
 /**
-- 
1.7.9.5


