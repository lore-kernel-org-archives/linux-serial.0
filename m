From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] tty: Replace TTY_IO_ERROR bit tests with tty_io_error()
Date: Sat,  9 Apr 2016 17:06:48 -0700
Message-ID: <1460246808-6319-1-git-send-email-peter@hurleysoftware.com>
References: <20160128222216.GA13513@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160128222216.GA13513@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Abstract TTY_IO_ERROR status test treewide with tty_io_error().
NB: tty->flags uses atomic bit ops; replace non-atomic bit test
with test_bit().

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---

v3: redo of an earlier patch titled "tty: Use test_bit() with tty->flags"
v2: rebase

 arch/ia64/hp/sim/simserial.c       | 2 +-
 drivers/char/pcmcia/synclink_cs.c  | 2 +-
 drivers/isdn/i4l/isdn_tty.c        | 6 +++---
 drivers/s390/char/tty3270.c        | 4 ++--
 drivers/staging/dgnc/dgnc_tty.c    | 2 +-
 drivers/tty/amiserial.c            | 6 +++---
 drivers/tty/mxser.c                | 7 +++----
 drivers/tty/pty.c                  | 2 +-
 drivers/tty/serial/crisv10.c       | 5 ++---
 drivers/tty/serial/serial_core.c   | 8 ++++----
 drivers/tty/synclink.c             | 4 ++--
 drivers/tty/synclink_gt.c          | 4 ++--
 drivers/tty/synclinkmp.c           | 4 ++--
 drivers/tty/tty_io.c               | 5 ++---
 drivers/tty/tty_port.c             | 2 +-
 include/linux/tty.h                | 5 +++++
 net/irda/ircomm/ircomm_tty.c       | 2 +-
 net/irda/ircomm/ircomm_tty_ioctl.c | 6 +++---
 18 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index e70cade..21fd50d 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -300,7 +300,7 @@ static int rs_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
 	    (cmd != TIOCMIWAIT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (tty_io_error(tty))
 		    return -EIO;
 	}
 
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 22c2765..825db42 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -2246,7 +2246,7 @@ static int mgslpc_ioctl(struct tty_struct *tty,
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCMIWAIT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (tty_io_error(tty))
 		    return -EIO;
 	}
 
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index 947d5c9..f1edc08 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1351,7 +1351,7 @@ isdn_tty_tiocmget(struct tty_struct *tty)
 
 	if (isdn_tty_paranoia_check(info, tty->name, __func__))
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (tty_io_error(tty))
 		return -EIO;
 
 	mutex_lock(&modem_info_mutex);
