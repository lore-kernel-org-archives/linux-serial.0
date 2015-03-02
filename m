From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 3/6] rtc: at91rm9200: rework wakeup and interrupt handling
Date: Mon,  2 Mar 2015 10:18:15 +0100
Message-ID: <1425287898-15093-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

The IRQ line used by the RTC device is usually shared with the system
timer (PIT) on at91 platforms.
Since timers are registering their handlers with IRQF_NO_SUSPEND, we
should expect being called in suspended state, and properly wake the
system up when this is the case.

Set IRQF_COND_SUSPEND flag when registering the IRQ handler to inform
irq core that it can safely be called while the system is suspended.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/rtc/rtc-at91rm9200.c | 62 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 70a5d94..b4f7744 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -31,6 +31,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/suspend.h>
 #include <linux/uaccess.h>
 
 #include "rtc-at91rm9200.h"
@@ -54,6 +55,10 @@ static void __iomem *at91_rtc_regs;
 static int irq;
 static DEFINE_SPINLOCK(at91_rtc_lock);
 static u32 at91_rtc_shadow_imr;
+static bool suspended;
+static DEFINE_SPINLOCK(suspended_lock);
+static unsigned long cached_events;
+static u32 at91_rtc_imr;
 
 static void at91_rtc_write_ier(u32 mask)
 {
@@ -290,7 +295,9 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
 	struct rtc_device *rtc = platform_get_drvdata(pdev);
 	unsigned int rtsr;
 	unsigned long events = 0;
+	int ret = IRQ_NONE;
 
+	spin_lock(&suspended_lock);
 	rtsr = at91_rtc_read(AT91_RTC_SR) & at91_rtc_read_imr();
 	if (rtsr) {		/* this interrupt is shared!  Is it ours? */
 		if (rtsr & AT91_RTC_ALARM)
@@ -304,14 +311,22 @@ static irqreturn_t at91_rtc_interrupt(int irq, void *dev_id)
 
 		at91_rtc_write(AT91_RTC_SCCR, rtsr);	/* clear status reg */
 
-		rtc_update_irq(rtc, 1, events);
+		if (!suspended) {
+			rtc_update_irq(rtc, 1, events);
 
-		dev_dbg(&pdev->dev, "%s(): num=%ld, events=0x%02lx\n", __func__,
-			events >> 8, events & 0x000000FF);
+			dev_dbg(&pdev->dev, "%s(): num=%ld, events=0x%02lx\n",
+				__func__, events >> 8, events & 0x000000FF);
+		} else {
+			cached_events |= events;
+			at91_rtc_write_idr(at91_rtc_imr);
+			pm_system_wakeup();
+		}
 
-		return IRQ_HANDLED;
+		ret = IRQ_HANDLED;
 	}
-	return IRQ_NONE;		/* not handled */
+	spin_lock(&suspended_lock);
+
+	return ret;
 }
 
 static const struct at91_rtc_config at91rm9200_config = {
@@ -401,8 +416,8 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 					AT91_RTC_CALEV);
 
 	ret = devm_request_irq(&pdev->dev, irq, at91_rtc_interrupt,
-				IRQF_SHARED,
-				"at91_rtc", pdev);
+			       IRQF_SHARED | IRQF_COND_SUSPEND,
+			       "at91_rtc", pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "IRQ %d already in use.\n", irq);
 		return ret;
@@ -454,8 +469,6 @@ static void at91_rtc_shutdown(struct platform_device *pdev)
 
 /* AT91RM9200 RTC Power management control */
 
-static u32 at91_rtc_imr;
-
 static int at91_rtc_suspend(struct device *dev)
 {
 	/* this IRQ is shared with DBGU and other hardware which isn't
@@ -464,21 +477,42 @@ static int at91_rtc_suspend(struct device *dev)
 	at91_rtc_imr = at91_rtc_read_imr()
 			& (AT91_RTC_ALARM|AT91_RTC_SECEV);
 	if (at91_rtc_imr) {
-		if (device_may_wakeup(dev))
+		if (device_may_wakeup(dev)) {
+			unsigned long flags;
+
 			enable_irq_wake(irq);
-		else
+
+			spin_lock_irqsave(&suspended_lock, flags);
+			suspended = true;
+			spin_unlock_irqrestore(&suspended_lock, flags);
+		} else {
 			at91_rtc_write_idr(at91_rtc_imr);
+		}
 	}
 	return 0;
 }
 
 static int at91_rtc_resume(struct device *dev)
 {
+	struct rtc_device *rtc = dev_get_drvdata(dev);
+
 	if (at91_rtc_imr) {
-		if (device_may_wakeup(dev))
+		if (device_may_wakeup(dev)) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&suspended_lock, flags);
+
+			if (cached_events) {
+				rtc_update_irq(rtc, 1, cached_events);
+				cached_events = 0;
+			}
+
+			suspended = false;
+			spin_unlock_irqrestore(&suspended_lock, flags);
+
 			disable_irq_wake(irq);
-		else
-			at91_rtc_write_ier(at91_rtc_imr);
+		}
+		at91_rtc_write_ier(at91_rtc_imr);
 	}
 	return 0;
 }
-- 
1.9.1
