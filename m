From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH_V2 08/34] MIPS: jz4740: allow interrupt controller probe via DT
Date: Wed, 4 Feb 2015 15:21:37 +0000
Message-ID: <1423063323-19419-9-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423063323-19419-1-git-send-email-Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Declare the interrupt controller for probe via the standard irqchip_init
function.

Signed-off-by: Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 arch/mips/jz4740/irq.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index 1b742c3..a4f0a82 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/of_irq.h>
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -29,6 +30,8 @@
 
 #include <asm/mach-jz4740/base.h>
 
+#include "../../drivers/irqchip/irqchip.h"
+
 static void __iomem *jz_intc_base;
 
 #define JZ_REG_INTC_STATUS	0x00
@@ -74,7 +77,7 @@ static struct irqaction jz4740_cascade_action = {
 	.name = "JZ4740 cascade interrupt",
 };
 
-void __init jz4740_intc_init(void)
+static void __init __jz4740_intc_init(int parent_irq)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
@@ -101,8 +104,27 @@ void __init jz4740_intc_init(void)
 
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0, IRQ_NOPROBE | IRQ_LEVEL);
 
-	setup_irq(2, &jz4740_cascade_action);
+	setup_irq(parent_irq, &jz4740_cascade_action);
+}
+
+void __init jz4740_intc_init(void)
+{
+	__jz4740_intc_init(2);
+}
+
+static int __init jz4740_intc_of_init(struct device_node *node,
+	struct device_node *parent)
+{
+	int parent_irq;
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq)
+		return -EINVAL;
+
+	__jz4740_intc_init(parent_irq);
+	return 0;
 }
+IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", jz4740_intc_of_init);
 
 #ifdef CONFIG_DEBUG_FS
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
