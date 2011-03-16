From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 32/76] tty: serial: altera_uart: Use port->regshift to store bus shift
Date: Wed, 16 Mar 2011 14:12:02 -0700
Message-ID: <1300309966-5745-32-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32850 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754836Ab1CPVN7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:59 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tobias Klauser <tklauser@distanz.ch>

Use the regshift member of struct uart_port to store the address stride
from platform data. This way we can save one dereference per call of
altera_uart_readl and altera_uart_writel.

This also allows us to use the driver without platform data, which is
needed for device tree support in the Nios2 port.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/altera_uart.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index dee7a0e..3a57352 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -86,16 +86,12 @@ struct altera_uart {
 
 static u32 altera_uart_readl(struct uart_port *port, int reg)
 {
-	struct altera_uart_platform_uart *platp = port->private_data;
-
-	return readl(port->membase + (reg << platp->bus_shift));
+	return readl(port->membase + (reg << port->regshift));
 }
 
 static void altera_uart_writel(struct uart_port *port, u32 dat, int reg)
 {
-	struct altera_uart_platform_uart *platp = port->private_data;
-
-	writel(dat, port->membase + (reg << platp->bus_shift));
+	writel(dat, port->membase + (reg << port->regshift));
 }
 
 static unsigned int altera_uart_tx_empty(struct uart_port *port)
@@ -546,13 +542,17 @@ static int __devinit altera_uart_probe(struct platform_device *pdev)
 	if (!port->membase)
 		return -ENOMEM;
 
+	if (platp)
+		port->regshift = platp->bus_shift;
+	else
+		port->regshift = 0;
+
 	port->line = i;
 	port->type = PORT_ALTERA_UART;
 	port->iotype = SERIAL_IO_MEM;
 	port->uartclk = platp->uartclk;
 	port->ops = &altera_uart_ops;
 	port->flags = UPF_BOOT_AUTOCONF;
-	port->private_data = platp;
 
 	uart_add_one_port(&altera_uart_driver, port);
 
-- 
1.7.4.1

