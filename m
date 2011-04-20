From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 7/7] TTY: tty_io, annotate locking functions
Date: Wed, 20 Apr 2011 10:43:18 +0200
Message-ID: <1303288998-31718-7-git-send-email-jslaby@suse.cz>
References: <1303288998-31718-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303288998-31718-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

tty_write_lock and tty_write_unlock contain imbalanced locking. But
this is intentional, so mark them appropriately by
__acquires/__releases.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_io.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 0bcf388..7721d6d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -964,12 +964,14 @@ static ssize_t tty_read(struct file *file, char __user *buf, size_t count,
 }
 
 void tty_write_unlock(struct tty_struct *tty)
+	__releases(&tty->atomic_write_lock)
 {
 	mutex_unlock(&tty->atomic_write_lock);
 	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
 }
 
 int tty_write_lock(struct tty_struct *tty, int ndelay)
+	__acquires(&tty->atomic_write_lock)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
-- 
1.7.4.2
