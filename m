From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v4 01/13] arm: fiq: Add callbacks to manage FIQ routings
Date: Thu, 19 Jun 2014 11:38:11 +0100
Message-ID: <1403174303-25456-2-git-send-email-daniel.thompson@linaro.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Fabio Estevam <festevam@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Currently enable_fiq/disable_fiq use a simple offset to convert an IRQ
virq into a FIQ virq. This is too inflexible for multi-platform kernels
and makes runtime error checking impossible.

We solve this by introducing a flexible mapping that allows interrupt
controllers that support FIQ to register those mappings. This, in turn,
makes it much possible for drivers in DT kernels to install FIQ handlers
without knowing anything about the interrupt controller.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/fiq.h |   7 +++
 arch/arm/kernel/fiq.c      | 103 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
index d493d0b..a7806ef 100644
--- a/arch/arm/include/asm/fiq.h
+++ b/arch/arm/include/asm/fiq.h
@@ -18,6 +18,11 @@
 
 #include <asm/ptrace.h>
 
+struct fiq_chip {
+	void (*fiq_enable)(struct irq_data *data);
+	void (*fiq_disable)(struct irq_data *data);
+};
+
 struct fiq_handler {
 	struct fiq_handler *next;
 	/* Name
@@ -38,6 +43,8 @@ extern void release_fiq(struct fiq_handler *f);
 extern void set_fiq_handler(void *start, unsigned int length);
 extern void enable_fiq(int fiq);
 extern void disable_fiq(int fiq);
+extern bool has_fiq(int fiq);
+extern void fiq_register_mapping(int irq, struct fiq_chip *chip);
 
 /* helpers defined in fiqasm.S: */
 extern void __set_fiq_regs(unsigned long const *regs);
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 918875d..567f8fd 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -40,6 +40,9 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
+#include <linux/irq.h>
+#include <linux/radix-tree.h>
+#include <linux/slab.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -52,7 +55,15 @@
 		(unsigned)&vector_fiq_offset;		\
 	})
 
+struct fiq_data {
+	struct fiq_chip *fiq_chip;
+	struct irq_data *irq_data;
+};
+
 static unsigned long no_fiq_insn;
+static int fiq_start = -1;
+static RADIX_TREE(fiq_data_tree, GFP_KERNEL);
+static DEFINE_MUTEX(fiq_data_mutex);
 
 /* Default reacquire function
  * - we always relinquish FIQ control
@@ -127,18 +138,65 @@ void release_fiq(struct fiq_handler *f)
 	while (current_fiq->fiq_op(current_fiq->dev_id, 0));
 }
 
-static int fiq_start;
+static struct fiq_data *lookup_fiq_data(int fiq)
+{
+	struct fiq_data *data;
+
+	rcu_read_lock();
+	data = radix_tree_lookup(&fiq_data_tree, fiq);
+	rcu_read_unlock();
+
+	return data;
+}
 
 void enable_fiq(int fiq)
 {
+	struct fiq_data *data = lookup_fiq_data(fiq);
+
+	if (data) {
+		if (data->fiq_chip->fiq_enable)
+			data->fiq_chip->fiq_enable(data->irq_data);
+		enable_irq(fiq);
+		return;
+	}
+
+	if (WARN_ON(fiq_start == -1))
+		return;
+
 	enable_irq(fiq + fiq_start);
 }
 
 void disable_fiq(int fiq)
 {
+	struct fiq_data *data = lookup_fiq_data(fiq);
+
+	if (data) {
+		if (data->fiq_chip->fiq_disable)
+			data->fiq_chip->fiq_disable(data->irq_data);
+		disable_irq(fiq);
+		return;
+	}
+
+	if (WARN_ON(fiq_start == -1))
+		return;
+
 	disable_irq(fiq + fiq_start);
 }
 
+bool has_fiq(int fiq)
+{
+	struct fiq_data *data = lookup_fiq_data(fiq);
+
+	if (data)
+		return true;
+
+	if (fiq_start == -1)
+		return false;
+
+	return fiq > fiq_start;
+}
+EXPORT_SYMBOL(has_fiq);
+
 EXPORT_SYMBOL(set_fiq_handler);
 EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
 EXPORT_SYMBOL(__get_fiq_regs);	/* defined in fiqasm.S */
@@ -147,9 +205,50 @@ EXPORT_SYMBOL(release_fiq);
 EXPORT_SYMBOL(enable_fiq);
 EXPORT_SYMBOL(disable_fiq);
 
+/*
+ * Add a mapping from a Linux irq to the fiq data.
+ */
+void fiq_register_mapping(int irq, struct fiq_chip *chip)
+{
+	struct fiq_data *fiq_data = NULL;
+	int res;
+
+	/* fiq_register_mapping can't be mixed with init_FIQ */
+	BUG_ON(fiq_start != -1);
+
+	fiq_data = kmalloc(sizeof(*fiq_data), GFP_KERNEL);
+	if (!fiq_data)
+		goto err;
+
+	fiq_data->fiq_chip = chip;
+	fiq_data->irq_data = irq_get_irq_data(irq);
+	BUG_ON(!fiq_data->irq_data);
+
+	mutex_lock(&fiq_data_mutex);
+	res = radix_tree_insert(&fiq_data_tree, irq, fiq_data);
+	mutex_unlock(&fiq_data_mutex);
+	if (res)
+		goto err;
+
+	return;
+
+err:
+	kfree(fiq_data);
+	pr_err("fiq: Cannot register mapping %d\n", irq);
+}
+
+/*
+ * Set the offset between normal IRQs and their FIQ shadows.
+ */
 void __init init_FIQ(int start)
 {
+	fiq_start = start;
+}
+
+static int __init init_default_fiq_handler(void)
+{
 	unsigned offset = FIQ_OFFSET;
 	no_fiq_insn = *(unsigned long *)(0xffff0000 + offset);
-	fiq_start = start;
+	return 0;
 }
+pure_initcall(init_default_fiq_handler);
-- 
1.9.3
