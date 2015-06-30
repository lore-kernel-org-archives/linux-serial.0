From: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
Subject: [PATCH v2 4/9] arm: twr-k70f120m: timer driver for Kinetis SoC
Date: Tue, 30 Jun 2015 14:27:25 +0200
Message-ID: <1435667250-28299-5-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435667250-28299-1-git-send-email-pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>, Anson Huang <b20788-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Rob Herring <r.herring-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yuri Tikhonov <yur-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>, Sergei Poselenov <sposelenov-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>, Alexander Potashev <aspotashev-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Based on legacy pre-OF code by Alexander Potashev <aspotashev-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>

Signed-off-by: Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
---
 .../bindings/timer/fsl,kinetis-pit-timer.txt       |  50 ++++
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/kinetis-twr-k70f120m.dts         |   4 +
 arch/arm/boot/dts/kinetis.dtsi                     |  40 +++
 drivers/clocksource/Kconfig                        |   5 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-kinetis.c                | 321 +++++++++++++++++++++
 7 files changed, 422 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,kinetis-pit-timer.txt
 create mode 100644 drivers/clocksource/timer-kinetis.c

diff --git a/Documentation/devicetree/bindings/timer/fsl,kinetis-pit-timer.txt b/Documentation/devicetree/bindings/timer/fsl,kinetis-pit-timer.txt
new file mode 100644
index 0000000..4017230
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,kinetis-pit-timer.txt
@@ -0,0 +1,50 @@
+Freescale Kinetis SoC Periodic Interrupt Timer (PIT)
+
+Required properties:
+
+- compatible: Should be "fsl,kinetis-pit-timer".
+- reg: Specifies base physical address and size of the register set for the
+  Periodic Interrupt Timer.
+- clocks: The clock provided by the SoC to drive the timer.
+- Set of timer devices: following properties are required for each:
+	- reg: Specifies base physical address and size of the register set
+		for given timer device.
+	- interrupts: Should be the clock event device interrupt.
+
+Example:
+
+aliases {
+	pit0 = &pit0;
+	pit1 = &pit1;
+	pit2 = &pit2;
+	pit3 = &pit3;
+};
+
+pit@40037000 {
+	compatible = "fsl,kinetis-pit-timer";
+	reg = <0x40037000 0x100>;
+	clocks = <&mcg_pclk_gate 5 23>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	pit0: timer@40037100 {
+		reg = <0x40037100 0x10>;
+		interrupts = <68>;
+	};
+
+	pit1: timer@40037110 {
+		reg = <0x40037110 0x10>;
+		interrupts = <69>;
+	};
+
+	pit2: timer@40037120 {
+		reg = <0x40037120 0x10>;
+		interrupts = <70>;
+	};
+
+	pit3: timer@40037130 {
+		reg = <0x40037130 0x10>;
+		interrupts = <71>;
+	};
+};
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9c89bdc..96ddaae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -968,6 +968,7 @@ config ARCH_KINETIS
 	bool "Freescale Kinetis MCU"
 	depends on ARM_SINGLE_ARMV7M
 	select ARMV7M_SYSTICK
+	select CLKSRC_KINETIS
 	help
 	  This enables support for the Freescale Kinetis MCUs
 
diff --git a/arch/arm/boot/dts/kinetis-twr-k70f120m.dts b/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
index edccf37..a6efc29 100644
--- a/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
+++ b/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
@@ -14,3 +14,7 @@
 		reg = <0x8000000 0x8000000>;
 	};
 };
