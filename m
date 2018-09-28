From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [SPAM][PATCH 2/4] dmaengine: mtk_uart_dma: add Mediatek uart
 DMA support
Date: Sat, 29 Sep 2018 05:44:26 +0800
Message-ID: <1538171066.30348.221.camel@mtkswgap22>
References: <1537425673-18807-1-git-send-email-long.cheng@mediatek.com>
 <1537425673-18807-3-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1537425673-18807-3-git-send-email-long.cheng@mediatek.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, dmaengine@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>, Dan Williams <dan.j.williams@intel.com>, Ed Blake <ed.blake@sondrel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

On Thu, 2018-09-20 at 14:41 +0800, Long Cheng wrote:
> In DMA engine framework, add 8250 mtk dma to support it.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  drivers/dma/8250_mtk_dma.c | 1049 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/Kconfig        |   11 +
>  drivers/dma/Makefile       |    1 +

the driver should be moved to driver/dma/mediatek

>  3 files changed, 1061 insertions(+)
>  create mode 100644 drivers/dma/8250_mtk_dma.c
> 
> diff --git a/drivers/dma/8250_mtk_dma.c b/drivers/dma/8250_mtk_dma.c
> new file mode 100644
> index 0000000..a07844e
> --- /dev/null
> +++ b/drivers/dma/8250_mtk_dma.c
> @@ -0,0 +1,1049 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek 8250 DMA driver.
> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Long Cheng <long.cheng@mediatek.com>
> + */
> +
> +#define pr_fmt(fmt) "8250-mtk-dma: " fmt

pr_fmt can be removed since no place is called with pr_fmt 

> +#define DRV_NAME    "8250-mtk-dma"
> +

use KBUILD_MODNAME instead


> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of_dma.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "virt-dma.h"
> +
> +#define MTK_SDMA_REQUESTS	127

name it as MTK_SDMA_DEFAULT_REQUESTS seems to be more readable

> +#define MTK_SDMA_CHANNELS	(CONFIG_SERIAL_8250_NR_UARTS * 2)

total number of the channels should depend on the capability the hardware provides, it should be detected by the device tree

> +
> +#define VFF_RX_INT_FLAG_CLR_B	(BIT(0U) | BIT(1U))
> +#define VFF_TX_INT_FLAG_CLR_B	0
> +#define VFF_RX_INT_EN0_B	BIT(0U)	/*rx valid size >=  vff thre */
> +#define VFF_RX_INT_EN1_B	BIT(1U)
> +#define VFF_TX_INT_EN_B		BIT(0U)	/*tx left size >= vff thre */
> +#define VFF_INT_EN_CLR_B	0
> +#define VFF_WARM_RST_B		BIT(0U)
> +#define VFF_EN_B		BIT(0U)
> +#define VFF_STOP_B		BIT(0U)
> +#define VFF_STOP_CLR_B		0
> +#define VFF_FLUSH_B		BIT(0U)
> +#define VFF_FLUSH_CLR_B		0
> +#define VFF_4G_SUPPORT_B	BIT(0U)
> +#define VFF_4G_SUPPORT_CLR_B	0
> +

all postfix U can be removed, and register offset placed along with the bit definition would be good to read

> +/* interrupt trigger level for tx */
> +#define VFF_TX_THRE(n)		((n) * 7 / 8)
> +/* interrupt trigger level for rx */
> +#define VFF_RX_THRE(n)		((n) * 3 / 4)
> +
> +#define MTK_DMA_RING_SIZE	0xffffU
> +/* invert this bit when wrap ring head again*/
> +#define MTK_DMA_RING_WRAP	0x10000U
> +
> +struct mtk_dmadev {
> +	struct dma_device ddev;
> +	void __iomem *mem_base[MTK_SDMA_CHANNELS];
> +	spinlock_t lock; /* dma dev lock */
> +	struct tasklet_struct task;

tasklet should be removed in general in order to allow the task as soon as possible to be process
you could refer to mtk_hsdma.c I made in drivers/dma/mediatek/ first

> +	struct list_head pending;
> +	struct clk *clk;
> +	unsigned int dma_requests;
> +	bool support_33bits;
> +	unsigned int dma_irq[MTK_SDMA_CHANNELS];
> +	struct mtk_chan *lch_map[MTK_SDMA_CHANNELS];

why is the map required? do you offer any way for that the channel would be assigned or managed on the runtime?

> +};
> +
> +struct mtk_chan {
> +	struct virt_dma_chan vc;
> +	struct list_head node;
> +	struct dma_slave_config	cfg;
> +	void __iomem *channel_base;

channel_base can be renamed to base since the member is located at mtk_chan

> +	struct mtk_dma_desc *desc;
> +
> +	bool paused;

I don't think the variable paused since it doesn't support pause function

> +	bool requested;
> +
> +	unsigned int dma_sig;
> +	unsigned int dma_ch;
> +	unsigned int sgidx;
> +	unsigned int remain_size;
> +	unsigned int rx_ptr;
> +
> +	/*sync*/
> +	struct completion done;	/* dma transfer done */
> +	spinlock_t lock; /* channel lock */
> +	atomic_t loopcnt;
> +	atomic_t entry;		/* entry count */

Why the two atomic variables is introduced? they make the whole logic flow a little bit hard to understand.
In general, the generic dma_virtual_channels can support the most dma engines for how descriptors on each channel being managed.

You should check it first how list vc->desc_allocated, vc->desc_submitted and vc->desc_issued being maintained and really think if
it's also suitable to the dmaengine. You could refer to mtk-hsdma.c I made in drivers/dma/mediatek/ first.
The driver totally reuses these vc lists.. 

> +};
> +
> +struct mtk_dma_sg {
> +	dma_addr_t addr;
> +	unsigned int en;		/* number of elements (24-bit) */
> +	unsigned int fn;		/* number of frames (16-bit) */
> +};
> +
> +struct mtk_dma_desc {
> +	struct virt_dma_desc vd;
> +	enum dma_transfer_direction dir;
> +	dma_addr_t dev_addr;
> +

I don't see dir, dev_addr being used in code flow? or I missed something ?

> +	unsigned int sglen;
> +	struct mtk_dma_sg sg[0];
> +};
> +
> +enum {
> +	VFF_INT_FLAG		= 0x00,
> +	VFF_INT_EN		= 0x04,
> +	VFF_EN			= 0x08,
> +	VFF_RST			= 0x0c,
> +	VFF_STOP		= 0x10,
> +	VFF_FLUSH		= 0x14,
> +	VFF_ADDR		= 0x1c,
> +	VFF_LEN			= 0x24,
> +	VFF_THRE		= 0x28,
> +	VFF_WPT			= 0x2c,
> +	VFF_RPT			= 0x30,
> +	/*TX: the buffer size HW can read. RX: the buffer size SW can read.*/
> +	VFF_VALID_SIZE		= 0x3c,
> +	/*TX: the buffer size SW can write. RX: the buffer size HW can write.*/
> +	VFF_LEFT_SIZE		= 0x40,
> +	VFF_DEBUG_STATUS	= 0x50,
> +	VFF_4G_SUPPORT		= 0x54,
> +};
> +

