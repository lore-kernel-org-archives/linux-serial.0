From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/2] sh: extend .device_terminate_all() to record partial transfer
Date: Fri, 19 Feb 2010 03:08:07 +0900
Message-ID: <20100218180807.GA12264@linux-sh.org>
References: <Pine.LNX.4.64.1002181624190.4373@axis700.grange> <Pine.LNX.4.64.1002181722070.4373@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1002181722070.4373@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 18, 2010 at 05:30:02PM +0100, Guennadi Liakhovetski wrote:
> This patch extends the .device_terminate_all() method of the shdma driver 
> to return number of bytes transfered in the current descriptor.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> diff --git a/arch/sh/include/asm/dmaengine.h b/arch/sh/include/asm/dmaengine.h
> index 9586e4a..bf2f30c 100644
> --- a/arch/sh/include/asm/dmaengine.h
> +++ b/arch/sh/include/asm/dmaengine.h
> @@ -70,4 +73,21 @@ struct sh_dmae_slave {
>  	struct sh_dmae_slave_config	*config;  /* Set by the driver */
>  };
>  
> +struct sh_dmae_regs {
> +	u32 sar; /* SAR / source address */
> +	u32 dar; /* DAR / destination address */
> +	u32 tcr; /* TCR / transfer count */
> +};
> +
> +struct sh_desc {
> +	struct sh_dmae_regs hw;
> +	struct list_head node;
> +	struct dma_async_tx_descriptor async_tx;
> +	enum dma_data_direction direction;
> +	dma_cookie_t cookie;
> +	size_t partial;
> +	int chunks;
> +	int mark;
> +};
> +
>  #endif

If we're going to expose this to drivers, can we please come up with a
better name than sh_desc? Even something as uninspired as sh_dmae_desc
would be better. This can be done as a follow-up patch though, since this
naming existed before these changes.
