From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] tty: serial: altera_uart: remove early_altera_uart_setup
Date: Wed,  8 Feb 2012 14:35:46 +0100
Message-ID: <1328708146-25052-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:35030 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764Ab2BHNph (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Feb 2012 08:45:37 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org

The function has no users inside the tree and the nios2
(out-of-mainline) port doesn't use it either (anymore).

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_uart.c |   23 -----------------------
 include/linux/altera_uart.h      |    4 ----
 2 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index bde59d1..5ef414c 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -406,29 +406,6 @@ static struct altera_uart altera_uart_ports[CONFIG_SERIAL_ALTERA_UART_MAXPORTS];
 
 #if defined(CONFIG_SERIAL_ALTERA_UART_CONSOLE)
 
-int __init early_altera_uart_setup(struct altera_uart_platform_uart *platp)
-{
-	struct uart_port *port;
-	int i;
-
-	for (i = 0; i < CONFIG_SERIAL_ALTERA_UART_MAXPORTS && platp[i].mapbase; i++) {
-		port = &altera_uart_ports[i].port;
-
-		port->line = i;
-		port->type = PORT_ALTERA_UART;
-		port->mapbase = platp[i].mapbase;
-		port->membase = ioremap(port->mapbase, ALTERA_UART_SIZE);
-		port->iotype = SERIAL_IO_MEM;
-		port->irq = platp[i].irq;
-		port->uartclk = platp[i].uartclk;
-		port->flags = UPF_BOOT_AUTOCONF;
-		port->ops = &altera_uart_ops;
-		port->private_data = platp;
-	}
-
-	return 0;
-}
-
 static void altera_uart_console_putc(struct uart_port *port, const char c)
 {
 	while (!(altera_uart_readl(port, ALTERA_UART_STATUS_REG) &
diff --git a/include/linux/altera_uart.h b/include/linux/altera_uart.h
index a10a907..c022c82 100644
--- a/include/linux/altera_uart.h
+++ b/include/linux/altera_uart.h
@@ -5,8 +5,6 @@
 #ifndef	__ALTUART_H
 #define	__ALTUART_H
 
-#include <linux/init.h>
-
 struct altera_uart_platform_uart {
 	unsigned long mapbase;	/* Physical address base */
 	unsigned int irq;	/* Interrupt vector */
@@ -14,6 +12,4 @@ struct altera_uart_platform_uart {
 	unsigned int bus_shift;	/* Bus shift (address stride) */
 };
 
-int __init early_altera_uart_setup(struct altera_uart_platform_uart *platp);
-
 #endif /* __ALTUART_H */
-- 
1.7.5.4