Add register definition with #define and move them near the bit field definition.


> +static bool mtk_dma_filter_fn(struct dma_chan *chan, void *param);
> +static struct of_dma_filter_info mtk_dma_info = {
> +	.filter_fn = mtk_dma_filter_fn,
> +};
> +
> +static inline struct mtk_dmadev *to_mtk_dma_dev(struct dma_device *d)
> +{
> +	return container_of(d, struct mtk_dmadev, ddev);
> +}
> +
> +static inline struct mtk_chan *to_mtk_dma_chan(struct dma_chan *c)
> +{
> +	return container_of(c, struct mtk_chan, vc.chan);
> +}
> +
> +static inline struct mtk_dma_desc *to_mtk_dma_desc
> +	(struct dma_async_tx_descriptor *t)
> +{
> +	return container_of(t, struct mtk_dma_desc, vd.tx);
> +}
> +
> +static void mtk_dma_chan_write(struct mtk_chan *c,
> +			       unsigned int reg, unsigned int val)
> +{
> +	writel(val, c->channel_base + reg);
> +}
> +
> +static unsigned int mtk_dma_chan_read(struct mtk_chan *c, unsigned int reg)
> +{
> +	return readl(c->channel_base + reg);
> +}
> +
> +static void mtk_dma_desc_free(struct virt_dma_desc *vd)
> +{
> +	struct dma_chan *chan = vd->tx.chan;
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (c->desc && c->cfg.direction == DMA_DEV_TO_MEM)
> +		atomic_dec(&c->entry);
> +
> +	kfree(c->desc);
> +	c->desc = NULL;
> +	spin_unlock_irqrestore(&c->vc.lock, flags);

The lock should not be necessary and try to make *_desc_free be as simple as possible.

In general, the function is being only to free specific memory about the vd. It should be done by 
kfree(container_of(vd, struct mtk_apdma_vdesc, vd)); And don't need to care what detail the channel and direction is.

> +}
> +
> +static int mtk_dma_clk_enable(struct mtk_dmadev *mtkd)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(mtkd->clk);
> +	if (ret) {
> +		dev_err(mtkd->ddev.dev, "Couldn't enable the clock\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void mtk_dma_clk_disable(struct mtk_dmadev *mtkd)
> +{
> +	clk_disable_unprepare(mtkd->clk);
> +}
> +
> +static void mtk_dma_remove_virt_list(dma_cookie_t cookie,
> +				     struct virt_dma_chan *vc)
> +{
> +	struct virt_dma_desc *vd;
> +
> +	if (list_empty(&vc->desc_issued) == 0) {
> +		list_for_each_entry(vd, &vc->desc_issued, node) {
> +			if (cookie == vd->tx.cookie) {
> +				INIT_LIST_HEAD(&vc->desc_issued);

Why force to reinit list desc_issued? that is enqueued by core layer. They are expected to be configured into the hardware by the driver in sequence 
and then dequeued from the list when the descriptor is totally setting done by the driver or completed by the hardware.

> +				break;
> +			}
> +		}
> +	}
> +}
> +
> +static void mtk_dma_tx_flush(struct dma_chan *chan)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +
> +	if (mtk_dma_chan_read(c, VFF_FLUSH) == 0U) {
> +		mtk_dma_chan_write(c, VFF_FLUSH, VFF_FLUSH_B);
> +		if (atomic_dec_and_test(&c->loopcnt))

I really think depending on atomic complete a synchronization is a tricky thing. Can we have another elegant way to let synchronization become good to read and easy to maintain?

Or you could refer to mtk_hsdma.c I made in drivers/dma/mediatek/ first, the similar synchronization is also being done here.

> +			complete(&c->done);
> +	}
> +}
> +
> +/*
> + * check whether the dma flush operation is finished or not.
> + * return 0 for flush success.
> + * return others for flush timeout.
> + */
> +static int mtk_dma_check_flush_result(struct dma_chan *chan)
> +{
> +	struct timespec start, end;
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +
> +	start = ktime_to_timespec(ktime_get());
> +
> +	while ((mtk_dma_chan_read(c, VFF_FLUSH) & VFF_FLUSH_B) == VFF_FLUSH_B) {
> +		end = ktime_to_timespec(ktime_get());
> +		if ((end.tv_sec - start.tv_sec) > 1 ||
> +		    ((end.tv_sec - start.tv_sec) == 1 &&
> +		      end.tv_nsec > start.tv_nsec)) {
> +			dev_err(chan->device->dev,
> +				"[DMA] Polling flush timeout\n");
> +			return -1;

You can check readx_poll_timeout and related APIs instead of the open coding.

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void mtk_dma_tx_write(struct dma_chan *chan)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
> +	unsigned int txcount = c->remain_size;
> +	unsigned int len, send, left, wpt, wrap;
> +
> +	if (atomic_inc_return(&c->entry) > 1) {

atomic variable again. Can you explain more about what the branches (if and else) are doing for ? Let's see if they can be replaced by more elegant ways

> +		if (vchan_issue_pending(&c->vc) && !c->desc) {
> +			spin_lock(&mtkd->lock);
> +			list_add_tail(&c->node, &mtkd->pending);
> +			spin_unlock(&mtkd->lock);
> +			tasklet_schedule(&mtkd->task);
> +		}
> +	} else {
> +		len = mtk_dma_chan_read(c, VFF_LEN);
> +		if (mtk_dma_check_flush_result(chan) != 0)
> +			return;
> +
> +		while ((left = mtk_dma_chan_read(c, VFF_LEFT_SIZE)) > 0U) {
> +			send = min(left, c->remain_size);
> +			wpt = mtk_dma_chan_read(c, VFF_WPT);
> +			wrap = wpt & MTK_DMA_RING_WRAP ? 0U : MTK_DMA_RING_WRAP;
> +
> +			if ((wpt & (len - 1U)) + send < len)
> +				mtk_dma_chan_write(c, VFF_WPT, wpt + send);
> +			else
> +				mtk_dma_chan_write(c, VFF_WPT,
> +						   ((wpt + send) & (len - 1U))
> +						   | wrap);
> +
> +			c->remain_size -= send;
> +			if (c->remain_size == 0U)

the if condition can be moved to the the beginning while condition

> +				break;
> +		}
> +
> +		if (txcount != c->remain_size) {
> +			mtk_dma_chan_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);

why need to enable interrupt to trigger the next?

> +			mtk_dma_tx_flush(chan);
> +		}
> +	}
> +	atomic_dec(&c->entry);
> +}
> +
> +static void mtk_dma_start_tx(struct mtk_chan *c)
> +{
> +	if (mtk_dma_chan_read(c, VFF_LEFT_SIZE) == 0U) {
> +		pr_info("%s maybe need fix? @L %d\n", __func__, __LINE__);

the debug message can be removed 

> +		mtk_dma_chan_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);

what is the step for?

> +	} else {
> +		reinit_completion(&c->done);
> +
> +		/* inc twice, once for tx_flush, another for tx_interrupt */
> +		atomic_inc(&c->loopcnt);
> +		atomic_inc(&c->loopcnt);

if you have two events for which some point wants to wait, why not create two two completions for them?

> +		mtk_dma_tx_write(&c->vc.chan);
> +	}
> +	c->paused = false;
> +}
> +
> +static void mtk_dma_get_rx_size(struct mtk_chan *c)
> +{
> +	unsigned int count;
> +	unsigned int rdptr, wrptr, wrreg, rdreg;
> +	unsigned int rx_size = mtk_dma_chan_read(c, VFF_LEN);
> +

Sort all declarations in reversed Xmas tree, even along with all occurrences in the other functions

> +	rdreg = mtk_dma_chan_read(c, VFF_RPT);
> +	wrreg = mtk_dma_chan_read(c, VFF_WPT);
> +	rdptr = rdreg & MTK_DMA_RING_SIZE;
> +	wrptr = wrreg & MTK_DMA_RING_SIZE;
> +	count = ((rdreg ^ wrreg) & MTK_DMA_RING_WRAP) ?
> +			(wrptr + rx_size - rdptr) : (wrptr - rdptr);
> +
> +	c->remain_size = count;
> +	c->rx_ptr = rdptr;
> +
> +	mtk_dma_chan_write(c, VFF_RPT, wrreg);
> +}
> +
> +static void mtk_dma_start_rx(struct mtk_chan *c)
> +{
> +	struct dma_chan *chan = &c->vc.chan;
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
> +	struct mtk_dma_desc *d = c->desc;
> +
> +	if (mtk_dma_chan_read(c, VFF_VALID_SIZE) != 0U &&
> +	    d && d->vd.tx.cookie != 0) {
> +		mtk_dma_get_rx_size(c);
> +		mtk_dma_remove_virt_list(d->vd.tx.cookie, &c->vc);
> +		vchan_cookie_complete(&d->vd);

please make vchan_cookie_complete in a completion handler such as a completion ISR, not in a start handler.

> +	} else {
> +		if (mtk_dma_chan_read(c, VFF_VALID_SIZE) != 0U) {
> +			spin_lock(&mtkd->lock);
> +			if (list_empty(&mtkd->pending))
> +				list_add_tail(&c->node, &mtkd->pending);
> +			spin_unlock(&mtkd->lock);
> +			tasklet_schedule(&mtkd->task);
> +		} else {
> +			if (atomic_read(&c->entry) > 0)
> +				atomic_set(&c->entry, 0);

I am not not clear about the magical reset. could you explain more?

> +		}
> +	}
> +}
> +
> +static void mtk_dma_reset(struct mtk_chan *c)
> +{
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(c->vc.chan.device);
> +
> +	mtk_dma_chan_write(c, VFF_ADDR, 0);
> +	mtk_dma_chan_write(c, VFF_THRE, 0);
> +	mtk_dma_chan_write(c, VFF_LEN, 0);
> +	mtk_dma_chan_write(c, VFF_RST, VFF_WARM_RST_B);
> +
> +	while
> +		(mtk_dma_chan_read(c, VFF_EN));

add a timeout, otherwise it would get a hang possibly. you can check readx_poll_timeout and related APIs to add a timeout.

> +
> +	if (c->cfg.direction == DMA_DEV_TO_MEM)
> +		mtk_dma_chan_write(c, VFF_RPT, 0);
> +	else if (c->cfg.direction == DMA_MEM_TO_DEV)
> +		mtk_dma_chan_write(c, VFF_WPT, 0);
> +	else
> +		dev_info(c->vc.chan.device->dev, "Unknown direction.\n");

is it possible to happen?

> +
> +	if (mtkd->support_33bits)
> +		mtk_dma_chan_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_CLR_B);
> +}
> +
> +static void mtk_dma_stop(struct mtk_chan *c)
> +{
> +	int polling_cnt;
> +
> +	mtk_dma_chan_write(c, VFF_FLUSH, VFF_FLUSH_CLR_B);
> +
> +	polling_cnt = 0;
> +	while ((mtk_dma_chan_read(c, VFF_FLUSH) & VFF_FLUSH_B) ==
> +		VFF_FLUSH_B)	{
> +		polling_cnt++;
> +		if (polling_cnt > 10000) {
> +			dev_err(c->vc.chan.device->dev,
> +				"dma stop: polling FLUSH fail, DEBUG=0x%x\n",
> +				mtk_dma_chan_read(c, VFF_DEBUG_STATUS));
> +			break;
> +		}
> +	}

You can check readx_poll_timeout and related APIs to make the fucntion more readable

> +
> +	polling_cnt = 0;
> +	/*set stop as 1 -> wait until en is 0 -> set stop as 0*/
> +	mtk_dma_chan_write(c, VFF_STOP, VFF_STOP_B);
> +	while (mtk_dma_chan_read(c, VFF_EN)) {
> +		polling_cnt++;
> +		if (polling_cnt > 10000) {
> +			dev_err(c->vc.chan.device->dev,
> +				"dma stop: polling VFF_EN fail, DEBUG=0x%x\n",
> +				mtk_dma_chan_read(c, VFF_DEBUG_STATUS));
> +			break;
> +		}
> +	}

You can check readx_poll_timeout and related APIs to make the function more readable.

> +	mtk_dma_chan_write(c, VFF_STOP, VFF_STOP_CLR_B);
> +	mtk_dma_chan_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
> +
> +	if (c->cfg.direction == DMA_DEV_TO_MEM)
> +		mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> +	else
> +		mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
> +
> +	c->paused = true;

It's a stop, not a pause

> +}
> +
> +/*
> + * We need to deal with 'all channels in-use'
> + */
> +static void mtk_dma_rx_sched(struct mtk_chan *c)
> +{
> +	struct dma_chan *chan = &c->vc.chan;
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
> +
> +	if (atomic_read(&c->entry) < 1) {
> +		mtk_dma_start_rx(c);
> +	} else {
> +		spin_lock(&mtkd->lock);
> +		if (list_empty(&mtkd->pending))
> +			list_add_tail(&c->node, &mtkd->pending);
> +		spin_unlock(&mtkd->lock);
> +		tasklet_schedule(&mtkd->task);

I'm not clear why mixing start rx and tasklet rx here. In general, please make all tx/rx job as soon as poosible.

you can refer to the mtk_hsdma.c I made.

> +	}
> +}
> +
> +/*
> + * This callback schedules all pending channels. We could be more
> + * clever here by postponing allocation of the real DMA channels to
> + * this point, and freeing them when our virtual channel becomes idle.
> + *
> + * We would then need to deal with 'all channels in-use'
> + */
> +static void mtk_dma_sched(unsigned long data)
> +{
> +	struct mtk_dmadev *mtkd = (struct mtk_dmadev *)data;
> +	struct mtk_chan *c;
> +	struct virt_dma_desc *vd;
> +	dma_cookie_t cookie;
> +	LIST_HEAD(head);
> +	unsigned long flags;
> +
> +	spin_lock_irq(&mtkd->lock);
> +	list_splice_tail_init(&mtkd->pending, &head);
> +	spin_unlock_irq(&mtkd->lock);
> +
> +	if (list_empty(&head) == 0) {

!list_empty

> +		c = list_first_entry(&head, struct mtk_chan, node);
> +		cookie = c->vc.chan.cookie;
> +
> +		spin_lock_irqsave(&c->vc.lock, flags);

head is a local list so the lock is not neccessary

> +		if (c->cfg.direction == DMA_DEV_TO_MEM) {
> +			list_del_init(&c->node);

why not use list_dec version

> +			mtk_dma_rx_sched(c);
> +		} else if (c->cfg.direction == DMA_MEM_TO_DEV) {
> +			vd = vchan_find_desc(&c->vc, cookie);
> +
> +			c->desc = to_mtk_dma_desc(&vd->tx);
> +			list_del_init(&c->node);
> +			mtk_dma_start_tx(c);

why is direct call for tx and tasklet for rx?

> +		}
> +		spin_unlock_irqrestore(&c->vc.lock, flags);
> +	}
> +}
> +
> +static int mtk_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	int ret = -EBUSY;
> +
> +	pm_runtime_get_sync(mtkd->ddev.dev);
> +
> +	if (!mtkd->lch_map[c->dma_ch]) {
> +		c->channel_base = mtkd->mem_base[c->dma_ch];
> +		mtkd->lch_map[c->dma_ch] = c;

keep lch_map in mtkd is not necessary. instead, I think we can keep all information required by the physical channel inside mtk_chan, not exported to the whole dma engine.

> +		ret = 1;

why returning 1 here?

> +	}
> +	c->requested = false;
> +	mtk_dma_reset(c);
> +
> +	return ret;
> +}
> +
> +static void mtk_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +
> +	if (c->requested) {
> +		c->requested = false;
> +		free_irq(mtkd->dma_irq[c->dma_ch], chan);
> +	}
> +
> +	tasklet_kill(&mtkd->task);
> +
> +	c->channel_base = NULL;
> +	mtkd->lch_map[c->dma_ch] = NULL;
> +	vchan_free_chan_resources(&c->vc);

