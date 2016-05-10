From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v1 2/2] dmaengine: rename cmd_pause to cmd_suspend
Date: Tue, 10 May 2016 21:29:28 +0530
Message-ID: <20160510155928.GH2274@localhost>
References: <1462390180-82368-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1462390180-82368-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462390180-82368-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, May 04, 2016 at 10:29:40PM +0300, Andy Shevchenko wrote:
> Rename cmd_pause to cmd_suspend to be clear that latter capability reflects
> pause AND resume.

How does cmd_suspend be any clearer to reflect that channel is paused and
not. One can argue this might be related to power management suspend ...

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/dmaengine.c               | 4 ++--
>  drivers/tty/serial/8250/8250_dma.c    | 2 +-
>  include/linux/dmaengine.h             | 4 ++--
>  sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 59eb4fa..e9917a4 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -503,9 +503,9 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  
>  	/*
>  	 * Some devices implement only pause (e.g. to get residuum) but no
> -	 * resume. However cmd_pause is advertised as pause AND resume.
> +	 * resume. However cmd_suspend is advertised as pause AND resume.
>  	 */
> -	caps->cmd_pause = !!(device->device_pause && device->device_resume);
> +	caps->cmd_suspend = !!(device->device_pause && device->device_resume);
>  	caps->cmd_terminate = !!device->device_terminate_all;
>  
>  	return 0;
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 8ccbf53..2db57b0 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -180,7 +180,7 @@ int serial8250_request_dma(struct uart_8250_port *p)
>  	ret = dma_get_slave_caps(dma->rxchan, &caps);
>  	if (ret)
>  		goto release_rx;
> -	if (!caps.cmd_pause || !caps.cmd_terminate ||
> +	if (!caps.cmd_suspend || !caps.cmd_terminate ||
>  	    caps.residue_granularity == DMA_RESIDUE_GRANULARITY_DESCRIPTOR) {
>  		ret = -EINVAL;
>  		goto release_rx;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 30de019..af9c97c 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -402,7 +402,7 @@ enum dma_residue_granularity {
>   * 	type of direction, the dma controller should fill (1 << <TYPE>) and same
>   * 	should be checked by controller as well
>   * @max_burst: max burst capability per-transfer
> - * @cmd_pause: true, if pause and thereby resume is supported
> + * @cmd_suspend: true, if pause and thereby resume is supported
>   * @cmd_terminate: true, if terminate cmd is supported
>   * @residue_granularity: granularity of the reported transfer residue
>   * @descriptor_reuse: if a descriptor can be reused by client and
> @@ -413,7 +413,7 @@ struct dma_slave_caps {
>  	u32 dst_addr_widths;
>  	u32 directions;
>  	u32 max_burst;
> -	bool cmd_pause;
> +	bool cmd_suspend;
>  	bool cmd_terminate;
>  	enum dma_residue_granularity residue_granularity;
>  	bool descriptor_reuse;
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 6cef397..73fc20e 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -151,7 +151,7 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
>  
>  	ret = dma_get_slave_caps(chan, &dma_caps);
>  	if (ret == 0) {
> -		if (dma_caps.cmd_pause)
> +		if (dma_caps.cmd_suspend)
>  			hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
>  		if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
>  			hw.info |= SNDRV_PCM_INFO_BATCH;
> -- 
> 2.8.1
> 

-- 
~Vinod
