From: Seth Bollinger <sethb@digi.com>
Subject: [PATCH] serial_core: Fix conditional start_tx on ring buffer not empty
Date: Tue, 25 Mar 2014 12:55:37 -0500
Message-ID: <1395770137-26421-1-git-send-email-sethb@digi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.101]:61730 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755907AbaCYRzx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Mar 2014 13:55:53 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter@hurleysoftware.com, Seth Bollinger <sethb@digi.com>

If the serial_core ring buffer empties just as the tty layer receives
an XOFF, then start_tx will never be called when the tty layer
receives an XON as the serial_core ring buffer is empty.  This will
possibly leave a few bytes trapped in the fifo for drivers that
disable the transmitter when flow controlled.

Signed-off-by: Seth Bollinger <sethb@digi.com>
---
 drivers/tty/serial/serial_core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ece2049..b3e5907 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -89,8 +89,7 @@ static void __uart_start(struct tty_struct *tty)
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->uart_port;
 
-	if (!uart_circ_empty(&state->xmit) && state->xmit.buf &&
-	    !tty->stopped && !tty->hw_stopped)
+	if (!tty->stopped && !tty->hw_stopped)
 		port->ops->start_tx(port);
 }
 
-- 
1.7.10.4

