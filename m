From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH] serial: 8250_core: use pre-decrement for iteration limit
Date: Mon, 13 Oct 2014 17:09:11 +0200
Message-ID: <1413212951-20901-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:41319 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbaJMPJX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Oct 2014 11:09:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frans Klaver <frans.klaver@xsens.com>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

In serial8250_rx_chars(), max_count is set to 256. Due to the
post-decrement operator used in the while() condition, the maximum
number of iterations actually 257. This is not a problem, but it is
mildly surprising if you're debugging. Use pre-decrement instead.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a06084d..cc9f1a8 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1485,7 +1485,7 @@ serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
 
 ignore_char:
 		lsr = serial_in(up, UART_LSR);
-	} while ((lsr & (UART_LSR_DR | UART_LSR_BI)) && (max_count-- > 0));
+	} while ((lsr & (UART_LSR_DR | UART_LSR_BI)) && (--max_count > 0));
 	spin_unlock(&port->lock);
 	tty_flip_buffer_push(&port->state->port);
 	spin_lock(&port->lock);
-- 
2.1.0

