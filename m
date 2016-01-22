From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH 1/4] ARM: edma: special case slot limit workaround
Date: Fri, 22 Jan 2016 11:27:35 +0100
Message-ID: <87egd9rjs8.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, peter@hurleysoftware.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Currently drivers are limited to 19 slots for cyclic transfers.
However, if the DMA burst size is the same as the period size,
the period size can be changed to the full buffer size and
intermediate interrupts activated. Since intermediate interrupts
will trigger for each burst and the burst size is the same as
the original period size, the driver will get interrupts each
period as expected. This has the benefit of allowing the
functionality of many more slots, but only uses 2 slots.

This workaround is only active if more than 19 slots are needed
and the burst size matches the period size.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 This particular patch was previously posted as v2:
 http://lkml.kernel.org/r/87a8rjt7p9.fsf_-_@linutronix.de

 It is being reposted because it is a necessary pre-requisite
 of this patch series.

 v2-v3 changes
 . rebased for next-20160122
 . added Acked-By

 v1-v2 changes
 . rebased for next-20151016

 drivers/dma/edma.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d92d655..151e990 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1228,6 +1228,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	struct edma_desc *edesc;
 	dma_addr_t src_addr, dst_addr;
 	enum dma_slave_buswidth dev_width;
+	bool use_intermediate = false;
 	u32 burst;
 	int i, ret, nslots;
 
@@ -1269,8 +1270,21 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	 * but the synchronization is difficult to achieve with Cyclic and
 	 * cannot be guaranteed, so we error out early.
 	 */
-	if (nslots > MAX_NR_SG)
-		return NULL;
+	if (nslots > MAX_NR_SG) {
+		/*
+		 * If the burst and period sizes are the same, we can put
+		 * the full buffer into a single period and activate
+		 * intermediate interrupts. This will produce interrupts
+		 * after each burst, which is also after each desired period.
+		 */
+		if (burst == period_len) {
+			period_len = buf_len;
+			nslots = 2;
+			use_intermediate = true;
+		} else {
+			return NULL;
+		}
+	}
 
 	edesc = kzalloc(sizeof(*edesc) + nslots * sizeof(edesc->pset[0]),
 			GFP_ATOMIC);
@@ -1348,8 +1362,13 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 		/*
 		 * Enable period interrupt only if it is requested
 		 */
-		if (tx_flags & DMA_PREP_INTERRUPT)
+		if (tx_flags & DMA_PREP_INTERRUPT) {
 			edesc->pset[i].param.opt |= TCINTEN;
+
+			/* Also enable intermediate interrupts if necessary */
+			if (use_intermediate)
+				edesc->pset[i].param.opt |= ITCINTEN;
+		}
 	}
 
 	/* Place the cyclic channel to highest priority queue */
-- 
1.7.10.4
