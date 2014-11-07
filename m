From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] serial: fsl_lpuart: Remove unneeded check for 'res'
Date: Fri,  7 Nov 2014 00:23:13 -0200
Message-ID: <1415326994-11666-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:63193 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaKGCXc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 21:23:32 -0500
Received: by mail-qg0-f51.google.com with SMTP id j5so1746219qga.24
        for <linux-serial@vger.kernel.org>; Thu, 06 Nov 2014 18:23:31 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: b35083@freescale.com, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

'res' will be automatically checked inside devm_ioremap_resource(), so there is
no need to explicitly perform a NULL check.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/fsl_lpuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6dd53af..567d0ad 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1786,15 +1786,13 @@ static int lpuart_probe(struct platform_device *pdev)
 	}
 	sport->port.line = ret;
 	sport->lpuart32 = of_device_is_compatible(np, "fsl,ls1021a-lpuart");
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
 
-	sport->port.mapbase = res->start;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(sport->port.membase))
 		return PTR_ERR(sport->port.membase);
 
+	sport->port.mapbase = res->start;
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
 	sport->port.iotype = UPIO_MEM;
-- 
1.9.1

