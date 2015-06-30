From: Paul Osmialowski <pawelo@king.net.pl>
Subject: [PATCH v2 5/9] arm: twr-k70f120m: IOMUX driver for Kinetis SoC
Date: Tue, 30 Jun 2015 14:27:26 +0200
Message-ID: <1435667250-28299-6-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Sergei Poselenov <sposelenov@emcraft.com>, Paul Bolle <pebolle@tiscali.nl>, Paul Osmialowski <pawelo@king.net.pl>, Arnd Bergmann <arnd@arndb.de>, Jingchang Lu <jingchang.lu@freescale.com>, Yuri Tikhonov <yur@emcraft.com>, Rob Herring <r.herring@freescale.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Alexander Potashev <aspotashev@emcraft.com>, Frank Li <Frank.Li@freescale.com>, Thomas Gleixner <tglx@linutronix.de>, Anson Huang <b20788@freescale.com>
List-Id: linux-serial@vger.kernel.org

This is a very cheap and simple implementation of pinctrl driver
for Kinetis SoC - its primary role is to provide means for enabling UART
fuctionality on I/O PORT_E which will be utilized by the commits
yet to come.

Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
---
 .../bindings/pinctrl/fsl,kinetis-pinctrl.txt       |  31 ++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/boot/dts/kinetis.dtsi                     |  48 ++
 drivers/pinctrl/freescale/Kconfig                  |   8 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-kinetis.c        | 541 +++++++++++++++++++++
 6 files changed, 631 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,kinetis-pinctrl.txt
 create mode 100644 drivers/pinctrl/freescale/pinctrl-kinetis.c

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,kinetis-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,kinetis-pinctrl.txt
new file mode 100644
index 0000000..a351ce4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,kinetis-pinctrl.txt
@@ -0,0 +1,31 @@
+Freescale Kinetis IOMUX Controller
+
+This controller is largely based on i.MX IOMUX Controller. Please refer to
+fsl,imx-pinctrl.txt in this directory for more detailed description.
+
+Required properties:
+- compatible: Should be "fsl,kinetis-iomuxc".
+- reg: Should contain the physical address and length of the gpio/pinmux
+  register range.
+- clocks: Clock that drives this I/O port.
+- fsl,pins: Two integers array, represents a group of pins mux and config
+  setting. The format is fsl,pins = <PIN_FUNC_ID CONFIG>, PIN_FUNC_ID is
+  a pin working on a specific function, CONFIG is the pad setting value
+  such as pull enable, pull select, drive strength enable. Please refer to
+  Kinetis datasheet for the valid pad config settings.
+
+Example:
+
+portE: pinmux@4004d000 {
+	compatible = "fsl,kinetis-padconf";
+	reg = <0x4004d000 0x1000>;
+	clocks = <&mcg_pclk_gate 4 13>;
+	uart2 {
+		uart2_pins: pinmux_uart2_pins {
+			fsl,pins = <
+				16	0x300 /* E.16 = UART2_TX */
+				17	0x300 /* E.17 = UART2_RX */
+			>;
+		};
+	};
+};
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 96ddaae..b21592b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -969,6 +969,8 @@ config ARCH_KINETIS
 	depends on ARM_SINGLE_ARMV7M
 	select ARMV7M_SYSTICK
 	select CLKSRC_KINETIS
+	select PINCTRL
+	select PINCTRL_KINETIS
 	help
 	  This enables support for the Freescale Kinetis MCUs
 
diff --git a/arch/arm/boot/dts/kinetis.dtsi b/arch/arm/boot/dts/kinetis.dtsi
index 0c572a5..5ff1d3b 100644
--- a/arch/arm/boot/dts/kinetis.dtsi
+++ b/arch/arm/boot/dts/kinetis.dtsi
@@ -10,9 +10,57 @@
 		pit1 = &pit1;
 		pit2 = &pit2;
 		pit3 = &pit3;
