From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC v2 01/10] arm: fiq: Allow EOI to be communicated to the intc
Date: Fri, 23 May 2014 14:57:49 +0100
Message-ID: <1400853478-5824-2-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
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

Modern ARM systems require an EOI to be sent to the interrupt controller
on completion of both IRQ and FIQ. The FIQ code currently does not provide
any API to perform this. This patch provides this API, implemented by
hooking into main irq driver in a similar way to the existing
enable_fiq()/disable_fiq().

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/fiq.h |  1 +
 arch/arm/kernel/fiq.c      | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/fiq.h b/arch/arm/include/asm/fiq.h
index d493d0b..5a2a9b9 100644
--- a/arch/arm/include/asm/fiq.h
+++ b/arch/arm/include/asm/fiq.h
@@ -38,6 +38,7 @@ extern void release_fiq(struct fiq_handler *f);
 extern void set_fiq_handler(void *start, unsigned int length);
 extern void enable_fiq(int fiq);
 extern void disable_fiq(int fiq);
+extern void eoi_fiq(int fiq);
 
 /* helpers defined in fiqasm.S: */
 extern void __set_fiq_regs(unsigned long const *regs);
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 918875d..defbe85 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -40,6 +40,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
+#include <linux/irq.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
@@ -139,6 +140,15 @@ void disable_fiq(int fiq)
 	disable_irq(fiq + fiq_start);
 }
 
+void eoi_fiq(int fiq)
+{
+	struct irq_data *irq_data = irq_get_irq_data(fiq + fiq_start);
+	struct irq_chip *chip = irq_data_get_irq_chip(irq_data);
+
+	if (chip->irq_eoi)
+			chip->irq_eoi(irq_data);
+}
+
 EXPORT_SYMBOL(set_fiq_handler);
 EXPORT_SYMBOL(__set_fiq_regs);	/* defined in fiqasm.S */
 EXPORT_SYMBOL(__get_fiq_regs);	/* defined in fiqasm.S */
@@ -146,6 +156,7 @@ EXPORT_SYMBOL(claim_fiq);
 EXPORT_SYMBOL(release_fiq);
 EXPORT_SYMBOL(enable_fiq);
 EXPORT_SYMBOL(disable_fiq);
+EXPORT_SYMBOL(eoi_fiq);
 
 void __init init_FIQ(int start)
 {
-- 
1.9.0
