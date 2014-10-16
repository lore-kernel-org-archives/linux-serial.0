From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 06/10] serial: core: Unwrap >80 char line in uart_close()
Date: Thu, 16 Oct 2014 16:54:23 -0400
Message-ID: <1413492867-20679-7-git-send-email-peter@hurleysoftware.com>
References: <1413492867-20679-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413492867-20679-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The wrapped line looks wrong and out-of-place; leave it as
>80 char line.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6ebe78c..be58916 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1373,8 +1373,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	if (port->blocked_open) {
 		spin_unlock_irqrestore(&port->lock, flags);
 		if (port->close_delay)
-			msleep_interruptible(
-					jiffies_to_msecs(port->close_delay));
+			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		spin_lock_irqsave(&port->lock, flags);
 	} else if (!uart_console(uport)) {
 		spin_unlock_irqrestore(&port->lock, flags);
-- 
2.1.1
