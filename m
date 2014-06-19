From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v4 05/13] irqchip: gic: Remove spin locks from eoi_irq
Date: Thu, 19 Jun 2014 11:38:15 +0100
Message-ID: <1403174303-25456-6-git-send-email-daniel.thompson@linaro.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This patch is motivated by the comment it removes from gic_init_fiq,
namely that the spin locks in eoi_irq preclude certain platforms from
supporting FIQ.

Currently there is only one upstream platform (tegra) that actually
hooks gic_arch_extn.irq_eoi and it does not require these spin locks.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/irqchip/irq-gic.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 0300c08..1cbff1d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -191,11 +191,8 @@ static void gic_unmask_irq(struct irq_data *d)
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	if (gic_arch_extn.irq_eoi) {
-		raw_spin_lock(&irq_controller_lock);
+	if (gic_arch_extn.irq_eoi)
 		gic_arch_extn.irq_eoi(d);
-		raw_spin_unlock(&irq_controller_lock);
-	}
 
 	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
 }
@@ -426,13 +423,6 @@ static void __init gic_init_fiq(struct gic_chip_data *gic,
 	unsigned int i;
 
 	/*
-	 * FIQ can only be supported on platforms without an extended irq_eoi
-	 * method (otherwise we take a lock during eoi handling).
-	 */
-	if (gic_arch_extn.irq_eoi)
-		return;
-
-	/*
 	 * If grouping is not available (not implemented or prohibited by
 	 * security mode) these registers a read-as-zero/write-ignored.
 	 * However as a precaution we restore the reset default regardless of
-- 
1.9.3
