From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/6] serial: max310x: Setup baud rate generator more precisely
Date: Fri,  7 Feb 2014 18:16:04 +0400
Message-ID: <1391782568-19442-3-git-send-email-shc_work@mail.ru>
References: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:54178 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbaBGOQg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Feb 2014 09:16:36 -0500
Received: from smtp48.i.mail.ru (smtp48.i.mail.ru [94.100.177.108])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id 018A34FF3FB6
	for <linux-serial@vger.kernel.org>; Fri,  7 Feb 2014 18:16:33 +0400 (MSK)
In-Reply-To: <1391782568-19442-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch provide more precisely setup of baud rate generator.
If the result of division has a remainder, we use the multiplier
for the base frequency. Additionally, we report result baud rate
back to serial core.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/max310x.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 8d71e40..313bdf0 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1,7 +1,7 @@
 /*
  *  Maxim (Dallas) MAX3107/8/9, MAX14830 serial driver
  *
- *  Copyright (C) 2012-2013 Alexander Shiyan <shc_work@mail.ru>
+ *  Copyright (C) 2012-2014 Alexander Shiyan <shc_work@mail.ru>
  *
  *  Based on max3100.c, by Christian Pellegrin <chripell@evolware.org>
  *  Based on max3110.c, by Feng Tang <feng.tang@intel.com>
@@ -504,25 +504,33 @@ static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 	return false;
 }
 
-static void max310x_set_baud(struct uart_port *port, int baud)
+static int max310x_set_baud(struct uart_port *port, int baud)
 {
-	unsigned int mode = 0, div = port->uartclk / baud;
+	unsigned int mode = 0, clk = port->uartclk, div = clk / baud;
 
-	if (!(div / 16)) {
+	/* Check for minimal value for divider */
+	if (div < 16)
+		div = 16;
+
+	if (clk % baud && (div / 16) < 0x8000) {
 		/* Mode x2 */
 		mode = MAX310X_BRGCFG_2XMODE_BIT;
-		div = (port->uartclk * 2) / baud;
-	}
-
-	if (!(div / 16)) {
-		/* Mode x4 */
-		mode = MAX310X_BRGCFG_4XMODE_BIT;
-		div = (port->uartclk * 4) / baud;
+		clk = port->uartclk * 2;
+		div = clk / baud;
+
+		if (clk % baud && (div / 16) < 0x8000) {
+			/* Mode x4 */
+			mode = MAX310X_BRGCFG_4XMODE_BIT;
+			clk = port->uartclk * 4;
+			div = clk / baud;
+		}
 	}
 
 	max310x_port_write(port, MAX310X_BRGDIVMSB_REG, (div / 16) >> 8);
 	max310x_port_write(port, MAX310X_BRGDIVLSB_REG, div / 16);
 	max310x_port_write(port, MAX310X_BRGCFG_REG, (div % 16) | mode);
+
+	return DIV_ROUND_CLOSEST(clk, div);
 }
 
 static int max310x_update_best_err(unsigned long f, long *besterr)
@@ -875,7 +883,7 @@ static void max310x_set_termios(struct uart_port *port,
 				  port->uartclk / 4);
 
 	/* Setup baudrate generator */
-	max310x_set_baud(port, baud);
+	baud = max310x_set_baud(port, baud);
 
 	/* Update timeout according to new baud rate */
 	uart_update_timeout(port, termios->c_cflag, baud);
-- 
1.8.3.2

