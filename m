From: Romain Izard <romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 08/10] pwm: atmel-tcb: Support backup mode
Date: Fri,  8 Sep 2017 17:36:02 +0200
Message-ID: <20170908153604.28383-9-romain.izard.pro@gmail.com>
References: <20170908153604.28383-1-romain.izard.pro@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170908153604.28383-1-romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Josh Wu <rainyfeeling-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Romain Izard <romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Save and restore registers for the PWM on suspend and resume, which
makes hibernation and backup modes possible.

Signed-off-by: Romain Izard <romain.izard.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
