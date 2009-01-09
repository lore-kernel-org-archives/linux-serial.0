From: akpm@linux-foundation.org
Subject: [patch 2/3] atmel_serial might lose modem status change
Date: Fri, 09 Jan 2009 14:17:41 -0800
Message-ID: <200901092217.n09MHfmS021131@imap1.linux-foundation.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40709 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932207AbZAIWTy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Jan 2009 17:19:54 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, anemo@mba.ocn.ne.jp, hskinnemoen@atmel.com, linux@bohmer.net, marc.pignat@hevs.ch

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

I found a problem of handling of modem status of atmel_serial driver.

With the commit 1ecc26 ("atmel_serial: split the interrupt handler"),
handling of modem status signal was splitted into two parts.  The
atmel_tasklet_func() compares new status with irq_status_prev, but
irq_status_prev is not correct if signal status was changed while the port
is closed.

Here is a sequence to cause problem:

1. Remote side sets CTS (and DSR).
2. Local side close the port.
3. Local side clears RTS and DTR.
4. Remote side clears CTS and DSR.
5. Local side reopen the port.  hw_stopped becomes 1.
6. Local side sets RTS and DTR.
7. Remote side sets CTS and DSR.

Then CTS change interrupt can be received, but since CTS bit in
irq_status_prev and new status is same, uart_handle_cts_change() will not
be called (so hw_stopped will not be cleared, i.e.  cannot send any data).

I suppose irq_status_prev should be initialized at somewhere in open
sequence.

Acked-by: Remy Bohmer <linux@bohmer.net>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Marc Pignat <marc.pignat@hevs.ch>
Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/serial/atmel_serial.c |    3 +++
 1 file changed, 3 insertions(+)

diff -puN drivers/serial/atmel_serial.c~atmel_serial-might-lose-modem-status-change drivers/serial/atmel_serial.c
--- a/drivers/serial/atmel_serial.c~atmel_serial-might-lose-modem-status-change
+++ a/drivers/serial/atmel_serial.c
@@ -877,6 +877,9 @@ static int atmel_startup(struct uart_por
 		}
 	}
 
+	/* Save current CSR for comparison in atmel_tasklet_func() */
+	atmel_port->irq_status_prev = UART_GET_CSR(port);
+
 	/*
 	 * Finally, enable the serial port
 	 */
_
