From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 22/23] tty: Bracket ldisc release with TTY_DEBUG_HANGUP messages
Date: Tue,  5 Feb 2013 15:20:37 -0500
Message-ID: <1360095638-6624-23-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
 <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Expected typical log output:
[    2.437211] tty_open: opening pts1...
[    2.443376] tty_open: opening pts5...
[    2.447830] tty_release: ptm0 (tty count=1)...
[    2.447849] pts0 vhangup...
[    2.447865] tty_release: ptm0: final close
[    2.447876] tty_release: ptm0: freeing structure...
[    2.451634] tty_release: tty1 (tty count=1)...
[    2.451638] tty_release: tty1: final close
[    2.451654] tty_release: tty1: freeing structure...
[    2.452505] tty_release: pts5 (tty count=2)...
[    2.453029] tty_open: opening pts0...

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 25494fd..f96bf54 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1793,7 +1793,7 @@ int tty_release(struct inode *inode, struct file *filp)
 		return 0;
 
 #ifdef TTY_DEBUG_HANGUP
-	printk(KERN_DEBUG "%s: freeing tty structure...\n", __func__);
+	printk(KERN_DEBUG "%s: %s: final close\n", __func__, tty_name(tty, buf));
 #endif
 	/*
 	 * Ask the line discipline code to release its structures
@@ -1805,6 +1805,9 @@ int tty_release(struct inode *inode, struct file *filp)
 	if (o_tty)
 		tty_flush_works(o_tty);
 
+#ifdef TTY_DEBUG_HANGUP
+	printk(KERN_DEBUG "%s: %s: freeing structure...\n", __func__, tty_name(tty, buf));
+#endif
 	/*
 	 * The release_tty function takes care of the details of clearing
 	 * the slots and preserving the termios structure. The tty_unlock_pair
-- 
1.8.1.2
