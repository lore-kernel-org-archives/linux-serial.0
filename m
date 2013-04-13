From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/3] tty: serial: add iosize field to struct uart_port
Date: Sat, 13 Apr 2013 11:33:37 +0200
Message-ID: <1365845618-16040-3-git-send-email-blogic@openwrt.org>
References: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:39372 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab3DMJho (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Apr 2013 05:37:44 -0400
In-Reply-To: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>

From: Gabor Juhos <juhosg@openwrt.org>

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/tty/serial/8250/8250_core.c |    3 +++
 include/linux/serial_core.h         |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 35f9c96..25b917a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2498,6 +2498,8 @@ serial8250_pm(struct uart_port *port, unsigned int state,
 
 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
+	if (pt->port.iosize)
+		return pt->port.iosize;
 	if (pt->port.iotype == UPIO_AU)
 		return 0x1000;
 	if (is_omap1_8250(pt))
@@ -3233,6 +3235,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 		uart->port.iobase       = up->port.iobase;
 		uart->port.membase      = up->port.membase;
+		uart->port.iosize       = up->port.iosize;
 		uart->port.irq          = up->port.irq;
 		uart->port.irqflags     = up->port.irqflags;
 		uart->port.uartclk      = up->port.uartclk;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 87d4bbc..d3aa18b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -194,6 +194,7 @@ struct uart_port {
 	unsigned char		irq_wake;
 	unsigned char		unused[2];
 	void			*private_data;		/* generic platform data pointer */
+	unsigned int		iosize;			/* for ioremap */
 };
 
 static inline int serial_port_in(struct uart_port *up, int offset)
-- 
1.7.10.4

