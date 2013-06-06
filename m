From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH 08/13] irqchip: exynos-combiner: set irq base as 256 for Exynos5420
Date: Thu,  6 Jun 2013 16:31:22 +0530
Message-ID: <1370516488-25860-8-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>, Thomas Abraham <thomas.abraham@linaro.org>
List-Id: linux-serial@vger.kernel.org

Exynos5420 uses 256 GIC interrupts unlike the previous Exynos SoCs which had
upto 160 GIC interrupts. Since the exynos-combiner driver uses irq domain simple
to support some of the Exynos4 non-dt platforms, the irq_base is set temporarily
to 256 for Exynos5420 combiner interrupts.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/irqchip/exynos-combiner.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index a9d2b2f..465271f 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -267,7 +267,10 @@ static int __init combiner_of_init(struct device_node *np,
 	 * get their IRQ from DT, remove this in order to get dynamic
 	 * allocation.
 	 */
-	irq_base = 160;
+	if (soc_is_exynos5420())
+		irq_base = 256;
+	else
+		irq_base = 160;
 
 	combiner_init(combiner_base, np, max_nr, irq_base);
 
-- 
1.7.9.5
