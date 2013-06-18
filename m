From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v4 08/10] clocksource: exynos_mct: use (request/free)_irq calls for local timer registration
Date: Tue, 18 Jun 2013 11:59:20 +0530
Message-ID: <1371536962-13322-9-git-send-email-chander.kashyap@linaro.org>
References: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:63826 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab3FRGaO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Jun 2013 02:30:14 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so3575036pdd.34
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2013 23:30:13 -0700 (PDT)
In-Reply-To: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, mark.rutland@arm.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>

Replace the (setup/remove)_irq calls for local timer registration with
(request/free)_irq calls. This generalizes the local timer registration API.
Suggested by Mark Rutland.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 drivers/clocksource/exynos_mct.c |   35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 662fcc0..a704804 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -400,18 +400,6 @@ static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction mct_tick0_event_irq = {
-	.name		= "mct_tick0_irq",
-	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
-	.handler	= exynos4_mct_tick_isr,
-};
-
-static struct irqaction mct_tick1_event_irq = {
-	.name		= "mct_tick1_irq",
-	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
-	.handler	= exynos4_mct_tick_isr,
-};
-
 static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
 {
 	struct mct_clock_event_device *mevt;
@@ -435,16 +423,15 @@ static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
 	if (mct_int_type == MCT_INT_SPI) {
-		if (cpu == 0) {
-			mct_tick0_event_irq.dev_id = mevt;
-			evt->irq = mct_irqs[MCT_L0_IRQ];
-			setup_irq(evt->irq, &mct_tick0_event_irq);
-		} else {
-			mct_tick1_event_irq.dev_id = mevt;
-			evt->irq = mct_irqs[MCT_L1_IRQ];
-			setup_irq(evt->irq, &mct_tick1_event_irq);
-			irq_set_affinity(evt->irq, cpumask_of(1));
+		evt->irq = mct_irqs[MCT_L0_IRQ + cpu];
+		if (request_irq(evt->irq, exynos4_mct_tick_isr,
+				IRQF_TIMER | IRQF_NOBALANCING,
+				evt->name, mevt)) {
+			pr_err("exynos-mct: cannot register IRQ %d\n",
+				evt->irq);
+			return -EIO;
 		}
+		irq_set_affinity(evt->irq, cpumask_of(cpu));
 	} else {
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
@@ -454,13 +441,9 @@ static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
 
 static void exynos4_local_timer_stop(struct clock_event_device *evt)
 {
-	unsigned int cpu = smp_processor_id();
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
 	if (mct_int_type == MCT_INT_SPI)
-		if (cpu == 0)
-			remove_irq(evt->irq, &mct_tick0_event_irq);
-		else
-			remove_irq(evt->irq, &mct_tick1_event_irq);
+		free_irq(evt->irq, this_cpu_ptr(&percpu_mct_tick));
 	else
 		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 }
-- 
1.7.9.5

