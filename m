From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/4] serial: mxs-auart: Use devm_request_irq()
Date: Thu, 27 Nov 2014 17:08:33 -0200
Message-ID: <1417115313-24113-4-git-send-email-festevam@gmail.com>
References: <1417115313-24113-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:52992 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbaK0TJA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Nov 2014 14:09:00 -0500
Received: by mail-qg0-f47.google.com with SMTP id z60so3870602qgd.6
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2014 11:09:00 -0800 (PST)
In-Reply-To: <1417115313-24113-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: j.uzycki@elproma.com.pl, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

By using devm_request_irq() we can have a shorter and cleaner code.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/mxs-auart.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 9309082..1e9fb37 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1268,7 +1268,8 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	s->irq = platform_get_irq(pdev, 0);
 	s->port.irq = s->irq;
-	ret = request_irq(s->irq, mxs_auart_irq_handle, 0, dev_name(&pdev->dev), s);
+	ret = devm_request_irq(&pdev->dev, s->irq, mxs_auart_irq_handle, 0,
+			       dev_name(&pdev->dev), s);
 	if (ret)
 		return ret;
 
@@ -1283,7 +1284,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	 */
 	ret = mxs_auart_request_gpio_irq(s);
 	if (ret)
-		goto out_free_irq;
+		return ret;
 
 	auart_port[s->port.line] = s;
 
@@ -1302,9 +1303,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 out_free_gpio_irq:
 	mxs_auart_free_gpio_irq(s);
-out_free_irq:
 	auart_port[pdev->id] = NULL;
-	free_irq(s->irq, s);
 	return ret;
 }
 
@@ -1313,11 +1312,8 @@ static int mxs_auart_remove(struct platform_device *pdev)
 	struct mxs_auart_port *s = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&auart_driver, &s->port);
-
 	auart_port[pdev->id] = NULL;
-
 	mxs_auart_free_gpio_irq(s);
-	free_irq(s->irq, s);
 
 	return 0;
 }
-- 
1.9.1

