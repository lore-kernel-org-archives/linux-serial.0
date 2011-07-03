From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] serial/imx: add device tree probe support
Date: Sun,  3 Jul 2011 15:56:00 +0800
Message-ID: <1309679760-22796-3-git-send-email-shawn.guo@linaro.org>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54497 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab1GCHp4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 3 Jul 2011 03:45:56 -0400
Received: by mail-iy0-f174.google.com with SMTP id 12so3771470iyb.19
        for <linux-serial@vger.kernel.org>; Sun, 03 Jul 2011 00:45:55 -0700 (PDT)
In-Reply-To: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Jeremy Kerr <jeremy.kerr@canonical.com>, Jason Liu <jason.hui@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Grant Likely <grant.likely@secretlab.ca>

It adds device tree probe support for imx tty/serial driver.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Jason Liu <jason.hui@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 .../bindings/tty/serial/fsl-imx-uart.txt           |   19 +++++
 drivers/tty/serial/imx.c                           |   82 +++++++++++++++++---
 2 files changed, 91 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
new file mode 100644
index 0000000..a9c0406
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
@@ -0,0 +1,19 @@
+* Freescale i.MX Universal Asynchronous Receiver/Transmitter (UART)
+
+Required properties:
+- compatible : Should be "fsl,<soc>-uart"
+- reg : Address and length of the register set for the device
+- interrupts : Should contain uart interrupt
+
+Optional properties:
+- fsl,uart-has-rtscts : Indicate the uart has rts and cts
+- fsl,irda-mode : Indicate the uart supports irda mode
+
+Example:
+
+uart@73fbc000 {
+	compatible = "fsl,imx51-uart", "fsl,imx21-uart";
+	reg = <0x73fbc000 0x4000>;
+	interrupts = <31>;
+	fsl,uart-has-rtscts;
+};
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 983f3bd..483c447 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -45,6 +45,8 @@
 #include <linux/delay.h>
 #include <linux/rational.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -239,6 +241,12 @@ static struct platform_device_id imx_uart_devtype[] = {
 	}
 };
 
+static struct of_device_id imx_uart_dt_ids[] = {
+	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
+	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX2_UART], },
+	{ /* sentinel */ },
+};
+
 /*
  * Handle any change of modem status signal since we were last called.
  */
@@ -1261,6 +1269,58 @@ static int serial_imx_resume(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static int serial_imx_probe_dt(struct imx_port *sport,
+		struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id =
+			of_match_device(imx_uart_dt_ids, &pdev->dev);
+
+	if (!np)
+		return -ENODEV;
+
+	pdev->id = of_alias_get_id(np, "serial");
+	if (pdev->id < 0)
+		return -ENODEV;
+
+	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
+		sport->have_rtscts = 1;
+
+	if (of_get_property(np, "fsl,irda-mode", NULL))
+		sport->use_irda = 1;
+
+	sport->devdata = of_id->data;
+
+	return 0;
+}
+#else
+static inline int serial_imx_probe_dt(struct imx_port *sport,
+		struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+#endif
+
+static int serial_imx_probe_pdata(struct imx_port *sport,
+		struct platform_device *pdev)
+{
+	struct imxuart_platform_data *pdata = pdev->dev.platform_data;
+
+	if (!pdata)
+		return 0;
+
+	if (pdata->flags & IMXUART_HAVE_RTSCTS)
+		sport->have_rtscts = 1;
+
+	if (pdata->flags & IMXUART_IRDA)
+		sport->use_irda = 1;
+
+	sport->devdata = &imx_uart_devdata[pdev->id_entry->driver_data];
+
+	return 0;
+}
+
 static int serial_imx_probe(struct platform_device *pdev)
 {
 	struct imx_port *sport;
@@ -1273,6 +1333,12 @@ static int serial_imx_probe(struct platform_device *pdev)
 	if (!sport)
 		return -ENOMEM;
 
+	ret = serial_imx_probe_dt(sport, pdev);
+	if (ret == -ENODEV)
+		ret = serial_imx_probe_pdata(sport, pdev);
+	if (ret)
+		goto free;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENODEV;
@@ -1301,7 +1367,6 @@ static int serial_imx_probe(struct platform_device *pdev)
 	init_timer(&sport->timer);
 	sport->timer.function = imx_timeout;
 	sport->timer.data     = (unsigned long)sport;
-	sport->devdata = &imx_uart_devdata[pdev->id_entry->driver_data];
 
 	sport->clk = clk_get(&pdev->dev, "uart");
 	if (IS_ERR(sport->clk)) {
@@ -1312,17 +1377,13 @@ static int serial_imx_probe(struct platform_device *pdev)
 
 	sport->port.uartclk = clk_get_rate(sport->clk);
 
-	imx_ports[pdev->id] = sport;
+	if (imx_ports[sport->port.line]) {
+		ret = -EBUSY;
+		goto clkput;
+	}
+	imx_ports[sport->port.line] = sport;
 
 	pdata = pdev->dev.platform_data;
-	if (pdata && (pdata->flags & IMXUART_HAVE_RTSCTS))
-		sport->have_rtscts = 1;
-
-#ifdef CONFIG_IRDA
-	if (pdata && (pdata->flags & IMXUART_IRDA))
-		sport->use_irda = 1;
-#endif
-
 	if (pdata && pdata->init) {
 		ret = pdata->init(pdev);
 		if (ret)
@@ -1384,6 +1445,7 @@ static struct platform_driver serial_imx_driver = {
 	.driver		= {
 		.name	= "imx-uart",
 		.owner	= THIS_MODULE,
+		.of_match_table = imx_uart_dt_ids,
 	},
 };
 
-- 
1.7.4.1

