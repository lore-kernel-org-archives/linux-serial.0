From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next v2 24/26] tty: Fix hung task on pty hangup
Date: Wed,  5 Nov 2014 12:13:07 -0500
Message-ID: <1415207589-15967-25-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
 <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

When hanging up one end of a pty pair, there may be waiting
readers/writers on the other end which may not exit, preventing
tty_ldisc_lock_pair() from acquiring the other side's ldisc lock.

Only acquire this side's ldisc lock; although this will no longer
prevent the other side from writing new input, that input will not
be processing until after the ldisc hangup is complete.

Reported-by: Sasha Levin <sasha.levin@oracle.com>
Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ldisc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 5bdc241..1dbe278 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -326,6 +326,24 @@ static inline void __tty_ldisc_unlock(struct tty_struct *tty)
 }
 
 static int __lockfunc
+tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout)
+{
+	int ret;
+
+	ret = __tty_ldisc_lock(tty, timeout);
+	if (!ret)
+		return -EBUSY;
+	set_bit(TTY_LDISC_HALTED, &tty->flags);
+	return 0;
+}
+
+static void tty_ldisc_unlock(struct tty_struct *tty)
+{
+	clear_bit(TTY_LDISC_HALTED, &tty->flags);
+	__tty_ldisc_unlock(tty);
+}
+
+static int __lockfunc
 tty_ldisc_lock_pair_timeout(struct tty_struct *tty, struct tty_struct *tty2,
 			    unsigned long timeout)
 {
@@ -682,7 +700,7 @@ void tty_ldisc_hangup(struct tty_struct *tty)
 	 *
 	 * Avoid racing set_ldisc or tty_ldisc_release
 	 */
-	tty_ldisc_lock_pair(tty, tty->link);
+	tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
 
 	if (tty->ldisc) {
 
@@ -704,7 +722,7 @@ void tty_ldisc_hangup(struct tty_struct *tty)
 			WARN_ON(tty_ldisc_open(tty, tty->ldisc));
 		}
 	}
-	tty_ldisc_enable_pair(tty, tty->link);
+	tty_ldisc_unlock(tty);
 	if (reset)
 		tty_reset_termios(tty);
 
-- 
2.1.3
