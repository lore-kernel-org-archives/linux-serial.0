From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: don't announce CIR serial ports
Date: Mon, 3 Aug 2015 16:40:12 -0700
Message-ID: <20150803234012.GA31555@kroah.com>
References: <55BE8725.6090303@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55BE8725.6090303@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Aug 02, 2015 at 11:09:57PM +0200, Maciej S. Szmigiero wrote:
> CIR type serial ports aren't real serial ports.
> This is just a way to prevent legacy serial driver
> from probing and eventually binding some resources
> so don't announce them like normal serial ports.
> 
> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> ---
>  drivers/tty/serial/serial_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index f368520..99f944d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2237,7 +2237,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
>  		port->ops->config_port(port, flags);
>  	}
>  
> -	if (port->type != PORT_UNKNOWN) {
> +	if (port->type != PORT_UNKNOWN && port->type != PORT_8250_CIR) {
>  		unsigned long flags;
>  
>  		uart_report_port(drv, port);

This does not seem correct, why is this type of "port" somehow special
that it should be skiped?

thanks,

greg k-h
