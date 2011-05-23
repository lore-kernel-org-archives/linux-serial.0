From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 20/48] serial: core, remove uart_update_termios
Date: Mon, 23 May 2011 12:10:26 -0700
Message-ID: <1306177854-18172-20-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42046 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab1EWTK4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:10:56 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

Now, uart_update_termios is empty, so it's time to remove it. We no
longer need a live tty in .dtr_rts. So this should prune all the bugs
where tty is zeroed in port->tty during tty_port_block_til_ready.

There is one thing to note. We don't set ASYNC_NORMAL_ACTIVE now. It's
because this is done already in tty_port_block_til_ready.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |   25 +------------------------
 1 files changed, 1 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3aae8ed..d4bd465 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1470,21 +1470,6 @@ static void uart_hangup(struct tty_struct *tty)
 	mutex_unlock(&port->mutex);
 }
 
-/**
- *	uart_update_termios	-	update the terminal hw settings
- *	@tty: tty associated with UART
- *	@state: UART to update
- *
- *	Copy across the serial console cflag setting into the termios settings
- *	for the initial open of the port.  This allows continuity between the
- *	kernel settings, and the settings init adopts when it opens the port
- *	for the first time.
- */
-static void uart_update_termios(struct tty_struct *tty,
-						struct uart_state *state)
-{
-}
-
 static int uart_carrier_raised(struct tty_port *port)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
@@ -1504,16 +1489,8 @@ static void uart_dtr_rts(struct tty_port *port, int onoff)
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport = state->uart_port;
 
-	if (onoff) {
+	if (onoff)
 		uart_set_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
-
-		/*
-		 * If this is the first open to succeed,
-		 * adjust things to suit.
-		 */
-		if (!test_and_set_bit(ASYNCB_NORMAL_ACTIVE, &port->flags))
-			uart_update_termios(port->tty, state);
-	}
 	else
 		uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
 }
-- 
1.7.4.2

