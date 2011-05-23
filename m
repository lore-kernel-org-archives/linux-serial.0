From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 19/48] serial: core, do not set DTR/RTS twice on startup
Date: Mon, 23 May 2011 12:10:25 -0700
Message-ID: <1306177854-18172-19-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47297 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTKw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:52 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

In .dtr_rts we do:
  uart_set_mctrl(uport, TIOCM_DTR | TIOCM_RTS)
and call uart_update_termios. It does:
  uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS)
once again. As the only callsite of uart_update_termios is .dtr_rts,
remove the uart_set_mctrl from uart_update_termios to not set it twice.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 47657cf..3aae8ed 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1483,20 +1483,6 @@ static void uart_hangup(struct tty_struct *tty)
 static void uart_update_termios(struct tty_struct *tty,
 						struct uart_state *state)
 {
-	struct uart_port *port = state->uart_port;
-
-	/*
-	 * If the device failed to grab its irq resources,
-	 * or some other error occurred, don't try to talk
-	 * to the port hardware.
-	 */
-	if (!(tty->flags & (1 << TTY_IO_ERROR))) {
-		/*
-		 * And finally enable the RTS and DTR signals.
-		 */
-		if (tty->termios->c_cflag & CBAUD)
-			uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
-	}
 }
 
 static int uart_carrier_raised(struct tty_port *port)
-- 
1.7.4.2

