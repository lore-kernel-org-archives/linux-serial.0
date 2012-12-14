From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 04/11] tty: Refactor n_tty_flush_buffer
Date: Fri, 14 Dec 2012 13:22:43 -0500
Message-ID: <1355509370-5883-5-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ilya Zykov <ilya@ilyx.ru>, Sasha Levin <levinsasha928@gmail.com>, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Factor out the packet mode status change for use by follow-on patch.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 3f704a9..41e58bf 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -237,6 +237,18 @@ static void reset_buffer_flags(struct tty_struct *tty)
 	n_tty_set_room(tty);
 }
 
+static void packet_mode_flush(struct tty_struct *tty)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&tty->ctrl_lock, flags);
+	if (tty->link->packet) {
+		tty->ctrl_status |= TIOCPKT_FLUSHREAD;
+		wake_up_interruptible(&tty->link->read_wait);
+	}
+	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
+}
+
 /**
  *	n_tty_flush_buffer	-	clean input queue
  *	@tty:	terminal device
@@ -251,19 +263,11 @@ static void reset_buffer_flags(struct tty_struct *tty)
 
 static void n_tty_flush_buffer(struct tty_struct *tty)
 {
-	unsigned long flags;
 	/* clear everything and unthrottle the driver */
 	reset_buffer_flags(tty);
 
-	if (!tty->link)
-		return;
-
-	spin_lock_irqsave(&tty->ctrl_lock, flags);
-	if (tty->link->packet) {
-		tty->ctrl_status |= TIOCPKT_FLUSHREAD;
-		wake_up_interruptible(&tty->link->read_wait);
-	}
-	spin_unlock_irqrestore(&tty->ctrl_lock, flags);
+	if (tty->link)
+		packet_mode_flush(tty);
 }
 
 /**
-- 
1.8.0.1
