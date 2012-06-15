From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/5] serial: mxs-auart: Allow device tree probing
Date: Fri, 15 Jun 2012 00:33:03 -0300
Message-ID: <1339731185-4889-3-git-send-email-festevam@gmail.com>
References: <1339731185-4889-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:36862 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab2FODeH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Jun 2012 23:34:07 -0400
Received: by ghrr11 with SMTP id r11so1980301ghr.19
        for <linux-serial@vger.kernel.org>; Thu, 14 Jun 2012 20:34:06 -0700 (PDT)
In-Reply-To: <1339731185-4889-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, marex@denx.de, matt@grid-net.com, snijsure@grid-net.com, Fabio Estevam <fabio.estevam@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Allow device tree probing.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: <linux-serial@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/mxs-auart.c |   55 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ec56d83..467b8a2 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/of_device.h>
 
 #include <asm/cacheflush.h>
 
@@ -675,6 +676,44 @@ static struct uart_driver auart_driver = {
 #endif
 };
 
+#ifdef CONFIG_OF
+/*
+ * This function returns 1 if pdev isn't a device instatiated by dt, 0 if it
+ * could successfully get all information from dt or a negative errno.
+ */
+static int serial_mxs_probe_dt(struct mxs_auart_port *s,
+		struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	if (!np)
+		/* no device tree device */
+		return 1;
+
+	ret = of_alias_get_id(np, "serial");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id: %d\n", ret);
+		return ret;
+	}
+	s->port.line = ret;
+
+	return 0;
+}
+#else
+static inline int serial_mxs_probe_dt(struct mxs_auart_port *s,
+		struct platform_device *pdev)
+{
+	return 1;
+}
+#endif
+
+static void mxs_auart_probe_pdev(struct mxs_auart_port *s,
+		struct platform_device *pdev)
+{
+	s->port.line = pdev->id < 0 ? 0 : pdev->id;
+}
+
 static int __devinit mxs_auart_probe(struct platform_device *pdev)
 {
 	struct mxs_auart_port *s;
@@ -689,6 +728,14 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	ret = serial_mxs_probe_dt(s, pdev);
+	if (ret > 0)
+		mxs_auart_probe_pdev(s, pdev);
+	else if (ret < 0) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl)) {
 		ret = PTR_ERR(pinctrl);
@@ -711,7 +758,6 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
 	s->port.membase = ioremap(r->start, resource_size(r));
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
-	s->port.line = pdev->id < 0 ? 0 : pdev->id;
 	s->port.fifosize = 16;
 	s->port.uartclk = clk_get_rate(s->clk);
 	s->port.type = PORT_IMX;
@@ -769,12 +815,19 @@ static int __devexit mxs_auart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id mxs_auart_dt_ids[] = {
+	{.compatible = "fsl,mxs-auart", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_auart_dt_ids);
+
 static struct platform_driver mxs_auart_driver = {
 	.probe = mxs_auart_probe,
 	.remove = __devexit_p(mxs_auart_remove),
 	.driver = {
 		.name = "mxs-auart",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(mxs_auart_dt_ids),
 	},
 };
 
-- 
1.7.1

