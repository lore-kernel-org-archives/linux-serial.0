From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 1/4] TTY: synclink: fix DTR being raised on hang up
Date: Fri, 12 Apr 2013 10:32:28 +0200
Message-ID: <1365755551-17824-2-git-send-email-jhovold@gmail.com>
References: <1365755551-17824-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365755551-17824-1-git-send-email-jhovold@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, "David S. Miller" <davem@davemloft.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
List-Id: linux-serial@vger.kernel.org

Make sure to check ASYNC_INITIALISED before raising DTR when waking up
from blocked open in block_til_ready.

Currently DTR could get raised at hang up as a blocked process would
raise DTR unconditionally before checking for hang up and returning.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/tty/synclink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 72d6071..8eaf1ab 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -3308,7 +3308,7 @@ static int block_til_ready(struct tty_struct *tty, struct file * filp,
 	port->blocked_open++;
 	
 	while (1) {
-		if (tty->termios.c_cflag & CBAUD)
+		if (C_BAUD(tty) && test_bit(ASYNCB_INITIALIZED, &port->flags))
 			tty_port_raise_dtr_rts(port);
 		
 		set_current_state(TASK_INTERRUPTIBLE);
-- 
1.8.1.5
