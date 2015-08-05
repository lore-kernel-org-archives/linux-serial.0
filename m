From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: don't register CIR serial ports
Date: Wed, 5 Aug 2015 08:25:33 -0700
Message-ID: <20150805152533.GA16635@kroah.com>
References: <55C2029D.30003@maciej.szmigiero.name>
 <20150805145134.GB363@kroah.com>
 <55C225D6.4010601@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C225D6.4010601@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 05, 2015 at 05:03:50PM +0200, Maciej S. Szmigiero wrote:
> On 05.08.2015 16:51, Greg Kroah-Hartman wrote:
> > On Wed, Aug 05, 2015 at 02:33:33PM +0200, Maciej S. Szmigiero wrote:
> >> CIR type serial ports aren't real serial ports.
> >>
> >> This is just a way to prevent legacy 8250 serial
> >> driver from probing and eventually binding some
> >> resources.
> >>
> >> Since in current state such ports aren't providing
> >> any real functionality and it is not possible
> >> to change their type via setserial/ioctl(TIOCSSERIAL)
> >> (due to UPF_FIXED_PORT flag set on them)
> >> it is simpler and cleaner to not register them at all
> >> with serial core.
> >>
> >> Print a short message in this case so it is known
> >> to user what has happened.
> >>
> >> This way checks for PORT_8250_CIR in serial port
> >> callbacks can be removed too, since they won't
> >> ever be called.
> >>
> >> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> >> ---
> >> This replaces "serial: don't announce CIR serial ports"
> >> submission.
> >>
> >>  drivers/tty/serial/8250/8250_core.c |   38 +++++++++++++++++-----------------
> >>  1 files changed, 19 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> >> index 37fff12..b843b83 100644
> >> --- a/drivers/tty/serial/8250/8250_core.c
> >> +++ b/drivers/tty/serial/8250/8250_core.c
> >> @@ -2129,9 +2129,6 @@ int serial8250_do_startup(struct uart_port *port)
> >>  	unsigned char lsr, iir;
> >>  	int retval;
> >>  
> >> -	if (port->type == PORT_8250_CIR)
> >> -		return -ENODEV;
> >> -
> >>  	if (!port->fifosize)
> >>  		port->fifosize = uart_config[port->type].fifo_size;
> >>  	if (!up->tx_loadsz)
> >> @@ -2858,14 +2855,8 @@ static void serial8250_release_port(struct uart_port *port)
> >>  static int serial8250_request_port(struct uart_port *port)
> >>  {
> >>  	struct uart_8250_port *up = up_to_u8250p(port);
> >> -	int ret;
> >> -
> >> -	if (port->type == PORT_8250_CIR)
> >> -		return -ENODEV;
> >> -
> >> -	ret = serial8250_request_std_resource(up);
> >>  
> >> -	return ret;
> >> +	return serial8250_request_std_resource(up);
> >>  }
> >>  
> >>  static int fcr_get_rxtrig_bytes(struct uart_8250_port *up)
> >> @@ -3013,9 +3004,6 @@ static void serial8250_config_port(struct uart_port *port, int flags)
> >>  	struct uart_8250_port *up = up_to_u8250p(port);
> >>  	int ret;
> >>  
> >> -	if (port->type == PORT_8250_CIR)
> >> -		return;
> >> -
> >>  	/*
> >>  	 * Find the region that we can probe for.  This in turn
> >>  	 * tells us whether we can probe for the type of port.
> >> @@ -3889,13 +3877,25 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
> >>  		if (up->dl_write)
> >>  			uart->dl_write = up->dl_write;
> >>  
> >> -		if (serial8250_isa_config != NULL)
> >> -			serial8250_isa_config(0, &uart->port,
> >> -					&uart->capabilities);
> >> +		if (uart->port.type != PORT_8250_CIR) {
> >> +			if (serial8250_isa_config != NULL)
> >> +				serial8250_isa_config(0, &uart->port,
> >> +						&uart->capabilities);
> >>  
> >> -		ret = uart_add_one_port(&serial8250_reg, &uart->port);
> >> -		if (ret == 0)
> >> -			ret = uart->port.line;
> >> +			ret = uart_add_one_port(&serial8250_reg,
> >> +						&uart->port);
> >> +			if (ret == 0)
> >> +				ret = uart->port.line;
> >> +		} else {
> >> +			pr_info("%s%sskipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
> >> +				uart->port.dev ? dev_name(uart->port.dev) : "",
> >> +				uart->port.dev ? ": " : "",
> >> +				uart->port.iobase,
> >> +				(unsigned long long)uart->port.mapbase,
> >> +				uart->port.irq);
> > 
> > dev_info() perhaps?  It provides much of what you are trying to say
> > here.
> 
> I thought about it, but while currently uart->port.dev is always set
> (because these ports are "registered" by PNP 8250 driver) maybe
> one day other sources will also make use of this port type.

Let someone in the future worry about that, right now the structure is
always there, so please use it.

greg k-h
