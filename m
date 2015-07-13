From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 5/7] tty: Replace inline #ifdef TTY_DEBUG_WAIT_UNTIL_SENT
Date: Sun, 12 Jul 2015 22:49:11 -0400
Message-ID: <1436755753-7746-6-git-send-email-peter@hurleysoftware.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Add tty_debug_wait_until_sent() macro which uses tty_debug() to print
the debug message; remove inlined #ifdef.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_ioctl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 5232fb6..9c5aebf 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -26,6 +26,12 @@
 
 #undef TTY_DEBUG_WAIT_UNTIL_SENT
 
+#ifdef TTY_DEBUG_WAIT_UNTIL_SENT
+# define tty_debug_wait_until_sent(tty, f, args...)    tty_debug(tty, f, ##args)
+#else
+# define tty_debug_wait_until_sent(tty, f, args...)    do {} while (0)
+#endif
+
 #undef	DEBUG
 
 /*
@@ -210,9 +216,8 @@ int tty_unthrottle_safe(struct tty_struct *tty)
 
 void tty_wait_until_sent(struct tty_struct *tty, long timeout)
 {
-#ifdef TTY_DEBUG_WAIT_UNTIL_SENT
-	printk(KERN_DEBUG "%s wait until sent...\n", tty_name(tty));
-#endif
+	tty_debug_wait_until_sent(tty, "\n");
+
 	if (!timeout)
 		timeout = MAX_SCHEDULE_TIMEOUT;
 
-- 
2.4.5
