From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] serial: mxs-auart: disable clks of Alphascale ASM9260
Date: Sat,  3 Mar 2018 01:42:01 +0300
Message-ID: <1520030521-19049-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

In case of Alphascale ASM9260 probe() enables s->clk and s->clk_ahb
via mxs_get_clks(), but there is no disable of the clocks.
The patch adds it to error paths and to mxs_auart_remove().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 254da0d753fb ("serial: mxs-auart: add Alphascale ASM9260 support")
---
 drivers/tty/serial/mxs-auart.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 079dc47aa142..531c374a5e3e 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1674,8 +1674,10 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		return ret;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r)
-		return -ENXIO;
+	if (!r) {
+		ret = -ENXIO;
+		goto out_disable_clks;
+	}
 
 	s->port.mapbase = r->start;
 	s->port.membase = ioremap(r->start, resource_size(r));
@@ -1690,21 +1692,23 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	s->mctrl_prev = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto out_disable_clks;
+	}
 
 	s->port.irq = irq;
 	ret = devm_request_irq(&pdev->dev, irq, mxs_auart_irq_handle, 0,
 			       dev_name(&pdev->dev), s);
 	if (ret)
-		return ret;
+		goto out_disable_clks;
 
 	platform_set_drvdata(pdev, s);
 
 	ret = mxs_auart_init_gpios(s, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize GPIOs.\n");
-		return ret;
+		goto out_disable_clks;
 	}
 
 	/*
@@ -1712,7 +1716,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 	 */
 	ret = mxs_auart_request_gpio_irq(s);
 	if (ret)
-		return ret;
+		goto out_disable_clks;
 
 	auart_port[s->port.line] = s;
 
@@ -1720,7 +1724,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(&auart_driver, &s->port);
 	if (ret)
-		goto out_disable_clks_free_qpio_irq;
+		goto out_free_qpio_irq;
 
 	/* ASM9260 don't have version reg */
 	if (is_asm9260_auart(s)) {
@@ -1734,13 +1738,15 @@ static int mxs_auart_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_disable_clks_free_qpio_irq:
-	if (s->clk)
-		clk_disable_unprepare(s->clk_ahb);
-	if (s->clk_ahb)
-		clk_disable_unprepare(s->clk_ahb);
+out_free_qpio_irq:
 	mxs_auart_free_gpio_irq(s);
 	auart_port[pdev->id] = NULL;
+
+out_disable_clks:
+	if (is_asm9260_auart(s)) {
+		clk_disable_unprepare(s->clk);
+		clk_disable_unprepare(s->clk_ahb);
+	}
 	return ret;
 }
 
@@ -1751,6 +1757,10 @@ static int mxs_auart_remove(struct platform_device *pdev)
 	uart_remove_one_port(&auart_driver, &s->port);
 	auart_port[pdev->id] = NULL;
 	mxs_auart_free_gpio_irq(s);
+	if (is_asm9260_auart(s)) {
+		clk_disable_unprepare(s->clk);
+		clk_disable_unprepare(s->clk_ahb);
+	}
 
 	return 0;
 }
-- 
2.7.4
