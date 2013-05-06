From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 10/13] serial: mxs-auart: Let device core handle pinctrl
Date: Mon, 6 May 2013 15:05:58 -0300
Message-ID: <1367863561-11534-10-git-send-email-fabio.estevam@freescale.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:55472
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755075Ab3EFSGo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 May 2013 14:06:44 -0400
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
 drivers/tty/serial/mxs-auart.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index d549fe1..573d656 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -32,7 +32,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/of_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/fsl/mxs-dma.h>
@@ -1059,7 +1058,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	u32 version;
 	int ret = 0;
 	struct resource *r;
-	struct pinctrl *pinctrl;
 
 	s = kzalloc(sizeof(struct mxs_auart_port), GFP_KERNEL);
 	if (!s) {
@@ -1073,12 +1071,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	else if (ret < 0)
 		goto out_free;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
-		goto out_free;
-	}
-
 	if (of_id) {
 		pdev->id_entry = of_id->data;
 		s->devtype = pdev->id_entry->driver_data;
-- 
1.7.9.5


