From: Atsuo Igarashi <atsuo_igarashi@tripeaks.co.jp>
Subject: [PATCH] serial: imx: add console polling routines for kgdboc
Date: Wed, 13 Aug 2008 17:27:39 +0900
Message-ID: <48A29AFB.9070502@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050305030701020705070805"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mfo31.po.2iij.NET ([210.128.50.52]:19889 "EHLO
	mfo31.po.2iij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbYHMIhg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 13 Aug 2008 04:37:36 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, kernel@pengutronix.de

This is a multi-part message in MIME format.
--------------050305030701020705070805
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Add console polling routines for the imx uart with kgdboc.

Signed-off-by Atsuo Igarashi <atsuo_igarashi@tripeaks.co.jp>



--------------050305030701020705070805
Content-Type: text/x-diff;
 name="imx_serial_for_kgdb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="imx_serial_for_kgdb.diff"

--- linux-2.6.orig/drivers/serial/imx.c	2008-08-13 15:06:45.000000000 +0900
+++ linux-2.6/drivers/serial/imx.c	2008-08-13 15:10:59.000000000 +0900
@@ -646,6 +646,29 @@ static void imx_shutdown(struct uart_por
 	writel(temp, sport->port.membase + UCR1);
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+
+static int imx_get_poll_char(struct uart_port *port)
+{
+	struct imx_port *sport = (struct imx_port *)port;
+
+	while (!(readl(sport->port.membase + USR2) & USR2_RDR));
+
+	return readl(sport->port.membase + URXD0);
+}
+
+static void imx_put_poll_char(struct uart_port *port, unsigned char ch)
+{
+	struct imx_port *sport = (struct imx_port *)port;
+
+	while (readl(sport->port.membase + UTS) & UTS_TXFULL)
+		barrier();
+
+	writel(ch, sport->port.membase + URTX0);
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 static void
 imx_set_termios(struct uart_port *port, struct ktermios *termios,
 		   struct ktermios *old)
@@ -892,6 +915,10 @@ static struct uart_ops imx_pops = {
 	.request_port	= imx_request_port,
 	.config_port	= imx_config_port,
 	.verify_port	= imx_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= imx_get_poll_char,
+	.poll_put_char	= imx_put_poll_char,
+#endif
 };
 
 static struct imx_port *imx_ports[UART_NR];

--------------050305030701020705070805--
