From: Paul Osmialowski <pawelo@king.net.pl>
Subject: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
Date: Tue, 30 Jun 2015 14:27:24 +0200
Message-ID: <1435667250-28299-4-git-send-email-pawelo@king.net.pl>
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

Based on K70P256M150SF3RM.pdf K70 Sub-Family Reference Manual, Rev. 3.

Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
---
 .../devicetree/bindings/clock/kinetis-clock.txt    |  63 +++
 arch/arm/boot/dts/kinetis.dtsi                     |  36 ++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-kinetis.c                          | 463 +++++++++++++++++++++
 4 files changed, 563 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/kinetis-clock.txt
 create mode 100644 drivers/clk/clk-kinetis.c

diff --git a/Documentation/devicetree/bindings/clock/kinetis-clock.txt b/Documentation/devicetree/bindings/clock/kinetis-clock.txt
new file mode 100644
index 0000000..63af6a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/kinetis-clock.txt
@@ -0,0 +1,63 @@
+* Clock bindings for Freescale Kinetis SoC
+
+Required properties:
+- compatible: Should be "fsl,kinetis-cmu".
+- reg: Two address ranges, one for the Clock Genetator register set,
+	one for System Integration Module register set.
+- Set of clock devices: one fixed-rate-root, fixed-rate clocks and clock-gates.
+
+For clock-gate addresses see K70 Sub-Family Reference Manual, Rev. 3 pg. 341
+and later. Notice that addresses are zero-based, so SIM_SCGC1 has address 0,
+SIM_SCGC2 has address 1 and so on. The second address component is the bit
+index.
+
+Example:
+
+cmu@40064000 {
+	compatible = "fsl,kinetis-cmu";
+	reg = <0x40064000 0x14>, <0x40047000 0x1100>;
+
+	mcg_outclk: fixed-rate-root@mcgout {
+		device_type = "mcgout";
+		#clock-cells = <0>;
+	};
+
+	mcg_cclk: fixed-rate@cclk {
+		device_type = "cclk";
+		#clock-cells = <0>;
+		clocks = <&mcg_outclk>;
+	};
+
+	mcg_pclk: fixed-rate@pclk {
+		device_type = "pclk";
+		#clock-cells = <0>;
+		clocks = <&mcg_outclk>;
+	};
+
+	mcg_cclk_gate: clock-gate@cclk {
+		#clock-cells = <2>;
+		clocks = <&mcg_cclk>;
+	};
+
+	mcg_pclk_gate: clock-gate@pclk {
+		#clock-cells = <2>;
+		clocks = <&mcg_pclk>;
+	};
+};
+
+mcg: cmu@40064000 {
+	compatible = "fsl,kinetis-cmu";
+	reg = <0x40064000 0x14>;
+	#clock-cells = <1>;
+};
+
+uart1: serial@4006b000 {
+	compatible = "fsl,kinetis-lpuart";
+	reg = <0x4006b000 0x1000>;
+	interrupts = <47>, <48>;
+	interrupt-names = "uart-stat", "uart-err";
+	clocks = <&mcg_cclk_gate 3 11>;
+	clock-names = "ipg";
+	dmas = <&edma 0 4>;
+	dma-names = "rx";
+};
diff --git a/arch/arm/boot/dts/kinetis.dtsi b/arch/arm/boot/dts/kinetis.dtsi
index 93d2a8a..ae0cf00 100644
--- a/arch/arm/boot/dts/kinetis.dtsi
+++ b/arch/arm/boot/dts/kinetis.dtsi
@@ -3,3 +3,39 @@
  *
  */
 #include "armv7-m.dtsi"
