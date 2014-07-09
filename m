From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v4 1/6] clk: sunxi: sun6i-apb0-gates: use
 bitmaps for valid gate indicies
Date: Wed,  9 Jul 2014 15:54:34 +0800
Message-ID: <1404892479-12222-2-git-send-email-wens@csie.org>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCMILY6JWQBBBRHK6OOQKGQE7AQYSWA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1404892479-12222-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-serial@vger.kernel.org

sun6i-apb0-gates uses the "clock-indices" DT property to indicate
valid gate bits or holes in between. However, the rest of sunxi
clock drivers use bitmaps for this purpose.

This patch modifies sun6i-apb0-gates to use bitmaps as well, to be
consistent with the sunxi platform. Also add the missing call to
clk_register_clkdev, so system clock lookups will work.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c | 75 +++++++++++++++++---------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index b342f2a..3bd8357 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -9,24 +9,48 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/clkdev.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #define SUN6I_APB0_GATES_MAX_SIZE	32
 
+struct gates_data {
+	DECLARE_BITMAP(mask, SUN6I_APB0_GATES_MAX_SIZE);
+};
+
+static const struct gates_data sun6i_a31_apb0_gates __initconst = {
+	.mask = {0x7F},
+};
+
+const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
+	{ .compatible = "allwinner,sun6i-a31-apb0-gates-clk", .data = &sun6i_a31_apb0_gates },
+	{ /* sentinel */ }
+};
+
 static int sun6i_a31_apb0_gates_clk_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct clk_onecell_data *clk_data;
+	const struct of_device_id *device;
+	const struct gates_data *data;
 	const char *clk_parent;
 	const char *clk_name;
 	struct resource *r;
 	void __iomem *reg;
-	int gate_id;
 	int ngates;
-	int gate_max = 0;
 	int i;
+	int j = 0;
+
+	if (!np)
+		return -ENODEV;
+
+	device = of_match_device(sun6i_a31_apb0_gates_clk_dt_ids, &pdev->dev);
+	if (!device)
+		return -ENODEV;
+	data = device->data;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(&pdev->dev, r);
@@ -37,57 +61,36 @@ static int sun6i_a31_apb0_gates_clk_probe(struct platform_device *pdev)
 	if (!clk_parent)
 		return -EINVAL;
 
-	ngates = of_property_count_strings(np, "clock-output-names");
-	if (ngates < 0)
-		return ngates;
-
-	if (!ngates || ngates > SUN6I_APB0_GATES_MAX_SIZE)
-		return -EINVAL;
-
 	clk_data = devm_kzalloc(&pdev->dev, sizeof(struct clk_onecell_data),
 				GFP_KERNEL);
 	if (!clk_data)
 		return -ENOMEM;
 
-	clk_data->clks = devm_kzalloc(&pdev->dev,
-				      SUN6I_APB0_GATES_MAX_SIZE *
-				      sizeof(struct clk *),
-				      GFP_KERNEL);
+	/* Worst-case size approximation and memory allocation */
+	ngates = find_last_bit(data->mask, SUN6I_APB0_GATES_MAX_SIZE);
+	clk_data->clks = devm_kcalloc(&pdev->dev, (ngates + 1),
+				      sizeof(struct clk *), GFP_KERNEL);
 	if (!clk_data->clks)
 		return -ENOMEM;
 
-	for (i = 0; i < ngates; i++) {
+	for_each_set_bit(i, data->mask, SUN6I_APB0_GATES_MAX_SIZE) {
 		of_property_read_string_index(np, "clock-output-names",
-					      i, &clk_name);
-
-		gate_id = i;
-		of_property_read_u32_index(np, "clock-indices", i, &gate_id);
-
-		WARN_ON(gate_id >= SUN6I_APB0_GATES_MAX_SIZE);
-		if (gate_id >= SUN6I_APB0_GATES_MAX_SIZE)
-			continue;
+					      j, &clk_name);
 
-		clk_data->clks[gate_id] = clk_register_gate(&pdev->dev,
-							    clk_name,
-							    clk_parent, 0,
-							    reg, gate_id,
-							    0, NULL);
-		WARN_ON(IS_ERR(clk_data->clks[gate_id]));
+		clk_data->clks[i] = clk_register_gate(&pdev->dev, clk_name,
+						      clk_parent, 0, reg, i,
+						      0, NULL);
+		WARN_ON(IS_ERR(clk_data->clks[i]));
+		clk_register_clkdev(clk_data->clks[i], clk_name, NULL);
 
-		if (gate_id > gate_max)
-			gate_max = gate_id;
+		j++;
 	}
 
-	clk_data->clk_num = gate_max + 1;
+	clk_data->clk_num = ngates + 1;
 
 	return of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
 }
 
-const struct of_device_id sun6i_a31_apb0_gates_clk_dt_ids[] = {
-	{ .compatible = "allwinner,sun6i-a31-apb0-gates-clk" },
-	{ /* sentinel */ }
-};
-
 static struct platform_driver sun6i_a31_apb0_gates_clk_driver = {
 	.driver = {
 		.name = "sun6i-a31-apb0-gates-clk",
-- 
2.0.1
