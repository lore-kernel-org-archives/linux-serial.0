From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v10 1/3] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Date: Tue, 19 Feb 2019 17:44:20 +0530
Message-ID: <20190219121420.GZ21884@vkoul-mobl>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
 <20190204072154.GJ4296@vkoul-mobl>
 <1550112296.7678.5.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550112296.7678.5.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Long Cheng <long.cheng@mediatek.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>, Zhenbao Liu <zhenbao.liu@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On 14-02-19, 10:44, Long Cheng wrote:
> On Mon, 2019-02-04 at 12:51 +0530, Vinod Koul wrote:

> > > +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> > > +{
> > > +	/* just for check caps pass */
> > > +	return 0;
> > > +}
> > 
> > please remove, this is not a mandatory fn
> 
> Can't remove it. Before the mail, i had explained it. in 8250 uart
> framework, will check the function..

I think you should fix the 8250 uart to handle driver not having a
pause. Keeping a dummy pause is just wrong and sets wrong expectations
for uart..

-- 
~Vinod
