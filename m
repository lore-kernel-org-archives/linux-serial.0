From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 7/7] pty: Add debug message for ptmx open
Date: Sun, 12 Jul 2015 22:49:13 -0400
Message-ID: <1436755753-7746-8-git-send-email-peter@hurleysoftware.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Opens of /dev/ptmx don't use tty_open() so debug messages are
not printed for those opens; print a debug message with the
open count (which must always be 1) if TTY_DEBUG_HANGUP is defined.

NB: Each tty core source file undefs support for debug messages.
The relevant source file must be patched/edited to enable these
messages.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 4d5e840..4d5937c 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -26,6 +26,12 @@
 #include <linux/mutex.h>
 #include <linux/poll.h>
 
+#undef TTY_DEBUG_HANGUP
+#ifdef TTY_DEBUG_HANGUP
+# define tty_debug_hangup(tty, f, args...)	tty_debug(tty, f, ##args)
+#else
+# define tty_debug_hangup(tty, f, args...)	do {} while (0)
+#endif
 
 #ifdef CONFIG_UNIX98_PTYS
 static struct tty_driver *ptm_driver;
@@ -779,6 +785,8 @@ static int ptmx_open(struct inode *inode, struct file *filp)
 	if (retval)
 		goto err_release;
 
+	tty_debug_hangup(tty, "(tty count=%d)\n", tty->count);
+
 	tty_unlock(tty);
 	return 0;
 err_release:
-- 
2.4.5
