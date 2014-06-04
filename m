From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 1/2] serial: core: Don't drop DTR if system console
Date: Wed,  4 Jun 2014 10:16:10 -0400
Message-ID: <1401891371-4946-1-git-send-email-peter@hurleysoftware.com>
References: <7EC4C3FDEFF6492F91DEE16AEE0831E6@vanni.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7EC4C3FDEFF6492F91DEE16AEE0831E6@vanni.it>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Valerio Vanni <valerio.vanni@inwind.it>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

If a tty is opened on a serial console, don't drop DTR on
last tty close, on tty hangup, or when resetting port hardware
via TIOCSSERIAL and TIOCSERCONFIG ioctls.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b68550d..498b149 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -239,7 +239,8 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
-		if (!tty || (tty->termios.c_cflag & HUPCL))
+		if (!uart_console(uport) &&
+		    (!tty || (tty->termios.c_cflag & HUPCL)))
 			uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
 
 		uart_port_shutdown(port);
-- 
1.9.1
