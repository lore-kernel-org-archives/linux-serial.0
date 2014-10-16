From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 17/27] tty: Simplify tty_release() state checks
Date: Thu, 16 Oct 2014 16:25:15 -0400
Message-ID: <1413491125-20134-18-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The local o_tty variable in tty_release() is now accessed only
when closing the pty master.

Set o_tty to slave pty when closing pty master, otherwise NULL;
use o_tty != NULL as replacement for pty_master.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8fedd22..fb043b9 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1758,8 +1758,8 @@ static int tty_release_checks(struct tty_struct *tty, int idx)
 int tty_release(struct inode *inode, struct file *filp)
 {
 	struct tty_struct *tty = file_tty(filp);
-	struct tty_struct *o_tty;
-	int	pty_master, do_sleep, final;
+	struct tty_struct *o_tty = NULL;
+	int	do_sleep, final;
 	int	idx;
 	char	buf[64];
 	long	timeout = 0;
@@ -1774,10 +1774,9 @@ int tty_release(struct inode *inode, struct file *filp)
 	__tty_fasync(-1, filp, 0);
 
 	idx = tty->index;
-	pty_master = (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
-		      tty->driver->subtype == PTY_TYPE_MASTER);
-	/* Review: parallel close */
-	o_tty = tty->link;
+	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
+	    tty->driver->subtype == PTY_TYPE_MASTER)
+		o_tty = tty->link;
 
 	if (tty_release_checks(tty, idx)) {
 		tty_unlock(tty);
@@ -1821,7 +1820,7 @@ int tty_release(struct inode *inode, struct file *filp)
 				do_sleep++;
 			}
 		}
-		if (pty_master && o_tty->count <= 1) {
+		if (o_tty && o_tty->count <= 1) {
 			if (waitqueue_active(&o_tty->read_wait)) {
 				wake_up_poll(&o_tty->read_wait, POLLIN);
 				do_sleep++;
@@ -1846,7 +1845,7 @@ int tty_release(struct inode *inode, struct file *filp)
 			timeout = MAX_SCHEDULE_TIMEOUT;
 	}
 
-	if (pty_master) {
+	if (o_tty) {
 		if (--o_tty->count < 0) {
 			printk(KERN_WARNING "%s: bad pty slave count (%d) for %s\n",
 				__func__, o_tty->count, tty_name(o_tty, buf));
@@ -1880,13 +1879,13 @@ int tty_release(struct inode *inode, struct file *filp)
 	if (!tty->count) {
 		read_lock(&tasklist_lock);
 		session_clear_tty(tty->session);
-		if (pty_master)
+		if (o_tty)
 			session_clear_tty(o_tty->session);
 		read_unlock(&tasklist_lock);
 	}
 
 	/* check whether both sides are closing ... */
-	final = !tty->count && !(pty_master && o_tty->count);
+	final = !tty->count && !(o_tty && o_tty->count);
 
 	tty_unlock_pair(tty, o_tty);
 	/* At this point, the tty->count == 0 should ensure a dead tty
-- 
2.1.1
