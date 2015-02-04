From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 14/34] clk: jz47xx-cgu: add driver for Ingenic jz47xx series CGU clocks
Date: Wed, 4 Feb 2015 15:21:43 +0000
Message-ID: <1423063323-19419-15-git-send-email-Zubair.Kakakhel@imgtec.com>
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

This driver supports the CGU clocks for the Ingenic jz47xx series of
SoCs. It is generic enough to be usable across at least the jz4740 to
the jz4780, as will be done in subsequent commits.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Co-authored-by: Paul Cercueil <paul@crapouillou.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Turquette <mturquette@linaro.org>

---
V2
Removed FSF address
Bug fix in error handling
---
 drivers/clk/Makefile            |   1 +
 drivers/clk/jz47xx/Makefile     |   1 +
 drivers/clk/jz47xx/jz47xx-cgu.c | 723 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/jz47xx/jz47xx-cgu.h | 205 ++++++++++++
 4 files changed, 930 insertions(+)
 create mode 100644 drivers/clk/jz47xx/Makefile
 create mode 100644 drivers/clk/jz47xx/jz47xx-cgu.c
 create mode 100644 drivers/clk/jz47xx/jz47xx-cgu.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d5fba5b..fc434c0 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
 obj-$(CONFIG_ARCH_HI3xxx)		+= hisilicon/
 obj-$(CONFIG_ARCH_HIP04)		+= hisilicon/
 obj-$(CONFIG_ARCH_HIX5HD2)		+= hisilicon/
