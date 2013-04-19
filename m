From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] serial: mxs: drop superfluous {get|put}_device
Date: Fri, 19 Apr 2013 21:06:20 +0200
Message-ID: <1366398380-26441-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35533 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753274Ab3DSTGi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Apr 2013 15:06:38 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huang Shijie <b32955@freescale.com>, kernel@pengutronix.de, Wolfram Sang <wsa@the-dreams.de>

Driver core already takes care of refcounting, no need to do this on
driver level again.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/tty/serial/mxs-auart.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index d549fe1..3c2d8be 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1103,7 +1103,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->port.fifosize = 16;
 	s->port.uartclk = clk_get_rate(s->clk);
 	s->port.type = PORT_IMX;
-	s->port.dev = s->dev = get_device(&pdev->dev);
+	s->port.dev = s->dev = &pdev->dev;
 
 	s->ctrl = 0;
 
@@ -1134,7 +1134,6 @@ out_free_irq:
 	auart_port[pdev->id] = NULL;
 	free_irq(s->irq, s);
 out_free_clk:
-	put_device(s->dev);
 	clk_put(s->clk);
 out_free:
 	kfree(s);
@@ -1150,7 +1149,6 @@ static int mxs_auart_remove(struct platform_device *pdev)
 
 	auart_port[pdev->id] = NULL;
 
-	put_device(s->dev);
 	clk_put(s->clk);
 	free_irq(s->irq, s);
 	kfree(s);
-- 
1.7.10.4

