From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] dmaengine: slave means at least one of DMA_SLAVE, DMA_CYCLIC
Date: Tue, 10 May 2016 20:43:34 +0300
Message-ID: <1462902214-64706-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

When check for capabilities recognize slave support by either DMA_SLAVE or
DMA_CYCLIC bit set. If we don't do that the user can't get a normally worked
DMA support for engines that doesn't have one of the mentioned bits set.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
In v2:
- fix typo in the commit message
- send patch separately
 drivers/dma/dmaengine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 5ff79a0..59eb4fa 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -482,8 +482,8 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	device = chan->device;
 
 	/* check if the channel supports slave transactions */
-	if ((!test_bit(DMA_SLAVE, device->cap_mask.bits)) ||
-			(!test_bit(DMA_CYCLIC, device->cap_mask.bits)))
+	if (!(test_bit(DMA_SLAVE, device->cap_mask.bits) ||
+	      test_bit(DMA_CYCLIC, device->cap_mask.bits)))
 		return -ENXIO;
 
 	/*
-- 
2.8.1
