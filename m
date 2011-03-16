From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 39/76] tty: add a helper for setting termios data from kernel side
Date: Wed, 16 Mar 2011 14:12:09 -0700
Message-ID: <1300309966-5745-39-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33007 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754856Ab1CPVOH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:07 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Alan Cox <alan@linux.intel.com>

This basically encapsulates the small bit of locking knowledge needed. While
we are at it make sure we blow up on any more abusers and unsafe misuses of
ioctl for this kind of stuff.

We change the function to return an argument as at some point it needs to
honour the POSIX 'I asked for changes but got none of them' error reporting
corner case.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_ioctl.c |   14 +++++++++-----
 include/linux/tty.h     |    1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 0c18899..1a1135d 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -486,7 +486,7 @@ int tty_termios_hw_change(struct ktermios *a, struct ktermios *b)
 EXPORT_SYMBOL(tty_termios_hw_change);
 
 /**
- *	change_termios		-	update termios values
+ *	tty_set_termios		-	update termios values
  *	@tty: tty to update
  *	@new_termios: desired new value
  *
@@ -497,7 +497,7 @@ EXPORT_SYMBOL(tty_termios_hw_change);
  *	Locking: termios_mutex
  */
 
-static void change_termios(struct tty_struct *tty, struct ktermios *new_termios)
+int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 {
 	struct ktermios old_termios;
 	struct tty_ldisc *ld;
@@ -553,7 +553,9 @@ static void change_termios(struct tty_struct *tty, struct ktermios *new_termios)
 		tty_ldisc_deref(ld);
 	}
 	mutex_unlock(&tty->termios_mutex);
+	return 0;
 }
+EXPORT_SYMBOL_GPL(tty_set_termios);
 
 /**
  *	set_termios		-	set termios values for a tty
@@ -562,7 +564,7 @@ static void change_termios(struct tty_struct *tty, struct ktermios *new_termios)
  *	@opt: option information
  *
  *	Helper function to prepare termios data and run necessary other
- *	functions before using change_termios to do the actual changes.
+ *	functions before using tty_set_termios to do the actual changes.
  *
  *	Locking:
  *		Called functions take ldisc and termios_mutex locks
@@ -620,7 +622,7 @@ static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 			return -EINTR;
 	}
 
-	change_termios(tty, &tmp_termios);
+	tty_set_termios(tty, &tmp_termios);
 
 	/* FIXME: Arguably if tmp_termios == tty->termios AND the
 	   actual requested termios was not tmp_termios then we may
@@ -797,7 +799,7 @@ static int set_sgttyb(struct tty_struct *tty, struct sgttyb __user *sgttyb)
 						termios.c_ospeed);
 #endif
 	mutex_unlock(&tty->termios_mutex);
-	change_termios(tty, &termios);
+	tty_set_termios(tty, &termios);
 	return 0;
 }
 #endif
@@ -951,6 +953,8 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 	int ret = 0;
 	struct ktermios kterm;
 
+	BUG_ON(file == NULL);
+
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver->subtype == PTY_TYPE_MASTER)
 		real_tty = tty->link;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index ef1e012..4e53d464 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -448,6 +448,7 @@ extern void tty_encode_baud_rate(struct tty_struct *tty,
 						speed_t ibaud, speed_t obaud);
 extern void tty_termios_copy_hw(struct ktermios *new, struct ktermios *old);
 extern int tty_termios_hw_change(struct ktermios *a, struct ktermios *b);
+extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);
-- 
1.7.4.1

