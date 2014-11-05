From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next v2 03/26] tty: Remove TTY_HUPPING
Date: Wed,  5 Nov 2014 12:12:46 -0500
Message-ID: <1415207589-15967-4-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
 <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415207589-15967-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Now that tty_ldisc_hangup() does not drop the tty lock, it is no
longer possible to observe TTY_HUPPING while holding the tty lock
on another cpu.

Remove TTY_HUPPING bit definition.

Reviewed-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c    | 12 +-----------
 drivers/tty/tty_ldisc.c |  3 +--
 include/linux/tty.h     |  1 -
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 45cc09e..bb4d2f2 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -690,9 +690,6 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 		return;
 	}
 
-	/* some functions below drop BTM, so we need this bit */
-	set_bit(TTY_HUPPING, &tty->flags);
-
 	/* inuse_filps is protected by the single tty lock,
 	   this really needs to change if we want to flush the
 	   workqueue with the lock held */
@@ -717,10 +714,6 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 	while (refs--)
 		tty_kref_put(tty);
 
-	/*
-	 * it drops BTM and thus races with reopen
-	 * we protect the race by TTY_HUPPING
-	 */
 	tty_ldisc_hangup(tty);
 
 	spin_lock_irq(&tty->ctrl_lock);
@@ -752,8 +745,6 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 	 * can't yet guarantee all that.
 	 */
 	set_bit(TTY_HUPPED, &tty->flags);
-	clear_bit(TTY_HUPPING, &tty->flags);
-
 	tty_unlock(tty);
 
 	if (f)
@@ -1461,8 +1452,7 @@ static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
 
-	if (test_bit(TTY_CLOSING, &tty->flags) ||
-			test_bit(TTY_HUPPING, &tty->flags))
+	if (test_bit(TTY_CLOSING, &tty->flags))
 		return -EIO;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 28858eb..49001fa 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -544,8 +544,7 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
 
 	old_ldisc = tty->ldisc;
 
-	if (test_bit(TTY_HUPPING, &tty->flags) ||
-	    test_bit(TTY_HUPPED, &tty->flags)) {
+	if (test_bit(TTY_HUPPED, &tty->flags)) {
 		/* We were raced by the hangup method. It will have stomped
 		   the ldisc data and closed the ldisc down */
 		tty_ldisc_enable_pair(tty, o_tty);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index b36b0b4..ff0dd7a 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -321,7 +321,6 @@ struct tty_file_private {
 #define TTY_PTY_LOCK 		16	/* pty private */
 #define TTY_NO_WRITE_SPLIT 	17	/* Preserve write boundaries to driver */
 #define TTY_HUPPED 		18	/* Post driver->hangup() */
-#define TTY_HUPPING 		21	/* ->hangup() in progress */
 #define TTY_LDISC_HALTED	22	/* Line discipline is halted */
 
 #define TTY_WRITE_FLUSH(tty) tty_write_flush((tty))
-- 
2.1.3
