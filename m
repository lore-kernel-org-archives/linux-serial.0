From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 06/10] tty: Remove !tty condition from __proc_set_tty()
Date: Thu, 16 Oct 2014 14:59:46 -0400
Message-ID: <1413485990-16855-7-git-send-email-peter@hurleysoftware.com>
References: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413485990-16855-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The tty parameter to __proc_set_tty() cannot be NULL; all
call sites have already dereferenced tty.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_io.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c224488..e33edfa 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -506,19 +506,18 @@ void proc_clear_tty(struct task_struct *p)
 
 static void __proc_set_tty(struct tty_struct *tty)
 {
-	if (tty) {
-		unsigned long flags;
-		/* We should not have a session or pgrp to put here but.... */
-		spin_lock_irqsave(&tty->ctrl_lock, flags);
-		put_pid(tty->session);
-		put_pid(tty->pgrp);
-		tty->pgrp = get_pid(task_pgrp(current));
-		spin_unlock_irqrestore(&tty->ctrl_lock, flags);
-		tty->session = get_pid(task_session(current));
-		if (current->signal->tty) {
-			printk(KERN_DEBUG "tty not NULL!!\n");
-			tty_kref_put(current->signal->tty);
-		}
+	unsigned long flags;
+
+	/* We should not have a session or pgrp to put here but.... */
+	spin_lock_irqsave(&tty->ctrl_lock, flags);
+	put_pid(tty->session);
+	put_pid(tty->pgrp);
+	tty->pgrp = get_pid(task_pgrp(current));
+	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
+	tty->session = get_pid(task_session(current));
+	if (current->signal->tty) {
+		printk(KERN_DEBUG "tty not NULL!!\n");
+		tty_kref_put(current->signal->tty);
 	}
 	put_pid(current->signal->tty_old_pgrp);
 	current->signal->tty = tty_kref_get(tty);
-- 
2.1.1
