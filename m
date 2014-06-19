From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v4 04/13] irqchip: gic: Add support for FIQ management
Date: Thu, 19 Jun 2014 11:38:14 +0100
Message-ID: <1403174303-25456-5-git-send-email-daniel.thompson@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
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

This patch introduces callbacks to route interrupts to or away
from the FIQ signal and registers these callbacks with the FIQ
infrastructure (if the device can supports it).

Both these aspects combine and allow a driver to deploy a FIQ handler
without any machine specific knowledge; it can be used effectively on
multi-platform kernels.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Sricharan R <r.sricharan@ti.com>
---
 drivers/irqchip/irq-gic.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index bbffca3..0300c08 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -366,6 +366,58 @@ static struct irq_chip gic_chip = {
 };
 
 #ifdef CONFIG_FIQ
+/*
+ * Shift an interrupt between Group 0 and Group 1.
+ *
+ * In addition to changing the group we also modify the priority to
+ * match what "ARM strongly recommends" for a system where no Group 1
+ * interrupt must ever preempt a Group 0 interrupt.
+ */
+static void gic_set_group_irq(struct irq_data *d, int group)
+{
+	unsigned int grp_reg = gic_irq(d) / 32 * 4;
+	u32 grp_mask = 1 << (gic_irq(d) % 32);
+	u32 grp_val;
+
+	unsigned int pri_reg = (gic_irq(d) / 4) * 4;
+	u32 pri_mask = 1 << (7 + ((gic_irq(d) % 4) * 8));
+	u32 pri_val;
+
+	raw_spin_lock(&irq_controller_lock);
+
+	grp_val = readl_relaxed(gic_dist_base(d) + GIC_DIST_IGROUP + grp_reg);
+	pri_val = readl_relaxed(gic_dist_base(d) + GIC_DIST_PRI + pri_reg);
+
+	if (group) {
+		grp_val |= grp_mask;
+		pri_val |= pri_mask;
+	} else {
+		grp_val &= ~grp_mask;
+		pri_val &= ~pri_mask;
+	}
+
+	writel_relaxed(grp_val, gic_dist_base(d) + GIC_DIST_IGROUP + grp_reg);
+	writel_relaxed(pri_val, gic_dist_base(d) + GIC_DIST_PRI + pri_reg);
+
+	raw_spin_unlock(&irq_controller_lock);
+}
+
+static void gic_enable_fiq(struct irq_data *d)
+{
+	gic_set_group_irq(d, 0);
+}
+
+static void gic_disable_fiq(struct irq_data *d)
+{
+	gic_set_group_irq(d, 1);
+}
+
+static struct fiq_chip gic_fiq = {
+	.fiq_enable		= gic_enable_fiq,
+	.fiq_disable            = gic_disable_fiq,
+	.fiq_eoi		= gic_eoi_irq,
+};
+
 static void __init gic_init_fiq(struct gic_chip_data *gic,
 				irq_hw_number_t first_irq,
 				unsigned int num_irqs)
@@ -394,6 +446,12 @@ static void __init gic_init_fiq(struct gic_chip_data *gic,
 
 	if (!gic->fiq_enable)
 		return;
+
+	/*
+	 * FIQ is supported on this device! Register our chip data.
+	 */
+	for (i = 0; i < num_irqs; i++)
+		fiq_register_mapping(first_irq + i, &gic_fiq);
 }
 #else /* CONFIG_FIQ */
 static inline void gic_init_fiq(struct gic_chip_data *gic,
-- 
1.9.3
