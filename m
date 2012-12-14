From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 06/11] tty: Refactor wait for ldisc refs out of tty_ldisc_hangup()
Date: Fri, 14 Dec 2012 13:22:45 -0500
Message-ID: <1355509370-5883-7-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ilya Zykov <ilya@ilyx.ru>, Sasha Levin <levinsasha928@gmail.com>, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Refactor tty_ldisc_hangup() to extract standalone function,
tty_ldisc_hangup_wait_idle(), to wait for ldisc references
to be released.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 54 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index f986bb0..6c1d8aa 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -549,6 +549,41 @@ static int tty_ldisc_halt(struct tty_struct *tty)
 }
 
 /**
+ *	tty_ldisc_hangup_wait_idle - wait for the ldisc to become idle
+ *	@tty: tty to wait for
+ *
+ *	Wait for the line discipline to become idle. The discipline must
+ *	have been halted for this to guarantee it remains idle.
+ *
+ *	Caller must hold legacy and ->ldisc_mutex.
+ */
+static bool tty_ldisc_hangup_wait_idle(struct tty_struct *tty)
+{
+	while (tty->ldisc) {	/* Not yet closed */
+		if (atomic_read(&tty->ldisc->users) != 1) {
+			char cur_n[TASK_COMM_LEN], tty_n[64];
+			long timeout = 3 * HZ;
+			tty_unlock(tty);
+
+			while (tty_ldisc_wait_idle(tty, timeout) == -EBUSY) {
+				timeout = MAX_SCHEDULE_TIMEOUT;
+				printk_ratelimited(KERN_WARNING
+					"%s: waiting (%s) for %s took too long, but we keep waiting...\n",
+					__func__, get_task_comm(cur_n, current),
+					tty_name(tty, tty_n));
+			}
+			/* must reacquire both locks and preserve lock order */
+			mutex_unlock(&tty->ldisc_mutex);
+			tty_lock(tty);
+			mutex_lock(&tty->ldisc_mutex);
+			continue;
+		}
+		break;
+	}
+	return !!(tty->ldisc);
+}
+
+/**
  *	tty_set_ldisc		-	set line discipline
  *	@tty: the terminal to set
  *	@ldisc: the line discipline
@@ -824,7 +859,6 @@ void tty_ldisc_hangup(struct tty_struct *tty)
 	cancel_work_sync(&tty->port->buf.work);
 	set_bit(TTY_LDISC_HALTED, &tty->flags);
 	mutex_unlock(&tty->ldisc_mutex);
-retry:
 	tty_lock(tty);
 	mutex_lock(&tty->ldisc_mutex);
 
@@ -832,23 +866,7 @@ retry:
 	   reopen it. We could defer this to the next open but
 	   it means auditing a lot of other paths so this is
 	   a FIXME */
-	if (tty->ldisc) {	/* Not yet closed */
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
-			mutex_unlock(&tty->ldisc_mutex);
-			goto retry;
-		}
-
+	if (tty_ldisc_hangup_wait_idle(tty)) {
 		if (reset == 0) {
 
 			if (!tty_ldisc_reinit(tty, tty->termios.c_line))
-- 
1.8.0.1
