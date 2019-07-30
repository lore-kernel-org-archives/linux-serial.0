From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 06/24] tty: serial: fsl_lpuart: Drop unnecessary
 sg_set_buf() call
Date: Tue, 30 Jul 2019 17:51:12 +0200
Message-ID: <20190730155112.GA11837@kroah.com>
References: <20190729195226.8862-1-andrew.smirnov@gmail.com>
 <20190729195226.8862-7-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190729195226.8862-7-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Chris Healy <cphealy@gmail.com>, Cory Tusar <cory.tusar@zii.aero>, Lucas Stach <l.stach@pengutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 29, 2019 at 12:52:08PM -0700, Andrey Smirnov wrote:
> Sg_init_one() will already call sg_set_buf(), so another explicit call
> right after it is unnecessary. Drop it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-imx@nxp.com
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/tty/serial/fsl_lpuart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 1b3f2a87e558..b600f591c8c2 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1144,7 +1144,6 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  		return -ENOMEM;
>  
>  	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
> -	sg_set_buf(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
>  	nent = dma_map_sg(sport->port.dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
>  
>  	if (!nent) {

This patch doesn't apply, is it already in the tree from someone else?

thanks,

greg k-h