+
+/ {
+	soc {
+		cmu@40064000 {
+			compatible = "fsl,kinetis-cmu";
+			reg = <0x40064000 0x14>, <0x40047000 0x1100>;
+
+			mcg_outclk: fixed-rate-root@mcgout {
+				device_type = "mcgout";
+				#clock-cells = <0>;
+			};
+
+			mcg_cclk: fixed-rate@cclk {
+				device_type = "cclk";
+				#clock-cells = <0>;
+				clocks = <&mcg_outclk>;
+			};
+
+			mcg_pclk: fixed-rate@pclk {
+				device_type = "pclk";
+				#clock-cells = <0>;
+				clocks = <&mcg_outclk>;
+			};
+
+			mcg_cclk_gate: clock-gate@cclk {
+				#clock-cells = <2>;
+				clocks = <&mcg_cclk>;
+			};
+
+			mcg_pclk_gate: clock-gate@pclk {
+				#clock-cells = <2>;
+				clocks = <&mcg_pclk>;
+			};
+		};
+	};
+};
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 63418cf..412d76b 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
+obj-$(CONFIG_ARCH_KINETIS)		+= clk-kinetis.o
 obj-$(CONFIG_MACH_LOONGSON32)		+= clk-ls1x.o
 obj-$(CONFIG_COMMON_CLK_MAX_GEN)	+= clk-max-gen.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
