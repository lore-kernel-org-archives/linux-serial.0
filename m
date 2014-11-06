From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 09/11] drivers/max310: Use the rs485 functions on serial_core
Date: Thu,  6 Nov 2014 09:22:58 +0100
Message-ID: <1415262180-2694-10-git-send-email-ricardo.ribalda@gmail.com>
References: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35824 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaKFIXR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 03:23:17 -0500
Received: by mail-lb0-f178.google.com with SMTP id f15so539036lbj.9
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2014 00:23:15 -0800 (PST)
In-Reply-To: <1415262180-2694-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

In order to unify all the rs485 ioctl handling
Use the implementation of TIOC[GS]RS485 ioctl handling on serial_core.

Reviewed-by: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serial/max310x.c | 70 +++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ecb4667..182549f 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -877,53 +877,37 @@ static void max310x_set_termios(struct uart_port *port,
 	uart_update_timeout(port, termios->c_cflag, baud);
 }
 
-static int max310x_ioctl(struct uart_port *port, unsigned int cmd,
-			 unsigned long arg)
+static int max310x_rs485_config(struct uart_port *port,
+				struct serial_rs485 *rs485)
 {
-	struct serial_rs485 rs485;
 	unsigned int val;
 
-	switch (cmd) {
-	case TIOCSRS485:
-		if (copy_from_user(&rs485, (void __user *)arg, sizeof(rs485)))
-			return -EFAULT;
-		if (rs485.delay_rts_before_send > 0x0f ||
-		    rs485.delay_rts_after_send > 0x0f)
-			return -ERANGE;
-		val = (rs485.delay_rts_before_send << 4) |
-		      rs485.delay_rts_after_send;
-		max310x_port_write(port, MAX310X_HDPIXDELAY_REG, val);
-		if (rs485.flags & SER_RS485_ENABLED) {
-			max310x_port_update(port, MAX310X_MODE1_REG,
-					    MAX310X_MODE1_TRNSCVCTRL_BIT,
-					    MAX310X_MODE1_TRNSCVCTRL_BIT);
-			max310x_port_update(port, MAX310X_MODE2_REG,
-					    MAX310X_MODE2_ECHOSUPR_BIT,
-					    MAX310X_MODE2_ECHOSUPR_BIT);
-		} else {
-			max310x_port_update(port, MAX310X_MODE1_REG,
-					    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
-			max310x_port_update(port, MAX310X_MODE2_REG,
-					    MAX310X_MODE2_ECHOSUPR_BIT, 0);
-		}
-		return 0;
-	case TIOCGRS485:
-		memset(&rs485, 0, sizeof(rs485));
-		val = max310x_port_read(port, MAX310X_MODE1_REG);
-		rs485.flags = (val & MAX310X_MODE1_TRNSCVCTRL_BIT) ?
-			      SER_RS485_ENABLED : 0;
-		rs485.flags |= SER_RS485_RTS_ON_SEND;
-		val = max310x_port_read(port, MAX310X_HDPIXDELAY_REG);
-		rs485.delay_rts_before_send = val >> 4;
-		rs485.delay_rts_after_send = val & 0x0f;
-		if (copy_to_user((void __user *)arg, &rs485, sizeof(rs485)))
-			return -EFAULT;
-		return 0;
-	default:
-		break;
+	if (rs485->delay_rts_before_send > 0x0f ||
+		    rs485->delay_rts_after_send > 0x0f)
+		return -ERANGE;
+
+	val = (rs485->delay_rts_before_send << 4) |
+		rs485->delay_rts_after_send;
+	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, val);
+	if (rs485->flags & SER_RS485_ENABLED) {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				MAX310X_MODE1_TRNSCVCTRL_BIT,
+				MAX310X_MODE1_TRNSCVCTRL_BIT);
+		max310x_port_update(port, MAX310X_MODE2_REG,
+				MAX310X_MODE2_ECHOSUPR_BIT,
+				MAX310X_MODE2_ECHOSUPR_BIT);
+	} else {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
+		max310x_port_update(port, MAX310X_MODE2_REG,
+				MAX310X_MODE2_ECHOSUPR_BIT, 0);
 	}
 
-	return -ENOIOCTLCMD;
+	rs485->flags &= SER_RS485_RTS_ON_SEND | SER_RS485_ENABLED;
+	memset(rs485->padding, 0, sizeof(rs485->padding));
+	port->rs485 = *rs485;
+
+	return 0;
 }
 
 static int max310x_startup(struct uart_port *port)
@@ -1018,7 +1002,6 @@ static const struct uart_ops max310x_ops = {
 	.release_port	= max310x_null_void,
 	.config_port	= max310x_config_port,
 	.verify_port	= max310x_verify_port,
-	.ioctl		= max310x_ioctl,
 };
 
 static int __maybe_unused max310x_suspend(struct device *dev)
@@ -1219,6 +1202,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		s->p[i].port.iobase	= i * 0x20;
 		s->p[i].port.membase	= (void __iomem *)~0;
 		s->p[i].port.uartclk	= uartclk;
+		s->p[i].port.rs485_config = max310x_rs485_config;
 		s->p[i].port.ops	= &max310x_ops;
 		/* Disable all interrupts */
 		max310x_port_write(&s->p[i].port, MAX310X_IRQEN_REG, 0);
-- 
2.1.1

