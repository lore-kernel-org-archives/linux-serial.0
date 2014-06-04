From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 2/2] serial: core: Preserve termios c_cflag for console resume
Date: Wed,  4 Jun 2014 10:16:11 -0400
Message-ID: <1401891371-4946-2-git-send-email-peter@hurleysoftware.com>
References: <7EC4C3FDEFF6492F91DEE16AEE0831E6@vanni.it>
 <1401891371-4946-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401891371-4946-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Valerio Vanni <valerio.vanni@inwind.it>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

When a tty is opened for the serial console, the termios c_cflag
settings are inherited from the console line settings.
However, if the tty is subsequently closed, the termios settings
are lost. This results in a garbled console if the console is later
suspended and resumed.

Preserve the termios c_cflag for the serial console when the tty
is shutdown; this reflects the most recent line settings.

Fixes: Bugzilla #69751, 'serial console does not wake from S3'
Reported-by: Valerio Vanni <valerio.vanni@inwind.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 498b149..a67861c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -239,6 +239,9 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
+		if (uart_console(uport) && tty)
+			uport->cons->cflag = tty->termios.c_cflag;
+
 		if (!uart_console(uport) &&
 		    (!tty || (tty->termios.c_cflag & HUPCL)))
 			uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
-- 
1.9.1