+
+&pit0 {
+	status = "ok";
+};
diff --git a/arch/arm/boot/dts/kinetis.dtsi b/arch/arm/boot/dts/kinetis.dtsi
index ae0cf00..0c572a5 100644
--- a/arch/arm/boot/dts/kinetis.dtsi
+++ b/arch/arm/boot/dts/kinetis.dtsi
@@ -5,7 +5,47 @@
 #include "armv7-m.dtsi"
 
 / {
+	aliases {
+		pit0 = &pit0;
+		pit1 = &pit1;
+		pit2 = &pit2;
+		pit3 = &pit3;
+	};
+
 	soc {
+		pit@40037000 {
+			compatible = "fsl,kinetis-pit-timer";
+			reg = <0x40037000 0x100>;
+			clocks = <&mcg_pclk_gate 5 23>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pit0: timer@40037100 {
+				reg = <0x40037100 0x10>;
+				interrupts = <68>;
+				status = "disabled";
+			};
+
+			pit1: timer@40037110 {
+				reg = <0x40037110 0x10>;
+				interrupts = <69>;
+				status = "disabled";
+			};
+
+			pit2: timer@40037120 {
+				reg = <0x40037120 0x10>;
+				interrupts = <70>;
+				status = "disabled";
+			};
+
+			pit3: timer@40037130 {
+				reg = <0x40037130 0x10>;
+				interrupts = <71>;
+				status = "disabled";
+			};
+		};
+
 		cmu@40064000 {
 			compatible = "fsl,kinetis-cmu";
 			reg = <0x40064000 0x14>, <0x40047000 0x1100>;
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4e57730..a12e5af 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -106,6 +106,11 @@ config CLKSRC_EFM32
 	  Support to use the timers of EFM32 SoCs as clock source and clock
 	  event device.
 
+config CLKSRC_KINETIS
+	bool "Clocksource for Kinetis SoCs"
+	depends on OF && ARCH_KINETIS
+	select CLKSRC_OF
+
 config CLKSRC_LPC32XX
 	bool
 	select CLKSRC_MMIO
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index f228354..5807429 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_ARCH_NSPIRE)	+= zevio-timer.o
 obj-$(CONFIG_ARCH_BCM_MOBILE)	+= bcm_kona_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
 obj-$(CONFIG_CLKSRC_EFM32)	+= time-efm32.o
+obj-$(CONFIG_CLKSRC_KINETIS)	+= timer-kinetis.o
 obj-$(CONFIG_CLKSRC_STM32)	+= timer-stm32.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
 obj-$(CONFIG_CLKSRC_LPC32XX)	+= time-lpc32xx.o
diff --git a/drivers/clocksource/timer-kinetis.c b/drivers/clocksource/timer-kinetis.c
new file mode 100644
index 0000000..a2a8880
--- /dev/null
+++ b/drivers/clocksource/timer-kinetis.c
@@ -0,0 +1,321 @@
+/*
+ * timer-kinetis.c - Timer driver for Kinetis K70
+ *
+ * Based on legacy pre-OF code by Alexander Potashev <aspotashev-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>
+ *
+ * Copyright (C) 2015 Paul Osmialowski <pawelo-rhuoMcPwk82rDJvtcaxF/A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/clk.h>
+#include <linux/sched.h>
+
+#define KINETIS_PIT_CHANNELS 4
+
+/*
+ * PIT Timer Control Register
+ */
+/* Timer Interrupt Enable Bit */
+#define KINETIS_PIT_TCTRL_TIE_MSK	(1 << 1)
+/* Timer Enable Bit */
+#define KINETIS_PIT_TCTRL_TEN_MSK	(1 << 0)
+/*
+ * PIT Timer Flag Register
+ */
+/* Timer Interrupt Flag */
+#define KINETIS_PIT_TFLG_TIF_MSK	(1 << 0)
+
+struct kinetis_pit_mcr_regs {
+	u32 mcr;
+};
+
+#define KINETIS_PITMCR_PTR(base, reg) \
+	(&(((struct kinetis_pit_mcr_regs *)(base))->reg))
+#define KINETIS_PITMCR_RD(be, base, reg) \
+		((be) ? ioread32be(KINETIS_PITMCR_PTR(base, reg)) \
+		      : ioread32(KINETIS_PITMCR_PTR(base, reg)))
+#define KINETIS_PITMCR_WR(be, base, reg, val) do { \
+		if (be) \
+			iowrite32be((val), KINETIS_PITMCR_PTR(base, reg)); \
+		else \
+			iowrite32((val), KINETIS_PITMCR_PTR(base, reg)); \
+	} while (0)
+
+/*
+ * Periodic Interrupt Timer (PIT) registers
+ */
+struct kinetis_pit_channel_regs {
+	u32 ldval;	/* Timer Load Value Register */
+	u32 cval;	/* Current Timer Value Register */
+	u32 tctrl;	/* Timer Control Register */
+	u32 tflg;	/* Timer Flag Register */
+};
+
+#define KINETIS_PIT_PTR(base, reg) \
+	(&(((struct kinetis_pit_channel_regs *)(base))->reg))
+#define KINETIS_PIT_RD(be, base, reg) \
+		((be) ? ioread32be(KINETIS_PIT_PTR(base, reg)) \
+		      : ioread32(KINETIS_PIT_PTR(base, reg)))
+#define KINETIS_PIT_WR(be, base, reg, val) do { \
+		if (be) \
+			iowrite32be((val), KINETIS_PIT_PTR(base, reg)); \
+		else \
+			iowrite32((val), KINETIS_PIT_PTR(base, reg)); \
+	} while (0)
+#define KINETIS_PIT_SET(be, base, reg, mask) \
+		KINETIS_PIT_WR(be, base, reg, \
+			KINETIS_PIT_RD(be, base, reg) | (mask))
+#define KINETIS_PIT_RESET(be, base, reg, mask) \
+		KINETIS_PIT_WR(be, base, reg, \
+			KINETIS_PIT_RD(be, base, reg) & (~(mask)))
+
+struct kinetis_clock_event_ddata {
+	struct clock_event_device evtdev;
+	void __iomem *base;
+	void __iomem *mcr;
+	bool big_endian;
+};
+
+/*
+ * Enable or disable a PIT channel
+ */
+static void kinetis_pit_enable(struct kinetis_clock_event_ddata *tmr,
+							    int enable)
+{
+	if (enable)
+		KINETIS_PIT_SET(tmr->big_endian, tmr->base, tctrl,
+					KINETIS_PIT_TCTRL_TEN_MSK);
+	else
+		KINETIS_PIT_RESET(tmr->big_endian, tmr->base, tctrl,
+					KINETIS_PIT_TCTRL_TEN_MSK);
+}
+
+/*
+ * Initialize a PIT channel, but do not enable it
+ */
+static void kinetis_pit_init(struct kinetis_clock_event_ddata *tmr, u32 ticks)
+{
+	/*
+	 * Enable the PIT module clock
+	 */
+	KINETIS_PITMCR_WR(tmr->big_endian, tmr->mcr, mcr, 0);
+
+	KINETIS_PIT_WR(tmr->big_endian, tmr->base, tctrl, 0);
+	KINETIS_PIT_WR(tmr->big_endian, tmr->base, tflg,
+					KINETIS_PIT_TFLG_TIF_MSK);
+	KINETIS_PIT_WR(tmr->big_endian, tmr->base, ldval, ticks);
+	KINETIS_PIT_WR(tmr->big_endian, tmr->base, cval, 0);
+	KINETIS_PIT_WR(tmr->big_endian, tmr->base, tctrl,
+					KINETIS_PIT_TCTRL_TIE_MSK);
+}
+
+static int kinetis_clockevent_tmr_set_state_periodic(
+	struct clock_event_device *evt)
+{
+	struct kinetis_clock_event_ddata *pit =
+		container_of(evt, struct kinetis_clock_event_ddata, evtdev);
+
+	kinetis_pit_enable(pit, 1);
+
+	return 0;
+}
+
+static int kinetis_clockevent_tmr_set_state_oneshot(
+	struct clock_event_device *evt)
+{
+	struct kinetis_clock_event_ddata *pit =
+		container_of(evt, struct kinetis_clock_event_ddata, evtdev);
+
+	kinetis_pit_enable(pit, 0);
+
+	return 0;
+}
+
+/*
+ * Configure the timer to generate an interrupt in the specified amount of ticks
+ */
+static int kinetis_clockevent_tmr_set_next_event(
+	unsigned long delta, struct clock_event_device *c)
+{
+	struct kinetis_clock_event_ddata *pit =
+		container_of(c, struct kinetis_clock_event_ddata, evtdev);
+
+	kinetis_pit_init(pit, delta);
+	kinetis_pit_enable(pit, 1);
+
+	return 0;
+}
+
+static struct kinetis_clock_event_ddata
+		kinetis_clockevent_tmrs[KINETIS_PIT_CHANNELS] = {
+	{
+		.evtdev = {
+			.name		= "kinetis-clockevent0",
+			.rating		= 200,
+			.features	=
+			    CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+			.set_next_event	= kinetis_clockevent_tmr_set_next_event,
+			.set_state_periodic =
+				kinetis_clockevent_tmr_set_state_periodic,
+			.set_state_oneshot =
+				kinetis_clockevent_tmr_set_state_oneshot,
+			.set_state_oneshot_stopped =
+				kinetis_clockevent_tmr_set_state_oneshot,
+			.set_state_shutdown =
+				kinetis_clockevent_tmr_set_state_oneshot,
+		},
+	},
+	{
+		.evtdev = {
+			.name		= "kinetis-clockevent1",
+		},
+	},
+	{
+		.evtdev = {
+			.name		= "kinetis-clockevent2",
+		},
+	},
+	{
+		.evtdev = {
+			.name		= "kinetis-clockevent3",
+		},
+	},
+};
+
+/*
+ * Timer IRQ handler
+ */
+static irqreturn_t kinetis_clockevent_tmr_irq_handler(int irq, void *dev_id)
+{
+	struct kinetis_clock_event_ddata *tmr = dev_id;
+
+	KINETIS_PIT_WR(tmr->big_endian, tmr->base, tflg,
+				KINETIS_PIT_TFLG_TIF_MSK);
+
+	tmr->evtdev.event_handler(&tmr->evtdev);
+
+	return IRQ_HANDLED;
+}
+
+static void __init kinetis_clockevent_init(struct device_node *np)
+{
+	const u64 max_delay_in_sec = 5;
+	struct device_node *child;
+	struct clk *clk;
+	void __iomem *base;
+	void __iomem *mcr;
+	unsigned long rate;
+	int irq, chan;
+	bool big_endian;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("failed to get clock for clockevent\n");
+		return;
+	}
+
+	if (clk_prepare_enable(clk)) {
+		pr_err("failed to enable timer clock for clockevent\n");
+		goto err_clk_enable;
+	}
+
+	rate = clk_get_rate(clk);
+	if (!(rate / HZ)) {
+		pr_err("failed to get proper clock rate for clockevent\n");
+		goto err_clk_enable;
+	}
+
+	mcr = of_iomap(np, 0);
+	if (!mcr) {
+		pr_err("failed to get mcr for clockevent\n");
+		goto err_iomap_mcr;
+	}
+
+	big_endian = of_property_read_bool(np, "big-endian");
+
+	for_each_child_of_node(np, child) {
+		if (!of_device_is_available(child))
+			continue;
+
+		chan = of_alias_get_id(child, "pit");
+		if ((chan < 0) || (chan >= KINETIS_PIT_CHANNELS)) {
+			pr_err("failed to calculate channel number for pit\n");
+			continue;
+		}
+
+		base = of_iomap(child, 0);
+		if (!base) {
+			pr_err("failed to get registers for pit%d\n", chan);
+			continue;
+		}
+
+		irq = irq_of_parse_and_map(child, 0);
+		if (irq <= 0) {
+			pr_err("failed to get irq for pit%d\n", chan);
+			iounmap(base);
+			continue;
+		}
+
+		kinetis_clockevent_tmrs[chan].big_endian = big_endian;
+		kinetis_clockevent_tmrs[chan].base = base;
+		kinetis_clockevent_tmrs[chan].mcr = mcr;
+
+		/*
+		 * Set the fields required for the set_next_event method
+		 * (tickless kernel support)
+		 */
+		clockevents_calc_mult_shift(
+					&kinetis_clockevent_tmrs[chan].evtdev,
+					rate, max_delay_in_sec);
+		kinetis_clockevent_tmrs[chan].evtdev.max_delta_ns =
+					max_delay_in_sec * NSEC_PER_SEC;
+		kinetis_clockevent_tmrs[chan].evtdev.min_delta_ns =
+				clockevent_delta2ns(0xf,
+					&kinetis_clockevent_tmrs[chan].evtdev);
+
+		clockevents_register_device(
+				&kinetis_clockevent_tmrs[chan].evtdev);
+
+		kinetis_pit_init(&kinetis_clockevent_tmrs[chan],
+						(rate / HZ) - 1);
+		kinetis_pit_enable(&kinetis_clockevent_tmrs[chan], 1);
+
+		if (request_irq(irq, kinetis_clockevent_tmr_irq_handler,
+					IRQF_TIMER | IRQF_IRQPOLL,
+					"kinetis-timer",
+					&kinetis_clockevent_tmrs[chan])) {
+			pr_err("failed to request irq for pit%d\n", chan);
+			kinetis_pit_enable(&kinetis_clockevent_tmrs[chan], 0);
+			continue;
+		}
+
+		pr_info("prepared pit%d at MMIO %#x\n", chan, (unsigned)base);
+	}
+
+	return;
+
+err_iomap_mcr:
+
+	clk_disable_unprepare(clk);
+err_clk_enable:
+
+	clk_put(clk);
+}
+
+CLOCKSOURCE_OF_DECLARE(kinetis_pit_timer, "fsl,kinetis-pit-timer",
+		       kinetis_clockevent_init);
-- 
2.3.6

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
