From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in
 console
Date: Sat, 13 Feb 2016 11:01:20 +0100 (CET)
Message-ID: <470852136.382408.76a8faee-9235-4ee0-9fd1-e25a1e9f0bb3.open-xchange@email.1und1.de>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org>
 <56BC895E.2010108@sperl.org>
 <1617009200.323700.219000a8-c162-4594-aacc-a7e9894518b2.open-xchange@email.1und1.de>
 <662D2FB2-B088-4CFC-8416-A4F35BBAD7DD@sperl.org>
 <F7A2533A-D64C-4187-ABD4-416C446D1637@martin.sperl.org>
 <6CD3FC59-BA17-43D9-897C-A2D122D26EF8@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <6CD3FC59-BA17-43D9-897C-A2D122D26EF8@martin.sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: Martin Sperl <kernel@martin.sperl.org>
Cc: linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Martin,

> Martin Sperl <kernel@martin.sperl.org> hat am 12. Februar 2016 um 20:44
> geschrieben:
>
> So the issue is triggered as soon as the plld_per
> pll divider gets disabled/reenabled.
>
> This happens because the clk_hw.core.prepare_count
> drops down to 0 and then unprepare is called.
>
> So we need to increase the ref-count for the pll
> and pll_dividers to at least 1 so that these never
> get disabled - at least for now until we can come
> up with a better contract with the firmware.
>
> Obviously this may impact other drivers as well
> where a pll is used for the first time - if nothing
> else uses it and the clock gets released, then
> the clock would trigger a unprepare of the whole
> branch of the clock tree.
>
> The question is: how can we solve it in an acceptable
> manner?
>
> Do we need a driver that just holds a reference to
> those clocks? Or should we just prepare the clock
> after registering it in clk-bcm2835.c?
>
> As for why does this not show up when compiled in?
> It seems that in that case the amba_pl011 driver
> never gets removed and then probed again.
>
> This is possibly related to the optional use of DMA,
> with the amba-pl011 driver that retries the install,
> which is not supported on the bcm2835 - at least that
> is what the datasheet says. And DMA is (probably) not
> enabled during the early boot stages, so it does not
> fail once when it tries to register DMA.
>
> Thanks,
> Martin
>

i think i must correct myself. The fixed apb should stay since there is no
dynamic replacement and a proper disabling of plld shouldn't cause this freeze.

I have the suspicion the freeze is caused by a clock glitch or lock-up.

Could you please revert your changes and apply the attached patch? Maybe we can
see more.

------------------------------8<-----------------------------------------
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 637f8ae..03d95c1 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -364,6 +364,7 @@ struct bcm2835_cprman {
 	void __iomem *regs;
 	spinlock_t regs_lock;
 	const char *osc_name;
+	int func_code;
 
 	struct clk_onecell_data onecell;
 	struct clk *clks[];
@@ -1222,8 +1223,13 @@ static void bcm2835_pll_off(struct clk_hw *hw)
 	struct bcm2835_cprman *cprman = pll->cprman;
 	const struct bcm2835_pll_data *data = pll->data;
 
+	if (!(cprman_read(cprman, CM_LOCK) & data->lock_mask))
+		pr_warn("%s: PLL still locked from %d\n", __func__, cprman->func_code);
+
 	cprman_write(cprman, data->cm_ctrl_reg, CM_PLL_ANARST);
 	cprman_write(cprman, data->a2w_ctrl_reg, A2W_PLL_CTRL_PWRDN);
+
+	cprman->func_code = 1;
 }
 
 static int bcm2835_pll_on(struct clk_hw *hw)
@@ -1233,10 +1239,15 @@ static int bcm2835_pll_on(struct clk_hw *hw)
 	const struct bcm2835_pll_data *data = pll->data;
 	ktime_t timeout;
 
+	if (!(cprman_read(cprman, CM_LOCK) & data->lock_mask))
+		pr_warn("%s: PLL still locked from %d\n", __func__, cprman->func_code);
+
 	/* Take the PLL out of reset. */
 	cprman_write(cprman, data->cm_ctrl_reg,
 		     cprman_read(cprman, data->cm_ctrl_reg) & ~CM_PLL_ANARST);
 
