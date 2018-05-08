From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Date: Tue, 8 May 2018 08:43:51 +0200
Message-ID: <20180508064351.ioczgw2v4jtryr3x@pengutronix.de>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
 <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, May 07, 2018 at 11:36:10PM +0200, Sebastian Reichel wrote:
> This properly unmaps DMA SG on device shutdown.
> 
> Reported-by: Nandor Han <nandor.han@ge.com>
> Suggested-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/tty/serial/imx.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 3ca767b1162a..6c53e74244ec 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_port *port)
>  	u32 ucr1, ucr2;
>  
>  	if (sport->dma_is_enabled) {
> -		sport->dma_is_rxing = 0;
> -		sport->dma_is_txing = 0;
>  		dmaengine_terminate_sync(sport->dma_chan_tx);
> +		if (sport->dma_is_txing) {
> +			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
> +				     sport->dma_tx_nents, DMA_TO_DEVICE);
> +			sport->dma_is_txing = 0;
> +		}

did you find this because the kernel crashed or consumed more and more
memory, or is this "only" a finding of reading the source code? If the
former it would be great to point out in the commit log, if the latter,
I wonder if this is a real problem that warrants a stable backport.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
