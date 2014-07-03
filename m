From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 1/9] clk: sunxi: Add A23 APB0 divider clock support
Date: Thu,  3 Jul 2014 22:55:41 +0800
Message-ID: <1404399349-20237-2-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCMILY6JWQBBBA662WOQKGQEYELLW6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1404399349-20237-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org

The A23 has an almost identical PRCM clock tree. The difference in
the APB0 clock is the smallest divisor is 1, instead of 2.

This patch adds a separate sun8i-a23-apb0-clk driver to support it.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/Makefile                        |  4 +-
 drivers/clk/sunxi/clk-sun8i-apb0.c                | 68 +++++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sunxi/clk-sun8i-apb0.c

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 18030ce..68dbd3d 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -28,6 +28,7 @@ Required properties:
 	"allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
 	"allwinner,sun4i-a10-apb0-clk" - for the APB0 clock
 	"allwinner,sun6i-a31-apb0-clk" - for the APB0 clock on A31
+	"allwinner,sun8i-a23-apb0-clk" - for the APB0 clock on A23
 	"allwinner,sun4i-a10-apb0-gates-clk" - for the APB0 gates on A10
 	"allwinner,sun5i-a13-apb0-gates-clk" - for the APB0 gates on A13
 	"allwinner,sun5i-a10s-apb0-gates-clk" - for the APB0 gates on A10s
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 762fd64..6850cba 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -6,4 +6,6 @@ obj-y += clk-sunxi.o clk-factors.o
 obj-y += clk-a10-hosc.o
 obj-y += clk-a20-gmac.o
 
-obj-$(CONFIG_MFD_SUN6I_PRCM) += clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o
+obj-$(CONFIG_MFD_SUN6I_PRCM) += \
+	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
+	clk-sun8i-apb0.o
diff --git a/drivers/clk/sunxi/clk-sun8i-apb0.c b/drivers/clk/sunxi/clk-sun8i-apb0.c
new file mode 100644
index 0000000..196a499
--- /dev/null
+++ b/drivers/clk/sunxi/clk-sun8i-apb0.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2014 Chen-Yu Tsai
+ * Author: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
+ *
+ * Allwinner A23 APB0 clock driver
+ *
+ * License Terms: GNU General Public License v2
+ *
+ * Based on clk-sun6i-apb0.c
+ * Allwinner A31 APB0 clock driver
+ *
+ * Copyright (C) 2014 Free Electrons
+ * Author: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+static int sun8i_a23_apb0_clk_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const char *clk_name = np->name;
+	const char *clk_parent;
+	struct resource *r;
+	void __iomem *reg;
+	struct clk *clk;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	clk_parent = of_clk_get_parent_name(np, 0);
+	if (!clk_parent)
+		return -EINVAL;
+
+	of_property_read_string(np, "clock-output-names", &clk_name);
+
+	/* The A23 APB0 clock is a standard 2 bit wide divider clock */
+	clk = clk_register_divider(&pdev->dev, clk_name, clk_parent, 0, reg,
+				   0, 2, CLK_DIVIDER_POWER_OF_TWO, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	return of_clk_add_provider(np, of_clk_src_simple_get, clk);
+}
+
+const struct of_device_id sun8i_a23_apb0_clk_dt_ids[] = {
+	{ .compatible = "allwinner,sun8i-a23-apb0-clk" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver sun8i_a23_apb0_clk_driver = {
+	.driver = {
+		.name = "sun8i-a23-apb0-clk",
+		.owner = THIS_MODULE,
+		.of_match_table = sun8i_a23_apb0_clk_dt_ids,
+	},
+	.probe = sun8i_a23_apb0_clk_probe,
+};
+module_platform_driver(sun8i_a23_apb0_clk_driver);
+
+MODULE_AUTHOR("Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>");
+MODULE_DESCRIPTION("Allwinner A23 APB0 clock Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.0.1
