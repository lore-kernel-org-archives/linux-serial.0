From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 16/34] MIPS: clk: migrate jz4740 to common clock framework
Date: Wed, 4 Feb 2015 15:21:45 +0000
Message-ID: <1423063323-19419-17-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

From: Paul Burton <paul.burton@imgtec.com>

Migrate the jz4740 & the qi_lb60 board to use common clock framework
via the new jz74xx-cgu driver.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Turquette <mturquette@linaro.org>

---
V2 Removed FSF address
---
 arch/mips/Kconfig                |   2 +-
 arch/mips/boot/dts/jz4740.dtsi   |  23 ++
 arch/mips/boot/dts/qi_lb60.dts   |   4 +
 arch/mips/jz4740/Makefile        |   2 -
 arch/mips/jz4740/board-qi_lb60.c |   5 -
 arch/mips/jz4740/clock-debugfs.c | 108 ------
 arch/mips/jz4740/clock.c         | 801 +--------------------------------------
 arch/mips/jz4740/clock.h         |  53 +--
 arch/mips/jz4740/time.c          |   2 +
 drivers/clk/jz47xx/Makefile      |   1 +
 drivers/clk/jz47xx/jz4740-cgu.c  | 219 +++++++++++
 11 files changed, 252 insertions(+), 968 deletions(-)
 delete mode 100644 arch/mips/jz4740/clock-debugfs.c
 create mode 100644 drivers/clk/jz47xx/jz4740-cgu.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 99d50cd..8b377a7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -286,7 +286,7 @@ config MACH_JZ4740
 	select IRQ_CPU
 	select ARCH_REQUIRE_GPIOLIB
 	select SYS_HAS_EARLY_PRINTK
-	select HAVE_CLK
+	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
 	select BUILTIN_DTB
 	select USE_OF
diff --git a/arch/mips/boot/dts/jz4740.dtsi b/arch/mips/boot/dts/jz4740.dtsi
index 3841024..ef679b4 100644
--- a/arch/mips/boot/dts/jz4740.dtsi
+++ b/arch/mips/boot/dts/jz4740.dtsi
@@ -1,3 +1,5 @@
+#include <dt-bindings/clock/jz4740-cgu.h>
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -20,4 +22,25 @@
 		interrupt-parent = <&cpuintc>;
 		interrupts = <2>;
 	};
+
+	ext: ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	rtc: rtc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
+	cgu: jz4740-cgu@10000000 {
+		compatible = "ingenic,jz4740-cgu";
+		reg = <0x10000000 0x100>;
+
+		clocks = <&ext>, <&rtc>;
+		clock-names = "ext", "rtc";
+
+		#clock-cells = <1>;
+	};
 };
diff --git a/arch/mips/boot/dts/qi_lb60.dts b/arch/mips/boot/dts/qi_lb60.dts
index 0c0f639..106d13c 100644
--- a/arch/mips/boot/dts/qi_lb60.dts
+++ b/arch/mips/boot/dts/qi_lb60.dts
@@ -5,3 +5,7 @@
 / {
 	compatible = "qi,lb60", "ingenic,jz4740";
 };
+
+&ext {
+	clock-frequency = <12000000>;
+};
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 28e5535..80e326d 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -7,8 +7,6 @@
 obj-y += prom.o irq.o time.o reset.o setup.o \
 	gpio.o clock.o platform.o timer.o serial.o
 
-obj-$(CONFIG_DEBUG_FS) += clock-debugfs.o
-
 # board specific support
 
 obj-$(CONFIG_JZ4740_QI_LB60)	+= board-qi_lb60.o
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index c454525..0fbb2d8 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -488,11 +488,6 @@ static int __init qi_lb60_init_platform_devices(void)
 
 }
 
