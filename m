From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v1 06/12] serial: 8250_dma: stop ongoing RX DMA on
 exception
Date: Thu, 7 Apr 2016 16:54:13 -0700
Message-ID: <5706F325.6090001@hurleysoftware.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1460061433-63750-7-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460061433-63750-7-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04/07/2016 01:37 PM, Andy Shevchenko wrote:
> If we get an exeption interrupt. i.e. UART_IIR_RLSI, stop any ongoing RX DMA
> transfer otherwise it might generates more spurious interrupts and make port
> unavailable anymore.

Then how to know which rx byte the error is for if dma continues anyway?
What if there are multiple error bytes?


> As has been seen on Intel Broxton system:

This system shouldn't be setup for UART DMA imo.


> ...
> [  168.526281] serial8250: too much work for irq5
> [  168.535908] serial8250: too much work for irq5
> [  173.449464] serial8250_interrupt: 4439 callbacks suppressed
> [  173.455694] serial8250: too much work for irq5
> ...
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 9d80bb1..b134bec 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -110,6 +110,16 @@ err:
>  	return ret;
>  }
>  
> +static void __dma_rx_stop(struct uart_8250_port *p, struct uart_8250_dma *dma)
> +{
> +	if (!dma->rx_running)
> +		return;
> +
> +	dmaengine_pause(dma->rxchan);
> +	__dma_rx_complete(p);
> +	dmaengine_terminate_async(dma->rxchan);
> +}
> +
>  int serial8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
>  {
>  	struct uart_8250_dma		*dma = p->dma;
> @@ -118,17 +128,14 @@ int serial8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
>  	switch (iir & 0x3f) {
>  	case UART_IIR_RLSI:
>  		/* 8250_core handles errors and break interrupts */
> +		__dma_rx_stop(p, dma);
>  		return -EIO;
>  	case UART_IIR_RX_TIMEOUT:
>  		/*
>  		 * If RCVR FIFO trigger level was not reached, complete the
>  		 * transfer and let 8250_core copy the remaining data.
>  		 */
> -		if (dma->rx_running) {
> -			dmaengine_pause(dma->rxchan);
> -			__dma_rx_complete(p);
> -			dmaengine_terminate_async(dma->rxchan);
> -		}
> +		__dma_rx_stop(p, dma);
>  		return -ETIMEDOUT;
>  	default:
>  		break;
> 
