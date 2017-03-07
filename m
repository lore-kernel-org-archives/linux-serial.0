From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] dmaengine: mtk_uart_dma: add Mediatek uart DMA support
Date: Tue, 7 Mar 2017 14:22:53 +0530
Message-ID: <20170307085253.GH2843@localhost>
References: <1487243251-964-1-git-send-email-long.cheng@mediatek.com>
 <1487243251-964-3-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1487243251-964-3-git-send-email-long.cheng@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Long Cheng <long.cheng@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 16, 2017 at 07:07:29PM +0800, Long Cheng wrote:
> In DMA engine framework, add 8250 mtk dma to support it.

Can you please describe the controller here

> +/*
> + * MTK DMAengine support
> + *
> + * Copyright (c) 2016 MediaTek Inc.

we are in 2017 now

> +#define VFF_INT_FLAG_CLR_B	0
> +/*VFF_INT_EN*/
> +#define VFF_RX_INT_EN0_B	BIT(0)
> +#define VFF_RX_INT_EN1_B	BIT(1)
> +#define VFF_TX_INT_EN_B		BIT(0)
> +#define VFF_INT_EN_CLR_B	0

empty line after each logical bloock helps in readablity

> +/*VFF_RST*/
> +#define VFF_WARM_RST_B		BIT(0)
> +/*VFF_EN*/
> +#define VFF_EN_B		BIT(0)
> +/*VFF_STOP*/
> +#define VFF_STOP_B		BIT(0)
> +#define VFF_STOP_CLR_B		0
> +/*VFF_FLUSH*/
> +#define VFF_FLUSH_B		BIT(0)
> +#define VFF_FLUSH_CLR_B		0

please align all these
> +
> +#define VFF_TX_THRE(n)		((n)*7/8)
> +#define VFF_RX_THRE(n)		((n)*3/4)

can you describe this

> +static bool mtk_dma_filter_fn(struct dma_chan *chan, void *param);

is there a reason for this, we can move the filer fn here!

