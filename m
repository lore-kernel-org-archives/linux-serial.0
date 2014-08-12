From: Alan Cox <alan@linux.intel.com>
Subject: [RFC 1/3] tty: Add RS485 helper functions
Date: Tue, 12 Aug 2014 16:01:20 +0100
Message-ID: <20140812150104.13378.24152.stgit@acox1-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28294 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203AbaHLPCI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Aug 2014 11:02:08 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

From: Alan <gnomes@lxorguk.ukuu.org.uk>

This follows the pattern of moving repeatedly occuring ioctl helpers into
common code where possible. We want things like user space copies to be done
in one place.

We allow the existing ioctl fall through to continue working. Old drivers
will not be affected and can be cleaned up in later patches.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/tty_ioctl.c    |   46 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/tty.h        |    1 +
 include/linux/tty_driver.h |   11 +++++++++++
 3 files changed, 58 insertions(+)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 6fd60fe..7f50d6e 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/mutex.h>
 #include <linux/compat.h>
+#include <linux/serial.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -968,6 +969,26 @@ static int tty_change_softcar(struct tty_struct *tty, int arg)
 }
 
 /**
+ *	tty_set_rs485		-	set RS485 related parameters
+ *	@tty: tty for the ioctl
+ *	@rs485: rs485 parameter block
+ *
+ *	Perform a change to the RS485 settings. This uses the termios
+ *	sem as often termios and rs485 interact
+ */
+
+static int tty_set_rs485(struct tty_struct *tty, struct serial_rs485 *rs485)
+{
+	int ret = -EOPNOTSUPP;
+
+	down_write(&tty->termios_rwsem);
+	if (tty->rs485 && tty->ops->set_rs485)
+		ret = tty->ops->set_rs485(tty, rs485);
+	up_write(&tty->termios_rwsem);
+	return ret;
+}
+
+/**
  *	tty_mode_ioctl		-	mode related ioctls
  *	@tty: tty for the ioctl
  *	@file: file pointer for the tty
@@ -1116,6 +1137,31 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 		if (get_user(arg, (unsigned int __user *) arg))
 			return -EFAULT;
 		return tty_change_softcar(real_tty, arg);
+	case TIOCGRS485: {
+		struct serial_rs485 rs485;
+
+		if (tty->rs485) {
+			down_read(&real_tty->termios_rwsem);
+			memcpy(&rs485, tty->rs485, sizeof(rs485));
+			up_read(&real_tty->termios_rwsem);
+			if (copy_to_user(p, &rs485, sizeof(rs485)))
+				ret = -EFAULT;
+			return ret;
+		}
+		/* For now fall through to legacy handling */
+		return -ENOIOCTLCMD;
+	}
+	case TIOCSRS485: {
+		struct serial_rs485 rs485;
+
+		if (tty->rs485) {
+			if (copy_from_user(&rs485, p, sizeof(rs485)))
+				return -EFAULT;
+			return tty_set_rs485(tty, &rs485);
+		}
+		/* For now fall through to legacy handling */
+		return -ENOIOCTLCMD;
+	}
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 8413294..310831f 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -255,6 +255,7 @@ struct tty_struct {
 	/* Termios values are protected by the termios rwsem */
 	struct ktermios termios, termios_locked;
 	struct termiox *termiox;	/* May be NULL for unsupported */
+	struct serial_rs485 *rs485;	/* May be NULL for unsupported */
 	char name[64];
 	struct pid *pgrp;		/* Protected by ctrl lock */
 	struct pid *session;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index e48c608..5a8a566 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -232,6 +232,15 @@
  *	Called when the device receives a TIOCGICOUNT ioctl. Passed a kernel
  *	structure to complete. This method is optional and will only be called
  *	if provided (otherwise EINVAL will be returned).
+ *
+ * int (*set_rs485)(struct tty_struct *tty, serial_rs485 *new);
+ *
+ *	Called when the device receives an RS485 ioctl. Passes down
+ *	the requested data from user space. This method will not be invoked
+ *	unless the tty also has a valid tty->rs485 pointer.
+ *
+ *	Optional: Called under the termios lock
+ *
  */
 
 #include <linux/export.h>
@@ -243,6 +252,7 @@
 struct tty_struct;
 struct tty_driver;
 struct serial_icounter_struct;
+struct serial_rs485;
 
 struct tty_operations {
 	struct tty_struct * (*lookup)(struct tty_driver *driver,
@@ -279,6 +289,7 @@ struct tty_operations {
 			unsigned int set, unsigned int clear);
 	int (*resize)(struct tty_struct *tty, struct winsize *ws);
 	int (*set_termiox)(struct tty_struct *tty, struct termiox *tnew);
+	int (*set_rs485)(struct tty_struct *tty, struct serial_rs485 *rs485);
 	int (*get_icount)(struct tty_struct *tty,
 				struct serial_icounter_struct *icount);
 #ifdef CONFIG_CONSOLE_POLL

