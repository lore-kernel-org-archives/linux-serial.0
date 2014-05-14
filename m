From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC 8/8] arm: fiq: Hack FIQ routing backdoors into GIC and VIC
Date: Wed, 14 May 2014 16:58:45 +0100
Message-ID: <1400083125-1464-9-git-send-email-daniel.thompson@linaro.org>
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

This is a hack to make it easy to check that the other interfaces in the
patchset make sense. It needs to be replaced by code to get the
interrupt controllers to expose FIQs.

Unless a better option presents itself I plan to double up each
interrupt source (so we get two virqs, one for regular interrupt and
one for FIQ). This is what most of the prior art around FIQ in Linux
has done in the past.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi          |  2 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi |  2 +-
 arch/arm/kernel/fiq.c                   | 39 +++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c               | 27 +++++++++++++++++++++++
 4 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 78746d2..a288898 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -99,7 +99,7 @@
 			compatible	= "st,asc";
 			status 		= "disabled";
 			reg		= <0xfe531000 0x2c>;
-			interrupts	= <0 210 0>;
+			interrupts	= <0 210 0>, <0 210 0>;
 			pinctrl-names 	= "default";
 			pinctrl-0 	= <&pinctrl_sbc_serial1>;
 			clocks          = <&CLK_SYSIN>;
diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index ac870fb..fab2a40 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -140,7 +140,7 @@
 			v2m_serial0: uart@090000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x090000 0x1000>;
-				interrupts = <5>;
+				interrupts = <5>, <5>;
 				clocks = <&v2m_oscclk2>, <&smbclk>;
 				clock-names = "uartclk", "apb_pclk";
 			};
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index defbe85..efce321 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -41,6 +41,7 @@
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
 #include <linux/irq.h>
+#include <linux/irqchip/arm-vic.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -130,14 +131,52 @@ void release_fiq(struct fiq_handler *f)
 
 static int fiq_start;
 
+/* These hacks use backdoors into the interrupt controller to perform FIQ/IRQ
+ * routing. These hacks are nasty and completely incompatible with (working)
+ * multiarch kernels. Additionally these hacks don't count enable/disable
+ * properly...
+ *
+ * This should probably all be replaced with virtual interrupt numbers
+ * that the intc already knows to bind to FIQ.
+ */
+#ifdef CONFIG_ARCH_VERSATILE
+#define USE_VIC_HACK
+#else
+#define USE_GIC_HACK
+#endif
+
 void enable_fiq(int fiq)
 {
+#ifdef USE_VIC_HACK
+	vic_set_fiq(fiq, true);
+#endif
+#ifdef USE_GIC_HACK
+{
+	struct irq_data *irq_data = irq_get_irq_data(fiq);
+
+	extern void gic_set_group_irq(struct irq_data *d, int group);
+	gic_set_group_irq(irq_data, 0);
+}
+#endif
+
 	enable_irq(fiq + fiq_start);
 }
 
 void disable_fiq(int fiq)
 {
 	disable_irq(fiq + fiq_start);
+
+#ifdef USE_VIC_HACK
+	vic_set_fiq(fiq, false);
+#endif
+#ifdef USE_GIC_HACK
+{
+	struct irq_data *irq_data = irq_get_irq_data(fiq);
+
+	extern void gic_set_group_irq(struct irq_data *d, int group);
+	gic_set_group_irq(irq_data, 1);
+}
+#endif
 }
 
 void eoi_fiq(int fiq)
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index aa8efe4..c25632b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -173,6 +173,33 @@ static void gic_unmask_irq(struct irq_data *d)
 	raw_spin_unlock(&irq_controller_lock);
 }
 
+/*static*/ void gic_set_group_irq(struct irq_data *d, int group)
+{
+	unsigned long flags;
+	unsigned int reg = gic_irq(d) / 32 * 4;
+	u32 mask = 1 << (gic_irq(d) % 32);
+	u32 val;
+
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
+	val = readl_relaxed(gic_dist_base(d) + GIC_DIST_IGROUP + reg);
+	if (group)
+		val |= mask;
+	else
+		val &= ~mask;
+	writel_relaxed(val, gic_dist_base(d) + GIC_DIST_IGROUP + reg);
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
+}
+
+/*static*/ int gic_get_group_irq(struct irq_data *d)
+{
+	unsigned int reg = gic_irq(d) / 32 * 4;
+	u32 mask = 1 << (gic_irq(d) % 32);
+	u32 val;
+
+	val = readl_relaxed(gic_dist_base(d) + GIC_DIST_IGROUP + reg);
+	return !!(val & mask);
+}
+
 static void gic_eoi_irq(struct irq_data *d)
 {
 	if (gic_arch_extn.irq_eoi) {
-- 
1.9.0