+obj-$(CONFIG_MACH_JZ4740)		+= jz47xx/
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
diff --git a/drivers/clk/jz47xx/Makefile b/drivers/clk/jz47xx/Makefile
new file mode 100644
index 0000000..ac594e5
--- /dev/null
+++ b/drivers/clk/jz47xx/Makefile
@@ -0,0 +1 @@
+obj-y				+= jz47xx-cgu.o
diff --git a/drivers/clk/jz47xx/jz47xx-cgu.c b/drivers/clk/jz47xx/jz47xx-cgu.c
new file mode 100644
index 0000000..85d0592
--- /dev/null
+++ b/drivers/clk/jz47xx/jz47xx-cgu.c
@@ -0,0 +1,723 @@
+/*
+ * Ingenic jz47xx series CGU driver
+ *
+ * Copyright (c) 2013-2015 Imagination Technologies
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
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include "jz47xx-cgu.h"
+
+#define REG_CLKGR		0x20
+#define REG_CLKGR_STRIDE	0x8
+
+#define MHZ (1000 * 1000)
+
+/**
+ * jz47xx_cgu_gate_get - get the value of clock gate register bit
+ * @cgu: reference to the CGU whose registers should be read
+ * @idx: index of the gate bit
+ *
+ * Returns 1 if the gate bit is set, else 0. The index begins with 0 being
+ * bit 0 of CLKGR0, continuing from 32 for bit 0 of CLKGR1 etc. For example,
+ * the index of bit 9 of CLKGR1 would be (32+9) == 41.
+ *
+ * The caller must hold cgu->power_lock.
+ */
+static inline unsigned jz47xx_cgu_gate_get(struct jz47xx_cgu *cgu,
+					   unsigned idx)
+{
+	void __iomem *reg;
+	u32 bit, clkgr;
+
+	reg = cgu->base + REG_CLKGR + ((idx / 32) * REG_CLKGR_STRIDE);
+	bit = 1 << (idx % 32);
+	clkgr = readl(reg);
+	return !!(clkgr & bit);
+}
+
+/**
+ * jz47xx_cgu_gate_set - set the value of clock gate register bit
+ * @cgu: reference to the CGU whose registers should be modified
+ * @idx: index of the gate bit
+ * @val: non-zero to gate a clock, otherwise zero
+ *
+ * Sets the given gate bit in order to gate or ungate a clock. See
+ * jz47xx_cgu_gate_get for a description of the idx parameter.
+ *
+ * The caller must hold cgu->power_lock.
+ */
+static inline void jz47xx_cgu_gate_set(struct jz47xx_cgu *cgu,
+				       unsigned idx, unsigned val)
+{
+	void __iomem *reg;
+	u32 bit, clkgr;
+
+	reg = cgu->base + REG_CLKGR + ((idx / 32) * REG_CLKGR_STRIDE);
+	bit = 1 << (idx % 32);
+	clkgr = readl(reg);
+
+	if (val)
+		clkgr |= bit;
+	else
+		clkgr &= ~bit;
+
+	writel(clkgr, reg);
+}
+
+/*
+ * PLL operations
+ */
+
+static unsigned long jz47xx_pll_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+	const struct jz47xx_cgu_pll_info *pll_info;
+	unsigned m, n, od_enc, od;
+	bool bypass, enable;
+	unsigned long flags;
+	u32 ctl;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+	BUG_ON(clk_info->type != CGU_CLK_PLL);
+	pll_info = &clk_info->pll;
+
+	spin_lock_irqsave(&cgu->pll_lock, flags);
+	ctl = readl(cgu->base + pll_info->reg);
+	spin_unlock_irqrestore(&cgu->pll_lock, flags);
+
+	m = ((ctl >> pll_info->m_shift) & GENMASK(pll_info->m_bits - 1, 0));
+	m += pll_info->m_offset;
+	n = ((ctl >> pll_info->n_shift) & GENMASK(pll_info->n_bits - 1, 0));
+	n += pll_info->n_offset;
+	od_enc = ((ctl >> pll_info->od_shift)
+		 & GENMASK(pll_info->od_bits - 1, 0));
+	bypass = !!(ctl & BIT(pll_info->bypass_bit));
+	enable = !!(ctl & BIT(pll_info->enable_bit));
+
+	if (bypass)
+		return parent_rate;
+
+	if (!enable)
+		return 0;
+
+	for (od = 0; od < pll_info->od_max; od++) {
+		if (pll_info->od_encoding[od] == od_enc)
+			break;
+	}
+	BUG_ON(od == pll_info->od_max);
+	od++;
+
+	return parent_rate * m / (n * od);
+}
+
+static unsigned long jz47xx_pll_calc(const struct jz47xx_cgu_clk_info *clk_info,
+				     unsigned long rate,
+				     unsigned long parent_rate,
+				     unsigned *pm, unsigned *pn, unsigned *pod)
+{
+	unsigned m, n, od;
+
+	/* deal with MHz */
+	rate -= (rate % MHZ);
+
+	m = rate / MHZ;
+	m = min_t(unsigned, m, 1 << clk_info->pll.m_bits);
+	m = max_t(unsigned, m, 1);
+
+	n = parent_rate / MHZ;
+	n = min_t(unsigned, n, 1 << clk_info->pll.n_bits);
+	n = max_t(unsigned, n, 1);
+
+	od = 1;
+
+	if (pm)
+		*pm = m;
+	if (pn)
+		*pn = n;
+	if (pod)
+		*pod = od;
+
+	return parent_rate * m / (n * od);
+}
+
+static long jz47xx_pll_round_rate(struct clk_hw *hw, unsigned long req_rate,
+				  unsigned long *prate)
+{
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+	BUG_ON(clk_info->type != CGU_CLK_PLL);
+
+	return jz47xx_pll_calc(clk_info, req_rate, *prate, NULL, NULL, NULL);
+}
+
+static int jz47xx_pll_set_rate(struct clk_hw *hw, unsigned long req_rate,
+			       unsigned long parent_rate)
+{
+	const unsigned timeout = 100;
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+	const struct jz47xx_cgu_pll_info *pll_info;
+	unsigned long rate, flags;
+	unsigned m, n, od, i;
+	u32 ctl;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+	BUG_ON(clk_info->type != CGU_CLK_PLL);
+	pll_info = &clk_info->pll;
+
+	rate = jz47xx_pll_calc(clk_info, req_rate, parent_rate,
+			       &m, &n, &od);
+	if (rate != req_rate) {
+		pr_info("jz47xx-cgu: request '%s' rate %luHz, actual %luHz\n",
+			clk_info->name, req_rate, rate);
+	}
+
+	spin_lock_irqsave(&cgu->pll_lock, flags);
+	ctl = readl(cgu->base + pll_info->reg);
+
+	ctl &= ~(GENMASK(pll_info->m_bits - 1, 0) << pll_info->m_shift);
+	ctl |= (m - pll_info->m_offset) << pll_info->m_shift;
+
+	ctl &= ~(GENMASK(pll_info->n_bits - 1, 0) << pll_info->n_shift);
+	ctl |= (n - pll_info->n_offset) << pll_info->n_shift;
+
+	ctl &= ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
+	ctl |= pll_info->od_encoding[od - 1] << pll_info->od_shift;
+
+	ctl &= ~BIT(pll_info->bypass_bit);
+	ctl |= BIT(pll_info->enable_bit);
+
+	writel(ctl, cgu->base + pll_info->reg);
+
+	/* wait for the PLL to stabilise */
+	for (i = 0; i < timeout; i++) {
+		if (readl(cgu->base + pll_info->reg)
+			 & BIT(pll_info->stable_bit))
+			break;
+		mdelay(1);
+	}
+
+	spin_unlock_irqrestore(&cgu->pll_lock, flags);
+
+	if (i == timeout)
+		return -EBUSY;
+
+	return 0;
+}
+
+static const struct clk_ops jz47xx_pll_ops = {
+	.recalc_rate = jz47xx_pll_recalc_rate,
+	.round_rate = jz47xx_pll_round_rate,
+	.set_rate = jz47xx_pll_set_rate,
+};
+
+/*
+ * Operations for all non-PLL clocks
+ */
+
+static u8 jz47xx_clk_get_parent(struct clk_hw *hw)
+{
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+	u32 reg;
+	u8 i, hw_idx, idx = 0;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+
+	if (clk_info->type & CGU_CLK_MUX) {
+		reg = readl(cgu->base + clk_info->mux.reg);
+		hw_idx = (reg >> clk_info->mux.shift) &
+			 ((1 << clk_info->mux.bits) - 1);
+
+		/*
+		 * Convert the hardware index to the parent index by skipping
+		 * over any -1's in the parents array.
+		 */
+		for (i = 0; i < hw_idx; i++) {
+			if (clk_info->parents[i] != -1)
+				idx++;
+		}
+	}
+
+	return idx;
+}
+
+static int jz47xx_clk_set_parent(struct clk_hw *hw, u8 idx)
+{
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+	unsigned long flags;
+	u8 curr_idx, hw_idx, num_poss;
+	u32 reg, mask;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+
+	if (clk_info->type & CGU_CLK_MUX) {
+		/*
+		 * Convert the parent index to the hardware index by adding
+		 * 1 for any -1 in the parents array preceeding the given
+		 * index. That is, we want the index of idx'th entry in
+		 * clk_info->parents which does not equal -1.
+		 */
+		hw_idx = curr_idx = 0;
+		num_poss = 1 << clk_info->mux.bits;
+		for (; (hw_idx < num_poss) && (curr_idx != idx); hw_idx++) {
+			if (clk_info->parents[hw_idx] == -1)
+				continue;
+			curr_idx++;
+		}
+
+		/* idx should always be a valid parent */
+		BUG_ON(curr_idx != idx);
+
+		mask = ((1 << clk_info->mux.bits) - 1) << clk_info->mux.shift;
+
+		spin_lock_irqsave(&cgu->divmux_lock, flags);
+
+		/* write the register */
+		reg = readl(cgu->base + clk_info->mux.reg);
+		reg &= ~mask;
+		reg |= hw_idx << clk_info->mux.shift;
+		writel(reg, cgu->base + clk_info->mux.reg);
+
+		spin_unlock_irqrestore(&cgu->divmux_lock, flags);
+		return 0;
+	}
+
+	return idx ? -EINVAL : 0;
+}
+
+static unsigned long jz47xx_clk_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+	unsigned long rate = parent_rate;
+	u32 div_reg, div;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+
+	if (clk_info->type & CGU_CLK_DIV) {
+		div_reg = readl(cgu->base + clk_info->div.reg);
+		div = (div_reg >> clk_info->div.shift) &
+		      ((1 << clk_info->div.bits) - 1);
+		div += 1;
+
+		rate /= div;
+	}
+
+	return rate;
+}
+
+static unsigned jz47xx_clk_calc_div(const struct jz47xx_cgu_clk_info *clk_info,
+				    unsigned long parent_rate,
+				    unsigned long req_rate)
+{
+	unsigned div;
+
+	/* calculate the divide that gets us closest */
+	div = DIV_ROUND_CLOSEST(parent_rate, req_rate);
+
+	/* and impose hardware constraints */
+	div = min_t(unsigned, div, 1 << clk_info->div.bits);
+	div = max_t(unsigned, div, 1);
+
+	return div;
+}
+
+static long jz47xx_clk_round_rate(struct clk_hw *hw, unsigned long req_rate,
+				  unsigned long *parent_rate)
+{
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+	long rate = req_rate;
+	unsigned div;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+
+	if (clk_info->type & CGU_CLK_DIV) {
+		div = jz47xx_clk_calc_div(clk_info, *parent_rate, req_rate);
+		rate = *parent_rate / div;
+	}
+
+	return rate;
+}
+
+static int jz47xx_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
+			       unsigned long parent_rate)
+{
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+	const unsigned timeout = 100;
+	unsigned long rate, flags;
+	unsigned div, i;
+	u32 reg, mask;
+	int ret = 0;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+
+	if (clk_info->type & CGU_CLK_DIV) {
+		div = jz47xx_clk_calc_div(clk_info, parent_rate, req_rate);
+		rate = parent_rate / div;
+
+		if (rate != req_rate)
+			return -EINVAL;
+
+		spin_lock_irqsave(&cgu->divmux_lock, flags);
+		reg = readl(cgu->base + clk_info->div.reg);
+
+		/* update the divide */
+		mask = (1 << clk_info->div.bits) - 1;
+		reg &= ~(mask << clk_info->div.shift);
+		reg |= (div - 1) << clk_info->div.shift;
+
+		/* clear the stop bit */
+		if (clk_info->div.stop_bit != -1)
+			reg &= ~(1 << clk_info->div.stop_bit);
+
+		/* set the change enable bit */
+		if (clk_info->div.ce_bit != -1)
+			reg |= 1 << clk_info->div.ce_bit;
+
+		/* update the hardware */
+		writel(reg, cgu->base + clk_info->div.reg);
+
+		/* wait for the change to take effect */
+		if (clk_info->div.busy_bit != -1) {
+			for (i = 0; i < timeout; i++) {
+				reg = readl(cgu->base + clk_info->div.reg);
+				if (!(reg & (1 << clk_info->div.busy_bit)))
+					break;
+				mdelay(1);
+			}
+			if (i == timeout)
+				ret = -EBUSY;
+		}
+
+		spin_unlock_irqrestore(&cgu->divmux_lock, flags);
+
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+static int jz47xx_clk_enable(struct clk_hw *hw)
+{
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+	unsigned long flags;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+
+	if (clk_info->type & CGU_CLK_GATE) {
+		/* ungate the clock */
+		spin_lock_irqsave(&cgu->power_lock, flags);
+		jz47xx_cgu_gate_set(cgu, clk_info->gate_bit, 0);
+		spin_unlock_irqrestore(&cgu->power_lock, flags);
+	}
+
+	return 0;
+}
+
+static void jz47xx_clk_disable(struct clk_hw *hw)
+{
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+	unsigned long flags;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+
+	if (clk_info->type & CGU_CLK_GATE) {
+		/* gate the clock */
+		spin_lock_irqsave(&cgu->power_lock, flags);
+		jz47xx_cgu_gate_set(cgu, clk_info->gate_bit, 1);
+		spin_unlock_irqrestore(&cgu->power_lock, flags);
+	}
+}
+
+static int jz47xx_clk_is_enabled(struct clk_hw *hw)
+{
+	struct jz47xx_clk *jz_clk = to_jz47xx_clk(hw);
+	struct jz47xx_cgu *cgu = jz_clk->cgu;
+	const struct jz47xx_cgu_clk_info *clk_info;
+	unsigned long flags;
+	int enabled = 1;
+
+	clk_info = &cgu->clock_info[jz_clk->idx];
+
+	if (clk_info->type & CGU_CLK_GATE) {
+		spin_lock_irqsave(&cgu->power_lock, flags);
+		enabled = !jz47xx_cgu_gate_get(cgu, clk_info->gate_bit);
+		spin_unlock_irqrestore(&cgu->power_lock, flags);
+	}
+
+	return enabled;
+}
+
+static const struct clk_ops jz47xx_clk_ops = {
+	.get_parent = jz47xx_clk_get_parent,
+	.set_parent = jz47xx_clk_set_parent,
+
+	.recalc_rate = jz47xx_clk_recalc_rate,
+	.round_rate = jz47xx_clk_round_rate,
+	.set_rate = jz47xx_clk_set_rate,
+
+	.enable = jz47xx_clk_enable,
+	.disable = jz47xx_clk_disable,
+	.is_enabled = jz47xx_clk_is_enabled,
+};
+
+/*
+ * Setup functions.
+ */
+
+static int register_clock(struct jz47xx_cgu *cgu, unsigned idx)
+{
+	const struct jz47xx_cgu_clk_info *clk_info = &cgu->clock_info[idx];
+	struct clk_init_data clk_init;
+	struct jz47xx_clk *jz_clk = NULL;
+	struct clk *clk, *parent;
+	const char *parent_names[4];
+	unsigned caps, i, num_possible;
+	int err = -EINVAL;
+
+	BUILD_BUG_ON(ARRAY_SIZE(clk_info->parents) > ARRAY_SIZE(parent_names));
+
+	if (clk_info->type == CGU_CLK_EXT) {
+		clk = of_clk_get_by_name(cgu->np, clk_info->name);
+		if (IS_ERR(clk)) {
+			pr_err("%s: no external clock '%s' provided\n",
+			       __func__, clk_info->name);
+			err = -ENODEV;
+			goto out;
+		}
+		err = clk_register_clkdev(clk, clk_info->name, NULL);
+		if (err) {
+			clk_put(clk);
+			goto out;
+		}
+		cgu->clocks.clks[idx] = clk;
+		return 0;
+	}
+
+	if (!clk_info->type) {
+		pr_err("%s: no clock type specified for '%s'\n", __func__,
+		       clk_info->name);
+		goto out;
+	}
+
+	jz_clk = kzalloc(sizeof(*jz_clk), GFP_KERNEL);
+	if (!jz_clk) {
+		pr_err("%s: failed to allocate struct jz47xx_clk\n", __func__);
+		err = -ENOMEM;
+		goto out;
+	}
+
+	jz_clk->hw.init = &clk_init;
+	jz_clk->cgu = cgu;
+	jz_clk->idx = idx;
+
+	clk_init.name = clk_info->name;
+	clk_init.flags = 0;
+	clk_init.parent_names = parent_names;
+
+	caps = clk_info->type;
+
+	if (caps & (CGU_CLK_MUX | CGU_CLK_CUSTOM)) {
+		clk_init.num_parents = 0;
+
+		if (caps & CGU_CLK_MUX)
+			num_possible = 1 << clk_info->mux.bits;
+		else
+			num_possible = ARRAY_SIZE(clk_info->parents);
+
+		for (i = 0; i < num_possible; i++) {
+			if (clk_info->parents[i] == -1)
+				continue;
+
+			parent = cgu->clocks.clks[clk_info->parents[i]];
+			parent_names[clk_init.num_parents] =
+				__clk_get_name(parent);
+			clk_init.num_parents++;
+		}
+
+		BUG_ON(!clk_init.num_parents);
+		BUG_ON(clk_init.num_parents > ARRAY_SIZE(parent_names));
+	} else {
+		BUG_ON(clk_info->parents[0] == -1);
+		clk_init.num_parents = 1;
+		parent = cgu->clocks.clks[clk_info->parents[0]];
+		parent_names[0] = __clk_get_name(parent);
+	}
+
+	if (caps & CGU_CLK_CUSTOM) {
+		clk_init.ops = clk_info->custom.clk_ops;
+
+		caps &= ~CGU_CLK_CUSTOM;
+
+		if (caps) {
+			pr_err("%s: custom clock may not be combined with type 0x%x\n",
+			       __func__, caps);
+			goto out;
+		}
+	} else if (caps & CGU_CLK_PLL) {
+		clk_init.ops = &jz47xx_pll_ops;
+
+		caps &= ~CGU_CLK_PLL;
+
+		if (caps) {
+			pr_err("%s: PLL may not be combined with type 0x%x\n",
+			       __func__, caps);
+			goto out;
+		}
+	} else {
+		clk_init.ops = &jz47xx_clk_ops;
+	}
+
+	/* nothing to do for gates */
+	caps &= ~CGU_CLK_GATE;
+
+	if (caps & CGU_CLK_MUX) {
+		if (!(caps & CGU_CLK_MUX_GLITCHFREE))
+			clk_init.flags |= CLK_SET_PARENT_GATE;
+
+		caps &= ~(CGU_CLK_MUX | CGU_CLK_MUX_GLITCHFREE);
+	}
+
+	if (caps & CGU_CLK_DIV) {
+		caps &= ~CGU_CLK_DIV;
+	} else {
+		/* pass rate changes to the parent clock */
+		clk_init.flags |= CLK_SET_RATE_PARENT;
+	}
+
+	if (caps) {
+		pr_err("%s: unknown clock type 0x%x\n", __func__, caps);
+		goto out;
+	}
+
+	clk = clk_register(NULL, &jz_clk->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register clock '%s'\n", __func__,
+		       clk_info->name);
+		err = PTR_ERR(clk);
+		goto out;
+	}
+
+	err = clk_register_clkdev(clk, clk_info->name, NULL);
+	if (err)
+		goto out;
+
+	cgu->clocks.clks[idx] = clk;
+out:
+	if (err)
+		kfree(jz_clk);
+	return err;
+}
+
+struct jz47xx_cgu *jz47xx_cgu_new(const struct jz47xx_cgu_clk_info *clock_info,
+				  unsigned num_clocks,
+				  struct device_node *np)
+{
+	struct jz47xx_cgu *cgu;
+
+	cgu = kzalloc(sizeof(*cgu), GFP_KERNEL);
+	if (!cgu) {
+		pr_err("%s: failed to allocate struct jz47xx_cgu\n", __func__);
+		goto err_out;
+	}
+
+	cgu->base = of_iomap(np, 0);
+	if (!cgu->base) {
+		pr_err("%s: failed to map CGU registers\n", __func__);
+		goto err_out_free;
+	}
+
+	cgu->np = np;
+	cgu->clock_info = clock_info;
+	cgu->clocks.clk_num = num_clocks;
+
+	spin_lock_init(&cgu->divmux_lock);
+	spin_lock_init(&cgu->power_lock);
+	spin_lock_init(&cgu->pll_lock);
+
+	return cgu;
+
+err_out_free:
+	kfree(cgu);
+err_out:
+	return NULL;
+}
+
+int jz47xx_cgu_register_clocks(struct jz47xx_cgu *cgu)
+{
+	unsigned i;
+	int err = -EINVAL;
+
+	cgu->clocks.clks = kzalloc(sizeof(struct clk *) * cgu->clocks.clk_num,
+				   GFP_KERNEL);
+	if (!cgu->clocks.clks) {
+		pr_err("%s: failed to alloc clock table\n", __func__);
+		goto err_out;
+	}
+
+	for (i = 0; i < cgu->clocks.clk_num; i++) {
+		err = register_clock(cgu, i);
+		if (err)
+			goto err_out_unregister;
+	}
+
+	err = of_clk_add_provider(cgu->np, of_clk_src_onecell_get,
+				  &cgu->clocks);
+	if (err)
+		goto err_out_unregister;
+
+	return 0;
+err_out_unregister:
+	if (cgu) {
+		for (i = 0; i < cgu->clocks.clk_num; i++) {
+			if (!cgu->clocks.clks[i])
+				continue;
+			if (cgu->clock_info[i].type & CGU_CLK_EXT)
+				clk_put(cgu->clocks.clks[i]);
+			else
+				clk_unregister(cgu->clocks.clks[i]);
+		}
+		kfree(cgu->clocks.clks);
+	}
+err_out:
+	return err;
+}
diff --git a/drivers/clk/jz47xx/jz47xx-cgu.h b/drivers/clk/jz47xx/jz47xx-cgu.h
new file mode 100644
index 0000000..ec7fe7d
--- /dev/null
+++ b/drivers/clk/jz47xx/jz47xx-cgu.h
@@ -0,0 +1,205 @@
+/*
+ * Ingenic jz47xx series CGU driver
+ *
+ * Copyright (c) 2013-2015 Imagination Technologies
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
+#ifndef __DRIVERS_CLK_JZ47XX_JZ47XX_CGU_H__
+#define __DRIVERS_CLK_JZ47XX_JZ47XX_CGU_H__
+
+#include <linux/of.h>
+#include <linux/spinlock.h>
+
+/**
+ * struct jz47xx_cgu_pll_info - information about a PLL
+ * @reg: the offset of the PLL's control register within the CGU
+ * @m_shift: the number of bits to shift the multiplier value by (ie. the
+ *           index of the lowest bit of the multiplier value in the PLL's
+ *           control register)
+ * @m_bits: the size of the multiplier field in bits
+ * @m_offset: the multiplier value which encodes to 0 in the PLL's control
+ *            register
+ * @n_shift: the number of bits to shift the divider value by (ie. the
+ *           index of the lowest bit of the divider value in the PLL's
+ *           control register)
+ * @n_bits: the size of the divider field in bits
+ * @n_offset: the divider value which encodes to 0 in the PLL's control
+ *            register
+ * @od_shift: the number of bits to shift the post-VCO divider value by (ie.
+ *            the index of the lowest bit of the post-VCO divider value in
+ *            the PLL's control register)
+ * @od_bits: the size of the post-VCO divider field in bits
+ * @od_max: the maximum post-VCO divider value
+ * @od_encoding: a pointer to an array mapping post-VCO divider values to
+ *               their encoded values in the PLL control register, or -1 for
+ *               unsupported values
+ * @bypass_bit: the index of the bypass bit in the PLL control register
+ * @enable_bit: the index of the enable bit in the PLL control register
+ * @stable_bit: the index of the stable bit in the PLL control register
+ */
+struct jz47xx_cgu_pll_info {
+	unsigned reg;
+	unsigned m_shift, m_bits, m_offset;
+	unsigned n_shift, n_bits, n_offset;
+	unsigned od_shift, od_bits, od_max;
+	const s8 *od_encoding;
+	unsigned bypass_bit;
+	unsigned enable_bit;
+	unsigned stable_bit;
+};
+
+/**
+ * struct jz47xx_cgu_mux_info - information about a clock mux
+ * @reg: offset of the mux control register within the CGU
+ * @shift: number of bits to shift the mux value by (ie. the index of
+ *         the lowest bit of the mux value within its control register)
+ * @bits: the size of the mux value in bits
+ */
+struct jz47xx_cgu_mux_info {
+	unsigned reg;
+	unsigned shift:5;
+	unsigned bits:5;
+};
+
+/**
+ * struct jz47xx_cgu_div_info - information about a divider
+ * @reg: offset of the divider control register within the CGU
+ * @shift: number of bits to shift the divide value by (ie. the index of
+ *         the lowest bit of the divide value within its control register)
+ * @bits: the size of the divide value in bits
+ * @ce_bit: the index of the change enable bit within reg, or -1 is there
+ *          isn't one
+ * @busy_bit: the index of the busy bit within reg, or -1 is there isn't one
+ * @stop_bit: the index of the stop bit within reg, or -1 is there isn't one
+ */
+struct jz47xx_cgu_div_info {
+	unsigned reg;
+	unsigned shift:5;
+	unsigned bits:5;
+	int ce_bit:6;
+	int busy_bit:6;
+	int stop_bit:6;
+};
+
+/**
+ * struct jz47xx_cgu_custom_info - information about a custom (SoC) clock
+ */
+struct jz47xx_cgu_custom_info {
+	struct clk_ops *clk_ops;
+};
+
+/**
+ * struct jz47xx_cgu_clk_info - information about a clock
+ * @name: name of the clock
+ * @type: a bitmask formed from CGU_CLK_* values
+ * @parents: an array of the indices of potential parents of this clock
+ *           within the clock_info array of the CGU, or -1 in entries
+ *           which correspond to no valid parent
+ * @pll: information valid if type includes CGU_CLK_PLL
+ * @gate_bit: the index of the gate bit in the CLKGR* registers, valid if
+ *            type includes CGU_CLK_GATE
+ * @mux: information valid if type includes CGU_CLK_MUX
+ * @div: information valid if type includes CGU_CLK_DIV
+ */
+struct jz47xx_cgu_clk_info {
+	const char *name;
+
+	enum {
+		CGU_CLK_NONE		= 0,
+		CGU_CLK_EXT		= (1 << 0),
+		CGU_CLK_PLL		= (1 << 1),
+		CGU_CLK_GATE		= (1 << 2),
+		CGU_CLK_MUX		= (1 << 3),
+		CGU_CLK_MUX_GLITCHFREE	= (1 << 4),
+		CGU_CLK_DIV		= (1 << 5),
+		CGU_CLK_CUSTOM		= (1 << 6),
+	} type;
+
+	int parents[4];
+
+	union {
+		struct jz47xx_cgu_pll_info pll;
+
+		struct {
+			unsigned gate_bit;
+			struct jz47xx_cgu_mux_info mux;
+			struct jz47xx_cgu_div_info div;
+		};
+
+		struct jz47xx_cgu_custom_info custom;
+	};
+};
+
+/**
+ * struct jz47xx_cgu - data about the CGU
+ * @np: the device tree node that caused the CGU to be probed
+ * @base: the ioremap'ed base address of the CGU registers
+ * @clock_info: an array containing information about implemented clocks
+ * @clocks: used to provide clocks to DT, allows lookup of struct clk*
+ * @gate_lock: lock to be held whilst (un)gating a clock
+ * @divmux_lock: lock to be held whilst re-muxing of rate-changing a clock
+ */
+struct jz47xx_cgu {
+	struct device_node *np;
+	void __iomem *base;
+
+	const struct jz47xx_cgu_clk_info *clock_info;
+	struct clk_onecell_data clocks;
+
+	spinlock_t divmux_lock;		/* must be held when changing a divide
+					   or re-muxing a clock */
+	spinlock_t power_lock;		/* must be held when changing a power
+					   manager register */
+	spinlock_t pll_lock;		/* must be held when changing a PLL
+					   control register */
+};
+
+/**
+ * struct jz47xx_clk - private data for a clock
+ * @hw: see Documentation/clk.txt
+ * @cgu: a pointer to the CGU data
+ * @idx: the index of this clock in cgu->clock_info
+ */
+struct jz47xx_clk {
+	struct clk_hw hw;
+	struct jz47xx_cgu *cgu;
+	unsigned idx;
+};
+
+#define to_jz47xx_clk(_hw) container_of(_hw, struct jz47xx_clk, hw)
+
+/**
+ * jz47xx_cgu_new - create a new CGU instance
+ * @clock_info: an array of clock information structures describing the clocks
+ *              which are implemented by the CGU
+ * @num_clocks: the number of entries in clock_info
+ * @np: the device tree node which causes this CGU to be probed
+ *
+ * Returns an opaque pointer to the CGU instance if initialisation & clock
+ * registration is successful, otherwise NULL.
+ */
+struct jz47xx_cgu *jz47xx_cgu_new(const struct jz47xx_cgu_clk_info *clock_info,
+				  unsigned num_clocks,
+				  struct device_node *np);
+
+/**
+ * jz47xx_cgu_register_clocks - Registers the clocks
+ * @cgu: pointer to cgu data
+ *
+ * Returns 1 on success and -EINVAL if unsuccesful.
+ */
+int jz47xx_cgu_register_clocks(struct jz47xx_cgu *cgu);
+
+#endif /* __DRIVERS_CLK_JZ47XX_JZ47XX_CGU_H__ */
-- 
1.9.1
