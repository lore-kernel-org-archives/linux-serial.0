From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 48/76] tty: serial: altera_jtaguart: Support getting mapbase and IRQ from resources
Date: Wed, 16 Mar 2011 14:12:18 -0700
Message-ID: <1300309966-5745-48-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32992 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439Ab1CPVOg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:14:36 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tobias Klauser <tklauser@distanz.ch>

This will make it easier to get the driver to support device tree. The
old platform data method is still supported though.

Also change the driver to use only one platform device per port.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/altera_jtaguart.c |   61 +++++++++++++++++++++++----------
 1 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 94ccf47..aa2a4ca 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -409,22 +409,45 @@ static int __devinit altera_jtaguart_probe(struct platform_device *pdev)
 {
 	struct altera_jtaguart_platform_uart *platp = pdev->dev.platform_data;
 	struct uart_port *port;
-	int i;
+	struct resource *res_irq, *res_mem;
+	int i = pdev->id;
 
-	for (i = 0; i < ALTERA_JTAGUART_MAXPORTS && platp[i].mapbase; i++) {
-		port = &altera_jtaguart_ports[i].port;
+	/* -1 emphasizes that the platform must have one port, no .N suffix */
+	if (i == -1)
+		i = 0;
 
-		port->line = i;
-		port->type = PORT_ALTERA_JTAGUART;
-		port->mapbase = platp[i].mapbase;
-		port->membase = ioremap(port->mapbase, ALTERA_JTAGUART_SIZE);
-		port->iotype = SERIAL_IO_MEM;
-		port->irq = platp[i].irq;
-		port->ops = &altera_jtaguart_ops;
-		port->flags = ASYNC_BOOT_AUTOCONF;
+	if (i >= ALTERA_JTAGUART_MAXPORTS)
+		return -EINVAL;
 
-		uart_add_one_port(&altera_jtaguart_driver, port);
-	}
+	port = &altera_jtaguart_ports[i].port;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res_mem)
+		port->mapbase = res_mem->start;
+	else if (platp)
+		port->mapbase = platp->mapbase;
+	else
+		return -ENODEV;
+
+	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res_irq)
+		port->irq = res_irq->start;
+	else if (platp)
+		port->irq = platp->irq;
+	else
+		return -ENODEV;
+
+	port->membase = ioremap(port->mapbase, ALTERA_JTAGUART_SIZE);
+	if (!port->membase)
+		return -ENOMEM;
+
+	port->line = i;
+	port->type = PORT_ALTERA_JTAGUART;
+	port->iotype = SERIAL_IO_MEM;
+	port->ops = &altera_jtaguart_ops;
+	port->flags = ASYNC_BOOT_AUTOCONF;
+
+	uart_add_one_port(&altera_jtaguart_driver, port);
 
 	return 0;
 }
@@ -432,13 +455,13 @@ static int __devinit altera_jtaguart_probe(struct platform_device *pdev)
 static int __devexit altera_jtaguart_remove(struct platform_device *pdev)
 {
 	struct uart_port *port;
-	int i;
+	int i = pdev->id;
 
-	for (i = 0; i < ALTERA_JTAGUART_MAXPORTS; i++) {
-		port = &altera_jtaguart_ports[i].port;
-		if (port)
-			uart_remove_one_port(&altera_jtaguart_driver, port);
-	}
+	if (i == -1)
+		i = 0;
+
+	port = &altera_jtaguart_ports[i].port;
+	uart_remove_one_port(&altera_jtaguart_driver, port);
 
 	return 0;
 }
-- 
1.7.4.1

