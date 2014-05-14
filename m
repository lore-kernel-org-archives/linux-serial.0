From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC 2/8] irqchip: gic: Provide support for interrupt grouping
Date: Wed, 14 May 2014 16:58:39 +0100
Message-ID: <1400083125-1464-3-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, Frederic Weisbecker <fweisbec@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@lin>
List-Id: linux-serial@vger.kernel.org

GICv2+ implementions that do not implement security extensions (and
devices that boot in secure mode by default) allow the interrupt group
registers (used for FIQ/IRQ selection) to be accessed from kernel code.
However the current gic support does not initialize the controller to
make interrupt grouping effective.

The registers involved are RAZ/WI when unimplemented or protected by
security policy then it should be safe to set up the grouping
unconditionally.

Tested on a (self-written) qemu GICv2 model (written from ARM spec) and
an STiH416 (ARM Cortex A9).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/irqchip/irq-gic.c       | 35 ++++++++++++++++++++++++++++++-----
 include/linux/irqchip/arm-gic.h |  3 +++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 57d165e..aa8efe4 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -408,13 +408,27 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
 		writel_relaxed(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);
 
 	/*
+	 * Set all global interrupts to be group 1.
+	 *
+	 * If grouping is not available (not implemented or prohibited by
+	 * security mode) these registers a read-as-zero/write-ignored.
+	 */
+	for (i = 32; i < gic_irqs; i += 32)
+		writel_relaxed(0xffffffff, base + GIC_DIST_IGROUP + i * 4 / 32);
+
+	/*
 	 * Disable all interrupts.  Leave the PPI and SGIs alone
 	 * as these enables are banked registers.
 	 */
 	for (i = 32; i < gic_irqs; i += 32)
 		writel_relaxed(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
 
-	writel_relaxed(1, base + GIC_DIST_CTRL);
+	/*
+	 * Set EnableGrp1/EnableGrp0 (bit 1 and 0) or EnableGrp (bit 0 only,
+	 * bit 1 ignored)
+	 */
+	writel_relaxed(GIC_DIST_CTRL_ENABLE_GRP0_BIT |
+		       GIC_DIST_CTRL_ENABLE_GRP1_BIT, base + GIC_DIST_CTRL);
 }
 
 static void gic_cpu_init(struct gic_chip_data *gic)
@@ -452,8 +466,16 @@ static void gic_cpu_init(struct gic_chip_data *gic)
 	for (i = 0; i < 32; i += 4)
 		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
 
+	/*
+	 * Set all PPI and SGI interrupts to be group 1.
+	 *
+	 * If grouping is not available (not implemented or prohibited by
+	 * security mode) these registers are read-as-zero/write-ignored.
+	 */
+	writel_relaxed(0xffffffff, dist_base + GIC_DIST_IGROUP + 0);
+
 	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
-	writel_relaxed(1, base + GIC_CPU_CTRL);
+	writel_relaxed(0x1f, base + GIC_CPU_CTRL);
 }
 
 void gic_cpu_if_down(void)
@@ -537,7 +559,9 @@ static void gic_dist_restore(unsigned int gic_nr)
 		writel_relaxed(gic_data[gic_nr].saved_spi_enable[i],
 			dist_base + GIC_DIST_ENABLE_SET + i * 4);
 
-	writel_relaxed(1, dist_base + GIC_DIST_CTRL);
+	writel_relaxed(GIC_DIST_CTRL_ENABLE_GRP0_BIT |
+			   GIC_DIST_CTRL_ENABLE_GRP1_BIT,
+		       dist_base + GIC_DIST_CTRL);
 }
 
 static void gic_cpu_save(unsigned int gic_nr)
@@ -594,7 +618,7 @@ static void gic_cpu_restore(unsigned int gic_nr)
 		writel_relaxed(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4);
 
 	writel_relaxed(0xf0, cpu_base + GIC_CPU_PRIMASK);
-	writel_relaxed(1, cpu_base + GIC_CPU_CTRL);
+	writel_relaxed(0x1f, cpu_base + GIC_CPU_CTRL);
 }
 
 static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
@@ -670,7 +694,8 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	dmb(ishst);
 
 	/* this always happens on GIC0 */
-	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+	writel_relaxed(map << 16 | irq | 0x8000,
+		       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 7ed92d0..919502f 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -37,6 +37,9 @@
 #define GIC_DIST_SGI_PENDING_CLEAR	0xf10
 #define GIC_DIST_SGI_PENDING_SET	0xf20
 
+#define GIC_DIST_CTRL_ENABLE_GRP0_BIT	(1 << 0)
+#define GIC_DIST_CTRL_ENABLE_GRP1_BIT	(1 << 1)
+
 #define GICH_HCR			0x0
 #define GICH_VTR			0x4
 #define GICH_VMCR			0x8
-- 
1.9.0
