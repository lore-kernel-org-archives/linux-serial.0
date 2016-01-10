From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 9/9] tty: Use test_bit() with tty->flags
Date: Sun, 10 Jan 2016 14:43:09 -0800
Message-ID: <1452465789-4039-9-git-send-email-peter@hurleysoftware.com>
References: <1452465789-4039-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452465789-4039-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

tty->flags are handled with atomic bit ops; use test_bit() treewide.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 arch/ia64/hp/sim/simserial.c       | 2 +-
 drivers/char/pcmcia/synclink_cs.c  | 2 +-
 drivers/isdn/i4l/isdn_tty.c        | 6 +++---
 drivers/s390/char/tty3270.c        | 4 ++--
 drivers/staging/dgap/dgap.c        | 2 +-
 drivers/staging/dgnc/dgnc_tty.c    | 2 +-
 drivers/tty/amiserial.c            | 6 +++---
 drivers/tty/serial/68328serial.c   | 2 +-
 drivers/tty/serial/crisv10.c       | 4 ++--
 drivers/tty/serial/serial_core.c   | 6 +++---
 drivers/tty/synclink.c             | 4 ++--
 drivers/tty/synclink_gt.c          | 4 ++--
 drivers/tty/synclinkmp.c           | 4 ++--
 drivers/tty/tty_port.c             | 2 +-
 net/irda/ircomm/ircomm_tty_ioctl.c | 6 +++---
 15 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/ia64/hp/sim/simserial.c b/arch/ia64/hp/sim/simserial.c
index e70cade..2ab9ba6 100644
--- a/arch/ia64/hp/sim/simserial.c
+++ b/arch/ia64/hp/sim/simserial.c
@@ -300,7 +300,7 @@ static int rs_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
 	    (cmd != TIOCMIWAIT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (test_bit(TTY_IO_ERROR, &tty->flags))
 		    return -EIO;
 	}
 
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 22c2765..776c479 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -2246,7 +2246,7 @@ static int mgslpc_ioctl(struct tty_struct *tty,
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCMIWAIT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (test_bit(TTY_IO_ERROR, &tty->flags))
 		    return -EIO;
 	}
 
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index 2175225..1a53b93 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1351,7 +1351,7 @@ isdn_tty_tiocmget(struct tty_struct *tty)
 
 	if (isdn_tty_paranoia_check(info, tty->name, __func__))
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 
 	mutex_lock(&modem_info_mutex);
