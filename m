From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 7/9] tty: Allow unreadable mess to be > 80 chars
Date: Sun, 10 Jan 2016 20:36:14 -0800
Message-ID: <1452486976-7594-8-git-send-email-peter@hurleysoftware.com>
References: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 846ed48..a76aec2 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -510,10 +510,8 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 
 	if (port->blocked_open) {
 		spin_unlock_irqrestore(&port->lock, flags);
-		if (port->close_delay) {
-			msleep_interruptible(
-				jiffies_to_msecs(port->close_delay));
-		}
+		if (port->close_delay)
+			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		spin_lock_irqsave(&port->lock, flags);
 		wake_up_interruptible(&port->open_wait);
 	}
-- 
2.7.0
