From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 04/12] dmaengine: dw: override LLP support if asked in platform data
Date: Thu,  7 Apr 2016 23:37:05 +0300
Message-ID: <1460061433-63750-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

There is at least one known device, i.e. UART on Intel Galileo, that works
unreliably in case of use of multi block transfer support in DMA mode.

Override autodetection by user provided data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/core.c                | 10 +++++++---
 include/linux/platform_data/dma-dw.h |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index fc77f4e..0617880 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -1631,9 +1631,13 @@ int dw_dma_probe(struct dw_dma_chip *chip)
 			dwc->block_size = pdata->block_size;
 
 			/* Check if channel supports multi block transfer */
-			channel_writel(dwc, LLP, DWC_LLP_LOC(0xffffffff));
-			dwc->nollp = DWC_LLP_LOC(channel_readl(dwc, LLP)) == 0;
-			channel_writel(dwc, LLP, 0);
+			if (pdata->is_nollp) {
+				dwc->nollp = pdata->is_nollp;
+			} else {
+				channel_writel(dwc, LLP, DWC_LLP_LOC(0xffffffff));
+				dwc->nollp = DWC_LLP_LOC(channel_readl(dwc, LLP)) == 0;
+				channel_writel(dwc, LLP, 0);
+			}
 		}
 	}
 
diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
index 6196139..8a9d132 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -40,6 +40,7 @@ struct dw_dma_slave {
  * @is_private: The device channels should be marked as private and not for
  *	by the general purpose DMA channel allocator.
  * @is_memcpy: The device channels do support memory-to-memory transfers.
+ * @is_nollp: The device channels does not support multi block transfers.
  * @chan_allocation_order: Allocate channels starting from 0 or 7
  * @chan_priority: Set channel priority increasing from 0 to 7 or 7 to 0.
  * @block_size: Maximum block size supported by the controller
@@ -50,6 +51,7 @@ struct dw_dma_platform_data {
 	unsigned int	nr_channels;
 	bool		is_private;
 	bool		is_memcpy;
+	bool		is_nollp;
 #define CHAN_ALLOCATION_ASCENDING	0	/* zero to seven */
 #define CHAN_ALLOCATION_DESCENDING	1	/* seven to zero */
 	unsigned char	chan_allocation_order;
-- 
2.8.0.rc3
