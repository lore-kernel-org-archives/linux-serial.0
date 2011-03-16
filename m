From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 47/76] tty: serial: altera_jtaguart: Remove unused function early_altera_jtaguart_setup
Date: Wed, 16 Mar 2011 14:12:17 -0700
Message-ID: <1300309966-5745-47-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32839 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898Ab1CPVOf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:35 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tobias Klauser <tklauser@distanz.ch>

This is not even used in nios2 arch code anymore.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/altera_jtaguart.c |   22 ----------------------
 1 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 0c0a8b6..94ccf47 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -305,28 +305,6 @@ static struct altera_jtaguart altera_jtaguart_ports[ALTERA_JTAGUART_MAXPORTS];
 
 #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE)
 
-int __init early_altera_jtaguart_setup(struct altera_jtaguart_platform_uart
-				       *platp)
-{
-	struct uart_port *port;
-	int i;
-
-	for (i = 0; i < ALTERA_JTAGUART_MAXPORTS && platp[i].mapbase; i++) {
-		port = &altera_jtaguart_ports[i].port;
-
-		port->line = i;
-		port->type = PORT_ALTERA_JTAGUART;
-		port->mapbase = platp[i].mapbase;
-		port->membase = ioremap(port->mapbase, ALTERA_JTAGUART_SIZE);
-		port->iotype = SERIAL_IO_MEM;
-		port->irq = platp[i].irq;
-		port->flags = ASYNC_BOOT_AUTOCONF;
-		port->ops = &altera_jtaguart_ops;
-	}
-
-	return 0;
-}
-
 #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS)
 static void altera_jtaguart_console_putc(struct console *co, const char c)
 {
-- 
1.7.4.1

