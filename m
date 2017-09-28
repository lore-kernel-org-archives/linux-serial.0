From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v4 6/8] pwm: atmel-tcb: Support backup mode
Date: Thu, 28 Sep 2017 11:46:25 +0200
Message-ID: <20170928094627.31017-7-romain.izard.pro@gmail.com>
References: <20170928094627.31017-1-romain.izard.pro@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170928094627.31017-1-romain.izard.pro@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Alan Stern <stern@rowland.harvard.edu>, Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Ale
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

Save and restore registers for the PWM on suspend and resume, which
makes hibernation and backup modes possible.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/pwm/pwm-atmel-tcb.c | 63 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 75db585a2a94..acd3ce8ecf3f 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -37,11 +37,20 @@ struct atmel_tcb_pwm_device {
 	unsigned period;		/* PWM period expressed in clk cycles */
 };
 
+struct atmel_tcb_channel {
+	u32 enabled;
+	u32 cmr;
+	u32 ra;
+	u32 rb;
+	u32 rc;
+};
+
 struct atmel_tcb_pwm_chip {
 	struct pwm_chip chip;
 	spinlock_t lock;
 	struct atmel_tc *tc;
 	struct atmel_tcb_pwm_device *pwms[NPWM];
+	struct atmel_tcb_channel bkup[NPWM / 2];
 };
 
 static inline struct atmel_tcb_pwm_chip *to_tcb_chip(struct pwm_chip *chip)
@@ -175,12 +184,15 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	 * Use software trigger to apply the new setting.
 	 * If both PWM devices in this group are disabled we stop the clock.
 	 */
-	if (!(cmr & (ATMEL_TC_ACPC | ATMEL_TC_BCPC)))
+	if (!(cmr & (ATMEL_TC_ACPC | ATMEL_TC_BCPC))) {
 		__raw_writel(ATMEL_TC_SWTRG | ATMEL_TC_CLKDIS,
 			     regs + ATMEL_TC_REG(group, CCR));
-	else
+		tcbpwmc->bkup[group].enabled = 1;
+	} else {
 		__raw_writel(ATMEL_TC_SWTRG, regs +
 			     ATMEL_TC_REG(group, CCR));
+		tcbpwmc->bkup[group].enabled = 0;
+	}
 
 	spin_unlock(&tcbpwmc->lock);
 }
@@ -263,6 +275,7 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/* Use software trigger to apply the new setting */
 	__raw_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
 		     regs + ATMEL_TC_REG(group, CCR));
+	tcbpwmc->bkup[group].enabled = 1;
 	spin_unlock(&tcbpwmc->lock);
 	return 0;
 }
@@ -445,10 +458,56 @@ static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_tcb_pwm_dt_ids);
 
+#ifdef CONFIG_PM_SLEEP
+static int atmel_tcb_pwm_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
+	void __iomem *base = tcbpwm->tc->regs;
+	int i;
+
+	for (i = 0; i < (NPWM / 2); i++) {
+		struct atmel_tcb_channel *chan = &tcbpwm->bkup[i];
+
+		chan->cmr = readl(base + ATMEL_TC_REG(i, CMR));
+		chan->ra = readl(base + ATMEL_TC_REG(i, RA));
+		chan->rb = readl(base + ATMEL_TC_REG(i, RB));
+		chan->rc = readl(base + ATMEL_TC_REG(i, RC));
+	}
+	return 0;
+}
+
+static int atmel_tcb_pwm_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
+	void __iomem *base = tcbpwm->tc->regs;
+	int i;
+
+	for (i = 0; i < (NPWM / 2); i++) {
+		struct atmel_tcb_channel *chan = &tcbpwm->bkup[i];
+
+		writel(chan->cmr, base + ATMEL_TC_REG(i, CMR));
+		writel(chan->ra, base + ATMEL_TC_REG(i, RA));
+		writel(chan->rb, base + ATMEL_TC_REG(i, RB));
+		writel(chan->rc, base + ATMEL_TC_REG(i, RC));
+		if (chan->enabled) {
+			writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
+				base + ATMEL_TC_REG(i, CCR));
+		}
+	}
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(atmel_tcb_pwm_pm_ops, atmel_tcb_pwm_suspend,
+			 atmel_tcb_pwm_resume);
+
 static struct platform_driver atmel_tcb_pwm_driver = {
 	.driver = {
 		.name = "atmel-tcb-pwm",
 		.of_match_table = atmel_tcb_pwm_dt_ids,
+		.pm = &atmel_tcb_pwm_pm_ops,
 	},
 	.probe = atmel_tcb_pwm_probe,
 	.remove = atmel_tcb_pwm_remove,
-- 
2.11.0
