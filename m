From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 17/23] tty: Document lock requirements to halt ldisc
Date: Tue,  5 Feb 2013 15:20:32 -0500
Message-ID: <1360095638-6624-18-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
 <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Although the tty_lock() - aka legacy_mutex - protects concurrent
close/re-open of the tty->ldisc, the lock cannot be held while
waiting for the line discipline to halt. The ldisc_mutex acts as
a surrogate lock to prevent the ldisc close while waiting for halt.
Unfortunately, to reacquire the tty_lock() requires dropping the
ldisc_mutex to maintain lock order. This accounts for the complicated
sequence of:

	 /* holding tty_lock() for atomic tty operation */

	 mutex_lock();
	 tty_unlock();
	 tty_ldisc_halt();
	 mutex_unlock();

	 tty_lock();
	 mutex_lock();

	 /* check for tty state change which may have occurred
	    while tty_lock() was dropped */

	 /* close old ldisc & open new ldisc */

	 tty_ldisc_enable();

	 mutex_unlock();
	 tty_unlock();

tty_ldisc_release() is exempt from locking the halt, as the only
other possible concurrent user, tty_ldisc_hangup(), checks tty
state to prevent this concurrent use.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index c2837b2..9599b05 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -505,6 +505,9 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
  *
  *	Wait for the line discipline to become idle. The discipline must
  *	have been halted for this to guarantee it remains idle.
+ *
+ *	Callers other than tty_ldisc_release() must hold ->ldisc_mutex and
+ *	cannot be holding tty_lock() (aka legacy_mutex).
  */
 static int tty_ldisc_wait_idle(struct tty_struct *tty, long timeout)
 {
@@ -533,6 +536,9 @@ static int tty_ldisc_wait_idle(struct tty_struct *tty, long timeout)
  *	released, which in turn, guarantees that no future buffer work
  *	can be rescheduled.
  *
+ *	Callers other than tty_ldisc_release() must hold ->ldisc_mutex and
+ *	cannot be holding tty_lock() (aka legacy_mutex).
+ *
  *	You need to do a 'flush_scheduled_work()' (outside the ldisc_mutex)
  *	in order to make sure any currently executing ldisc work is also
  *	flushed.
@@ -713,10 +719,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	retval = tty_ldisc_halt(tty, o_tty, &work, &o_work, 5 * HZ);
 
-	/*
-	 * Wait for hangup to complete, if pending.
-	 * We must drop the mutex here in case a hangup is also in process.
-	 */
+	/* Wait for hangup to complete, if pending. */
 
 	mutex_unlock(&tty->ldisc_mutex);
 
-- 
1.8.1.2
