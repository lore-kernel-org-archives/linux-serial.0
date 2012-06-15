From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/3] serial: mxs-auart: Allow device tree probing
Date: Fri, 15 Jun 2012 08:32:29 -0300
Message-ID: <1339759950-5507-2-git-send-email-festevam@gmail.com>
References: <1339759950-5507-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33243 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862Ab2FOLco (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Jun 2012 07:32:44 -0400
Received: by yhmm54 with SMTP id m54so2327694yhm.19
        for <linux-serial@vger.kernel.org>; Fri, 15 Jun 2012 04:32:43 -0700 (PDT)
In-Reply-To: <1339759950-5507-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, marex@denx.de, matt@grid-net.com, snijsure@grid-net.com, rob.herring@calxeda.com, Fabio Estevam <fabio.estevam@freescale.com>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Allow device tree probing.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: <linux-serial@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Merged patches 3 and 5 from v1 into this one
 .../bindings/tty/serial/fsl-mxs-auart.txt          |   13 +++++
 drivers/tty/serial/mxs-auart.c                     |   55 +++++++++++++++++++-
 2 files changed, 67 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
new file mode 100644
index 0000000..1b28b1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/fsl-mxs-auart.txt
@@ -0,0 +1,13 @@
+* Freescale MXS Application UART (AUART)
+
+Required properties:
+- compatible : Should be "fsl,mxs-uart"
+- reg : Address and length of the register set for the device
+- interrupts : Should contain the auart interrupt
+
+Example:
+auart0: serial@8006a000 {
+	compatible = "fsl,mxs-auart";
+	reg = <0x8006a000 0x2000>;
+	interrupts = <112 70 71>;
+};
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ec56d83..21e2ce7 100644
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

