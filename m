From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 10/27] tty: Don't take tty_mutex for tty count changes
Date: Thu, 16 Oct 2014 16:25:08 -0400
Message-ID: <1413491125-20134-11-git-send-email-peter@hurleysoftware.com>
References: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:33564 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753028AbaJPVBi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 17:01:38 -0400
In-Reply-To: <1413491125-20134-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>

Holding tty_mutex is no longer required to serialize changes to
the tty_count or to prevent concurrent opens of closing ttys;
tty_lock() is sufficient.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 55f9931..7b40247 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1805,10 +1805,6 @@ int tty_release(struct inode *inode, struct file *filp)
 	 * each iteration we avoid any problems.
 	 */
 	while (1) {
-		/* Guard against races with tty->count changes elsewhere and
-		   opens on /dev/tty */
-
-		mutex_lock(&tty_mutex);
 		tty_lock_pair(tty, o_tty);
 		tty_closing = tty->count <= 1;
 		o_tty_closing = o_tty &&
@@ -1844,7 +1840,6 @@ int tty_release(struct inode *inode, struct file *filp)
 			       __func__, tty_name(tty, buf));
 		}
 		tty_unlock_pair(tty, o_tty);
-		mutex_unlock(&tty_mutex);
 		schedule_timeout_killable(timeout);
 		if (timeout < 120 * HZ)
 			timeout = 2 * timeout + 1;
@@ -1899,7 +1894,6 @@ int tty_release(struct inode *inode, struct file *filp)
 		read_unlock(&tasklist_lock);
 	}
 
-	mutex_unlock(&tty_mutex);
 	tty_unlock_pair(tty, o_tty);
 	/* At this point, the tty->count == 0 should ensure a dead tty
 	   cannot be re-opened by a racing opener */
-- 
2.1.1

