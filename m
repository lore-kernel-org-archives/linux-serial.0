From: Martin Michlmayr <tbm@cyrius.com>
Subject: [PATCH] serial: Fix compilation error in dz.c
Date: Mon, 26 Jun 2006 18:18:11 +0200
Message-ID: <20060626161811.GA14240@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:2564 "EHLO sorrow.cyrius.com")
	by vger.kernel.org with ESMTP id S1750749AbWFZQST (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Jun 2006 12:18:19 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

Fix the following compilation error in the dz serial driver that got
introduced with the "kernel console should send CRLF not LFCR" change.

  CC      drivers/serial/dz.o
drivers/serial/dz.c: In function 'dz_console_putchar':
drivers/serial/dz.c:679: error: 'uport' undeclared (first use in this function)
drivers/serial/dz.c:679: error: (Each undeclared identifier is reported only once
drivers/serial/dz.c:679: error: for each function it appears in.)

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- a/drivers/serial/dz.c
+++ b/drivers/serial/dz.c
@@ -674,7 +674,7 @@ static void dz_reset(struct dz_port *dpo
 }
 
 #ifdef CONFIG_SERIAL_DZ_CONSOLE
-static void dz_console_putchar(struct uart_port *port, int ch)
+static void dz_console_putchar(struct uart_port *uport, int ch)
 {
 	struct dz_port *dport = (struct dz_port *)uport;
 	unsigned long flags;

-- 
Martin Michlmayr
http://www.cyrius.com/
