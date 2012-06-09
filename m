From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] serial: fix kernel-doc warnings in 8250.c
Date: Fri, 08 Jun 2012 18:51:23 -0700
Message-ID: <4FD2AC1B.6070500@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:49392 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933086Ab2FIBve (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Jun 2012 21:51:34 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc warnings in drivers/tty/serial/8250/8250.c:

Warning(drivers/tty/serial/8250/8250.c:3128): No description found for parameter 'up'
Warning(drivers/tty/serial/8250/8250.c:3128): Excess function parameter 'port' description in 'serial8250_register_8250_port'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/tty/serial/8250/8250.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-35-rc1.orig/drivers/tty/serial/8250/8250.c
+++ lnx-35-rc1/drivers/tty/serial/8250/8250.c
@@ -3113,7 +3113,7 @@ static struct uart_8250_port *serial8250
 
 /**
  *	serial8250_register_8250_port - register a serial port
- *	@port: serial port template
+ *	@up: serial port template
  *
  *	Configure the serial port specified by the request. If the
  *	port exists and is in use, it is hung up and unregistered
