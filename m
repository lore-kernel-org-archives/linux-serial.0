From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 5/9] pty: Don't claim slave's ctrl_lock for master's packet mode
Date: Thu, 16 Oct 2014 15:33:26 -0400
Message-ID: <1413488010-16885-6-git-send-email-peter@hurleysoftware.com>
References: <1413488010-16885-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413488010-16885-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The slave's ctrl_lock serializes updates to the ctrl_status field
only, whereas the master's ctrl_lock serializes updates to the
packet mode enable (ie., the master does not have ctrl_status and
the slave does not have packet mode). Thus, claiming the slave's
ctrl_lock to access ->packet is useless.

Unlocked reads of ->packet are already smp-safe.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 4 ++--
 drivers/tty/pty.c   | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 53cdfbe..6a42204 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -351,13 +351,13 @@ static void n_tty_packet_mode_flush(struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&tty->ctrl_lock, flags);
 	if (tty->link->packet) {
+		spin_lock_irqsave(&tty->ctrl_lock, flags);
 		tty->ctrl_status |= TIOCPKT_FLUSHREAD;
+		spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 		if (waitqueue_active(&tty->link->read_wait))
 			wake_up_interruptible(&tty->link->read_wait);
 	}
-	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 }
 
 /**
diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 29b5eeb..e554393 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -339,26 +339,26 @@ static void pty_start(struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&tty->ctrl_lock, flags);
 	if (tty->link && tty->link->packet) {
+		spin_lock_irqsave(&tty->ctrl_lock, flags);
 		tty->ctrl_status &= ~TIOCPKT_STOP;
 		tty->ctrl_status |= TIOCPKT_START;
+		spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 		wake_up_interruptible_poll(&tty->link->read_wait, POLLIN);
 	}
-	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 }
 
 static void pty_stop(struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&tty->ctrl_lock, flags);
 	if (tty->link && tty->link->packet) {
+		spin_lock_irqsave(&tty->ctrl_lock, flags);
 		tty->ctrl_status &= ~TIOCPKT_START;
 		tty->ctrl_status |= TIOCPKT_STOP;
+		spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 		wake_up_interruptible_poll(&tty->link->read_wait, POLLIN);
 	}
-	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
 }
 
 /**
-- 
2.1.1