-struct jz4740_clock_board_data jz4740_clock_bdata = {
-	.ext_rate = 12000000,
-	.rtc_rate = 32768,
-};
-
 static __init int board_avt2(char *str)
 {
 	qi_lb60_mmc_pdata.card_detect_active_low = 1;
diff --git a/arch/mips/jz4740/clock-debugfs.c b/arch/mips/jz4740/clock-debugfs.c
deleted file mode 100644
index 325422d0..0000000
--- a/arch/mips/jz4740/clock-debugfs.c
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 SoC clock support debugfs entries
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General	 Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-
-#include <linux/debugfs.h>
-#include <linux/uaccess.h>
-
-#include <asm/mach-jz4740/clock.h>
-#include "clock.h"
-
-static struct dentry *jz4740_clock_debugfs;
-
-static int jz4740_clock_debugfs_show_enabled(void *data, uint64_t *value)
-{
-	struct clk *clk = data;
-	*value = clk_is_enabled(clk);
-
-	return 0;
-}
-
-static int jz4740_clock_debugfs_set_enabled(void *data, uint64_t value)
-{
-	struct clk *clk = data;
-
-	if (value)
-		return clk_enable(clk);
-	else
-		clk_disable(clk);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(jz4740_clock_debugfs_ops_enabled,
-	jz4740_clock_debugfs_show_enabled,
-	jz4740_clock_debugfs_set_enabled,
-	"%llu\n");
-
-static int jz4740_clock_debugfs_show_rate(void *data, uint64_t *value)
-{
-	struct clk *clk = data;
-	*value = clk_get_rate(clk);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(jz4740_clock_debugfs_ops_rate,
-	jz4740_clock_debugfs_show_rate,
-	NULL,
-	"%llu\n");
-
-void jz4740_clock_debugfs_add_clk(struct clk *clk)
-{
-	if (!jz4740_clock_debugfs)
-		return;
-
-	clk->debugfs_entry = debugfs_create_dir(clk->name, jz4740_clock_debugfs);
-	debugfs_create_file("rate", S_IWUGO | S_IRUGO, clk->debugfs_entry, clk,
-				&jz4740_clock_debugfs_ops_rate);
-	debugfs_create_file("enabled", S_IRUGO, clk->debugfs_entry, clk,
-				&jz4740_clock_debugfs_ops_enabled);
-
-	if (clk->parent) {
-		char parent_path[100];
-		snprintf(parent_path, 100, "../%s", clk->parent->name);
-		clk->debugfs_parent_entry = debugfs_create_symlink("parent",
-						clk->debugfs_entry,
-						parent_path);
-	}
-}
-
-/* TODO: Locking */
-void jz4740_clock_debugfs_update_parent(struct clk *clk)
-{
-	debugfs_remove(clk->debugfs_parent_entry);
-
-	if (clk->parent) {
-		char parent_path[100];
-		snprintf(parent_path, 100, "../%s", clk->parent->name);
-		clk->debugfs_parent_entry = debugfs_create_symlink("parent",
-						clk->debugfs_entry,
-						parent_path);
-	} else {
-		clk->debugfs_parent_entry = NULL;
-	}
-}
-
-void jz4740_clock_debugfs_init(void)
-{
-	jz4740_clock_debugfs = debugfs_create_dir("jz4740-clock", NULL);
-	if (IS_ERR(jz4740_clock_debugfs))
-		jz4740_clock_debugfs = NULL;
-}
diff --git a/arch/mips/jz4740/clock.c b/arch/mips/jz4740/clock.c
index c257073..dedee7c 100644
--- a/arch/mips/jz4740/clock.c
+++ b/arch/mips/jz4740/clock.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -27,820 +28,44 @@
 
 #include "clock.h"
 
-#define JZ_REG_CLOCK_CTRL	0x00
 #define JZ_REG_CLOCK_LOW_POWER	0x04
 #define JZ_REG_CLOCK_PLL	0x10
 #define JZ_REG_CLOCK_GATE	0x20
-#define JZ_REG_CLOCK_SLEEP_CTRL 0x24
-#define JZ_REG_CLOCK_I2S	0x60
-#define JZ_REG_CLOCK_LCD	0x64
-#define JZ_REG_CLOCK_MMC	0x68
-#define JZ_REG_CLOCK_UHC	0x6C
-#define JZ_REG_CLOCK_SPI	0x74
-
-#define JZ_CLOCK_CTRL_I2S_SRC_PLL	BIT(31)
-#define JZ_CLOCK_CTRL_KO_ENABLE		BIT(30)
-#define JZ_CLOCK_CTRL_UDC_SRC_PLL	BIT(29)
-#define JZ_CLOCK_CTRL_UDIV_MASK		0x1f800000
-#define JZ_CLOCK_CTRL_CHANGE_ENABLE	BIT(22)
-#define JZ_CLOCK_CTRL_PLL_HALF		BIT(21)
-#define JZ_CLOCK_CTRL_LDIV_MASK		0x001f0000
-#define JZ_CLOCK_CTRL_UDIV_OFFSET	23
-#define JZ_CLOCK_CTRL_LDIV_OFFSET	16
-#define JZ_CLOCK_CTRL_MDIV_OFFSET	12
-#define JZ_CLOCK_CTRL_PDIV_OFFSET	 8
-#define JZ_CLOCK_CTRL_HDIV_OFFSET	 4
-#define JZ_CLOCK_CTRL_CDIV_OFFSET	 0
 
 #define JZ_CLOCK_GATE_UART0	BIT(0)
 #define JZ_CLOCK_GATE_TCU	BIT(1)
-#define JZ_CLOCK_GATE_RTC	BIT(2)
-#define JZ_CLOCK_GATE_I2C	BIT(3)
-#define JZ_CLOCK_GATE_SPI	BIT(4)
-#define JZ_CLOCK_GATE_AIC	BIT(5)
-#define JZ_CLOCK_GATE_I2S	BIT(6)
-#define JZ_CLOCK_GATE_MMC	BIT(7)
-#define JZ_CLOCK_GATE_ADC	BIT(8)
-#define JZ_CLOCK_GATE_CIM	BIT(9)
-#define JZ_CLOCK_GATE_LCD	BIT(10)
 #define JZ_CLOCK_GATE_UDC	BIT(11)
 #define JZ_CLOCK_GATE_DMAC	BIT(12)
-#define JZ_CLOCK_GATE_IPU	BIT(13)
-#define JZ_CLOCK_GATE_UHC	BIT(14)
-#define JZ_CLOCK_GATE_UART1	BIT(15)
-
-#define JZ_CLOCK_I2S_DIV_MASK		0x01ff
-
-#define JZ_CLOCK_LCD_DIV_MASK		0x01ff
-
-#define JZ_CLOCK_MMC_DIV_MASK		0x001f
 
-#define JZ_CLOCK_UHC_DIV_MASK		0x000f
-
-#define JZ_CLOCK_SPI_SRC_PLL		BIT(31)
-#define JZ_CLOCK_SPI_DIV_MASK		0x000f
-
-#define JZ_CLOCK_PLL_M_MASK		0x01ff
-#define JZ_CLOCK_PLL_N_MASK		0x001f
-#define JZ_CLOCK_PLL_OD_MASK		0x0003
 #define JZ_CLOCK_PLL_STABLE		BIT(10)
-#define JZ_CLOCK_PLL_BYPASS		BIT(9)
 #define JZ_CLOCK_PLL_ENABLED		BIT(8)
-#define JZ_CLOCK_PLL_STABLIZE_MASK	0x000f
-#define JZ_CLOCK_PLL_M_OFFSET		23
-#define JZ_CLOCK_PLL_N_OFFSET		18
-#define JZ_CLOCK_PLL_OD_OFFSET		16
 
 #define JZ_CLOCK_LOW_POWER_MODE_DOZE BIT(2)
 #define JZ_CLOCK_LOW_POWER_MODE_SLEEP BIT(0)
 
-#define JZ_CLOCK_SLEEP_CTRL_SUSPEND_UHC BIT(7)
-#define JZ_CLOCK_SLEEP_CTRL_ENABLE_UDC BIT(6)
-
 static void __iomem *jz_clock_base;
-static spinlock_t jz_clock_lock;
-static LIST_HEAD(jz_clocks);
-
-struct main_clk {
-	struct clk clk;
-	uint32_t div_offset;
-};
-
-struct divided_clk {
-	struct clk clk;
-	uint32_t reg;
-	uint32_t mask;
-};
-
-struct static_clk {
-	struct clk clk;
-	unsigned long rate;
-};
 
 static uint32_t jz_clk_reg_read(int reg)
 {
 	return readl(jz_clock_base + reg);
 }
 
-static void jz_clk_reg_write_mask(int reg, uint32_t val, uint32_t mask)
-{
-	uint32_t val2;
-
-	spin_lock(&jz_clock_lock);
-	val2 = readl(jz_clock_base + reg);
-	val2 &= ~mask;
-	val2 |= val;
-	writel(val2, jz_clock_base + reg);
-	spin_unlock(&jz_clock_lock);
-}
-
 static void jz_clk_reg_set_bits(int reg, uint32_t mask)
 {
 	uint32_t val;
 
-	spin_lock(&jz_clock_lock);
 	val = readl(jz_clock_base + reg);
 	val |= mask;
 	writel(val, jz_clock_base + reg);
-	spin_unlock(&jz_clock_lock);
 }
 
 static void jz_clk_reg_clear_bits(int reg, uint32_t mask)
 {
 	uint32_t val;
 
-	spin_lock(&jz_clock_lock);
 	val = readl(jz_clock_base + reg);
 	val &= ~mask;
 	writel(val, jz_clock_base + reg);
-	spin_unlock(&jz_clock_lock);
-}
-
-static int jz_clk_enable_gating(struct clk *clk)
-{
-	if (clk->gate_bit == JZ4740_CLK_NOT_GATED)
-		return -EINVAL;
-
-	jz_clk_reg_clear_bits(JZ_REG_CLOCK_GATE, clk->gate_bit);
-	return 0;
-}
-
-static int jz_clk_disable_gating(struct clk *clk)
-{
-	if (clk->gate_bit == JZ4740_CLK_NOT_GATED)
-		return -EINVAL;
-
-	jz_clk_reg_set_bits(JZ_REG_CLOCK_GATE, clk->gate_bit);
-	return 0;
-}
-
-static int jz_clk_is_enabled_gating(struct clk *clk)
-{
-	if (clk->gate_bit == JZ4740_CLK_NOT_GATED)
-		return 1;
-
-	return !(jz_clk_reg_read(JZ_REG_CLOCK_GATE) & clk->gate_bit);
-}
-
-static unsigned long jz_clk_static_get_rate(struct clk *clk)
-{
-	return ((struct static_clk *)clk)->rate;
-}
-
-static int jz_clk_ko_enable(struct clk *clk)
-{
-	jz_clk_reg_set_bits(JZ_REG_CLOCK_CTRL, JZ_CLOCK_CTRL_KO_ENABLE);
-	return 0;
-}
-
-static int jz_clk_ko_disable(struct clk *clk)
-{
-	jz_clk_reg_clear_bits(JZ_REG_CLOCK_CTRL, JZ_CLOCK_CTRL_KO_ENABLE);
-	return 0;
-}
-
-static int jz_clk_ko_is_enabled(struct clk *clk)
-{
-	return !!(jz_clk_reg_read(JZ_REG_CLOCK_CTRL) & JZ_CLOCK_CTRL_KO_ENABLE);
-}
-
-static const int pllno[] = {1, 2, 2, 4};
-
-static unsigned long jz_clk_pll_get_rate(struct clk *clk)
-{
-	uint32_t val;
-	int m;
-	int n;
-	int od;
-
-	val = jz_clk_reg_read(JZ_REG_CLOCK_PLL);
-
-	if (val & JZ_CLOCK_PLL_BYPASS)
-		return clk_get_rate(clk->parent);
-
-	m = ((val >> 23) & 0x1ff) + 2;
-	n = ((val >> 18) & 0x1f) + 2;
-	od = (val >> 16) & 0x3;
-
-	return ((clk_get_rate(clk->parent) / n) * m) / pllno[od];
-}
-
-static unsigned long jz_clk_pll_half_get_rate(struct clk *clk)
-{
-	uint32_t reg;
-
-	reg = jz_clk_reg_read(JZ_REG_CLOCK_CTRL);
-	if (reg & JZ_CLOCK_CTRL_PLL_HALF)
-		return jz_clk_pll_get_rate(clk->parent);
-	return jz_clk_pll_get_rate(clk->parent) >> 1;
-}
-
-static const int jz_clk_main_divs[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32};
-
-static unsigned long jz_clk_main_round_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long parent_rate = jz_clk_pll_get_rate(clk->parent);
-	int div;
-
-	div = parent_rate / rate;
-	if (div > 32)
-		return parent_rate / 32;
-	else if (div < 1)
-		return parent_rate;
-
-	div &= (0x3 << (ffs(div) - 1));
-
-	return parent_rate / div;
-}
-
-static unsigned long jz_clk_main_get_rate(struct clk *clk)
-{
-	struct main_clk *mclk = (struct main_clk *)clk;
-	uint32_t div;
-
-	div = jz_clk_reg_read(JZ_REG_CLOCK_CTRL);
-
-	div >>= mclk->div_offset;
-	div &= 0xf;
-
-	if (div >= ARRAY_SIZE(jz_clk_main_divs))
-		div = ARRAY_SIZE(jz_clk_main_divs) - 1;
-
-	return jz_clk_pll_get_rate(clk->parent) / jz_clk_main_divs[div];
-}
-
-static int jz_clk_main_set_rate(struct clk *clk, unsigned long rate)
-{
-	struct main_clk *mclk = (struct main_clk *)clk;
-	int i;
-	int div;
-	unsigned long parent_rate = jz_clk_pll_get_rate(clk->parent);
-
-	rate = jz_clk_main_round_rate(clk, rate);
-
-	div = parent_rate / rate;
-
-	i = (ffs(div) - 1) << 1;
-	if (i > 0 && !(div & BIT(i-1)))
-		i -= 1;
-
-	jz_clk_reg_write_mask(JZ_REG_CLOCK_CTRL, i << mclk->div_offset,
-				0xf << mclk->div_offset);
-
-	return 0;
-}
-
-static struct clk_ops jz_clk_static_ops = {
-	.get_rate = jz_clk_static_get_rate,
-	.enable = jz_clk_enable_gating,
-	.disable = jz_clk_disable_gating,
-	.is_enabled = jz_clk_is_enabled_gating,
-};
-
-static struct static_clk jz_clk_ext = {
-	.clk = {
-		.name = "ext",
-		.gate_bit = JZ4740_CLK_NOT_GATED,
-		.ops = &jz_clk_static_ops,
-	},
-};
-
-static struct clk_ops jz_clk_pll_ops = {
-	.get_rate = jz_clk_pll_get_rate,
-};
-
-static struct clk jz_clk_pll = {
-	.name = "pll",
-	.parent = &jz_clk_ext.clk,
-	.ops = &jz_clk_pll_ops,
-};
-
-static struct clk_ops jz_clk_pll_half_ops = {
-	.get_rate = jz_clk_pll_half_get_rate,
-};
-
-static struct clk jz_clk_pll_half = {
-	.name = "pll half",
-	.parent = &jz_clk_pll,
-	.ops = &jz_clk_pll_half_ops,
-};
-
-static const struct clk_ops jz_clk_main_ops = {
-	.get_rate = jz_clk_main_get_rate,
-	.set_rate = jz_clk_main_set_rate,
-	.round_rate = jz_clk_main_round_rate,
-};
-
-static struct main_clk jz_clk_cpu = {
-	.clk = {
-		.name = "cclk",
-		.parent = &jz_clk_pll,
-		.ops = &jz_clk_main_ops,
-	},
-	.div_offset = JZ_CLOCK_CTRL_CDIV_OFFSET,
-};
-
-static struct main_clk jz_clk_memory = {
-	.clk = {
-		.name = "mclk",
-		.parent = &jz_clk_pll,
-		.ops = &jz_clk_main_ops,
-	},
-	.div_offset = JZ_CLOCK_CTRL_MDIV_OFFSET,
-};
-
-static struct main_clk jz_clk_high_speed_peripheral = {
-	.clk = {
-		.name = "hclk",
-		.parent = &jz_clk_pll,
-		.ops = &jz_clk_main_ops,
-	},
-	.div_offset = JZ_CLOCK_CTRL_HDIV_OFFSET,
-};
-
-
-static struct main_clk jz_clk_low_speed_peripheral = {
-	.clk = {
-		.name = "pclk",
-		.parent = &jz_clk_pll,
-		.ops = &jz_clk_main_ops,
-	},
-	.div_offset = JZ_CLOCK_CTRL_PDIV_OFFSET,
-};
-
-static const struct clk_ops jz_clk_ko_ops = {
-	.enable = jz_clk_ko_enable,
-	.disable = jz_clk_ko_disable,
-	.is_enabled = jz_clk_ko_is_enabled,
-};
-
-static struct clk jz_clk_ko = {
-	.name = "cko",
-	.parent = &jz_clk_memory.clk,
-	.ops = &jz_clk_ko_ops,
-};
-
-static int jz_clk_spi_set_parent(struct clk *clk, struct clk *parent)
-{
-	if (parent == &jz_clk_pll)
-		jz_clk_reg_set_bits(JZ_CLOCK_SPI_SRC_PLL, JZ_REG_CLOCK_SPI);
-	else if (parent == &jz_clk_ext.clk)
-		jz_clk_reg_clear_bits(JZ_CLOCK_SPI_SRC_PLL, JZ_REG_CLOCK_SPI);
-	else
-		return -EINVAL;
-
-	clk->parent = parent;
-
-	return 0;
-}
-
-static int jz_clk_i2s_set_parent(struct clk *clk, struct clk *parent)
-{
-	if (parent == &jz_clk_pll_half)
-		jz_clk_reg_set_bits(JZ_REG_CLOCK_CTRL, JZ_CLOCK_CTRL_I2S_SRC_PLL);
-	else if (parent == &jz_clk_ext.clk)
-		jz_clk_reg_clear_bits(JZ_REG_CLOCK_CTRL, JZ_CLOCK_CTRL_I2S_SRC_PLL);
-	else
-		return -EINVAL;
-
-	clk->parent = parent;
-
-	return 0;
-}
-
-static int jz_clk_udc_enable(struct clk *clk)
-{
-	jz_clk_reg_set_bits(JZ_REG_CLOCK_SLEEP_CTRL,
-			JZ_CLOCK_SLEEP_CTRL_ENABLE_UDC);
-
-	return 0;
-}
-
-static int jz_clk_udc_disable(struct clk *clk)
-{
-	jz_clk_reg_clear_bits(JZ_REG_CLOCK_SLEEP_CTRL,
-			JZ_CLOCK_SLEEP_CTRL_ENABLE_UDC);
-
-	return 0;
-}
-
-static int jz_clk_udc_is_enabled(struct clk *clk)
-{
-	return !!(jz_clk_reg_read(JZ_REG_CLOCK_SLEEP_CTRL) &
-			JZ_CLOCK_SLEEP_CTRL_ENABLE_UDC);
-}
-
-static int jz_clk_udc_set_parent(struct clk *clk, struct clk *parent)
-{
-	if (parent == &jz_clk_pll_half)
-		jz_clk_reg_set_bits(JZ_REG_CLOCK_CTRL, JZ_CLOCK_CTRL_UDC_SRC_PLL);
-	else if (parent == &jz_clk_ext.clk)
-		jz_clk_reg_clear_bits(JZ_REG_CLOCK_CTRL, JZ_CLOCK_CTRL_UDC_SRC_PLL);
-	else
-		return -EINVAL;
-
-	clk->parent = parent;
-
-	return 0;
-}
-
-static int jz_clk_udc_set_rate(struct clk *clk, unsigned long rate)
-{
-	int div;
-
-	if (clk->parent == &jz_clk_ext.clk)
-		return -EINVAL;
-
-	div = clk_get_rate(clk->parent) / rate - 1;
-
-	if (div < 0)
-		div = 0;
-	else if (div > 63)
-		div = 63;
-
-	jz_clk_reg_write_mask(JZ_REG_CLOCK_CTRL, div << JZ_CLOCK_CTRL_UDIV_OFFSET,
-				JZ_CLOCK_CTRL_UDIV_MASK);
-	return 0;
-}
-
-static unsigned long jz_clk_udc_get_rate(struct clk *clk)
-{
-	int div;
-
-	if (clk->parent == &jz_clk_ext.clk)
-		return clk_get_rate(clk->parent);
-
-	div = (jz_clk_reg_read(JZ_REG_CLOCK_CTRL) & JZ_CLOCK_CTRL_UDIV_MASK);
-	div >>= JZ_CLOCK_CTRL_UDIV_OFFSET;
-	div += 1;
-
-	return clk_get_rate(clk->parent) / div;
-}
-
-static unsigned long jz_clk_divided_get_rate(struct clk *clk)
-{
-	struct divided_clk *dclk = (struct divided_clk *)clk;
-	int div;
-
-	if (clk->parent == &jz_clk_ext.clk)
-		return clk_get_rate(clk->parent);
-
-	div = (jz_clk_reg_read(dclk->reg) & dclk->mask) + 1;
-
-	return clk_get_rate(clk->parent) / div;
-}
-
-static int jz_clk_divided_set_rate(struct clk *clk, unsigned long rate)
-{
-	struct divided_clk *dclk = (struct divided_clk *)clk;
-	int div;
-
-	if (clk->parent == &jz_clk_ext.clk)
-		return -EINVAL;
-
-	div = clk_get_rate(clk->parent) / rate - 1;
-
-	if (div < 0)
-		div = 0;
-	else if (div > dclk->mask)
-		div = dclk->mask;
-
-	jz_clk_reg_write_mask(dclk->reg, div, dclk->mask);
-
-	return 0;
-}
-
-static unsigned long jz_clk_ldclk_round_rate(struct clk *clk, unsigned long rate)
-{
-	int div;
-	unsigned long parent_rate = jz_clk_pll_half_get_rate(clk->parent);
-
-	if (rate > 150000000)
-		return 150000000;
-
-	div = parent_rate / rate;
-	if (div < 1)
-		div = 1;
-	else if (div > 32)
-		div = 32;
-
-	return parent_rate / div;
-}
-
-static int jz_clk_ldclk_set_rate(struct clk *clk, unsigned long rate)
-{
-	int div;
-
-	if (rate > 150000000)
-		return -EINVAL;
-
-	div = jz_clk_pll_half_get_rate(clk->parent) / rate - 1;
-	if (div < 0)
-		div = 0;
-	else if (div > 31)
-		div = 31;
-
-	jz_clk_reg_write_mask(JZ_REG_CLOCK_CTRL, div << JZ_CLOCK_CTRL_LDIV_OFFSET,
-				JZ_CLOCK_CTRL_LDIV_MASK);
-
-	return 0;
-}
-
-static unsigned long jz_clk_ldclk_get_rate(struct clk *clk)
-{
-	int div;
-
-	div = jz_clk_reg_read(JZ_REG_CLOCK_CTRL) & JZ_CLOCK_CTRL_LDIV_MASK;
-	div >>= JZ_CLOCK_CTRL_LDIV_OFFSET;
-
-	return jz_clk_pll_half_get_rate(clk->parent) / (div + 1);
-}
-
-static const struct clk_ops jz_clk_ops_ld = {
-	.set_rate = jz_clk_ldclk_set_rate,
-	.get_rate = jz_clk_ldclk_get_rate,
-	.round_rate = jz_clk_ldclk_round_rate,
-	.enable = jz_clk_enable_gating,
-	.disable = jz_clk_disable_gating,
-	.is_enabled = jz_clk_is_enabled_gating,
-};
-
-static struct clk jz_clk_ld = {
-	.name = "lcd",
-	.gate_bit = JZ_CLOCK_GATE_LCD,
-	.parent = &jz_clk_pll_half,
-	.ops = &jz_clk_ops_ld,
-};
-
-static const struct clk_ops jz_clk_i2s_ops = {
-	.set_rate = jz_clk_divided_set_rate,
-	.get_rate = jz_clk_divided_get_rate,
-	.enable = jz_clk_enable_gating,
-	.disable = jz_clk_disable_gating,
-	.is_enabled = jz_clk_is_enabled_gating,
-	.set_parent = jz_clk_i2s_set_parent,
-};
-
-static const struct clk_ops jz_clk_spi_ops = {
-	.set_rate = jz_clk_divided_set_rate,
-	.get_rate = jz_clk_divided_get_rate,
-	.enable = jz_clk_enable_gating,
-	.disable = jz_clk_disable_gating,
-	.is_enabled = jz_clk_is_enabled_gating,
-	.set_parent = jz_clk_spi_set_parent,
-};
-
-static const struct clk_ops jz_clk_divided_ops = {
-	.set_rate = jz_clk_divided_set_rate,
-	.get_rate = jz_clk_divided_get_rate,
-	.enable = jz_clk_enable_gating,
-	.disable = jz_clk_disable_gating,
-	.is_enabled = jz_clk_is_enabled_gating,
-};
-
-static struct divided_clk jz4740_clock_divided_clks[] = {
-	[0] = {
-		.clk = {
-			.name = "i2s",
-			.parent = &jz_clk_ext.clk,
-			.gate_bit = JZ_CLOCK_GATE_I2S,
-			.ops = &jz_clk_i2s_ops,
-		},
-		.reg = JZ_REG_CLOCK_I2S,
-		.mask = JZ_CLOCK_I2S_DIV_MASK,
-	},
-	[1] = {
-		.clk = {
-			.name = "spi",
-			.parent = &jz_clk_ext.clk,
-			.gate_bit = JZ_CLOCK_GATE_SPI,
-			.ops = &jz_clk_spi_ops,
-		},
-		.reg = JZ_REG_CLOCK_SPI,
-		.mask = JZ_CLOCK_SPI_DIV_MASK,
-	},
-	[2] = {
-		.clk = {
-			.name = "lcd_pclk",
-			.parent = &jz_clk_pll_half,
-			.gate_bit = JZ4740_CLK_NOT_GATED,
-			.ops = &jz_clk_divided_ops,
-		},
-		.reg = JZ_REG_CLOCK_LCD,
-		.mask = JZ_CLOCK_LCD_DIV_MASK,
-	},
-	[3] = {
-		.clk = {
-			.name = "mmc",
-			.parent = &jz_clk_pll_half,
-			.gate_bit = JZ_CLOCK_GATE_MMC,
-			.ops = &jz_clk_divided_ops,
-		},
-		.reg = JZ_REG_CLOCK_MMC,
-		.mask = JZ_CLOCK_MMC_DIV_MASK,
-	},
-	[4] = {
-		.clk = {
-			.name = "uhc",
-			.parent = &jz_clk_pll_half,
-			.gate_bit = JZ_CLOCK_GATE_UHC,
-			.ops = &jz_clk_divided_ops,
-		},
-		.reg = JZ_REG_CLOCK_UHC,
-		.mask = JZ_CLOCK_UHC_DIV_MASK,
-	},
-};
-
-static const struct clk_ops jz_clk_udc_ops = {
-	.set_parent = jz_clk_udc_set_parent,
-	.set_rate = jz_clk_udc_set_rate,
-	.get_rate = jz_clk_udc_get_rate,
-	.enable = jz_clk_udc_enable,
-	.disable = jz_clk_udc_disable,
-	.is_enabled = jz_clk_udc_is_enabled,
-};
-
-static const struct clk_ops jz_clk_simple_ops = {
-	.enable = jz_clk_enable_gating,
-	.disable = jz_clk_disable_gating,
-	.is_enabled = jz_clk_is_enabled_gating,
-};
-
-static struct clk jz4740_clock_simple_clks[] = {
-	[0] = {
-		.name = "udc",
-		.parent = &jz_clk_ext.clk,
-		.ops = &jz_clk_udc_ops,
-	},
-	[1] = {
-		.name = "uart0",
-		.parent = &jz_clk_ext.clk,
-		.gate_bit = JZ_CLOCK_GATE_UART0,
-		.ops = &jz_clk_simple_ops,
-	},
-	[2] = {
-		.name = "uart1",
-		.parent = &jz_clk_ext.clk,
-		.gate_bit = JZ_CLOCK_GATE_UART1,
-		.ops = &jz_clk_simple_ops,
-	},
-	[3] = {
-		.name = "dma",
-		.parent = &jz_clk_high_speed_peripheral.clk,
-		.gate_bit = JZ_CLOCK_GATE_DMAC,
-		.ops = &jz_clk_simple_ops,
-	},
-	[4] = {
-		.name = "ipu",
-		.parent = &jz_clk_high_speed_peripheral.clk,
-		.gate_bit = JZ_CLOCK_GATE_IPU,
-		.ops = &jz_clk_simple_ops,
-	},
-	[5] = {
-		.name = "adc",
-		.parent = &jz_clk_ext.clk,
-		.gate_bit = JZ_CLOCK_GATE_ADC,
-		.ops = &jz_clk_simple_ops,
-	},
-	[6] = {
-		.name = "i2c",
-		.parent = &jz_clk_ext.clk,
-		.gate_bit = JZ_CLOCK_GATE_I2C,
-		.ops = &jz_clk_simple_ops,
-	},
-	[7] = {
-		.name = "aic",
-		.parent = &jz_clk_ext.clk,
-		.gate_bit = JZ_CLOCK_GATE_AIC,
-		.ops = &jz_clk_simple_ops,
-	},
-};
-
-static struct static_clk jz_clk_rtc = {
-	.clk = {
-		.name = "rtc",
-		.gate_bit = JZ_CLOCK_GATE_RTC,
-		.ops = &jz_clk_static_ops,
-	},
-	.rate = 32768,
-};
-
-int clk_enable(struct clk *clk)
-{
-	if (!clk->ops->enable)
-		return -EINVAL;
-
-	return clk->ops->enable(clk);
-}
-EXPORT_SYMBOL_GPL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-	if (clk->ops->disable)
-		clk->ops->disable(clk);
-}
-EXPORT_SYMBOL_GPL(clk_disable);
-
-int clk_is_enabled(struct clk *clk)
-{
-	if (clk->ops->is_enabled)
-		return clk->ops->is_enabled(clk);
-
-	return 1;
-}
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	if (clk->ops->get_rate)
-		return clk->ops->get_rate(clk);
-	if (clk->parent)
-		return clk_get_rate(clk->parent);
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(clk_get_rate);
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	if (!clk->ops->set_rate)
-		return -EINVAL;
-	return clk->ops->set_rate(clk, rate);
-}
-EXPORT_SYMBOL_GPL(clk_set_rate);
-
-long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	if (clk->ops->round_rate)
-		return clk->ops->round_rate(clk, rate);
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(clk_round_rate);
-
-int clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	int ret;
-	int enabled;
-
-	if (!clk->ops->set_parent)
-		return -EINVAL;
-
-	enabled = clk_is_enabled(clk);
-	if (enabled)
-		clk_disable(clk);
-	ret = clk->ops->set_parent(clk, parent);
-	if (enabled)
-		clk_enable(clk);
-
-	jz4740_clock_debugfs_update_parent(clk);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(clk_set_parent);
-
-struct clk *clk_get(struct device *dev, const char *name)
-{
-	struct clk *clk;
-
-	list_for_each_entry(clk, &jz_clocks, list) {
-		if (strcmp(clk->name, name) == 0)
-			return clk;
-	}
-	return ERR_PTR(-ENXIO);
-}
-EXPORT_SYMBOL_GPL(clk_get);
-
-void clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL_GPL(clk_put);
-
-static inline void clk_add(struct clk *clk)
-{
-	list_add_tail(&clk->list, &jz_clocks);
-
-	jz4740_clock_debugfs_add_clk(clk);
-}
-
-static void clk_register_clks(void)
-{
-	size_t i;
-
-	clk_add(&jz_clk_ext.clk);
-	clk_add(&jz_clk_pll);
-	clk_add(&jz_clk_pll_half);
-	clk_add(&jz_clk_cpu.clk);
-	clk_add(&jz_clk_high_speed_peripheral.clk);
-	clk_add(&jz_clk_low_speed_peripheral.clk);
-	clk_add(&jz_clk_ko);
-	clk_add(&jz_clk_ld);
-	clk_add(&jz_clk_rtc.clk);
-
-	for (i = 0; i < ARRAY_SIZE(jz4740_clock_divided_clks); ++i)
-		clk_add(&jz4740_clock_divided_clks[i].clk);
-
-	for (i = 0; i < ARRAY_SIZE(jz4740_clock_simple_clks); ++i)
-		clk_add(&jz4740_clock_simple_clks[i]);
 }
 
 void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode)
