From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH v2 1/3] serial: sh-sci: Add OF support
Date: Mon, 25 Feb 2013 13:06:53 -0600
Message-ID: <1361819215-4115-1-git-send-email-hechtb+renesas@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:62072 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab3BYSHA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Feb 2013 13:07:00 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org

We add the capabilty to probe Renesas SCI devices using Device Tree setup.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
Based on the topic/all+next branch from the 17th Feb. I couldn't rebase it on the current HEAD as the armadillo-reference code currently isn't in.

changelog v2:
 - Renamed title to "Add OF support"
 - Removed fixed configurations from driver and added the following binding props:
	- renesas,scscr
	- renesas,scbrr-algo-id
	- renesas,autoconf
	- renesas,regtype
	See patch for descriptions

 .../bindings/tty/serial/renesas,sci-serial.txt     |   47 +++++++
 drivers/tty/serial/sh-sci.c                        |  131 +++++++++++++++++++-
 2 files changed, 174 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
new file mode 100644
index 0000000..f9163a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
@@ -0,0 +1,47 @@
+* Renesas SH-Mobile Serial Communication Interface
+
+Required properties:
+- compatible : Should be "renesas,sci-<port type>-uart", where <port type> may be
+  SCI, SCIF, IRDA, SCIFA or SCIFB.
+- reg : Address and length of the register set for the device
+- interrupts : Should contain the following IRQs: ERI, RXI, TXI and BRI.
+- cell-index : The device id.
+- renesas,scscr : Should contain a bitfield used by the Serial Control Register.
+  b7 = SCSCR_TIE
+  b6 = SCSCR_RIE
+  b5 = SCSCR_TE
+  b4 = SCSCR_RE
+  b3 = SCSCR_REIE
+  b2 = SCSCR_TOIE
+  b1 = SCSCR_CKE1
+  b0 = SCSCR_CKE0
+- renesas,scbrr-algo-id : Algorithm ID for the Bit Rate Register
+  1 = SCBRR_ALGO_1 ((clk + 16 * bps) / (16 * bps) - 1)
+  2 = SCBRR_ALGO_2 ((clk + 16 * bps) / (32 * bps) - 1)
+  3 = SCBRR_ALGO_3 (((clk * 2) + 16 * bps) / (16 * bps) - 1)
+  4 = SCBRR_ALGO_4 (((clk * 2) + 16 * bps) / (32 * bps) - 1)
+  5 = SCBRR_ALGO_5 (((clk * 1000 / 32) / bps) - 1)
+
+Optional properties:
+- renesas,autoconf : Set if device is capable of auto configuration
+- renesas,regtype : Overwrite the register layout. Some legacy hardware versions
+  use a non-default register layout. Possible layouts are
+  0 = SCIx_SH2_SCIF_FIFODATA_REGTYPE
+  1 = SCIx_SH3_SCIF_REGTYPE
+  2 = SCIx_SH4_SCIF_REGTYPE
+  3 = SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE
+  4 = SCIx_SH4_SCIF_FIFODATA_REGTYPE
+  5 = SCIx_SH7705_SCIF_REGTYPE
+
+
+Example:
+	sci@0xe6c50000 {
+		compatible = "renesas,sci-SCIFA-uart";
+		interrupt-parent = <&intca>;
+		reg = <0xe6c50000 0x100>;
+		interrupts = <0x0c20>, <0x0c20>, <0x0c20>, <0x0c20>;
+		cell-index = <1>;
+		renesas,scscr = <0x30>;
+		renesas,scbrr-algo-id = <4>;
+		renesas,autoconf;
+	};
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6147756..d183f3a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2353,6 +2353,117 @@ static int sci_remove(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id of_sci_match[] = {
+	{ .compatible = "renesas,sci-SCI-uart",
+		.data = (void *)PORT_SCI },
+	{ .compatible = "renesas,sci-SCIF-uart",
+		.data = (void *)PORT_SCIF },
+	{ .compatible = "renesas,sci-IRDA-uart",
+		.data = (void *)PORT_IRDA },
+	{ .compatible = "renesas,sci-SCIFA-uart",
+		.data = (void *)PORT_SCIFA },
+	{ .compatible = "renesas,sci-SCIFB-uart",
+		.data = (void *)PORT_SCIFB },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_sci_match);
+
+/* This array belongs to the DT binding definition "renesas,regtype" */
+static const char sci_regtype_modes[] = {
+	SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+	SCIx_SH3_SCIF_REGTYPE,
+	SCIx_SH4_SCIF_REGTYPE,
+	SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE,
+	SCIx_SH4_SCIF_FIFODATA_REGTYPE,
+	SCIx_SH7705_SCIF_REGTYPE
+};
+
+static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
+								int *dev_id)
+{
+	struct plat_sci_port *p;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match;
+	struct resource *res;
+	const __be32 *prop;
+	int i, irq, val;
+
+	match = of_match_node(of_sci_match, pdev->dev.of_node);
+	if (!match || !match->data) {
+		dev_err(&pdev->dev, "OF match error\n");
+		return NULL;
+	}
+
+	p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
+	if (!p) {
+		dev_err(&pdev->dev, "failed to allocate DT config data\n");
+		return NULL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get I/O memory\n");
+		return NULL;
+	}
+	p->mapbase = res->start;
+
+	for (i = 0; i < SCIx_NR_IRQS; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			dev_err(&pdev->dev, "failed to get irq data %d\n", i);
+			return NULL;
+		}
+		p->irqs[i] = irq;
+	}
+
+	prop = of_get_property(np, "cell-index", NULL);
+	if (!prop) {
+		dev_err(&pdev->dev, "required DT prop cell-index missing\n");
+		return NULL;
+	}
+	*dev_id = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "renesas,scscr", NULL);
+	if (!prop) {
+		dev_err(&pdev->dev, "required DT prop scscr missing\n");
+		return NULL;
+	}
+	p->scscr = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "renesas,scbrr-algo-id", NULL);
+	if (!prop) {
+		dev_err(&pdev->dev, "required DT prop scbrr-algo-id missing\n");
+		return NULL;
+	}
+	p->scbrr_algo_id = be32_to_cpup(prop) - 1;
+
+	p->flags = UPF_IOREMAP;
+	if (of_get_property(np, "renesas,autoconf", NULL))
+		p->flags |= UPF_BOOT_AUTOCONF;
+
+	prop = of_get_property(np, "renesas,regtype", NULL);
+	if (prop) {
+		val = be32_to_cpup(prop);
+		if (val <= 0 || val >= ARRAY_SIZE(sci_regtype_modes)) {
+			dev_err(&pdev->dev, "invalid DT prop regtype\n");
+			return NULL;
+		}
+		p->regtype = sci_regtype_modes[be32_to_cpup(prop)];
+	}
+
+	p->type = (unsigned int)match->data;
+
+	return p;
+}
+#else
+static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
+								int *dev_id)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
@@ -2385,9 +2496,9 @@ static int sci_probe_single(struct platform_device *dev,
 
 static int sci_probe(struct platform_device *dev)
 {
-	struct plat_sci_port *p = dev->dev.platform_data;
-	struct sci_port *sp = &sci_ports[dev->id];
-	int ret;
+	struct plat_sci_port *p;
+	struct sci_port *sp;
+	int ret, dev_id = dev->id;
 
 	/*
 	 * If we've come here via earlyprintk initialization, head off to
@@ -2397,9 +2508,20 @@ static int sci_probe(struct platform_device *dev)
 	if (is_early_platform_device(dev))
 		return sci_probe_earlyprintk(dev);
 
+	if (dev->dev.of_node)
+		p = sci_parse_dt(dev, &dev_id);
+	else
+		p = dev->dev.platform_data;
+
+	if (!p) {
+		dev_err(&dev->dev, "no setup data supplied\n");
+		return -EINVAL;
+	}
+
+	sp = &sci_ports[dev_id];
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev->id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp);
 	if (ret)
 		return ret;
 
@@ -2451,6 +2573,7 @@ static struct platform_driver sci_driver = {
 		.name	= "sh-sci",
 		.owner	= THIS_MODULE,
 		.pm	= &sci_dev_pm_ops,
+		.of_match_table = of_match_ptr(of_sci_match),
 	},
 };
 
-- 
1.7.9.5