I think we should call mtk_dma_terminate first to free all descriptors and then free the other channel resouce in the function.

> +
> +	dev_dbg(mtkd->ddev.dev, "freeing channel for %u\n", c->dma_sig);
> +	c->dma_sig = 0;
> +
> +	pm_runtime_put_sync(mtkd->ddev.dev);
> +}
> +
> +static enum dma_status mtk_dma_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	ret = dma_cookie_status(chan, cookie, txstate);

consider txstate null case and directly return when the descriptor is complete, such as

ret = dma_cookie_status(c, cookie, txstate);
	if (ret == DMA_COMPLETE || !txstate)
		return ret;

> +
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (ret == DMA_IN_PROGRESS) {
> +		c->rx_ptr = mtk_dma_chan_read(c, VFF_RPT) & MTK_DMA_RING_SIZE;
> +		txstate->residue = c->rx_ptr;

are you sure all descriptors DMA_IN_PROCESS all be processed by hardware ?

> +	} else if (ret == DMA_COMPLETE && c->cfg.direction == DMA_DEV_TO_MEM) {
> +		txstate->residue = c->remain_size;

why is residue not zero when dma is complete ?

> +	} else {
> +		txstate->residue = 0;
> +	}

setup ->residue by dma_set_residue

> +	spin_unlock_irqrestore(&c->vc.lock, flags);
> +

