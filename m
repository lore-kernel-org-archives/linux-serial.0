From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] serial: atmel_serial: remove atmel open/close hooks
Date: Mon, 19 Nov 2012 09:54:27 +0100
Message-ID: <50A9F3C3.2020908@atmel.com>
References: <1353110956-17541-1-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:46002 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab2KSIyb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Nov 2012 03:54:31 -0500
In-Reply-To: <1353110956-17541-1-git-send-email-manabian@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>, linux@arm.linux.org.uk
Cc: gregkh@linuxfoundation.org, plagnioj@jcrosoft.com, avictor.za@gmail.com, alan@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On 11/17/2012 01:09 AM, Joachim Eastwood :
> After serial_at91.h was removed the atmel_open/close_hook
> code is now useless.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks Joachim.

> ---
> Hi,
> 
> This patch depends on [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
> patch from Russell King.
> 
> Patch based on current linux-next with "[RFC 3/3] ARM/AVR32: get rid of serial_at91.h"
> patch on top. There is a small conflict with Russell's patch
> in next now due to another header change.
> 
> If there is another tree this patch should be based on please
> let me know.
> 
> regards
> Joachim Eastwood
> 
>  drivers/tty/serial/atmel_serial.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 76e4c05..5c2337d 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -113,9 +113,6 @@ static void atmel_stop_rx(struct uart_port *port);
>  #define UART_PUT_TCR(port,v)	__raw_writel(v, (port)->membase + ATMEL_PDC_TCR)
>  #define UART_GET_TCR(port)	__raw_readl((port)->membase + ATMEL_PDC_TCR)
>  
> -static int (*atmel_open_hook)(struct uart_port *);
> -static void (*atmel_close_hook)(struct uart_port *);
> -
>  struct atmel_dma_buffer {
>  	unsigned char	*buf;
>  	dma_addr_t	dma_addr;
> @@ -976,18 +973,6 @@ static int atmel_startup(struct uart_port *port)
>  		pdc->ofs = 0;
>  	}
>  
> -	/*
> -	 * If there is a specific "open" function (to register
> -	 * control line interrupts)
> -	 */
> -	if (atmel_open_hook) {
> -		retval = atmel_open_hook(port);
> -		if (retval) {
> -			free_irq(port->irq, port);
> -			return retval;
> -		}
> -	}
> -
>  	/* Save current CSR for comparison in atmel_tasklet_func() */
>  	atmel_port->irq_status_prev = UART_GET_CSR(port);
>  	atmel_port->irq_status = atmel_port->irq_status_prev;
> @@ -1062,13 +1047,6 @@ static void atmel_shutdown(struct uart_port *port)
>  	 * Free the interrupt
>  	 */
>  	free_irq(port->irq, port);
> -
> -	/*
> -	 * If there is a specific "close" function (to unregister
> -	 * control line interrupts)
> -	 */
> -	if (atmel_close_hook)
> -		atmel_close_hook(port);
>  }
>  
>  /*
> 


-- 
Nicolas Ferre
