From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: [PATCH V3] serial: Add ioctl to enable auto rs485 mode with some Exar UARTs
Date: Thu, 15 Jan 2009 20:23:15 +0100
Message-ID: <200901152023.15352.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:33677 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753156AbZAOTXS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Jan 2009 14:23:18 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Laurent Pinchart <laurentp@cse-semaphore.com>

Some Exar UARTs support an auto rs485 mode. In this mode
the UART's RTS# pin is activated during transmitting and
can be used to enable a rs485 line driver. This has nothing
to do with attempts to do this by manually asserting/
deasserting handshake lines in software.

Signed-off-by: Matthias Fuchs <mfuchs@ma-fu.de>
---
 drivers/serial/8250.c      |   70 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/serial_reg.h |    1 +
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 0d934bf..9c986bd 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2580,6 +2580,75 @@ serial8250_type(struct uart_port *port)
 	return uart_config[type].name;
 }
 
+static int
+serial8250_ioctl_port(struct uart_port *port,
+		      unsigned int cmd, unsigned long arg)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+
+	switch (cmd) {
+	case TIOCSRS485:
+	{
+		struct serial_rs485 rs485ctrl;
+		unsigned char fctr, lcr;
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
+		lcr = serial_inp(up, UART_LCR);
+		serial_outp(up, UART_LCR, 0xbf);
+		fctr = serial_inp(up, UART_FCTR);
+		if (rs485ctrl.flags & SER_RS485_ENABLED)
+			fctr |= UART_FCTR_RS485;
+		else
+			fctr &= ~UART_FCTR_RS485;
+		serial_outp(up, UART_FCTR, fctr);
+		serial_outp(up, UART_LCR, lcr);
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		return 0;
+	}
+
+	case TIOCGRS485:
+	{
+		struct serial_rs485 rs485ctrl;
+		unsigned char lcr;
+
+		if (port->type != PORT_16850)
+			return -ENOTTY;
+
+		memset(&rs485ctrl, 0, sizeof(rs485ctrl));
+
+		spin_lock_irqsave(&up->port.lock, flags);
+		lcr = serial_inp(up, UART_LCR);
+		serial_outp(up, UART_LCR, 0xbf);
+		if (serial_inp(up, UART_FCTR) & UART_FCTR_RS485)
+			rs485ctrl.flags = SER_RS485_ENABLED;
+		else
+			rs485ctrl.flags = 0;
+		serial_outp(up, UART_LCR, lcr);
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
@@ -2598,6 +2667,7 @@ static struct uart_ops serial8250_pops = {
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

