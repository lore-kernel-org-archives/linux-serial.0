From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH v4 1/3] serial: sh-sci: Add OF support
Date: Mon,  4 Mar 2013 17:20:52 +0100
Message-ID: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:60014 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757041Ab3CDPX1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Mar 2013 10:23:27 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

We add the capabilty to probe Renesas SCI devices using Device Tree setup.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v4:
Added missing OF header

 .../bindings/tty/serial/renesas,sci-serial.txt     |   53 ++++++++
 drivers/tty/serial/sh-sci.c                        |  127 +++++++++++++++++++-
 include/linux/serial_sci.h                         |    4 +
 3 files changed, 180 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
new file mode 100644
index 0000000..6ad1adf
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/renesas,sci-serial.txt
@@ -0,0 +1,53 @@
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
+- renesas,regtype : Overwrite the register layout. In most cases you can rely
+  on auto-probing (omit this property or set to 0) but some legacy devices
+  use a non-default register layout. Possible layouts are
+  0 = SCIx_PROBE_REGTYPE (default)
+  1 = SCIx_SCI_REGTYPE
+  2 = SCIx_IRDA_REGTYPE
+  3 = SCIx_SCIFA_REGTYPE
+  4 = SCIx_SCIFB_REGTYPE
+  5 = SCIx_SH2_SCIF_FIFODATA_REGTYPE
+  6 = SCIx_SH3_SCIF_REGTYPE
+  7 = SCIx_SH4_SCIF_REGTYPE
+  8 = SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE
+  9 = SCIx_SH4_SCIF_FIFODATA_REGTYPE
+ 10 = SCIx_SH7705_SCIF_REGTYPE
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
index 6147756..cc1b69c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -52,6 +52,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
 
 #ifdef CONFIG_SUPERH
 #include <asm/sh_bios.h>
@@ -2353,6 +2354,112 @@ static int sci_remove(struct platform_device *dev)
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
+	val = be32_to_cpup(prop);
+	if (val <= SCBRR_ALGO_INVALID || val >= SCBRR_NR_ALGOS) {
+		dev_err(&pdev->dev, "DT prop scbrr-algo-id out of range\n");
+		return NULL;
+	}
+	p->scbrr_algo_id = val;
+
+	p->flags = UPF_IOREMAP;
+	if (of_get_property(np, "renesas,autoconf", NULL))
+		p->flags |= UPF_BOOT_AUTOCONF;
+
+	prop = of_get_property(np, "renesas,regtype", NULL);
+	if (prop) {
+		val = be32_to_cpup(prop);
+		if (val < SCIx_PROBE_REGTYPE || val >= SCIx_NR_REGTYPES) {
+			dev_err(&pdev->dev, "DT prop regtype out of range\n");
+			return NULL;
+		}
+		p->regtype = val;
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
@@ -2385,9 +2492,9 @@ static int sci_probe_single(struct platform_device *dev,
 
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
@@ -2397,9 +2504,20 @@ static int sci_probe(struct platform_device *dev)
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
 
@@ -2451,6 +2569,7 @@ static struct platform_driver sci_driver = {
 		.name	= "sh-sci",
 		.owner	= THIS_MODULE,
 		.pm	= &sci_dev_pm_ops,
+		.of_match_table = of_match_ptr(of_sci_match),
 	},
 };
 
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index eb763ad..857eec4 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -11,11 +11,15 @@
 #define SCIx_NOT_SUPPORTED	(-1)
 
 enum {
+	SCBRR_ALGO_INVALID,
+
 	SCBRR_ALGO_1,		/* ((clk + 16 * bps) / (16 * bps) - 1) */
 	SCBRR_ALGO_2,		/* ((clk + 16 * bps) / (32 * bps) - 1) */
 	SCBRR_ALGO_3,		/* (((clk * 2) + 16 * bps) / (16 * bps) - 1) */
 	SCBRR_ALGO_4,		/* (((clk * 2) + 16 * bps) / (32 * bps) - 1) */
 	SCBRR_ALGO_5,		/* (((clk * 1000 / 32) / bps) - 1) */
+
+	SCBRR_NR_ALGOS,
 };
 
 #define SCSCR_TIE	(1 << 7)
-- 
1.7.9.5

