From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2] tty: serial: fsl_lpuart: fix del_timer_sync() vs timer
 routine deadlock
Date: Tue, 06 Dec 2016 17:44:30 -0800
Message-ID: <fa720115c7aa1e18c4d6d16d4418111e@agner.ch>
References: <1480866568-15725-1-git-send-email-nikita.yoush@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480866568-15725-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Wei Yongjun <weiyongjun1@huawei.com>, Aaron Brice <aaron.brice@datasoft.com>, Nicolae Rosia <nicolae_rosia@mentor.com>, linux-serial@vger.kernel.org, Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2016-12-04 07:49, Nikita Yushchenko wrote:
> Problem found via lockdep:
> 
> - lpuart_set_termios() calls del_timer_sync(&sport->lpuart_timer) while
>   holding sport->port.lock
> 
> - sport->lpuart_timer routine is lpuart_timer_func() that calls
>   lpuart_copy_rx_to_tty() that acquires same lock.
> 
> To fix, move Rx DMA stopping out of lock, as it already is in other places
> in the same file.
> 
> While at it, also make Rx DMA start/stop code to look the same is in
> other places in the same file.

Looks good here:

Tested-by: Stefan Agner <stefan@agner.ch>

> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
> Changes from v1:
> - keep reallocation of Rx DMA buffer conditional on 'old'
> - do not set sport->lpuart_dma_rx_use to true when it is already true
> 
>  drivers/tty/serial/fsl_lpuart.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index a1c6519837a4..f02934ffb329 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1407,6 +1407,18 @@ lpuart_set_termios(struct uart_port *port,
> struct ktermios *termios,
>  	/* ask the core to calculate the divisor */
>  	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
>  
> +	/*
> +	 * Need to update the Ring buffer length according to the selected
> +	 * baud rate and restart Rx DMA path.
> +	 *
> +	 * Since timer function acqures sport->port.lock, need to stop before
> +	 * acquring same lock because otherwise del_timer_sync() can deadlock.
> +	 */
> +	if (old && sport->lpuart_dma_rx_use) {
> +		del_timer_sync(&sport->lpuart_timer);
> +		lpuart_dma_rx_free(&sport->port);
> +	}
> +
>  	spin_lock_irqsave(&sport->port.lock, flags);
>  
>  	sport->port.read_status_mask = 0;
> @@ -1456,22 +1468,11 @@ lpuart_set_termios(struct uart_port *port,
> struct ktermios *termios,
>  	/* restore control register */
>  	writeb(old_cr2, sport->port.membase + UARTCR2);
>  
> -	/*
> -	 * If new baud rate is set, we will also need to update the Ring buffer
> -	 * length according to the selected baud rate and restart Rx DMA path.
> -	 */
> -	if (old) {
> -		if (sport->lpuart_dma_rx_use) {
> -			del_timer_sync(&sport->lpuart_timer);
> -			lpuart_dma_rx_free(&sport->port);
> -		}
> -
> -		if (sport->dma_rx_chan && !lpuart_start_rx_dma(sport)) {
> -			sport->lpuart_dma_rx_use = true;
> +	if (old && sport->lpuart_dma_rx_use) {
> +		if (!lpuart_start_rx_dma(sport))
>  			rx_dma_timer_init(sport);
> -		} else {
> +		else
>  			sport->lpuart_dma_rx_use = false;
> -		}
>  	}
>  
>  	spin_unlock_irqrestore(&sport->port.lock, flags);
> @@ -2131,12 +2132,10 @@ static int lpuart_resume(struct device *dev)
>  
>  	if (sport->lpuart_dma_rx_use) {
>  		if (sport->port.irq_wake) {
> -			if (!lpuart_start_rx_dma(sport)) {
> -				sport->lpuart_dma_rx_use = true;
> +			if (!lpuart_start_rx_dma(sport))
>  				rx_dma_timer_init(sport);
> -			} else {
> +			else
>  				sport->lpuart_dma_rx_use = false;
> -			}
>  		}
>  	}