@@ -891,33 +116,9 @@ void jz4740_clock_resume(void)
 
 int jz4740_clock_init(void)
 {
-	uint32_t val;
-
 	jz_clock_base = ioremap(JZ4740_CPM_BASE_ADDR, 0x100);
 	if (!jz_clock_base)
 		return -EBUSY;
 
-	spin_lock_init(&jz_clock_lock);
-
-	jz_clk_ext.rate = jz4740_clock_bdata.ext_rate;
-	jz_clk_rtc.rate = jz4740_clock_bdata.rtc_rate;
-
-	val = jz_clk_reg_read(JZ_REG_CLOCK_SPI);
-
-	if (val & JZ_CLOCK_SPI_SRC_PLL)
-		jz4740_clock_divided_clks[1].clk.parent = &jz_clk_pll_half;
-
-	val = jz_clk_reg_read(JZ_REG_CLOCK_CTRL);
-
-	if (val & JZ_CLOCK_CTRL_I2S_SRC_PLL)
-		jz4740_clock_divided_clks[0].clk.parent = &jz_clk_pll_half;
-
-	if (val & JZ_CLOCK_CTRL_UDC_SRC_PLL)
-		jz4740_clock_simple_clks[0].parent = &jz_clk_pll_half;
-
-	jz4740_clock_debugfs_init();
-
-	clk_register_clks();
-
 	return 0;
 }
