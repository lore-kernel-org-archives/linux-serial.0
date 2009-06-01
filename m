From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 6/9] serial: workaround TI AR7 silicon bug
Date: Mon, 1 Jun 2009 14:01:15 +0200
Message-ID: <200906011401.15991.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:39412 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbZFAMBR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Jun 2009 08:01:17 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, akpm <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

This patch make the serial8250_console_putchar work
on TI AR7 hardware which has a hardware bug clobbering
serial characters resulting in an almost unusable
kernel console.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 03376b0..16b5a7e 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2694,7 +2694,11 @@ static void serial8250_console_putchar(struct uart_port *port, int ch)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 
+#ifdef CONFIG_AR7
+	wait_for_xmitr(up, BOTH_EMPTY);
+#else
 	wait_for_xmitr(up, UART_LSR_THRE);
+#endif
 	serial_out(up, UART_TX, ch);
 }
 
