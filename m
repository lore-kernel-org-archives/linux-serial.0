From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 03/12] dmaengine: dw: set polarity of handshake interface
Date: Thu,  7 Apr 2016 23:37:04 +0300
Message-ID: <1460061433-63750-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Intel Quark UART uses DesignWare DMA IP. Though the DMA IP is connected in such
way that handshake interface uses inverted polarity. We have to provide a
possibility to set this in the DMA driver when configuring a channel.

Introduce a new member of custom slave configuration called 'polarity' and set
active low polarity in case this value is 'true'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/core.c                | 2 ++
 include/linux/platform_data/dma-dw.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 840f0da..fc77f4e 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -143,6 +143,8 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
 	cfghi |= DWC_CFGH_DST_PER(dwc->dws.dst_id);
 	cfghi |= DWC_CFGH_SRC_PER(dwc->dws.src_id);
 
+	cfglo |= dwc->dws.polarity ? DWC_CFGL_HS_DST_POL | DWC_CFGL_HS_SRC_POL : 0;
+
 	channel_writel(dwc, CFG_LO, cfglo);
 	channel_writel(dwc, CFG_HI, cfghi);
 
diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
index 06227d0..6196139 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -23,6 +23,7 @@
  * @dst_id:	dst request line
  * @m_master:	memory master for transfers on allocated channel
  * @p_master:	peripheral master for transfers on allocated channel
+ * @polarity:	set active low polarity of handshake interface
  */
 struct dw_dma_slave {
 	struct device		*dma_dev;
@@ -30,6 +31,7 @@ struct dw_dma_slave {
 	u8			dst_id;
 	u8			m_master;
 	u8			p_master;
+	bool			polarity;
 };
 
 /**
-- 
2.8.0.rc3
