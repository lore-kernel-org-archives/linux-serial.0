From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 2/9] tty: Call methods in modern style
Date: Wed,  5 Nov 2014 12:26:25 -0500
Message-ID: <1415208392-16189-3-git-send-email-peter@hurleysoftware.com>
References: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The use of older function ptr calling style, (*fn)(), makes static
analysis more error-prone; replace with modern fn() style.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c    | 12 ++++++------
 drivers/tty/tty_ioctl.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1262368..01d45fd 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -981,7 +981,7 @@ void __stop_tty(struct tty_struct *tty)
 		return;
 	tty->stopped = 1;
 	if (tty->ops->stop)
-		(tty->ops->stop)(tty);
+		tty->ops->stop(tty);
 }
 
 void stop_tty(struct tty_struct *tty)
@@ -1012,7 +1012,7 @@ void __start_tty(struct tty_struct *tty)
 		return;
 	tty->stopped = 0;
 	if (tty->ops->start)
-		(tty->ops->start)(tty);
+		tty->ops->start(tty);
 	tty_wakeup(tty);
 }
 
@@ -1066,7 +1066,7 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 	   situation */
 	ld = tty_ldisc_ref_wait(tty);
 	if (ld->ops->read)
-		i = (ld->ops->read)(tty, file, buf, count);
+		i = ld->ops->read(tty, file, buf, count);
 	else
 		i = -EIO;
 	tty_ldisc_deref(ld);
@@ -2182,7 +2182,7 @@ static unsigned int tty_poll(struct file *filp, poll_table *wait)
 
 	ld = tty_ldisc_ref_wait(tty);
 	if (ld->ops->poll)
-		ret = (ld->ops->poll)(tty, filp, wait);
+		ret = ld->ops->poll(tty, filp, wait);
 	tty_ldisc_deref(ld);
 	return ret;
 }
@@ -2905,7 +2905,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 	}
 	if (tty->ops->ioctl) {
-		retval = (tty->ops->ioctl)(tty, cmd, arg);
+		retval = tty->ops->ioctl(tty, cmd, arg);
 		if (retval != -ENOIOCTLCMD)
 			return retval;
 	}
@@ -2932,7 +2932,7 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 		return -EINVAL;
 
 	if (tty->ops->compat_ioctl) {
-		retval = (tty->ops->compat_ioctl)(tty, cmd, arg);
+		retval = tty->ops->compat_ioctl(tty, cmd, arg);
 		if (retval != -ENOIOCTLCMD)
 			return retval;
 	}
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 24a1360..1787fa4 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -550,14 +550,14 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 	unset_locked_termios(&tty->termios, &old_termios, &tty->termios_locked);
 
 	if (tty->ops->set_termios)
-		(*tty->ops->set_termios)(tty, &old_termios);
+		tty->ops->set_termios(tty, &old_termios);
 	else
 		tty_termios_copy_hw(&tty->termios, &old_termios);
 
 	ld = tty_ldisc_ref(tty);
 	if (ld != NULL) {
 		if (ld->ops->set_termios)
-			(ld->ops->set_termios)(tty, &old_termios);
+			ld->ops->set_termios(tty, &old_termios);
 		tty_ldisc_deref(ld);
 	}
 	up_write(&tty->termios_rwsem);
-- 
2.1.3
