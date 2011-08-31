From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/4] TTY: serial, fix locking imbalance
Date: Wed, 31 Aug 2011 21:24:56 +0200
Message-ID: <1314818699-10873-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.pripojeni.net ([178.22.112.14]:42892 "EHLO
	smtp.pripojeni.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab1HaTZH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Aug 2011 15:25:07 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com

Commit "TTY: serial, move locking in uart_close" moved the lock, but
omitted to update branches which unlock the lock. Now they try to
unlock the lock without holding it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
If possible, please, merge this into the patch mentioned above (it's
not upstream yet).

 drivers/tty/serial/serial_core.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 5c04cb9..c0fdbc5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1262,7 +1262,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 	if (tty_hung_up_p(filp)) {
 		spin_unlock_irqrestore(&port->lock, flags);
-		goto done;
+		return;
 	}
 
 	if ((tty->count == 1) && (port->count != 1)) {
@@ -1284,7 +1284,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	}
 	if (port->count) {
 		spin_unlock_irqrestore(&port->lock, flags);
-		goto done;
+		return;
 	}
 
 	/*
@@ -1347,7 +1347,6 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	wake_up_interruptible(&port->open_wait);
 	wake_up_interruptible(&port->close_wait);
 
-done:
 	mutex_unlock(&port->mutex);
 }
 
-- 
1.7.6.1


