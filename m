From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/3] serial: imx: Use devm_ioremap_resource()
Date: Sat, 22 Feb 2014 16:01:33 +0400
Message-ID: <1393070495-11220-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp40.i.mail.ru ([94.100.177.100]:49710 "EHLO smtp40.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbaBVMBs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 22 Feb 2014 07:01:48 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

Use devm_ioremap_resource() in order to make the code simpler and
it gives proper codes on errors.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/imx.c | 44 ++++----------------------------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index dff0f0a..d185972 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1469,44 +1469,13 @@ static const char *imx_type(struct uart_port *port)
 }
 
 /*
- * Release the memory region(s) being used by 'port'.
- */
-static void imx_release_port(struct uart_port *port)
-{
-	struct platform_device *pdev = to_platform_device(port->dev);
-	struct resource *mmres;
-
-	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mmres->start, resource_size(mmres));
-}
-
-/*
- * Request the memory region(s) being used by 'port'.
- */
-static int imx_request_port(struct uart_port *port)
-{
-	struct platform_device *pdev = to_platform_device(port->dev);
-	struct resource *mmres;
-	void *ret;
-
-	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mmres)
-		return -ENODEV;
-
-	ret = request_mem_region(mmres->start, resource_size(mmres), "imx-uart");
-
-	return  ret ? 0 : -EBUSY;
-}
-
-/*
  * Configure/autoconfigure the port.
  */
 static void imx_config_port(struct uart_port *port, int flags)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 
-	if (flags & UART_CONFIG_TYPE &&
-	    imx_request_port(&sport->port) == 0)
+	if (flags & UART_CONFIG_TYPE)
 		sport->port.type = PORT_IMX;
 }
 
@@ -1616,8 +1585,6 @@ static struct uart_ops imx_pops = {
 	.flush_buffer	= imx_flush_buffer,
 	.set_termios	= imx_set_termios,
 	.type		= imx_type,
-	.release_port	= imx_release_port,
-	.request_port	= imx_request_port,
 	.config_port	= imx_config_port,
 	.verify_port	= imx_verify_port,
 #if defined(CONFIG_CONSOLE_POLL)
@@ -1950,12 +1917,9 @@ static int serial_imx_probe(struct platform_device *pdev)
 		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	base = devm_ioremap(&pdev->dev, res->start, PAGE_SIZE);
-	if (!base)
-		return -ENOMEM;
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
-- 
1.8.3.2

