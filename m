From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] dmaengine: implement pause and resume for dw_dmac
Date: Tue, 19 Apr 2011 02:31:32 +0200
Message-ID: <1303173092-21785-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: shiraz.hashim@st.com, amit.goel@st.com, Linus Walleij <linus.walleij@linaro.org>, armando.visconti@st.com, viresh.linux@gmail.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

It seems that the SPEAr needs this.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/dw_dmac.c      |   22 ++++++++++++++++++++--
 drivers/dma/dw_dmac_regs.h |    1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 9c25c7d..60ac779 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -801,8 +801,7 @@ static int dwc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	struct dw_desc		*desc, *_desc;
 	LIST_HEAD(list);
 
-	/* Only supports DMA_TERMINATE_ALL */
-	if (cmd != DMA_TERMINATE_ALL)
+	if (cmd != DMA_TERMINATE_ALL && cmd != DMA_PAUSE && cmd != DMA_RESUME)
 		return -ENXIO;
 
 	/*
@@ -813,11 +812,30 @@ static int dwc_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 	 */
 	spin_lock_bh(&dwc->lock);
 
+	if (cmd == DMA_RESUME) {
+		if (dwc->paused) {
+			channel_set_bit(dw, CH_EN, dwc->mask);
+			while (!dma_readl(dw, CH_EN) & dwc->mask)
+				cpu_relax();
+		}
+		spin_unlock_bh(&dwc->lock);
+		return 0;
+	}
+
 	channel_clear_bit(dw, CH_EN, dwc->mask);
 
 	while (dma_readl(dw, CH_EN) & dwc->mask)
 		cpu_relax();
 
+	if (cmd == DMA_PAUSE) {
+		dwc->paused = true;
+		spin_unlock_bh(&dwc->lock);
+		return 0;
+	}
+
+	/* Terminating a paused transfer */
+	dwc->paused = false;
+
 	/* active_list entries will end up before queued entries */
 	list_splice_init(&dwc->queue, &list);
 	list_splice_init(&dwc->active_list, &list);
diff --git a/drivers/dma/dw_dmac_regs.h b/drivers/dma/dw_dmac_regs.h
index 720f821..c968597 100644
--- a/drivers/dma/dw_dmac_regs.h
+++ b/drivers/dma/dw_dmac_regs.h
@@ -138,6 +138,7 @@ struct dw_dma_chan {
 	void __iomem		*ch_regs;
 	u8			mask;
 	u8			priority;
+	bool			paused;
 
 	spinlock_t		lock;
 
-- 
1.7.4
