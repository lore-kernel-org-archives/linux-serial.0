From: Chun Chen <chunchen@cs.utah.edu>
Subject: 8250.c faster baud rate for Socket CF Bluetooth Card
Date: Sun, 1 Mar 2009 14:19:23 -0700
Message-ID: <20090301141923.760e29db@cs.utah.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/kocXoBsr4YpxTt7cl9Nzmh="
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:45737 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbZCAV0o (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Mar 2009 16:26:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 8595A6500BA
	for <linux-serial@vger.kernel.org>; Sun,  1 Mar 2009 14:19:20 -0700 (MST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

--MP_/kocXoBsr4YpxTt7cl9Nzmh=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I have a Socket Compact Flash Bluetooth Card Rev. G.   It requires
serial port with at least baud rate 230,400 to make it work.  There is a
patch file (attched) according to
http://www.adamis.de/linux/bt-socket.html that solves the problem.  Is
it possible such change merge into future 8250.c linux kernel release.

Thanks,
Chun

--MP_/kocXoBsr4YpxTt7cl9Nzmh=
Content-Type: text/x-patch; name=serial_8250.c_2.6.17.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=serial_8250.c_2.6.17.patch

--- linux/drivers/serial/8250.c.orig	2006-06-30 19:37:38.000000000 +0200
+++ linux/drivers/serial/8250.c	2006-07-01 19:19:49.000000000 +0200
@@ -7,6 +7,9 @@
  *
  *  Copyright (C) 2001 Russell King.
  *
+ *  2005/09/16: Enabled higher baud rates for 16C95x.
+ *		(Mathias Adam <a2@adamis.de>)
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -1745,6 +1748,14 @@
 	else if ((port->flags & UPF_MAGIC_MULTIPLIER) &&
 		 baud == (port->uartclk/8))
 		quot = 0x8002;
+	/*
+	 * For 16C950s UART_TCR is used in combination with divisor==1
+	 * to achieve baud rates up to baud_base*4.
+	 */
+	else if ((port->type == PORT_16C950) &&
+		 baud > (port->uartclk/16))
+		quot = 1;
+
 	else
 		quot = uart_get_divisor(port, baud);
 
@@ -1758,7 +1769,7 @@
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 	unsigned char cval, fcr = 0;
 	unsigned long flags;
-	unsigned int baud, quot;
+	unsigned int baud, quot, max_baud;
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
@@ -1790,7 +1801,8 @@
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 */
-	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
+	max_baud = (up->port.type == PORT_16C950 ? port->uartclk/4 : port->uartclk/16);
+	baud = uart_get_baud_rate(port, termios, old, 0, max_baud); 
 	quot = serial8250_get_divisor(port, baud);
 
 	/*
@@ -1826,6 +1838,19 @@
 	 */
 	spin_lock_irqsave(&up->port.lock, flags);
 
+	/* 
+	 * 16C950 supports additional prescaler ratios between 1:16 and 1:4
+	 * thus increasing max baud rate to uartclk/4.
+	 */
+	if (up->port.type == PORT_16C950) {
+		if (baud == port->uartclk/4)
+			serial_icr_write(up, UART_TCR, 0x4);
+		else if (baud == port->uartclk/8)
+			serial_icr_write(up, UART_TCR, 0x8);
+		else
+			serial_icr_write(up, UART_TCR, 0);
+	}
+	
 	/*
 	 * Update the per-port timeout.
 	 */

--MP_/kocXoBsr4YpxTt7cl9Nzmh=--
