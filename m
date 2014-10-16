From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 11/27] tty: Don't release tty locks for wait queue sanity check
Date: Thu, 16 Oct 2014 16:25:09 -0400
Message-ID: <1413491125-20134-12-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Releasing the tty locks while waiting for the tty wait queues to
be empty is no longer necessary nor desirable. Prior to
"tty: Don't take tty_mutex for tty count changes", dropping the
tty locks was necessary to reestablish the correct lock order between
tty_mutex and the tty locks. Dropping the global tty_mutex was necessary;
otherwise new ttys could not have been opened while waiting.

However, without needing the global tty_mutex held, the tty locks for
the releasing tty can now be held through the sleep. The sanity check
is for abnormal conditions caused by kernel bugs, not for recoverable
errors caused by misbehaving userspace; dropping the tty locks only
allows the tty state to get more sideways.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7b40247..50118ce 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1799,13 +1799,10 @@ int tty_release(struct inode *inode, struct file *filp)
 	 * first, its count will be one, since the master side holds an open.
 	 * Thus this test wouldn't be triggered at the time the slave closes,
 	 * so we do it now.
-	 *
-	 * Note that it's possible for the tty to be opened again while we're
-	 * flushing out waiters.  By recalculating the closing flags before
-	 * each iteration we avoid any problems.
 	 */
+	tty_lock_pair(tty, o_tty);
+
 	while (1) {
-		tty_lock_pair(tty, o_tty);
 		tty_closing = tty->count <= 1;
 		o_tty_closing = o_tty &&
 			(o_tty->count <= (pty_master ? 1 : 0));
@@ -1839,7 +1836,6 @@ int tty_release(struct inode *inode, struct file *filp)
 			printk(KERN_WARNING "%s: %s: read/write wait queue active!\n",
 			       __func__, tty_name(tty, buf));
 		}
-		tty_unlock_pair(tty, o_tty);
 		schedule_timeout_killable(timeout);
 		if (timeout < 120 * HZ)
 			timeout = 2 * timeout + 1;
-- 
2.1.1
