From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: [PATCHv3] serial: of-serial: fix up PM ops on no_console_suspend and port type
Date: Mon, 13 Oct 2014 17:14:27 +0800
Message-ID: <1413191667-10949-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [157.56.110.106] ([157.56.110.106]:2567 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752937AbaJMKBQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Oct 2014 06:01:16 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: josephl@nvidia.com, arnd@arndb.de, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jingchang Lu <jingchang.lu@freescale.com>

This patch fixes commit 2dea53bf57783f243c892e99c10c6921e956aa7e,
"serial: of-serial: add PM suspend/resume support", which disables
the uart clock on suspend, but also causes a hardware hang on register
access if no_console_suspend command line option is used.

Also, not every of_serial device is an 8250 port, so the serial8250
suspend/resume functions should only be applied to a real 8250 port.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
changes in v3:
 fix up point reference and deference.

changes in v2:
 add switch selection on uart type.

 drivers/tty/serial/of_serial.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 8bc2563..9d747a7 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -245,9 +245,24 @@ static int of_serial_suspend(struct device *dev)
 {
 	struct of_serial_info *info = dev_get_drvdata(dev);
 
-	serial8250_suspend_port(info->line);
-	if (info->clk)
-		clk_disable_unprepare(info->clk);
+	switch(info->type) {
+#ifdef CONFIG_SERIAL_8250
+	case PORT_8250 ... PORT_MAX_8250:
+	{
+		struct uart_8250_port *port8250;
+		port8250 = serial8250_get_port(info->line);
+
+		serial8250_suspend_port(info->line);
+		if (info->clk &&
+		    (!uart_console(&port8250->port) ||
+		    (uart_console(&port8250->port) && console_suspend_enabled)))
+			clk_disable_unprepare(info->clk);
+		break;
+	}
+#endif
+	default:
+		break;
+	}
 
 	return 0;
 }
@@ -256,10 +271,25 @@ static int of_serial_resume(struct device *dev)
 {
 	struct of_serial_info *info = dev_get_drvdata(dev);
 
-	if (info->clk)
-		clk_prepare_enable(info->clk);
+	switch(info->type) {
+#ifdef CONFIG_SERIAL_8250
+	case PORT_8250 ... PORT_MAX_8250:
+	{
+		struct uart_8250_port *port8250;
+		port8250 = serial8250_get_port(info->line);
+
+		if (info->clk &&
+		    (!uart_console(&port8250->port) ||
+		    (uart_console(&port8250->port) && console_suspend_enabled)))
+			clk_prepare_enable(info->clk);
 
-	serial8250_resume_port(info->line);
+		serial8250_resume_port(info->line);
+		break;
+	}
+#endif
+	default:
+		break;
+	}
 
 	return 0;
 }
-- 
1.8.0

