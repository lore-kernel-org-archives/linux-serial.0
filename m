From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 05/32] tty: Remove unnecessary re-test of ldisc ref count
Date: Wed, 20 Feb 2013 15:02:52 -0500
Message-ID: <1361390599-15195-6-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
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
index c5b848a..fa0170e 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -558,29 +558,29 @@ static int tty_ldisc_wait_idle(struct tty_struct *tty, long timeout)
  *	have been halted for this to guarantee it remains idle.
  *
  *	Caller must hold legacy and ->ldisc_mutex.
+ *
+ *	NB: tty_set_ldisc() is prevented from changing the ldisc concurrently
+ *	with this function by checking the TTY_HUPPING flag.
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
 	return !!tty->ldisc;
 }
-- 
1.8.1.2
