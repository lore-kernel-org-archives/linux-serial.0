From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/4] serial: mxs-auart: Use devm_kzalloc()
Date: Thu, 27 Nov 2014 17:08:31 -0200
Message-ID: <1417115313-24113-2-git-send-email-festevam@gmail.com>
References: <1417115313-24113-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:43682 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbaK0TIy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Nov 2014 14:08:54 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so3593303qae.41
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2014 11:08:54 -0800 (PST)
In-Reply-To: <1417115313-24113-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: j.uzycki@elproma.com.pl, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

By using devm_kzalloc() we can have a shorter and cleaner code.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/mxs-auart.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index a9e7fa6..0b5f0ea 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1231,7 +1231,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	int ret = 0;
 	struct resource *r;
 
-	s = kzalloc(sizeof(struct mxs_auart_port), GFP_KERNEL);
+	s = devm_kzalloc(&pdev->dev, sizeof(*s), GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;
 
@@ -1239,7 +1239,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	if (ret > 0)
 		s->port.line = pdev->id < 0 ? 0 : pdev->id;
 	else if (ret < 0)
-		goto out_free;
+		return ret;
 
 	if (of_id) {
 		pdev->id_entry = of_id->data;
@@ -1247,10 +1247,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	}
 
 	s->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(s->clk)) {
-		ret = PTR_ERR(s->clk);
-		goto out_free;
-	}
+	if (IS_ERR(s->clk))
+		return PTR_ERR(s->clk);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
@@ -1310,8 +1308,6 @@ out_free_irq:
 	free_irq(s->irq, s);
 out_free_clk:
 	clk_put(s->clk);
-out_free:
-	kfree(s);
 	return ret;
 }
 
@@ -1326,7 +1322,6 @@ static int mxs_auart_remove(struct platform_device *pdev)
 	mxs_auart_free_gpio_irq(s);
 	clk_put(s->clk);
 	free_irq(s->irq, s);
-	kfree(s);
 
 	return 0;
 }
-- 
1.9.1

