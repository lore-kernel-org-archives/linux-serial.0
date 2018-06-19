From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v5 5/7] dmaengine: imx-sdma: remove the maximum limitation for bd numbers
Date: Wed, 20 Jun 2018 00:57:02 +0800
Message-ID: <1529427424-12321-6-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de, dan.j.williams@intel.com, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

No this limitation now after virtual dma used since bd is allocated
dynamically instead of static.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d1d3494..9f1a462 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -285,7 +285,6 @@ struct sdma_context_data {
 	u32  scratch7;
 } __attribute__ ((packed));
 
-#define NUM_BD (int)(PAGE_SIZE / sizeof(struct sdma_buffer_descriptor))
 
 struct sdma_engine;
 
@@ -1290,13 +1289,6 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	if (ret)
 		goto err_bd_out;
 
-	if (sg_len > NUM_BD) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
-				channel, sg_len, NUM_BD);
-		ret = -EINVAL;
-		goto err_bd_out;
-	}
-
 	desc->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct sdma_buffer_descriptor *bd = &desc->bd[i];
@@ -1406,12 +1398,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	if (ret)
 		goto err_bd_out;
 
-	if (num_periods > NUM_BD) {
-		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
-				channel, num_periods, NUM_BD);
-		goto err_bd_out;
-	}
-
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
 				channel, period_len, 0xffff);
-- 
2.7.4
