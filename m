From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 07/11] tty: Remove unnecessary re-test of ldisc ref count
Date: Fri, 14 Dec 2012 13:22:46 -0500
Message-ID: <1355509370-5883-8-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ilya Zykov <ilya@ilyx.ru>, Sasha Levin <levinsasha928@gmail.com>, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Since the tty->ldisc is prevented from being changed by tty_set_ldisc()
when a tty is being hung up, re-testing the ldisc user count is
unnecessary -- ie, it cannot be a different ldisc and the user count
cannot have increased (assuming the caller meets the precondition that
TTY_LDISC flag is cleared)

Removal of the 'early-out' locking optimization is necessary for
the subsequent patch 'tty: Fix ldisc halt sequence on hangup'.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 6c1d8aa..0d18d1e 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -556,29 +556,29 @@ static int tty_ldisc_halt(struct tty_struct *tty)
  *	have been halted for this to guarantee it remains idle.
  *
  *	Caller must hold legacy and ->ldisc_mutex.
+ *
+ *	NB: tty_set_ldisc() is prevented from changing the ldisc concurrently
+ *	with this function when it checks the TTY_HUPPING state.
  */
 static bool tty_ldisc_hangup_wait_idle(struct tty_struct *tty)
 {
-	while (tty->ldisc) {	/* Not yet closed */
-		if (atomic_read(&tty->ldisc->users) != 1) {
-			char cur_n[TASK_COMM_LEN], tty_n[64];
-			long timeout = 3 * HZ;
-			tty_unlock(tty);
-
-			while (tty_ldisc_wait_idle(tty, timeout) == -EBUSY) {
-				timeout = MAX_SCHEDULE_TIMEOUT;
-				printk_ratelimited(KERN_WARNING
-					"%s: waiting (%s) for %s took too long, but we keep waiting...\n",
-					__func__, get_task_comm(cur_n, current),
-					tty_name(tty, tty_n));
-			}
-			/* must reacquire both locks and preserve lock order */
-			mutex_unlock(&tty->ldisc_mutex);
-			tty_lock(tty);
-			mutex_lock(&tty->ldisc_mutex);
-			continue;
+	char cur_n[TASK_COMM_LEN], tty_n[64];
+	long timeout = 3 * HZ;
+
+	if (tty->ldisc) {	/* Not yet closed */
+		tty_unlock(tty);
+
+		while (tty_ldisc_wait_idle(tty, timeout) == -EBUSY) {
+			timeout = MAX_SCHEDULE_TIMEOUT;
+			printk_ratelimited(KERN_WARNING
+				"%s: waiting (%s) for %s took too long, but we keep waiting...\n",
+				__func__, get_task_comm(cur_n, current),
+				tty_name(tty, tty_n));
 		}
-		break;
+		/* must reacquire both locks and preserve lock order */
+		mutex_unlock(&tty->ldisc_mutex);
+		tty_lock(tty);
+		mutex_lock(&tty->ldisc_mutex);
 	}
 	return !!(tty->ldisc);
 }
-- 
1.8.0.1
