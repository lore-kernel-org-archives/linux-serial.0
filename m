From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4/4] serial: core: Mask mctrl with TIOCM_RTS too if
 rs485 on and RTS_AFTER_SEND set.
Date: Wed, 06 Jun 2018 15:03:40 +0300
Message-ID: <a156ce90ab7e45ecf6936c29cc5d976c56f49a51.camel@linux.intel.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
         <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
         <20180606094942.71190-3-giulio.benetti@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606094942.71190-3-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: matwey.kornilov@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <mbrugger@suse.com>, Kees Cook <keescook@chromium.org>, Sean Young <sean@mess.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
> If rs485 is enabled and RTS_AFTER_SEND is set on startup need to keep
> TIOCM_RTS asserted to keep rs485 transceiver in RX when idle.
> 
> Check if rs485 is on and RTS_AFTER_SEND is set and mask port->mctrl
> with
> TIOCM_RTS too and not only TIOCM_DTR.
> 

This one feels wrong to be in serial_core.c. Perhaps in 8250/8250*.c.

> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/tty/serial/serial_core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c
> b/drivers/tty/serial/serial_core.c
> index 0466f9f08a91..06d9441f6d20 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2288,6 +2288,16 @@ uart_configure_port(struct uart_driver *drv,
> struct uart_state *state,
>  
>  	if (port->type != PORT_UNKNOWN) {
>  		unsigned long flags;
> +		int rs485_on = port->rs485_config &&
> +			(port->rs485.flags & SER_RS485_ENABLED);
> +		int RTS_after_send = !!(port->rs485.flags &
> +				SER_RS485_RTS_AFTER_SEND);
> +		int mctrl;
> +
> +		if (rs485_on && RTS_after_send)
> +			mctrl = port->mctrl & (TIOCM_DTR |
> TIOCM_RTS);
> +		else
> +			mctrl = port->mctrl & TIOCM_DTR;
>  
>  		uart_report_port(drv, port);
>  
> @@ -2300,7 +2310,7 @@ uart_configure_port(struct uart_driver *drv,
> struct uart_state *state,
>  		 * We probably don't need a spinlock around this, but
>  		 */
>  		spin_lock_irqsave(&port->lock, flags);
> -		port->ops->set_mctrl(port, port->mctrl & TIOCM_DTR);
> +		port->ops->set_mctrl(port, mctrl);
>  		spin_unlock_irqrestore(&port->lock, flags);
>  
>  		/*

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
