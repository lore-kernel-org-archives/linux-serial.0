From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 19/24] tty: Only guarantee termios read safety for throttle/unthrottle
Date: Mon, 15 Apr 2013 11:19:23 -0400
Message-ID: <1366039168-8510-20-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

No tty driver modifies termios during throttle() or unthrottle().
Therefore, only read safety is required.

However, tty_throttle_safe and tty_unthrottle_safe must still be
mutually exclusive; introduce throttle_mutex for that purpose.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c     | 4 ----
 drivers/tty/tty_io.c    | 1 +
 drivers/tty/tty_ioctl.c | 8 ++++----
 include/linux/tty.h     | 1 +
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 3d334ef..dba7e99 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1519,9 +1519,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		tty_set_flow_change(tty, TTY_THROTTLE_SAFE);
 		if (receive_room(tty) >= TTY_THRESHOLD_THROTTLE)
 			break;
-		up_read(&tty->termios_rwsem);
 		throttled = tty_throttle_safe(tty);
-		down_read(&tty->termios_rwsem);
 		if (!throttled)
 			break;
 	}
@@ -2084,9 +2082,7 @@ do_it_again:
 			if (!tty->count)
 				break;
 			n_tty_set_room(tty);
-			up_read(&tty->termios_rwsem);
 			unthrottled = tty_unthrottle_safe(tty);
-			down_read(&tty->termios_rwsem);
 			if (!unthrottled)
 				break;
 		}
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 30201e6..55b8594 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2951,6 +2951,7 @@ void initialize_tty_struct(struct tty_struct *tty,
 	tty->session = NULL;
 	tty->pgrp = NULL;
 	mutex_init(&tty->legacy_mutex);
+	mutex_init(&tty->throttle_mutex);
 	init_rwsem(&tty->termios_rwsem);
 	init_ldsem(&tty->ldisc_sem);
 	init_waitqueue_head(&tty->write_wait);
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 490e499..5e55ca4 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -151,7 +151,7 @@ int tty_throttle_safe(struct tty_struct *tty)
 {
 	int ret = 0;
 
-	down_write(&tty->termios_rwsem);
+	mutex_lock(&tty->throttle_mutex);
 	if (!test_bit(TTY_THROTTLED, &tty->flags)) {
 		if (tty->flow_change != TTY_THROTTLE_SAFE)
 			ret = 1;
@@ -161,7 +161,7 @@ int tty_throttle_safe(struct tty_struct *tty)
 				tty->ops->throttle(tty);
 		}
 	}
-	up_write(&tty->termios_rwsem);
+	mutex_unlock(&tty->throttle_mutex);
 
 	return ret;
 }
@@ -182,7 +182,7 @@ int tty_unthrottle_safe(struct tty_struct *tty)
 {
 	int ret = 0;
 
-	down_write(&tty->termios_rwsem);
+	mutex_lock(&tty->throttle_mutex);
 	if (test_bit(TTY_THROTTLED, &tty->flags)) {
 		if (tty->flow_change != TTY_UNTHROTTLE_SAFE)
 			ret = 1;
@@ -192,7 +192,7 @@ int tty_unthrottle_safe(struct tty_struct *tty)
 				tty->ops->unthrottle(tty);
 		}
 	}
-	up_write(&tty->termios_rwsem);
+	mutex_unlock(&tty->throttle_mutex);
 
 	return ret;
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1d1c7c6a..e56ab4c 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -244,6 +244,7 @@ struct tty_struct {
 
 	struct mutex atomic_write_lock;
 	struct mutex legacy_mutex;
+	struct mutex throttle_mutex;
 	struct rw_semaphore termios_rwsem;
 	spinlock_t ctrl_lock;
 	/* Termios values are protected by the termios rwsem */
-- 
1.8.1.2
