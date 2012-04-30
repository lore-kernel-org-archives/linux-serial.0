From: Christian Melki <christian.melki@ericsson.com>
Subject: RE: [PATCH] 8250.c: less than 2400 baud fix.
Date: Mon, 30 Apr 2012 11:21:26 +0200
Message-ID: <1346E68D3A5B2043907CF4BF466383411A07E01243@ESESSCMS0353.eemea.ericsson.se>
References: <1346E68D3A5B2043907CF4BF466383411A07E00DBB@ESESSCMS0353.eemea.ericsson.se>
 <20120430020710.GA18098@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailgw2.ericsson.se ([193.180.251.37]:60246 "EHLO
	mailgw2.ericsson.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525Ab2D3JV3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Apr 2012 05:21:29 -0400
In-Reply-To: <20120430020710.GA18098@kroah.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Sorry about that.

Diff should have handled that simple line offset. Now it applies cleanly to my linux-next atleast.

Signed-off-by: Christian Melki <christian.melki@ericsson.se>
---

diff -urpN linux-next.orig/drivers/tty/serial/8250/8250.c linux-next/drivers/tty/serial/8250/8250.c
--- linux-next.orig/drivers/tty/serial/8250/8250.c	2012-04-30 10:58:13.000000000 +0200
+++ linux-next/drivers/tty/serial/8250/8250.c	2012-04-30 11:03:12.000000000 +0200
@@ -2259,10 +2259,11 @@ serial8250_do_set_termios(struct uart_po
 		quot++;
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
-		if (baud < 2400)
-			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
-		else
-			fcr = uart_config[port->type].fcr;
+		fcr = uart_config[port->type].fcr;
+		if (baud < 2400) {
+			fcr &= ~UART_FCR_TRIGGER_MASK;
+			fcr |= UART_FCR_TRIGGER_1;
+		}
 	}
 
 	/*
