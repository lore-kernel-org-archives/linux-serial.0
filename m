From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v2 09/20] clk: sunxi: Add sun6i MBUS clock support
Date: Tue, 17 Jun 2014 22:52:46 +0800
Message-ID: <1403016777-15121-10-git-send-email-wens@csie.org>
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

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/clk-sunxi.c                     | 44 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index b9ec668..7b2ba41 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -40,6 +40,7 @@ Required properties:
 	"allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
+	"allwinner,sun6i-a31-mbus-clk" - for the MBUS clocks on A31 / A23
 	"allwinner,sun7i-a20-out-clk" - for the external output clocks
 	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
 	"allwinner,sun4i-a10-usb-clk" - for usb gates + resets on A10 / A20
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index eca3c6e..a086b5b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -307,6 +307,37 @@ static void sun4i_get_mod0_factors(u32 *freq, u32 parent_rate,
 
 
 /**
+ * sun6i_a31_get_mbus_factors() - calculates m factor for MBUS clocks
+ * MBUS rate is calculated as follows
+ * rate = parent_rate / (m + 1);
+ */
+
+static void sun6i_a31_get_mbus_factors(u32 *freq, u32 parent_rate,
+				       u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 div;
+
+	/* These clocks can only divide, so we will never be able to achieve
+	 * frequencies higher than the parent frequency */
+	if (*freq > parent_rate)
+		*freq = parent_rate;
+
+	div = DIV_ROUND_UP(parent_rate, *freq);
+
+	if (div > 8)
+		div = 8;
+
+	*freq = parent_rate / div;
+
+	/* we were called to round the frequency, we can now return */
+	if (n == NULL)
+		return;
+
+	*m = div - 1;
+}
+
+
+/**
  * sun7i_a20_get_out_factors() - calculates m, p factors for CLK_OUT_A/B
  * CLK_OUT rate is calculated as follows
  * rate = (parent_rate >> p) / (m + 1);
@@ -447,6 +478,11 @@ static struct clk_factors_config sun4i_mod0_config = {
 	.pwidth = 2,
 };
 
+static struct clk_factors_config sun6i_a31_mbus_config = {
+	.mshift = 0,
+	.mwidth = 3,
+};
+
 /* user manual says "n" but it's really "p" */
 static struct clk_factors_config sun7i_a20_out_config = {
 	.mshift = 8,
@@ -505,6 +541,13 @@ static const struct factors_data sun4i_mod0_data __initconst = {
 	.getter = sun4i_get_mod0_factors,
 };
 
+static const struct factors_data sun6i_a31_mbus_data __initconst = {
+	.enable = 31,
+	.mux = 24,
+	.table = &sun6i_a31_mbus_config,
+	.getter = sun6i_a31_get_mbus_factors,
+};
+
 static const struct factors_data sun7i_a20_out_data __initconst = {
 	.enable = 31,
 	.mux = 24,
@@ -1099,6 +1142,7 @@ static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
 	{.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
 	{.compatible = "allwinner,sun4i-a10-mod0-clk", .data = &sun4i_mod0_data,},
+	{.compatible = "allwinner,sun6i-a31-mbus-clk", .data = &sun6i_a31_mbus_data,},
 	{.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
 	{}
 };
-- 
2.0.0
