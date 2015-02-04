From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 22/34] MIPS: jz4740: support >32 interrupts
Date: Wed, 4 Feb 2015 15:21:51 +0000
Message-ID: <1423063323-19419-23-git-send-email-Zubair.Kakakhel@imgtec.com>
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

On later jz47xx series SoCs the interrupt controller supports more than
32 interrupts, which it does by duplicating the registers at intervals
of 0x20 bytes within its address space. Add support for an arbitrary
number of interrupts using multiple generic chips, and provide the
number of chips to register from the SoC-specific probe function.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/irq.c | 58 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index a620b23..3e53a32 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -33,21 +33,27 @@
 #include "../../drivers/irqchip/irqchip.h"
 
 static void __iomem *jz_intc_base;
+static unsigned jz_num_chips;
 
 #define JZ_REG_INTC_STATUS	0x00
 #define JZ_REG_INTC_MASK	0x04
 #define JZ_REG_INTC_SET_MASK	0x08
 #define JZ_REG_INTC_CLEAR_MASK	0x0c
 #define JZ_REG_INTC_PENDING	0x10
+#define CHIP_SIZE		0x20
 
 static irqreturn_t jz4740_cascade(int irq, void *data)
 {
 	uint32_t irq_reg;
+	unsigned i;
 
-	irq_reg = readl(jz_intc_base + JZ_REG_INTC_PENDING);
+	for (i = 0; i < jz_num_chips; i++) {
+		irq_reg = readl(jz_intc_base + (i * CHIP_SIZE) + JZ_REG_INTC_PENDING);
+		if (!irq_reg)
+			continue;
 
-	if (irq_reg)
-		generic_handle_irq(__fls(irq_reg) + JZ4740_IRQ_BASE);
+		generic_handle_irq(__fls(irq_reg) + (i * 32) + JZ4740_IRQ_BASE);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -77,39 +83,43 @@ static struct irqaction jz4740_cascade_action = {
 	.name = "JZ4740 cascade interrupt",
 };
 
-static int __init jz4740_intc_of_init(struct device_node *node,
-	struct device_node *parent)
+static int __init jz47xx_intc_of_init(struct device_node *node, unsigned num_chips)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	struct irq_domain *domain;
 	int parent_irq;
+	unsigned i;
 
 	parent_irq = irq_of_parse_and_map(node, 0);
 	if (!parent_irq)
 		return -EINVAL;
 
-	jz_intc_base = ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
+	jz_num_chips = num_chips;
+	jz_intc_base = ioremap(JZ4740_INTC_BASE_ADDR,
+			       ((num_chips - 1) * CHIP_SIZE) + 0x14);
 
-	/* Mask all irqs */
-	writel(0xffffffff, jz_intc_base + JZ_REG_INTC_SET_MASK);
+	for (i = 0; i < num_chips; i++) {
+		/* Mask all irqs */
+		writel(0xffffffff, jz_intc_base + (i * CHIP_SIZE) + JZ_REG_INTC_SET_MASK);
 
-	gc = irq_alloc_generic_chip("INTC", 1, JZ4740_IRQ_BASE, jz_intc_base,
-		handle_level_irq);
+		gc = irq_alloc_generic_chip("INTC", 1, JZ4740_IRQ_BASE + (i * 32),
+					    jz_intc_base + (i * CHIP_SIZE), handle_level_irq);
 
-	gc->wake_enabled = IRQ_MSK(32);
+		gc->wake_enabled = IRQ_MSK(32);
 
-	ct = gc->chip_types;
-	ct->regs.enable = JZ_REG_INTC_CLEAR_MASK;
-	ct->regs.disable = JZ_REG_INTC_SET_MASK;
-	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
-	ct->chip.irq_mask = irq_gc_mask_disable_reg;
-	ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
-	ct->chip.irq_set_wake = irq_gc_set_wake;
-	ct->chip.irq_suspend = jz4740_irq_suspend;
-	ct->chip.irq_resume = jz4740_irq_resume;
+		ct = gc->chip_types;
+		ct->regs.enable = JZ_REG_INTC_CLEAR_MASK;
+		ct->regs.disable = JZ_REG_INTC_SET_MASK;
+		ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
+		ct->chip.irq_mask = irq_gc_mask_disable_reg;
+		ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
+		ct->chip.irq_set_wake = irq_gc_set_wake;
+		ct->chip.irq_suspend = jz4740_irq_suspend;
+		ct->chip.irq_resume = jz4740_irq_resume;
 
-	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0, IRQ_NOPROBE | IRQ_LEVEL);
+		irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0, IRQ_NOPROBE | IRQ_LEVEL);
+	}
 
 	domain = irq_domain_add_legacy(node, num_chips * 32, JZ4740_IRQ_BASE, 0,
 				       &irq_domain_simple_ops, NULL);
@@ -119,6 +129,12 @@ static int __init jz4740_intc_of_init(struct device_node *node,
 	setup_irq(parent_irq, &jz4740_cascade_action);
 	return 0;
 }
+
+static int __init jz4740_intc_of_init(struct device_node *node,
+	struct device_node *parent)
+{
+	return jz47xx_intc_of_init(node, 1);
+}
 IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
 
 #ifdef CONFIG_DEBUG_FS
-- 
1.9.1
