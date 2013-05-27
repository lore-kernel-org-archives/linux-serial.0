From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] serial: mxs-auart: Let device core handle pinctrl
Date: Sun, 26 May 2013 22:43:05 -0300
Message-ID: <1369618985-9658-2-git-send-email-festevam@gmail.com>
References: <1369618985-9658-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ye0-f175.google.com ([209.85.213.175]:60572 "EHLO
	mail-ye0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab3E0BuG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 26 May 2013 21:50:06 -0400
Received: by mail-ye0-f175.google.com with SMTP id q1so694740yen.34
        for <linux-serial@vger.kernel.org>; Sun, 26 May 2013 18:50:05 -0700 (PDT)
In-Reply-To: <1369618985-9658-1-git-send-email-festevam@gmail.com>
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
 drivers/tty/serial/mxs-auart.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 4f5f161..a63a20e 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -32,7 +32,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/of_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -1015,7 +1014,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	u32 version;
 	int ret = 0;
 	struct resource *r;
-	struct pinctrl *pinctrl;
 
 	s = kzalloc(sizeof(struct mxs_auart_port), GFP_KERNEL);
 	if (!s) {
@@ -1029,12 +1027,6 @@ static int mxs_auart_probe(struct platform_device *pdev)
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
1.8.1.2

