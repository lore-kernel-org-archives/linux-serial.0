From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/12] TTY: pty, fix pty counting
Date: Fri, 26 Aug 2011 13:58:19 -0700
Message-ID: <1314392301-25140-10-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
 <1314392301-25140-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37796 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774Ab1HZU7I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:59:08 -0400
In-Reply-To: <1314392301-25140-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

tty_operations->remove is normally called like:
queue_release_one_tty
 ->tty_shutdown
   ->tty_driver_remove_tty
     ->tty_operations->remove

However tty_shutdown() is called from queue_release_one_tty() only if
tty_operations->shutdown is NULL. But for pty, it is not.
pty_unix98_shutdown() is used there as ->shutdown.

So tty_operations->remove of pty (i.e. pty_unix98_remove()) is never
called. This results in invalid pty_count. I.e. what can be seen in
/proc/sys/kernel/pty/nr.

I see this was already reported at:
  https://lkml.org/lkml/2009/11/5/370
But it was not fixed since then.

This patch is kind of a hackish way. The problem lies in ->install. We
allocate there another tty (so-called tty->link). So ->install is
called once, but ->remove twice, for both tty and tty->link. The fix
here is to count both tty and tty->link and divide the count by 2 for
user.

And to have ->remove called, let's make tty_driver_remove_tty() global
and call that from pty_unix98_shutdown() (tty_operations->shutdown).

While at it, let's document that when ->shutdown is defined,
tty_shutdown() is not called.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/pty.c          |   17 +++++++++++++++--
 drivers/tty/tty_io.c       |    3 +--
 include/linux/tty.h        |    2 ++
 include/linux/tty_driver.h |    3 +++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 98b6e3b..e809e9d 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -446,8 +446,19 @@ static inline void legacy_pty_init(void) { }
 int pty_limit = NR_UNIX98_PTY_DEFAULT;
 static int pty_limit_min;
 static int pty_limit_max = NR_UNIX98_PTY_MAX;
+static int tty_count;
 static int pty_count;
 
+static inline void pty_inc_count(void)
+{
+	pty_count = (++tty_count) / 2;
+}
+
+static inline void pty_dec_count(void)
+{
+	pty_count = (--tty_count) / 2;
+}
+
 static struct cdev ptmx_cdev;
 
 static struct ctl_table pty_table[] = {
@@ -542,6 +553,7 @@ static struct tty_struct *pts_unix98_lookup(struct tty_driver *driver,
 
 static void pty_unix98_shutdown(struct tty_struct *tty)
 {
+	tty_driver_remove_tty(tty->driver, tty);
 	/* We have our own method as we don't use the tty index */
 	kfree(tty->termios);
 }
@@ -588,7 +600,8 @@ static int pty_unix98_install(struct tty_driver *driver, struct tty_struct *tty)
 	 */
 	tty_driver_kref_get(driver);
 	tty->count++;
-	pty_count++;
+	pty_inc_count(); /* tty */
+	pty_inc_count(); /* tty->link */
 	return 0;
 err_free_mem:
 	deinitialize_tty_struct(o_tty);
@@ -602,7 +615,7 @@ err_free_tty:
 
 static void pty_unix98_remove(struct tty_driver *driver, struct tty_struct *tty)
 {
-	pty_count--;
+	pty_dec_count();
 }
 
 static const struct tty_operations ptm_unix98_ops = {
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 150e4f7..4f1fc81 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1295,8 +1295,7 @@ static int tty_driver_install_tty(struct tty_driver *driver,
  *
  *	Locking: tty_mutex for now
  */
-static void tty_driver_remove_tty(struct tty_driver *driver,
-						struct tty_struct *tty)
+void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *tty)
 {
 	if (driver->ops->remove)
 		driver->ops->remove(driver, tty);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 44bc0c5..5f2ede8 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -421,6 +421,8 @@ extern void tty_driver_flush_buffer(struct tty_struct *tty);
 extern void tty_throttle(struct tty_struct *tty);
 extern void tty_unthrottle(struct tty_struct *tty);
 extern int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
+extern void tty_driver_remove_tty(struct tty_driver *driver,
+				  struct tty_struct *tty);
 extern void tty_shutdown(struct tty_struct *tty);
 extern void tty_free_termios(struct tty_struct *tty);
 extern int is_current_pgrp_orphaned(void);
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 9deeac8..ecdaeb9 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -47,6 +47,9 @@
  *
  * 	This routine is called synchronously when a particular tty device
  *	is closed for the last time freeing up the resources.
+ *	Note that tty_shutdown() is not called if ops->shutdown is defined.
+ *	This means one is responsible to take care of calling ops->remove (e.g.
+ *	via tty_driver_remove_tty) and releasing tty->termios.
  *
  *
  * void (*cleanup)(struct tty_struct * tty);
-- 
1.7.6.1

