From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 4/4] TTY: ircomm: fix DTR being raised on hang up
Date: Fri, 12 Apr 2013 10:32:31 +0200
Message-ID: <1365755551-17824-5-git-send-email-jhovold@gmail.com>
References: <1365755551-17824-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365755551-17824-1-git-send-email-jhovold@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, "David S. Miller" <davem@davemloft.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
List-Id: linux-serial@vger.kernel.org

Make sure to check ASYNC_INITIALISED before raising DTR when waking up
from blocked open in ircomm_tty_block_til_ready.

Currently DTR could get raised at hang up as a blocked process would
raise DTR unconditionally before checking for hang up and returning.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 net/irda/ircomm/ircomm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index 362ba47..41ac7938 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -328,7 +328,7 @@ static int ircomm_tty_block_til_ready(struct ircomm_tty_cb *self,
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	while (1) {
-		if (tty->termios.c_cflag & CBAUD)
+		if (C_BAUD(tty) && test_bit(ASYNCB_INITIALIZED, &port->flags))
 			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
-- 
1.8.1.5
