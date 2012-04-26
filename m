From: Christian Melki <christian.melki@ericsson.com>
Subject: [PATCH] 8250.c: less than 2400 baud fix.
Date: Thu, 26 Apr 2012 08:59:50 +0200
Message-ID: <1346E68D3A5B2043907CF4BF466383411A07E00DBB@ESESSCMS0353.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailgw7.ericsson.se ([193.180.251.48]:63816 "EHLO
	mailgw7.ericsson.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab2DZHOx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2012 03:14:53 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

From: Christian Melki <christian.melki@ericsson.se>

We noticed that we were loosing data at speed less than 2400 baud.
It turned out our (TI16750 compatible) uart with 64 byte outgoing fifo was truncated to 16 byte (bit 5 sets fifo len) when modifying the fcr reg.
The input code still fills the buffer with 64 bytes if I remember correctly and thus data is lost.
Our fix was to remove whiping of the fcr content and just add the TRIGGER_1 which we want for latency.
I can't see why this would not work on less than 2400 always, for all uarts...
Otherwise one would have to make sure the filling of the fifo re-checks the current state of available fifo size (urrk).

Signed-off-by: Christian Melki <christian.melki@ericsson.se>
---

diff -urpN linux-3.3.2.orig//drivers/tty/serial/8250/8250.c linux-3.3.2/drivers/tty/serial/8250/8250.c
--- linux-3.3.2.orig//drivers/tty/serial/8250/8250.c	2012-04-25 10:31:29.000000000 +0200
+++ linux-3.3.2/drivers/tty/serial/8250/8250.c	2012-04-26 08:46:29.000000000 +0200
@@ -2299,10 +2299,11 @@ serial8250_do_set_termios(struct uart_po
 		quot++;
 
 	if (up->capabilities & UART_CAP_FIFO && up->port.fifosize > 1) {
-		if (baud < 2400)
-			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
-		else
-			fcr = uart_config[up->port.type].fcr;
+		fcr = uart_config[up->port.type].fcr;
+		if (baud < 2400) {
+			fcr &= ~UART_FCR_TRIGGER_MASK;
+			fcr |= UART_FCR_TRIGGER_1;
+		}
 	}
 
 	/*


