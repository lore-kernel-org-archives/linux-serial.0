From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 06/11] serial/mcf: Use the rs485 functions on serial_core
Date: Thu,  6 Nov 2014 09:22:55 +0100
Message-ID: <1415262180-2694-7-git-send-email-ricardo.ribalda@gmail.com>
References: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:55774 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbaKFIXN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 03:23:13 -0500
Received: by mail-la0-f48.google.com with SMTP id gq15so2133406lab.21
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2014 00:23:12 -0800 (PST)
In-Reply-To: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

In order to unify all the rs485 ioctl handling.
Use the implementation of TIOC[GS]RS485 ioctl handling on serial_core.

Reviewed-by: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/mcf.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index bc896dc..d7be1f1 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -57,7 +57,6 @@ struct mcf_uart {
 	struct uart_port	port;
 	unsigned int		sigs;		/* Local copy of line sigs */
 	unsigned char		imr;		/* Local IMR mirror */
-	struct serial_rs485	rs485;		/* RS485 settings */
 };
 
 /****************************************************************************/
@@ -104,7 +103,7 @@ static void mcf_start_tx(struct uart_port *port)
 {
 	struct mcf_uart *pp = container_of(port, struct mcf_uart, port);
 
-	if (pp->rs485.flags & SER_RS485_ENABLED) {
+	if (port->rs485.flags & SER_RS485_ENABLED) {
 		/* Enable Transmitter */
 		writeb(MCFUART_UCR_TXENABLE, port->membase + MCFUART_UCR);
 		/* Manually assert RTS */
@@ -258,7 +257,7 @@ static void mcf_set_termios(struct uart_port *port, struct ktermios *termios,
 		mr2 |= MCFUART_MR2_TXCTS;
 	}
 
-	if (pp->rs485.flags & SER_RS485_ENABLED) {
+	if (port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		mr2 |= MCFUART_MR2_TXRTS;
 	}
@@ -360,7 +359,7 @@ static void mcf_tx_chars(struct mcf_uart *pp)
 		pp->imr &= ~MCFUART_UIR_TXREADY;
 		writeb(pp->imr, port->membase + MCFUART_UIMR);
 		/* Disable TX to negate RTS automatically */
-		if (pp->rs485.flags & SER_RS485_ENABLED)
+		if (port->rs485.flags & SER_RS485_ENABLED)
 			writeb(MCFUART_UCR_TXDISABLE,
 				port->membase + MCFUART_UCR);
 	}
@@ -440,7 +439,7 @@ static int mcf_verify_port(struct uart_port *port, struct serial_struct *ser)
 /****************************************************************************/
 
 /* Enable or disable the RS485 support */
-static void mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
+static int mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 {
 	struct mcf_uart *pp = container_of(port, struct mcf_uart, port);
 	unsigned long flags;
@@ -460,32 +459,9 @@ static void mcf_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 	}
 	writeb(mr1, port->membase + MCFUART_UMR);
 	writeb(mr2, port->membase + MCFUART_UMR);
-	pp->rs485 = *rs485;
+	port->rs485 = *rs485;
 	spin_unlock_irqrestore(&port->lock, flags);
-}
 
-static int mcf_ioctl(struct uart_port *port, unsigned int cmd,
-		unsigned long arg)
-{
-	switch (cmd) {
-	case TIOCSRS485: {
-		struct serial_rs485 rs485;
-		if (copy_from_user(&rs485, (struct serial_rs485 *)arg,
-				sizeof(struct serial_rs485)))
-			return -EFAULT;
-		mcf_config_rs485(port, &rs485);
-		break;
-	}
-	case TIOCGRS485: {
-		struct mcf_uart *pp = container_of(port, struct mcf_uart, port);
-		if (copy_to_user((struct serial_rs485 *)arg, &pp->rs485,
-				sizeof(struct serial_rs485)))
-			return -EFAULT;
-		break;
-	}
-	default:
-		return -ENOIOCTLCMD;
-	}
 	return 0;
 }
 
@@ -510,7 +486,6 @@ static const struct uart_ops mcf_uart_ops = {
 	.release_port	= mcf_release_port,
 	.config_port	= mcf_config_port,
 	.verify_port	= mcf_verify_port,
-	.ioctl		= mcf_ioctl,
 };
 
 static struct mcf_uart mcf_ports[4];
@@ -538,6 +513,7 @@ int __init early_mcf_setup(struct mcf_platform_uart *platp)
 		port->irq = platp[i].irq;
 		port->uartclk = MCF_BUSCLK;
 		port->flags = UPF_BOOT_AUTOCONF;
+		port->rs485_config = mcf_config_rs485;
 		port->ops = &mcf_uart_ops;
 	}
 
@@ -663,6 +639,7 @@ static int mcf_probe(struct platform_device *pdev)
 		port->uartclk = MCF_BUSCLK;
 		port->ops = &mcf_uart_ops;
 		port->flags = UPF_BOOT_AUTOCONF;
+		port->rs485_config = mcf_config_rs485;
 
 		uart_add_one_port(&mcf_driver, port);
 	}
-- 
2.1.1

