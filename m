Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973642CAEB;
	Tue, 29 Sep 2026 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663770; cv=none; b=l22CJnqfN9wKwO2JBpdqkbeRXP419dWiX+6Y7XhoSMj8CYQA5js05GMhoQZ/PK8PsfEMLgsbE2akaFfERX2+rwkiwSOdge7St4S3s0Nl89MQ29Yg9maPJ4FIq+NHqAEynXUF9Xf4NMNu50EG3uUvSalnP0vsAwQY5zssNR7mmXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663770; c=relaxed/simple;
	bh=UFAJDXz68kUdJW58qiWVfUb6DvILZ81VNU0iRRb3INk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1FQFE/dRuOub4/WLukPxfO3+j2Ji6cXtuAxP5ctq1EjqI8cLuKSHWGm7p2PxVuqnraNvyV6AvzQecrRpljZW1OiXKEfrnnS+6WZtC7y83VQLUrkZht9QZ0O9spKhh2SAF5sMBdcUeZAmuGr54EWVQk/ct4RnRyCBZFT8kr7zVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwGDqSPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwGDqSPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CC81F00898;
	Tue, 29 Sep 2026 06:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663767;
	bh=qY78oJ6ymxVyIgLSPPb1jqMtWEmYH1IHZohiZpCP+ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PwGDqSPYHZOJorpXRsCcwYPHt9DnkZjD1ULL3B3aq7APz6haP6lRbxYok1F4pFYmu
	 7PpvBX7hMsHEz6GyKuPYQ+7szcr0NXzO1u13tSG9L2HkuBrfYyPEVwmKGlfed02atX
	 DmHFVDLd1JBnFYnHxHPizXu7hOHceU4U39TdsA6Slzc8JaQyTG5xskdwZE6jkD0Wf0
	 JfidUPib0V/9GxKsv+3aRJqbZ1IKfavCCpKnzzJTdnzXQo67LeHy8zoJI4hPjDiP8O
	 dv5+hghheZfx9+WBnj0kKTji+IYNWOQLEZwllODvPGr7mCK1nBPRzu5JrRAlpmq93y
	 kR67FZwX5IHdw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 16/20] clk: berlin: add Synaptics SL261X SoC clocks and plls
Date: Tue, 29 Sep 2026 14:14:13 +0800
Message-ID: <20260929061417.20733-17-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929061417.20733-1-jszhang@kernel.org>
References: <20260929061417.20733-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for clocks, plls in Synaptics SL261X SoCs.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/clk/Kconfig                |   1 +
 drivers/clk/berlin/Kconfig         |  25 ++
 drivers/clk/berlin/Makefile        |   4 +
 drivers/clk/berlin/sl-clk.c        | 279 +++++++++++++++++++++
 drivers/clk/berlin/sl-clk.h        |  31 +++
 drivers/clk/berlin/sl-sysmgr-clk.c | 250 +++++++++++++++++++
 drivers/clk/berlin/sl-sysmgr-clk.h |  44 ++++
 drivers/clk/berlin/sl261x-clks.c   | 385 +++++++++++++++++++++++++++++
 drivers/clk/berlin/sl261x-pll.c    | 145 +++++++++++
 drivers/clk/berlin/sl261x-pll.h    |  14 ++
 10 files changed, 1178 insertions(+)
 create mode 100644 drivers/clk/berlin/Kconfig
 create mode 100644 drivers/clk/berlin/sl-clk.c
 create mode 100644 drivers/clk/berlin/sl-clk.h
 create mode 100644 drivers/clk/berlin/sl-sysmgr-clk.c
 create mode 100644 drivers/clk/berlin/sl-sysmgr-clk.h
 create mode 100644 drivers/clk/berlin/sl261x-clks.c
 create mode 100644 drivers/clk/berlin/sl261x-pll.c
 create mode 100644 drivers/clk/berlin/sl261x-pll.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index f9592fd9ec2b..8052db52e28f 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -509,6 +509,7 @@ source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/aspeed/Kconfig"
 source "drivers/clk/bcm/Kconfig"
+source "drivers/clk/berlin/Kconfig"
 source "drivers/clk/cix/Kconfig"
 source "drivers/clk/eswin/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
diff --git a/drivers/clk/berlin/Kconfig b/drivers/clk/berlin/Kconfig
new file mode 100644
index 000000000000..2d5694cd29b7
--- /dev/null
+++ b/drivers/clk/berlin/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config SL_COMMON_CLK
+	bool
+
+config SL_SYSMGR_CLK
+	bool
+
+config SL261X_PLL
+	tristate "Synaptics SL261X PLL Driver"
+	depends on ARCH_BERLIN || COMPILE_TEST
+	default n
+	help
+	  This driver provides support for PLLs on Synaptics SL261X SoC.
+
+config SL261X_CLK
+	tristate "Synaptics SL261X Clock Driver"
+	depends on ARCH_BERLIN || COMPILE_TEST
+	select SL_COMMON_CLK
+	select SL_SYSMGR_CLK
+	default n
+	help
+	  This driver provides support for clock controller on Synaptics SL261X
+	  SoC. The clock controller generates and supplies clocks to various
+	  peripherals within the SoC.
diff --git a/drivers/clk/berlin/Makefile b/drivers/clk/berlin/Makefile
index 3733733a4806..2a664782d8a2 100644
--- a/drivers/clk/berlin/Makefile
+++ b/drivers/clk/berlin/Makefile
@@ -3,3 +3,7 @@ obj-y += berlin2-avpll.o berlin2-pll.o berlin2-div.o
 obj-$(CONFIG_MACH_BERLIN_BG2)	+= bg2.o
 obj-$(CONFIG_MACH_BERLIN_BG2CD)	+= bg2.o
 obj-$(CONFIG_MACH_BERLIN_BG2Q)	+= bg2q.o
