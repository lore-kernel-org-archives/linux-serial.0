From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 4/9] staging: dgap: Remove redundant write_wait wakeups
Date: Sun, 10 Jan 2016 20:36:11 -0800
Message-ID: <1452486976-7594-5-git-send-email-peter@hurleysoftware.com>
References: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Waking the write_wait queue is exactly what tty_wakeup() does;
remove the open-coded wakeups.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/staging/dgap/dgap.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/dgap/dgap.c b/drivers/staging/dgap/dgap.c
index dfbae21..5413ed8 100644
--- a/drivers/staging/dgap/dgap.c
+++ b/drivers/staging/dgap/dgap.c
@@ -3155,8 +3155,6 @@ static void dgap_tty_flush_buffer(struct tty_struct *tty)
 
 	spin_unlock_irqrestore(&ch->ch_lock, lock_flags2);
 	spin_unlock_irqrestore(&bd->bd_lock, lock_flags);
-	if (waitqueue_active(&tty->write_wait))
-		wake_up_interruptible(&tty->write_wait);
 	tty_wakeup(tty);
 }
 
@@ -4953,10 +4951,6 @@ static int dgap_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 			ch->ch_pun.un_flags &= ~(UN_LOW | UN_EMPTY);
 			wake_up_interruptible(&ch->ch_pun.un_flags_wait);
 		}
-		if (waitqueue_active(&tty->write_wait))
-			wake_up_interruptible(&tty->write_wait);
-
-		/* Can't hold any locks when calling tty_wakeup! */
 		spin_unlock_irqrestore(&ch->ch_lock, lock_flags2);
 		spin_unlock_irqrestore(&bd->bd_lock, lock_flags);
 		tty_wakeup(tty);
-- 
2.7.0
