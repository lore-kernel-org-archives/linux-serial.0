From: Nandor Han <nandor.han@ge.com>
Subject: [PATCH 2/4] dmaengine: imx-sdma - update the residue calculation for cyclic channels
Date: Mon,  8 Aug 2016 15:38:26 +0300
Message-ID: <0e47cf5eb88ef63f844f310bfbd836264f65ccdf.1470656658.git.nandor.han@ge.com>
References: <cover.1465456639.git.nandor.han@ge.com>
 <cover.1470656657.git.nandor.han@ge.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470656657.git.nandor.han@ge.com>
In-Reply-To: <cover.1470656657.git.nandor.han@ge.com>
References: <cover.1470656657.git.nandor.han@ge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Nandor Han <nandor.han@ge.com>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Senna Tschudin <peter.senna@collabora.com>
List-Id: linux-serial@vger.kernel.org

The calculation of the DMA transaction residue supports only fixed
size data transfers. This implementation is not covering all
operations (e.g. data receiving) when we need to know the exact amount
of bytes transferred.

The loop channels handling was changed to clear the buffer
descriptor errors and use the bd->mode.count to calculate the
residue.

Tested-by: Peter Senna Tschudin <peter.senna@collabora.com>
Acked-by: Peter Senna Tschudin <peter.senna@collabora.com>
Reviewed-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Nandor Han <nandor.han@ge.com>
---
 drivers/dma/imx-sdma.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index aa35a77..3cb4738 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -651,6 +651,8 @@ static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
 static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 {
 	struct sdma_buffer_descriptor *bd;
+	int error = 0;
+	enum dma_status	old_status = sdmac->status;
 
 	/*
 	 * loop mode. Iterate over descriptors, re-setup them and
@@ -662,10 +664,20 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		if (bd->mode.status & BD_DONE)
 			break;
 
-		if (bd->mode.status & BD_RROR)
+		if (bd->mode.status & BD_RROR) {
+			bd->mode.status &= ~BD_RROR;
 			sdmac->status = DMA_ERROR;
+			error = -EIO;
+		}
 
+	       /*
+		* We use bd->mode.count to calculate the residue, since contains
+		* the number of bytes present in the current buffer descriptor.
+		*/
+
+		sdmac->chn_real_count = bd->mode.count;
 		bd->mode.status |= BD_DONE;
+		bd->mode.count = sdmac->period_len;
 
 		/*
 		 * The callback is called from the interrupt context in order
@@ -679,6 +691,9 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 
 		sdmac->buf_tail++;
 		sdmac->buf_tail %= sdmac->num_bd;
+
+		if (error)
+			sdmac->status = old_status;
 	}
 }
 
@@ -1349,7 +1364,8 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 	u32 residue;
 
 	if (sdmac->flags & IMX_DMA_SG_LOOP)
-		residue = (sdmac->num_bd - sdmac->buf_tail) * sdmac->period_len;
+		residue = (sdmac->num_bd - sdmac->buf_tail) *
+			   sdmac->period_len - sdmac->chn_real_count;
 	else
 		residue = sdmac->chn_count - sdmac->chn_real_count;
 
-- 
2.8.3
