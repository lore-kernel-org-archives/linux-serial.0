From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 64/79] tty: Support compat_ioctl get/set termios_locked
Date: Wed, 26 Oct 2011 14:13:09 +0200
Message-ID: <1319631204-23262-64-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32846 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932950Ab1JZMN6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:58 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Thomas Meyer <thomas@m3y3r.de>, Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@google.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Thomas Meyer <thomas@m3y3r.de>

When running a Fedora 15 (x86) on an x86_64 kernel, in the boot process
plymouthd complains about those two missing ioctls:
[    2.581783] ioctl32(plymouthd:186): Unknown cmd fd(10) cmd(00005457){t:'T';sz:0} arg(ffb6a5d0) on /dev/tty1
[    2.581803] ioctl32(plymouthd:186): Unknown cmd fd(10) cmd(00005456){t:'T';sz:0} arg(ffb6a680) on /dev/tty1

both ioctl functions work on the 'struct termios' resp. 'struct termios2',
which has the same size (36 bytes resp. 44 bytes) on x86 and x86_64,
so it's just a matter of converting the pointer from userland.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_io.c    |    2 ++
 drivers/tty/tty_ioctl.c |   17 +++++++++++++++++
 include/linux/tty.h     |    2 ++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 150e4f7..4ca4bcd 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2717,6 +2717,8 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 	ld = tty_ldisc_ref_wait(tty);
 	if (ld->ops->compat_ioctl)
 		retval = ld->ops->compat_ioctl(tty, file, cmd, arg);
+	else
+		retval = n_tty_compat_ioctl_helper(tty, file, cmd, arg);
 	tty_ldisc_deref(ld);
 
 	return retval;
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 53f2442..9314d93 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/mutex.h>
+#include <linux/compat.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1179,3 +1180,19 @@ int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 	}
 }
 EXPORT_SYMBOL(n_tty_ioctl_helper);
+
+#ifdef CONFIG_COMPAT
+long n_tty_compat_ioctl_helper(struct tty_struct *tty, struct file *file,
+					unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case TIOCGLCKTRMIOS:
+	case TIOCSLCKTRMIOS:
+		return tty_mode_ioctl(tty, file, cmd, (unsigned long) compat_ptr(arg));
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+EXPORT_SYMBOL(n_tty_compat_ioctl_helper);
+#endif
+
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 0ad6888..64c12a3 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -579,6 +579,8 @@ extern int __init tty_init(void);
 /* tty_ioctl.c */
 extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 		       unsigned int cmd, unsigned long arg);
+extern long n_tty_compat_ioctl_helper(struct tty_struct *tty, struct file *file,
+		       unsigned int cmd, unsigned long arg);
 
 /* serial.c */
 
-- 
1.7.7

