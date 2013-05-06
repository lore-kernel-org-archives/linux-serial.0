From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 09/13] serial: imx: Let device core handle pinctrl
Date: Mon, 6 May 2013 15:05:57 -0300
Message-ID: <1367863561-11534-9-git-send-email-fabio.estevam@freescale.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:45839
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754502Ab3EFSGm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 May 2013 14:06:42 -0400
In-Reply-To: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: shawn.guo@linaro.org
Cc: kernel@pengutronix.de, festevam@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
we can rely on device core for handling pinctrl.

So remove devm_pinctrl_get_select_default() from the driver. 

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-serial@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 147c9e1..8552700 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -47,7 +47,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
@@ -1466,7 +1465,6 @@ static int serial_imx_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret = 0;
 	struct resource *res;
-	struct pinctrl *pinctrl;
 
 	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
 	if (!sport)
@@ -1502,13 +1500,6 @@ static int serial_imx_probe(struct platform_device *pdev)
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
1.7.9.5


