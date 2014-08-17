From: Carlo Caione <carlo@caione.org>
Subject: [PATCH 3/7] ARM: meson6: clocksource: add Meson6 timer support
Date: Sun, 17 Aug 2014 12:49:50 +0200
Message-ID: <1408272594-10814-4-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:41319 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbaHQKuc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Aug 2014 06:50:32 -0400
In-Reply-To: <1408272594-10814-1-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, gregkh@linuxfoundation.org, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com
Cc: Carlo Caione <carlo@caione.org>

Meson6 SoCs are equipped with 5 32-bit timers, called TIMER_A, TIMER_B,
TIMER_C, TIMER_D and TIMER_E.

The driver is providing clocksource support for the 32-bit counter using
TIMER_E. Clockevents are also supported using TIMER_A.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 drivers/clocksource/Kconfig        |   3 +
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/meson6_timer.c | 187 +++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 drivers/clocksource/meson6_timer.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfd6519..38029ca 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -30,6 +30,9 @@ config ARMADA_370_XP_TIMER
 	bool
 	select CLKSRC_OF
 
+config MESON6_TIMER
+	bool
+
 config ORION_TIMER
 	select CLKSRC_OF
 	select CLKSRC_MMIO
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 7fd9fd1..e4ae987 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
 obj-$(CONFIG_ARCH_U300)		+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
+obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
 obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
 obj-$(CONFIG_ARCH_NSPIRE)	+= zevio-timer.o
diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
new file mode 100644
index 0000000..1ef1095
--- /dev/null
+++ b/drivers/clocksource/meson6_timer.c
@@ -0,0 +1,187 @@
+/*
+ * Amlogic Meson6 SoCs timer handling.
+ *
+ * Copyright (C) 2014 Carlo Caione
+ *
+ * Carlo Caione <carlo@caione.org>
+ *
+ * Based on code from Amlogic, Inc
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+enum {
+	A = 0,
+	B,
+	C,
+	D,
+};
+
+#define TIMER_ISA_MUX		0
+#define TIMER_ISA_E_VAL		0x14
+#define TIMER_ISA_t_VAL(t)	((t + 1) << 2)
+
+#define TIMER_t_INPUT_BIT(t)	(2 * t)
+#define TIMER_E_INPUT_BIT	8
+#define TIMER_t_INPUT_MASK(t)	(3UL << TIMER_t_INPUT_BIT(t))
+#define TIMER_E_INPUT_MASK	(7UL << TIMER_E_INPUT_BIT)
+#define TIMER_t_ENABLE_BIT(t)	(16 + t)
+#define TIMER_E_ENABLE_BIT	20
+#define TIMER_t_PERIODIC_BIT(t)	(12 + t)
+
+#define TIMER_UNIT_1us		0
+#define TIMER_E_UNIT_1us	1
+
+static void __iomem *timer_base;
+
+static cycle_t cycle_read_timer_e(struct clocksource *cs)
+{
+	return (cycle_t)readl(timer_base + TIMER_ISA_E_VAL);
+}
+
+static struct clocksource clocksource_timer_e = {
+	.name	= "meson6_timerE",
+	.rating	= 300,
+	.read	= cycle_read_timer_e,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags  = CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u64 notrace meson6_timer_sched_read(void)
+{
+	return (u64)readl(timer_base + TIMER_ISA_E_VAL);
+}
+
+static void meson6_clkevt_time_stop(unsigned char timer)
+{
+	u32 val = readl(timer_base + TIMER_ISA_MUX);
+
+	writel(val & ~TIMER_t_ENABLE_BIT(timer), timer_base + TIMER_ISA_MUX);
+}
+
+static void meson6_clkevt_time_setup(unsigned char timer, unsigned long delay)
+{
+	writel(delay, timer_base + TIMER_ISA_t_VAL(timer));
+}
+
+static void meson6_clkevt_time_start(unsigned char timer, bool periodic)
+{
+	u32 val = readl(timer_base + TIMER_ISA_MUX);
+
+	if (periodic)
+		val |= TIMER_t_PERIODIC_BIT(timer);
+	else
+		val &= ~TIMER_t_PERIODIC_BIT(timer);
+
+	writel(val | TIMER_t_ENABLE_BIT(timer), timer_base + TIMER_ISA_MUX);
+}
+
+static void meson6_clkevt_mode(enum clock_event_mode mode,
+			       struct clock_event_device *clk)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		meson6_clkevt_time_stop(A);
+		meson6_clkevt_time_setup(A, USEC_PER_SEC/HZ - 1);
+		meson6_clkevt_time_start(A, true);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		meson6_clkevt_time_stop(A);
+		meson6_clkevt_time_start(A, false);
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		meson6_clkevt_time_stop(A);
+		break;
+	}
+}
+
+static int meson6_clkevt_next_event(unsigned long evt,
+				    struct clock_event_device *unused)
+{
+	meson6_clkevt_time_stop(A);
+	meson6_clkevt_time_setup(A, evt);
+	meson6_clkevt_time_start(A, false);
+
+	return 0;
+}
+
+static struct clock_event_device meson6_clockevent = {
+	.name		= "meson6_tick",
+	.rating		= 400,
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode	= meson6_clkevt_mode,
+	.set_next_event	= meson6_clkevt_next_event,
+};
+
+static irqreturn_t meson6_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction meson6_timer_irq = {
+	.name		= "meson6_timerA",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= meson6_timer_interrupt,
+	.dev_id		= &meson6_clockevent,
+};
+
+static void __init meson6_timer_init(struct device_node *node)
+{
+	u32 val;
+	int ret, irq;
+
+	timer_base = of_iomap(node, 0);
+	if (!timer_base)
+		panic("Can't map registers");
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq <= 0)
+		panic("Can't parse IRQ");
+
+	/* Set 1us for timer E */
+	val = readl(timer_base + TIMER_ISA_MUX);
+	val &= ~TIMER_E_INPUT_MASK;
+	val |= TIMER_E_UNIT_1us << TIMER_E_INPUT_BIT;
+	writel(val, timer_base + TIMER_ISA_MUX);
+
+	sched_clock_register(meson6_timer_sched_read, 32, USEC_PER_SEC);
+	clocksource_register_khz(&clocksource_timer_e, 1000);
+
+	/* Timer A base 1us */
+	val &= ~TIMER_t_INPUT_MASK(A);
+	val |= TIMER_UNIT_1us << TIMER_t_INPUT_BIT(A);
+	writel(val, timer_base + TIMER_ISA_MUX);
+
+	/* Stop the timer A */
+	meson6_clkevt_time_stop(A);
+
+	ret = setup_irq(irq, &meson6_timer_irq);
+	if (ret)
+		pr_warn("failed to setup irq %d\n", irq);
+
+	meson6_clockevent.cpumask = cpu_possible_mask;
+	meson6_clockevent.irq = irq;
+
+	clockevents_config_and_register(&meson6_clockevent, USEC_PER_SEC,
+					1, 0xfffe);
+}
+CLOCKSOURCE_OF_DECLARE(meson6, "amlogic,meson6-timer",
+		       meson6_timer_init);
-- 
1.9.1