spin_lock can be dropped 

> +	return ret;
> +}
> +
> +static unsigned int mtk_dma_desc_size(struct mtk_dma_desc *d)
> +{
> +	struct mtk_dma_sg *sg;
> +	unsigned int i;
> +	unsigned int size;
> +
> +	for (size = i = 0; i < d->sglen; i++) {
> +		sg = &d->sg[i];
> +		size += sg->en * sg->fn;
> +	}
> +	return size;

drop the function definition, see the below reason.

> +}
> +
> +static struct dma_async_tx_descriptor *mtk_dma_prep_slave_sg
> +	(struct dma_chan *chan, struct scatterlist *sgl,
> +	unsigned int sglen,	enum dma_transfer_direction dir,
> +	unsigned long tx_flags, void *context)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	struct scatterlist *sgent;
> +	struct mtk_dma_desc *d;
> +	dma_addr_t dev_addr;
> +	unsigned int i, j, en, frame_bytes;

save the variable frame_bytes an en, it's always kept as 1 during the function call

> +
> +	en = 1;
> +	frame_bytes = 1;
> +
> +	if (dir == DMA_DEV_TO_MEM) {
> +		dev_addr = c->cfg.src_addr;
> +	} else if (dir == DMA_MEM_TO_DEV) {
> +		dev_addr = c->cfg.dst_addr;
> +	} else {
> +		dev_err(chan->device->dev, "bad direction\n");

the case seems never happens because the device registers the capability it can support to.

> +		return NULL;
> +	}
> +
> +	/* Now allocate and setup the descriptor. */
> +	d = kzalloc(sizeof(*d) + sglen * sizeof(d->sg[0]), GFP_ATOMIC);
> +	if (!d)
> +		return NULL;
> +
> +	d->dir = dir;
> +	d->dev_addr = dev_addr;

