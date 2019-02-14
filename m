From: Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH v10 1/3] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Date: Thu, 14 Feb 2019 10:44:56 +0800
Message-ID: <1550112296.7678.5.camel@mhfsdcap03>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
         <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
         <20190204072154.GJ4296@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204072154.GJ4296@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>, Zhenbao Liu <zhenbao.liu@me>
List-Id: linux-serial@vger.kernel.org

On Mon, 2019-02-04 at 12:51 +0530, Vinod Koul wrote:

Hi Vinod sir,

> On 18-01-19, 11:10, Long Cheng wrote:
> > +static enum dma_status mtk_uart_apdma_tx_status(struct dma_chan *chan,
> > +					 dma_cookie_t cookie,
> > +					 struct dma_tx_state *txstate)
> > +{
> > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > +	enum dma_status ret;
> > +	unsigned long flags;
> > +
> > +	if (!txstate)
> > +		return DMA_ERROR;
> 
> Why, it is not a mandatory arg!

Next version, I will remove it.
> 
> > +	ret = dma_cookie_status(chan, cookie, txstate);
> > +	spin_lock_irqsave(&c->vc.lock, flags);
> > +	if (ret == DMA_IN_PROGRESS) {
> > +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> > +		dma_set_residue(txstate, c->rx_status);
> > +	} else if (ret == DMA_COMPLETE && c->dir == DMA_DEV_TO_MEM) {
> > +		dma_set_residue(txstate, c->rx_status);
> 
> what is the point is setting residue to comleted txn, it is zero!
> 
> > +	} else {
> > +		dma_set_residue(txstate, 0);
> 
> naah that doesnt sound correct!
> 
Next version, I will modify the function.

> > +static void mtk_uart_apdma_config_write(struct dma_chan *chan,
> > +			       struct dma_slave_config *cfg,
> > +			       enum dma_transfer_direction dir)
> > +{
> > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > +	struct mtk_uart_apdmadev *mtkd =
> > +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> > +	unsigned int tmp;
> > +
> > +	if (mtk_uart_apdma_read(c, VFF_EN) == VFF_EN_B)
> > +		return;
> > +
> > +	c->dir = dir;
> > +
> > +	if (dir == DMA_DEV_TO_MEM) {
> > +		tmp = cfg->src_addr_width * 1024;
> 
> why multiply by 1024?
> 
Next version, I will modify the this, with 'src_port_window_size' &&
'dst_port_window_size'.

> > +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> > +{
> > +	/* just for check caps pass */
> > +	return 0;
> > +}
> 
> please remove, this is not a mandatory fn

Can't remove it. Before the mail, i had explained it. in 8250 uart
framework, will check the function..

thanks.
