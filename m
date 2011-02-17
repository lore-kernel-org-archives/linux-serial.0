From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 2/5] tty: serial: altera_jtaguart: Remove unused function early_altera_jtaguart_setup
Date: Thu, 17 Feb 2011 21:29:11 +0100
Message-ID: <777ec1696d95d76065439fb6ef406dcec7ffc787.1297974227.git.tklauser@distanz.ch>
References: <cover.1297974227.git.tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:39274 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab1BQU3M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Feb 2011 15:29:12 -0500
In-Reply-To: <cover.1297974227.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: nios2-dev@sopc.et.ntust.edu.tw

This is not even used in nios2 arch code anymore.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
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
1.7.0.4

