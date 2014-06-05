From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC v3 5/9] irqchip: vic: Introduce shadow irqs for FIQ
Date: Thu,  5 Jun 2014 10:53:10 +0100
Message-ID: <1401961994-18033-6-git-send-email-daniel.thompson@linaro.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, linux-samsung-soc@vger.kernel.org, Ben
List-Id: linux-serial@vger.kernel.org

Currently on the ARM Versatile machine both FIQ and IRQ signals share
the same irq number. The effect of this is that enable_fiq() will
enable an interrupt but will leave it routed to IRQ. This requires a
driver utilizing FIQ to employ machine specific knowledge (i.e. that
the machine has a VIC).

By introducing shadow irqs to describe FIQs the VIC driver is able
to update the routing automatically during enable_fiq()/disable_fiq().

Changes to the vic_init() API allow individual machines to choose where
to fit the shadow irqs in the interrupt map and also to
choose not to have shadows at all.

This patch introduces shadows for mach-versatile whilst mach-ep93xx, mach-netx, mach-s3c64xx and plat-samsung retain unmodified interrupt maps.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: linux-samsung-soc@vger.kernel.org
---
 arch/arm/mach-ep93xx/core.c                 |   6 +-
 arch/arm/mach-netx/generic.c                |   3 +-
 arch/arm/mach-s3c64xx/common.c              |   6 +-
 arch/arm/mach-versatile/core.c              |   9 +--
 arch/arm/mach-versatile/include/mach/irqs.h |   5 +-
 arch/arm/plat-samsung/s5p-irq.c             |   3 +-
 drivers/irqchip/irq-vic.c                   | 102 +++++++++++++++++++++++-----
 include/linux/irqchip/arm-vic.h             |   8 ++-
 8 files changed, 113 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 0e571f1..aa26411 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -185,8 +185,10 @@ void __init ep93xx_timer_init(void)
  *************************************************************************/
 void __init ep93xx_init_irq(void)
 {
-	vic_init(EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_IRQ_MASK, 0);
-	vic_init(EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_IRQ_MASK, 0);
+	vic_init(EP93XX_VIC1_BASE, 0, VIC_FIQ_START_NONE,
+		 EP93XX_VIC1_VALID_IRQ_MASK, 0);
+	vic_init(EP93XX_VIC2_BASE, 32, VIC_FIQ_START_NONE,
+		 EP93XX_VIC2_VALID_IRQ_MASK, 0);
 }
 
 
diff --git a/arch/arm/mach-netx/generic.c b/arch/arm/mach-netx/generic.c
index db25b0c..5398dcd 100644
--- a/arch/arm/mach-netx/generic.c
+++ b/arch/arm/mach-netx/generic.c
@@ -169,7 +169,8 @@ void __init netx_init_irq(void)
 {
 	int irq;
 
-	vic_init(io_p2v(NETX_PA_VIC), NETX_IRQ_VIC_START, ~0, 0);
+	vic_init(io_p2v(NETX_PA_VIC), NETX_IRQ_VIC_START, VIC_FIQ_START_NONE,
+		 ~0, 0);
 
 	for (irq = NETX_IRQ_HIF_CHAINED(0); irq <= NETX_IRQ_HIF_LAST; irq++) {
 		irq_set_chip_and_handler(irq, &netx_hif_chip,
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index 5c45aae..b98dd48 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -242,8 +242,10 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
 	printk(KERN_DEBUG "%s: initialising interrupts\n", __func__);
 
 	/* initialise the pair of VICs */
-	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, IRQ_VIC0_RESUME);
-	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, IRQ_VIC1_RESUME);
+	vic_init(VA_VIC0, IRQ_VIC0_BASE, VIC_FIQ_START_NONE, vic0_valid,
+		 IRQ_VIC0_RESUME);
+	vic_init(VA_VIC1, IRQ_VIC1_BASE, VIC_FIQ_START_NONE, vic1_valid,
+		 IRQ_VIC1_RESUME);
 }
 
 #define eint_offset(irq)	((irq) - IRQ_EINT(0))
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index f2c89fb..3444ca8 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -108,7 +108,8 @@ void __init versatile_init_irq(void)
 
 	np = of_find_matching_node_by_address(NULL, vic_of_match,
 					      VERSATILE_VIC_BASE);
