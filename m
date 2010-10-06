From: Mathias Nyman <mathias.nyman@nokia.com>
Subject: [PATCH] serial: 8250.c: Clear FIFOs before enabling them
Date: Wed,  6 Oct 2010 12:35:20 +0300
Message-ID: <1286357720-17351-1-git-send-email-mathias.nyman@nokia.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:35103 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab0JFJdC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Oct 2010 05:33:02 -0400
Received: from nokia.com (localhost [127.0.0.1])
	by mgw-sa02.nokia.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o969X0vW032266
	for <linux-serial@vger.kernel.org>; Wed, 6 Oct 2010 12:33:00 +0300
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@nokia.com>

There's a short time when FIFO's are disabled and interrupts enabled
between startup and set_termios.
If rx FIFO is not cleared before enabled, and there are lots of serial I/O,
an interrupt indicating FIFO data error can occur.
(LSR register bit 7 set, no other error bits set).

The current interrupt handle is unable to clear this interrupt and will continue looping with a
flood of "too much work" messages.

This is seen on an omap board with ST16654 type uart if a key is kept pressed in serial console while
booting.

Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
---
 drivers/serial/8250.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 5ed1b82..d3add25 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2403,6 +2403,8 @@ serial8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (fcr & UART_FCR_ENABLE_FIFO) {
 			/* emulated UARTs (Lucent Venus 167x) need two steps */
 			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
+				    UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 		}
 		serial_outp(up, UART_FCR, fcr);		/* set fcr */
 	}
-- 
1.5.6.5

