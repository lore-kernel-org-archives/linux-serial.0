From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 41/76] tty: add TIOCVHANGUP to allow clean tty shutdown of all ttys
Date: Wed, 16 Mar 2011 14:12:11 -0700
Message-ID: <1300309966-5745-41-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33056 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754879Ab1CPVOP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:15 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>, Greg Kroah-Hartman <gregkh@suse.de>

From: Kay Sievers <kay.sievers@vrfy.org>

This is useful for system management software so that it can kick
off things like gettys and everything that's started from a tty,
before we reuse it from/for something else or shut it down.

Without this ioctl it would have to temporarily become the owner of
the tty, then call vhangup() and then give it up again.

Cc: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/alpha/include/asm/ioctls.h   |    1 +
 arch/mips/include/asm/ioctls.h    |    1 +
 arch/parisc/include/asm/ioctls.h  |    1 +
 arch/powerpc/include/asm/ioctls.h |    1 +
 arch/sh/include/asm/ioctls.h      |    1 +
 arch/sparc/include/asm/ioctls.h   |    1 +
 arch/xtensa/include/asm/ioctls.h  |    1 +
 drivers/tty/tty_io.c              |    5 +++++
 include/asm-generic/ioctls.h      |    1 +
 9 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/alpha/include/asm/ioctls.h b/arch/alpha/include/asm/ioctls.h
index 034b6cf..80e1cee 100644
--- a/arch/alpha/include/asm/ioctls.h
+++ b/arch/alpha/include/asm/ioctls.h
@@ -94,6 +94,7 @@
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
+#define TIOCVHANGUP	0x5437
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff --git a/arch/mips/include/asm/ioctls.h b/arch/mips/include/asm/ioctls.h
index d967b89..92403c3 100644
--- a/arch/mips/include/asm/ioctls.h
+++ b/arch/mips/include/asm/ioctls.h
@@ -85,6 +85,7 @@
 #define TIOCSPTLCK	_IOW('T', 0x31, int)  /* Lock/unlock Pty */
 #define TIOCGDEV	_IOR('T', 0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T', 0x36, int)  /* Generate signal on Pty slave */
+#define TIOCVHANGUP	0x5437
 
 /* I hope the range from 0x5480 on is free ... */
 #define TIOCSCTTY	0x5480		/* become controlling tty */
diff --git a/arch/parisc/include/asm/ioctls.h b/arch/parisc/include/asm/ioctls.h
index 6ba80d0..054ec06 100644
--- a/arch/parisc/include/asm/ioctls.h
+++ b/arch/parisc/include/asm/ioctls.h
@@ -54,6 +54,7 @@
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TIOCGDEV	_IOR('T',0x32, int)  /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
+#define TIOCVHANGUP	0x5437
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff --git a/arch/powerpc/include/asm/ioctls.h b/arch/powerpc/include/asm/ioctls.h
index c7dc17c..e9b7887 100644
--- a/arch/powerpc/include/asm/ioctls.h
+++ b/arch/powerpc/include/asm/ioctls.h
@@ -96,6 +96,7 @@
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
+#define TIOCVHANGUP	0x5437
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff --git a/arch/sh/include/asm/ioctls.h b/arch/sh/include/asm/ioctls.h
index 84e85a7..a6769f3 100644
--- a/arch/sh/include/asm/ioctls.h
+++ b/arch/sh/include/asm/ioctls.h
@@ -87,6 +87,7 @@
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
+#define TIOCVHANGUP	_IO('T', 0x37)
 
 #define TIOCSERCONFIG	_IO('T', 83) /* 0x5453 */
 #define TIOCSERGWILD	_IOR('T', 84,  int) /* 0x5454 */
diff --git a/arch/sparc/include/asm/ioctls.h b/arch/sparc/include/asm/ioctls.h
index ed3807b..28d0c8b 100644
--- a/arch/sparc/include/asm/ioctls.h
+++ b/arch/sparc/include/asm/ioctls.h
@@ -20,6 +20,7 @@
 #define TCSETSW2	_IOW('T', 14, struct termios2)
 #define TCSETSF2	_IOW('T', 15, struct termios2)
 #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
+#define TIOCVHANGUP	_IO('T', 0x37)
 
 /* Note that all the ioctls that are not available in Linux have a 
  * double underscore on the front to: a) avoid some programs to
diff --git a/arch/xtensa/include/asm/ioctls.h b/arch/xtensa/include/asm/ioctls.h
index ccf1800..fd1d136 100644
--- a/arch/xtensa/include/asm/ioctls.h
+++ b/arch/xtensa/include/asm/ioctls.h
@@ -100,6 +100,7 @@
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
 #define TIOCSIG		_IOW('T',0x36, int)  /* Generate signal on Pty slave */
+#define TIOCVHANGUP	_IO('T', 0x37)
 
 #define TIOCSERCONFIG	_IO('T', 83)
 #define TIOCSERGWILD	_IOR('T', 84,  int)
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 20a862a..8ef2d69 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2626,6 +2626,11 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return put_user(tty->ldisc->ops->num, (int __user *)p);
 	case TIOCSETD:
 		return tiocsetd(tty, p);
+	case TIOCVHANGUP:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		tty_vhangup(tty);
+		return 0;
 	case TIOCGDEV:
 	{
 		unsigned int ret = new_encode_dev(tty_devnum(real_tty));
diff --git a/include/asm-generic/ioctls.h b/include/asm-generic/ioctls.h
index 3f3f2d1..199975f 100644
--- a/include/asm-generic/ioctls.h
+++ b/include/asm-generic/ioctls.h
@@ -73,6 +73,7 @@
 #define TCSETXF		0x5434
 #define TCSETXW		0x5435
 #define TIOCSIG		_IOW('T', 0x36, int)  /* pty: generate signal */
+#define TIOCVHANGUP	0x5437
 
 #define FIONCLEX	0x5450
 #define FIOCLEX		0x5451
-- 
1.7.4.1