-	__vic_init(VA_VIC_BASE, 0, IRQ_VIC_START, ~0, 0, np);
+	__vic_init(VA_VIC_BASE, 0, IRQ_VIC_START,
+		   np ? -1 : FIQ_VIC_START, ~0, 0, np);
 
 	writel(~0, VA_SIC_BASE + SIC_IRQ_ENABLE_CLEAR);
 
@@ -614,9 +615,9 @@ static struct pl022_ssp_controller ssp0_plat_data = {
  * These devices are connected via the DMA APB bridge
  */
 #define SCI_IRQ		{ IRQ_SCIINT }
-#define UART0_IRQ	{ IRQ_UARTINT0 }
-#define UART1_IRQ	{ IRQ_UARTINT1 }
-#define UART2_IRQ	{ IRQ_UARTINT2 }
+#define UART0_IRQ	{ IRQ_UARTINT0, FIQ_UARTINT0 }
+#define UART1_IRQ	{ IRQ_UARTINT1, FIQ_UARTINT1 }
+#define UART2_IRQ	{ IRQ_UARTINT2, FIQ_UARTINT2 }
 #define SSP_IRQ		{ IRQ_SSPINT }
 
 /* FPGA Primecells */
diff --git a/arch/arm/mach-versatile/include/mach/irqs.h b/arch/arm/mach-versatile/include/mach/irqs.h
index 0fd771c..68171d9 100644
--- a/arch/arm/mach-versatile/include/mach/irqs.h
+++ b/arch/arm/mach-versatile/include/mach/irqs.h
@@ -131,4 +131,7 @@
 #define IRQ_GPIO3_START		(IRQ_GPIO2_END + 1)
 #define IRQ_GPIO3_END		(IRQ_GPIO3_START + 31)
 
-#define NR_IRQS			(IRQ_GPIO3_END + 1)
+#define FIQ_VIC_START		(IRQ_GPIO3_END + 1)
+#define FIQ_VIC_END		(FIQ_VIC_START + (IRQ_VIC_END - IRQ_VIC_START))
+
+#define NR_IRQS			(FIQ_VIC_END + 1)
diff --git a/arch/arm/plat-samsung/s5p-irq.c b/arch/arm/plat-samsung/s5p-irq.c
index ddfaca9..ddb1138 100644
--- a/arch/arm/plat-samsung/s5p-irq.c
+++ b/arch/arm/plat-samsung/s5p-irq.c
@@ -26,6 +26,7 @@ void __init s5p_init_irq(u32 *vic, u32 num_vic)
 
 	/* initialize the VICs */
 	for (irq = 0; irq < num_vic; irq++)
-		vic_init(VA_VIC(irq), VIC_BASE(irq), vic[irq], 0);
+		vic_init(VA_VIC(irq), VIC_BASE(irq), VIC_FIQ_START_NONE,
+			 vic[irq], 0);
 #endif
 }
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 7d35287..748c5af 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -36,6 +36,9 @@
 
 #include <asm/exception.h>
 #include <asm/irq.h>
+#ifdef CONFIG_FIQ
+#include <asm/fiq.h>
+#endif
 
 #include "irqchip.h"
 
@@ -56,6 +59,8 @@
 
 #define VIC_PL192_VECT_ADDR		0xF00
 
+#define VIC_FIQ_SHADOW_OFFSET		32
+
 /**
  * struct vic_device - VIC PM device
  * @parent_irq: The parent IRQ number of the VIC if cascaded, or 0.
@@ -81,8 +86,11 @@ struct vic_device {
 	u32		soft_int;
 	u32		protect;
 	struct irq_domain *domain;
+	struct irq_domain *fiq_domain;
 };
 
+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+
 /* we cannot allocate memory when VICs are initially registered */
 static struct vic_device vic_devices[CONFIG_ARM_VIC_NR];
 
