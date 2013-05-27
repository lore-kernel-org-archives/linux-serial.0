From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] serial: imx: Let device core handle pinctrl
Date: Sun, 26 May 2013 22:43:04 -0300
Message-ID: <1369618985-9658-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:36556 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690Ab3E0BnV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 26 May 2013 21:43:21 -0400
Received: by mail-yh0-f51.google.com with SMTP id c41so155754yho.38
        for <linux-serial@vger.kernel.org>; Sun, 26 May 2013 18:43:20 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit ab78029 (drivers/pinctrl: grab default handles from device core)
we can rely on device core for handling pinctrl, so remove 
devm_pinctrl_get_select_default() from the driver.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 72bc1db..2ea3494 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -47,7 +47,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
@@ -1481,7 +1480,6 @@ static int serial_imx_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret = 0;
 	struct resource *res;
-	struct pinctrl *pinctrl;
 
 	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
 	if (!sport)
@@ -1517,13 +1515,6 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->timer.function = imx_timeout;
 	sport->timer.data     = (unsigned long)sport;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
-		dev_err(&pdev->dev, "failed to get default pinctrl: %d\n", ret);
-		return ret;
-	}
-
 	sport->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(sport->clk_ipg)) {
 		ret = PTR_ERR(sport->clk_ipg);
-- 
1.8.1.2

