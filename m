From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 47/47] serial: sh-sci: Add OF support
Date: Fri,  6 Dec 2013 10:59:54 +0100
Message-ID: <1386323994-12850-48-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:33748 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757909Ab3LFKAw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Dec 2013 05:00:52 -0500
In-Reply-To: <1386323994-12850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>

From: Bastian Hecht <hechtb@gmail.com>

Extend the driver to with support for SCIx device tree bindings. A
minimal set of features is supported, additional properties can be added
later should the need to describe more device features arise.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 101 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4258bb8..6653c11 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -39,6 +39,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
@@ -2414,6 +2415,83 @@ static int sci_remove(struct platform_device *dev)
 	return 0;
 }
 
+struct sci_port_info {
+	unsigned int type;
+	unsigned int regtype;
+};
+
+static const struct of_device_id of_sci_match[] = {
+	{
+		.compatible = "renesas,scif",
+		.data = (void *)&(const struct sci_port_info) {
+			.type = PORT_SCIF,
+			.regtype = SCIx_SH4_SCIF_REGTYPE,
+		},
+	}, {
+		.compatible = "renesas,scifa",
+		.data = (void *)&(const struct sci_port_info) {
+			.type = PORT_SCIFA,
+			.regtype = SCIx_SCIFA_REGTYPE,
+		},
+	}, {
+		.compatible = "renesas,scifb",
+		.data = (void *)&(const struct sci_port_info) {
+			.type = PORT_SCIFB,
+			.regtype = SCIx_SCIFB_REGTYPE,
+		},
+	}, {
+		.compatible = "renesas,hscif",
+		.data = (void *)&(const struct sci_port_info) {
+			.type = PORT_HSCIF,
+			.regtype = SCIx_HSCIF_REGTYPE,
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
+
+	return p;
+}
+
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
@@ -2446,8 +2524,9 @@ static int sci_probe_single(struct platform_device *dev,
 
 static int sci_probe(struct platform_device *dev)
 {
-	struct plat_sci_port *p = dev_get_platdata(&dev->dev);
-	struct sci_port *sp = &sci_ports[dev->id];
+	struct plat_sci_port *p;
+	struct sci_port *sp;
+	unsigned int dev_id;
 	int ret;
 
 	/*
@@ -2458,9 +2537,24 @@ static int sci_probe(struct platform_device *dev)
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
 
@@ -2512,6 +2606,7 @@ static struct platform_driver sci_driver = {
 		.name	= "sh-sci",
 		.owner	= THIS_MODULE,
 		.pm	= &sci_dev_pm_ops,
+		.of_match_table = of_match_ptr(of_sci_match),
 	},
 };
 
-- 
1.8.3.2

