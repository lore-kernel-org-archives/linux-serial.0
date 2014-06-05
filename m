From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC v3 1/9] arm: fiq: arbitrary mappings from IRQ to FIQ virqs
Date: Thu,  5 Jun 2014 10:53:06 +0100
Message-ID: <1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Fabio Estevam <festevam@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Currently enable_fiq/disable_fiq use a simple offset to convert an IRQ
virq into a FIQ virq. This is too inflexible for multi-platform kernels
and makes runtime error checking impossible.

We solve this by introducing a flexible mapping that allows interrupt
controllers that support FIQ to register those mappings. This, in turn,
makes it much possible for drivers in DT kernels to gain access to
FIQ virqs.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/fiq.h |  2 ++
 arch/arm/kernel/fiq.c      | 57 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
index d493d0b..75d98c6 100644
--- a/arch/arm/include/asm/fiq.h
+++ b/arch/arm/include/asm/fiq.h
@@ -36,8 +36,10 @@ struct fiq_handler {
 extern int claim_fiq(struct fiq_handler *f);
 extern void release_fiq(struct fiq_handler *f);
 extern void set_fiq_handler(void *start, unsigned int length);
+extern struct irq_data *lookup_fiq_irq_data(int fiq);
 extern void enable_fiq(int fiq);
 extern void disable_fiq(int fiq);
+extern void fiq_add_mapping(int irq, int fiq_virq, unsigned int length);
 
 /* helpers defined in fiqasm.S: */
 extern void __set_fiq_regs(unsigned long const *regs);
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 918875d..177939c 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -40,6 +40,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
+#include <linux/irq.h>
+#include <linux/radix-tree.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -53,6 +55,9 @@
 	})
 
 static unsigned long no_fiq_insn;
+static int fiq_start = -1;
+static RADIX_TREE(fiq_virq_tree, GFP_KERNEL);
+static DEFINE_MUTEX(fiq_virq_mutex);
 
 /* Default reacquire function
  * - we always relinquish FIQ control
@@ -60,8 +65,11 @@ static unsigned long no_fiq_insn;
  */
 static int fiq_def_op(void *ref, int relinquish)
 {
-	if (!relinquish)
+	if (!relinquish) {
+		unsigned offset = FIQ_OFFSET;
+		no_fiq_insn = *(unsigned long *)(0xffff0000 + offset);
 		set_fiq_handler(&no_fiq_insn, sizeof(no_fiq_insn));
+	}
 
 	return 0;
 }
@@ -127,16 +135,33 @@ void release_fiq(struct fiq_handler *f)
 	while (current_fiq->fiq_op(current_fiq->dev_id, 0));
 }
 
-static int fiq_start;
+struct irq_data *lookup_fiq_irq_data(int fiq)
+{
+	struct irq_data *d;
+
+	if (fiq_start != -1)
+		return irq_get_irq_data(fiq + fiq_start);
+
+	rcu_read_lock();
+	d = radix_tree_lookup(&fiq_virq_tree, fiq);
+	rcu_read_unlock();
+	return d;
+}
 
 void enable_fiq(int fiq)
 {
-	enable_irq(fiq + fiq_start);
+	struct irq_data *d = lookup_fiq_irq_data(fiq);
+	if (WARN_ON(!d))
+		return;
+	enable_irq(d->irq);
 }
 
 void disable_fiq(int fiq)
 {
-	disable_irq(fiq + fiq_start);
+	struct irq_data *d = lookup_fiq_irq_data(fiq);
+	if (WARN_ON(!d))
+		return;
+	disable_irq(d->irq);
 }
 
 EXPORT_SYMBOL(set_fiq_handler);
@@ -144,12 +169,32 @@ EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
 EXPORT_SYMBOL(__get_fiq_regs);	/* defined in fiqasm.S */
 EXPORT_SYMBOL(claim_fiq);
 EXPORT_SYMBOL(release_fiq);
+EXPORT_SYMBOL(lookup_fiq_irq_data);
 EXPORT_SYMBOL(enable_fiq);
 EXPORT_SYMBOL(disable_fiq);
 
+/*
+ * Add a mapping between a normal IRQ and a FIQ shadow.
+ */
+void fiq_add_mapping(int irq, int fiq_virq, unsigned int length)
+{
+	int i;
+
+	/* fiq_add_mapping can't be mixed with init_FIQ */
+	BUG_ON(fiq_start != -1);
+
+	mutex_lock(&fiq_virq_mutex);
+	for (i = 0; i < length; i++) {
+		int err = radix_tree_insert(&fiq_virq_tree, irq + i,
+					    irq_get_irq_data(fiq_virq + i));
+		if (err)
+			pr_err("fiq: Cannot map %d to %d\n", irq + i,
+			       fiq_virq + i);
+	}
+	mutex_unlock(&fiq_virq_mutex);
+}
+
 void __init init_FIQ(int start)
 {
-	unsigned offset = FIQ_OFFSET;
-	no_fiq_insn = *(unsigned long *)(0xffff0000 + offset);
 	fiq_start = start;
 }
-- 
1.9.0
