From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v2 16/20] mfd: sun6i-prcm: Add support for
 Allwinner A23 PRCM
Date: Tue, 17 Jun 2014 22:52:53 +0800
Message-ID: <1403016777-15121-17-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCMILY6JWQBBBZNMQGOQKGQEZB4RRNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1403016777-15121-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Luc Verhaegen <libv-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
The differences are the AR100 clock can no longer be modified,
the APB0 clock has different divisors, and some clock gates are
gone.

This patch adds a compatible with a modified subdevice list for
the A23.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
 drivers/mfd/sun6i-prcm.c                           | 30 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
index 1f5a31f..03c5a55 100644
--- a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
+++ b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
@@ -4,7 +4,7 @@ PRCM is an MFD device exposing several Power Management related devices
 (like clks and reset controllers).
 
 Required properties:
- - compatible: "allwinner,sun6i-a31-prcm"
+ - compatible: "allwinner,sun6i-a31-prcm" or "allwinner,sun8i-a23-prcm"
  - reg: The PRCM registers range
 
 The prcm node may contain several subdevices definitions:
diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
index 718fc4d..7a198d3 100644
--- a/drivers/mfd/sun6i-prcm.c
+++ b/drivers/mfd/sun6i-prcm.c
@@ -76,16 +76,46 @@ static const struct mfd_cell sun6i_a31_prcm_subdevs[] = {
 	},
 };
 
+static const struct mfd_cell sun8i_a23_prcm_subdevs[] = {
+	{
+		.name = "sun6i-a31-apb0-clk",
+		.of_compatible = "allwinner,sun8i-a23-apb0-clk",
+		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_clk_res),
+		.resources = sun6i_a31_apb0_clk_res,
+	},
+	{
+		.name = "sun6i-a31-apb0-gates-clk",
+		.of_compatible = "allwinner,sun8i-a23-apb0-gates-clk",
+		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_gates_clk_res),
+		.resources = sun6i_a31_apb0_gates_clk_res,
+	},
+	{
+		.name = "sun6i-a31-apb0-clock-reset",
+		.of_compatible = "allwinner,sun6i-a31-clock-reset",
+		.num_resources = ARRAY_SIZE(sun6i_a31_apb0_rstc_res),
+		.resources = sun6i_a31_apb0_rstc_res,
+	},
+};
+
 static const struct prcm_data sun6i_a31_prcm_data = {
 	.nsubdevs = ARRAY_SIZE(sun6i_a31_prcm_subdevs),
 	.subdevs = sun6i_a31_prcm_subdevs,
 };
 
+static const struct prcm_data sun8i_a23_prcm_data = {
+	.nsubdevs = ARRAY_SIZE(sun8i_a23_prcm_subdevs),
+	.subdevs = sun8i_a23_prcm_subdevs,
+};
+
 static const struct of_device_id sun6i_prcm_dt_ids[] = {
 	{
 		.compatible = "allwinner,sun6i-a31-prcm",
 		.data = &sun6i_a31_prcm_data,
 	},
+	{
+		.compatible = "allwinner,sun8i-a23-prcm",
+		.data = &sun8i_a23_prcm_data,
+	},
 	{ /* sentinel */ },
 };
 
-- 
2.0.0
