From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Date: Sun, 20 Jan 2019 10:57:50 +0530
Message-ID: <20190120052750.GN4635@vkoul-mobl>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
 <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
 <20190104171953.GQ13372@vkoul-mobl.Dlink>
 <1547116431.3831.43.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1547116431.3831.43.camel@mhfsdcap03>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>, Zhenbao Liu <zhenbao.liu@mediatek.com>, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, YT Shen <yt.shen@mediatek.com>, dmaengine@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>, linux-mediatek@lists.infradead.org, Sean Wang <sean.wang@mediatek.com>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 10-01-19, 18:33, Long Cheng wrote:
> On Fri, 2019-01-04 at 22:49 +0530, Vinod Koul wrote:
> > On 02-01-19, 10:12, Long Cheng wrote:
> > > In DMA engine framework, add 8250 uart dma to support MediaTek uart.
> > > If MediaTek uart enabled(SERIAL_8250_MT6577), and want to improve
> > > the performance, can enable the function.
> > 
> > Is the DMA controller UART specific, can it work with other controllers
> > as well, if so you should get rid of uart name in patch
> 
> I don't know that it can work or not on other controller. but it's for
> MediaTek SOC

What I meant was that if can work with other controllers (users) apart
from UART, how about say audio, spi etc!!

> 
> > > +#define MTK_UART_APDMA_CHANNELS		(CONFIG_SERIAL_8250_NR_UARTS * 2)
> > 
> > Why are the channels not coming from DT?
> > 
> 
> i will using dma-requests install of it.
> 
> > > +
> > > +#define VFF_EN_B		BIT(0)
> > > +#define VFF_STOP_B		BIT(0)
> > > +#define VFF_FLUSH_B		BIT(0)
> > > +#define VFF_4G_SUPPORT_B	BIT(0)
> > > +#define VFF_RX_INT_EN0_B	BIT(0)	/*rx valid size >=  vff thre*/
> > > +#define VFF_RX_INT_EN1_B	BIT(1)
> > > +#define VFF_TX_INT_EN_B		BIT(0)	/*tx left size >= vff thre*/
> > 
> > space around /* space */ also run checkpatch to check for style errors
> > 
> 
> ok.
> 
> > > +static void mtk_uart_apdma_start_tx(struct mtk_chan *c)
> > > +{
> > > +	unsigned int len, send, left, wpt, d_wpt, tmp;
> > > +	int ret;
> > > +
> > > +	left = mtk_uart_apdma_read(c, VFF_LEFT_SIZE);
> > > +	if (!left) {
> > > +		mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> > > +		return;
> > > +	}
> > > +
> > > +	/* Wait 1sec for flush,  can't sleep*/
> > > +	ret = readx_poll_timeout(readl, c->base + VFF_FLUSH, tmp,
> > > +			tmp != VFF_FLUSH_B, 0, 1000000);
> > > +	if (ret)
> > > +		dev_warn(c->vc.chan.device->dev, "tx: fail, debug=0x%x\n",
> > > +			mtk_uart_apdma_read(c, VFF_DEBUG_STATUS));
> > > +
> > > +	send = min_t(unsigned int, left, c->desc->avail_len);
> > > +	wpt = mtk_uart_apdma_read(c, VFF_WPT);
> > > +	len = mtk_uart_apdma_read(c, VFF_LEN);
> > > +
> > > +	d_wpt = wpt + send;
> > > +	if ((d_wpt & VFF_RING_SIZE) >= len) {
> > > +		d_wpt = d_wpt - len;
> > > +		d_wpt = d_wpt ^ VFF_RING_WRAP;
> > > +	}
> > > +	mtk_uart_apdma_write(c, VFF_WPT, d_wpt);
> > > +
> > > +	c->desc->avail_len -= send;
> > > +
> > > +	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
> > > +	if (mtk_uart_apdma_read(c, VFF_FLUSH) == 0U)
> > > +		mtk_uart_apdma_write(c, VFF_FLUSH, VFF_FLUSH_B);
> > > +}
> > > +
> > > +static void mtk_uart_apdma_start_rx(struct mtk_chan *c)
> > > +{
> > > +	struct mtk_uart_apdma_desc *d = c->desc;
> > > +	unsigned int len, wg, rg, cnt;
> > > +
> > > +	if ((mtk_uart_apdma_read(c, VFF_VALID_SIZE) == 0U) ||
> > > +		!d || !vchan_next_desc(&c->vc))
> > > +		return;
> > > +
> > > +	len = mtk_uart_apdma_read(c, VFF_LEN);
> > > +	rg = mtk_uart_apdma_read(c, VFF_RPT);
> > > +	wg = mtk_uart_apdma_read(c, VFF_WPT);
> > > +	if ((rg ^ wg) & VFF_RING_WRAP)
> > > +		cnt = (wg & VFF_RING_SIZE) + len - (rg & VFF_RING_SIZE);
> > > +	else
> > > +		cnt = (wg & VFF_RING_SIZE) - (rg & VFF_RING_SIZE);
> > > +
> > > +	c->rx_status = cnt;
> > > +	mtk_uart_apdma_write(c, VFF_RPT, wg);
> > > +
> > > +	list_del(&d->vd.node);
> > > +	vchan_cookie_complete(&d->vd);
> > > +}
> > 
> > this looks odd, why do you have different rx and tx start routines?
> > 
> 
> Would you like explain it in more detail? thanks.
> In tx function, will wait the last data flush done. and the count the
> size that send.
> In Rx function, will count the size that receive.
> Any way, in rx / tx, need andle WPT or RPT.
> 
> > > +static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
> > > +{
> > > +	struct mtk_uart_apdmadev *mtkd = to_mtk_uart_apdma_dev(chan->device);
> > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > +	u32 tmp;
> > > +	int ret;
> > > +
> > > +	pm_runtime_get_sync(mtkd->ddev.dev);
> > > +
> > > +	mtk_uart_apdma_write(c, VFF_ADDR, 0);
> > > +	mtk_uart_apdma_write(c, VFF_THRE, 0);
> > > +	mtk_uart_apdma_write(c, VFF_LEN, 0);
> > > +	mtk_uart_apdma_write(c, VFF_RST, VFF_WARM_RST_B);
> > > +
> > > +	ret = readx_poll_timeout(readl, c->base + VFF_EN, tmp,
> > > +			tmp == 0, 10, 100);
> > > +	if (ret) {
> > > +		dev_err(chan->device->dev, "dma reset: fail, timeout\n");
> > > +		return ret;
> > > +	}
> > 
> > register read does reset?
> > 
> 
> 'mtk_uart_apdma_write(c, VFF_RST, VFF_WARM_RST_B);' is reset. resd just
> poll reset done.
> 
> > > +
> > > +	if (!c->requested) {
> > > +		c->requested = true;
> > > +		ret = request_irq(mtkd->dma_irq[chan->chan_id],
> > > +				  mtk_uart_apdma_irq_handler, IRQF_TRIGGER_NONE,
> > > +				  KBUILD_MODNAME, chan);
> > 
> > why is the irq not requested in driver probe?
> > 
> 
> I have explained in below,
> http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016418.html
> 
> > > +static enum dma_status mtk_uart_apdma_tx_status(struct dma_chan *chan,
> > > +					 dma_cookie_t cookie,
> > > +					 struct dma_tx_state *txstate)
> > > +{
> > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > +	enum dma_status ret;
> > > +	unsigned long flags;
> > > +
> > > +	if (!txstate)
> > > +		return DMA_ERROR;
> > > +
> > > +	ret = dma_cookie_status(chan, cookie, txstate);
> > > +	spin_lock_irqsave(&c->vc.lock, flags);
> > > +	if (ret == DMA_IN_PROGRESS) {
> > > +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> > > +		dma_set_residue(txstate, c->rx_status);
> > > +	} else if (ret == DMA_COMPLETE && c->cfg.direction == DMA_DEV_TO_MEM) {
> > 
> > why set reside when it is complete? also reside can be null, that should
> > be checked as well
> > 
> In different status, set different reside.

Can you explain that..

> 
> > > +static struct dma_async_tx_descriptor *mtk_uart_apdma_prep_slave_sg
> > > +	(struct dma_chan *chan, struct scatterlist *sgl,
> > > +	unsigned int sglen, enum dma_transfer_direction dir,
> > > +	unsigned long tx_flags, void *context)
> > > +{
> > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > +	struct mtk_uart_apdma_desc *d;
> > > +
> > > +	if ((dir != DMA_DEV_TO_MEM) &&
> > > +		(dir != DMA_MEM_TO_DEV)) {
> > > +		dev_err(chan->device->dev, "bad direction\n");
> > > +		return NULL;
> > > +	}
> > 
> > we have a macro for this
> 
> Thanks for your suggestion. i will modify it.
> > 
> > > +
> > > +	/* Now allocate and setup the descriptor */
> > > +	d = kzalloc(sizeof(*d), GFP_ATOMIC);
> > > +	if (!d)
> > > +		return NULL;
> > > +
> > > +	/* sglen is 1 */
> > 
> > ?
> > 
> > > +static int mtk_uart_apdma_slave_config(struct dma_chan *chan,
> > > +				struct dma_slave_config *cfg)
> > > +{
> > > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > > +	struct mtk_uart_apdmadev *mtkd =
> > > +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> > > +
> > > +	c->cfg = *cfg;
> > > +
> > > +	if (cfg->direction == DMA_DEV_TO_MEM) {
> > 
> > fg->direction is deprecated, in fact I have removed all users recently,
> > please do not use this
> 
> You will remove 'direction' in 'struct dma_slave_config'? if remove, how
> do confirm direction?

Yes please use the direction argument in prep_xx calls
-- 
~Vinod
