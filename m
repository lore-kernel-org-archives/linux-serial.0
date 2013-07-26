From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH] serial8250-em: Convert to devm_* managed helpers
Date: Fri, 26 Jul 2013 16:22:02 +0200
Message-ID: <1374848522-13125-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>
List-Id: linux-serial@vger.kernel.org

Replace kzalloc and clk_get by their managed counterparts to simplify
error and cleanup paths.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/8250/8250_em.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 916cc19..5f3bba1 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -95,25 +95,23 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	struct serial8250_em_priv *priv;
 	struct uart_8250_port up;
-	int ret = -EINVAL;
+	int ret;
 
 	if (!regs || !irq) {
 		dev_err(&pdev->dev, "missing registers or irq\n");
-		goto err0;
+		return -EINVAL;
 	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		dev_err(&pdev->dev, "unable to allocate private data\n");
-		ret = -ENOMEM;
-		goto err0;
+		return -ENOMEM;
 	}
 
-	priv->sclk = clk_get(&pdev->dev, "sclk");
+	priv->sclk = devm_clk_get(&pdev->dev, "sclk");
 	if (IS_ERR(priv->sclk)) {
 		dev_err(&pdev->dev, "unable to get clock\n");
-		ret = PTR_ERR(priv->sclk);
-		goto err1;
+		return PTR_ERR(priv->sclk);
 	}
 
 	memset(&up, 0, sizeof(up));
@@ -136,20 +134,13 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "unable to register 8250 port\n");
-		goto err2;
+		clk_disable(priv->sclk);
+		return ret;
 	}
 
 	priv->line = ret;
 	platform_set_drvdata(pdev, priv);
 	return 0;
-
- err2:
-	clk_disable(priv->sclk);
-	clk_put(priv->sclk);
- err1:
-	kfree(priv);
- err0:
-	return ret;
 }
 
 static int serial8250_em_remove(struct platform_device *pdev)
@@ -158,8 +149,6 @@ static int serial8250_em_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(priv->line);
 	clk_disable(priv->sclk);
-	clk_put(priv->sclk);
-	kfree(priv);
 	return 0;
 }
 
-- 
Regards,

Laurent Pinchart

