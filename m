From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 06/34] MIPS: jz4740: move arch_init_irq out of arch/mips/jz4740/irq.c
Date: Wed, 4 Feb 2015 15:21:35 +0000
Message-ID: <1423063323-19419-7-git-send-email-Zubair.Kakakhel@imgtec.com>
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

In preparation for moving the jz4740 interrupt controller driver to
drivers/irqchip, move arch_init_irq into setup.c such that everything
remaining in irq.c is related to said jz4740 interrupt controller.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/irq.h | 2 ++
 arch/mips/jz4740/irq.c                  | 5 +----
 arch/mips/jz4740/setup.c                | 8 ++++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
index df50736..5ce4302 100644
--- a/arch/mips/include/asm/mach-jz4740/irq.h
+++ b/arch/mips/include/asm/mach-jz4740/irq.h
@@ -54,4 +54,6 @@
 
 #define NR_IRQS (JZ4740_IRQ_ADC_BASE + 6)
 
+extern void __init jz4740_intc_init(void);
+
 #endif
diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 999d64b..1b742c3 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -18,7 +18,6 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/irqchip.h>
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -75,13 +74,11 @@ static struct irqaction jz4740_cascade_action = {
 	.name = "JZ4740 cascade interrupt",
 };
 
-void __init arch_init_irq(void)
+void __init jz4740_intc_init(void)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 
-	irqchip_init();
-
 	jz_intc_base = ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
 
 	/* Mask all irqs */
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index d6bb7a3..4808730 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -16,6 +16,7 @@
 
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
@@ -24,6 +25,7 @@
 #include <asm/prom.h>
 
 #include <asm/mach-jz4740/base.h>
+#include <asm/mach-jz4740/irq.h>
 
 #include "reset.h"
 
@@ -78,3 +80,9 @@ const char *get_system_type(void)
 {
 	return "JZ4740";
 }
+
+void __init arch_init_irq(void)
+{
+	irqchip_init();
+	jz4740_intc_init();
+}
-- 
1.9.1
