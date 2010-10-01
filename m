From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH 3/8] altera_uart: Add support for getting mapbase and IRQ
 from resources
Date: Fri, 1 Oct 2010 17:21:42 +0400
Message-ID: <20101001132142.GC25897@oksana.dev.rtsoft.ru>
References: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33073 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516Ab0JANVy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Oct 2010 09:21:54 -0400
Content-Disposition: inline
In-Reply-To: <20101001132045.GA9649@oksana.dev.rtsoft.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Tobias Klauser <tklauser@distanz.ch>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

This makes it much easier to integrate the driver with the rest of
the Linux (e.g. MFD subsystem).

The old method is still supported though.

Also, from now on, there is one platform device per port (no
changes are needed for the platform code, as no one registers
the devices anywhere in-tree yet).

Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
Acked-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/serial/altera_uart.c |   60 ++++++++++++++++++++++++++---------------
 1 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/serial/altera_uart.c b/drivers/serial/altera_uart.c
index 7dd58da..1dfeffa 100644
--- a/drivers/serial/altera_uart.c
+++ b/drivers/serial/altera_uart.c
@@ -498,38 +498,54 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 {
 	struct altera_uart_platform_uart *platp = pdev->dev.platform_data;
 	struct uart_port *port;
-	int i;
+	struct resource *res_mem;
+	struct resource *res_irq;
+	int i = pdev->id;
 
-	for (i = 0; i < CONFIG_SERIAL_ALTERA_UART_MAXPORTS && platp[i].mapbase; i++) {
-		port = &altera_uart_ports[i].port;
+	/* -1 emphasizes that the platform must have one port, no .N suffix */
+	if (i == -1)
+		i = 0;
 
-		port->line = i;
-		port->type = PORT_ALTERA_UART;
-		port->mapbase = platp[i].mapbase;
-		port->membase = ioremap(port->mapbase, ALTERA_UART_SIZE);
-		port->iotype = SERIAL_IO_MEM;
-		port->irq = platp[i].irq;
-		port->uartclk = platp[i].uartclk;
-		port->ops = &altera_uart_ops;
-		port->flags = ASYNC_BOOT_AUTOCONF;
+	if (i >= CONFIG_SERIAL_ALTERA_UART_MAXPORTS)
+		return -EINVAL;
 
-		uart_add_one_port(&altera_uart_driver, port);
-	}
+	port = &altera_uart_ports[i].port;
+
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res_mem)
+		port->mapbase = res_mem->start;
+	else if (platp->mapbase)
+		port->mapbase = platp->mapbase;
+	else
+		return -EINVAL;
+
+	res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res_irq)
+		port->irq = res_irq->start;
+	else if (platp->irq)
+		port->irq = platp->irq;
+
+	port->membase = ioremap(port->mapbase, ALTERA_UART_SIZE);
+	if (!port->membase)
+		return -ENOMEM;
+
+	port->line = i;
+	port->type = PORT_ALTERA_UART;
+	port->iotype = SERIAL_IO_MEM;
+	port->uartclk = platp->uartclk;
+	port->ops = &altera_uart_ops;
+	port->flags = ASYNC_BOOT_AUTOCONF;
+
+	uart_add_one_port(&altera_uart_driver, port);
 
 	return 0;
 }
 
 static int __devexit altera_uart_remove(struct platform_device *pdev)
 {
-	struct uart_port *port;
-	int i;
-
-	for (i = 0; i < CONFIG_SERIAL_ALTERA_UART_MAXPORTS; i++) {
-		port = &altera_uart_ports[i].port;
-		if (port)
-			uart_remove_one_port(&altera_uart_driver, port);
-	}
+	struct uart_port *port = &altera_uart_ports[pdev->id].port;
 
+	uart_remove_one_port(&altera_uart_driver, port);
 	return 0;
 }
 
-- 
1.7.0.5