+	cprman->func_code = 2;
+
 	/* Wait for the PLL to lock. */
 	timeout = ktime_add_ns(ktime_get(), LOCK_TIMEOUT_NS);
 	while (!(cprman_read(cprman, CM_LOCK) & data->lock_mask)) {
@@ -1267,6 +1278,8 @@ bcm2835_pll_write_ana(struct bcm2835_cprman *cprman, u32
ana_reg_base, u32 *ana)
 	 */
 	for (i = 3; i >= 0; i--)
 		cprman_write(cprman, ana_reg_base + i * 4, ana[i]);
+
+	cprman->func_code = 3;
 }
 
 static int bcm2835_pll_set_rate(struct clk_hw *hw,
@@ -1339,6 +1352,8 @@ static int bcm2835_pll_set_rate(struct clk_hw *hw,
 	if (!do_ana_setup_first)
 		bcm2835_pll_write_ana(cprman, data->ana_reg_base, ana);
 
+	cprman->func_code = 4;
+
 	return 0;
 }
 
@@ -1404,6 +1419,8 @@ static void bcm2835_pll_divider_off(struct clk_hw *hw)
 		     (cprman_read(cprman, data->cm_reg) &
 		      ~data->load_mask) | data->hold_mask);
 	cprman_write(cprman, data->a2w_reg, A2W_PLL_CHANNEL_DISABLE);
+
+	cprman->func_code = 5;
 }
 
 static int bcm2835_pll_divider_on(struct clk_hw *hw)
@@ -1419,6 +1436,8 @@ static int bcm2835_pll_divider_on(struct clk_hw *hw)
 	cprman_write(cprman, data->cm_reg,
 		     cprman_read(cprman, data->cm_reg) & ~data->hold_mask);
 
+	cprman->func_code = 6;
+
 	return 0;
 }
 
@@ -1440,6 +1459,8 @@ static int bcm2835_pll_divider_set_rate(struct clk_hw *hw,
 	cprman_write(cprman, data->cm_reg, cm | data->load_mask);
 	cprman_write(cprman, data->cm_reg, cm & ~data->load_mask);
 
+	cprman->func_code = 7;
+
 	return 0;
 }
 
@@ -1588,7 +1609,7 @@ static void bcm2835_clock_wait_busy(struct bcm2835_clock
*clock)
 
 	while (cprman_read(cprman, data->ctl_reg) & CM_BUSY) {
 		if (ktime_after(ktime_get(), timeout)) {
-			dev_err(cprman->dev, "%s: couldn't lock PLL\n",
+			dev_err(cprman->dev, "%s: clk busy timeout\n",
 				clk_hw_get_name(&clock->hw));
 			return;
 		}
@@ -1602,6 +1623,9 @@ static void bcm2835_clock_off(struct clk_hw *hw)
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
 
+	if (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
+		pr_warn("%s: clk still busy from %d\n", __func__, cprman->func_code);
+
 	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, data->ctl_reg,
 		     cprman_read(cprman, data->ctl_reg) & ~CM_ENABLE);
@@ -1609,6 +1633,11 @@ static void bcm2835_clock_off(struct clk_hw *hw)
 
 	/* BUSY will remain high until the divider completes its cycle. */
 	bcm2835_clock_wait_busy(clock);
+
+	cprman->func_code = 8;
+
+	if (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
+		pr_warn("%s: clk now busy from %d\n", __func__, cprman->func_code);
 }
 
 static int bcm2835_clock_on(struct clk_hw *hw)
@@ -1617,6 +1646,9 @@ static int bcm2835_clock_on(struct clk_hw *hw)
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
 
+	if (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
+		pr_warn("%s: clk still busy from %d\n", __func__, cprman->func_code);
+
 	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, data->ctl_reg,
 		     cprman_read(cprman, data->ctl_reg) |
@@ -1624,6 +1656,11 @@ static int bcm2835_clock_on(struct clk_hw *hw)
 		     CM_GATE);
 	spin_unlock(&cprman->regs_lock);
 
+	cprman->func_code = 9;
+
+	if (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
+		pr_warn("%s: clk now busy from %d\n", __func__, cprman->func_code);
+
 	return 0;
 }
 
@@ -1638,6 +1675,9 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
 	enum bcm2835_clock_mash_type mash = divmash_get_mash(dm);
 	u32 ctl;
 
+	if (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
+		pr_warn("%s: clk still busy from %d\n", __func__, cprman->func_code);
+
 	spin_lock(&cprman->regs_lock);
 
 	/* if div and mash are identical, then there is nothing to do */
@@ -1663,6 +1703,11 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
 unlock_exit:
 	spin_unlock(&cprman->regs_lock);
 
+	cprman->func_code = 10;
+
+	if (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
+		pr_warn("%s: clk now busy from %d\n", __func__, cprman->func_code);
+
 	return 0;
 }
 
@@ -1713,7 +1758,16 @@ static int bcm2835_clock_set_parent(struct clk_hw *hw, u8
index)
 	const struct bcm2835_clock_data *data = clock->data;
 	u8 src = (index << CM_SRC_SHIFT) & CM_SRC_MASK;
 
+	if (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
+		pr_warn("%s: clk still busy from %d\n", __func__, cprman->func_code);
+
 	cprman_write(cprman, data->ctl_reg, src);
+
+	cprman->func_code = 11;
+
+	if (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
+		pr_warn("%s: clk now busy from %d\n", __func__, cprman->func_code);
+
 	return 0;
 }
 
