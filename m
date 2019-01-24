From: Erin Lo <erin.lo@mediatek.com>
Subject: [PATCH v6 1/6] irqchip/mtk-sysirq: support 4 interrupt parameters for sysirq
Date: Thu, 24 Jan 2019 16:07:15 +0800
Message-ID: <1548317240-44682-2-git-send-email-erin.lo@mediatek.com>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, erin.lo@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, Seiya Wang <seiya.wang@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Seiya Wang <seiya.wang@mediatek.com>

To support partitioned PPIs, 4 interrupt parameters should be valid
for sysirq.

Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 drivers/irqchip/irq-mtk-sysirq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 90aaf19..282736a 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -81,7 +81,7 @@ static int mtk_sysirq_domain_translate(struct irq_domain *d,
 				       unsigned int *type)
 {
 	if (is_of_node(fwspec->fwnode)) {
-		if (fwspec->param_count != 3)
+		if (fwspec->param_count != 3 && fwspec->param_count != 4)
 			return -EINVAL;
 
 		/* No PPI should point to this domain */
@@ -104,7 +104,7 @@ static int mtk_sysirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	struct irq_fwspec *fwspec = arg;
 	struct irq_fwspec gic_fwspec = *fwspec;
 
-	if (fwspec->param_count != 3)
+	if (fwspec->param_count != 3 && fwspec->param_count != 4)
 		return -EINVAL;
 
 	/* sysirq doesn't support PPI */
-- 
1.9.1