> +static int mtk_dma_tx_write(struct dma_chan *chan)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
> +	struct timespec a, b;
> +	int txcount = c->remain_size;
> +	unsigned int tx_size = c->cfg.dst_addr_width*1024;
> +	unsigned int len, left;
> +	unsigned int wpt;
> +	ktime_t begin, end;
> +
> +	if (atomic_inc_and_test(&c->entry) > 1) {

why are we using atomic variables

> +		if (vchan_issue_pending(&c->vc) && !c->desc) {
> +			spin_lock(&mtkd->lock);
> +			list_add_tail(&c->node, &mtkd->pending);
> +			spin_unlock(&mtkd->lock);
> +			tasklet_schedule(&mtkd->task);
> +		}
> +	} else {
> +		while (mtk_dma_chan_read(c, VFF_LEFT_SIZE) >= c->trig) {
> +			left = tx_size - mtk_dma_chan_read(c, VFF_VALID_SIZE);
> +			left = (left > 16) ? (left - 16) : (0);
> +			len = left < c->remain_size ? left : c->remain_size;

?? can you explain this

> +
> +			begin = ktime_get();
> +			a = ktime_to_timespec(begin);

more alarm bells now!

> +			while (len--) {
> +				/*
> +				 * DMA limitation.
> +				 * Workaround: Polling flush bit to zero,
> +				 * set 1s timeout
> +				 */

1sec is ***VERY*** large, does the device recommend that?

> +				while (mtk_dma_chan_read(c, VFF_FLUSH)) {
> +					end = ktime_get();
> +					b = ktime_to_timespec(end);
> +					if ((b.tv_sec - a.tv_sec) > 1 ||
> +						((b.tv_sec - a.tv_sec) == 1 &&
> +						b.tv_nsec > a.tv_nsec)) {
> +						dev_info(chan->device->dev,
> +							"[UART] Polling flush timeout\n");
> +						return 0;
> +					}
> +				}

No this is not how you implement a time out. Hint use jiffes and count them.

> +
> +				wpt = mtk_dma_chan_read(c, VFF_WPT);
> +
> +				if ((wpt & 0x0000ffffl) ==

magic number?

> +static void mtk_dma_start_tx(struct mtk_chan *c)
> +{
> +	if (mtk_dma_chan_read(c, VFF_LEFT_SIZE) == 0) {
> +		dev_info(c->vc.chan.device->dev, "%s maybe need fix? %d @L %d\n",
> +				__func__, mtk_dma_chan_read(c, VFF_LEFT_SIZE),
> +				__LINE__);
> +		mtk_dma_chan_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> +	} else {
> +		reinit_completion(&c->done);
> +		atomic_inc(&c->loopcnt);
> +		atomic_inc(&c->loopcnt);

why would you increment twice

> +static void mtk_dma_reset(struct mtk_chan *c)
> +{
> +	struct timespec a, b;
> +	ktime_t begin, end;
> +
> +	mtk_dma_chan_write(c, VFF_ADDR, 0);
> +	mtk_dma_chan_write(c, VFF_THRE, 0);
> +	mtk_dma_chan_write(c, VFF_LEN, 0);
> +	mtk_dma_chan_write(c, VFF_RST, VFF_WARM_RST_B);
> +
> +	begin = ktime_get();
> +	a = ktime_to_timespec(begin);
> +	while (mtk_dma_chan_read(c, VFF_EN)) {
> +		end = ktime_get();
> +		b = ktime_to_timespec(end);
> +		if ((b.tv_sec - a.tv_sec) > 1 ||
> +			((b.tv_sec - a.tv_sec) == 1 &&
> +			b.tv_nsec > a.tv_nsec)) {
> +			dev_info(c->vc.chan.device->dev,
> +				"[UART] Polling VFF EN timeout\n");
> +			return;
> +		}

and here we go again

> +static void mtk_dma_stop(struct mtk_chan *c)
> +{
> +	int polling_cnt;
> +
> +	mtk_dma_chan_write(c, VFF_FLUSH, VFF_FLUSH_CLR_B);
> +
> +	polling_cnt = 0;
> +	while (mtk_dma_chan_read(c, VFF_FLUSH))	{
> +		polling_cnt++;
> +		if (polling_cnt > MTK_POLLING_CNT) {
> +			dev_info(c->vc.chan.device->dev, "mtk_uart_stop_dma: polling VFF_FLUSH fail VFF_DEBUG_STATUS=0x%x\n",

126 chars, surely that must be a record!

> +					mtk_dma_chan_read(c, VFF_DEBUG_STATUS));
> +			break;
> +		}
> +	}
> +
> +	polling_cnt = 0;
> +	/*set stop as 1 -> wait until en is 0 -> set stop as 0*/
> +	mtk_dma_chan_write(c, VFF_STOP, VFF_STOP_B);
> +	while (mtk_dma_chan_read(c, VFF_EN)) {
> +		polling_cnt++;
> +		if (polling_cnt > MTK_POLLING_CNT) {
> +			dev_info(c->vc.chan.device->dev, "mtk_uart_stop_dma: polling VFF_EN fail VFF_DEBUG_STATUS=0x%x\n",

and here

> +					mtk_dma_chan_read(c, VFF_DEBUG_STATUS));
> +			break;
> +		}
> +	}
> +	mtk_dma_chan_write(c, VFF_STOP, VFF_STOP_CLR_B);
> +	mtk_dma_chan_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
> +	mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_INT_FLAG_CLR_B);
> +
> +	c->paused = true;
> +}
> +
> +/*
> + * This callback schedules all pending channels. We could be more
> + * clever here by postponing allocation of the real DMA channels to
> + * this point, and freeing them when our virtual channel becomes idle.

yeah sounds good to me :)

> +static int mtk_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	int ret;
> +
> +	ret = -EBUSY;
> +
> +	if (mtkd->lch_map[c->dma_ch] == NULL) {
> +		c->channel_base = mtkd->base + 0x80 * c->dma_ch;

this should be probe thingy, why are we doing this here?

> +static enum dma_status mtk_dma_tx_status(struct dma_chan *chan,
> +	dma_cookie_t cookie, struct dma_tx_state *txstate)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);
> +
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +
> +	if (ret == DMA_IN_PROGRESS) {
> +		c->rx_ptr = mtk_dma_chan_read(c, VFF_RPT) & 0x0000ffffl;

magic!!

> +		txstate->residue = c->rx_ptr;
> +	} else if (ret == DMA_COMPLETE && c->cfg.direction == DMA_DEV_TO_MEM) {
> +		txstate->residue = c->remain_size;

this seems incorrect, if it is complete then why residue?

> +	} else {
> +		txstate->residue = 0;

which is a no-op


> +static struct dma_async_tx_descriptor *mtk_dma_prep_slave_sg(
> +	struct dma_chan *chan, struct scatterlist *sgl, unsigned int sglen,
> +	enum dma_transfer_direction dir, unsigned long tx_flags, void *context)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	enum dma_slave_buswidth dev_width;
> +	struct scatterlist *sgent;
> +	struct mtk_desc *d;
> +	dma_addr_t dev_addr;
> +	unsigned int i, j, en, frame_bytes;
> +
> +	en = frame_bytes = 1;
> +
> +	if (dir == DMA_DEV_TO_MEM) {
> +		dev_addr = c->cfg.src_addr;
> +		dev_width = c->cfg.src_addr_width;
> +	} else if (dir == DMA_MEM_TO_DEV) {
> +		dev_addr = c->cfg.dst_addr;
> +		dev_width = c->cfg.dst_addr_width;
> +	} else {
> +		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
> +		return NULL;
> +	}
> +
> +	/* Now allocate and setup the descriptor. */
> +	d = kmalloc(sizeof(*d) + sglen * sizeof(d->sg[0]),
> +				GFP_KERNEL | ___GFP_ZERO);

why ___GFP_ZERO? why not GFP_NOATOMIC?

> +static int
> +mtk_dma_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(c->vc.chan.device);
> +	int ret;
> +
> +	memcpy(&c->cfg, cfg, sizeof(c->cfg));
> +
> +	if (cfg->direction == DMA_DEV_TO_MEM) {
> +		mtk_dma_chan_write(c, VFF_ADDR, cfg->src_addr);
> +		mtk_dma_chan_write(c, VFF_LEN, cfg->src_addr_width*1024);
> +		mtk_dma_chan_write(c, VFF_THRE,
> +					VFF_RX_THRE(cfg->src_addr_width*1024));
> +		mtk_dma_chan_write(c, VFF_INT_EN,
> +					VFF_RX_INT_EN0_B | VFF_RX_INT_EN1_B);
> +		mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_INT_FLAG_CLR_B);
> +		mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);

this is wrong, you dont program channel here, but upon the descriptor issue.
The values should be stored locally and used to prepare.

> +static int mtk_dma_pause(struct dma_chan *chan)
> +{
> +	/* Pause/Resume only allowed with cyclic mode */
> +	return -EINVAL;
> +}

then remove it

> +	dma_cap_set(DMA_SLAVE, mtkd->ddev.cap_mask);
> +	mtkd->ddev.device_alloc_chan_resources = mtk_dma_alloc_chan_resources;
> +	mtkd->ddev.device_free_chan_resources = mtk_dma_free_chan_resources;
> +	mtkd->ddev.device_tx_status = mtk_dma_tx_status;
> +	mtkd->ddev.device_issue_pending = mtk_dma_issue_pending;
> +	mtkd->ddev.device_prep_slave_sg = mtk_dma_prep_slave_sg;
> +	mtkd->ddev.device_config = mtk_dma_slave_config;
> +	mtkd->ddev.device_pause = mtk_dma_pause;
> +	mtkd->ddev.device_resume = mtk_dma_resume;
> +	mtkd->ddev.device_terminate_all = mtk_dma_terminate_all;
> +	mtkd->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	mtkd->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);

1bytes width, are you sure about that?

> +static int mtk_dma_init(void)
> +{
> +	return platform_driver_register(&mtk_dma_driver);
> +}
> +subsys_initcall(mtk_dma_init);
> +
> +static void __exit mtk_dma_exit(void)
> +{
> +	platform_driver_unregister(&mtk_dma_driver);
> +}
> +module_exit(mtk_dma_exit);

platform_driver_register() pls

-- 
~Vinod
