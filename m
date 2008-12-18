From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: [PATCH/RFC] serial: Add ioctl to enable auto rs485 mode with some Exar UARTs
Date: Fri, 19 Dec 2008 00:48:34 +0100
Message-ID: <200812190048.35249.mfuchs@ma-fu.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:39054 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752243AbYLRXsj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Dec 2008 18:48:39 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 090794C5BD
	for <linux-serial@vger.kernel.org>; Fri, 19 Dec 2008 00:48:37 +0100 (CET)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id D79A42D377D
	for <linux-serial@vger.kernel.org>; Fri, 19 Dec 2008 00:48:36 +0100 (CET)
Received: from bunny.home (dslb-088-070-089-025.pools.arcor-ip.net [88.70.89.25])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 985D82351A9
	for <linux-serial@vger.kernel.org>; Fri, 19 Dec 2008 00:48:36 +0100 (CET)
Received: from fox.localnet (fox.home [192.168.2.13])
	by bunny.home (Postfix) with ESMTPS id F27772510419
	for <linux-serial@vger.kernel.org>; Fri, 19 Dec 2008 00:48:32 +0100 (CET)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

please see my patch for enabling the RS485 half-duplex control below.
Please note that I am using this on a PowerPC platform. So I needed to
add the ioctl to the PowerPC header. As Wolfgang stated, it is
already in the x86 header. I am not sure if I have to post the modification
on the powerpc header to the PowerPC list or if it will be accepted here
as well.  .... But first I will have to see what you think of this patch :-)

Matthias


Some Exar UARTs support a auto rs485 mode. In this mode
the UART's RTS# pin is activated during transmitting and
can be used to enable a rs485 line driver. This has nothing
to do with attempts to do this by manually by asserting/
deasserting handshake lines.

Signed-off-by: Matthias Fuchs <mfuchs@ma-fu.de>
---
 arch/powerpc/include/asm/ioctls.h |    2 +
 drivers/serial/8250.c             |   59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ioctls.h b/arch/powerpc/include/asm/ioctls.h
index 279a622..1842186 100644
--- a/arch/powerpc/include/asm/ioctls.h
+++ b/arch/powerpc/include/asm/ioctls.h
@@ -89,6 +89,8 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TIOCGRS485	0x542e
+#define TIOCSRS485	0x542f
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 303272a..e6df50f 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2511,6 +2511,64 @@ serial8250_type(struct uart_port *port)
 	return uart_config[type].name;
 }
 
+static int 
+serial8250_ioctl_port(struct uart_port *port, unsigned int cmd, unsigned long arg)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+
+	switch (cmd) {
+	case TIOCSRS485:
+	{
+		struct serial_rs485 rs485ctrl;
+		unsigned char fctr;
+
+		if (port->type != PORT_16850)
+			return -ENODEV;
+
+		if (copy_from_user(&rs485ctrl, 
+				   (struct serial_rs485 *)arg,
+				   sizeof(rs485ctrl)))
+			return -EFAULT;
+
+		serial_outp(up, UART_LCR, 0xbf);
+		fctr = serial_inp(up, UART_FCTR);
+		if (rs485ctrl.flags & SER_RS485_ENABLED)
+			fctr |= 0x08;
+		else
+			fctr &= ~0x08;
+		serial_outp(up, UART_FCTR, fctr);
+		serial_outp(up, UART_LCR, 0);
+		return 0;
+	}
+
+	case TIOCGRS485:
+	{
+		struct serial_rs485 rs485ctrl;
+
+		if (port->type != PORT_16850)
+			return -ENODEV;
+
+		serial_outp(up, UART_LCR, 0xbf);
+		if (serial_inp(up, UART_FCTR) & 0x08)
+			rs485ctrl.flags = SER_RS485_ENABLED;
+		else
+			rs485ctrl.flags = 0;
+		serial_outp(up, UART_LCR, 0);
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
@@ -2529,6 +2587,7 @@ static struct uart_ops serial8250_pops = {
 	.request_port	= serial8250_request_port,
 	.config_port	= serial8250_config_port,
 	.verify_port	= serial8250_verify_port,
+	.ioctl		= serial8250_ioctl_port,
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_get_char = serial8250_get_poll_char,
 	.poll_put_char = serial8250_put_poll_char,
-- 
1.5.6.3


