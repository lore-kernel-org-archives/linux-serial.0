From: Mario Forner <m.forner@be4energy.com>
Subject: Re: [PATCH] dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
Date: Fri, 30 Nov 2018 11:07:39 +0100
Message-ID: <3059696.Xnxl6OxYbg@linux-7rm0>
References: <20181127160635.11836-1-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181127160635.11836-1-richard.genoud@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vkoul@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Am Dienstag, 27. November 2018, 17:06:34 CET schrieb Richard Genoud:
> The leak was found when opening/closing a serial port a great number of
> time, increasing kmalloc-32 in slabinfo.
> 
> Each time the port was opened, dma_request_slave_channel() was called.
> Then, in at_dma_xlate(), atslave was allocated with devm_kzalloc() and
> never freed. (Well, it was free at module unload, but that's not what we
> want).
> So, here, kzalloc is more suited for the job since it has to be freed in
> atc_free_chan_resources().
> 
> Cc: stable@vger.kernel.org
> Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
> Reported-by: Mario Forner <m.forner@be4energy.com>
> Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

After testing I installed an updated kernel on a production machine, which
worked fine. The memory leak has been repaired successfully.  There have been
no adverse side-effects.

Thank you for providing the patch.

> ---
>  drivers/dma/at_hdmac.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 7cbac6e8c113..1b7f0ca0d5cd 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -1641,6 +1641,12 @@ static void atc_free_chan_resources(struct dma_chan *chan)
>  	atchan->descs_allocated = 0;
>  	atchan->status = 0;
>  
> +	/*
> +	 * Free atslave allocated in at_dma_xlate()
> +	 */
> +	kfree(chan->private);
> +	chan->private = NULL;
> +
>  	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
>  }
>  
> @@ -1675,7 +1681,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	atslave = devm_kzalloc(&dmac_pdev->dev, sizeof(*atslave), GFP_KERNEL);
> +	atslave = kzalloc(sizeof(*atslave), GFP_KERNEL);
>  	if (!atslave)
>  		return NULL;
>  
> 
