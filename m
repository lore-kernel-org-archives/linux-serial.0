From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 18/48] serial: core, move termios handling to uart_startup
Date: Mon, 23 May 2011 12:10:24 -0700
Message-ID: <1306177854-18172-18-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42041 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTKt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:49 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

We should not fiddle with speed and cflags in .dtr_rts hook. Actually
we might not have tty at that moment already.

So move the console cflag copy and speed setup into uart_startup.
Actually the speed setup is already there, but we need to call it
unconditionally (uart_startup is called from uart_open with hw_init =
0).

This means we move uart_change_speed before dtr/rts setup in .dtr_rts.
But this should not matter as the setup should be called after
uart_change_speed anyway.
Before:                             After:
dtr/rts setup (dtr_rts)             uart_change_speed (startup)
uart_change_speed (update_termios)  dtr/rts setup (dtr_rts)
dtr/rts setup (update_termios)      dtr/rts setup (update_termios)

The second setup will dismiss with the next patch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d6e7240..47657cf 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -172,12 +172,16 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state, int in
 
 	retval = uport->ops->startup(uport);
 	if (retval == 0) {
-		if (init_hw) {
-			/*
-			 * Initialise the hardware port settings.
-			 */
-			uart_change_speed(tty, state, NULL);
+		if (uart_console(uport) && uport->cons->cflag) {
+			tty->termios->c_cflag = uport->cons->cflag;
+			uport->cons->cflag = 0;
+		}
+		/*
+		 * Initialise the hardware port settings.
+		 */
+		uart_change_speed(tty, state, NULL);
 
+		if (init_hw) {
 			/*
 			 * Setup the RTS and DTR signals once the
 			 * port is open and ready to respond.
@@ -1481,11 +1485,6 @@ static void uart_update_termios(struct tty_struct *tty,
 {
 	struct uart_port *port = state->uart_port;
 
-	if (uart_console(port) && port->cons->cflag) {
-		tty->termios->c_cflag = port->cons->cflag;
-		port->cons->cflag = 0;
-	}
-
 	/*
 	 * If the device failed to grab its irq resources,
 	 * or some other error occurred, don't try to talk
@@ -1493,11 +1492,6 @@ static void uart_update_termios(struct tty_struct *tty,
 	 */
 	if (!(tty->flags & (1 << TTY_IO_ERROR))) {
 		/*
-		 * Make termios settings take effect.
-		 */
-		uart_change_speed(tty, state, NULL);
-
-		/*
 		 * And finally enable the RTS and DTR signals.
 		 */
 		if (tty->termios->c_cflag & CBAUD)
-- 
1.7.4.2

