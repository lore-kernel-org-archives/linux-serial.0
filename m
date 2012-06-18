From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v4 2/2] serial: mxs-auart: Allow device tree probing
Date: Mon, 18 Jun 2012 10:06:09 -0300
Message-ID: <1340024769-7122-1-git-send-email-fabio.estevam@freescale.com>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:27646
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600Ab2FRNG1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Jun 2012 09:06:27 -0400
In-Reply-To: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, marex@denx.de, rob.herring@calxeda.com, Fabio Estevam <fabio.estevam@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Allow device tree probing.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: <linux-serial@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v3:
- Remove unneeded mxs_auart_devtype
Changes since v2:
- Change compatible string
- Add aliases information in bindings doc
- Remove unneeded mxs_auart_probe_pdev function
- Remove "ifdef CONFIG_OF"
- Remove of_match_ptr wrapper
Changes since v1:
- Merged patches 3 and 5 from v1 into this one
 .../bindings/tty/serial/fsl-mxs-auart.txt          |   27 +++++++++++++
 drivers/tty/serial/mxs-auart.c                     |   40 +++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
new file mode 100644
index 0000000..2ee903f
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
@@ -0,0 +1,27 @@
+* Freescale MXS Application UART (AUART)
+
+Required properties:
+- compatible : Should be "fsl,<soc>-auart". The supported SoCs include
+  imx23 and imx28.
+- reg : Address and length of the register set for the device
+- interrupts : Should contain the auart interrupt numbers
+
+Example:
+auart0: serial@8006a000 {
+	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+	reg = <0x8006a000 0x2000>;
+	interrupts = <112 70 71>;
+};
+
+Note: Each auart port should have an alias correctly numbered in "aliases"
+node.
+
+Example:
+
+aliases {
+	serial0 = &auart0;
+	serial1 = &auart1;
+	serial2 = &auart2;
+	serial3 = &auart3;
+	serial4 = &auart4;
+};
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ec56d83..103087d 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/of_device.h>
 
 #include <asm/cacheflush.h>
 
@@ -675,6 +676,30 @@ static struct uart_driver auart_driver = {
 #endif
 };
 
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
+
 static int __devinit mxs_auart_probe(struct platform_device *pdev)
 {
 	struct mxs_auart_port *s;
@@ -689,6 +714,12 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	ret = serial_mxs_probe_dt(s, pdev);
+	if (ret > 0)
+		s->port.line = pdev->id < 0 ? 0 : pdev->id;
+	else if (ret < 0)
+		goto out_free;
+
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl)) {
 		ret = PTR_ERR(pinctrl);
@@ -711,7 +742,6 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
 	s->port.membase = ioremap(r->start, resource_size(r));
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
-	s->port.line = pdev->id < 0 ? 0 : pdev->id;
 	s->port.fifosize = 16;
 	s->port.uartclk = clk_get_rate(s->clk);
 	s->port.type = PORT_IMX;
@@ -769,12 +799,19 @@ static int __devexit mxs_auart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id mxs_auart_dt_ids[] = {
+	{ .compatible = "fsl,imx23-auart", },
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
+		.of_match_table = mxs_auart_dt_ids,
 	},
 };
 
@@ -807,3 +844,4 @@ module_init(mxs_auart_init);
 module_exit(mxs_auart_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Freescale MXS application uart driver");
+MODULE_ALIAS("platform:mxs-auart");
-- 
1.7.1