when and where is the d->dev_addr being used?

> +
> +	j = 0;
> +	for_each_sg(sgl, sgent, sglen, i) {
> +		d->sg[j].addr = sg_dma_address(sgent);
> +		d->sg[j].en = en;
> +		d->sg[j].fn = sg_dma_len(sgent) / frame_bytes;
> +		j++;
> +	}
> +
> +	d->sglen = j;
> +
> +	if (dir == DMA_MEM_TO_DEV)
> +		c->remain_size = mtk_dma_desc_size(d);

function mtk_dma_desc_size can be dropped since the function is only used once and the result can be accumulated by for_each_sg

> +	return vchan_tx_prep(&c->vc, &d->vd, tx_flags);
> +}
> +
> +static void mtk_dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	struct mtk_dmadev *mtkd;
> +	struct virt_dma_desc *vd;
> +	dma_cookie_t cookie;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (c->cfg.direction == DMA_DEV_TO_MEM) {
> +		cookie = c->vc.chan.cookie;
> +		mtkd = to_mtk_dma_dev(chan->device);
> +		if (vchan_issue_pending(&c->vc) && !c->desc) {
> +			vd = vchan_find_desc(&c->vc, cookie);
> +			c->desc = to_mtk_dma_desc(&vd->tx);
> +			if (atomic_read(&c->entry) > 0)
> +				atomic_set(&c->entry, 0);
> +		}
> +	} else if (c->cfg.direction == DMA_MEM_TO_DEV) {
> +		cookie = c->vc.chan.cookie;
> +		if (vchan_issue_pending(&c->vc) && !c->desc) {
> +			vd = vchan_find_desc(&c->vc, cookie);
> +			c->desc = to_mtk_dma_desc(&vd->tx);
> +			mtk_dma_start_tx(c);
> +		}
> +	}
> +	spin_unlock_irqrestore(&c->vc.lock, flags)


in general, we have to dump all vc->desc_issued into the hw as soon as possible. how is the other descriptors except for the cookie stands for ?

