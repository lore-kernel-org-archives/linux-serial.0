From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH v3 3/6] TTY: fix DTR being raised on hang up
Date: Thu,  7 Mar 2013 15:55:50 +0100
Message-ID: <1362668153-10972-4-git-send-email-jhovold@gmail.com>
References: <51361724.4050107@suse.cz>
 <1362668153-10972-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362668153-10972-1-git-send-email-jhovold@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
List-Id: linux-serial@vger.kernel.org

Make sure to check ASYNC_INITIALISED before raising DTR when waking up
from blocked open in tty_port_block_til_ready.

Currently DTR could get raised at hang up as a blocked process would
raise DTR unconditionally before checking for hang up and returning.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/tty/tty_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 3de5918..52f1066 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -355,7 +355,7 @@ int tty_port_block_til_ready(struct tty_port *port,
 
 	while (1) {
 		/* Indicate we are open */
-		if (tty->termios.c_cflag & CBAUD)
+		if (C_BAUD(tty) && test_bit(ASYNCB_INITIALIZED, &port->flags))
 			tty_port_raise_dtr_rts(port);
 
 		prepare_to_wait(&port->open_wait, &wait, TASK_INTERRUPTIBLE);
-- 
1.8.1.1
