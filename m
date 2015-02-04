From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V2 10/34] MIPS: jz4740: remove non-DT interrupt controller init
Date: Wed, 4 Feb 2015 15:21:39 +0000
Message-ID: <1423063323-19419-11-git-send-email-Zubair.Kakakhel@imgtec.com>
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

The jz4740 now probes the interrupt controller using DT, so remove the
now dead non-DT init code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/irq.h |  2 --
 arch/mips/jz4740/irq.c                  | 25 +++++++------------------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
index 5ce4302..df50736 100644
--- a/arch/mips/include/asm/mach-jz4740/irq.h
+++ b/arch/mips/include/asm/mach-jz4740/irq.h
@@ -54,6 +54,4 @@
 
 #define NR_IRQS (JZ4740_IRQ_ADC_BASE + 6)
 
-extern void __init jz4740_intc_init(void);
-
 #endif
diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index a4f0a82..9a8bda3 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -77,10 +77,16 @@ static struct irqaction jz4740_cascade_action = {
 	.name = "JZ4740 cascade interrupt",
 };
 
-static void __init __jz4740_intc_init(int parent_irq)
+static int __init jz4740_intc_of_init(struct device_node *node,
+	struct device_node *parent)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
+	int parent_irq;
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq)
+		return -EINVAL;
 
 	jz_intc_base = ioremap(JZ4740_INTC_BASE_ADDR, 0x14);
 
@@ -105,23 +111,6 @@ static void __init __jz4740_intc_init(int parent_irq)
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0, IRQ_NOPROBE | IRQ_LEVEL);
 
 	setup_irq(parent_irq, &jz4740_cascade_action);
-}
-
-void __init jz4740_intc_init(void)
-{
-	__jz4740_intc_init(2);
-}
-
-static int __init jz4740_intc_of_init(struct device_node *node,
-	struct device_node *parent)
-{
-	int parent_irq;
-
-	parent_irq = irq_of_parse_and_map(node, 0);
-	if (!parent_irq)
-		return -EINVAL;
-
-	__jz4740_intc_init(parent_irq);
 	return 0;
 }
 IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
-- 
1.9.1
