From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v4 2/7] dmaengine: imx-sdma: factor out a struct sdma_desc from struct sdma_channel
Date: Thu, 14 Jun 2018 22:02:57 +0800
Message-ID: <1528984982-5074-3-git-send-email-yibin.gong@nxp.com>
References: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de, dan.j.williams@intel.com, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

This is a preparation step to make the adding of virt-dma easier.
We create a struct sdma_desc, move some fields from struct sdma_channel
there and add a pointer from the former to the latter. For now we
allocate the data statically in struct sdma_channel, but with
virt-dma support it will be dynamically allocated.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 137 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 83 insertions(+), 54 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index ccd03c3..556d087 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -296,6 +296,30 @@ struct sdma_context_data {
 struct sdma_engine;
 
 /**
+ * struct sdma_desc - descriptor structor for one transfer
+ * @vd			descriptor for virt dma
+ * @num_bd		max NUM_BD. number of descriptors currently handling
+ * @buf_tail		ID of the buffer that was processed
+ * @buf_ptail		ID of the previous buffer that was processed
+ * @period_len		period length, used in cyclic.
+ * @chn_real_count	the real count updated from bd->mode.count
+ * @chn_count		the transfer count setuped
+ * @sdmac		sdma_channel pointer
+ * @bd			pointer of alloced bd
+ */
+struct sdma_desc {
+	unsigned int		num_bd;
+	dma_addr_t		bd_phys;
+	unsigned int		buf_tail;
+	unsigned int		buf_ptail;
+	unsigned int		period_len;
+	unsigned int		chn_real_count;
+	unsigned int		chn_count;
+	struct sdma_channel	*sdmac;
+	struct sdma_buffer_descriptor *bd;
+};
+
+/**
  * struct sdma_channel - housekeeping for a SDMA channel
  *
  * @sdma		pointer to the SDMA engine for this channel
@@ -305,11 +329,10 @@ struct sdma_engine;
  * @event_id0		aka dma request line
  * @event_id1		for channels that use 2 events
  * @word_size		peripheral access size
- * @buf_tail		ID of the buffer that was processed
- * @buf_ptail		ID of the previous buffer that was processed
- * @num_bd		max NUM_BD. number of descriptors currently handling
  */
 struct sdma_channel {
+	struct sdma_desc		*desc;
+	struct sdma_desc		_desc;
 	struct sdma_engine		*sdma;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
@@ -317,12 +340,6 @@ struct sdma_channel {
 	unsigned int			event_id0;
 	unsigned int			event_id1;
 	enum dma_slave_buswidth		word_size;
-	unsigned int			buf_tail;
-	unsigned int			buf_ptail;
-	unsigned int			num_bd;
-	unsigned int			period_len;
-	struct sdma_buffer_descriptor	*bd;
-	dma_addr_t			bd_phys;
 	unsigned int			pc_from_device, pc_to_device;
 	unsigned int			device_to_device;
 	unsigned long			flags;
@@ -332,10 +349,8 @@ struct sdma_channel {
 	u32				shp_addr, per_addr;
 	struct dma_chan			chan;
 	spinlock_t			lock;
-	struct dma_async_tx_descriptor	desc;
+	struct dma_async_tx_descriptor	txdesc;
 	enum dma_status			status;
-	unsigned int			chn_count;
-	unsigned int			chn_real_count;
 	struct tasklet_struct		tasklet;
 	struct imx_dma_data		data;
 	bool				enabled;
@@ -398,6 +413,8 @@ struct sdma_engine {
 	u32				spba_start_addr;
 	u32				spba_end_addr;
 	unsigned int			irq;
+	dma_addr_t			bd0_phys;
+	struct sdma_buffer_descriptor	*bd0;
 };
 
 static struct sdma_driver_data sdma_imx31 = {
@@ -632,7 +649,7 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 static int sdma_load_script(struct sdma_engine *sdma, void *buf, int size,
 		u32 address)
 {
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	void *buf_virt;
 	dma_addr_t buf_phys;
 	int ret;
@@ -707,7 +724,9 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	 * call callback function.
 	 */
 	while (1) {
-		bd = &sdmac->bd[sdmac->buf_tail];
+		struct sdma_desc *desc = sdmac->desc;
+
+		bd = &desc->bd[desc->buf_tail];
 
 		if (bd->mode.status & BD_DONE)
 			break;
@@ -723,11 +742,11 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		* the number of bytes present in the current buffer descriptor.
 		*/
 
-		sdmac->chn_real_count = bd->mode.count;
+		desc->chn_real_count = bd->mode.count;
 		bd->mode.status |= BD_DONE;
-		bd->mode.count = sdmac->period_len;
-		sdmac->buf_ptail = sdmac->buf_tail;
-		sdmac->buf_tail = (sdmac->buf_tail + 1) % sdmac->num_bd;
+		bd->mode.count = desc->period_len;
+		desc->buf_ptail = desc->buf_tail;
+		desc->buf_tail = (desc->buf_tail + 1) % desc->num_bd;
 
 		/*
 		 * The callback is called from the interrupt context in order
@@ -736,7 +755,7 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		 * executed.
 		 */
 
-		dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
+		dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
 
 		if (error)
 			sdmac->status = old_status;
@@ -749,17 +768,17 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 	struct sdma_buffer_descriptor *bd;
 	int i, error = 0;
 
-	sdmac->chn_real_count = 0;
+	sdmac->desc->chn_real_count = 0;
 	/*
 	 * non loop mode. Iterate over all descriptors, collect
 	 * errors and call callback function
 	 */
-	for (i = 0; i < sdmac->num_bd; i++) {
-		bd = &sdmac->bd[i];
+	for (i = 0; i < sdmac->desc->num_bd; i++) {
+		bd = &sdmac->desc->bd[i];
 
 		 if (bd->mode.status & (BD_DONE | BD_RROR))
 			error = -EIO;
-		 sdmac->chn_real_count += bd->mode.count;
+		 sdmac->desc->chn_real_count += bd->mode.count;
 	}
 
 	if (error)
@@ -767,9 +786,9 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 	else
 		sdmac->status = DMA_COMPLETE;
 
-	dma_cookie_complete(&sdmac->desc);
+	dma_cookie_complete(&sdmac->txdesc);
 
-	dmaengine_desc_get_callback_invoke(&sdmac->desc, NULL);
+	dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
 }
 
 static irqreturn_t sdma_int_handler(int irq, void *dev_id)
@@ -897,7 +916,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int channel = sdmac->channel;
 	int load_address;
 	struct sdma_context_data *context = sdma->context;
-	struct sdma_buffer_descriptor *bd0 = sdma->channel[0].bd;
+	struct sdma_buffer_descriptor *bd0 = sdma->bd0;
 	int ret;
 	unsigned long flags;
 
@@ -1100,18 +1119,22 @@ static int sdma_set_channel_priority(struct sdma_channel *sdmac,
 static int sdma_request_channel(struct sdma_channel *sdmac)
 {
 	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_desc *desc;
 	int channel = sdmac->channel;
 	int ret = -EBUSY;
 
-	sdmac->bd = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdmac->bd_phys,
+	sdmac->desc = &sdmac->_desc;
+	desc = sdmac->desc;
+
+	desc->bd = dma_zalloc_coherent(NULL, PAGE_SIZE, &desc->bd_phys,
 					GFP_KERNEL);
-	if (!sdmac->bd) {
+	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	sdma->channel_control[channel].base_bd_ptr = sdmac->bd_phys;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
+	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
 
 	sdma_set_channel_priority(sdmac, MXC_SDMA_DEFAULT_PRIORITY);
 	return 0;
@@ -1176,10 +1199,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto disable_clk_ahb;
 
-	dma_async_tx_descriptor_init(&sdmac->desc, chan);
-	sdmac->desc.tx_submit = sdma_tx_submit;
+	dma_async_tx_descriptor_init(&sdmac->txdesc, chan);
+	sdmac->txdesc.tx_submit = sdma_tx_submit;
 	/* txd.flags will be overwritten in prep funcs */
-	sdmac->desc.flags = DMA_CTRL_ACK;
+	sdmac->txdesc.flags = DMA_CTRL_ACK;
 
 	return 0;
 
@@ -1194,6 +1217,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
+	struct sdma_desc *desc = sdmac->desc;
 
 	sdma_disable_channel(chan);
 
@@ -1207,7 +1231,7 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_set_channel_priority(sdmac, 0);
 
-	dma_free_coherent(NULL, PAGE_SIZE, sdmac->bd, sdmac->bd_phys);
+	dma_free_coherent(NULL, PAGE_SIZE, desc->bd, desc->bd_phys);
 
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
@@ -1223,6 +1247,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
+	struct sdma_desc *desc = sdmac->desc;
 
 	if (sdmac->status == DMA_IN_PROGRESS)
 		return NULL;
@@ -1230,9 +1255,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	sdmac->flags = 0;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->chn_real_count = 0;
 
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
@@ -1249,9 +1274,9 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		goto err_out;
 	}
 
-	sdmac->chn_count = 0;
+	desc->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = sg->dma_address;
@@ -1266,7 +1291,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		}
 
 		bd->mode.count = count;
-		sdmac->chn_count += count;
+		desc->chn_count += count;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES) {
 			ret =  -EINVAL;
@@ -1307,10 +1332,10 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.status = param;
 	}
 
-	sdmac->num_bd = sg_len;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
+	desc->num_bd = sg_len;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
 
-	return &sdmac->desc;
+	return &sdmac->txdesc;
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1326,6 +1351,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
+	struct sdma_desc *desc = sdmac->desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
@@ -1334,10 +1360,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->status = DMA_IN_PROGRESS;
 
-	sdmac->buf_tail = 0;
-	sdmac->buf_ptail = 0;
-	sdmac->chn_real_count = 0;
-	sdmac->period_len = period_len;
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->chn_real_count = 0;
+	desc->period_len = period_len;
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 	sdmac->direction = direction;
@@ -1358,7 +1384,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	}
 
 	while (buf < buf_len) {
-		struct sdma_buffer_descriptor *bd = &sdmac->bd[i];
+		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
 
 		bd->buffer_addr = dma_addr;
@@ -1389,10 +1415,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		i++;
 	}
 
-	sdmac->num_bd = num_periods;
-	sdma->channel_control[channel].current_bd_ptr = sdmac->bd_phys;
+	desc->num_bd = num_periods;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
 
-	return &sdmac->desc;
+	return &sdmac->txdesc;
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1431,13 +1457,14 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 				      struct dma_tx_state *txstate)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	struct sdma_desc *desc = sdmac->desc;
 	u32 residue;
 
 	if (sdmac->flags & IMX_DMA_SG_LOOP)
-		residue = (sdmac->num_bd - sdmac->buf_ptail) *
-			   sdmac->period_len - sdmac->chn_real_count;
+		residue = (desc->num_bd - desc->buf_ptail) *
+			   desc->period_len - desc->chn_real_count;
 	else
-		residue = sdmac->chn_count - sdmac->chn_real_count;
+		residue = desc->chn_count - desc->chn_real_count;
 
 	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
 			 residue);
@@ -1661,6 +1688,8 @@ static int sdma_init(struct sdma_engine *sdma)
 	if (ret)
 		goto err_dma_alloc;
 
+	sdma->bd0 = sdma->channel[0].desc->bd;
+
 	sdma_config_ownership(&sdma->channel[0], false, true, false);
 
 	/* Set Command Channel (Channel Zero) */
-- 
2.7.4
