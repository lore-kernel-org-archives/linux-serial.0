From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/4] serial: mxs-auart: Use devm_clk_get()
Date: Thu, 27 Nov 2014 17:08:32 -0200
Message-ID: <1417115313-24113-3-git-send-email-festevam@gmail.com>
References: <1417115313-24113-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:59724 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbaK0TI6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Nov 2014 14:08:58 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so3922263qcv.36
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2014 11:08:57 -0800 (PST)
In-Reply-To: <1417115313-24113-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: j.uzycki@elproma.com.pl, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

By using devm_clk_get() we can have a shorter and cleaner code.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/mxs-auart.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 0b5f0ea..9309082 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1246,15 +1246,14 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		s->devtype = pdev->id_entry->driver_data;
 	}
 
-	s->clk = clk_get(&pdev->dev, NULL);
+	s->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(s->clk))
 		return PTR_ERR(s->clk);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		ret = -ENXIO;
-		goto out_free_clk;
-	}
+	if (!r)
+		return -ENXIO;
+
 
 	s->port.mapbase = r->start;
 	s->port.membase = ioremap(r->start, resource_size(r));
@@ -1271,7 +1270,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->port.irq = s->irq;
 	ret = request_irq(s->irq, mxs_auart_irq_handle, 0, dev_name(&pdev->dev), s);
 	if (ret)
-		goto out_free_clk;
+		return ret;
 
 	platform_set_drvdata(pdev, s);
 
@@ -1306,8 +1305,6 @@ out_free_gpio_irq:
 out_free_irq:
 	auart_port[pdev->id] = NULL;
 	free_irq(s->irq, s);
-out_free_clk:
-	clk_put(s->clk);
 	return ret;
 }
 
@@ -1320,7 +1317,6 @@ static int mxs_auart_remove(struct platform_device *pdev)
 	auart_port[pdev->id] = NULL;
 
 	mxs_auart_free_gpio_irq(s);
-	clk_put(s->clk);
 	free_irq(s->irq, s);
 
 	return 0;
-- 
1.9.1