+obj-$(CONFIG_SL_COMMON_CLK)	+= sl-clk.o
+obj-$(CONFIG_SL_SYSMGR_CLK)	+= sl-sysmgr-clk.o
+obj-$(CONFIG_SL261X_PLL)	+= sl261x-pll.o
+obj-$(CONFIG_SL261X_CLK)	+= sl261x-clks.o
diff --git a/drivers/clk/berlin/sl-clk.c b/drivers/clk/berlin/sl-clk.c
new file mode 100644
index 000000000000..e212320a0637
--- /dev/null
+++ b/drivers/clk/berlin/sl-clk.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Synaptics Incorporated
+ * Copyright (c) 2015 Marvell Technology Group Ltd.
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "sl-clk.h"
+
+#define SL_CLK_EN		BIT(0)
+#define SL_CLK_PLL_SEL		GENMASK(3, 1)
+#define SL_CLK_PLL_SWITCH	BIT(4)
+#define SL_CLK_DIV_SWITCH	BIT(5)
+#define SL_CLK_DIV3_SWITCH	BIT(6)
+#define SL_CLK_DIV_SEL		GENMASK(9, 7)
+#define SL_MAX_PARENTS	6
+
+struct sl_clk {
+	struct clk_hw hw;
+	void __iomem *reg;
+	spinlock_t *lock;
+	struct device *dev;
+};
+
+#define to_sl_clk(_hw) container_of(_hw, struct sl_clk, hw)
+
+static const unsigned int sl_clk_values[] = { 1, 2, 3, 4, 6, 8, 12 };
+
+static unsigned int sl_clk_value(u32 val)
+{
+	static const u8 div_table[] = { 0, 2, 4, 6, 8, 12, 0, 0 };
+
+	if (val & SL_CLK_DIV3_SWITCH)
+		return 3;
+	if (!(val & SL_CLK_DIV_SWITCH))
+		return 1;
+
+	return div_table[FIELD_GET(SL_CLK_DIV_SEL, val)];
+}
+
+static unsigned long sl_clk_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	unsigned int divisor = sl_clk_value(readl_relaxed(clk->reg));
+
+	if (WARN_ON_ONCE(!divisor))
+		return 0;
+
+	return parent_rate / divisor;
+}
+
+static unsigned int sl_clk_best(unsigned long parent_rate,
+				unsigned long rate)
+{
+	unsigned long best_diff = ULONG_MAX;
+	unsigned int best = 1, i;
+
+	for (i = 0; i < ARRAY_SIZE(sl_clk_values); i++) {
+		unsigned long candidate = parent_rate / sl_clk_values[i];
+		unsigned long diff = candidate > rate ? candidate - rate :
+							     rate - candidate;
+
+		if (diff < best_diff) {
+			best_diff = diff;
+			best = sl_clk_values[i];
+		}
+	}
+
+	return best;
+}
+
+static int sl_clk_determine_rate(struct clk_hw *hw,
+				 struct clk_rate_request *req)
+{
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+
+	if (!parent)
+		return -EINVAL;
+
+	req->best_parent_hw = parent;
+	req->best_parent_rate = clk_hw_get_rate(parent);
+	req->rate = req->best_parent_rate /
+		    sl_clk_best(req->best_parent_rate, req->rate);
+
+	return 0;
+}
+
+static int sl_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	unsigned int divisor, select;
+	unsigned long flags;
+	u32 val;
+
+	divisor = sl_clk_best(parent_rate, rate);
+	if (parent_rate / divisor != rate)
+		return -EINVAL;
+
+	spin_lock_irqsave(clk->lock, flags);
+	val = readl_relaxed(clk->reg);
+	val &= ~(SL_CLK_DIV3_SWITCH | SL_CLK_DIV_SWITCH |
+		 SL_CLK_DIV_SEL);
+	if (divisor == 3) {
+		val |= SL_CLK_DIV3_SWITCH;
+	} else if (divisor != 1) {
+		switch (divisor) {
+		case 2:
+			select = 1;
+			break;
+		case 4:
+			select = 2;
+			break;
+		case 6:
+			select = 3;
+			break;
+		case 8:
+			select = 4;
+			break;
+		case 12:
+			select = 5;
+			break;
+		default:
+			spin_unlock_irqrestore(clk->lock, flags);
+			return -EINVAL;
+		}
+		val |= SL_CLK_DIV_SWITCH |
+			FIELD_PREP(SL_CLK_DIV_SEL, select);
+	}
+	writel_relaxed(val, clk->reg);
+	spin_unlock_irqrestore(clk->lock, flags);
+
+	return 0;
+}
+
+static u8 sl_clk_get_parent(struct clk_hw *hw)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	u32 val = readl_relaxed(clk->reg);
+	u8 selector;
+	unsigned int index;
+
+	if (!(val & SL_CLK_PLL_SWITCH))
+		return 0;
+
+	selector = FIELD_GET(SL_CLK_PLL_SEL, val);
+	index = selector + 1;
+	if (index < clk_hw_get_num_parents(hw))
+		return index;
+
+	dev_warn(clk->dev, "%s: unsupported parent selector %u\n",
+		 clk_hw_get_name(hw), selector);
+	return 0;
+}
+
+static int sl_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	unsigned long flags;
+	u32 val;
+
+	if (index >= clk_hw_get_num_parents(hw) || index >= SL_MAX_PARENTS)
+		return -EINVAL;
+
+	spin_lock_irqsave(clk->lock, flags);
+	val = readl_relaxed(clk->reg);
+	if (!index) {
+		val &= ~SL_CLK_PLL_SWITCH;
+	} else {
+		val &= ~SL_CLK_PLL_SEL;
+		val |= SL_CLK_PLL_SWITCH |
+			FIELD_PREP(SL_CLK_PLL_SEL, index - 1);
+	}
+	writel_relaxed(val, clk->reg);
+	spin_unlock_irqrestore(clk->lock, flags);
+
+	return 0;
+}
+
+static int sl_clk_enable(struct clk_hw *hw)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(clk->lock, flags);
+	val = readl_relaxed(clk->reg);
+	writel_relaxed(val | SL_CLK_EN, clk->reg);
+	spin_unlock_irqrestore(clk->lock, flags);
+
+	return 0;
+}
+
+static void sl_clk_disable(struct clk_hw *hw)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(clk->lock, flags);
+	val = readl_relaxed(clk->reg);
+	writel_relaxed(val & ~SL_CLK_EN, clk->reg);
+	spin_unlock_irqrestore(clk->lock, flags);
+}
+
+static int sl_clk_is_enabled(struct clk_hw *hw)
+{
+	struct sl_clk *clk = to_sl_clk(hw);
+
+	return !!(readl_relaxed(clk->reg) & SL_CLK_EN);
+}
+
+static const struct clk_ops sl_clk_ops = {
+	.get_parent = sl_clk_get_parent,
+	.set_parent = sl_clk_set_parent,
+	.recalc_rate = sl_clk_recalc_rate,
+	.determine_rate = sl_clk_determine_rate,
+	.set_rate = sl_clk_set_rate,
+	.enable = sl_clk_enable,
+	.disable = sl_clk_disable,
+	.is_enabled = sl_clk_is_enabled,
+};
+
+struct clk_hw *sl_clk_register(struct device *dev, void __iomem *reg,
+			       const char *name, const char * const *parent_names,
+			       unsigned int num_parents, unsigned long flags,
+			       spinlock_t *lock)
+{
+	struct clk_init_data init = {};
+	struct sl_clk *clk;
+	unsigned int i;
+	int ret;
+
+	if (!dev || !reg || !name || !parent_names || !num_parents ||
+	    num_parents > SL_MAX_PARENTS || !lock)
+		return ERR_PTR(-EINVAL);
+
+	for (i = 0; i < num_parents; i++)
+		if (!parent_names[i])
+			return ERR_PTR(-EINVAL);
+
+	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	clk->dev = dev;
+	clk->reg = reg;
+	clk->lock = lock;
+
+	init.name = name;
+	init.ops = &sl_clk_ops;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.flags = flags;
+	clk->hw.init = &init;
+
+	ret = devm_clk_hw_register(dev, &clk->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &clk->hw;
+}
+EXPORT_SYMBOL_GPL(sl_clk_register);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Synaptics SL261x clock divider support");
diff --git a/drivers/clk/berlin/sl-clk.h b/drivers/clk/berlin/sl-clk.h
new file mode 100644
index 000000000000..7489b26a5e8d
--- /dev/null
+++ b/drivers/clk/berlin/sl-clk.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SL_CLK_H
+#define __SL_CLK_H
+
+#include <linux/compiler_types.h>
+#include <linux/spinlock_types.h>
+
+struct clk_hw;
+struct device;
+
+struct sl_clk_desc {
+	const char	*name;
+	u32		id;
+	u32		offset;
+	unsigned long	flags;
+};
+
+struct sl_gateclk_desc {
+	const char	*name;
+	const char	*parent_name;
+	u32		id;
+	u8		bit_idx;
+	unsigned long	flags;
+};
+
+struct clk_hw *sl_clk_register(struct device *dev, void __iomem *reg,
+			       const char *name, const char * const *parent_names,
+			       unsigned int num_parents, unsigned long flags,
+			       spinlock_t *lock);
+
+#endif /* __SL_CLK_H */
diff --git a/drivers/clk/berlin/sl-sysmgr-clk.c b/drivers/clk/berlin/sl-sysmgr-clk.c
new file mode 100644
index 000000000000..fba8c22ca830
--- /dev/null
+++ b/drivers/clk/berlin/sl-sysmgr-clk.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/version.h>
+
+#include "sl-sysmgr-clk.h"
+
+#define CLK_EN		BIT(0)
+#define DIV_CHNG_EN	BIT(1)
+
+struct sl_sysmgr_gateclk {
+	struct clk_hw hw;
+	void __iomem *base;
+	u8 bit_idx;
+};
+
+struct sl_sysmgr_clk {
+	struct clk_hw hw;
+	void __iomem *base;
+	u8 div_bits;
+};
+
+struct sl_sysmgr_clk_priv {
+	struct sl_sysmgr_gateclk *gclks;
+	struct sl_sysmgr_clk *clks;
+};
+
+static DEFINE_SPINLOCK(sl_sysmgr_gateclk_lock);
+
+#define to_sl_sysmgr_gateclk(hw)	container_of(hw, struct sl_sysmgr_gateclk, hw)
+#define to_sl_sysmgr_clk(hw)		container_of(hw, struct sl_sysmgr_clk, hw)
+
+static int sl_sysmgr_gateclk_enable(struct clk_hw *hw)
+{
+	u32 val;
+	struct sl_sysmgr_gateclk *clk = to_sl_sysmgr_gateclk(hw);
+
+	guard(spinlock)(&sl_sysmgr_gateclk_lock);
+
+	val = readl_relaxed(clk->base);
+	if (!(val & BIT(clk->bit_idx))) {
+		val |= BIT(clk->bit_idx);
+		writel_relaxed(val, clk->base);
+	}
+
+	return 0;
+}
+
+static int sl_sysmgr_gateclk_is_enabled(struct clk_hw *hw)
+{
+	u32 val;
+	struct sl_sysmgr_gateclk *clk = to_sl_sysmgr_gateclk(hw);
+
+	guard(spinlock)(&sl_sysmgr_gateclk_lock);
+
+	val = readl_relaxed(clk->base);
+	val &= BIT(clk->bit_idx);
+
+	return val ? 1 : 0;
+}
+
+static const struct clk_ops sl_sysmgr_gateclk_ops = {
+	.enable		= sl_sysmgr_gateclk_enable,
+	.is_enabled	= sl_sysmgr_gateclk_is_enabled,
+};
+
+static int
+sl_sysmgr_gateclk_register(struct device *dev, struct sl_sysmgr_gateclk *gclk,
+			   const char *name, const char *parent_names,
+			   u8 bit_idx, void __iomem *base)
+{
+	struct clk_init_data init;
+
+	init.name = name;
+	init.ops = &sl_sysmgr_gateclk_ops;
+	init.parent_names = &parent_names;
+	init.num_parents = 1;
+	init.flags = 0;
+
+	gclk->bit_idx = bit_idx;
+	gclk->base = base;
+	gclk->hw.init = &init;
+
+	return devm_clk_hw_register(dev, &gclk->hw);
+}
+
+static unsigned long
+sl_sysmgr_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	u32 val, div;
+	struct sl_sysmgr_clk *clk = to_sl_sysmgr_clk(hw);
+
+	val = readl_relaxed(clk->base);
+	div = (val >> 2) & ((1 << clk->div_bits) - 1);
+	++div;
+
+	return parent_rate / div;
+}
+
+static int sl_sysmgr_clk_enable(struct clk_hw *hw)
+{
+	u32 val;
+	struct sl_sysmgr_clk *clk = to_sl_sysmgr_clk(hw);
+
+	val = readl_relaxed(clk->base);
+	if (!(val & CLK_EN)) {
+		val |= CLK_EN;
+		writel_relaxed(val, clk->base);
+	}
+
+	return 0;
+}
+
+static int sl_sysmgr_clk_is_enabled(struct clk_hw *hw)
+{
+	u32 val;
+	struct sl_sysmgr_clk *clk = to_sl_sysmgr_clk(hw);
+
+	val = readl_relaxed(clk->base);
+	val &= CLK_EN;
+
+	return val ? 1 : 0;
+}
+
+static const struct clk_ops sl_sysmgr_clk_ops = {
+	.recalc_rate	= sl_sysmgr_clk_recalc_rate,
+	.enable		= sl_sysmgr_clk_enable,
+	.is_enabled	= sl_sysmgr_clk_is_enabled,
+};
+
+static int
+sl_sysmgr_clk_register(struct device *dev, struct sl_sysmgr_clk *sclk,
+		       const char *name, const char *parent_names,
+		       u8 div_bits, void __iomem *base)
+{
+	struct clk_init_data init;
+
+	init.name = name;
+	init.ops = &sl_sysmgr_clk_ops;
+	init.parent_names = &parent_names;
+	init.num_parents = 1;
+	init.flags = 0;
+
+	sclk->div_bits = div_bits;
+	sclk->base = base;
+	sclk->hw.init = &init;
+
+	return devm_clk_hw_register(dev, &sclk->hw);
+}
+
+static void sl_sysmgr_clk_put_node(void *data)
+{
+	of_node_put(data);
+}
+
+int sl_sysmgr_clk_setup(struct platform_device *pdev,
+			const struct sl_sysmgr_fixedclk_desc *fdescs,
+			int fclk_n,
+			const struct sl_sysmgr_gateclk_desc *gdescs,
+			int gclk_n,
+			u32 gclk_offset,
+			const struct sl_sysmgr_clk_desc *descs,
+			int clk_n)
+{
+	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
+	int i, ret, num = fclk_n + gclk_n + clk_n;
+	struct clk_hw_onecell_data *clk_data;
+	struct sl_sysmgr_clk_priv *priv;
+	struct clk_hw *clk_hw;
+	void __iomem *base;
+	u32 id;
+
+	ret = devm_add_action_or_reset(&pdev->dev, sl_sysmgr_clk_put_node, parent_np);
+	if (ret)
+		return ret;
+
+	clk_data = devm_kzalloc(&pdev->dev, struct_size(clk_data, hws, num), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+	clk_data->num = num;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->gclks = devm_kcalloc(&pdev->dev, gclk_n, sizeof(*priv->gclks), GFP_KERNEL);
+	if (!priv->gclks)
+		return -ENOMEM;
+
+	priv->clks = devm_kcalloc(&pdev->dev, clk_n, sizeof(*priv->clks), GFP_KERNEL);
+	if (!priv->clks)
+		return -ENOMEM;
+
+	base = devm_of_iomap(&pdev->dev, parent_np, 0, NULL);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	for (i = 0; i < fclk_n; i++) {
+		clk_hw = devm_clk_hw_register_fixed_rate(&pdev->dev, fdescs[i].name,
+							 NULL, 0,
+							 fdescs[i].rate);
+		if (IS_ERR(clk_hw))
+			return PTR_ERR(clk_hw);
+
+		id = fdescs[i].id;
+		clk_data->hws[id] = clk_hw;
+	}
+
+	for (i = 0; i < gclk_n; i++) {
+		ret = sl_sysmgr_gateclk_register(&pdev->dev, &priv->gclks[i],
+						 gdescs[i].name, gdescs[i].parent_name,
+						 gdescs[i].bit_idx, base + gclk_offset);
+		if (ret)
+			return ret;
+
+		id = gdescs[i].id;
+		clk_data->hws[id] = &priv->gclks[i].hw;
+	}
+
+	for (i = 0; i < clk_n; i++) {
+		ret = sl_sysmgr_clk_register(&pdev->dev, &priv->clks[i],
+					     descs[i].name, descs[i].parent_name,
+					     descs[i].div_bits, base + descs[i].offset);
+		if (ret)
+			return ret;
+
+		id = descs[i].id;
+		clk_data->hws[id] = &priv->clks[i].hw;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get, clk_data);
+}
+EXPORT_SYMBOL_GPL(sl_sysmgr_clk_setup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_DESCRIPTION("SysMgr domain clk driver for Synaptics SL SoCs");
diff --git a/drivers/clk/berlin/sl-sysmgr-clk.h b/drivers/clk/berlin/sl-sysmgr-clk.h
new file mode 100644
index 000000000000..5ccf388bcccb
--- /dev/null
+++ b/drivers/clk/berlin/sl-sysmgr-clk.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ *
+ */
+
+#ifndef __SL_SYSMGR_CLK_H
+#define __SL_SYSMGR_CLK_H
+
+struct sl_sysmgr_clk_desc {
+	const char	*name;
+	const char	*parent_name;
+	u32		id;
+	u32		offset;
+	u8		div_bits;
+	unsigned long	flags;
+};
+
+struct sl_sysmgr_gateclk_desc {
+	const char	*name;
+	const char	*parent_name;
+	u32		id;
+	u8		bit_idx;
+	unsigned long	flags;
+};
+
+struct sl_sysmgr_fixedclk_desc {
+	const char	*name;
+	u32		id;
+	unsigned long	rate;
+};
+
+int sl_sysmgr_clk_setup(struct platform_device *pdev,
+			const struct sl_sysmgr_fixedclk_desc *fdescs,
+			int fclk_n,
+			const struct sl_sysmgr_gateclk_desc *gdescs,
+			int gclk_n,
+			u32 gclk_offset,
+			const struct sl_sysmgr_clk_desc *descs,
+			int clk_n);
+
+#endif
diff --git a/drivers/clk/berlin/sl261x-clks.c b/drivers/clk/berlin/sl261x-clks.c
new file mode 100644
index 000000000000..d4e9cee7b685
--- /dev/null
+++ b/drivers/clk/berlin/sl261x-clks.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+
+#include <dt-bindings/clock/syna,sl261x.h>
+
+#include "sl261x-pll.h"
+#include "sl-clk.h"
+#include "sl-sysmgr-clk.h"
+
+#define REG_CLKENABLE		0x0420
+
+#define CLK_GATE_CTRL0		0x0600
+
+#define SYSPLL0_OFFSET		0x0200
+#define SYSPLL1_OFFSET		0x0220
+#define CPUPLL_OFFSET		0x2000
+#define APLL0_OFFSET		0x0008
+#define APLL1_OFFSET		0x0030
+
+static DEFINE_SPINLOCK(gate_lock);
+static DEFINE_SPINLOCK(lock);
+
+enum {
+	SYSPLL0_OUT, SYSPLL0_OUTF,
+	SYSPLL1_OUT, SYSPLL1_OUTF,
+	CPUPLL_OUT, CPUPLL_OUTF,
+	APLL0_OUT, APLL0_OUTF,
+	APLL1_OUT, APLL1_OUTF,
+};
+
+static const char *clk_names[] = {
+	[SYSPLL0_OUT]		= "syspll0_out",
+	[SYSPLL0_OUTF]		= "syspll0_outf",
+	[SYSPLL1_OUT]		= "syspll1_out",
+	[SYSPLL1_OUTF]		= "syspll1_outf",
+	[CPUPLL_OUT]		= "cpupll_out",
+	[CPUPLL_OUTF]		= "cpupll_outf",
+	[APLL0_OUT]		= "apll0_out",
+	[APLL0_OUTF]		= "apll0_outf",
+	[APLL1_OUT]		= "apll1_out",
+	[APLL1_OUTF]		= "apll1_outf",
+};
+
+static const struct sl_gateclk_desc sl261x_gates[] = {
+	{ "usb0coreclk",	"perifsysclk",	CLK_USB0CORE,		0 },
+	{ "sdiosysclk",		"perifsysclk",	CLK_SDIOSYS,		1 },
+	{ "emmcsysclk",		"perifsysclk",	CLK_EMMCSYS,		2 },
+	{ "gpuaxiclk",		"hpcclk",	CLK_GPUAXI,		3 },
+	{ "gethrgmiisysclk",	"perifsysclk",	CLK_GETHRGMIISYS,	4 },
+	{ "sdio1sysclk",	"perifsysclk",	CLK_SDIO1SYS,		5 },
+	{ "usb1coreclk",	"perifsysclk",	CLK_USB1CORE,		6 },
+	{ "gethrgmii1sysclk",	"perifsysclk",	CLK_GETHRGMII1SYS,	7 },
+	{ "usb0phyrefclk",	"perifsysclk",	CLK_USB0PHYREF,		8 },
+	{ "usb1phyrefclk",	"perifsysclk",	CLK_USB1PHYREF,		9 },
+	{ "apbuart0clk",	"apbcoreclk",	CLK_APBUART0,		10 },
+	{ "apbuart1clk",	"apbcoreclk",	CLK_APBUART1,		11 },
+	{ "apbuart2clk",	"apbcoreclk",	CLK_APBUART2,		12 },
+	{ "apbuart3lck",	"apbcoreclk",	CLK_APBUART3,		13 },
+	{ "apbi2c0clk",		"apbcoreclk",	CLK_APBI2C0,		14 },
+	{ "apbi2c1lck",		"apbcoreclk",	CLK_APBI2C1,		15 },
+	{ "apbspi0clk",		"apbcoreclk",	CLK_APBSPI0,		16 },
+	{ "apbspi1clk",		"apbcoreclk",	CLK_APBSPI1,		17 },
+	{ "apbspi2clk",		"apbcoreclk",	CLK_APBSPI2,		18 },
+	{ "apbspi3clk",		"apbcoreclk",	CLK_APBSPI3,		19 },
+	{ "apbgpioclk",		"apbcoreclk",	CLK_APBGPIO,		20 },
+	{ "apbtimersclk",	"apbcoreclk",	CLK_APBTIMERS,		21 },
+	{ "apbsyscntclk",	"apbcoreclk",	CLK_APBSYSCNT,		22 },
+	{ "apbwdtclk",		"apbcoreclk",	CLK_APBWDT,		23 },
+	{ "apbdmaclk",		"apbcoreclk",	CLK_APBDMA,		24 },
+};
+
+static const struct sl_clk_desc sl261x_descs[] = {
+	{ "cpufastrefclk",	CLK_CPUFASTREF,		0x440, CLK_IS_CRITICAL },
+	{ "memfastrefclk",	CLK_MEMFASTREF,		0x444, CLK_IS_CRITICAL },
+	{ "cfgclk",		CLK_CFG,		0x448, CLK_IS_CRITICAL },
+	{ "sysclk",		CLK_SYS,		0x44c, CLK_IS_CRITICAL },
+	{ "perifsysclk",	CLK_PERIFSYS,		0x450, CLK_IS_CRITICAL },
+	{ "apbcoreclk",		CLK_APBCORE,		0x454, CLK_IS_CRITICAL },
+	{ "apbserclk",		CLK_APBSER,		0x458, CLK_IS_CRITICAL },
+	{ "atbclk",		CLK_ATB,		0x45c },
+	{ "hpcclk",		CLK_HPC,		0x460, CLK_IS_CRITICAL },
+	{ "emmcclk",		CLK_EMMC,		0x464 },
+	{ "sd0clk",		CLK_SD0,		0x468 },
+	{ "sd1clk",		CLK_SD1,		0x46c },
+	{ "gethrgmiiclk",	CLK_GETHRGMII,		0x470 },
+	{ "gethrgmii1clk",	CLK_GETHRGMII1,		0x474 },
+	{ "ge0_ptp_refclk",	CLK_GE0_PTP_REF,	0x478 },
+	{ "ge1_ptp_refclk",	CLK_GE1_PTP_REF,	0x47c },
+	{ "usb2testclk",	CLK_USB2TEST,		0x480 },
+	{ "usb2test480mg0clk",	CLK_USB2TEST480MG0,	0x484 },
+	{ "usb2test480mg1clk",	CLK_USB2TEST480MG1,	0x488 },
+	{ "usb2test480mg2clk",	CLK_USB2TEST480MG2,	0x48c },
+	{ "usb2test100mg0clk",	CLK_USB2TEST100MG0,	0x490 },
+	{ "usb2test100mg1clk",	CLK_USB2TEST100MG1,	0x494 },
+	{ "usb2test100mg2clk",	CLK_USB2TEST100MG2,	0x498 },
+	{ "usb2test100mg3clk",	CLK_USB2TEST100MG3,	0x49c },
+	{ "periftest125mg0clk",	CLK_PERIFTEST125MG0,	0x4a0 },
+	{ "periftest200mg0clk",	CLK_PERIFTEST200MG0,	0x4a4 },
+	{ "periftest200mg1clk",	CLK_PERIFTEST200MG1,	0x4a8 },
+	{ "gpuclk",		CLK_GPU,		0x4ac },
+	{ "npuclk",		CLK_NPU,		0x4b0 },
+	{ "aviosysclk",		CLK_AVIOSYS,		0x4b4, CLK_IS_CRITICAL },
+	{ "aiosysclk",		CLK_AIOSYS,		0x4b8, CLK_IS_CRITICAL },
+	{ "avio_lcdc2scanclk",	CLK_AVIO_LCDC2SCAN,	0x4bc },
+	{ "avio_ipiclk",	CLK_AVIO_IPI,		0x4c0 },
+	{ "avio_pclk",		CLK_AVIO_P,		0x4c4 },
+	{ "avio_dphyrxtxescclk", CLK_AVIO_DPHYRXTXESC,	0x4c8 },
+	{ "aviofpllclk",	CLK_AVIOFPLL,		0x4cc },
+	{ "avio_rx_scanbyteclk", CLK_AVIO_RX_SCANBYTE,	0x4d0 },
+	{ "avio_rx_scantestclk", CLK_AVIO_RX_SCANTEST,	0x4d4 },
+};
+
+static const char *default_parent_names[] = {
+	"syspll0_out",
+	"apll0_out",
+	"syspll0_outf",
+	"apll0_outf",
+	"syspll1_out",
+	"syspll1_outf",
+};
+
+static const char *ge_ptp_refclk_parent_names[] = {
+	"osc",
+	"apll0_outf",
+	"syspll1_out",
+	"syspll0_out",
+	"clk_mcu_axi",
+};
+
+static int sl261x_soc_clk_setup(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *parent_np = of_get_parent(np);
+	struct clk_hw_onecell_data *clk_data;
+	const char **parent_names;
+	int num_parents;
+	void __iomem *base;
+	struct clk_hw **hws;
+	int n, ret;
+	u32 id;
+
+	base = devm_of_iomap(dev, parent_np, 0, NULL);
+	of_node_put(parent_np);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, SL261X_CLK_MAX), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+	clk_data->num = SL261X_CLK_MAX;
+	hws = clk_data->hws;
+
+	/* sysplls */
+	ret = sl261x_pll_register(dev, base + SYSPLL0_OFFSET,
+				  clk_names[SYSPLL0_OUT], clk_names[SYSPLL0_OUTF]);
+	if (ret)
+		return ret;
+	ret = sl261x_pll_register(dev, base + SYSPLL1_OFFSET,
+				  clk_names[SYSPLL1_OUT], clk_names[SYSPLL1_OUTF]);
+	if (ret)
+		return ret;
+
+	/* normal clocks */
+	for (n = 0; n < ARRAY_SIZE(sl261x_descs); n++) {
+		const struct sl_clk_desc *cd = &sl261x_descs[n];
+
+		id = cd->id;
+		if (id == CLK_GE0_PTP_REF || id == CLK_GE1_PTP_REF) {
+			parent_names = ge_ptp_refclk_parent_names;
+			num_parents = ARRAY_SIZE(ge_ptp_refclk_parent_names);
+		} else {
+			parent_names = default_parent_names;
+			num_parents = ARRAY_SIZE(default_parent_names);
+		}
+		hws[id] = sl_clk_register(dev, base + cd->offset, cd->name,
+					  parent_names, num_parents, cd->flags, &lock);
+		if (IS_ERR(hws[id]))
+			return PTR_ERR(hws[id]);
+	}
+
+	/* gate clocks */
+	for (n = 0; n < ARRAY_SIZE(sl261x_gates); n++) {
+		const struct sl_gateclk_desc *gd = &sl261x_gates[n];
+
+		id = gd->id;
+		hws[id] = devm_clk_hw_register_gate(dev, gd->name, gd->parent_name,
+						    gd->flags, base + REG_CLKENABLE,
+						    gd->bit_idx, 0, &gate_lock);
+		if (IS_ERR(hws[id]))
+			return PTR_ERR(hws[id]);
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+}
+
+static int sl261x_cpu_clk_setup(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *parent_np = of_get_parent(np);
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **hws;
+	void __iomem *base;
+	int ret;
+
+	base = devm_of_iomap(dev, parent_np, 0, NULL);
+	of_node_put(parent_np);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, SL261X_CPU_CLK_MAX), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+	clk_data->num = SL261X_CPU_CLK_MAX;
+	hws = clk_data->hws;
+
+	/* cpupll */
+	ret = sl261x_pll_register(dev, base + CPUPLL_OFFSET,
+				  clk_names[CPUPLL_OUT], clk_names[CPUPLL_OUTF]);
+	if (ret)
+		return ret;
+
+	/* TODO: support cpupll bypass */
+	hws[CLK_CPU0] =
+		devm_clk_hw_register_fixed_factor(dev, "cpu0", clk_names[CPUPLL_OUTF], 0, 1, 1);
+	if (IS_ERR(hws[CLK_CPU0]))
+		return PTR_ERR(hws[CLK_CPU0]);
+	hws[CLK_CPU1] =
+		devm_clk_hw_register_fixed_factor(dev, "cpu1", clk_names[CPUPLL_OUTF], 0, 1, 1);
+	if (IS_ERR(hws[CLK_CPU1]))
+		return PTR_ERR(hws[CLK_CPU1]);
+	hws[CLK_DSU] =
+		devm_clk_hw_register_fixed_factor(dev, "dsu", clk_names[CPUPLL_OUT], 0, 1, 1);
+	if (IS_ERR(hws[CLK_DSU]))
+		return PTR_ERR(hws[CLK_DSU]);
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+}
+
+static int sl261x_aio_clk_setup(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *parent_np = of_get_parent(np);
+	void __iomem *base;
+	int ret;
+
+	base = devm_of_iomap(dev, parent_np, 0, NULL);
+	of_node_put(parent_np);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	/* aplls */
+	ret = sl261x_pll_register(dev, base + APLL0_OFFSET,
+				  clk_names[APLL0_OUT], clk_names[APLL0_OUTF]);
+	if (ret)
+		return ret;
+	ret = sl261x_pll_register(dev, base + APLL1_OFFSET,
+				  clk_names[APLL1_OUT], clk_names[APLL1_OUTF]);
+	if (ret)
+		return ret;
+
+	/* TODO aio clks */
+
+	return 0;
+}
+
+static const struct sl_sysmgr_fixedclk_desc sl261x_sysmgr_fixeds[] = {
+	{ "clk_mcu_ref",	CLK_MCU_REF,	25000000 },
+	{ "clk_mcu_pll",	CLK_MCU_PLL,	400000000 },
+	{ "clk_mcu_io_pll",	CLK_MCU_IO_PLL,	300000000 },
+	{ "clk_mcu_apb",	CLK_MCU_APB,	100000000 },
+	{ "clk_mcu_axi",	CLK_MCU_AXI,	200000000 },
+};
+
+static const struct sl_sysmgr_gateclk_desc sl261x_sysmgr_gates[] = {
+	{ "clk_cfg_uart0",	"clk_mcu_apb",	CLK_CFG_UART0,	0 },
+	{ "clk_ser_uart0",	"clk_mcu_ref",	CLK_SER_UART0,	1 },
+	{ "clk_cfg_uart1",	"clk_mcu_apb",	CLK_CFG_UART1,	2 },
+	{ "clk_cfg_uart2",	"clk_mcu_apb",	CLK_CFG_UART2,	3 },
+	{ "clk_cfg_uart3",	"clk_mcu_apb",	CLK_CFG_UART3,	4 },
+	{ "clk_cfg_gpio",	"clk_mcu_apb",	CLK_CFG_GPIO,	5 },
+	{ "clk_cfg_i2cm0",	"clk_mcu_apb",	CLK_CFG_I2CM0,	6 },
+	{ "clk_cfg_i2cm1",	"clk_mcu_apb",	CLK_CFG_I2CM1,	7 },
+	{ "clk_cfg_spim",	"clk_mcu_apb",	CLK_CFG_SPIM,	8 },
+	{ "clk_cfg_spis",	"clk_mcu_apb",	CLK_CFG_SPIS,	9 },
+	{ "clk_cfg_i3c",	"clk_mcu_apb",	CLK_CFG_I3C,	10 },
+	{ "clk_cfg_xspi",	"clk_mcu_apb",	CLK_CFG_XSPI,	11 },
+	{ "clk_axi_xspi",	"clk_mcu_axi",	CLK_AXI_XSPI,	12 },
+	{ "clk_cfg_pvt",	"clk_mcu_apb",	CLK_CFG_PVT,	13 },
+	{ "clk_cfg_adc",	"clk_mcu_apb",	CLK_CFG_ADC,	14 },
+	{ "clk_cfg_pwm",	"clk_mcu_apb",	CLK_CFG_PWM,	15 },
+	{ "clk_bus_can0",	"clk_mcu_axi",	CLK_BUS_CAN0,	16 },
+	{ "clk_bus_can1",	"clk_mcu_axi",	CLK_BUS_CAN1,	17 },
+	{ "clk_cfg_pdm",	"clk_mcu_apb",	CLK_CFG_PDM,	18 },
+};
+
+static const struct sl_sysmgr_clk_desc sl261x_sysmgr_clks[] = {
+	{ "clk_ser_uart1",	"clk_mcu_pll",	CLK_SER_UART1,	0x604,	4 },
+	{ "clk_ser_uart2",	"clk_mcu_pll",	CLK_SER_UART2,	0x608,	4 },
+	{ "clk_ser_uart3",	"clk_mcu_pll",	CLK_SER_UART3,	0x60c,	4 },
+	{ "clk_deb_gpio",	"clk_mcu_pll",	CLK_DEB_GPIO,	0x610,	4 },
+	{ "clk_ser_i2cm0",	"clk_mcu_pll",	CLK_SER_I2CM0,	0x614,	4 },
+	{ "clk_ser_i2cm1",	"clk_mcu_pll",	CLK_SER_I2CM1,	0x618,	4 },
+	{ "clk_ser_spim",	"clk_mcu_pll",	CLK_SER_SPIM,	0x61c,	4 },
+	{ "clk_ser_spis",	"clk_mcu_pll",	CLK_SER_SPIS,	0x620,	4 },
+	{ "clk_ser_i3c",	"clk_mcu_pll",	CLK_SER_I3C,	0x624,	4 },
+	{ "clk_ser_xspi",	"clk_mcu_io_pll", CLK_SER_XSPI,	0x628,	4 },
+	{ "clk_hs_pvt",		"clk_mcu_pll",	CLK_HS_PVT,	0x62c,	4 },
+	{ "clk_core_adc",	"clk_mcu_pll",	CLK_CORE_ADC,	0x630,	8 },
+	{ "clk_ser_pwm",	"clk_mcu_pll",	CLK_SER_PWM,	0x634,	4 },
+	{ "clk_ser_can0",	"clk_mcu_pll",	CLK_SER_CAN0,	0x638,	4 },
+	{ "clk_ser_can1",	"clk_mcu_pll",	CLK_SER_CAN1,	0x63c,	4 },
+	{ "clk_ser_pdm",	"clk_mcu_pll",	CLK_SER_PDM,	0x640,	8 },
+	{ "clk_ref_calib",	"clk_mcu_pll",	CLK_REF_CALIB,	0x644,	8 },
+};
+
+static int sl261x_sysmgr_clk_setup(struct platform_device *pdev)
+{
+	return sl_sysmgr_clk_setup(pdev, sl261x_sysmgr_fixeds, ARRAY_SIZE(sl261x_sysmgr_fixeds),
+				   sl261x_sysmgr_gates, ARRAY_SIZE(sl261x_sysmgr_gates),
+				   CLK_GATE_CTRL0,
+				   sl261x_sysmgr_clks, ARRAY_SIZE(sl261x_sysmgr_clks));
+}
+
+static const struct of_device_id sl261x_clks_match_table[] = {
+	{
+		.compatible = "syna,sl261x-soc-clk",
+		.data = sl261x_soc_clk_setup,
+	},
+	{
+		.compatible = "syna,sl261x-cpu-clk",
+		.data = sl261x_cpu_clk_setup,
+	},
+	{
+		.compatible = "syna,sl261x-aio-clk",
+		.data = sl261x_aio_clk_setup,
+	},
+	{
+		.compatible = "syna,sl261x-system-clk",
+		.data = sl261x_sysmgr_clk_setup,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sl261x_clks_match_table);
+
+static int sl261x_clks_probe(struct platform_device *pdev)
+{
+	int (*clk_setup)(struct platform_device *pdev);
+	int ret;
+
+	clk_setup = of_device_get_match_data(&pdev->dev);
+	if (!clk_setup)
+		return -ENODEV;
+
+	ret = clk_setup(pdev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver sl261x_clks_driver = {
+	.probe		= sl261x_clks_probe,
+	.driver		= {
+		.name	= "syna-sl261x-clks",
+		.of_match_table = sl261x_clks_match_table,
+	},
+};
+module_platform_driver(sl261x_clks_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_DESCRIPTION("Synaptics sl261x clks Driver");
diff --git a/drivers/clk/berlin/sl261x-pll.c b/drivers/clk/berlin/sl261x-pll.c
new file mode 100644
index 000000000000..ce19a6043da1
--- /dev/null
+++ b/drivers/clk/berlin/sl261x-pll.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2021 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_clk.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "sl261x-pll.h"
+
+#define FRAC_BITS		24
+
+#define CTRLC			0x08
+#define DIVR_MASK		GENMASK(8, 0)
+#define CTRLD			0x0c
+#define DIVF_MASK		GENMASK(8, 0)
+#define CTRLE			0x10
+#define DIVFF_MASK		GENMASK(23, 0)
+#define CTRLF			0x14
+#define DIVQ_MASK		GENMASK(4, 0)
+#define CTRLG			0x18
+#define DIVQF_MASK		GENMASK(2, 0)
+
+#define SL261X_APLL
+struct sl261x_pll {
+	void __iomem *ctrl;
+	struct clk_hw pllout;
+	struct clk_hw plloutf;
+};
+
+#define to_pllout(_hw) container_of(_hw, struct sl261x_pll, pllout)
+#define to_plloutf(_hw) container_of(_hw, struct sl261x_pll, plloutf)
+
+static unsigned long sl261x_pll_recalc_rate(struct sl261x_pll *pll,
+					    unsigned long parent_rate, bool fractional_output)
+{
+	u32 dm, dn, frac, dp;
+	u64 rate;
+
+	dm = (readl_relaxed(pll->ctrl + CTRLC) & DIVR_MASK) + 1;
+	dn = (readl_relaxed(pll->ctrl + CTRLD) & DIVF_MASK) + 1;
+	frac = readl_relaxed(pll->ctrl + CTRLE) & DIVFF_MASK;
+
+	if (fractional_output)
+		dp = (readl_relaxed(pll->ctrl + CTRLG) & DIVQF_MASK) + 1;
+	else
+		dp = ((readl_relaxed(pll->ctrl + CTRLF) & DIVQ_MASK) + 1) * 2;
+
+	rate = (u64)parent_rate * dn;
+	rate += ((u64)parent_rate * frac + BIT_ULL(FRAC_BITS - 1)) >> FRAC_BITS;
+	rate = DIV_ROUND_CLOSEST_ULL(rate * 4, dm * dp);
+
+	return rate;
+}
+
+static unsigned long sl261x_pllout_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	return sl261x_pll_recalc_rate(to_pllout(hw), parent_rate, false);
+}
+
+static unsigned long sl261x_plloutf_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	return sl261x_pll_recalc_rate(to_plloutf(hw), parent_rate, true);
+}
+
+static const struct clk_ops sl261x_pllout_ops = {
+	.recalc_rate = sl261x_pllout_recalc_rate,
+};
+
+static const struct clk_ops sl261x_plloutf_ops = {
+	.recalc_rate = sl261x_plloutf_recalc_rate,
+};
+
+static void sl261x_pll_put_clk(void *data)
+{
+	clk_put(data);
+}
+
+int sl261x_pll_register(struct device *dev, void __iomem *ctrl,
+			const char *out, const char *outf)
+{
+	struct device_node *np = dev->of_node;
+	struct clk_parent_data parent = {};
+	struct clk_init_data init = {};
+	struct sl261x_pll *pll;
+	struct clk *input;
+	int ret;
+
+	if (!dev || !ctrl || !out || !outf)
+		return -EINVAL;
+
+	input = of_clk_get(np, 0);
+	if (IS_ERR(input))
+		return dev_err_probe(dev, PTR_ERR(input),
+				     "failed to get PLL reference clock\n");
+	parent.hw = __clk_get_hw(input);
+	ret = devm_add_action_or_reset(dev, sl261x_pll_put_clk, input);
+	if (ret)
+		return ret;
+
+	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return -ENOMEM;
+	pll->ctrl = ctrl;
+
+	init.name = out;
+	init.ops = &sl261x_pllout_ops;
+	init.parent_data = &parent;
+	init.num_parents = 1;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	pll->pllout.init = &init;
+
+	ret = devm_clk_hw_register(dev, &pll->pllout);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register pllout\n");
+
+	init.name = outf;
+	init.ops = &sl261x_plloutf_ops;
+	pll->plloutf.init = &init;
+
+	ret = devm_clk_hw_register(dev, &pll->plloutf);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register plloutf\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sl261x_pll_register);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Synaptics SL261x PLL clock driver");
diff --git a/drivers/clk/berlin/sl261x-pll.h b/drivers/clk/berlin/sl261x-pll.h
new file mode 100644
index 000000000000..70788661ff60
--- /dev/null
+++ b/drivers/clk/berlin/sl261x-pll.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SL261X_PLL_H
+#define __SL261X_PLL_H
+
+#include <linux/io.h>
+
+struct clk_hw_onecell_data;
+struct device;
+struct device_node;
+
+int sl261x_pll_register(struct device *dev, void __iomem *ctrl,
+			const char *out, const char *outf);
+
+#endif /* __SL261X_PLL_H */
-- 
2.53.0