diff --git a/drivers/clk/clk-kinetis.c b/drivers/clk/clk-kinetis.c
new file mode 100644
index 0000000..611e2e9
--- /dev/null
+++ b/drivers/clk/clk-kinetis.c
@@ -0,0 +1,463 @@
+/*
+ * clk-kinetis.c - Clock driver for Kinetis K70 MCG
+ *
+ * Based on legacy pre-OF code by Alexander Potashev <aspotashev@emcraft.com>
+ *
+ * Copyright (C) 2015 Paul Osmialowski <pawelo@king.net.pl>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+
+/*
+ * Frequencies on OSC0 (EXTAL0/XTAL0) and OSC1 (EXTAL1/XTAL1)
+ *
+ * These frequencies should be set to the same values as in U-Boot.
+ */
+#define KINETIS_OSC0_RATE	50000000	/* 50 MHz */
+#define KINETIS_OSC1_RATE	12000000	/* 12 MHz */
+
+#define KINETIS_SIM_CG_NUMREGS	7
+
+/*
+ * System Integration Module (SIM) register map
+ *
+ * This map actually covers two hardware modules:
+ *     1. SIM low-power logic, at 0x40047000
+ *     2. System integration module (SIM), at 0x40048000
+ */
+struct kinetis_sim_regs {
+	u32 sopt1;	/* System Options Register 1 */
+	u32 rsv0[1024];
+	u32 sopt2;	/* System Options Register 2 */
+	u32 rsv1;
+	u32 sopt4;	/* System Options Register 4 */
+	u32 sopt5;	/* System Options Register 5 */
+	u32 sopt6;	/* System Options Register 6 */
+	u32 sopt7;	/* System Options Register 7 */
+	u32 rsv2[2];
+	u32 sdid;	/* System Device Identification Register */
+	u32 scgc[KINETIS_SIM_CG_NUMREGS];	/* Clock Gating Regs 1...7 */
+	u32 clkdiv1;	/* System Clock Divider Register 1 */
+	u32 clkdiv2;	/* System Clock Divider Register 2 */
+	u32 fcfg1;	/* Flash Configuration Register 1 */
+	u32 fcfg2;	/* Flash Configuration Register 2 */
+	u32 uidh;	/* Unique Identification Register High */
+	u32 uidmh;	/* Unique Identification Register Mid-High */
+	u32 uidml;	/* Unique Identification Register Mid Low */
+	u32 uidl;	/* Unique Identification Register Low */
+	u32 clkdiv3;	/* System Clock Divider Register 3 */
+	u32 clkdiv4;	/* System Clock Divider Register 4 */
+	u32 mcr;	/* Misc Control Register */
+};
+
+/*
+ * SIM registers base
+ */
+#define KINETIS_SIM_PTR(base, reg) \
+	(&(((struct kinetis_sim_regs *)(base))->reg))
+#define KINETIS_SIM_RD(be, base, reg) \
+		((be) ? ioread32be(KINETIS_SIM_PTR(base, reg)) \
+		      : ioread32(KINETIS_SIM_PTR(base, reg)))
+#define KINETIS_SIM_WR(be, base, reg, val) do { \
+		if (be) \
+			iowrite32be((val), KINETIS_SIM_PTR(base, reg)); \
+		else \
+			iowrite32((val), KINETIS_SIM_PTR(base, reg)); \
+	} while (0)
+#define KINETIS_SIM_SET(be, base, reg, mask) \
+		KINETIS_SIM_WR(be, base, reg, \
+			KINETIS_SIM_RD(be, base, reg) | (mask))
+#define KINETIS_SIM_RESET(be, base, reg, mask) \
+		KINETIS_SIM_WR(be, base, reg, \
+			KINETIS_SIM_RD(be, base, reg) & (~(mask)))
+
+/*
+ * System Clock Divider Register 1
+ */
+/* Clock 1 output divider value (for the core/system clock) */
+#define KINETIS_SIM_CLKDIV1_OUTDIV1_BITS	28
+#define KINETIS_SIM_CLKDIV1_OUTDIV1_MSK \
+	(((1 << 4) - 1) << KINETIS_SIM_CLKDIV1_OUTDIV1_BITS)
+/* Clock 2 output divider value (for the peripheral clock) */
+#define KINETIS_SIM_CLKDIV1_OUTDIV2_BITS	24
+#define KINETIS_SIM_CLKDIV1_OUTDIV2_MSK \
+	(((1 << 4) - 1) << KINETIS_SIM_CLKDIV1_OUTDIV2_BITS)
+
+/*
+ * System Clock Divider Register 2
+ */
+/* USB HS clock divider fraction */
+#define KINETIS_SIM_CLKDIV2_USBHSFRAC_BIT	8
+#define KINETIS_SIM_CLKDIV2_USBHSFRAC_MSK \
+	(1 << KINETIS_SIM_CLKDIV2_USBHSFRAC_BIT)
+/* USB HS clock divider divisor */
+#define KINETIS_SIM_CLKDIV2_USBHSDIV_BIT	9
+#define KINETIS_SIM_CLKDIV2_USBHSDIV_MSK \
+	(7 << KINETIS_SIM_CLKDIV2_USBHSDIV_BIT)
+
+/*
+ * MCG Control 5 Register
+ */
+/* PLL External Reference Divider */
+#define KINETIS_MCG_C5_PRDIV_BITS	0
+#define KINETIS_MCG_C5_PRDIV_MSK \
+	(((1 << 3) - 1) << KINETIS_MCG_C5_PRDIV_BITS)
+/* PLL Stop Enable */
+#define KINETIS_MCG_C5_PLLSTEN_MSK	(1 << 5)
+/* PLL Clock Enable */
+#define KINETIS_MCG_C5_PLLCLKEN_MSK	(1 << 6)
+/* PLL External Reference Select (for K70@120MHz) */
+#define KINETIS_MCG_C5_PLLREFSEL_BIT	7
+#define KINETIS_MCG_C5_PLLREFSEL_MSK	(1 << KINETIS_MCG_C5_PLLREFSEL_BIT)
+/*
+ * MCG Control 6 Register
+ */
+/* VCO Divider */
+#define KINETIS_MCG_C6_VDIV_BITS	0
+#define KINETIS_MCG_C6_VDIV_MSK \
+	(((1 << 5) - 1) << KINETIS_MCG_C6_VDIV_BITS)
+/* PLL Select */
+#define KINETIS_MCG_C6_PLLS_MSK		(1 << 6)
+/*
+ * MCG Control 11 Register
+ */
+/* PLL1 External Reference Divider */
+#define KINETIS_MCG_C11_PRDIV_BITS	0
+#define KINETIS_MCG_C11_PRDIV_MSK \
+	(((1 << 3) - 1) << KINETIS_MCG_C11_PRDIV_BITS)
+/* PLL Clock Select: PLL0 or PLL1 */
+#define KINETIS_MCG_C11_PLLCS_MSK	(1 << 4)
+/* PLL1 Stop Enable */
+#define KINETIS_MCG_C11_PLLSTEN1_MSK	(1 << 5)
+/* PLL1 Clock Enable */
+#define KINETIS_MCG_C11_PLLCLKEN1_MSK	(1 << 6)
+/* PLL1 External Reference Select (for K70@120MHz) */
+#define KINETIS_MCG_C11_PLLREFSEL1_BIT	7
+#define KINETIS_MCG_C11_PLLREFSEL1_MSK	(1 << KINETIS_MCG_C11_PLLREFSEL1_BIT)
+/*
+ * MCG Control 12 Register
+ */
+/* VCO1 Divider */
+#define KINETIS_MCG_C12_VDIV1_BITS	0
+#define KINETIS_MCG_C12_VDIV1_MSK \
+	(((1 << 5) - 1) << KINETIS_MCG_C12_VDIV1_BITS)
+
+/*
+ * Multipurpose Clock Generator (MCG) register map
+ *
+ * See Chapter 25 of the K70 Reference Manual
+ */
+struct kinetis_mcg_regs {
+	u8 c1;		/* MCG Control 1 Register */
+	u8 c2;		/* MCG Control 2 Register */
+	u8 c3;		/* MCG Control 3 Register */
+	u8 c4;		/* MCG Control 4 Register */
+	u8 c5;		/* MCG Control 5 Register */
+	u8 c6;		/* MCG Control 6 Register */
+	u8 status;	/* MCG Status Register */
+	u8 rsv0;
+	u8 atc;		/* MCG Auto Trim Control Register */
+	u8 rsv1;
+	u8 atcvh;	/* MCG Auto Trim Compare Value High Register */
+	u8 atcvl;	/* MCG Auto Trim Compare Value Low Register */
+	u8 c7;		/* MCG Control 7 Register */
+	u8 c8;		/* MCG Control 8 Register */
+	u8 rsv2;
+	u8 c10;		/* MCG Control 10 Register */
+	u8 c11;		/* MCG Control 11 Register */
+	u8 c12;		/* MCG Control 12 Register */
+	u8 status2;	/* MCG Status 2 Register */
+	u8 rsv3;
+};
+
+#define KINETIS_MCG_PTR(base, reg) \
+	(&(((struct kinetis_mcg_regs *)(base))->reg))
+#define KINETIS_MCG_RD(base, reg) readb_relaxed(KINETIS_MCG_PTR(base, reg))
+#define KINETIS_MCG_WR(base, reg, val) \
+	writeb_relaxed((val), KINETIS_MCG_PTR(base, reg))
+#define KINETIS_MCG_ISSET(base, reg, mask) \
+	(KINETIS_MCG_RD(base, reg) & (mask))
+
+struct kinetis_clk_gate {
+	const char *clk_gate_name;
+	struct clk *clk;
+	u32 reg;
+	u32 idx;
+	struct list_head clk_list;
+};
+
+struct kinetis_clk_gate_data {
+	const char *clk_parent_name;
+	void __iomem *sim;
+	struct list_head clk_gate_list;
+};
+
+static struct clk *kinetis_find_clk_gate(
+		struct kinetis_clk_gate_data *clk_gate_data, u32 reg, u32 idx)
+{
+	struct kinetis_clk_gate *gate;
+
+	list_for_each_entry(gate, &clk_gate_data->clk_gate_list, clk_list)
+		if ((gate->reg == reg) && (gate->idx == idx))
+			return gate->clk;
+
+	return NULL;
+}
+
+static struct clk *kinetis_clk_gate_get(struct of_phandle_args *clkspec,
+					void *data)
+{
+	struct kinetis_clk_gate_data *clk_gate_data = data;
+	struct kinetis_clk_gate *gate;
+	u32 reg = clkspec->args[0];
+	u32 idx = clkspec->args[1];
+	struct clk *clk;
+
+	clk = kinetis_find_clk_gate(clk_gate_data, reg, idx);
+	if (clk)
+		return clk;
+
+	gate = kzalloc(sizeof(struct kinetis_clk_gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+	gate->clk_gate_name = kasprintf(GFP_KERNEL, "%s:%u:%u",
+				clkspec->np->full_name, reg, idx);
+
+	clk = clk_register_gate(NULL, gate->clk_gate_name,
+				clk_gate_data->clk_parent_name, 0,
+				KINETIS_SIM_PTR(clk_gate_data->sim, scgc[reg]),
+				idx, 0, NULL);
+	if (IS_ERR(clk)) {
+		pr_err("Cannot register gate to clock %s\n",
+				clk_gate_data->clk_parent_name);
+		kfree_const(gate->clk_gate_name);
+		kfree(gate);
+		return clk;
+	}
+
+	gate->clk = clk;
+	gate->reg = reg;
+	gate->idx = idx;
+
+	list_add(&gate->clk_list, &clk_gate_data->clk_gate_list);
+
+	return clk;
+}
+
+static const char *kinetis_of_clk_get_name(struct device_node *np)
+{
+	struct of_phandle_args clkspec;
+	int ret;
+	const char *retval;
+
+	ret = of_parse_phandle_with_args(np, "clocks", "#clock-cells", 0,
+					&clkspec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	retval = clkspec.np->full_name;
+
+	of_node_put(clkspec.np);
+
+	return retval;
+}
+
+static void __init kinetis_mcg_init(struct device_node *np)
+{
+	const int vco_div = 2;
+	const int vdiv_min = 16;
+	u32 clock_val_mcgout;
+	u32 clock_val_cclk;
+	u32 clock_val_pclk;
+	u32 clock_val;
+	void __iomem *base;
+	void __iomem *sim;
+	int pll_sel;
+	int osc_sel;
+	unsigned long mcgout;
+	struct clk *clk;
+	const char *clk_parent_name;
+	struct kinetis_clk_gate_data *clk_gate;
+	struct device_node *child;
+	bool big_endian;
+	int ret;
+
+	big_endian = of_property_read_bool(np, "big-endian");
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("Failed to map address range for kinetis,mcg node\n");
+		return;
+	}
+
+	sim = of_iomap(np, 1);
+	if (!sim) {
+		pr_err("Failed to map address range for kinetis SIM module\n");
+		iounmap(base);
+		return;
+	}
+
+	/*
+	 * Check whether PLL0 or PLL1 is used for MCGOUTCLK
+	 */
+	pll_sel = !!(KINETIS_MCG_ISSET(base, c11, KINETIS_MCG_C11_PLLCS_MSK));
+
+	/*
+	 * Check whether OSC0 or OSC1 is used to source the main PLL
+	 */
+	if (pll_sel)
+		osc_sel = !!(KINETIS_MCG_ISSET(base, c11,
+				KINETIS_MCG_C11_PLLREFSEL1_MSK));
+	else
+		osc_sel = !!(KINETIS_MCG_ISSET(base, c5,
+				KINETIS_MCG_C5_PLLREFSEL_MSK));
+
+	/*
+	 * Start with the MCG input clock
+	 */
+	mcgout = osc_sel ? KINETIS_OSC1_RATE : KINETIS_OSC0_RATE;
+
+	/*
+	 * Apply dividers and multipliers of the selected PLL
+	 */
+	if (pll_sel) {
+		/*
+		 * PLL1 internal divider (PRDIV)
+		 */
+		mcgout /= ((KINETIS_MCG_RD(base, c11) &
+		  KINETIS_MCG_C11_PRDIV_MSK) >> KINETIS_MCG_C11_PRDIV_BITS) + 1;
+		/*
+		 * PLL1 multiplication factor (VDIV)
+		 */
+		mcgout *= ((KINETIS_MCG_RD(base, c12) &
+		  KINETIS_MCG_C12_VDIV1_MSK) >> KINETIS_MCG_C12_VDIV1_BITS) +
+								    vdiv_min;
+	} else {
+		/*
+		 * PLL0 internal divider (PRDIV)
+		 */
+		mcgout /= ((KINETIS_MCG_RD(base, c5) &
+			KINETIS_MCG_C5_PRDIV_MSK) >>
+			KINETIS_MCG_C5_PRDIV_BITS) + 1;
+		/*
+		 * PLL0 multiplication factor (VDIV)
+		 */
+		mcgout *= ((KINETIS_MCG_RD(base, c6) &
+			KINETIS_MCG_C6_VDIV_MSK) >>
+			KINETIS_MCG_C6_VDIV_BITS) + vdiv_min;
+	}
+
+	/*
+	 * Apply the PLL output divider
+	 */
+	mcgout /= vco_div;
+
+	clock_val_mcgout = mcgout;
+
+	clock_val_cclk = mcgout /
+		(((KINETIS_SIM_RD(big_endian, sim, clkdiv1) &
+			KINETIS_SIM_CLKDIV1_OUTDIV1_MSK) >>
+				KINETIS_SIM_CLKDIV1_OUTDIV1_BITS) + 1);
+
+	/*
+	 * Peripheral (bus) clock
+	 */
+	clock_val_pclk = mcgout /
+		(((KINETIS_SIM_RD(big_endian, sim, clkdiv1) &
+			KINETIS_SIM_CLKDIV1_OUTDIV2_MSK) >>
+				KINETIS_SIM_CLKDIV1_OUTDIV2_BITS) + 1);
+
+	for_each_child_of_node(np, child) {
+		if (!of_device_is_available(child))
+			continue;
+
+		clock_val = 0;
+		if (child->type) {
+			if (!of_node_cmp(child->type, "mcgout"))
+				clock_val = clock_val_mcgout;
+			else if (!of_node_cmp(child->type, "cclk"))
+				clock_val = clock_val_cclk;
+			else if (!of_node_cmp(child->type, "pclk"))
+				clock_val = clock_val_pclk;
+		}
+
+		if (!of_node_cmp(child->name, "fixed-rate-root")) {
+			clk = clk_register_fixed_rate(NULL, child->full_name,
+						NULL, CLK_IS_ROOT, clock_val);
+			if (IS_ERR(clk)) {
+				pr_err("Could not register clock %s\n",
+							child->full_name);
+				continue;
+			}
+
+			ret = of_clk_add_provider(child, of_clk_src_simple_get,
+							clk);
+			if (ret < 0) {
+				pr_err("Could not add clock provider %s\n",
+							child->full_name);
+				continue;
+			}
+		} else if (!of_node_cmp(child->name, "fixed-rate")) {
+			clk_parent_name = kinetis_of_clk_get_name(child);
+			if (IS_ERR(clk_parent_name)) {
+				pr_err("Could not get parent clk name for %s\n",
+							child->full_name);
+			}
+
+			clk = clk_register_fixed_rate(NULL, child->full_name,
+						clk_parent_name, 0, clock_val);
+			if (IS_ERR(clk)) {
+				pr_err("Could not register clock %s\n",
+							child->full_name);
+				continue;
+			}
+
+			ret = of_clk_add_provider(child, of_clk_src_simple_get,
+							clk);
+			if (ret < 0) {
+				pr_err("Could not add clock provider %s\n",
+							child->full_name);
+				continue;
+			}
+		} else if (!of_node_cmp(child->name, "clock-gate")) {
+			clk_parent_name = kinetis_of_clk_get_name(child);
+			if (IS_ERR(clk_parent_name)) {
+				pr_err("Could not get parent clk name for %s\n",
+							child->full_name);
+			}
+
+			clk_gate = kzalloc(sizeof(struct kinetis_clk_gate_data),
+								    GFP_KERNEL);
+			if (!clk_gate)
+				continue;
+
+			clk_gate->clk_parent_name = clk_parent_name;
+			clk_gate->sim = sim;
+			INIT_LIST_HEAD(&clk_gate->clk_gate_list);
+
+			ret = of_clk_add_provider(child, kinetis_clk_gate_get,
+							clk_gate);
+			if (ret < 0) {
+				pr_err("Could not add clock provider %s\n",
+							child->full_name);
+				continue;
+			}
+		} else {
+			pr_err("Unknown clock name\n");
+			continue;
+		}
+	}
+}
+
+CLK_OF_DECLARE(kinetis_mcg, "fsl,kinetis-cmu", kinetis_mcg_init);
-- 
2.3.6
