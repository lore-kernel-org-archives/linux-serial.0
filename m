From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 02/32] n_tty: Factor packet mode status change for reuse
Date: Wed, 20 Feb 2013 15:02:49 -0500
Message-ID: <1361390599-15195-3-git-send-email-peter@hurleysoftware.com>
References: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361390599-15195-1-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
References: <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Shawn Guo <shawn.guo@linaro.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Factor the packet mode status change from n_tty_flush_buffer
for use by follow-on patch.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 9c18e37..4d3ab2c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -238,6 +238,18 @@ static void reset_buffer_flags(struct tty_struct *tty)
 	n_tty_set_room(tty);
 }
 
+static void n_tty_packet_mode_flush(struct tty_struct *tty)
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
@@ -252,19 +264,11 @@ static void reset_buffer_flags(struct tty_struct *tty)
 
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
+		n_tty_packet_mode_flush(tty);
 }
 
 /**
-- 
1.8.1.2
