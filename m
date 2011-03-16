From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 63/76] tty: phase out of ioctl file pointer for tty3270 as well
Date: Wed, 16 Mar 2011 14:12:33 -0700
Message-ID: <1300309966-5745-63-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32946 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754118Ab1CPVPI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:08 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The patch "tty: now phase out the ioctl file pointer for good" missed
the tty3270 driver. This is the missing piece.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/s390/char/keyboard.c |    4 +---
 drivers/s390/char/keyboard.h |    2 +-
 drivers/s390/char/tty3270.c  |   14 ++++++--------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
index 8cd58e4..d667334 100644
--- a/drivers/s390/char/keyboard.c
+++ b/drivers/s390/char/keyboard.c
@@ -455,9 +455,7 @@ do_kdgkb_ioctl(struct kbd_data *kbd, struct kbsentry __user *u_kbs,
 	return 0;
 }
 
-int
-kbd_ioctl(struct kbd_data *kbd, struct file *file,
-	  unsigned int cmd, unsigned long arg)
+int kbd_ioctl(struct kbd_data *kbd, unsigned int cmd, unsigned long arg)
 {
 	void __user *argp;
 	int ct, perm;
diff --git a/drivers/s390/char/keyboard.h b/drivers/s390/char/keyboard.h
index 5ccfe9c..7e736aa 100644
--- a/drivers/s390/char/keyboard.h
+++ b/drivers/s390/char/keyboard.h
@@ -36,7 +36,7 @@ void kbd_free(struct kbd_data *);
 void kbd_ascebc(struct kbd_data *, unsigned char *);
 
 void kbd_keycode(struct kbd_data *, unsigned int);
-int kbd_ioctl(struct kbd_data *, struct file *, unsigned int, unsigned long);
+int kbd_ioctl(struct kbd_data *, unsigned int, unsigned long);
 
 /*
  * Helper Functions.
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 911822db..d33554df 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1718,9 +1718,8 @@ tty3270_wait_until_sent(struct tty_struct *tty, int timeout)
 {
 }
 
-static int
-tty3270_ioctl(struct tty_struct *tty, struct file *file,
-	      unsigned int cmd, unsigned long arg)
+static int tty3270_ioctl(struct tty_struct *tty, unsigned int cmd,
+			 unsigned long arg)
 {
 	struct tty3270 *tp;
 
@@ -1729,13 +1728,12 @@ tty3270_ioctl(struct tty_struct *tty, struct file *file,
 		return -ENODEV;
 	if (tty->flags & (1 << TTY_IO_ERROR))
 		return -EIO;
-	return kbd_ioctl(tp->kbd, file, cmd, arg);
+	return kbd_ioctl(tp->kbd, cmd, arg);
 }
 
 #ifdef CONFIG_COMPAT
-static long
-tty3270_compat_ioctl(struct tty_struct *tty, struct file *file,
-	      unsigned int cmd, unsigned long arg)
+static long tty3270_compat_ioctl(struct tty_struct *tty,
+				 unsigned int cmd, unsigned long arg)
 {
 	struct tty3270 *tp;
 
@@ -1744,7 +1742,7 @@ tty3270_compat_ioctl(struct tty_struct *tty, struct file *file,
 		return -ENODEV;
 	if (tty->flags & (1 << TTY_IO_ERROR))
 		return -EIO;
-	return kbd_ioctl(tp->kbd, file, cmd, (unsigned long)compat_ptr(arg));
+	return kbd_ioctl(tp->kbd, cmd, (unsigned long)compat_ptr(arg));
 }
 #endif
 
-- 
1.7.4.1

