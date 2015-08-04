From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: don't announce CIR serial ports
Date: Mon, 03 Aug 2015 21:46:20 -0400
Message-ID: <55C0196C.7090308@hurleysoftware.com>
References: <55BE8725.6090303@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BE8725.6090303@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Maciej,

On 08/02/2015 05:09 PM, Maciej S. Szmigiero wrote:
> CIR type serial ports aren't real serial ports.
> This is just a way to prevent legacy serial driver
> from probing and eventually binding some resources
> so don't announce them like normal serial ports.

I'd like to keep some form of reporting so that we know the
port was properly probed; what about extending uart_report_port()
to including CIR + disabled status?

Secondly, good catch! Because we should not be trying to
register a console on this port, nor driving modem signals.

So maybe an early exit after uart_report_port?

Regards,
Peter Hurley

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
