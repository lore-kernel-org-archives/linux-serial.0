From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 4/4] tty: serial: 8250: omap: consume spurious interrupts
Date: Fri, 22 Jan 2016 08:48:55 -0800
Message-ID: <56A25D77.7090000@hurleysoftware.com>
References: <87si1pq577.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87si1pq577.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>, gregkh@linuxfoundation.org, tony@atomide.com, nsekhar@ti.com
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, bigeasy@linutronix.de, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi John,

On 01/22/2016 02:27 AM, John Ogness wrote:
> It has been seen that spurious interrupts are generated when the
> DMA engine is in use. By disabling timeout interrupts (~IER_RDI)
> this phenomenon goes away, but this driver relies on the timeout
> interrupts, so we just consume the spurious interrupts.
> 
> Since we are consuming spurious interrupts, the irq cannot be
> shared with other drivers. (It is never really shared anyway.)

Does this fix the spurious irqs referred to by Sekhar in
this email chain  https://lkml.org/lkml/2015/12/3/442 ?



> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  patch against next-20160122
> 
>  drivers/tty/serial/8250/8250_omap.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index ef7a60b..004b85a 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -630,7 +630,7 @@ static int omap_8250_startup(struct uart_port *port)
>  	}
>  #endif
>  
> -	ret = request_irq(port->irq, omap8250_irq, IRQF_SHARED,
> +	ret = request_irq(port->irq, omap8250_irq, 0,
>  			  dev_name(port->dev), port);
>  	if (ret < 0)
>  		goto err;
> @@ -1112,8 +1112,14 @@ static int omap_8250_dma_handle_irq(struct uart_port *port, unsigned int iir)
>  	unsigned char status;
>  	int dma_err;
>  
> +	/*
> +	 * It has been seen that spurious interrupts are generated when the
> +	 * DMA engine is in use. By disabling timeout interrupts (~IER_RDI)
> +	 * this phenomenon goes away, but this driver relies on the timeout
> +	 * interrupts, so we just consume the spurious interrupts.
> +	 */
>  	if (iir & UART_IIR_NO_INT)
> -		return 0;
> +		return 1;
>  
>  	spin_lock(&port->lock);
>  
> 
