From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v5 6/7] dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
Date: Wed, 20 Jun 2018 00:57:03 +0800
Message-ID: <1529427424-12321-7-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de, dan.j.williams@intel.com, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

There are lot of codes overlap between prep_sg and prep_cyclic function.
Add sdma_transfer_init() function to elimated the code overlap.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 83 ++++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9f1a462..f8becaf 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1248,6 +1248,40 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 	clk_disable(sdma->clk_ahb);
 }
 
+static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
+				enum dma_transfer_direction direction, u32 bds)
+{
+	struct sdma_desc *desc;
+
+	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
+	if (!desc)
+		goto err_out;
+
+	sdmac->status = DMA_IN_PROGRESS;
+	sdmac->direction = direction;
+	sdmac->flags = 0;
+
+	desc->chn_count = 0;
+	desc->chn_real_count = 0;
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->sdmac = sdmac;
+	desc->num_bd = bds;
+
+	if (sdma_alloc_bd(desc))
+		goto err_desc_out;
+
+	if (sdma_load_context(sdmac))
+		goto err_desc_out;
+
+	return desc;
+
+err_desc_out:
+	kfree(desc);
+err_out:
+	return NULL;
+}
+
 static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -1260,36 +1294,13 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	struct scatterlist *sg;
 	struct sdma_desc *desc;
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		return NULL;
-	sdmac->status = DMA_IN_PROGRESS;
-
-	sdmac->flags = 0;
-
-	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
+	desc = sdma_transfer_init(sdmac, direction, sg_len);
 	if (!desc)
 		goto err_out;
 
-	desc->buf_tail = 0;
-	desc->buf_ptail = 0;
-	desc->sdmac = sdmac;
-	desc->num_bd = sg_len;
-	desc->chn_real_count = 0;
-
-	if (sdma_alloc_bd(desc)) {
-		kfree(desc);
-		goto err_out;
-	}
-
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
 
-	sdmac->direction = direction;
-	ret = sdma_load_context(sdmac);
-	if (ret)
-		goto err_bd_out;
-
-	desc->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
@@ -1365,38 +1376,18 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	struct sdma_engine *sdma = sdmac->sdma;
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
-	int ret, i = 0, buf = 0;
+	int i = 0, buf = 0;
 	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		return NULL;
-
-	sdmac->status = DMA_IN_PROGRESS;
-
-	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
+	desc = sdma_transfer_init(sdmac, direction, num_periods);
 	if (!desc)
 		goto err_out;
 
-	desc->buf_tail = 0;
-	desc->buf_ptail = 0;
-	desc->sdmac = sdmac;
-	desc->num_bd = num_periods;
-	desc->chn_real_count = 0;
 	desc->period_len = period_len;
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
-	sdmac->direction = direction;
-
-	if (sdma_alloc_bd(desc)) {
-		kfree(desc);
-		goto err_bd_out;
-	}
-
-	ret = sdma_load_context(sdmac);
-	if (ret)
-		goto err_bd_out;
 
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
-- 
2.7.4
