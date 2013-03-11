From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v5 41/44] tty: Implement ldsem fast path write lock stealing
Date: Mon, 11 Mar 2013 16:45:01 -0400
Message-ID: <1363034704-28036-42-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
 <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363034704-28036-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Dave Jones <davej@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Michel Lespinasse <walken@google.com>
List-Id: linux-serial@vger.kernel.org

Even with waiting writers, if the lock can be grabbed by
a new writer, simply grab it.

Derived from Michel Lespinasse's write lock stealing work on
rwsem.

Cc: Michel Lespinasse <walken@google.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldsem.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 372e897..fd95950 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -325,7 +325,7 @@ static inline int __ldsem_down_write_nested(struct ld_semaphore *sem,
 
 	count = atomic_long_add_return(LDSEM_WRITE_BIAS,
 				       (atomic_long_t *)&sem->count);
-	if (count != LDSEM_WRITE_BIAS) {
+	if ((count & LDSEM_ACTIVE_MASK) != LDSEM_ACTIVE_BIAS) {
 		lock_stat(sem, contended);
 		if (!down_write_failed(sem, timeout)) {
 			lockdep_release(sem, 1, _RET_IP_);
@@ -380,12 +380,16 @@ int ldsem_down_write_trylock(struct ld_semaphore *sem)
 {
 	long count;
 
-	count = atomic_long_cmpxchg(&sem->count, LDSEM_UNLOCKED,
-				    LDSEM_WRITE_BIAS);
-	if (count == LDSEM_UNLOCKED) {
-		lockdep_acquire(sem, 0, 1, _RET_IP_);
-		lock_stat(sem, acquired);
-		return 1;
+	while (((count = sem->count) & LDSEM_ACTIVE_MASK) == 0) {
+		long tmp;
+
+		tmp = atomic_long_cmpxchg(&sem->count, count,
+					  count + LDSEM_WRITE_BIAS);
+		if (count == tmp) {
+			lockdep_acquire(sem, 0, 1, _RET_IP_);
+			lock_stat(sem, acquired);
+			return 1;
+		}
 	}
 	return 0;
 }
-- 
1.8.1.2
