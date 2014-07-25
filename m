From: jon@ringle.org
Subject: [PATCH] serial: sc16is7xx: Correct initialization of s->clk
Date: Fri, 25 Jul 2014 13:53:36 -0400
Message-ID: <1406310816-32094-1-git-send-email-jon@ringle.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:34104 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934625AbaGYRyD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jul 2014 13:54:03 -0400
Received: by mail-qa0-f44.google.com with SMTP id f12so4970960qad.3
        for <linux-serial@vger.kernel.org>; Fri, 25 Jul 2014 10:54:02 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, dan.carpenter@oracle.com
Cc: Jon Ringle <jringle@gridpoint.com>

From: Jon Ringle <jringle@gridpoint.com>

The s->clk never gets setup in sc16is7xx_probe() and instead was using a
local clk variable, but then testing the uninitialized s->clk during
teardown

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jon Ringle <jringle@gridpoint.com>
---
 drivers/tty/serial/sc16is7xx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index ed139f5..a0a2295 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1061,7 +1061,6 @@ static int sc16is7xx_probe(struct device *dev,
 			   struct regmap *regmap, int irq, unsigned long flags)
 {
 	unsigned long freq, *pfreq = dev_get_platdata(dev);
-	struct clk *clk;
 	int i, ret;
 	struct sc16is7xx_port *s;
 
@@ -1077,14 +1076,14 @@ static int sc16is7xx_probe(struct device *dev,
 		return -ENOMEM;
 	}
 
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
+	s->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(s->clk)) {
 		if (pfreq)
 			freq = *pfreq;
 		else
-			return PTR_ERR(clk);
+			return PTR_ERR(s->clk);
 	} else {
-		freq = clk_get_rate(clk);
+		freq = clk_get_rate(s->clk);
 	}
 
 	s->regmap = regmap;
-- 
1.8.5.4

