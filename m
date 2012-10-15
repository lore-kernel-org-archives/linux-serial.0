From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH RESEND] serial/amba-pl011: use devm_* managed resources
Date: Mon, 15 Oct 2012 13:36:01 +0200
Message-ID: <1350300961-7036-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:59913 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752222Ab2JOLga (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Oct 2012 07:36:30 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Anmar Oueja <anmar.oueja@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

From: Linus Walleij <linus.walleij@linaro.org>

This switches a bunch of allocation and remapping to use the
devm_* garbage collected methods and cleans up the error
path and remove() paths consequently.

devm_ioremap() is only in <linux/io.h> so fix up the
erroneous <asm/*> include as well.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d7e1ede..7fca402 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -56,8 +56,7 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/sizes.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 
 #define UART_NR			14
 
@@ -1973,7 +1972,8 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		goto out;
 	}
 
-	uap = kzalloc(sizeof(struct uart_amba_port), GFP_KERNEL);
+	uap = devm_kzalloc(&dev->dev, sizeof(struct uart_amba_port),
+			   GFP_KERNEL);
 	if (uap == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -1981,16 +1981,17 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 
 	i = pl011_probe_dt_alias(i, &dev->dev);
 
-	base = ioremap(dev->res.start, resource_size(&dev->res));
+	base = devm_ioremap(&dev->dev, dev->res.start,
+			    resource_size(&dev->res));
 	if (!base) {
 		ret = -ENOMEM;
-		goto free;
+		goto out;
 	}
 
 	uap->pinctrl = devm_pinctrl_get(&dev->dev);
 	if (IS_ERR(uap->pinctrl)) {
 		ret = PTR_ERR(uap->pinctrl);
-		goto unmap;
+		goto out;
 	}
 	uap->pins_default = pinctrl_lookup_state(uap->pinctrl,
 						 PINCTRL_STATE_DEFAULT);
@@ -2002,10 +2003,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	if (IS_ERR(uap->pins_sleep))
 		dev_dbg(&dev->dev, "could not get sleep pinstate\n");
 
-	uap->clk = clk_get(&dev->dev, NULL);
+	uap->clk = devm_clk_get(&dev->dev, NULL);
 	if (IS_ERR(uap->clk)) {
 		ret = PTR_ERR(uap->clk);
-		goto unmap;
+		goto out;
 	}
 
 	uap->vendor = vendor;
@@ -2038,11 +2039,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		amba_set_drvdata(dev, NULL);
 		amba_ports[i] = NULL;
 		pl011_dma_remove(uap);
-		clk_put(uap->clk);
- unmap:
-		iounmap(base);
- free:
-		kfree(uap);
 	}
  out:
 	return ret;
@@ -2062,9 +2058,6 @@ static int pl011_remove(struct amba_device *dev)
 			amba_ports[i] = NULL;
 
 	pl011_dma_remove(uap);
-	iounmap(uap->port.membase);
-	clk_put(uap->clk);
-	kfree(uap);
 	return 0;
 }
 
-- 
1.7.11.3

