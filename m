From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v1 1/2] dmaengine: slave means at least one of DMA_SLAVE,
 DMA_CYCLIC
Date: Tue, 10 May 2016 21:26:37 +0530
Message-ID: <20160510155637.GG2274@localhost>
References: <1462390180-82368-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1462390180-82368-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462390180-82368-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, May 04, 2016 at 10:29:39PM +0300, Andy Shevchenko wrote:
> When check for capabilities recognize slave support by eother DMA_SLAVE or
							^^^^^^^
typo

> DMA_CYCLIC bit set. If we don't do that the user can't get a normally worked
> DMA support for engines that doesn't have one of the mentioned bits set.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dmaengine.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 5ff79a0..59eb4fa 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -482,8 +482,8 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	device = chan->device;
>  
>  	/* check if the channel supports slave transactions */
> -	if ((!test_bit(DMA_SLAVE, device->cap_mask.bits)) ||
> -			(!test_bit(DMA_CYCLIC, device->cap_mask.bits)))
> +	if (!(test_bit(DMA_SLAVE, device->cap_mask.bits) ||
> +	      test_bit(DMA_CYCLIC, device->cap_mask.bits)))
>  		return -ENXIO;
>  
>  	/*
> -- 
> 2.8.1
> 

-- 
~Vinod
