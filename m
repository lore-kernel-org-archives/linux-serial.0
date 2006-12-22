From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] serial/uartlite: Only enable port if request_port succeeded
Date: Fri, 22 Dec 2006 16:38:40 +0100
Message-ID: <87r6usgcu7.fsf@vps.korsgaard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from vps.korsgaard.com ([64.79.194.204]:60242 "EHLO
	vps.korsgaard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422893AbWLVQE4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Dec 2006 11:04:56 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org
Cc: linux-serial@vger.kernel.org

The uartlite driver used to always enable the port even if request_port
failed causing havoc. This patch fixes it.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

diff -urpN linux-2.6.20-rc1/drivers/serial/uartlite.c linux-2.6.20-rc1.new/drivers/serial/uartlite.c
--- linux-2.6.20-rc1/drivers/serial/uartlite.c	2006-12-22 15:11:37.000000000 +0100
+++ linux-2.6.20-rc1.new/drivers/serial/uartlite.c	2006-12-22 15:20:51.000000000 +0100
@@ -278,8 +278,8 @@ static int ulite_request_port(struct uar
 
 static void ulite_config_port(struct uart_port *port, int flags)
 {
-	ulite_request_port(port);
-	port->type = PORT_UARTLITE;
+	if (!ulite_request_port(port))
+		port->type = PORT_UARTLITE;
 }
 
 static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)

-- 
Bye, Peter Korsgaard
