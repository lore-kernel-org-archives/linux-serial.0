From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 3/5] tty: serial: altera_jtaguart: Support getting mapbase and IRQ from resources
Date: Thu, 17 Feb 2011 21:29:22 +0100
Message-ID: <8ec9d5ede1edda8b0ac8c6b343909e22d76670f9.1297974227.git.tklauser@distanz.ch>
References: <cover.1297974227.git.tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:39288 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab1BQU3X (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Feb 2011 15:29:23 -0500
In-Reply-To: <cover.1297974227.git.tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: nios2-dev@sopc.et.ntust.edu.tw

This will make it easier to get the driver to support device tree. The
old platform data method is still supported though.

Also change the driver to use only one platform device per port.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
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
1.7.0.4

