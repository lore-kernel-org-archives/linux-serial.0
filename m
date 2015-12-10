From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH LINUX v4 06/13] tty: xuartps: Move request_irq to after
 setting up the HW
Date: Thu, 10 Dec 2015 13:41:06 -0800
Message-ID: <5669F172.6020503@hurleysoftware.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
 <1449376769-13369-7-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449376769-13369-7-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>
List-Id: linux-serial@vger.kernel.org

On 12/05/2015 08:39 PM, Soren Brinkmann wrote:
> Request_irq() should be _after_ h/w programming, otherwise an
> interrupt could be triggered and in-progress before the h/w has been
> setup.

Slight misunderstanding. My fault; I should have been more explicit.

1. Any setup necessary for the isr not to be confused and misdirect spurious
   interrupts (or hang) should be before installing the isr with request_irq()
   None of this code should trigger an interrupt.
2. Clear pending interrupts
3. Install the isr with request_irq()
4. Enable interrupts

For extra safety, first disable interrupts before starting h/w programming.

I would do the v5 series in the same order as the v3 series only up to
what I reviewed. Then do another series with the remainder plus new changes, ok?

Regards,
Peter Hurley

> Reported-by: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> v4:
>  - this patch has been added. Thanks to Peter for pointing it out and providing
>    commit message
> ---
>  drivers/tty/serial/xilinx_uartps.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 6ffd3bbe3e18..1e9053656610 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -759,12 +759,7 @@ static void cdns_uart_set_termios(struct uart_port *port,
>  static int cdns_uart_startup(struct uart_port *port)
>  {
>  	unsigned long flags;
> -	unsigned int retval = 0, status = 0;
> -
> -	retval = request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME,
> -								(void *)port);
> -	if (retval)
> -		return retval;
> +	unsigned int status = 0;
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  
> @@ -818,7 +813,7 @@ static int cdns_uart_startup(struct uart_port *port)
>  
>  	spin_unlock_irqrestore(&port->lock, flags);
>  
> -	return retval;
> +	return request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME, port);
>  }
>  
>  /**
> 
