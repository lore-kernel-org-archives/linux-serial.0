From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: [PATCH V2] serial: Add ioctl to enable auto rs485 mode with some Exar UARTs
Date: Fri, 2 Jan 2009 17:26:09 +0100
Message-ID: <200901021726.09767.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:45558 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751839AbZABQ0O (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 11:26:14 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 90AF324B381
	for <linux-serial@vger.kernel.org>; Fri,  2 Jan 2009 17:26:11 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 6C95C2D3AA4
	for <linux-serial@vger.kernel.org>; Fri,  2 Jan 2009 17:26:11 +0100 (CET)
Received: from bunny.home (dslb-088-070-064-025.pools.arcor-ip.net [88.70.64.25])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 380A71BF574
	for <linux-serial@vger.kernel.org>; Fri,  2 Jan 2009 17:26:11 +0100 (CET)
Received: from fox.localnet (fox.home [192.168.2.13])
	by bunny.home (Postfix) with ESMTPS id 2829E25105AB
	for <linux-serial@vger.kernel.org>; Fri,  2 Jan 2009 17:26:13 +0100 (CET)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Some Exar UARTs support a auto rs485 mode. In this mode
the UART's RTS# pin is activated during transmitting and
can be used to enable a rs485 line driver. This has nothing
to do with attempts to do this by manually by asserting/
deasserting handshake lines.

Signed-off-by: Matthias Fuchs <mfuchs@ma-fu.de>
---
 drivers/serial/8250.c      |   64 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_reg.h |    1 +
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 303272a..4b89f8a 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2511,6 +2511,69 @@ serial8250_type(struct uart_port *port)
 	return uart_config[type].name;
 }
 
+static int
+serial8250_ioctl_port(struct uart_port *port, unsigned int cmd, unsigned long arg)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+
+	switch (cmd) {
+	case TIOCSRS485:
+	{
+		struct serial_rs485 rs485ctrl;
+		unsigned char fctr;
+
+		if (port->type != PORT_16850)
+			return -ENOTTY;
+
+		if (copy_from_user(&rs485ctrl,
+				   (struct serial_rs485 *)arg,
+				   sizeof(rs485ctrl)))
+			return -EFAULT;
+
+		spin_lock_irqsave(&up->port.lock, flags);
+		serial_outp(up, UART_LCR, 0xbf);
+		fctr = serial_inp(up, UART_FCTR);
+		if (rs485ctrl.flags & SER_RS485_ENABLED)
+			fctr |= UART_FCTR_RS485;
+		else
+			fctr &= ~UART_FCTR_RS485;
+		serial_outp(up, UART_FCTR, fctr);
+		serial_outp(up, UART_LCR, 0);
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		return 0;
+	}
+
+	case TIOCGRS485:
+	{
+		struct serial_rs485 rs485ctrl;
+
+		if (port->type != PORT_16850)
+			return -ENOTTY;
+
+		spin_lock_irqsave(&up->port.lock, flags);
+		serial_outp(up, UART_LCR, 0xbf);
+		if (serial_inp(up, UART_FCTR) & UART_FCTR_RS485)
+			rs485ctrl.flags = SER_RS485_ENABLED;
+		else
+			rs485ctrl.flags = 0;
+		serial_outp(up, UART_LCR, 0);
+		spin_unlock_irqrestore(&up->port.lock, flags);
+
+		if (copy_to_user((struct serial_rs485 *)arg,
+				 &rs485ctrl,
+				 sizeof(rs485ctrl)))
+			return -EFAULT;
+		return 0;
+	}
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
 static struct uart_ops serial8250_pops = {
 	.tx_empty	= serial8250_tx_empty,
 	.set_mctrl	= serial8250_set_mctrl,
@@ -2529,6 +2592,7 @@ static struct uart_ops serial8250_pops = {
 	.request_port	= serial8250_request_port,
 	.config_port	= serial8250_config_port,
 	.verify_port	= serial8250_verify_port,
+	.ioctl		= serial8250_ioctl_port,
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_get_char = serial8250_get_poll_char,
 	.poll_put_char = serial8250_put_poll_char,
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 96c0d93..086c3e2 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -191,6 +191,7 @@
 #define UART_FCTR_RTS_8DELAY	0x03
 #define UART_FCTR_IRDA		0x04  /* IrDa data encode select */
 #define UART_FCTR_TX_INT	0x08  /* Tx interrupt type select */
+#define UART_FCTR_RS485		0x08  /* Auto RS485 mode */
 #define UART_FCTR_TRGA		0x00  /* Tx/Rx 550 trigger table select */
 #define UART_FCTR_TRGB		0x10  /* Tx/Rx 650 trigger table select */
 #define UART_FCTR_TRGC		0x20  /* Tx/Rx 654 trigger table select */
-- 
1.5.6.3