> ;
> +}
> +
> +static irqreturn_t mtk_dma_rx_interrupt(int irq, void *dev_id)
> +{
> +	struct dma_chan *chan = (struct dma_chan *)dev_id;
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> +
> +	if (atomic_inc_return(&c->entry) > 1) {
> +		if (list_empty(&mtkd->pending))
> +			list_add_tail(&c->node, &mtkd->pending);
> +		tasklet_schedule(&mtkd->task);
> +	} else {
> +		mtk_dma_start_rx(c);
> +	}

what's the reason making rx into direct call or tasklet in some case?

> +	spin_unlock_irqrestore(&c->vc.lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t mtk_dma_tx_interrupt(int irq, void *dev_id)
> +{
> +	struct dma_chan *chan = (struct dma_chan *)dev_id;
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
> +	struct mtk_dma_desc *d = c->desc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (c->remain_size != 0U) {
> +		list_add_tail(&c->node, &mtkd->pending);
> +		tasklet_schedule(&mtkd->task);
> +	} else {
> +		mtk_dma_remove_virt_list(d->vd.tx.cookie, &c->vc);
> +		vchan_cookie_complete(&d->vd);
> +	}
> +	spin_unlock_irqrestore(&c->vc.lock, flags);
> +
> +	mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
> +	if (atomic_dec_and_test(&c->loopcnt))
> +		complete(&c->done);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_dma_slave_config(struct dma_chan *chan,
> +				struct dma_slave_config *cfg)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	struct mtk_dmadev *mtkd = to_mtk_dma_dev(c->vc.chan.device);
> +	int ret;
> +
> +	c->cfg = *cfg;
> +
> +	if (cfg->direction == DMA_DEV_TO_MEM) {
> +		unsigned int rx_len = cfg->src_addr_width * 1024;

the dma eingine only supports DMA_SLAVE_BUSWIDTH_1_BYTE, why do we need to consider any other src_addr_width here ?

> +
> +		mtk_dma_chan_write(c, VFF_ADDR, cfg->src_addr);
> +		mtk_dma_chan_write(c, VFF_LEN, rx_len);
> +		mtk_dma_chan_write(c, VFF_THRE, VFF_RX_THRE(rx_len));
> +		mtk_dma_chan_write(c,
> +				   VFF_INT_EN, VFF_RX_INT_EN0_B
> +				   | VFF_RX_INT_EN1_B);
> +		mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
> +		mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> +
> +		if (!c->requested) {
> +			atomic_set(&c->entry, 0);
> +			c->requested = true;
> +			ret = request_irq(mtkd->dma_irq[c->dma_ch],
> +					  mtk_dma_rx_interrupt,
> +					  IRQF_TRIGGER_NONE,
> +			

move the request_irq to driver probe stage, it can be manage by the core such irq affinity 

> 		  DRV_NAME, chan);
> +			if (ret < 0) {
> +				dev_err(chan->device->dev, "Can't request rx dma IRQ\n");
> +				return -EINVAL;
> +			}
> +		}
> +	} else if (cfg->direction == DMA_MEM_TO_DEV)	{
> +		unsigned int tx_len = cfg->dst_addr_width * 1024;
> +

the dma eingine only supports DMA_SLAVE_BUSWIDTH_1_BYTE, why do we need to consider any other src_addr_width here ?

> +		mtk_dma_chan_write(c, VFF_ADDR, cfg->dst_addr);
> +		mtk_dma_chan_write(c, VFF_LEN, tx_len);
> +		mtk_dma_chan_write(c, VFF_THRE, VFF_TX_THRE(tx_len));
> +		mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
> +		mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
> +
> +		if (!c->requested) {
> +			c->requested = true;
> +			ret = request_irq(mtkd->dma_irq[c->dma_ch],
> +					  mtk_dma_tx_interrupt,
> +					  IRQF_TRIGGER_NONE,
> +					  DRV_NAME, chan);

move the request_irq to driver probe stage, it can be manage by the core such irq affinity 

> +			if (ret < 0) {
> +				dev_err(chan->device->dev, "Can't request tx dma IRQ\n");
> +				return -EINVAL;
> +			}
> +		}
> +	} else {
> +		dev_info(chan->device->dev, "Unknown direction!\n");

remove the the unnecessary log

> +	}
> +
> +	if (mtkd->support_33bits)
> +		mtk_dma_chan_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_B);
> +
> +	if (mtk_dma_chan_read(c, VFF_EN) != VFF_EN_B) {

when is the condition being satisfied ?

> +		dev_err(chan->device->dev,
> +			"config dma dir[%d] fail\n", cfg->direction);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct mtk_chan *c = to_mtk_dma_chan(chan);
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	if (atomic_read(&c->loopcnt) != 0)
> +		wait_for_completion(&c->done);
> +
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (c->desc) {
> +		mtk_dma_remove_virt_list(c->desc->vd.tx.cookie, &c->vc);
> +		spin_unlock_irqrestore(&c->vc.lock, flags);
> +
> +		mtk_dma_desc_free(&c->desc->vd);
> +
> +		spin_lock_irqsave(&c->vc.lock, flags);
> +		if (!c->paused)	{
> +			list_del_init(&c->node);
> +			mtk_dma_stop(c);

I think split logic between descriptors recycle and channel stop would
be good.

> +		}
> +	}
> +	vchan_get_all_descriptors(&c->vc, &head);
> +	spin_unlock_irqrestore(&c->vc.lock, flags);
> +
> +	vchan_dma_desc_free_list(&c->vc, &head);


Can you tell more about the situation for vc->desc_allocated, vc->desc_submitted and vc->desc_issued when the function is being called ?
Which list do the descriptors hardware is processing stay on?


> +
> +	return 0;
> +}
> +
> +static int mtk_dma_device_pause(struct dma_chan *chan)
> +{
> +	/* Pause/Resume only allowed with cyclic mode */
> +	return -EINVAL;
> +}

I guess we don't nodde to register the dumb pause handler

> +
> +static int mtk_dma_device_resume(struct dma_chan *chan)
> +{
> +	/* Pause/Resume only allowed with cyclic mode */
> +	return -EINVAL;
> +}

I guess we don't nodde to register the dumb resume handler

> +
> +static int mtk_dma_chan_init(struct mtk_dmadev *mtkd)
> +{

Directly span the function in the driver probe is good to know how many channels are request and how large size its memory being allocated.

> +	struct mtk_chan *c;
> +
> +	c = devm_kzalloc(mtkd->ddev.dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	c->vc.desc_free = mtk_dma_desc_free;
> +	vchan_init(&c->vc, &mtkd->ddev);
> +	spin_lock_init(&c->lock);
> +	INIT_LIST_HEAD(&c->node);
> +
> +	init_completion(&c->done);
> +	atomic_set(&c->loopcnt, 0);
> +	atomic_set(&c->entry, 0);

I really don't like to magic atomic variable. It would make it's harder to track each descriptors usage either pending or active in the dma engine.

> +
> +	return 0;
> +}
> +
> +static void mtk_dma_free(struct mtk_dmadev *mtkd)
> +{
> +	tasklet_kill(&mtkd->task);
> +	while (list_empty(&mtkd->ddev.channels) == 0) {
> +		struct mtk_chan *c = list_first_entry(&mtkd->ddev.channels,
> +			struct mtk_chan, vc.chan.device_node);
> +
> +		list_del(&c->vc.chan.device_node);
> +		tasklet_kill(&c->vc.task);
> +		devm_kfree(mtkd->ddev.dev, c);

devm_kfree isn't be called explicitly in the driver, it would be taken care when driver is unloaded by the core.

> +	}
> +}
> +
> +static const struct of_device_id mtk_uart_dma_match[] = {
> +	{ .compatible = "mediatek,mt6577-uart-dma", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, mtk_uart_dma_match);
> +
> +static int mtk_dma_probe(struct platform_device *pdev)
> +{
> +	struct mtk_dmadev *mtkd;
> +	struct resource *res;
> +	unsigned int i;
> +	int rc;
> +
> +	mtkd = devm_kzalloc(&pdev->dev, sizeof(*mtkd), GFP_KERNEL);
> +	if (!mtkd)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < MTK_SDMA_CHANNELS; i++) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res)
> +			return -ENODEV;
> +		mtkd->mem_base[i] = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(mtkd->mem_base[i]))
> +			return PTR_ERR(mtkd->mem_base[i]);
> +	}
> +
> +	/* request irq */

remove the comment that is not identical to the implementation as below code snippet

> +	for (i = 0; i < MTK_SDMA_CHANNELS; i++) {
> +		mtkd->dma_irq[i] = platform_get_irq(pdev, i);
> +		if ((int)mtkd->dma_irq[i] < 0) {

the cast seems not necessary

> +			dev_err(&pdev->dev, "failed to get IRQ[%d]\n", i);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	mtkd->clk = devm_clk_get(&pdev->dev, NULL);

assign a name to the "apdma" per the binding you adds

> +	if (IS_ERR(mtkd->clk)) {
> +		dev_err(&pdev->dev, "No clock specified\n");
> +		return PTR_ERR(mtkd->clk);
> +	}
> +
> +	if (of_property_read_bool(pdev->dev.of_node, "dma-33bits")) {
> +		dev_info(&pdev->dev, "Support dma 33bits\n");
> +		mtkd->support_33bits = true;
> +	}
> +
> +	if (mtkd->support_33bits)
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(33));
> +	else
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	if (rc)
> +		return rc;
> +
> +	dma_cap_set(DMA_SLAVE, mtkd->ddev.cap_mask);
> +	mtkd->ddev.device_alloc_chan_resources = mtk_dma_alloc_chan_resources;
> +	mtkd->ddev.device_free_chan_resources = mtk_dma_free_chan_resources;
> +	mtkd->ddev.device_tx_status = mtk_dma_tx_status;
> +	mtkd->ddev.device_issue_pending = mtk_dma_issue_pending;
> +	mtkd->ddev.device_prep_slave_sg = mtk_dma_prep_slave_sg;
> +	mtkd->ddev.device_config = mtk_dma_slave_config;
> +	mtkd->ddev.device_pause = mtk_dma_device_pause;
> +	mtkd->ddev.device_resume = mtk_dma_device_resume;

Is it possible that we don't register pause and resume handler if the dma engine cannot support to?

> +	mtkd->ddev.device_terminate_all = mtk_dma_terminate_all;
> +	mtkd->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	mtkd->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> +	mtkd->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	mtkd->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +	mtkd->ddev.dev = &pdev->dev;
> +	INIT_LIST_HEAD(&mtkd->ddev.channels);
> +	INIT_LIST_HEAD(&mtkd->pending);
> +
> +	spin_lock_init(&mtkd->lock);
> +	tasklet_init(&mtkd->task, mtk_dma_sched, (unsigned long)mtkd);
> +
> +	mtkd->dma_requests = MTK_SDMA_REQUESTS;
> +	if (of_property_read_u32(pdev->dev.of_node,
> +				 "dma-requests", &mtkd->dma_requests) != 0) {

extra "! = 0" can be dropped in the condition check

> +		dev_info(&pdev->dev,
> +			 "Missing dma-requests property, using %u.\n",
> +			 MTK_SDMA_REQUESTS);
> +	}
> +
> +	for (i = 0; i < MTK_SDMA_CHANNELS; i++) {
> +		rc = mtk_dma_chan_init(mtkd);
> +		if (rc)
> +			goto err_no_dma;
> +	}
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +
> +	rc = dma_async_device_register(&mtkd->ddev);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "fail to register DMA device: %d\n", rc);

drop the debug log

> +		mtk_dma_clk_disable(mtkd);

move the undo jobs at the tail of the function to error handling clean

> +		goto err_no_dma;
> +	}
> +
> +	platform_set_drvdata(pdev, mtkd);
> +
> +	if (pdev->dev.of_node) {

you don't need that since all mtk drivers are dt based

> +		mtk_dma_info.dma_cap = mtkd->ddev.cap_mask;
> +
> +		/* Device-tree DMA controller registration */
> +		rc = of_dma_controller_register(pdev->dev.of_node,
> +						of_dma_simple_xlate,
> +						&mtk_dma_info);
> +		if (rc) {
> +			dev_warn(&pdev->dev, "fail to register DMA controller\n");

drop the debug log

> +			dma_async_device_unregister(&mtkd->ddev);
> +			mtk_dma_clk_disable(mtkd);

move the undo jobs at the tail of the function to make error handling clean

> +			goto err_no_dma;
> +		}
> +	}
> +
> +	return rc;
> +
> +err_no_dma:
> +	mtk_dma_free(mtkd);
> +	return rc;
> +}
> +
> +static int mtk_dma_remove(struct platform_device *pdev)
> +{
> +	struct mtk_dmadev *mtkd = platform_get_drvdata(pdev);
> +
> +	if (pdev->dev.of_node)
> +		of_dma_controller_free(pdev->dev.of_node);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
> +	dma_async_device_unregister(&mtkd->ddev);
> +
> +	mtk_dma_free(mtkd);

Extra task in the remove handler is needed to add here such as ensure that VC tasks being killed, disable hardware and its interrupts and wait for pending ISRs task all done.

> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_dma_suspend(struct device *dev)
> +{
> +	struct mtk_dmadev *mtkd = dev_get_drvdata(dev);
> +
> +	if (!pm_runtime_suspended(dev))
> +		mtk_dma_clk_disable(mtkd);
> +
> +	return 0;
> +}
> +
> +static int mtk_dma_resume(struct device *dev)
> +{
> +	int ret;
> +	struct mtk_dmadev *mtkd = dev_get_drvdata(dev);
> +
> +	if (!pm_runtime_suspended(dev)) {
> +		ret = mtk_dma_clk_enable(mtkd);
> +		if (ret) {
> +			dev_info(dev, "fail to enable clk: %d\n", ret);

get rid of the debug message

> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_dma_runtime_suspend(struct device *dev)
> +{
> +	struct mtk_dmadev *mtkd = dev_get_drvdata(dev);
> +
> +	mtk_dma_clk_disable(mtkd);
> +
> +	return 0;
> +}
> +
> +static int mtk_dma_runtime_resume(struct device *dev)
> +{
> +	int ret;
> +	struct mtk_dmadev *mtkd = dev_get_drvdata(dev);
> +
> +	ret = mtk_dma_clk_enable(mtkd);
> +	if (ret) {
> +		dev_warn(dev, "fail to enable clk: %d\n", ret);

get rid of the debug message

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops mtk_dma_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(mtk_dma_suspend, mtk_dma_resume)
> +	SET_RUNTIME_PM_OPS(mtk_dma_runtime_suspend,
> +			   mtk_dma_runtime_resume, NULL)
> +};
> +
> +static struct platform_driver mtk_dma_driver = {
> +	.probe	= mtk_dma_probe,

mtk_apdma_uart_probe? I guess apdma is a real name for the dma engine

> +	.remove	= mtk_dma_remove,

mtk_apdma_uart_remove? same reason as the above 

> +	.driver = {
> +		.name		= "8250-mtk-dma",

.name		= KBUILD_MODNAME,

> +		.pm		= &mtk_dma_pm_ops,
> +		.of_match_table = of_match_ptr(mtk_uart_dma_match),
> +	},
> +};
> +
> +static bool mtk_dma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	if (chan->device->dev->driver == &mtk_dma_driver.driver) {
> +		struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
> +		struct mtk_chan *c = to_mtk_dma_chan(chan);
> +		unsigned int req = *(unsigned int *)param;
> +
> +		if (req <= mtkd->dma_requests) {
> +			c->dma_sig = req;
> +			c->dma_ch = req;
> +			return true;
> +		}
> +	}
> +	return false;
> +}

I really wonder if the filter fn is necessary stuff made here but I am not fully sure.

Can you look into more about of_dma_controller_register and its usage to see if the generic call satisfies your need?

> +
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

Use module_platform_driver instead and then add more information for the module such as MODULE_DESCRIPTION, MODULE_AUTHOR, MODULE_LICENSE.

> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index dacf3f4..cfa1699 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -151,6 +151,17 @@ config DMA_JZ4780
>  	  If you have a board based on such a SoC and wish to use DMA for
>  	  devices which can use the DMA controller, say Y or M here.
>  
> +config DMA_MTK_UART
> +	tristate "MediaTek SoCs APDMA support for UART"
> +	depends on OF
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support for the UART DMA engine found on MediaTek MTK SoCs.
> +	  when 8250 mtk uart is enabled, and if you want to using DMA,
> +	  you can enable the config. the DMA engine just only be used
> +	  with MediaTek Socs.
> +
>  config DMA_SA11X0
>  	tristate "SA-11x0 DMA support"
>  	depends on ARCH_SA1100 || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index c91702d..42690d8 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
>  obj-$(CONFIG_DMA_BCM2835) += bcm2835-dma.o
>  obj-$(CONFIG_DMA_JZ4740) += dma-jz4740.o
>  obj-$(CONFIG_DMA_JZ4780) += dma-jz4780.o
> +obj-$(CONFIG_DMA_MTK_UART) += 8250_mtk_dma.o

move Makefile update to drivers/dma/mediatek

>  obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
>  obj-$(CONFIG_DMA_SUN4I) += sun4i-dma.o
>  obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
