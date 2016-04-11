From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 01/11] dmaengine: dw: keep copy of custom slave config in dwc
Date: Mon, 11 Apr 2016 15:51:01 +0300
Message-ID: <1460379071-132591-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1460379071-132591-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460379071-132591-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

It seems we need to extend custom slave configuration by one more member to
support Intel Quart UART. It becomes a burden to manage all members of struct
dw_dma_slave one-by-one.

Replace set of fields by embedding struct dw_dma_slave into struct dw_dma_chan.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/core.c | 29 ++++++++++-------------------
 drivers/dma/dw/regs.h |  5 +----
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 2b994dc..f586ba1 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -46,9 +46,9 @@
 		u8 _dmsize = _is_slave ? _sconfig->dst_maxburst :	\
 			DW_DMA_MSIZE_16;			\
 		u8 _dms = (_dwc->direction == DMA_MEM_TO_DEV) ?		\
-			_dwc->p_master : _dwc->m_master;		\
+			_dwc->dws.p_master : _dwc->dws.m_master;	\
 		u8 _sms = (_dwc->direction == DMA_DEV_TO_MEM) ?		\
-			_dwc->p_master : _dwc->m_master;		\
+			_dwc->dws.p_master : _dwc->dws.m_master;	\
 								\
 		(DWC_CTLL_DST_MSIZE(_dmsize)			\
 		 | DWC_CTLL_SRC_MSIZE(_smsize)			\
@@ -140,8 +140,8 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
 	if (test_bit(DW_DMA_IS_INITIALIZED, &dwc->flags))
 		return;
 
-	cfghi |= DWC_CFGH_DST_PER(dwc->dst_id);
-	cfghi |= DWC_CFGH_SRC_PER(dwc->src_id);
+	cfghi |= DWC_CFGH_DST_PER(dwc->dws.dst_id);
+	cfghi |= DWC_CFGH_SRC_PER(dwc->dws.src_id);
 
 	channel_writel(dwc, CFG_LO, cfglo);
 	channel_writel(dwc, CFG_HI, cfghi);
@@ -202,7 +202,7 @@ static inline void dwc_do_single_block(struct dw_dma_chan *dwc,
 static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 {
 	struct dw_dma	*dw = to_dw_dma(dwc->chan.device);
-	u8		lms = DWC_LLP_LMS(dwc->m_master);
+	u8		lms = DWC_LLP_LMS(dwc->dws.m_master);
 	unsigned long	was_soft_llp;
 
 	/* ASSERT:  channel is idle */
@@ -686,7 +686,7 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	unsigned int		src_width;
 	unsigned int		dst_width;
 	u32			ctllo;
-	u8			lms = DWC_LLP_LMS(dwc->m_master);
+	u8			lms = DWC_LLP_LMS(dwc->dws.m_master);
 
 	dev_vdbg(chan2dev(chan),
 			"%s: d%pad s%pad l0x%zx f0x%lx\n", __func__,
@@ -759,7 +759,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct dw_desc		*prev;
 	struct dw_desc		*first;
 	u32			ctllo;
-	u8			lms = DWC_LLP_LMS(dwc->m_master);
+	u8			lms = DWC_LLP_LMS(dwc->dws.m_master);
 	dma_addr_t		reg;
 	unsigned int		reg_width;
 	unsigned int		mem_width;
@@ -912,12 +912,7 @@ bool dw_dma_filter(struct dma_chan *chan, void *param)
 		return false;
 
 	/* We have to copy data since dws can be temporary storage */
-
-	dwc->src_id = dws->src_id;
-	dwc->dst_id = dws->dst_id;
-
-	dwc->m_master = dws->m_master;
-	dwc->p_master = dws->p_master;
+	memcpy(&dwc->dws, dws, sizeof(struct dw_dma_slave));
 
 	return true;
 }
@@ -1224,11 +1219,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	dwc->descs_allocated = 0;
 
 	/* Clear custom channel configuration */
-	dwc->src_id = 0;
-	dwc->dst_id = 0;
-
-	dwc->m_master = 0;
-	dwc->p_master = 0;
+	memset(&dwc->dws, 0, sizeof(struct dw_dma_slave));
 
 	clear_bit(DW_DMA_IS_INITIALIZED, &dwc->flags);
 
@@ -1326,7 +1317,7 @@ struct dw_cyclic_desc *dw_dma_cyclic_prep(struct dma_chan *chan,
 	struct dw_cyclic_desc		*retval = NULL;
 	struct dw_desc			*desc;
 	struct dw_desc			*last = NULL;
-	u8				lms = DWC_LLP_LMS(dwc->m_master);
+	u8				lms = DWC_LLP_LMS(dwc->dws.m_master);
 	unsigned long			was_cyclic;
 	unsigned int			reg_width;
 	unsigned int			periods;
diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
index 5b3ea2d..f9e56f9 100644
--- a/drivers/dma/dw/regs.h
+++ b/drivers/dma/dw/regs.h
@@ -246,10 +246,7 @@ struct dw_dma_chan {
 	bool			nollp;
 
 	/* custom slave configuration */
-	u8			src_id;
-	u8			dst_id;
-	u8			m_master;
-	u8			p_master;
+	struct dw_dma_slave	dws;
 
 	/* configuration passed via .device_config */
 	struct dma_slave_config dma_sconfig;
-- 
2.8.0.rc3
