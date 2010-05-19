From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 04/11] riscom8: kill use of lock_kernel
Date: Wed, 19 May 2010 13:02:28 +0100
Message-ID: <20100519120220.16717.60836.stgit@localhost.localdomain>
References: <20100519120111.16717.71992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51090 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756041Ab0ESMo4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 May 2010 08:44:56 -0400
In-Reply-To: <20100519120111.16717.71992.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

The riscom8 board uses lock_kernel to protect bits of the port setting
ioctl logic. We can use the port mutex for this as the logic is internal
and will also lock set versus open (a locking property that has been lost
somewhere along the way)

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/riscom8.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)


diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
index b02332a..af4de1f 100644
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -47,7 +47,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/tty_flip.h>
-#include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
 
@@ -1184,6 +1183,7 @@ static int rc_set_serial_info(struct tty_struct *tty, struct riscom_port *port,
 	if (copy_from_user(&tmp, newinfo, sizeof(tmp)))
 		return -EFAULT;
 
+	mutex_lock(&port->port.mutex);
 	change_speed = ((port->port.flags & ASYNC_SPD_MASK) !=
 			(tmp.flags & ASYNC_SPD_MASK));
 
@@ -1191,8 +1191,10 @@ static int rc_set_serial_info(struct tty_struct *tty, struct riscom_port *port,
 		if ((tmp.close_delay != port->port.close_delay) ||
 		    (tmp.closing_wait != port->port.closing_wait) ||
 		    ((tmp.flags & ~ASYNC_USR_MASK) !=
-		     (port->port.flags & ~ASYNC_USR_MASK)))
+		     (port->port.flags & ~ASYNC_USR_MASK))) {
+			mutex_unlock(&port->port.mutex);
 			return -EPERM;
+		}
 		port->port.flags = ((port->port.flags & ~ASYNC_USR_MASK) |
 			       (tmp.flags & ASYNC_USR_MASK));
 	} else  {
@@ -1208,6 +1210,7 @@ static int rc_set_serial_info(struct tty_struct *tty, struct riscom_port *port,
 		rc_change_speed(tty, bp, port);
 		spin_unlock_irqrestore(&riscom_lock, flags);
 	}
+	mutex_unlock(&port->port.mutex);
 	return 0;
 }
 
@@ -1220,12 +1223,15 @@ static int rc_get_serial_info(struct riscom_port *port,
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.type = PORT_CIRRUS;
 	tmp.line = port - rc_port;
+
+	mutex_lock(&port->port.mutex);
 	tmp.port = bp->base;
 	tmp.irq  = bp->irq;
 	tmp.flags = port->port.flags;
 	tmp.baud_base = (RC_OSCFREQ + CD180_TPC/2) / CD180_TPC;
 	tmp.close_delay = port->port.close_delay * HZ/100;
 	tmp.closing_wait = port->port.closing_wait * HZ/100;
+	mutex_unlock(&port->port.mutex);
 	tmp.xmit_fifo_size = CD180_NFIFO;
 	return copy_to_user(retinfo, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
@@ -1242,14 +1248,10 @@ static int rc_ioctl(struct tty_struct *tty, struct file *filp,
 
 	switch (cmd) {
 	case TIOCGSERIAL:
-		lock_kernel();
 		retval = rc_get_serial_info(port, argp);
-		unlock_kernel();
 		break;
 	case TIOCSSERIAL:
-		lock_kernel();
 		retval = rc_set_serial_info(tty, port, argp);
-		unlock_kernel();
 		break;
 	default:
 		retval = -ENOIOCTLCMD;