@@ -1378,7 +1378,7 @@ isdn_tty_tiocmset(struct tty_struct *tty,
 
 	if (isdn_tty_paranoia_check(info, tty->name, __func__))
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 
 #ifdef ISDN_DEBUG_MODEM_IOCTL
@@ -1419,7 +1419,7 @@ isdn_tty_ioctl(struct tty_struct *tty, uint cmd, ulong arg)
 
 	if (isdn_tty_paranoia_check(info, tty->name, "isdn_tty_ioctl"))
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 	switch (cmd) {
 	case TCSBRK:   /* SVID version: non-zero arg --> no break */
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index e96fc7f..4aaedec 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1804,7 +1804,7 @@ static int tty3270_ioctl(struct tty_struct *tty, unsigned int cmd,
 	tp = tty->driver_data;
 	if (!tp)
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 	return kbd_ioctl(tp->kbd, cmd, arg);
 }
@@ -1818,7 +1818,7 @@ static long tty3270_compat_ioctl(struct tty_struct *tty,
 	tp = tty->driver_data;
 	if (!tp)
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 	return kbd_ioctl(tp->kbd, cmd, (unsigned long)compat_ptr(arg));
 }
diff --git a/drivers/staging/dgap/dgap.c b/drivers/staging/dgap/dgap.c
index 294c1c8..3fc996d 100644
--- a/drivers/staging/dgap/dgap.c
+++ b/drivers/staging/dgap/dgap.c
@@ -3043,7 +3043,7 @@ static int dgap_block_til_ready(struct tty_struct *tty, struct file *file,
 			if (file->f_flags & O_NONBLOCK)
 				break;
 
-			if (tty->flags & (1 << TTY_IO_ERROR))
+			if (test_bit(TTY_IO_ERROR, &tty->flags))
 				break;
 
 			if (ch->ch_flags & CH_CD)
diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
index 9f9a73f..5b43000 100644
--- a/drivers/staging/dgnc/dgnc_tty.c
+++ b/drivers/staging/dgnc/dgnc_tty.c
@@ -1259,7 +1259,7 @@ static int dgnc_block_til_ready(struct tty_struct *tty,
 			if (file->f_flags & O_NONBLOCK)
 				break;
 
-			if (tty->flags & (1 << TTY_IO_ERROR)) {
+			if (test_bit(TTY_IO_ERROR, &tty->flags)) {
 				retval = -EIO;
 				break;
 			}
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index eacf4c9..59b981d 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1143,7 +1143,7 @@ static int rs_tiocmget(struct tty_struct *tty)
 
 	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 
 	control = info->MCR;
@@ -1165,7 +1165,7 @@ static int rs_tiocmset(struct tty_struct *tty, unsigned int set,
 
 	if (serial_paranoia_check(info, tty->name, "rs_ioctl"))
 		return -ENODEV;
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 
 	local_irq_save(flags);
@@ -1250,7 +1250,7 @@ static int rs_ioctl(struct tty_struct *tty,
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
 	    (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (test_bit(TTY_IO_ERROR, &tty->flags))
 		    return -EIO;
 	}
 
diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/68328serial.c
index 4931212..3804b41 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -931,7 +931,7 @@ static int rs_ioctl(struct tty_struct *tty,
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGWILD)  &&
 	    (cmd != TIOCSERSWILD) && (cmd != TIOCSERGSTRUCT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (test_bit(TTY_IO_ERROR, &tty->flags))
 		    return -EIO;
 	}
 	
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 37f10c4..df740c5 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -3445,7 +3445,7 @@ rs_ioctl(struct tty_struct *tty,
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGWILD)  &&
 	    (cmd != TIOCSERSWILD) && (cmd != TIOCSERGSTRUCT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (test_bit(TTY_IO_ERROR, &tty->flags))
 			return -EIO;
 	}
 
@@ -3757,7 +3757,7 @@ block_til_ready(struct tty_struct *tty, struct file * filp,
 	 * then make the check up front and then exit.
 	 */
 	if ((filp->f_flags & O_NONBLOCK) ||
-	    (tty->flags & (1 << TTY_IO_ERROR))) {
+	    test_bit(TTY_IO_ERROR, &tty->flags)) {
 		info->port.flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1efdc2b..3698ada 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -977,7 +977,7 @@ static int uart_tiocmget(struct tty_struct *tty)
 	int result = -EIO;
 
 	mutex_lock(&port->mutex);
-	if (!(tty->flags & (1 << TTY_IO_ERROR))) {
+	if (!test_bit(TTY_IO_ERROR, &tty->flags)) {
 		result = uport->mctrl;
 		spin_lock_irq(&uport->lock);
 		result |= uport->ops->get_mctrl(uport);
@@ -997,7 +997,7 @@ uart_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
 	int ret = -EIO;
 
 	mutex_lock(&port->mutex);
-	if (!(tty->flags & (1 << TTY_IO_ERROR))) {
+	if (!test_bit(TTY_IO_ERROR, &tty->flags)) {
 		uart_update_mctrl(uport, set, clear);
 		ret = 0;
 	}
@@ -1246,7 +1246,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd,
 	if (ret != -ENOIOCTLCMD)
 		goto out;
 
-	if (tty->flags & (1 << TTY_IO_ERROR)) {
+	if (test_bit(TTY_IO_ERROR, &tty->flags)) {
 		ret = -EIO;
 		goto out;
 	}
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index f5476e2..c4b6924 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -2972,7 +2972,7 @@ static int mgsl_ioctl(struct tty_struct *tty,
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCMIWAIT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (test_bit(TTY_IO_ERROR, &tty->flags))
 		    return -EIO;
 	}
 
@@ -3270,7 +3270,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 		printk("%s(%d):block_til_ready on %s\n",
 			 __FILE__,__LINE__, tty->driver->name );
 
-	if (filp->f_flags & O_NONBLOCK || tty->flags & (1 << TTY_IO_ERROR)){
+	if (filp->f_flags & O_NONBLOCK || test_bit(TTY_IO_ERROR, &tty->flags)) {
 		/* nonblock mode is set or port is not enabled */
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index c0a2f5a..95a06fe 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1032,7 +1032,7 @@ static int ioctl(struct tty_struct *tty,
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCMIWAIT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (test_bit(TTY_IO_ERROR, &tty->flags))
 		    return -EIO;
 	}
 
@@ -3269,7 +3269,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 
 	DBGINFO(("%s block_til_ready\n", tty->driver->name));
 
-	if (filp->f_flags & O_NONBLOCK || tty->flags & (1 << TTY_IO_ERROR)){
+	if (filp->f_flags & O_NONBLOCK || test_bit(TTY_IO_ERROR, &tty->flags)) {
 		/* nonblock mode is set or port is not enabled */
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 4b314b6..c4cc454 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -1261,7 +1261,7 @@ static int ioctl(struct tty_struct *tty,
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCMIWAIT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (test_bit(TTY_IO_ERROR, &tty->flags))
 		    return -EIO;
 	}
 
@@ -3285,7 +3285,7 @@ static int block_til_ready(struct tty_struct *tty, struct file *filp,
 		printk("%s(%d):%s block_til_ready()\n",
 			 __FILE__,__LINE__, tty->driver->name );
 
-	if (filp->f_flags & O_NONBLOCK || tty->flags & (1 << TTY_IO_ERROR)){
+	if (filp->f_flags & O_NONBLOCK || test_bit(TTY_IO_ERROR, &tty->flags)) {
 		/* nonblock mode is set or port is not enabled */
 		/* just verify that callout device is not active */
 		port->flags |= ASYNC_NORMAL_ACTIVE;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 0473fc7..1fbba8e 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -364,7 +364,7 @@ int tty_port_block_til_ready(struct tty_port *port,
 
 	/* if non-blocking mode is set we can pass directly to open unless
 	   the port has just hung up or is in another error state */
-	if (tty->flags & (1 << TTY_IO_ERROR)) {
+	if (test_bit(TTY_IO_ERROR, &tty->flags)) {
 		port->flags |= ASYNC_NORMAL_ACTIVE;
 		return 0;
 	}
diff --git a/net/irda/ircomm/ircomm_tty_ioctl.c b/net/irda/ircomm/ircomm_tty_ioctl.c
index d3687aa..f6d4f5b 100644
--- a/net/irda/ircomm/ircomm_tty_ioctl.c
+++ b/net/irda/ircomm/ircomm_tty_ioctl.c
@@ -190,7 +190,7 @@ int ircomm_tty_tiocmget(struct tty_struct *tty)
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
 	unsigned int result;
 
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 
 	result =  ((self->settings.dte & IRCOMM_RTS) ? TIOCM_RTS : 0)
@@ -213,7 +213,7 @@ int ircomm_tty_tiocmset(struct tty_struct *tty,
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
 
-	if (tty->flags & (1 << TTY_IO_ERROR))
+	if (test_bit(TTY_IO_ERROR, &tty->flags))
 		return -EIO;
 
 	IRDA_ASSERT(self != NULL, return -1;);
@@ -362,7 +362,7 @@ int ircomm_tty_ioctl(struct tty_struct *tty,
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
 	    (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
 	    (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
-		if (tty->flags & (1 << TTY_IO_ERROR))
+		if (test_bit(TTY_IO_ERROR, &tty->flags))
 		    return -EIO;
 	}
 
-- 
2.7.0
