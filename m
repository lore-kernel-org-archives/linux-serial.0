From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 4/6] clk: at91: implement suspend/resume for the PMC irqchip
Date: Mon,  2 Mar 2015 10:18:16 +0100
Message-ID: <1425287898-15093-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Mike Turquette <mturquette@linaro.org>, linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Wim Van Sebroeck <wim@iguana.be>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The irq line used by the PMC block is shared with several peripherals
including the init timer which is registering its handler with
IRQF_NO_SUSPEND.
Implement the appropriate suspend/resume callback for the PMC irqchip,
and inform irq core that PMC irq handler can be safely called while
the system is suspended by setting IRQF_COND_SUSPEND.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clk/at91/pmc.c | 20 +++++++++++++++++++-
 drivers/clk/at91/pmc.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index f07c815..3f27d21 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -89,12 +89,29 @@ static int pmc_irq_set_type(struct irq_data *d, unsigned type)
 	return 0;
 }
 
+static void pmc_irq_suspend(struct irq_data *d)
+{
+	struct at91_pmc *pmc = irq_data_get_irq_chip_data(d);
+
+	pmc->imr = pmc_read(pmc, AT91_PMC_IMR);
+	pmc_write(pmc, AT91_PMC_IDR, pmc->imr);
+}
+
+static void pmc_irq_resume(struct irq_data *d)
+{
+	struct at91_pmc *pmc = irq_data_get_irq_chip_data(d);
+
+	pmc_write(pmc, AT91_PMC_IER, pmc->imr);
+}
+
 static struct irq_chip pmc_irq = {
 	.name = "PMC",
 	.irq_disable = pmc_irq_mask,
 	.irq_mask = pmc_irq_mask,
 	.irq_unmask = pmc_irq_unmask,
 	.irq_set_type = pmc_irq_set_type,
+	.irq_suspend = pmc_irq_suspend,
+	.irq_resume = pmc_irq_resume,
 };
 
 static struct lock_class_key pmc_lock_class;
@@ -224,7 +241,8 @@ static struct at91_pmc *__init at91_pmc_init(struct device_node *np,
 		goto out_free_pmc;
 
 	pmc_write(pmc, AT91_PMC_IDR, 0xffffffff);
-	if (request_irq(pmc->virq, pmc_irq_handler, IRQF_SHARED, "pmc", pmc))
+	if (request_irq(pmc->virq, pmc_irq_handler,
+			IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc))
 		goto out_remove_irqdomain;
 
 	return pmc;
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 52d2041..69abb08 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -33,6 +33,7 @@ struct at91_pmc {
 	spinlock_t lock;
 	const struct at91_pmc_caps *caps;
 	struct irq_domain *irqdomain;
+	u32 imr;
 };
 
 static inline void pmc_lock(struct at91_pmc *pmc)
-- 
1.9.1
