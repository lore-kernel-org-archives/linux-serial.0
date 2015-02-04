From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 17/34] MIPS: clk: move jz4740_clock_set_wait_mode to jz4740-cgu
Date: Wed, 4 Feb 2015 15:21:46 +0000
Message-ID: <1423063323-19419-18-git-send-email-Zubair.Kakakhel@imgtec.com>
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
there too. Move jz4740_clock_set_wait_mode for such consistency.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Turquette <mturquette@linaro.org>
---
 arch/mips/jz4740/clock.c        | 16 ----------------
 drivers/clk/jz47xx/jz4740-cgu.c | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/mips/jz4740/clock.c b/arch/mips/jz4740/clock.c
index dedee7c..90b44d7 100644
--- a/arch/mips/jz4740/clock.c
+++ b/arch/mips/jz4740/clock.c
@@ -28,7 +28,6 @@
 
 #include "clock.h"
 
-#define JZ_REG_CLOCK_LOW_POWER	0x04
 #define JZ_REG_CLOCK_PLL	0x10
 #define JZ_REG_CLOCK_GATE	0x20
 
@@ -40,9 +39,6 @@
 #define JZ_CLOCK_PLL_STABLE		BIT(10)
 #define JZ_CLOCK_PLL_ENABLED		BIT(8)
 
-#define JZ_CLOCK_LOW_POWER_MODE_DOZE BIT(2)
-#define JZ_CLOCK_LOW_POWER_MODE_SLEEP BIT(0)
-
 static void __iomem *jz_clock_base;
 
 static uint32_t jz_clk_reg_read(int reg)
@@ -68,18 +64,6 @@ static void jz_clk_reg_clear_bits(int reg, uint32_t mask)
 	writel(val, jz_clock_base + reg);
 }
 
-void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode)
-{
-	switch (mode) {
-	case JZ4740_WAIT_MODE_IDLE:
-		jz_clk_reg_clear_bits(JZ_REG_CLOCK_LOW_POWER, JZ_CLOCK_LOW_POWER_MODE_SLEEP);
-		break;
-	case JZ4740_WAIT_MODE_SLEEP:
-		jz_clk_reg_set_bits(JZ_REG_CLOCK_LOW_POWER, JZ_CLOCK_LOW_POWER_MODE_SLEEP);
-		break;
-	}
-}
-
 void jz4740_clock_udc_disable_auto_suspend(void)
 {
 	jz_clk_reg_clear_bits(JZ_REG_CLOCK_GATE, JZ_CLOCK_GATE_UDC);
diff --git a/drivers/clk/jz47xx/jz4740-cgu.c b/drivers/clk/jz47xx/jz4740-cgu.c
index 83f1e1f..ef559e7 100644
--- a/drivers/clk/jz47xx/jz4740-cgu.c
+++ b/drivers/clk/jz47xx/jz4740-cgu.c
@@ -20,10 +20,12 @@
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <dt-bindings/clock/jz4740-cgu.h>
+#include <asm/mach-jz4740/clock.h>
 #include "jz47xx-cgu.h"
 
 /* CGU register offsets */
 #define CGU_REG_CPCCR		0x00
+#define CGU_REG_LCR		0x04
 #define CGU_REG_CPPCR		0x10
 #define CGU_REG_I2SCDR		0x60
 #define CGU_REG_LPCDR		0x64
@@ -42,6 +44,9 @@
 #define PLLCTL_BYPASS		(1 << 9)
 #define PLLCTL_ENABLE		(1 << 8)
 
+/* bits within the LCR register */
+#define LCR_SLEEP		(1 << 0)
+
 static struct jz47xx_cgu *cgu;
 
 static const s8 pll_od_encoding[4] = {
@@ -217,3 +222,20 @@ static void __init jz4740_cgu_init(struct device_node *np)
 		pr_err("%s: failed to register CGU Clocks\n", __func__);
 }
 CLK_OF_DECLARE(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
+
+void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode)
+{
+	uint32_t lcr = readl(cgu->base + CGU_REG_LCR);
+
+	switch (mode) {
+	case JZ4740_WAIT_MODE_IDLE:
+		lcr &= ~LCR_SLEEP;
+		break;
+
+	case JZ4740_WAIT_MODE_SLEEP:
+		lcr |= LCR_SLEEP;
+		break;
+	}
+
+	writel(lcr, cgu->base + CGU_REG_LCR);
+}
-- 
1.9.1
