From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v10 02/11] dmaengine: dw: set polarity of handshake interface
Date: Fri, 12 Aug 2016 19:01:47 +0300
Message-ID: <1471017716-44893-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1471017716-44893-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471017716-44893-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Intel Quark UART uses DesignWare DMA IP. Though the DMA IP is connected in such
way that handshake interface uses inverted polarity. We have to provide a
possibility to set this in the DMA driver when configuring a channel.

Introduce a new member of custom slave configuration called 'hs_polarity' and
set active low polarity in case this value is 'true'.

Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/core.c                | 4 ++++
 include/linux/platform_data/dma-dw.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 81b06df..80e7421 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -143,6 +143,7 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
 	struct dw_dma *dw = to_dw_dma(dwc->chan.device);
 	u32 cfghi = DWC_CFGH_FIFO_MODE;
 	u32 cfglo = DWC_CFGL_CH_PRIOR(dwc->priority);
+	bool hs_polarity = dwc->dws.hs_polarity;
 
 	if (test_bit(DW_DMA_IS_INITIALIZED, &dwc->flags))
 		return;
@@ -150,6 +151,9 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
 	cfghi |= DWC_CFGH_DST_PER(dwc->dws.dst_id);
 	cfghi |= DWC_CFGH_SRC_PER(dwc->dws.src_id);
 
+	/* Set polarity of handshake interface */
+	cfglo |= hs_polarity ? DWC_CFGL_HS_DST_POL | DWC_CFGL_HS_SRC_POL : 0;
+
 	channel_writel(dwc, CFG_LO, cfglo);
 	channel_writel(dwc, CFG_HI, cfghi);
 
diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
index d15d8ba..4636c93 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -23,6 +23,7 @@
  * @dst_id:	dst request line
  * @m_master:	memory master for transfers on allocated channel
  * @p_master:	peripheral master for transfers on allocated channel
+ * @hs_polarity:set active low polarity of handshake interface
  */
 struct dw_dma_slave {
 	struct device		*dma_dev;
@@ -30,6 +31,7 @@ struct dw_dma_slave {
 	u8			dst_id;
 	u8			m_master;
 	u8			p_master;
+	bool			hs_polarity;
 };
 
 /**
-- 
2.8.1
