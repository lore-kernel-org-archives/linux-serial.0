From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: fix del_timer_sync() vs timer
 routine deadlock
Date: Fri, 02 Dec 2016 10:05:36 -0800
Message-ID: <77e2726b8b84c55f9109ff18dfcfbbdf@agner.ch>
References: <1480674490-24718-1-git-send-email-nikita.yoush@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480674490-24718-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, Wei Yongjun <weiyongjun1@huawei.com>, Aaron Brice <aaron.brice@datasoft.com>, Nicolae Rosia <nicolae_rosia@mentor.com>, linux-serial@vger.kernel.org, Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2016-12-02 02:28, Nikita Yushchenko wrote:
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

Yeah I saw that too, never really came around to look closer into it.

Thanks for looking into it.

You removed the check whether there was an old configuration, I think
the idea of that was that we only resize DMA if it was configured
differently before... Not sure how startup/set_termios calls are
ordered. I guess in practice that shouldn't really make a difference
since lpuart_dma_rx_use can't be true until after startup?

One nit below.

--
Stefan

> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index a1c6519837a4..81100c40f33b 100644
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
> +	if (sport->lpuart_dma_rx_use) {
> +		del_timer_sync(&sport->lpuart_timer);
> +		lpuart_dma_rx_free(&sport->port);
> +	}
> +
>  	spin_lock_irqsave(&sport->port.lock, flags);
>  
>  	sport->port.read_status_mask = 0;
> @@ -1456,17 +1468,8 @@ lpuart_set_termios(struct uart_port *port,
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
> +	if (sport->lpuart_dma_rx_use) {
> +		if (!lpuart_start_rx_dma(sport)) {
>  			sport->lpuart_dma_rx_use = true;

No need to set to true here, it is guaranteed to be true at this point.

>  			rx_dma_timer_init(sport);
>  		} else {
