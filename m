From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH v3 2/6] TTY: wake up processes last at hangup
Date: Thu,  7 Mar 2013 15:55:49 +0100
Message-ID: <1362668153-10972-3-git-send-email-jhovold@gmail.com>
References: <51361724.4050107@suse.cz>
 <1362668153-10972-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362668153-10972-1-git-send-email-jhovold@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
List-Id: linux-serial@vger.kernel.org

Move wake up of processes on blocked-open and modem-status wait queues
to after port shutdown at hangup.

This way the woken up processes can use the ASYNC_INITIALIZED flag to
detect port shutdown.

Note that this is the order currently used by serial-core.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/tty/tty_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 57a061e..3de5918 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -231,9 +231,9 @@ void tty_port_hangup(struct tty_port *port)
 	}
 	port->tty = NULL;
 	spin_unlock_irqrestore(&port->lock, flags);
+	tty_port_shutdown(port);
 	wake_up_interruptible(&port->open_wait);
 	wake_up_interruptible(&port->delta_msr_wait);
-	tty_port_shutdown(port);
 }
 EXPORT_SYMBOL(tty_port_hangup);
 
-- 
1.8.1.1
