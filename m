From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] TTY: serial_core, fix dtr_rts NULL dereference
Date: Fri, 25 Mar 2011 11:45:56 +0100
Message-ID: <1301049956-6933-1-git-send-email-jslaby@suse.cz>
References: <4D8C7253.3040204@suse.cz>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.pripojeni.net ([217.66.174.14]:44322 "EHLO
	smtp.pripojeni.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934195Ab1CYKqG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Mar 2011 06:46:06 -0400
In-Reply-To: <4D8C7253.3040204@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: linux-serial@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Under certain circumstances uart_dtr_rts might cause an oops. It dies
because port->tty is NULL. To fix this, let's take a reference of
port->tty by tty_port_tty_get. And if it is not there already, fail
gracefully.

After all, indeed drop the reference.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Greg KH <gregkh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/tty/serial/serial_core.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d6e7240..88a0472 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1531,8 +1531,12 @@ static void uart_dtr_rts(struct tty_port *port, int onoff)
 		 * If this is the first open to succeed,
 		 * adjust things to suit.
 		 */
-		if (!test_and_set_bit(ASYNCB_NORMAL_ACTIVE, &port->flags))
-			uart_update_termios(port->tty, state);
+		if (!test_and_set_bit(ASYNCB_NORMAL_ACTIVE, &port->flags)) {
+			struct tty_struct *tty = tty_port_tty_get(port);
+			if (tty)
+				uart_update_termios(tty, state);
+			tty_kref_put(tty);
+		}
 	}
 	else
 		uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
-- 
1.7.4.1


