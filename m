From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: exar: Fix stuck MSIs
Date: Mon, 24 Apr 2017 11:59:39 +0300
Message-ID: <1493024379.24567.154.camel@linux.intel.com>
References: <39750541-c6a9-0e49-59fa-9f0a2e202850@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39750541-c6a9-0e49-59fa-9f0a2e202850@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Sat, 2017-04-22 at 11:36 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> After migrating 8250_exar to MSI in 172c33cb61da, we can get stuck
> without further interrupts because of the special wake-up event these
> chips send. They are only cleared by reading INT0. As we fail to do so
> during startup and shutdown, we can leave the interrupt line asserted,
> which is fatal with edge-triggered MSIs.
> 
> Add the required reading of INT0 to startup and shutdown. Also account
> for the fact that a pending wake-up interrupt means we have to return
> 1
> from exar_handle_irq.
> 
> An alternative approach would have been disabling the wake-up
> interrupt.
> Unfortunately, this feature (REGB[17] = 1) is not available on the
> XR17D15X.
> 
> Fixes: 172c33cb61da ("serial: exar: Enable MSI support")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Regression of upcoming 4.11.
> 
>  drivers/tty/serial/8250/8250_port.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index 6119516ef5fc..3a3667880fcf 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -47,6 +47,7 @@
>  /*
>   * These are definitions for the Exar XR17V35X and XR17(C|D)15X
>   */
> +#define UART_EXAR_INT0		0x80
>  #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
>  #define UART_EXAR_DVID		0x8d	/* Device
> identification */
>  
> @@ -1869,17 +1870,13 @@ static int
> serial8250_default_handle_irq(struct uart_port *port)
>  static int exar_handle_irq(struct uart_port *port)
>  {
>  	unsigned int iir = serial_port_in(port, UART_IIR);
> -	int ret;
> +	int ret = 0;
>  
> -	ret = serial8250_handle_irq(port, iir);
> +	if (((port->type == PORT_XR17V35X) || (port->type ==
> PORT_XR17D15X)) &&
> +	    serial_port_in(port, UART_EXAR_INT0) != 0)
> +		ret = 1;
>  
> -	if ((port->type == PORT_XR17V35X) ||
> -	   (port->type == PORT_XR17D15X)) {

> -		serial_port_in(port, 0x80);
> -		serial_port_in(port, 0x81);
> -		serial_port_in(port, 0x82);
> -		serial_port_in(port, 0x83);

You replaced 4 reads by one. I'm suspecting that on multi-port cards you
still need to read all of them (I assume they are called INT0, INT1,
...). Perhaps you need a helper where you do that and call it from all
necessary places.

> -	}
> +	ret |= serial8250_handle_irq(port, iir);
>  
>  	return ret;
>  }
> @@ -2177,6 +2174,8 @@ int serial8250_do_startup(struct uart_port
> *port)
>  	serial_port_in(port, UART_RX);
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
> +	if ((port->type == PORT_XR17V35X) || (port->type ==
> PORT_XR17D15X))
> +		serial_port_in(port, UART_EXAR_INT0);
>  
>  	/*
>  	 * At this point, there's no way the LSR could still be 0xff;
> @@ -2335,6 +2334,8 @@ int serial8250_do_startup(struct uart_port
> *port)
>  	serial_port_in(port, UART_RX);
>  	serial_port_in(port, UART_IIR);
>  	serial_port_in(port, UART_MSR);
> +	if ((port->type == PORT_XR17V35X) || (port->type ==
> PORT_XR17D15X))
> +		serial_port_in(port, UART_EXAR_INT0);
>  	up->lsr_saved_flags = 0;
>  	up->msr_saved_flags = 0;
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
