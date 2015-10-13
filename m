From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3] Revert "serial: 8250_dma: don't bother DMA with
 small transfers"
Date: Tue, 13 Oct 2015 17:10:48 +0300
Message-ID: <1444745448.8361.618.camel@linux.intel.com>
References: <1444403696-9223-1-git-send-email-frederic.danis@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444403696-9223-1-git-send-email-frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2015-10-09 at 17:14 +0200, Frederic Danis wrote:
> This reverts commit 9119fba0cfeda6d415c9f068df66838a104b87cb.
> 
> This commit prevents from sending "big" file using Bluetooth.
> When sending a lot of data quickly through the Bluetooth interface, 
> and
> after a variable amount of data sent, transfer fails with error:
>     kernel: [  415.247453] Bluetooth: hci0 hardware error 0x00
> 
> Found on T100TA.
> 
> After reverting this commit, send works fine for any file size.
> 
> Signed-off-by: Frederic Danis <frederic.danis-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Fixes: 9119fba0cfed (serial: 8250_dma: don't bother DMA with small
> transfers)
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Acked-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> ---
> v3: Add Fixes and Cc tags
> v2: Re-send to correct people
> 
>  drivers/tty/serial/8250/8250_dma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c 
> b/drivers/tty/serial/8250/8250_dma.c
> index b503071..78259d3 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -77,10 +77,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
>  		return 0;
>  
>  	dma->tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, 
> UART_XMIT_SIZE);
> -	if (dma->tx_size < p->port.fifosize) {
> -		ret = -EINVAL;
> -		goto err;
> -	}
>  
>  	desc = dmaengine_prep_slave_single(dma->txchan,
>  					   dma->tx_addr + xmit
> ->tail,

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
