From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 2/2] serial: samsung: Add missing checks for
 dma_map_single failure
Date: Thu, 23 Mar 2017 22:04:13 +0200
Message-ID: <20170323200413.3tfu6f73jcu5gzy3@kozik-lap>
References: <1490270519-4046-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170323120213eucas1p2f288fa4f85c8d0db098d3ca2bf378b34@eucas1p2.samsung.com>
 <1490270519-4046-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1490270519-4046-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Inki Dae <inki.dae@samsung.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 23, 2017 at 01:01:53PM +0100, Marek Szyprowski wrote:
> This patch adds missing checks for dma_map_single() failure and proper error
> reporting. While touching this part of the code, it also removes unnecessary
> spinlock calls around dma_map_single() for TX buffer. This finally solves all
> the issues reported by DMA API debug framework.
> 
> Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Fixes: 62c37eedb74c8 ("serial: samsung: add dma reqest/release functions")
> CC: stable@vger.kernel.org # v4.10+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> This issue was there since adding DMA support, but this patch applies cleanly
> only to v4.10+ kernels due to other changes in the surrounding code.
> 
> v2:
> - fixed commit id in 'fixes' tag, added 'reviewed-by' tag
> ---
>  drivers/tty/serial/samsung.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 9f3759bdb44f..8aca18c4cdea 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -859,7 +859,7 @@ static void s3c24xx_serial_break_ctl(struct uart_port *port, int break_state)
>  static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>  {
>  	struct s3c24xx_uart_dma	*dma = p->dma;
> -	unsigned long flags;
> +	int ret;
>  
>  	/* Default slave configuration parameters */
>  	dma->rx_conf.direction		= DMA_DEV_TO_MEM;
> @@ -884,8 +884,8 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>  
>  	dma->tx_chan = dma_request_chan(p->port.dev, "tx");
>  	if (IS_ERR(dma->tx_chan)) {
> -		dma_release_channel(dma->rx_chan);
> -		return PTR_ERR(dma->tx_chan);
> +		ret = PTR_ERR(dma->tx_chan);
> +		goto err_release_rx;
>  	}
>  
>  	dmaengine_slave_config(dma->tx_chan, &dma->tx_conf);
> @@ -894,25 +894,38 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>  	dma->rx_size = PAGE_SIZE;
>  
>  	dma->rx_buf = kmalloc(dma->rx_size, GFP_KERNEL);
> -
>  	if (!dma->rx_buf) {
> -		dma_release_channel(dma->rx_chan);
> -		dma_release_channel(dma->tx_chan);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_release_tx;
>  	}
>  
>  	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
>  				dma->rx_size, DMA_FROM_DEVICE);
> -
> -	spin_lock_irqsave(&p->port.lock, flags);

Error paths look fine but how about splitting spinlock removal out of
this patch?  Logically they are two different changes and unrelated code
should not be backported.

Best regards,
Krzysztof
