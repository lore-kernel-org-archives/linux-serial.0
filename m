From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 1/9] tty: WARN for attempted set_termios() of pty master
Date: Thu, 16 Oct 2014 15:33:22 -0400
Message-ID: <1413488010-16885-2-git-send-email-peter@hurleysoftware.com>
References: <1413488010-16885-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413488010-16885-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The pty master's termios should never be set; currently, all code
paths which call the driver's set_termios() method ensure that the
pty slave's termios is being set.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c       | 2 --
 drivers/tty/tty_ioctl.c | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 4c0218d..6c76025 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -477,7 +477,6 @@ static const struct tty_operations master_pty_ops_bsd = {
 	.flush_buffer = pty_flush_buffer,
 	.chars_in_buffer = pty_chars_in_buffer,
 	.unthrottle = pty_unthrottle,
-	.set_termios = pty_set_termios,
 	.ioctl = pty_bsd_ioctl,
 	.cleanup = pty_cleanup,
 	.resize = pty_resize,
@@ -654,7 +653,6 @@ static const struct tty_operations ptm_unix98_ops = {
 	.flush_buffer = pty_flush_buffer,
 	.chars_in_buffer = pty_chars_in_buffer,
 	.unthrottle = pty_unthrottle,
-	.set_termios = pty_set_termios,
 	.ioctl = pty_unix98_ioctl,
 	.resize = pty_resize,
 	.shutdown = pty_unix98_shutdown,
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 32cee97..f29e3d1 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -528,6 +528,8 @@ EXPORT_SYMBOL(tty_termios_hw_change);
  *	is a bit of layering violation here with n_tty in terms of the
  *	internal knowledge of this function.
  *
+ *	A master pty's termios should never be set.
+ *
  *	Locking: termios_rwsem
  */
 
@@ -537,6 +539,8 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 	struct tty_ldisc *ld;
 	unsigned long flags;
 
+	WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
+		tty->driver->subtype == PTY_TYPE_MASTER);
 	/*
 	 *	Perform the actual termios internal changes under lock.
 	 */
-- 
2.1.1
