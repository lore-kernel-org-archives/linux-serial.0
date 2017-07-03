From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 7/7] serial: imx: Fix imx_shutdown procedure
Date: Mon, 3 Jul 2017 09:08:21 +0200
Message-ID: <20170703070821.jnyyylwszz2bqprh@pengutronix.de>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-8-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170630120446.13994-8-romain.perier@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Romain Perier <romain.perier@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nandor Han <nandor.han@ge.com>, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 30, 2017 at 02:04:46PM +0200, Romain Perier wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> In some cases, It looks that interrupts can happen after the dma was
s/It/it/

> disabled and port was not yet shutdown. This will result in interrupts
> handled by imx_rxint.
> 
> This commits updates the shutdown function to ensure that underlying
> components are disabled in the right order. This disables RX and TX
> blocks, then it disabled interrupts. In case DMA is enabled, it disables
> DMA and free corresponding resources. It disables UART port and stop
> clocks.
> 
> Signed-off-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Romain Perier <romain.perier@collabora.com>
> ---
>  drivers/tty/serial/imx.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index d5b6e09..7dc6f0c 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1404,44 +1404,44 @@ static void imx_shutdown(struct uart_port *port)
>  	unsigned long temp;
>  	unsigned long flags;
>  
> -	if (sport->dma_is_enabled) {
> -		sport->dma_is_rxing = 0;
> -		sport->dma_is_txing = 0;
> -		dmaengine_terminate_sync(sport->dma_chan_tx);
> -		dmaengine_terminate_sync(sport->dma_chan_rx);
> -
> +	if (!sport->port.suspended) {
>  		spin_lock_irqsave(&sport->port.lock, flags);
>  		imx_stop_tx(port);
>  		imx_stop_rx(port);
> -		imx_disable_dma(sport);
>  		spin_unlock_irqrestore(&sport->port.lock, flags);
> -		imx_uart_dma_exit(sport);
>  	}
>  
> -	mctrl_gpio_disable_ms(sport->gpios);
> +	if (sport->dma_is_inited) {
> +		if (sport->dma_is_enabled) {
> +			spin_lock_irqsave(&sport->port.lock, flags);
> +			imx_disable_dma(sport);
> +			spin_unlock_irqrestore(&sport->port.lock, flags);
> +		}
> +		imx_uart_dma_exit(sport);
> +	}
>  
>  	spin_lock_irqsave(&sport->port.lock, flags);
>  	temp = readl(sport->port.membase + UCR2);
> -	temp &= ~(UCR2_TXEN);
> +	temp &= ~(UCR2_TXEN | UCR2_RXEN);
>  	writel(temp, sport->port.membase + UCR2);
> +	temp = readl(sport->port.membase + UCR4);
> +	temp &= ~UCR4_OREN;
> +	writel(temp, sport->port.membase + UCR4);
>  	spin_unlock_irqrestore(&sport->port.lock, flags);

The function already had two critical blocks protected by
spin_lock_irqsave on sport->port.lock. With your patch there are three.
Is it possible to grab the lock only once?

>  
> -	/*
> -	 * Stop our timer.
> -	 */
> -	del_timer_sync(&sport->timer);
> +	mctrl_gpio_disable_ms(sport->gpios);
>  
> -	/*
> -	 * Disable all interrupts, port and break condition.
> -	 */
> +	/* Stop our timer. */

Updating the comment style in such a commit makes the diff unnecessarily
hard to read.

> +	del_timer_sync(&sport->timer);
>  
> +	/* Disable port. */
>  	spin_lock_irqsave(&sport->port.lock, flags);
>  	temp = readl(sport->port.membase + UCR1);
> -	temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN);
> -
> +	temp &= ~UCR1_UARTEN;
>  	writel(temp, sport->port.membase + UCR1);
>  	spin_unlock_irqrestore(&sport->port.lock, flags);
>  
> +	/* Disable clocks. */
>  	clk_disable_unprepare(sport->clk_per);
>  	clk_disable_unprepare(sport->clk_ipg);
>  }
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