diff --git a/arch/mips/jz4740/clock.h b/arch/mips/jz4740/clock.h
index 5d07499..86a3e01 100644
--- a/arch/mips/jz4740/clock.h
+++ b/arch/mips/jz4740/clock.h
@@ -16,61 +16,10 @@
 #ifndef __MIPS_JZ4740_CLOCK_H__
 #define __MIPS_JZ4740_CLOCK_H__
 
+#include <linux/clk.h>
 #include <linux/list.h>
 
-struct jz4740_clock_board_data {
-	unsigned long ext_rate;
-	unsigned long rtc_rate;
-};
-
-extern struct jz4740_clock_board_data jz4740_clock_bdata;
-
 void jz4740_clock_suspend(void);
 void jz4740_clock_resume(void);
 
-struct clk;
-
-struct clk_ops {
-	unsigned long (*get_rate)(struct clk *clk);
-	unsigned long (*round_rate)(struct clk *clk, unsigned long rate);
-	int (*set_rate)(struct clk *clk, unsigned long rate);
-	int (*enable)(struct clk *clk);
-	int (*disable)(struct clk *clk);
-	int (*is_enabled)(struct clk *clk);
-
-	int (*set_parent)(struct clk *clk, struct clk *parent);
-
-};
-
-struct clk {
-	const char *name;
-	struct clk *parent;
-
-	uint32_t gate_bit;
-
-	const struct clk_ops *ops;
-
-	struct list_head list;
-
-#ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_entry;
-	struct dentry *debugfs_parent_entry;
-#endif
-
-};
-
-#define JZ4740_CLK_NOT_GATED ((uint32_t)-1)
-
-int clk_is_enabled(struct clk *clk);
-
-#ifdef CONFIG_DEBUG_FS
-void jz4740_clock_debugfs_init(void);
-void jz4740_clock_debugfs_add_clk(struct clk *clk);
-void jz4740_clock_debugfs_update_parent(struct clk *clk);
-#else
-static inline void jz4740_clock_debugfs_init(void) {};
-static inline void jz4740_clock_debugfs_add_clk(struct clk *clk) {};
-static inline void jz4740_clock_debugfs_update_parent(struct clk *clk) {};
-#endif
-
 #endif
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index bff2ac9..caa796d 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/time.h>
@@ -112,6 +113,7 @@ void __init plat_time_init(void)
 	uint16_t ctrl;
 	struct clk *ext_clk;
 
