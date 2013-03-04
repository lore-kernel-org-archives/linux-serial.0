From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] serial: vt8500_serial: Convert to devm_ioremap_resource()
Date: Mon,  4 Mar 2013 14:24:39 +0530
Message-ID: <1362387279-31829-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:55938 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab3CDJFG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Mar 2013 04:05:06 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so2965693pbc.31
        for <linux-serial@vger.kernel.org>; Mon, 04 Mar 2013 01:05:06 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux@prisktech.co.nz, gregkh@linuxfoundation.org, sachin.kamat@linaro.org, thierry.reding@avionic-design.de

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/vt8500_serial.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index a3f9dd5..f15f53f 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -35,6 +35,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/err.h>
 
 /*
  * UART Register offsets
@@ -585,9 +586,9 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	if (!vt8500_port)
 		return -ENOMEM;
 
-	vt8500_port->uart.membase = devm_request_and_ioremap(&pdev->dev, mmres);
-	if (!vt8500_port->uart.membase)
-		return -EADDRNOTAVAIL;
+	vt8500_port->uart.membase = devm_ioremap_resource(&pdev->dev, mmres);
+	if (IS_ERR(vt8500_port->uart.membase))
+		return PTR_ERR(vt8500_port->uart.membase);
 
 	vt8500_port->clk = of_clk_get(pdev->dev.of_node, 0);
 	if (IS_ERR(vt8500_port->clk)) {
-- 
1.7.4.1

