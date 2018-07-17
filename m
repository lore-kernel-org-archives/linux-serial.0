From: Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v5 08/11] clk: mediatek: fix pll setting
Date: Tue, 17 Jul 2018 16:52:29 +0800
Message-ID: <1531817552-17221-9-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Stephen Boyd <sboyd@kernel.org>, Sean Wang <sean.wang@mediatek.com>
Cc: CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Owen Chen <owen.chen@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Owen Chen <owen.chen@mediatek.com>

1. pcwibits: The integer bits of pcw for plls is extend to 8 bits,
   add a variable to indicate this change and
   backward-compatible.
2. fmin: The pll freqency lower-bound is vary from 1GMhz to
   1.5Ghz, add a variable to indicate platform-dependent.

Signed-off-by: Owen Chen <owen.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.h |    2 ++
 drivers/clk/mediatek/clk-pll.c |   45 ++++++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f83c2bb..1882221 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -215,7 +215,9 @@ struct mtk_pll_data {
 	const struct clk_ops *ops;
 	u32 rst_bar_mask;
 	unsigned long fmax;
+	unsigned long fmin;
 	int pcwbits;
+	int pcwibits;
 	uint32_t pcw_reg;
 	int pcw_shift;
 	const struct mtk_pll_div_table *div_table;
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index f54e401..df571e5 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -27,7 +27,7 @@
 #define CON0_BASE_EN		BIT(0)
 #define CON0_PWR_ON		BIT(0)
 #define CON0_ISO_EN		BIT(1)
-#define CON0_PCW_CHG		BIT(31)
+#define CON1_PCW_CHG		BIT(31)
 
 #define AUDPLL_TUNER_EN		BIT(31)
 
@@ -69,11 +69,13 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
 {
 	int pcwbits = pll->data->pcwbits;
 	int pcwfbits;
+	int ibits;
 	u64 vco;
 	u8 c = 0;
 
 	/* The fractional part of the PLL divider. */
-	pcwfbits = pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
+	ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
+	pcwfbits = pcwbits > ibits ? pcwbits - ibits : 0;
 
 	vco = (u64)fin * pcw;
 
@@ -93,9 +95,31 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 {
 	u32 con1, val;
 	int pll_en;
+	u32 tuner_en = 0;
+	u32 tuner_en_mask;
+	void __iomem *tuner_en_addr = NULL;
 
 	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
 
+	/* disable tuner */
+	if (pll->tuner_en_addr) {
+		tuner_en_addr = pll->tuner_en_addr;
+		tuner_en_mask = BIT(pll->data->tuner_en_bit);
+	} else if (pll->tuner_addr) {
+		tuner_en_addr = pll->tuner_addr;
+		tuner_en_mask = AUDPLL_TUNER_EN;
+	}
+
+	if (tuner_en_addr) {
+		val = readl(tuner_en_addr);
+		tuner_en = val & tuner_en_mask;
+
+		if (tuner_en) {
+			val &= ~tuner_en_mask;
+			writel(val, tuner_en_addr);
+		}
+	}
+
 	/* set postdiv */
 	val = readl(pll->pd_addr);
 	val &= ~(POSTDIV_MASK << pll->data->pd_shift);
@@ -116,12 +140,20 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 	con1 = readl(pll->base_addr + REG_CON1);
 
 	if (pll_en)
-		con1 |= CON0_PCW_CHG;
+		con1 |= CON1_PCW_CHG;
 
 	writel(con1, pll->base_addr + REG_CON1);
+
 	if (pll->tuner_addr)
 		writel(con1 + 1, pll->tuner_addr);
 
+	/* restore tuner_en */
+	if (tuner_en_addr && tuner_en) {
+		val = readl(tuner_en_addr);
+		val |= tuner_en_mask;
+		writel(val, tuner_en_addr);
+	}
+
 	if (pll_en)
 		udelay(20);
 }
@@ -138,9 +170,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
 		u32 freq, u32 fin)
 {
-	unsigned long fmin = 1000 * MHZ;
+	unsigned long fmin = pll->data->fmin ? pll->data->fmin : 1000 * MHZ;
 	const struct mtk_pll_div_table *div_table = pll->data->div_table;
 	u64 _pcw;
+	int ibits;
 	u32 val;
 
 	if (freq > pll->data->fmax)
@@ -164,7 +197,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
 	}
 
 	/* _pcw = freq * postdiv / fin * 2^pcwfbits */
-	_pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
+	ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
+	_pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);
 	do_div(_pcw, fin);
 
 	*pcw = (u32)_pcw;
@@ -192,7 +226,6 @@ static unsigned long mtk_pll_recalc_rate(struct clk_hw *hw,
 
 	postdiv = (readl(pll->pd_addr) >> pll->data->pd_shift) & POSTDIV_MASK;
 	postdiv = 1 << postdiv;
-
 	pcw = readl(pll->pcw_addr) >> pll->data->pcw_shift;
 	pcw &= GENMASK(pll->data->pcwbits - 1, 0);
 
-- 
1.7.9.5
