From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Use of_device_get_match_data() helper
Date: Wed,  4 Oct 2017 14:21:56 +0200
Message-ID: <1507119716-12958-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Use the of_device_get_match_data() helper instead of open coding.
Note that when used with DT, there's always a valid match.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 784dd42002eadbeb..95b12eefcb7ae906 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
@@ -3044,17 +3045,15 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 					  unsigned int *dev_id)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct plat_sci_port *p;
 	struct sci_port *sp;
+	const void *data;
 	int id;
 
 	if (!IS_ENABLED(CONFIG_OF) || !np)
 		return NULL;
 
-	match = of_match_node(of_sci_match, np);
-	if (!match)
-		return NULL;
+	data = of_device_get_match_data(&pdev->dev);
 
 	p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
 	if (!p)
@@ -3070,8 +3069,8 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	sp = &sci_ports[id];
 	*dev_id = id;
 
-	p->type = SCI_OF_TYPE(match->data);
-	p->regtype = SCI_OF_REGTYPE(match->data);
+	p->type = SCI_OF_TYPE(data);
+	p->regtype = SCI_OF_REGTYPE(data);
 
 	sp->has_rtscts = of_property_read_bool(np, "uart-has-rtscts");
 
-- 
2.7.4
