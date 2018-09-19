From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/3] serial: 8250_uniphier: flatten probe function
Date: Wed, 19 Sep 2018 14:28:12 +0900
Message-ID: <1537334893-26079-3-git-send-email-yamada.masahiro@socionext.com>
References: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Dai Okamura <okamura.dai@socionext.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Currently, the DT-related settings are split out to
uniphier_of_serial_setup(), but it turned out to be not nice.
The next commit will add a DT property, but it will not fit in
the helper.  Merge the helper into the probe function.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 49 ++++++++++++---------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index d292654..1028c02 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -155,36 +155,6 @@ static void uniphier_serial_dl_write(struct uart_8250_port *up, int value)
 	writel(value, up->port.membase + UNIPHIER_UART_DLR);
 }
 
-static int uniphier_of_serial_setup(struct device *dev, struct uart_port *port,
-				    struct uniphier8250_priv *priv)
-{
-	int ret;
-	u32 prop;
-	struct device_node *np = dev->of_node;
-
-	ret = of_alias_get_id(np, "serial");
-	if (ret < 0) {
-		dev_err(dev, "failed to get alias id\n");
-		return ret;
-	}
-	port->line = ret;
-
-	/* Get clk rate through clk driver */
-	priv->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		dev_err(dev, "failed to get clock\n");
-		return PTR_ERR(priv->clk);
-	}
-
-	ret = clk_prepare_enable(priv->clk);
-	if (ret < 0)
-		return ret;
-
-	port->uartclk = clk_get_rate(priv->clk);
-
-	return 0;
-}
-
 static int uniphier_uart_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -217,9 +187,24 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 
 	memset(&up, 0, sizeof(up));
 
-	ret = uniphier_of_serial_setup(dev, &up.port, priv);
-	if (ret < 0)
+	ret = of_alias_get_id(dev->of_node, "serial");
+	if (ret < 0) {
+		dev_err(dev, "failed to get alias id\n");
 		return ret;
+	}
+	up.port.line = ret;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "failed to get clock\n");
+		return PTR_ERR(priv->clk);
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	up.port.uartclk = clk_get_rate(priv->clk);
 
 	spin_lock_init(&priv->atomic_write_lock);
 
-- 
2.7.4
