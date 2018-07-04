From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/3] serial: 8250: introduce get_divisor() and
 set_divisor() hook
Date: Wed, 04 Jul 2018 13:00:33 +0300
Message-ID: <ced59625cfa0c9132680aca18d17d5cd123d62a0.camel@linux.intel.com>
References: <20180704165908.4bb8b090@xhacker.debian>
         <20180704170217.190711ef@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180704170217.190711ef@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2018-07-04 at 17:02 +0800, Jisheng Zhang wrote:
> Add these two hooks so that they can be overridden with driver
> specific
> implementations.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/tty/serial/8250/8250_core.c |  4 ++++
>  drivers/tty/serial/8250/8250_port.c | 27 +++++++++++++++++++++++----
>  include/linux/serial_core.h         |  7 +++++++
>  3 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c
> b/drivers/tty/serial/8250/8250_core.c
> index 9342fc2ee7df..a0bb77290747 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -1023,6 +1023,10 @@ int serial8250_register_8250_port(struct
> uart_8250_port *up)
>  			uart->port.get_mctrl = up->port.get_mctrl;
>  		if (up->port.set_mctrl)
>  			uart->port.set_mctrl = up->port.set_mctrl;
> +		if (up->port.get_divisor)
> +			uart->port.get_divisor = up-
> >port.get_divisor;
> +		if (up->port.set_divisor)
> +			uart->port.set_divisor = up-
> >port.set_divisor;
>  		if (up->port.startup)
>  			uart->port.startup = up->port.startup;
>  		if (up->port.shutdown)
> diff --git a/drivers/tty/serial/8250/8250_port.c
> b/drivers/tty/serial/8250/8250_port.c
> index 709fe6b4265c..ce0dc17f18ee 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2498,9 +2498,9 @@ static unsigned int npcm_get_divisor(struct
> uart_8250_port *up,
>  	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
>  }
>  
> -static unsigned int serial8250_get_divisor(struct uart_port *port,
> -					   unsigned int baud,
> -					   unsigned int *frac)
> +static unsigned int serial8250_do_get_divisor(struct uart_port *port,
> +					      unsigned int baud,
> +					      unsigned int *frac)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	unsigned int quot;
> @@ -2532,6 +2532,16 @@ static unsigned int
> serial8250_get_divisor(struct uart_port *port,
>  	return quot;
>  }
>  
> +static unsigned int serial8250_get_divisor(struct uart_port *port,
> +					   unsigned int baud,
> +					   unsigned int *frac)
> +{
> +	if (port->get_divisor)
> +		return port->get_divisor(port, baud, frac);
> +
> +	return serial8250_do_get_divisor(port, baud, frac);
> +}
> +
>  static unsigned char serial8250_compute_lcr(struct uart_8250_port
> *up,
>  					    tcflag_t c_cflag)
>  {
> @@ -2570,7 +2580,7 @@ static unsigned char
> serial8250_compute_lcr(struct uart_8250_port *up,
>  	return cval;
>  }
>  
> -static void serial8250_set_divisor(struct uart_port *port, unsigned
> int baud,
> +static void serial8250_do_set_divisor(struct uart_port *port,
> unsigned int baud,
>  			    unsigned int quot, unsigned int
> quot_frac)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> @@ -2603,6 +2613,15 @@ static void serial8250_set_divisor(struct
> uart_port *port, unsigned int baud,
>  	}
>  }
>  
> +static void serial8250_set_divisor(struct uart_port *port, unsigned
> int baud,
> +				   unsigned int quot, unsigned int
> quot_frac)
> +{
> +	if (port->set_divisor)
> +		port->set_divisor(port, baud, quot, quot_frac);
> +	else
> +		serial8250_do_set_divisor(port, baud, quot,
> quot_frac);
> +}
> +
>  static unsigned int serial8250_get_baud_rate(struct uart_port *port,
>  					     struct ktermios
> *termios,
>  					     struct ktermios *old)
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 06ea4eeb09ab..406edae44ca3 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -127,6 +127,13 @@ struct uart_port {
>  					     struct ktermios *);
>  	unsigned int		(*get_mctrl)(struct uart_port *);
>  	void			(*set_mctrl)(struct uart_port *,
> unsigned int);
> +	unsigned int		(*get_divisor)(struct uart_port
> *,
> +					       unsigned int baud,
> +					       unsigned int *frac);
> +	void			(*set_divisor)(struct uart_port
> *,
> +					       unsigned int baud,
> +					       unsigned int quot,
> +					       unsigned int
> quot_frac);
>  	int			(*startup)(struct uart_port
> *port);
>  	void			(*shutdown)(struct uart_port
> *port);
>  	void			(*throttle)(struct uart_port
> *port);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
