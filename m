From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 1/2] serial/amba-pl011: use devm_* allocators
Date: Sun, 17 Jun 2012 15:44:08 +0200
Message-ID: <1339940648-6847-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:36841 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757204Ab2FQNpE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Jun 2012 09:45:04 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

From: Linus Walleij <linus.walleij@linaro.org>

This switches a bunch of allocation and remapping to use the
devm_* garbage collected methods and cleans up the error
path and remove() paths consequently.

devm_ioremap() is only in <linux/io.h> so fix up the
erroneous <asm/*> include as well.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c17923e..3ce984f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -53,8 +53,8 @@
 #include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/sizes.h>
 
 #define UART_NR			14
@@ -1885,22 +1885,24 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		goto out;
 	}
 
-	uap = kzalloc(sizeof(struct uart_amba_port), GFP_KERNEL);
+	uap = devm_kzalloc(&dev->dev, sizeof(struct uart_amba_port),
+			   GFP_KERNEL);
 	if (uap == NULL) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
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
@@ -1915,7 +1917,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(uap->clk)) {
 		ret = PTR_ERR(uap->clk);
-		goto unmap;
+		goto out;
 	}
 
 	uap->vendor = vendor;
@@ -1950,10 +1952,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		amba_ports[i] = NULL;
 		pl011_dma_remove(uap);
 		clk_put(uap->clk);
- unmap:
-		iounmap(base);
- free:
-		kfree(uap);
 	}
  out:
 	return ret;
@@ -1973,9 +1971,7 @@ static int pl011_remove(struct amba_device *dev)
 			amba_ports[i] = NULL;
 
 	pl011_dma_remove(uap);
-	iounmap(uap->port.membase);
 	clk_put(uap->clk);
-	kfree(uap);
 	return 0;
 }
 
-- 
1.7.9.2

