From: Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH 2/4] dmaengine: imx-sdma: fix dma freezes
Date: Wed, 11 Sep 2019 16:49:41 +0200
Message-ID: <20190911144943.21554-3-philipp.puschmann@emlix.com>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190911144943.21554-1-philipp.puschmann@emlix.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, jslaby@suse.com, vkoul@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, gregkh@linuxfoundation.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, festevam@gmail.com, Philipp Puschmann <philipp.puschmann@emlix.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For some years and since many kernel versions there are reports that the
RX UART SDMA channel stops working at some point. The workaround was to
disable DMA for RX. This commit tries to fix the problem itself.

Due to its license i wasn't able to debug the sdma script itself but it
somehow leads to blocking the scheduling of the channel script when a
running sdma script does not find any usable destination buffer to put its
data into.

If we detect such a potential case we manually retrigger the sdma script
for this channel and by this reenable the scipt being run by scheduler.

As sdmac->desc is constant we can move desc out of the loop.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---
 drivers/dma/imx-sdma.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 1abb14ff394d..6a5a84504858 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -775,21 +775,23 @@ static void sdma_start_desc(struct sdma_channel *sdmac)
 static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 {
 	struct sdma_buffer_descriptor *bd;
-	int error = 0;
-	enum dma_status	old_status = sdmac->status;
+	struct sdma_desc *desc = sdmac->desc;
+	int error = 0, cnt = 0;
+	enum dma_status old_status = sdmac->status;
 
 	/*
 	 * loop mode. Iterate over descriptors, re-setup them and
 	 * call callback function.
 	 */
-	while (sdmac->desc) {
-		struct sdma_desc *desc = sdmac->desc;
+	while (desc) {
 
 		bd = &desc->bd[desc->buf_tail];
 
 		if (bd->mode.status & BD_DONE)
 			break;
 
+		cnt++;
+
 		if (bd->mode.status & BD_RROR) {
 			bd->mode.status &= ~BD_RROR;
 			sdmac->status = DMA_ERROR;
@@ -821,6 +823,18 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		if (error)
 			sdmac->status = old_status;
 	}
+
+	/* In some situations it happens that the sdma stops serving
+	 * dma interrupt requests. It happens when running dma script
+	 * does not find any usable destination buffer to put its data into.
+	 *
+	 * While there is no specific error condition we can check for, a
+	 * necessary condition is that all available buffers for the current
+	 * channel have been written to by the sdma script. In such a case we
+	 * will trigger the sdma script manually.
+	 */
+	if (cnt >= desc->num_bd)
+		sdma_enable_channel(sdmac->sdma, sdmac->channel);
 }
 
 static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
-- 
2.23.0
