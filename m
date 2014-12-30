From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] tty: Remove warning in tty_lock_slave()
Date: Tue, 30 Dec 2014 07:11:11 -0500
Message-ID: <1419941471-5466-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Dan Carpenter <dan.carpenter@oracle.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Commit 2aff5e2bc62db43e05c814461a08aff0fc2b7fe5 ('tty: Change
tty lock order to master->slave') added a warning which is broken
and unnecessary now that the tty lock has fixed lock subclasses,
added in commit 2febdb632bb96235b94b8fccaf882a78f8f4b2bb
('tty: Preset lock subclass for nested tty locks').

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_mutex.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/tty_mutex.c b/drivers/tty/tty_mutex.c
index 4486741..a872389 100644
--- a/drivers/tty/tty_mutex.c
+++ b/drivers/tty/tty_mutex.c
@@ -46,12 +46,8 @@ EXPORT_SYMBOL(tty_unlock);
 
 void __lockfunc tty_lock_slave(struct tty_struct *tty)
 {
-	if (tty && tty != tty->link) {
-		WARN_ON(!mutex_is_locked(&tty->link->legacy_mutex) ||
-			!tty->driver->type == TTY_DRIVER_TYPE_PTY ||
-			!tty->driver->type == PTY_TYPE_SLAVE);
+	if (tty && tty != tty->link)
 		tty_lock(tty);
-	}
 }
 
 void __lockfunc tty_unlock_slave(struct tty_struct *tty)
-- 
2.2.1