+	of_clk_init(NULL);
 	jz4740_clock_init();
 	jz4740_timer_init();
 
diff --git a/drivers/clk/jz47xx/Makefile b/drivers/clk/jz47xx/Makefile
index ac594e5..21746fc 100644
--- a/drivers/clk/jz47xx/Makefile
+++ b/drivers/clk/jz47xx/Makefile
@@ -1 +1,2 @@
 obj-y				+= jz47xx-cgu.o
+obj-$(CONFIG_MACH_JZ4740)	+= jz4740-cgu.o
diff --git a/drivers/clk/jz47xx/jz4740-cgu.c b/drivers/clk/jz47xx/jz4740-cgu.c
new file mode 100644
index 0000000..83f1e1f
--- /dev/null
+++ b/drivers/clk/jz47xx/jz4740-cgu.c
@@ -0,0 +1,219 @@
+/*
+ * Ingenic jz4740 SoC CGU driver
+ *
+ * Copyright (c) 2015 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <dt-bindings/clock/jz4740-cgu.h>
+#include "jz47xx-cgu.h"
+
+/* CGU register offsets */
+#define CGU_REG_CPCCR		0x00
+#define CGU_REG_CPPCR		0x10
+#define CGU_REG_I2SCDR		0x60
+#define CGU_REG_LPCDR		0x64
+#define CGU_REG_MSCCDR		0x68
+#define CGU_REG_UHCCDR		0x6c
+#define CGU_REG_SSICDR		0x74
+
+/* bits within a PLL control register */
+#define PLLCTL_M_SHIFT		23
+#define PLLCTL_M_MASK		(0x1ff << PLLCTL_M_SHIFT)
+#define PLLCTL_N_SHIFT		18
+#define PLLCTL_N_MASK		(0x1f << PLLCTL_N_SHIFT)
+#define PLLCTL_OD_SHIFT		16
+#define PLLCTL_OD_MASK		(0x3 << PLLCTL_OD_SHIFT)
+#define PLLCTL_STABLE		(1 << 10)
+#define PLLCTL_BYPASS		(1 << 9)
+#define PLLCTL_ENABLE		(1 << 8)
+
+static struct jz47xx_cgu *cgu;
+
+static const s8 pll_od_encoding[4] = {
+	0x0, 0x1, -1, 0x3,
+};
+
+static const struct jz47xx_cgu_clk_info jz4740_cgu_clocks[] = {
+
+	/* External clocks */
+
+	[JZ4740_CLK_EXT] = { "ext", CGU_CLK_EXT },
+	[JZ4740_CLK_RTC] = { "rtc", CGU_CLK_EXT },
+
+	[JZ4740_CLK_PLL] = {
+		"pll", CGU_CLK_PLL,
+		.parents = { JZ4740_CLK_EXT, -1 },
+		.pll = {
+			.reg = CGU_REG_CPPCR,
+			.m_shift = 23,
+			.m_bits = 9,
+			.m_offset = 2,
+			.n_shift = 18,
+			.n_bits = 5,
+			.n_offset = 2,
+			.od_shift = 16,
+			.od_bits = 2,
+			.od_max = 4,
+			.od_encoding = pll_od_encoding,
+			.stable_bit = 10,
+			.bypass_bit = 9,
+			.enable_bit = 8,
+		},
+	},
+
+	/* Muxes & dividers */
+
+	[JZ4740_CLK_PLL_HALF] = {
+		"pll half", CGU_CLK_DIV,
+		.parents = { JZ4740_CLK_PLL, -1 },
+		.div = { CGU_REG_CPCCR, 21, 1, -1, -1, -1 },
+	},
+
+	[JZ4740_CLK_CCLK] = {
+		"cclk", CGU_CLK_DIV,
+		.parents = { JZ4740_CLK_PLL, -1 },
+		.div = { CGU_REG_CPCCR, 0, 4, 22, -1, -1 },
+	},
+
+	[JZ4740_CLK_HCLK] = {
+		"hclk", CGU_CLK_DIV,
+		.parents = { JZ4740_CLK_PLL, -1 },
+		.div = { CGU_REG_CPCCR, 4, 4, 22, -1, -1 },
+	},
+
+	[JZ4740_CLK_PCLK] = {
+		"pclk", CGU_CLK_DIV,
+		.parents = { JZ4740_CLK_PLL, -1 },
+		.div = { CGU_REG_CPCCR, 8, 4, 22, -1, -1 },
+	},
+
+	[JZ4740_CLK_MCLK] = {
+		"mclk", CGU_CLK_DIV,
+		.parents = { JZ4740_CLK_PLL, -1 },
+		.div = { CGU_REG_CPCCR, 12, 4, 22, -1, -1 },
+	},
+
+	[JZ4740_CLK_LCD] = {
+		"lcd", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_PLL_HALF, -1 },
+		.div = { CGU_REG_CPCCR, 16, 5, 22, -1, -1 },
+		.gate_bit = 10,
+	},
+
+	[JZ4740_CLK_LCD_PCLK] = {
+		"lcd_pclk", CGU_CLK_DIV,
+		.parents = { JZ4740_CLK_PLL_HALF, -1 },
+		.div = { CGU_REG_LPCDR, 0, 11, -1, -1, -1 },
+	},
+
+	[JZ4740_CLK_I2S] = {
+		"i2s", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF, -1 },
+		.mux = { CGU_REG_CPCCR, 31, 1 },
+		.div = { CGU_REG_I2SCDR, 0, 8, -1, -1, -1 },
+		.gate_bit = 6,
+	},
+
+	[JZ4740_CLK_SPI] = {
+		"spi", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL, -1 },
+		.mux = { CGU_REG_SSICDR, 31, 1 },
+		.div = { CGU_REG_SSICDR, 0, 4, -1, -1, -1 },
+		.gate_bit = 4,
+	},
+
+	[JZ4740_CLK_MMC] = {
+		"mmc", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_PLL_HALF, -1 },
+		.div = { CGU_REG_MSCCDR, 0, 5, -1, -1, -1 },
+		.gate_bit = 7,
+	},
+
+	[JZ4740_CLK_UHC] = {
+		"uhc", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_PLL_HALF, -1 },
+		.div = { CGU_REG_UHCCDR, 0, 4, -1, -1, -1 },
+		.gate_bit = 14,
+	},
+
+	[JZ4740_CLK_UDC] = {
+		"udc", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF, -1 },
+		.mux = { CGU_REG_CPCCR, 29, 1 },
+		.div = { CGU_REG_CPCCR, 23, 6, -1, -1, -1 },
+		/* TODO: gate via SCR */
+	},
+
+	/* Gate-only clocks */
+
+	[JZ4740_CLK_UART0] = {
+		"uart0", CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_EXT, -1 },
+		.gate_bit = 0,
+	},
+
+	[JZ4740_CLK_UART1] = {
+		"uart1", CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_EXT, -1 },
+		.gate_bit = 15,
+	},
+
+	[JZ4740_CLK_DMA] = {
+		"dma", CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_PCLK, -1 },
+		.gate_bit = 12,
+	},
+
+	[JZ4740_CLK_IPU] = {
+		"ipu", CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_PCLK, -1 },
+		.gate_bit = 13,
+	},
+
+	[JZ4740_CLK_ADC] = {
+		"adc", CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_EXT, -1 },
+		.gate_bit = 8,
+	},
+
+	[JZ4740_CLK_I2C] = {
+		"i2c", CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_EXT, -1 },
+		.gate_bit = 3,
+	},
+
+	[JZ4740_CLK_AIC] = {
+		"aic", CGU_CLK_GATE,
+		.parents = { JZ4740_CLK_EXT, -1 },
+		.gate_bit = 5,
+	},
+};
+
+static void __init jz4740_cgu_init(struct device_node *np)
+{
+	int retval;
+	cgu = jz47xx_cgu_new(jz4740_cgu_clocks, ARRAY_SIZE(jz4740_cgu_clocks),
+			     np);
+	if (!cgu)
+		pr_err("%s: failed to initialise CGU\n", __func__);
+
+	retval = jz47xx_cgu_register_clocks(cgu);
+	if (retval)
+		pr_err("%s: failed to register CGU Clocks\n", __func__);
+}
+CLK_OF_DECLARE(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
-- 
1.9.1
