From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] serial-uartlite: Initialize port parameters in console_setup
Date: Wed, 15 Nov 2006 21:21:04 +0100
Message-ID: <87hcx0bgwf.fsf@slug.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outmx004.isp.belgacom.be ([195.238.4.101]:7569 "EHLO
	outmx004.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030964AbWKOUVZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Nov 2006 15:21:25 -0500
Received: from outmx004.isp.belgacom.be (localhost [127.0.0.1])
        by outmx004.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id kAFKLLOH015804
        for <linux-serial@vger.kernel.org>; Wed, 15 Nov 2006 21:21:21 +0100
        (envelope-from <jacmet@sunsite.dk>)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org
Cc: linux-serial@vger.kernel.org

Hi Andrew,

Initialize port parameters in console_setup so port timeout is set to
something sensible even if user space never calls set_termios.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

--- linux-mm.orig/drivers/serial/uartlite.c
+++ linux-mm/drivers/serial/uartlite.c
@@ -358,6 +358,10 @@
 static int __init ulite_console_setup(struct console *co, char *options)
 {
 	struct uart_port *port;
+	int baud = 9600;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
 
 	if (co->index < 0 || co->index >= ULITE_NR_UARTS)
 		return -EINVAL;
@@ -368,7 +372,10 @@
 	if (!port->membase)
 		return -ENODEV;
 
-	return 0;
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
 static struct uart_driver ulite_uart_driver;

-- 
Bye, Peter Korsgaard