@@ -197,6 +205,9 @@ static int vic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 {
 	struct vic_device *v = d->host_data;
 
+	if (hwirq > VIC_FIQ_SHADOW_OFFSET)
+		hwirq -= VIC_FIQ_SHADOW_OFFSET;
+
 	/* Skip invalid IRQs, only register handlers for the real ones */
 	if (!(v->valid_sources & (1 << hwirq)))
 		return -EPERM;
@@ -261,6 +272,15 @@ static struct irq_domain_ops vic_irqdomain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
+#ifdef CONFIG_FIQ
+static void vic_map_fiq(int irq, int fiq, unsigned int length)
+{
+	fiq_add_mapping(irq, fiq, length);
+}
+#else
+static inline void vic_map_fiq(int irq, int fiq, unsigned int length) {}
+#endif
+
 /**
  * vic_register() - Register a VIC.
  * @base: The base address of the VIC.
@@ -277,7 +297,7 @@ static struct irq_domain_ops vic_irqdomain_ops = {
  * This also configures the IRQ domain for the VIC.
  */
 static void __init vic_register(void __iomem *base, unsigned int parent_irq,
-				unsigned int irq,
+				unsigned int irq, int fiq,
 				u32 valid_sources, u32 resume_sources,
 				struct device_node *node)
 {
@@ -307,6 +327,22 @@ static void __init vic_register(void __iomem *base, unsigned int parent_irq,
 	for (i = 0; i < fls(valid_sources); i++)
 		if (valid_sources & (1 << i))
 			irq_create_mapping(v->domain, i);
+
+	/* create FIQ shadow mapping for each IRQ */
+	if (fiq >= 0) {
+		v->fiq_domain = irq_domain_add_legacy(
+				node, fls(valid_sources), fiq,
+				VIC_FIQ_SHADOW_OFFSET, &vic_irqdomain_ops, v);
+		/* create an IRQ mapping for each valid IRQ */
+		for (i = 0; i < fls(valid_sources); i++)
+			if (valid_sources & (1 << i)) {
+				int fiq_virq = irq_create_mapping(
+				    v->fiq_domain, i + VIC_FIQ_SHADOW_OFFSET);
+				vic_map_fiq(irq_find_mapping(v->domain, i),
+					    fiq_virq, 1);
+			}
+	}
+
 	/* If no base IRQ was passed, figure out our allocated base */
 	if (irq)
 		v->irq = irq;
@@ -314,10 +350,36 @@ static void __init vic_register(void __iomem *base, unsigned int parent_irq,
 		v->irq = irq_find_mapping(v->domain, 0);
 }
 
+static inline bool vic_is_fiq(struct irq_data *d)
+{
+	return d->hwirq >= VIC_FIQ_SHADOW_OFFSET;
+}
+
+static inline unsigned int vic_irq(struct irq_data *d)
+{
+	return d->hwirq & (VIC_FIQ_SHADOW_OFFSET-1);
+}
+
+static void vic_set_fiq(struct irq_data *d, bool enable)
+{
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned int irq = vic_irq(d);
+	u32 val;
+
+	raw_spin_lock(&irq_controller_lock);
+	val = readl(base + VIC_INT_SELECT);
+	if (enable)
+		val |= 1 << irq;
+	else
+		val &= ~(1 << irq);
+	writel(val, base + VIC_INT_SELECT);
+	raw_spin_unlock(&irq_controller_lock);
+}
+
 static void vic_ack_irq(struct irq_data *d)
 {
 	void __iomem *base = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->hwirq;
+	unsigned int irq = vic_irq(d);
 	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
 	/* moreover, clear the soft-triggered, in case it was the reason */
 	writel(1 << irq, base + VIC_INT_SOFT_CLEAR);
@@ -326,17 +388,22 @@ static void vic_ack_irq(struct irq_data *d)
 static void vic_mask_irq(struct irq_data *d)
 {
 	void __iomem *base = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->hwirq;
+	unsigned int irq = vic_irq(d);
+	if (vic_is_fiq(d))
+		vic_set_fiq(d, false);
 	writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
 }
 
 static void vic_unmask_irq(struct irq_data *d)
 {
 	void __iomem *base = irq_data_get_irq_chip_data(d);
-	unsigned int irq = d->hwirq;
+	unsigned int irq = vic_irq(d);
+	if (vic_is_fiq(d))
+		vic_set_fiq(d, true);
 	writel(1 << irq, base + VIC_INT_ENABLE);
 }
 
+
 #if defined(CONFIG_PM)
 static struct vic_device *vic_from_irq(unsigned int irq)
 {
@@ -355,7 +422,7 @@ static struct vic_device *vic_from_irq(unsigned int irq)
 static int vic_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct vic_device *v = vic_from_irq(d->irq);
-	unsigned int off = d->hwirq;
+	unsigned int off = vic_irq(d);
 	u32 bit = 1 << off;
 
 	if (!v)
@@ -413,7 +480,8 @@ static void __init vic_clear_interrupts(void __iomem *base)
  *  and 020 within the page. We call this "second block".
  */
 static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
-			       u32 vic_sources, struct device_node *node)
+			       int fiq_start, u32 vic_sources,
+			       struct device_node *node)
 {
 	unsigned int i;
 	int vic_2nd_block = ((unsigned long)base & ~PAGE_MASK) != 0;
@@ -439,12 +507,12 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 		writel(32, base + VIC_PL190_DEF_VECT_ADDR);
 	}
 
-	vic_register(base, 0, irq_start, vic_sources, 0, node);
+	vic_register(base, 0, irq_start, fiq_start, vic_sources, 0, node);
 }
 
 void __init __vic_init(void __iomem *base, int parent_irq, int irq_start,
-			      u32 vic_sources, u32 resume_sources,
-			      struct device_node *node)
+		       int fiq_start, u32 vic_sources, u32 resume_sources,
+		       struct device_node *node)
 {
 	unsigned int i;
 	u32 cellid = 0;
@@ -462,7 +530,7 @@ void __init __vic_init(void __iomem *base, int parent_irq, int irq_start,
 
 	switch(vendor) {
 	case AMBA_VENDOR_ST:
-		vic_init_st(base, irq_start, vic_sources, node);
+		vic_init_st(base, irq_start, fiq_start, vic_sources, node);
 		return;
 	default:
 		printk(KERN_WARNING "VIC: unknown vendor, continuing anyways\n");
@@ -479,7 +547,8 @@ void __init __vic_init(void __iomem *base, int parent_irq, int irq_start,
 
 	vic_init2(base);
 
-	vic_register(base, parent_irq, irq_start, vic_sources, resume_sources, node);
+	vic_register(base, parent_irq, irq_start, fiq_start, vic_sources,
+		     resume_sources, node);
 }
 
 /**
@@ -490,9 +559,9 @@ void __init __vic_init(void __iomem *base, int parent_irq, int irq_start,
  * @resume_sources: bitmask of interrupt sources to allow for resume
  */
 void __init vic_init(void __iomem *base, unsigned int irq_start,
-		     u32 vic_sources, u32 resume_sources)
+		     int fiq_start, u32 vic_sources, u32 resume_sources)
 {
-	__vic_init(base, 0, irq_start, vic_sources, resume_sources, NULL);
+	__vic_init(base, 0, irq_start, -1, vic_sources, resume_sources, NULL);
 }
 
 /**
@@ -511,7 +580,7 @@ int __init vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
 	struct vic_device *v;
 
 	v = &vic_devices[vic_id];
-	__vic_init(base, parent_irq, 0, vic_sources, resume_sources, NULL);
+	__vic_init(base, parent_irq, 0, -1, vic_sources, resume_sources, NULL);
 	/* Return out acquired base */
 	return v->irq;
 }
@@ -535,9 +604,10 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 	of_property_read_u32(node, "valid-wakeup-mask", &wakeup_mask);
 
 	/*
-	 * Passing 0 as first IRQ makes the simple domain allocate descriptors
+	 * Passing 0 as first IRQ (and first FIQ) makes the domain allocate
+	 * descriptors.
 	 */
-	__vic_init(regs, 0, 0, interrupt_mask, wakeup_mask, node);
+	__vic_init(regs, 0, 0, -1, interrupt_mask, wakeup_mask, node);
 
 	return 0;
 }
diff --git a/include/linux/irqchip/arm-vic.h b/include/linux/irqchip/arm-vic.h
index ba46c79..fae480d 100644
--- a/include/linux/irqchip/arm-vic.h
+++ b/include/linux/irqchip/arm-vic.h
@@ -26,12 +26,16 @@
 #define VIC_INT_ENABLE			0x10	/* 1 = enable, 0 = disable */
 #define VIC_INT_ENABLE_CLEAR		0x14
 
+#define VIC_FIQ_START_NONE -1
+
 struct device_node;
 struct pt_regs;
 
 void __vic_init(void __iomem *base, int parent_irq, int irq_start,
-		u32 vic_sources, u32 resume_sources, struct device_node *node);
-void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
+		int fiq_start, u32 vic_sources, u32 resume_sources,
+		struct device_node *node);
+void vic_init(void __iomem *base, unsigned int irq_start, int fiq_start,
+	      u32 vic_sources, u32 resume_sources);
 int vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
 		      u32 vic_sources, u32 resume_sources);
 
-- 
1.9.0
