From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC v3 4/9] irqchip: gic: Introduce shadow irqs for FIQ
Date: Thu,  5 Jun 2014 10:53:09 +0100
Message-ID: <1401961994-18033-5-git-send-email-daniel.thompson@linaro.org>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Sricharan R <r.sricharan@ti.com>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>
List-Id: linux-serial@vger.kernel.org

This patch registers two virqs for each interrupt source it supports.
Using multiple virqs allows the GIC driver to automatically modify the group
register, allowing the new virqs to be used as argument to enable_fiq().
This also allows FIQ resources to be described in the device tree's
interrupt list using a special flag (currently 0x80).

Both these aspects combine and allow a driver to deploy a FIQ handler
without any machine specific knowledge; it can be used effectively on
multi-arch kernels.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Sricharan R <r.sricharan@ti.com>
---
 drivers/irqchip/irq-gic.c | 62 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index aa8efe4..9a4712d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -42,12 +42,17 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/arm-gic.h>
 
+#ifdef CONFIG_FIQ
+#include <asm/fiq.h>
+#endif
 #include <asm/irq.h>
 #include <asm/exception.h>
 #include <asm/smp_plat.h>
 
 #include "irqchip.h"
 
+#define GIC_INTSPEC_IRQ_IS_FIQ (1 << 7)
+
 union gic_base {
 	void __iomem *common_base;
 	void __percpu * __iomem *percpu_base;
@@ -65,6 +70,7 @@ struct gic_chip_data {
 #endif
 	struct irq_domain *domain;
 	unsigned int gic_irqs;
+	unsigned int fiq_shadow_offset;
 #ifdef CONFIG_GIC_NON_BANKED
 	void __iomem *(*get_base)(union gic_base *);
 #endif
@@ -143,11 +149,34 @@ static inline void __iomem *gic_cpu_base(struct irq_data *d)
 	return gic_data_cpu_base(gic_data);
 }
 
+static inline bool gic_is_fiq(struct irq_data *d)
+{
+	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
+	return d->hwirq > gic_data->gic_irqs;
+}
+
 static inline unsigned int gic_irq(struct irq_data *d)
 {
+	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
+	if (gic_is_fiq(d))
+		return d->hwirq - gic_data->fiq_shadow_offset;
 	return d->hwirq;
 }
 
+static void gic_set_group_irq(struct irq_data *d, int group)
+{
+	unsigned int reg = gic_irq(d) / 32 * 4;
+	u32 mask = 1 << (gic_irq(d) % 32);
+	u32 val;
+
+	val = readl_relaxed(gic_dist_base(d) + GIC_DIST_IGROUP + reg);
+	if (group)
+		val |= mask;
+	else
+		val &= ~mask;
+	writel_relaxed(val, gic_dist_base(d) + GIC_DIST_IGROUP + reg);
+}
+
 /*
  * Routines to acknowledge, disable and enable interrupts
  */
@@ -159,6 +188,8 @@ static void gic_mask_irq(struct irq_data *d)
 	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
 	if (gic_arch_extn.irq_mask)
 		gic_arch_extn.irq_mask(d);
+	if (gic_is_fiq(d))
+		gic_set_group_irq(d, 1);
 	raw_spin_unlock(&irq_controller_lock);
 }
 
@@ -167,6 +198,8 @@ static void gic_unmask_irq(struct irq_data *d)
 	u32 mask = 1 << (gic_irq(d) % 32);
 
 	raw_spin_lock(&irq_controller_lock);
+	if (gic_is_fiq(d))
+		gic_set_group_irq(d, 0);
 	if (gic_arch_extn.irq_unmask)
 		gic_arch_extn.irq_unmask(d);
 	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
@@ -940,7 +973,12 @@ static int gic_routable_irq_domain_xlate(struct irq_domain *d,
 				unsigned long *out_hwirq,
 				unsigned int *out_type)
 {
+	struct gic_chip_data *gic_data = d->host_data;
 	*out_hwirq += 16;
+
+	if (intspec[2] & GIC_INTSPEC_IRQ_IS_FIQ)
+		*out_hwirq += gic_data->fiq_shadow_offset;
+
 	return 0;
 }
 
@@ -1026,10 +1064,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	gic->gic_irqs = gic_irqs;
 
 	gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
+	gic->fiq_shadow_offset = gic_irqs;
 
 	if (of_property_read_u32(node, "arm,routable-irqs",
 				 &nr_routable_irqs)) {
-		irq_base = irq_alloc_descs(irq_start, 16, gic_irqs,
+		irq_base = irq_alloc_descs(irq_start, 16, 2 * gic_irqs,
 					   numa_node_id());
 		if (IS_ERR_VALUE(irq_base)) {
 			WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
@@ -1037,17 +1076,28 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 			irq_base = irq_start;
 		}
 
-		gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
-					hwirq_base, &gic_irq_domain_ops, gic);
+		gic->domain =
+		    irq_domain_add_legacy(node, 2 * gic_irqs, irq_base,
+					  hwirq_base, &gic_irq_domain_ops, gic);
 	} else {
-		gic->domain = irq_domain_add_linear(node, nr_routable_irqs,
-						    &gic_irq_domain_ops,
-						    gic);
+		gic->domain = irq_domain_add_linear(node, 2 * nr_routable_irqs,
+						    &gic_irq_domain_ops, gic);
 	}
 
 	if (WARN_ON(!gic->domain))
 		return;
 
+#ifdef CONFIG_FIQ
+	/* FIQ can only be supported on platforms without an extended irq_eoi
+	 * method (otherwise we take a lock during irq_eoi handling).
+	 */
+	if (!gic_arch_extn.irq_eoi)
+		fiq_add_mapping(
+		    irq_linear_revmap(gic->domain, hwirq_base),
+		    irq_linear_revmap(gic->domain, hwirq_base + gic_irqs),
+		    gic_irqs);
+#endif
+
 	if (gic_nr == 0) {
 #ifdef CONFIG_SMP
 		set_smp_cross_call(gic_raise_softirq);
-- 
1.9.0
