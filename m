From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 29/29] serial: sh-sci: Add OF support
Date: Sun, 10 Nov 2013 04:33:41 +0100
Message-ID: <1384054421-13357-30-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1384054421-13357-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-serial@vger.kernel.org

From: Bastian Hecht <hechtb@gmail.com>

Extend the driver to with support for SCIx device tree bindings. A
minimal set of features is supported, additional properties can be added
later should the need to describe more device features arise.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 107 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6bb1e8f..ca1c453 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
@@ -2472,6 +2473,89 @@ static int sci_remove(struct platform_device *dev)
 	return 0;
 }
 
+struct sci_port_info {
+	unsigned int type;
+	unsigned int regtype;
+	unsigned int brr_algo;
+};
+
+static const struct of_device_id of_sci_match[] = {
+	{
+		.compatible = "renesas,scif-generic",
+		.data = (void *)&(const struct sci_port_info) {
+			.type = PORT_SCIF,
+			.regtype = SCIx_SH4_SCIF_REGTYPE,
+			.brr_algo = SCBRR_ALGO_2,
+		},
+	}, {
+		.compatible = "renesas,scifa-generic",
+		.data = (void *)&(const struct sci_port_info) {
+			.type = PORT_SCIFA,
+			.regtype = SCIx_SCIFA_REGTYPE,
+			.brr_algo = SCBRR_ALGO_4,
+		},
+	}, {
+		.compatible = "renesas,scifb-generic",
+		.data = (void *)&(const struct sci_port_info) {
+			.type = PORT_SCIFB,
+			.regtype = SCIx_SCIFB_REGTYPE,
+			.brr_algo = SCBRR_ALGO_4,
+		},
+	}, {
+		.compatible = "renesas,hscif-generic",
+		.data = (void *)&(const struct sci_port_info) {
+			.type = PORT_HSCIF,
+			.regtype = SCIx_HSCIF_REGTYPE,
+			.brr_algo = SCBRR_ALGO_6,
+		},
+	}, {
+		/* Terminator */
+	},
+};
+MODULE_DEVICE_TABLE(of, of_sci_match);
+
+static struct plat_sci_port *
+sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match;
+	const struct sci_port_info *info;
+	struct plat_sci_port *p;
+	int id;
+
+	if (!IS_ENABLED(CONFIG_OF) || !np)
+		return NULL;
+
+	match = of_match_node(of_sci_match, pdev->dev.of_node);
+	if (!match)
+		return NULL;
+
+	info = match->data;
+
+	p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
+	if (!p) {
+		dev_err(&pdev->dev, "failed to allocate DT config data\n");
+		return NULL;
+	}
+
+	/* Get the line number for the aliases node. */
+	id = of_alias_get_id(np, "serial");
+	if (id < 0) {
+		dev_err(&pdev->dev, "failed to get alias id (%d)\n", id);
+		return NULL;
+	}
+
+	*dev_id = id;
+
+	p->flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
+	p->type = info->type;
+	p->regtype = info->regtype;
+	p->scscr = SCSCR_RE | SCSCR_TE;
+	p->scbrr_algo_id = info->brr_algo;
+
+	return p;
+}
+
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
@@ -2504,8 +2588,9 @@ static int sci_probe_single(struct platform_device *dev,
 
 static int sci_probe(struct platform_device *dev)
 {
-	struct plat_sci_port *p = dev_get_platdata(&dev->dev);
-	struct sci_port *sp = &sci_ports[dev->id];
+	struct plat_sci_port *p;
+	struct sci_port *sp;
+	unsigned int dev_id;
 	int ret;
 
 	/*
@@ -2516,9 +2601,24 @@ static int sci_probe(struct platform_device *dev)
 	if (is_early_platform_device(dev))
 		return sci_probe_earlyprintk(dev);
 
+	if (dev->dev.of_node) {
+		p = sci_parse_dt(dev, &dev_id);
+		if (p == NULL)
+			return -EINVAL;
+	} else {
+		p = dev->dev.platform_data;
+		if (p == NULL) {
+			dev_err(&dev->dev, "no platform data supplied\n");
+			return -EINVAL;
+		}
+
+		dev_id = dev->id;
+	}
+
+	sp = &sci_ports[dev_id];
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev->id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp);
 	if (ret)
 		return ret;
 
@@ -2570,6 +2670,7 @@ static struct platform_driver sci_driver = {
 		.name	= "sh-sci",
 		.owner	= THIS_MODULE,
 		.pm	= &sci_dev_pm_ops,
+		.of_match_table = of_match_ptr(of_sci_match),
 	},
 };
 
-- 
1.8.1.5

