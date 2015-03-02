From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 2/6] rtc: at91sam9: rework wakeup and interrupt handling
Date: Mon,  2 Mar 2015 10:18:14 +0100
Message-ID: <1425287898-15093-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425287898-15093-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The IRQ line used by the RTC device is usually shared with the system timer
(PIT) on at91 platforms.
Since timers are registering their handlers with IRQF_NO_SUSPEND, we should
expect being called in suspended state, and properly wake the system up
when this is the case.

Set IRQF_COND_SUSPEND flag when registering the IRQ handler to inform
irq core that it can safely be called while the system is suspended.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/rtc/rtc-at91sam9.c | 73 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 2183fd2..5ccaee3 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/suspend.h>
 #include <linux/clk.h>
 
 /*
@@ -77,6 +78,9 @@ struct sam9_rtc {
 	unsigned int		gpbr_offset;
 	int 			irq;
 	struct clk		*sclk;
+	bool			suspended;
+	unsigned long		events;
+	spinlock_t		lock;
 };
 
 #define rtt_readl(rtc, field) \
@@ -271,14 +275,9 @@ static int at91_rtc_proc(struct device *dev, struct seq_file *seq)
 	return 0;
 }
 
-/*
- * IRQ handler for the RTC
- */
-static irqreturn_t at91_rtc_interrupt(int irq, void *_rtc)
+static irqreturn_t at91_rtc_cache_events(struct sam9_rtc *rtc)
 {
-	struct sam9_rtc *rtc = _rtc;
 	u32 sr, mr;
-	unsigned long events = 0;
 
 	/* Shared interrupt may be for another device.  Note: reading
 	 * SR clears it, so we must only read it in this irq handler!
@@ -290,18 +289,54 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *_rtc)
 
 	/* alarm status */
 	if (sr & AT91_RTT_ALMS)
-		events |= (RTC_AF | RTC_IRQF);
+		rtc->events |= (RTC_AF | RTC_IRQF);
 
 	/* timer update/increment */
 	if (sr & AT91_RTT_RTTINC)
-		events |= (RTC_UF | RTC_IRQF);
+		rtc->events |= (RTC_UF | RTC_IRQF);
+
+	return IRQ_HANDLED;
+}
+
+static void at91_rtc_flush_events(struct sam9_rtc *rtc)
+{
+	if (!rtc->events)
+		return;
 
-	rtc_update_irq(rtc->rtcdev, 1, events);
+	rtc_update_irq(rtc->rtcdev, 1, rtc->events);
+	rtc->events = 0;
 
 	pr_debug("%s: num=%ld, events=0x%02lx\n", __func__,
-		events >> 8, events & 0x000000FF);
+		rtc->events >> 8, rtc->events & 0x000000FF);
+}
 
-	return IRQ_HANDLED;
+/*
+ * IRQ handler for the RTC
+ */
+static irqreturn_t at91_rtc_interrupt(int irq, void *_rtc)
+{
+	struct sam9_rtc *rtc = _rtc;
+	int ret;
+
+	spin_lock(&rtc->lock);
+
+	ret = at91_rtc_cache_events(rtc);
+
+	/* We're called in suspended state */
+	if (rtc->suspended) {
+		/* Mask irqs coming from this peripheral */
+		rtt_writel(rtc, MR,
+			   rtt_readl(rtc, MR) &
+			   ~(AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN));
+		/* Trigger a system wakeup */
+		pm_system_wakeup();
+	} else {
+		at91_rtc_flush_events(rtc);
+	}
+
+	spin_unlock(&rtc->lock);
+
+	return ret;
 }
 
 static const struct rtc_class_ops at91_rtc_ops = {
@@ -421,7 +456,8 @@ static int at91_rtc_probe(struct platform_device *pdev)
 
 	/* register irq handler after we know what name we'll use */
 	ret = devm_request_irq(&pdev->dev, rtc->irq, at91_rtc_interrupt,
-				IRQF_SHARED, dev_name(&rtc->rtcdev->dev), rtc);
+			       IRQF_SHARED | IRQF_COND_SUSPEND,
+			       dev_name(&rtc->rtcdev->dev), rtc);
 	if (ret) {
 		dev_dbg(&pdev->dev, "can't share IRQ %d?\n", rtc->irq);
 		return ret;
@@ -482,7 +518,12 @@ static int at91_rtc_suspend(struct device *dev)
 	rtc->imr = mr & (AT91_RTT_ALMIEN | AT91_RTT_RTTINCIEN);
 	if (rtc->imr) {
 		if (device_may_wakeup(dev) && (mr & AT91_RTT_ALMIEN)) {
+			unsigned long flags;
+
 			enable_irq_wake(rtc->irq);
+			spin_lock_irqsave(&rtc->lock, flags);
+			rtc->suspended = true;
+			spin_unlock_irqrestore(&rtc->lock, flags);
 			/* don't let RTTINC cause wakeups */
 			if (mr & AT91_RTT_RTTINCIEN)
 				rtt_writel(rtc, MR, mr & ~AT91_RTT_RTTINCIEN);
@@ -499,10 +540,18 @@ static int at91_rtc_resume(struct device *dev)
 	u32		mr;
 
 	if (rtc->imr) {
+		unsigned long flags;
+
 		if (device_may_wakeup(dev))
 			disable_irq_wake(rtc->irq);
 		mr = rtt_readl(rtc, MR);
 		rtt_writel(rtc, MR, mr | rtc->imr);
+
+		spin_lock_irqsave(&rtc->lock, flags);
+		rtc->suspended = false;
+		at91_rtc_cache_events(rtc);
+		at91_rtc_flush_events(rtc);
+		spin_unlock_irqrestore(&rtc->lock, flags);
 	}
 
 	return 0;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
