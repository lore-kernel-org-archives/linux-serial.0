From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 4/4] dmaengine: imx-sdma: drop redundant variable
Date: Mon, 16 Sep 2019 16:30:25 +0200
Message-ID: <fcc6e54f56089d2204ca9aff79ac769a62b3adcb.camel@pengutronix.de>
References: <20190911144943.21554-1-philipp.puschmann@emlix.com>
         <20190911144943.21554-5-philipp.puschmann@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190911144943.21554-5-philipp.puschmann@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Puschmann <philipp.puschmann@emlix.com>, linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, jslaby@suse.com, vkoul@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, gregkh@linuxfoundation.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mi, 2019-09-11 at 16:49 +0200, Philipp Puschmann wrote:
> In sdma_prep_dma_cyclic buf is redundant. Drop it.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 6a5a84504858..5b6beeee9f0e 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1544,7 +1544,7 @@ static struct dma_async_tx_descriptor
> *sdma_prep_dma_cyclic(
>  	struct sdma_engine *sdma = sdmac->sdma;
>  	int num_periods = buf_len / period_len;
>  	int channel = sdmac->channel;
> -	int i = 0, buf = 0;
> +	int i;
>  	struct sdma_desc *desc;
>  
>  	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
> @@ -1565,7 +1565,7 @@ static struct dma_async_tx_descriptor
> *sdma_prep_dma_cyclic(
>  		goto err_bd_out;
>  	}
>  
> -	while (buf < buf_len) {
> +	for (i = 0; i < num_periods; i++) {
>  		struct sdma_buffer_descriptor *bd = &desc->bd[i];
>  		int param;
>  
> @@ -1592,9 +1592,6 @@ static struct dma_async_tx_descriptor
> *sdma_prep_dma_cyclic(
>  		bd->mode.status = param;
>  
>  		dma_addr += period_len;
> -		buf += period_len;
> -
> -		i++;
>  	}
>  
>  	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
