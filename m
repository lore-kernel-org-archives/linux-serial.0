From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 19/34] MIPS: clk: move jz4740 clock suspend, resume functions to jz4740-cgu
Date: Wed, 4 Feb 2015 15:21:48 +0000
Message-ID: <1423063323-19419-20-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com, gregkh@linuxfoundation.org, mturquette@linaro.org, sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz, tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de, paul.burton@imgtec.com
List-Id: linux-serial@vger.kernel.org

From: Paul Burton <paul.burton@imgtec.com>

The jz4740-cgu driver already has access to the CGU, so it makes sense
to move the few remaining accesses to the CGU from arch/mips/jz4740
there too. Move the jz4740_clock_{suspend,resume} functions there for
such consistency. The arch/mips/jz4740/clock.c file now contains nothing
more of use & so is removed.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Turquette <mturquette@linaro.org>
---
 arch/mips/include/asm/mach-jz4740/clock.h |  2 -
 arch/mips/jz4740/Makefile                 |  2 +-
 arch/mips/jz4740/clock.c                  | 95 -------------------------------
 arch/mips/jz4740/time.c                   |  1 -
 drivers/clk/jz47xx/jz4740-cgu.c           | 34 +++++++++++
 5 files changed, 35 insertions(+), 99 deletions(-)
 delete mode 100644 arch/mips/jz4740/clock.c

diff --git a/arch/mips/include/asm/mach-jz4740/clock.h b/arch/mips/include/asm/mach-jz4740/clock.h
index 01d8468..16659cd 100644
--- a/arch/mips/include/asm/mach-jz4740/clock.h
+++ b/arch/mips/include/asm/mach-jz4740/clock.h
@@ -20,8 +20,6 @@ enum jz4740_wait_mode {
 	JZ4740_WAIT_MODE_SLEEP,
 };
 
-int jz4740_clock_init(void);
-
 void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode);
 
 void jz4740_clock_udc_enable_auto_suspend(void);
diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
index 80e326d..61168a2 100644
--- a/arch/mips/jz4740/Makefile
+++ b/arch/mips/jz4740/Makefile
@@ -5,7 +5,7 @@
 # Object file lists.
 
 obj-y += prom.o irq.o time.o reset.o setup.o \
-	gpio.o clock.o platform.o timer.o serial.o
+	gpio.o platform.o timer.o serial.o
 
 # board specific support
 
diff --git a/arch/mips/jz4740/clock.c b/arch/mips/jz4740/clock.c
deleted file mode 100644
index 2a10829..0000000
--- a/arch/mips/jz4740/clock.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 SoC clock support
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General	 Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/list.h>
-#include <linux/err.h>
-
-#include <asm/mach-jz4740/clock.h>
-#include <asm/mach-jz4740/base.h>
-
-#include "clock.h"
-
-#define JZ_REG_CLOCK_PLL	0x10
-#define JZ_REG_CLOCK_GATE	0x20
-
-#define JZ_CLOCK_GATE_UART0	BIT(0)
-#define JZ_CLOCK_GATE_TCU	BIT(1)
-#define JZ_CLOCK_GATE_DMAC	BIT(12)
-
-#define JZ_CLOCK_PLL_STABLE		BIT(10)
-#define JZ_CLOCK_PLL_ENABLED		BIT(8)
-
-static void __iomem *jz_clock_base;
-
-static uint32_t jz_clk_reg_read(int reg)
-{
-	return readl(jz_clock_base + reg);
-}
-
-static void jz_clk_reg_set_bits(int reg, uint32_t mask)
-{
-	uint32_t val;
-
-	val = readl(jz_clock_base + reg);
-	val |= mask;
-	writel(val, jz_clock_base + reg);
-}
-
-static void jz_clk_reg_clear_bits(int reg, uint32_t mask)
-{
-	uint32_t val;
-
-	val = readl(jz_clock_base + reg);
-	val &= ~mask;
-	writel(val, jz_clock_base + reg);
-}
-
-void jz4740_clock_suspend(void)
-{
-	jz_clk_reg_set_bits(JZ_REG_CLOCK_GATE,
-		JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0);
-
-	jz_clk_reg_clear_bits(JZ_REG_CLOCK_PLL, JZ_CLOCK_PLL_ENABLED);
-}
-
-void jz4740_clock_resume(void)
-{
-	uint32_t pll;
-
-	jz_clk_reg_set_bits(JZ_REG_CLOCK_PLL, JZ_CLOCK_PLL_ENABLED);
-
-	do {
-		pll = jz_clk_reg_read(JZ_REG_CLOCK_PLL);
-	} while (!(pll & JZ_CLOCK_PLL_STABLE));
-
-	jz_clk_reg_clear_bits(JZ_REG_CLOCK_GATE,
-		JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0);
-}
-
-int jz4740_clock_init(void)
-{
-	jz_clock_base = ioremap(JZ4740_CPM_BASE_ADDR, 0x100);
-	if (!jz_clock_base)
-		return -EBUSY;
-
-	return 0;
-}
diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
index caa796d..121ec3a 100644
--- a/arch/mips/jz4740/time.c
+++ b/arch/mips/jz4740/time.c
@@ -114,7 +114,6 @@ void __init plat_time_init(void)
 	struct clk *ext_clk;
 
 	of_clk_init(NULL);
-	jz4740_clock_init();
 	jz4740_timer_init();
 
 	ext_clk = clk_get(NULL, "ext");
diff --git a/drivers/clk/jz47xx/jz4740-cgu.c b/drivers/clk/jz47xx/jz4740-cgu.c
index 46b6c1a..3325bd8 100644
--- a/drivers/clk/jz47xx/jz4740-cgu.c
+++ b/drivers/clk/jz47xx/jz4740-cgu.c
@@ -259,3 +259,37 @@ void jz4740_clock_udc_enable_auto_suspend(void)
 	writel(clkgr, cgu->base + CGU_REG_CLKGR);
 }
 EXPORT_SYMBOL_GPL(jz4740_clock_udc_enable_auto_suspend);
+
+#define JZ_CLOCK_GATE_UART0	BIT(0)
+#define JZ_CLOCK_GATE_TCU	BIT(1)
+#define JZ_CLOCK_GATE_DMAC	BIT(12)
+
+void jz4740_clock_suspend(void)
+{
+	uint32_t clkgr, cppcr;
+
+	clkgr = readl(cgu->base + CGU_REG_CLKGR);
+	clkgr |= JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0;
+	writel(clkgr, cgu->base + CGU_REG_CLKGR);
+
+	cppcr = readl(cgu->base + CGU_REG_CPPCR);
+	cppcr &= ~BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.enable_bit);
+	writel(cppcr, cgu->base + CGU_REG_CPPCR);
+}
+
+void jz4740_clock_resume(void)
+{
+	uint32_t clkgr, cppcr;
+
+	cppcr = readl(cgu->base + CGU_REG_CPPCR);
+	cppcr |= BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.enable_bit);
+	writel(cppcr, cgu->base + CGU_REG_CPPCR);
+
+	do {
+		cppcr = readl(cgu->base + CGU_REG_CPPCR);
+	} while (!(cppcr & BIT(jz4740_cgu_clocks[JZ4740_CLK_PLL].pll.stable_bit)));
+
+	clkgr = readl(cgu->base + CGU_REG_CLKGR);
+	clkgr &= ~(JZ_CLOCK_GATE_TCU | JZ_CLOCK_GATE_DMAC | JZ_CLOCK_GATE_UART0);
+	writel(clkgr, cgu->base + CGU_REG_CLKGR);
+}
-- 
1.9.1
