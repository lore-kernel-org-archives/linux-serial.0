From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v2 15/20] pinctrl: sunxi: Add A23 R_PIO
 controller support
Date: Tue, 17 Jun 2014 22:52:52 +0800
Message-ID: <1403016777-15121-16-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCMILY6JWQBBBY5MQGOQKGQEURBXQFQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

The A23 has a R_PIO pin controller, similar to the one found on the A31 SoC.
Add support for the pins controlled by the R_PIO controller.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 drivers/pinctrl/sunxi/Kconfig                      |   5 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c        | 142 +++++++++++++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 44a78c1..93ce12e 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -14,6 +14,7 @@ Required properties:
   "allwinner,sun6i-a31-r-pinctrl"
   "allwinner,sun7i-a20-pinctrl"
   "allwinner,sun8i-a23-pinctrl"
+  "allwinner,sun8i-a23-r-pinctrl"
 - reg: Should contain the register physical address and length for the
   pin controller.
 
diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 7c72ed8..da49524 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -37,4 +37,9 @@ config PINCTRL_SUN8I_A23
 	def_bool MACH_SUN8I
 	select PINCTRL_SUNXI_COMMON
 
+config PINCTRL_SUN8I_A23_R
+	def_bool MACH_SUN8I
+	depends on RESET_CONTROLLER
+	select PINCTRL_SUNXI_COMMON
+
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index 850cd50..e797efb 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_PINCTRL_SUN6I_A31)		+= pinctrl-sun6i-a31.o
 obj-$(CONFIG_PINCTRL_SUN6I_A31_R)	+= pinctrl-sun6i-a31-r.o
 obj-$(CONFIG_PINCTRL_SUN7I_A20)		+= pinctrl-sun7i-a20.o
 obj-$(CONFIG_PINCTRL_SUN8I_A23)		+= pinctrl-sun8i-a23.o
+obj-$(CONFIG_PINCTRL_SUN8I_A23_R)	+= pinctrl-sun8i-a23-r.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
new file mode 100644
index 0000000..90f3b3a
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
@@ -0,0 +1,142 @@
+/*
+ * Allwinner A23 SoCs special pins pinctrl driver.
+ *
+ * Copyright (C) 2014 Chen-Yu Tsai
+ * Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
+ *
+ * Copyright (C) 2014 Boris Brezillon
+ * Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
+ *
+ * Copyright (C) 2014 Maxime Ripard
+ * Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/reset.h>
+
+#include "pinctrl-sunxi.h"
+
+static const struct sunxi_desc_pin sun8i_a23_r_pins[] = {
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_rsb"),		/* SCK */
+		  SUNXI_FUNCTION(0x3, "s_twi"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 0)),	/* PL_EINT0 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 1),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_rsb"),		/* SDA */
+		  SUNXI_FUNCTION(0x3, "s_twi"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 1)),	/* PL_EINT1 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 2),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* TX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 2)),	/* PL_EINT2 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 3),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_uart"),	/* RX */
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 3)),	/* PL_EINT3 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 4),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* MS */
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 4)),	/* PL_EINT4 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 5),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* CK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 5)),	/* PL_EINT5 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 6),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* DO */
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 6)),	/* PL_EINT6 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 7),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x3, "s_jtag"),	/* DI */
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 7)),	/* PL_EINT7 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 8),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_twi"),		/* SCK */
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 8)),	/* PL_EINT8 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 9),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_twi"),		/* SDA */
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 9)),	/* PL_EINT9 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 10),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION(0x2, "s_pwm"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 10)),	/* PL_EINT10 */
+	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 11),
+		  SUNXI_FUNCTION(0x0, "gpio_in"),
+		  SUNXI_FUNCTION(0x1, "gpio_out"),
+		  SUNXI_FUNCTION_IRQ_BANK(0x4, 0, 11)),	/* PL_EINT11 */
+};
+
+static const struct sunxi_pinctrl_desc sun8i_a23_r_pinctrl_data = {
+	.pins = sun8i_a23_r_pins,
+	.npins = ARRAY_SIZE(sun8i_a23_r_pins),
+	.pin_base = PL_BASE,
+	.irq_banks = 1,
+};
+
+static int sun8i_a23_r_pinctrl_probe(struct platform_device *pdev)
+{
+	struct reset_control *rstc;
+	int ret;
+
+	rstc = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(rstc)) {
+		dev_err(&pdev->dev, "Reset controller missing\n");
+		return PTR_ERR(rstc);
+	}
+
+	ret = reset_control_deassert(rstc);
+	if (ret)
+		return ret;
+
+	ret = sunxi_pinctrl_init(pdev,
+				 &sun8i_a23_r_pinctrl_data);
+
+	if (ret)
+		reset_control_assert(rstc);
+
+	return ret;
+}
+
+static struct of_device_id sun8i_a23_r_pinctrl_match[] = {
+	{ .compatible = "allwinner,sun8i-a23-r-pinctrl", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sun8i_a23_r_pinctrl_match);
+
+static struct platform_driver sun8i_a23_r_pinctrl_driver = {
+	.probe	= sun8i_a23_r_pinctrl_probe,
+	.driver	= {
+		.name		= "sun8i-a23-r-pinctrl",
+		.owner		= THIS_MODULE,
+		.of_match_table	= sun8i_a23_r_pinctrl_match,
+	},
+};
+module_platform_driver(sun8i_a23_r_pinctrl_driver);
+
+MODULE_AUTHOR("Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>");
+MODULE_AUTHOR("Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org");
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org");
+MODULE_DESCRIPTION("Allwinner A23 R_PIO pinctrl driver");
+MODULE_LICENSE("GPL");
-- 
2.0.0