+		pmx0 = &portA;
+		pmx1 = &portB;
+		pmx2 = &portC;
+		pmx3 = &portD;
+		pmx4 = &portE;
+		pmx5 = &portF;
 	};
 
 	soc {
+		portA: pinmux@40049000 {
+			compatible = "fsl,kinetis-padconf";
+			reg = <0x40049000 0x1000>;
+			clocks = <&mcg_pclk_gate 4 9>;
+			status = "disabled";
+		};
+
+		portB: pinmux@4004a000 {
+			compatible = "fsl,kinetis-padconf";
+			reg = <0x4004a000 0x1000>;
+			clocks = <&mcg_pclk_gate 4 10>;
+			status = "disabled";
+		};
+
+		portC: pinmux@4004b000 {
+			compatible = "fsl,kinetis-padconf";
+			reg = <0x4004b000 0x1000>;
+			clocks = <&mcg_pclk_gate 4 11>;
+			status = "disabled";
+		};
+
+		portD: pinmux@4004c000 {
+			compatible = "fsl,kinetis-padconf";
+			reg = <0x4004c000 0x1000>;
+			clocks = <&mcg_pclk_gate 4 12>;
+			status = "disabled";
+		};
+
+		portE: pinmux@4004d000 {
+			compatible = "fsl,kinetis-padconf";
+			reg = <0x4004d000 0x1000>;
+			clocks = <&mcg_pclk_gate 4 13>;
+			status = "disabled";
+		};
+
+		portF: pinmux@4004e000 {
+			compatible = "fsl,kinetis-padconf";
+			reg = <0x4004e000 0x1000>;
+			clocks = <&mcg_pclk_gate 4 14>;
+			status = "disabled";
+		};
+
 		pit@40037000 {
 			compatible = "fsl,kinetis-pit-timer";
 			reg = <0x40037000 0x100>;
diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index 12ef544..c547aa9 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -94,6 +94,14 @@ config PINCTRL_IMX7D
 	help
 	  Say Y here to enable the imx7d pinctrl driver
 
+config PINCTRL_KINETIS
+	tristate "Kinetis pinctrl driver"
+	depends on OF
+	depends on ARCH_KINETIS
+	select PINMUX
+	help
+	  Say Y here to enable the Kinetis pinctrl driver
+
 config PINCTRL_VF610
 	bool "Freescale Vybrid VF610 pinctrl driver"
 	depends on SOC_VF610
diff --git a/drivers/pinctrl/freescale/Makefile b/drivers/pinctrl/freescale/Makefile
index 343cb43..8db5f4c 100644
--- a/drivers/pinctrl/freescale/Makefile
+++ b/drivers/pinctrl/freescale/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PINCTRL_IMX6Q)	+= pinctrl-imx6dl.o
 obj-$(CONFIG_PINCTRL_IMX6SL)	+= pinctrl-imx6sl.o
 obj-$(CONFIG_PINCTRL_IMX6SX)	+= pinctrl-imx6sx.o
 obj-$(CONFIG_PINCTRL_IMX7D)	+= pinctrl-imx7d.o
+obj-$(CONFIG_PINCTRL_KINETIS)	+= pinctrl-kinetis.o
 obj-$(CONFIG_PINCTRL_VF610)	+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_MXS)	+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_IMX23)	+= pinctrl-imx23.o
