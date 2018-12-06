From: Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH v2 2/4] dmaengine: mtk_uart_dma: add Mediatek uart DMA support
Date: Thu, 6 Dec 2018 13:22:01 -0800
Message-ID: <CAGp9LzpVuhWHBgL3qoXQKqoGAhCWY8FS7b_xVi2V=JeDAOz+8g@mail.gmail.com>
References: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
 <1543999380-7946-3-git-send-email-long.cheng@mediatek.com>
 <CAGp9LzqkOHPqVmAOR+YRotOb511BEDOpUWHc-YSjphF3Gpar=w@mail.gmail.com> <1544090140.28871.11.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544090140.28871.11.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: long.cheng@mediatek.com
Cc: vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, jslaby@suse.com, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org, yt.shen@mediatek.com
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 6, 2018 at 1:55 AM Long Cheng <long.cheng@mediatek.com> wrote:
>
> On Wed, 2018-12-05 at 13:07 -0800, Sean Wang wrote:
> > .
> > On Wed, Dec 5, 2018 at 1:31 AM Long Cheng <long.cheng@mediatek.com> wrote:
> > >
> > > In DMA engine framework, add 8250 mtk dma to support it.
> > >
> > > Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> > > ---
> > >  drivers/dma/mediatek/8250_mtk_dma.c |  894 +++++++++++++++++++++++++++++++++++
> > >  drivers/dma/mediatek/Kconfig        |   11 +
> > >  drivers/dma/mediatek/Makefile       |    1 +
> > >  3 files changed, 906 insertions(+)
> > >  create mode 100644 drivers/dma/mediatek/8250_mtk_dma.c
> > >
> > > diff --git a/drivers/dma/mediatek/8250_mtk_dma.c b/drivers/dma/mediatek/8250_mtk_dma.c
> > > new file mode 100644
> > > index 0000000..3454679
> > > --- /dev/null
> > > +++ b/drivers/dma/mediatek/8250_mtk_dma.c
> > > @@ -0,0 +1,894 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Mediatek 8250 DMA driver.
> > > + *
> > > + * Copyright (c) 2018 MediaTek Inc.
> > > + * Author: Long Cheng <long.cheng@mediatek.com>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/dmaengine.h>
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/err.h>
> > > +#include <linux/init.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/list.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_dma.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/iopoll.h>
> > > +
> > > +#include "../virt-dma.h"
> > > +
> > > +#define MTK_APDMA_DEFAULT_REQUESTS     127
> > > +#define MTK_APDMA_CHANNELS             (CONFIG_SERIAL_8250_NR_UARTS * 2)
> > > +
> > > +#define VFF_EN_B               BIT(0)
> > > +#define VFF_STOP_B             BIT(0)
> > > +#define VFF_FLUSH_B            BIT(0)
> > > +#define VFF_4G_SUPPORT_B       BIT(0)
> > > +#define VFF_RX_INT_EN0_B       BIT(0)  /*rx valid size >=  vff thre*/
> > > +#define VFF_RX_INT_EN1_B       BIT(1)
> > > +#define VFF_TX_INT_EN_B                BIT(0)  /*tx left size >= vff thre*/
> > > +#define VFF_WARM_RST_B         BIT(0)
> > > +#define VFF_RX_INT_FLAG_CLR_B  (BIT(0) | BIT(1))
> > > +#define VFF_TX_INT_FLAG_CLR_B  0
> > > +#define VFF_STOP_CLR_B         0
> > > +#define VFF_FLUSH_CLR_B                0
> > > +#define VFF_INT_EN_CLR_B       0
> > > +#define VFF_4G_SUPPORT_CLR_B   0
> > > +
> > > +/* interrupt trigger level for tx */
> > > +#define VFF_TX_THRE(n)         ((n) * 7 / 8)
> > > +/* interrupt trigger level for rx */
> > > +#define VFF_RX_THRE(n)         ((n) * 3 / 4)
> > > +
> > > +#define MTK_DMA_RING_SIZE      0xffffU
> > > +/* invert this bit when wrap ring head again*/
> > > +#define MTK_DMA_RING_WRAP      0x10000U
> > > +
> > > +#define VFF_INT_FLAG           0x00
> > > +#define VFF_INT_EN             0x04
> > > +#define VFF_EN                 0x08
> > > +#define VFF_RST                        0x0c
> > > +#define VFF_STOP               0x10
> > > +#define VFF_FLUSH              0x14
> > > +#define VFF_ADDR               0x1c
> > > +#define VFF_LEN                        0x24
> > > +#define VFF_THRE               0x28
> > > +#define VFF_WPT                        0x2c
> > > +#define VFF_RPT                        0x30
> > > +/*TX: the buffer size HW can read. RX: the buffer size SW can read.*/
> > > +#define VFF_VALID_SIZE         0x3c
> > > +/*TX: the buffer size SW can write. RX: the buffer size HW can write.*/
> > > +#define VFF_LEFT_SIZE          0x40
> > > +#define VFF_DEBUG_STATUS       0x50
> > > +#define VFF_4G_SUPPORT         0x54
> > > +
> > > +struct mtk_dmadev {
> > > +       struct dma_device ddev;
> > > +       void __iomem *mem_base[MTK_APDMA_CHANNELS];
> > > +       spinlock_t lock; /* dma dev lock */
> > > +       struct tasklet_struct task;
> > > +       struct list_head pending;
> > > +       struct clk *clk;
> > > +       unsigned int dma_requests;
> > > +       bool support_33bits;
> > > +       unsigned int dma_irq[MTK_APDMA_CHANNELS];
> > > +       struct mtk_chan *ch[MTK_APDMA_CHANNELS];
> > > +};
> > > +
> > > +struct mtk_chan {
> > > +       struct virt_dma_chan vc;
> > > +       struct list_head node;
> > > +       struct dma_slave_config cfg;
> > > +       void __iomem *base;
> > > +       struct mtk_dma_desc *desc;
> > > +
> > > +       bool stop;
> > > +       bool requested;
> > > +
> > > +       unsigned int dma_sig;
> >
> > the member can be removed as no real user would refer to it
> >
>
> Ok, i will remove it at next patch
>
> > > +       unsigned int dma_ch;
> >
> > a chan_id is already included in struct dma_chan, we can reuse it
> >
>
> chan_id is start from 0. but in this driver, dma info is stored to list.
> if use port1, in filter_fn function, will set dma_ch to 2, 3(tx, rx). So
> can't using chan_id
>

if you use of_dma_xlate_by_chan_id in of_dma_controller_register, the
client device still can get the right channel with the appropriate
chan_id expressed in dmas property in dts.

> > > +       unsigned int sgidx;
> >

[ ... ]

> ok, i will modify it
> > > +               wpt = mtk_dma_chan_read(c, VFF_WPT);
> > > +               wrap = wpt & MTK_DMA_RING_WRAP ? 0U : MTK_DMA_RING_WRAP;
> > > +
> > > +               if ((wpt & (len - 1U)) + send < len)
> > > +                       mtk_dma_chan_write(c, VFF_WPT, wpt + send);
> > > +               else
> > > +                       mtk_dma_chan_write(c, VFF_WPT,
> > > +                                          ((wpt + send) & (len - 1U))
> > > +                                          | wrap);
> > > +
> > > +               c->remain_size -= send;
> >
> > I'm curious why you don't need to set up the hardware from the
> > descriptor information
> >
>
> mtk_dma_chan_write is update the hardware. remain_size is length of TX
> data.

I thought it is not enough to be a full dmaengine. if the driver only
supports single continuous data moving for device_prep_slave_sg
callback.

We could try to turn each sg item information such as source or
destination address and data length to be one part of the descriptor.
When a descriptor is being issued, and then program VFF_ADDR/LEN and
issue the data move by other VFF_* registers rather than assuming the
data portion is always the fixed as the user assignment at
mtk_dma_slave_config.
