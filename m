From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 3/3] tty: Remove sparse lock annotations from tty_write_lock()/_unlock()
Date: Thu, 16 Oct 2014 14:19:49 -0400
Message-ID: <1413483589-6490-3-git-send-email-peter@hurleysoftware.com>
References: <1413483589-6490-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:57058 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751309AbaJPSUR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 14:20:17 -0400
In-Reply-To: <1413483589-6490-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

sparse lock annotations cannot represent conditional acquire, such
as mutex_lock_interruptible() or mutex_trylock(), and produce sparse
warnings at _every_ correct call site.

Remove lock annotations from tty_write_lock() and tty_write_unlock().

Fixes sparse warnings:
drivers/tty/tty_io.c:1083:13: warning: context imbalance in 'tty_write_unlock' - wrong count at exit
drivers/tty/tty_io.c:1090:12: warning: context imbalance in 'tty_write_lock' - wrong count at exit
drivers/tty/tty_io.c:1211:17: warning: context imbalance in 'tty_write_message' - unexpected unlock
drivers/tty/tty_io.c:1233:16: warning: context imbalance in 'tty_write' - different lock contexts for basic block
drivers/tty/tty_io.c:1285:5: warning: context imbalance in 'tty_send_xchar' - different lock contexts for basic block
drivers/tty/tty_io.c:2653:12: warning: context imbalance in 'send_break' - different lock contexts for basic block

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index cf7c9b8..8cce5ab 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1024,14 +1024,12 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 }
 
 static void tty_write_unlock(struct tty_struct *tty)
-	__releases(&tty->atomic_write_lock)
 {
 	mutex_unlock(&tty->atomic_write_lock);
 	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
 }
 
 static int tty_write_lock(struct tty_struct *tty, int ndelay)
-	__acquires(&tty->atomic_write_lock)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
-- 
2.1.1