diff --git a/drivers/pinctrl/freescale/pinctrl-kinetis.c b/drivers/pinctrl/freescale/pinctrl-kinetis.c
new file mode 100644
index 0000000..4f0f36f
--- /dev/null
+++ b/drivers/pinctrl/freescale/pinctrl-kinetis.c
@@ -0,0 +1,541 @@
+/*
+ * pinctrl-kinetis.c - iomux for Kinetis MCUs
+ *
+ * Based on pinctrl-imx.c by Dong Aisheng <dong.aisheng@linaro.org>
+ *
+ * Copyright (C) 2015 Paul Osmialowski <pawelo@king.net.pl>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/slab.h>
+
+/**
+ * struct kinetis_pin_group - describes a single pin
+ * @mux_reg: the mux register for this pin.
+ * @mux_mode: the mux mode for this pin.
+ */
+struct kinetis_pin {
+	u32 mux_reg;
+	u32 mux_mode;
+};
+
+/**
+ * struct kinetis_pin_group - describes a pin group
+ * @name: the name of this specific pin group
+ * @npins: the number of pins in this group array, i.e. the number of
+ *	elements in .pins so we can iterate over that array
+ * @pins: array of pins
+ */
+struct kinetis_pin_group {
+	const char *name;
+	unsigned npins;
+	struct kinetis_pin *pins;
+};
+
+/**
+ * struct kinetis_pmx_func - describes pinmux functions
+ * @name: the name of this specific function
+ * @groups: corresponding pin groups
+ * @num_groups: the number of groups
+ */
+struct kinetis_pmx_func {
+	const char *name;
+	const char **groups;
+	unsigned num_groups;
+};
+
+struct kinetis_pinctrl_soc_info {
+	struct device			*dev;
+	struct kinetis_pin_group	*groups;
+	unsigned int			ngroups;
+	struct kinetis_pmx_func		*functions;
+	unsigned int			nfunctions;
+};
+
+struct kinetis_pinctrl {
+	int				port_id;
+	struct device			*dev;
+	struct pinctrl_dev		*pctl;
+	void __iomem			*base;
+	struct clk			*clk;
+	struct kinetis_pinctrl_soc_info	info;
+	bool				big_endian;
+};
+
+static const struct of_device_id kinetis_pinctrl_of_match[] = {
+	{ .compatible = "fsl,kinetis-padconf", },
+	{ /* sentinel */ }
+};
+
+/*
+ * PORTx register map
+ */
+struct kinetis_port_regs {
+	u32 pcr[32];	/* Pin Control Registers */
+	u32 gpclr;	/* Global Pin Control Low Register */
+	u32 gpchr;	/* Global Pin Control High Register */
+	u32 rsv0[6];
+	u32 isfr;	/* Interrupt Status Flag Register */
+	u32 rsv1[7];
+	u32 dfer;	/* Digital Filter Enable Register */
+	u32 dfcr;	/* Digital Filter Clock Register */
+	u32 dfwr;	/* Digital Filter Width Register */
+};
+
+/*
+ * PORTx registers base
+ */
+#define KINETIS_PORT_PTR(base, reg) \
+	(&(((struct kinetis_port_regs *)(base))->reg))
+#define KINETIS_PORT_RD(be, base, reg) \
+		((be) ? ioread32be(KINETIS_PORT_PTR(base, reg)) \
+		      : ioread32(KINETIS_PORT_PTR(base, reg)))
+#define KINETIS_PORT_WR(be, base, reg, val) do { \
+		if (be) \
+			iowrite32be((val), KINETIS_PORT_PTR(base, reg)); \
+		else \
+			iowrite32((val), KINETIS_PORT_PTR(base, reg)); \
+	} while (0)
+#define KINETIS_PORT_SET(be, base, reg, mask) \
+		KINETIS_PORT_WR(be, base, reg, \
+			KINETIS_PORT_RD(be, base, reg) | (mask))
+#define KINETIS_PORT_RESET(be, base, reg, mask) \
+		KINETIS_PORT_WR(be, base, reg, \
+			KINETIS_PORT_RD(be, base, reg) & (~(mask)))
+
+static const struct kinetis_pin_group *kinetis_pinctrl_find_group_by_name(
+				const struct kinetis_pinctrl_soc_info *info,
+				const char *name)
+{
+	const struct kinetis_pin_group *grp = NULL;
+	int i;
+
+	for (i = 0; i < info->ngroups; i++) {
+		if (!strcmp(info->groups[i].name, name)) {
+			grp = &info->groups[i];
+			break;
+		}
+	}
+
+	return grp;
+}
+
+static int kinetis_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct kinetis_pinctrl *kpctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct kinetis_pinctrl_soc_info *info = &kpctl->info;
+
+	return info->ngroups;
+}
+
+static const char *kinetis_get_group_name(struct pinctrl_dev *pctldev,
+				unsigned selector)
+{
+	struct kinetis_pinctrl *kpctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct kinetis_pinctrl_soc_info *info = &kpctl->info;
+
+	return info->groups[selector].name;
+}
+
+static int kinetis_dt_node_to_map(struct pinctrl_dev *pctldev,
+			struct device_node *np,
+			struct pinctrl_map **map, unsigned *num_maps)
+{
+	struct kinetis_pinctrl *kpctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct kinetis_pinctrl_soc_info *info = &kpctl->info;
+	const struct kinetis_pin_group *grp;
+	struct pinctrl_map *new_map;
+	struct device_node *parent;
+
+	/*
+	 * first find the group of this node and check if we need create
+	 * config maps for pins
+	 */
+	grp = kinetis_pinctrl_find_group_by_name(info, np->name);
+	if (!grp) {
+		dev_err(info->dev, "unable to find group for node %s\n",
+			np->name);
+		return -EINVAL;
+	}
+
+	new_map = kmalloc(sizeof(struct pinctrl_map), GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+
+	*map = new_map;
+	*num_maps = 1;
+
+	/* create mux map */
+	parent = of_get_parent(np);
+	if (!parent) {
+		dev_err(info->dev, "%s has no parent\n", np->name);
+		kfree(new_map);
+		return -EINVAL;
+	}
+	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
+	new_map[0].data.mux.function = parent->name;
+	new_map[0].data.mux.group = np->name;
+	of_node_put(parent);
+
+	dev_dbg(info->dev, "maps: function %s group %s\n",
+		(*map)->data.mux.function, (*map)->data.mux.group);
+
+	return 0;
+}
+
+static void kinetis_dt_free_map(struct pinctrl_dev *pctldev,
+				struct pinctrl_map *map, unsigned num_maps)
+{
+	kfree(map);
+}
+
+static int kinetis_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct kinetis_pinctrl *kpctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct kinetis_pinctrl_soc_info *info = &kpctl->info;
+
+	return info->nfunctions;
+}
+
+static const char *kinetis_get_function_name(struct pinctrl_dev *pctldev,
+				unsigned selector)
+{
+	struct kinetis_pinctrl *kpctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct kinetis_pinctrl_soc_info *info = &kpctl->info;
+
+	return info->functions[selector].name;
+}
+
+static int kinetis_get_function_groups(struct pinctrl_dev *pctldev,
+				unsigned selector,
+				const char * const **groups,
+				unsigned * const num_groups)
+{
+	struct kinetis_pinctrl *kpctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct kinetis_pinctrl_soc_info *info = &kpctl->info;
+
+	*groups = info->functions[selector].groups;
+	*num_groups = info->functions[selector].num_groups;
+
+	return 0;
+}
+
+static int kinetis_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
+				unsigned group)
+{
+	struct kinetis_pinctrl *kpctl = pinctrl_dev_get_drvdata(pctldev);
+	const struct kinetis_pinctrl_soc_info *info = &kpctl->info;
+	struct kinetis_pin_group *grp = &info->groups[group];
+	unsigned int npins = grp->npins;
+	struct kinetis_pin *pin;
+	int i;
+
+	for (i = 0; i < npins; i++) {
+		pin = &grp->pins[i];
+		KINETIS_PORT_WR(kpctl->big_endian, kpctl->base,
+				pcr[pin->mux_reg], pin->mux_mode);
+	}
+
+	return 0;
+}
+
+static const struct pinctrl_ops kinetis_pctrl_ops = {
+	.get_groups_count = kinetis_get_groups_count,
+	.get_group_name = kinetis_get_group_name,
+	.dt_node_to_map = kinetis_dt_node_to_map,
+	.dt_free_map = kinetis_dt_free_map,
+};
+
+static const struct pinmux_ops kinetis_pmx_ops = {
+	.get_functions_count = kinetis_get_functions_count,
+	.get_function_name = kinetis_get_function_name,
+	.get_function_groups = kinetis_get_function_groups,
+	.set_mux = kinetis_set_mux,
+};
+
+static struct pinctrl_desc kinetis_pinctrl_desc = {
+	.pctlops = &kinetis_pctrl_ops,
+	.pmxops = &kinetis_pmx_ops,
+	.owner = THIS_MODULE,
+};
+
+#define KINETIS_PIN_SIZE 8
+
+static int kinetis_pinctrl_parse_groups(struct device_node *np,
+				    struct kinetis_pin_group *grp,
+				    struct kinetis_pinctrl_soc_info *info,
+				    u32 index)
+{
+	int size;
+	const int pin_size = KINETIS_PIN_SIZE;
+	const __be32 *list;
+	int i;
+
+	dev_dbg(info->dev, "group(%d): %s\n", index, np->name);
+
+	/* Initialise group */
+	grp->name = np->name;
+
+	list = of_get_property(np, "fsl,pins", &size);
+	if (!list) {
+		dev_err(info->dev, "no fsl,pins property in node %s\n",
+					np->full_name);
+		return -EINVAL;
+	}
+
+	/* we do not check return since it's safe node passed down */
+	if (!size || size % pin_size) {
+		dev_err(info->dev, "Invalid fsl,pins property in node %s\n",
+					np->full_name);
+		return -EINVAL;
+	}
+
+	grp->npins = size / pin_size;
+	grp->pins = devm_kzalloc(info->dev,
+				grp->npins * sizeof(struct kinetis_pin),
+				GFP_KERNEL);
+	if (!grp->pins)
+		return -ENOMEM;
+
+	for (i = 0; i < grp->npins; i++) {
+		grp->pins[i].mux_reg = be32_to_cpu(*list++);
+		grp->pins[i].mux_mode = be32_to_cpu(*list++);
+	}
+
+	return 0;
+}
+
+static int kinetis_pinctrl_parse_functions(struct device_node *np,
+				       struct kinetis_pinctrl_soc_info *info,
+				       u32 index)
+{
+	struct device_node *child;
+	struct kinetis_pmx_func *func;
+	struct kinetis_pin_group *grp;
+	static u32 grp_index;
+	u32 i = 0;
+
+	dev_dbg(info->dev, "parse function(%d): %s\n", index, np->name);
+
+	func = &info->functions[index];
+
+	/* Initialise function */
+	func->name = np->name;
+	func->num_groups = of_get_child_count(np);
+	if (func->num_groups == 0) {
+		dev_err(info->dev, "no groups defined in %s\n", np->full_name);
+		return -EINVAL;
+	}
+	func->groups = devm_kzalloc(info->dev,
+			func->num_groups * sizeof(char *), GFP_KERNEL);
+
+	for_each_child_of_node(np, child) {
+		func->groups[i] = child->name;
+		grp = &info->groups[grp_index++];
+		kinetis_pinctrl_parse_groups(child, grp, info, i++);
+	}
+
+	return 0;
+}
+
+/*
+ * Check if the DT contains pins in the direct child nodes. This indicates the
+ * newer DT format to store pins. This function returns true if the first found
+ * fsl,pins property is in a child of np. Otherwise false is returned.
+ */
+static bool kinetis_pinctrl_dt_is_flat_functions(struct device_node *np)
+{
+	struct device_node *function_np;
+	struct device_node *pinctrl_np;
+
+	for_each_child_of_node(np, function_np) {
+		if (of_property_read_bool(function_np, "fsl,pins"))
+			return true;
+
+		for_each_child_of_node(function_np, pinctrl_np) {
+			if (of_property_read_bool(pinctrl_np, "fsl,pins"))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static int kinetis_pinctrl_probe_dt(struct platform_device *pdev,
+				struct kinetis_pinctrl_soc_info *info)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
+	u32 nfuncs = 0;
+	u32 i = 0;
+	bool flat_funcs;
+
+	if (!np)
+		return -ENODEV;
+
+	flat_funcs = kinetis_pinctrl_dt_is_flat_functions(np);
+	if (flat_funcs) {
+		nfuncs = 1;
+	} else {
+		nfuncs = of_get_child_count(np);
+		if (nfuncs <= 0) {
+			dev_err(&pdev->dev, "no functions defined\n");
+			return -EINVAL;
+		}
+	}
+
+	info->nfunctions = nfuncs;
+	info->functions = devm_kzalloc(&pdev->dev,
+				nfuncs * sizeof(struct kinetis_pmx_func),
+				GFP_KERNEL);
+	if (!info->functions)
+		return -ENOMEM;
+
+	if (flat_funcs) {
+		info->ngroups = of_get_child_count(np);
+	} else {
+		info->ngroups = 0;
+		for_each_child_of_node(np, child)
+			info->ngroups += of_get_child_count(child);
+	}
+	if (!(info->ngroups)) {
+		dev_err(&pdev->dev, "no groups found\n");
+		return -EINVAL;
+	}
+	info->groups = devm_kzalloc(&pdev->dev,
+			info->ngroups * sizeof(struct kinetis_pin_group),
+			GFP_KERNEL);
+	if (!info->groups)
+		return -ENOMEM;
+
+	if (flat_funcs) {
+		kinetis_pinctrl_parse_functions(np, info, 0);
+	} else {
+		for_each_child_of_node(np, child)
+			kinetis_pinctrl_parse_functions(child, info, i++);
+	}
+
+	return 0;
+}
+
+static int kinetis_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct kinetis_pinctrl *kpctl;
+	struct resource *res;
+	int ret;
+
+	kpctl = devm_kzalloc(&pdev->dev, sizeof(struct kinetis_pinctrl),
+					GFP_KERNEL);
+	if (!kpctl)
+		return -ENOMEM;
+
+	kpctl->big_endian = of_property_read_bool(np, "big-endian");
+
+	ret = of_alias_get_id(np, "pmx");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+		return ret;
+	}
+	kpctl->port_id = ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	kpctl->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(kpctl->base))
+		return PTR_ERR(kpctl->base);
+
+	kpctl->clk = of_clk_get(np, 0);
+	if (IS_ERR(kpctl->clk)) {
+		dev_err(&pdev->dev, "failed to get clock for PORT_%c\n",
+					'A' + kpctl->port_id);
+		return PTR_ERR(kpctl->clk);
+	}
+
+	ret = clk_prepare_enable(kpctl->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable clock for PORT_%c\n",
+					'A' + kpctl->port_id);
+		goto err_clk_enable;
+	}
+
+	kpctl->info.dev = &pdev->dev;
+	ret = kinetis_pinctrl_probe_dt(pdev, &kpctl->info);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to probe dt properties\n");
+		return ret;
+	}
+
+	kpctl->dev = &pdev->dev;
+	kinetis_pinctrl_desc.name = dev_name(&pdev->dev);
+
+	platform_set_drvdata(pdev, kpctl);
+	kpctl->pctl = pinctrl_register(&kinetis_pinctrl_desc,
+					&pdev->dev, kpctl);
+	if (IS_ERR(kpctl->pctl)) {
+		dev_err(&pdev->dev, "could not register Kinetis I/O PORT_%c\n",
+					'A' + kpctl->port_id);
+		ret = PTR_ERR(kpctl->pctl);
+		goto err_pinctrl_register;
+	}
+
+	dev_info(&pdev->dev, "initialized Kinetis I/O PORT_%c\n",
+					'A' + kpctl->port_id);
+
+	return 0;
+
+err_pinctrl_register:
+
+err_clk_enable:
+
+	clk_put(kpctl->clk);
+
+	return ret;
+}
+
+static int kinetis_pinctrl_remove(struct platform_device *pdev)
+{
+	struct kinetis_pinctrl *kpctl = platform_get_drvdata(pdev);
+
+	pinctrl_unregister(kpctl->pctl);
+	clk_disable_unprepare(kpctl->clk);
+	clk_put(kpctl->clk);
+	return 0;
+}
+
+static struct platform_driver kinetis_pinctrl_driver = {
+	.driver = {
+		.name = "kinetis-pinctrl",
+		.of_match_table = kinetis_pinctrl_of_match,
+	},
+	.probe = kinetis_pinctrl_probe,
+	.remove = kinetis_pinctrl_remove,
+};
+
+static int __init kinetis_pinctrl_init(void)
+{
+	return platform_driver_register(&kinetis_pinctrl_driver);
+}
+module_init(kinetis_pinctrl_init);
+
+static void __exit kinetis_pinctrl_exit(void)
+{
+	platform_driver_unregister(&kinetis_pinctrl_driver);
+}
+module_exit(kinetis_pinctrl_exit);
+
+MODULE_DESCRIPTION("Freescale Kinetis pinctrl driver");
+MODULE_LICENSE("GPL v2");
-- 
2.3.6
