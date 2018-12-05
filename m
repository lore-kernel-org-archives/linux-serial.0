From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/4] add uart DMA function
Date: Wed, 5 Dec 2018 22:01:33 +0530
Message-ID: <20181205163133.GQ2847@vkoul-mobl>
References: <1543999380-7946-1-git-send-email-long.cheng@mediatek.com>
 <20181205100306.GA12106@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205100306.GA12106@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Long Cheng <long.cheng@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On 05-12-18, 11:03, Greg Kroah-Hartman wrote:
> On Wed, Dec 05, 2018 at 04:42:56PM +0800, Long Cheng wrote:
> > In Mediatek SOCs, the uart can support DMA function.
> > Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.
> > 
> > This series contains document bindings, Kconfig to control the function enable or not,
> > device tree including interrupt and dma device node, the code of UART DM
> 
> I've queued up patches 1 and 3 from this series in my tty tree, thanks.

Do you mind not taking patch 2, I would like that to go thru dmaengine
tree

Thanks
-- 
~Vinod
