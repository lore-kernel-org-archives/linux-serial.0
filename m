From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] tty: Prevent "read/write wait queue active!" log flooding
Date: Thu, 16 Oct 2014 13:54:36 -0400
Message-ID: <1413482076-14302-1-git-send-email-peter@hurleysoftware.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Only print one warning when a task is on the read_wait or write_wait
wait queue at final tty release.

Cc: <stable@vger.kernel.org> # 3.4.x+
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1019025..cf7c9b8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1709,6 +1709,7 @@ int tty_release(struct inode *inode, struct file *filp)
 	int	idx;
 	char	buf[64];
 	long	timeout = 0;
+	int	once = 1;
 
 	if (tty_paranoia_check(tty, inode, __func__))
 		return 0;
@@ -1789,8 +1790,11 @@ int tty_release(struct inode *inode, struct file *filp)
 		if (!do_sleep)
 			break;
 
-		printk(KERN_WARNING "%s: %s: read/write wait queue active!\n",
-				__func__, tty_name(tty, buf));
+		if (once) {
+			once = 0;
+			printk(KERN_WARNING "%s: %s: read/write wait queue active!\n",
+			       __func__, tty_name(tty, buf));
+		}
 		tty_unlock_pair(tty, o_tty);
 		mutex_unlock(&tty_mutex);
 		schedule_timeout_killable(timeout);
-- 
2.1.1