@@ -1378,7 +1378,7 @@ isdn_tty_tiocmset(struct tty_struct *tty,
 
 	if (isdn_tty_paranoia_check(info, tty->name, __func__))
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (tty_io_error(tty))
 		return -EIO;
 
 #ifdef ISDN_DEBUG_MODEM_IOCTL
@@ -1419,7 +1419,7 @@ isdn_tty_ioctl(struct tty_struct *tty, uint cmd, ulong arg)
 
 	if (isdn_tty_paranoia_check(info, tty->name, "isdn_tty_ioctl"))
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (tty_io_error(tty))
 		return -EIO;
 	switch (cmd) {
 	case TCSBRK:   /* SVID version: non-zero arg --> no break */
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index e96fc7f..080a987 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1804,7 +1804,7 @@ static int tty3270_ioctl(struct tty_struct *tty, unsigned int cmd,
 	tp = tty->driver_data;
 	if (!tp)
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (tty_io_error(tty))
 		return -EIO;
 	return kbd_ioctl(tp->kbd, cmd, arg);
 }
@@ -1818,7 +1818,7 @@ static long tty3270_compat_ioctl(struct tty_struct *tty,
 	tp = tty->driver_data;
 	if (!tp)
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (tty_io_error(tty))
 		return -EIO;
 	return kbd_ioctl(tp->kbd, cmd, (unsigned long)compat_ptr(arg));
 }
diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
index bcd2bdf..5c22159 100644
--- a/drivers/staging/dgnc/dgnc_tty.c
+++ b/drivers/staging/dgnc/dgnc_tty.c
@@ -1255,7 +1255,7 @@ static int dgnc_block_til_ready(struct tty_struct *tty,
 			if (file->f_flags & O_NONBLOCK)
 				break;
 
-			if (tty->flags & (1 << TTY_IO_ERROR)) {
+			if (tty_io_error(tty)) {
 				retval = -EIO;
 				break;
 			}
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index eacf4c9..183e98e 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1143,7 +1143,7 @@ static int rs_tiocmget(struct tty_struct *tty)
 
 	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (tty_io_error(tty))
 		return -EIO;
 
 	control = info->MCR;
@@ -1165,7 +1165,7 @@ static int rs_tiocmset(struct tty_struct *tty, unsigned int set,
 
 	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (tty_io_error(tty))
 		return -EIO;
 
 	local_irq_save(flags);
@@ -1250,7 +1250,7 @@ static int rs_ioctl(struct tty_struct *tty,
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
 	    (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (tty_io_error(tty))
 		    return -EIO;
 	}
 
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 2f12bb9..f23c2a1 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1334,7 +1334,7 @@ static int mxser_tiocmget(struct tty_struct *tty)
 
 	if (tty->index == MXSER_PORTS)
 		return -ENOIOCTLCMD;
-	if (test_bit(TTY_IO_ERROR, &tty->flags))
+	if (tty_io_error(tty))
 		return -EIO;
 
 	control = info->MCR;
@@ -1361,7 +1361,7 @@ static int mxser_tiocmset(struct tty_struct *tty,
 
 	if (tty->index == MXSER_PORTS)
 		return -ENOIOCTLCMD;
-	if (test_bit(TTY_IO_ERROR, &tty->flags))
+	if (tty_io_error(tty))
 		return -EIO;
 
 	spin_lock_irqsave(&info->slock, flags);
@@ -1715,8 +1715,7 @@ static int mxser_ioctl(struct tty_struct *tty,
 		return 0;
 	}
 
-	if (cmd != TIOCGSERIAL && cmd != TIOCMIWAIT &&
-			test_bit(TTY_IO_ERROR, &tty->flags))
+	if (cmd != TIOCGSERIAL && cmd != TIOCMIWAIT && tty_io_error(tty))
 		return -EIO;
 
 	switch (cmd) {
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index e16a49b..d8afe77 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -44,7 +44,7 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
 	if (tty->driver->subtype == PTY_TYPE_MASTER)
 		WARN_ON(tty->count > 1);
 	else {
-		if (test_bit(TTY_IO_ERROR, &tty->flags))
+		if (tty_io_error(tty))
 			return;
 		if (tty->count > 2)
 			return;
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index c0172bf54..5469903 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -3445,7 +3445,7 @@ rs_ioctl(struct tty_struct *tty,
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGWILD)  &&
 	    (cmd != TIOCSERSWILD) && (cmd != TIOCSERGSTRUCT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (tty_io_error(tty))
 			return -EIO;
 	}
 
@@ -3755,8 +3755,7 @@ block_til_ready(struct tty_struct *tty, struct file * filp,
 	 * If non-blocking mode is set, or the port is not enabled,
 	 * then make the check up front and then exit.
 	 */
-	if ((filp->f_flags & O_NONBLOCK) ||
-	    (tty->flags & (1 << TTY_IO_ERROR))) {
+	if ((filp->f_flags & O_NONBLOCK) || tty_io_error(tty)) {
 		info->port.flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a126a60..67b3950 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -969,7 +969,7 @@ static int uart_tiocmget(struct tty_struct *tty)
 	int result = -EIO;
 
 	mutex_lock(&port->mutex);
-	if (!(tty->flags & (1 << TTY_IO_ERROR))) {
+	if (!tty_io_error(tty)) {
 		result = uport->mctrl;
 		spin_lock_irq(&uport->lock);
 		result |= uport->ops->get_mctrl(uport);
@@ -989,7 +989,7 @@ uart_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
 	int ret = -EIO;
 
 	mutex_lock(&port->mutex);
-	if (!(tty->flags & (1 << TTY_IO_ERROR))) {
+	if (!tty_io_error(tty)) {
 		uart_update_mctrl(uport, set, clear);
 		ret = 0;
 	}
@@ -1238,7 +1238,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd,
 	if (ret != -ENOIOCTLCMD)
 		goto out;
 
-	if (tty->flags & (1 << TTY_IO_ERROR)) {
+	if (tty_io_error(tty)) {
 		ret = -EIO;
 		goto out;
 	}
@@ -1257,7 +1257,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd,
 
 	mutex_lock(&port->mutex);
 
-	if (tty->flags & (1 << TTY_IO_ERROR)) {
+	if (tty_io_error(tty)) {
 		ret = -EIO;
 		goto out_up;
 	}
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index f5476e2..8b22772 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -2972,7 +2972,7 @@ static int mgsl_ioctl(struct tty_struct *tty,
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCMIWAIT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (tty_io_error(tty))
 		    return -EIO;
 	}
 
@@ -3270,7 +3270,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 		printk("%s(%d):block_til_ready on %s\n",
 			 __FILE__,__LINE__, tty->driver->name );
 
-	if (filp->f_flags & O_NONBLOCK || tty->flags & (1 << TTY_IO_ERROR)){
+	if (filp->f_flags & O_NONBLOCK || tty_io_error(tty)) {
 		/* nonblock mode is set or port is not enabled */
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index c0a2f5a..1f7d6d9 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1032,7 +1032,7 @@ static int ioctl(struct tty_struct *tty,
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCMIWAIT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (tty_io_error(tty))
 		    return -EIO;
 	}
 
@@ -3269,7 +3269,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 
 	DBGINFO(("%s block_til_ready\n", tty->driver->name));
 
-	if (filp->f_flags & O_NONBLOCK || tty->flags & (1 << TTY_IO_ERROR)){
+	if (filp->f_flags & O_NONBLOCK || tty_io_error(tty)) {
 		/* nonblock mode is set or port is not enabled */
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 90da0c7..e938799 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -1261,7 +1261,7 @@ static int ioctl(struct tty_struct *tty,
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCMIWAIT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (tty_io_error(tty))
 		    return -EIO;
 	}
 
@@ -3285,7 +3285,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		printk("%s(%d):%s block_til_ready()\n",
 			 __FILE__,__LINE__, tty->driver->name );
 
-	if (filp->f_flags & O_NONBLOCK || tty->flags & (1 << TTY_IO_ERROR)){
+	if (filp->f_flags & O_NONBLOCK || tty_io_error(tty)) {
 		/* nonblock mode is set or port is not enabled */
 		/* just verify that callout device is not active */
 		port->flags |= ASYNC_NORMAL_ACTIVE;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 9b04d72..320dc4d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1070,7 +1070,7 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 
 	if (tty_paranoia_check(tty, inode, "tty_read"))
 		return -EIO;
-	if (!tty || (test_bit(TTY_IO_ERROR, &tty->flags)))
+	if (!tty || tty_io_error(tty))
 		return -EIO;
 
 	/* We want to wait for the line discipline to sort out in this
@@ -1245,8 +1245,7 @@ static ssize_t tty_write(struct file *file, const char __user *buf,
 
 	if (tty_paranoia_check(tty, file_inode(file), "tty_write"))
 		return -EIO;
-	if (!tty || !tty->ops->write ||
-		(test_bit(TTY_IO_ERROR, &tty->flags)))
+	if (!tty || !tty->ops->write ||	tty_io_error(tty))
 			return -EIO;
 	/* Short term debug to catch buggy drivers */
 	if (tty->ops->write_room == NULL)
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index dbcca30..9127c54 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -364,7 +364,7 @@ int tty_port_block_til_ready(struct tty_port *port,
 
 	/* if non-blocking mode is set we can pass directly to open unless
 	   the port has just hung up or is in another error state */
-	if (tty->flags & (1 << TTY_IO_ERROR)) {
+	if (tty_io_error(tty)) {
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 3b09f23..68d829b 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -360,6 +360,11 @@ static inline void tty_set_flow_change(struct tty_struct *tty, int val)
 	smp_mb();
 }
 
+static inline bool tty_io_error(struct tty_struct *tty)
+{
+	return test_bit(TTY_IO_ERROR, &tty->flags);
+}
+
 #ifdef CONFIG_TTY
 extern void console_init(void);
 extern void tty_kref_put(struct tty_struct *tty);
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index da126ee..840b82f 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -280,7 +280,7 @@ static int ircomm_tty_block_til_ready(struct ircomm_tty_cb *self,
 	 * If non-blocking mode is set, or the port is not enabled,
 	 * then make the check up front and then exit.
 	 */
-	if (test_bit(TTY_IO_ERROR, &tty->flags)) {
+	if (tty_io_error(tty)) {
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
diff --git a/net/irda/ircomm/ircomm_tty_ioctl.c b/net/irda/ircomm/ircomm_tty_ioctl.c
index d3687aa..9beb011 100644
--- a/net/irda/ircomm/ircomm_tty_ioctl.c
+++ b/net/irda/ircomm/ircomm_tty_ioctl.c
@@ -190,7 +190,7 @@ int ircomm_tty_tiocmget(struct tty_struct *tty)
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
 	unsigned int result;
 
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (tty_io_error(tty))
 		return -EIO;
 
 	result =  ((self->settings.dte & IRCOMM_RTS) ? TIOCM_RTS : 0)
@@ -213,7 +213,7 @@ int ircomm_tty_tiocmset(struct tty_struct *tty,
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
 
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (tty_io_error(tty))
 		return -EIO;
 
 	IRDA_ASSERT(self != NULL, return -1;);
@@ -362,7 +362,7 @@ int ircomm_tty_ioctl(struct tty_struct *tty,
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
 	    (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (tty_io_error(tty))
 		    return -EIO;
 	}
 
-- 
2.8.1
