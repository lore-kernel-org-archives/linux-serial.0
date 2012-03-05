From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 61/68] TTY: amiserial, use tty_port_close_end
Date: Mon,  5 Mar 2012 14:52:48 +0100
Message-ID: <1330955575-26641-62-git-send-email-jslaby@suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

Hmm, the code was sleeping with interrupts disabled. This was not
good. Fix this by turning interrupts at an appropriate place. (The
race is protected by CLOSING flag.)

After the move, the code is identical to tty_port_close_end, so use
it!

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/amiserial.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 8cc8e15..9c8b199 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1433,6 +1433,7 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
+	local_irq_restore(flags);
 	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, port->closing_wait);
 	/*
@@ -1461,17 +1462,9 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 	rs_flush_buffer(tty);
 		
 	tty_ldisc_flush(tty);
-	tty->closing = 0;
 	port->tty = NULL;
-	if (port->blocked_open) {
-		if (port->close_delay) {
-			msleep_interruptible(jiffies_to_msecs(port->close_delay));
-		}
-		wake_up_interruptible(&port->open_wait);
-	}
-	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
-	wake_up_interruptible(&port->close_wait);
-	local_irq_restore(flags);
+
+	tty_port_close_end(port, tty);
 }
 
 /*
-- 
1.7.9.2
