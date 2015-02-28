From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH -next 03/13] console: Add extensible console matching
Date: Sat, 28 Feb 2015 12:18:14 -0500
Message-ID: <54F1F856.8020106@hurleysoftware.com>
References: <1424795830-31223-1-git-send-email-peter@hurleysoftware.com> <1424795830-31223-4-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424795830-31223-4-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 02/24/2015 11:37 AM, Peter Hurley wrote:
> Add match() method to struct console which allows the console to
> perform console command line matching instead of (or in addition to)
> default console matching (ie., by fixed name and index).
> 
> The match() method returns 0 to indicate a successful match; normal
> console matching occurs if no match() method is defined or the
> match() method returns non-zero. The match() method is expected to set
> the console index if required.
> 
> Re-implement earlycon-to-console-handoff with direct matching of
> "console=uart|uart8250,..." to the 8250 ttyS console.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/serial/8250/8250_core.c  | 64 +++++++++++++++++++++++++++---------
>  drivers/tty/serial/8250/8250_early.c | 23 -------------
>  include/linux/console.h              |  3 +-
>  include/linux/serial_8250.h          |  2 --
>  kernel/printk/printk.c               | 50 ++++++++++------------------
>  5 files changed, 66 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index e3b9570a..5eb95fd 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -3337,9 +3337,54 @@ static int serial8250_console_setup(struct console *co, char *options)
>  	return uart_set_options(port, co, baud, parity, bits, flow);
>  }
>  
> -static int serial8250_console_early_setup(void)
> +/**
> + *	serial8250_console_match - non-standard console matching
> + *	@co:	  registering console
> + *	@name:	  name from console command line
> + *	@idx:	  index from console command line
> + *	@options: ptr to option string from console command line
> + *
> + *	Only attempts to match console command lines of the form:
> + *	    console=uart<>,io|mmio|mmio32,<addr>,<options>
> + *	    console=uart<>,<addr>,options
> + *	This form is used to register an initial earlycon boot console and
> + *	replace it with the serial8250_console at 8250 driver init.
> + *
> + *	Performs console setup for a match (as required by interface)
> + *
> + *	Returns 0 if console matches; otherwise non-zero to use default matching
> + */
> +static int serial8250_console_match(struct console *co, char *name, int idx,
> +				    char *options)
>  {
> -	return serial8250_find_port_for_earlycon();
> +	char match[] = "uart";	/* 8250-specific earlycon name */
> +	unsigned char iotype;
> +	unsigned long addr;
> +	int i;
> +
> +	if (strncmp(name, match, 4) != 0)
> +		return -ENODEV;
> +
> +	if (uart_parse_earlycon(options, &iotype, &addr, &options))
> +		return -ENODEV;
> +
> +	/* try to match the port specified on the command line */
> +	for (i = 0; i < nr_uarts; i++) {
> +		struct uart_port *port = &serial8250_ports[i].port;
> +
> +		if (port->iotype != iotype)
> +			continue;
> +		if ((iotype == UPIO_MEM || iotype == UPIO_MEM32) &&
> +		    (port->mapbase != addr))
> +			continue;
> +		if (iotype == UPIO_PORT && port->iobase != addr)
> +			continue;
> +
> +		co->index = i;
> +		return serial8250_console_setup(co, options);
> +	}
> +
> +	return -ENODEV;
>  }
>  
>  static struct console serial8250_console = {
> @@ -3347,7 +3392,7 @@ static struct console serial8250_console = {
>  	.write		= serial8250_console_write,
>  	.device		= uart_console_device,
>  	.setup		= serial8250_console_setup,
> -	.early_setup	= serial8250_console_early_setup,
> +	.match		= serial8250_console_match,
>  	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
>  	.index		= -1,
>  	.data		= &serial8250_reg,
> @@ -3361,19 +3406,6 @@ static int __init serial8250_console_init(void)
>  }
>  console_initcall(serial8250_console_init);
>  
> -int serial8250_find_port(struct uart_port *p)
> -{
> -	int line;
> -	struct uart_port *port;
> -
> -	for (line = 0; line < nr_uarts; line++) {
> -		port = &serial8250_ports[line].port;
> -		if (uart_match_port(p, port))
> -			return line;
> -	}
> -	return -ENODEV;
> -}
> -
>  #define SERIAL8250_CONSOLE	&serial8250_console
>  #else
>  #define SERIAL8250_CONSOLE	NULL
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index c31a22b..49bca65 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -173,26 +173,3 @@ int __init setup_early_serial8250_console(char *cmdline)
>  
>  	return setup_earlycon(cmdline, match, early_serial8250_setup);
>  }
> -
> -int serial8250_find_port_for_earlycon(void)
> -{
> -	struct earlycon_device *device = early_device;
> -	struct uart_port *port = device ? &device->port : NULL;
> -	int line;
> -	int ret;
> -
> -	if (!port || (!port->membase && !port->iobase))
> -		return -ENODEV;
> -
> -	line = serial8250_find_port(port);
> -	if (line < 0)
> -		return -ENODEV;
> -
> -	ret = update_console_cmdline("uart", 8250,
> -			     "ttyS", line, device->options);
> -	if (ret < 0)
> -		ret = update_console_cmdline("uart", 0,
> -				     "ttyS", line, device->options);
> -
> -	return ret;
> -}
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 7571a16..9f50fb4 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -123,7 +123,7 @@ struct console {
>  	struct tty_driver *(*device)(struct console *, int *);
>  	void	(*unblank)(void);
>  	int	(*setup)(struct console *, char *);
> -	int	(*early_setup)(void);
> +	int	(*match)(struct console *, char *name, int idx, char *options);
>  	short	flags;
>  	short	index;
>  	int	cflag;
> @@ -141,7 +141,6 @@ extern int console_set_on_cmdline;
>  extern struct console *early_console;
>  
>  extern int add_preferred_console(char *name, int idx, char *options);
> -extern int update_console_cmdline(char *name, int idx, char *name_new, int idx_new, char *options);
>  extern void register_console(struct console *);
>  extern int unregister_console(struct console *);
>  extern struct console *console_drivers;
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index a8efa23..f26ae7f 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -118,8 +118,6 @@ void serial8250_resume_port(int line);
>  
>  extern int early_serial_setup(struct uart_port *port);
>  
> -extern int serial8250_find_port(struct uart_port *p);
> -extern int serial8250_find_port_for_earlycon(void);
>  extern unsigned int serial8250_early_in(struct uart_port *port, int offset);
>  extern void serial8250_early_out(struct uart_port *port, int offset, int value);
>  extern int setup_early_serial8250_console(char *cmdline);
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ce5c297..040be39 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2017,24 +2017,6 @@ int add_preferred_console(char *name, int idx, char *options)
>  	return __add_preferred_console(name, idx, options, NULL);
>  }
>  
> -int update_console_cmdline(char *name, int idx, char *name_new, int idx_new, char *options)
> -{
> -	struct console_cmdline *c;
> -	int i;
> -
> -	for (i = 0, c = console_cmdline;
> -	     i < MAX_CMDLINECONSOLES && c->name[0];
> -	     i++, c++)
> -		if (strcmp(c->name, name) == 0 && c->index == idx) {
> -			strlcpy(c->name, name_new, sizeof(c->name));
> -			c->options = options;
> -			c->index = idx_new;
> -			return i;
> -		}
> -	/* not found */
> -	return -1;
> -}
> -
>  bool console_suspend_enabled = true;
>  EXPORT_SYMBOL(console_suspend_enabled);
>  
> @@ -2436,9 +2418,6 @@ void register_console(struct console *newcon)
>  	if (preferred_console < 0 || bcon || !console_drivers)
>  		preferred_console = selected_console;
>  
> -	if (newcon->early_setup)
> -		newcon->early_setup();
> -
>  	/*
>  	 *	See if we want to use this console driver. If we
>  	 *	didn't select a console we take the first one
> @@ -2464,20 +2443,25 @@ void register_console(struct console *newcon)
>  	for (i = 0, c = console_cmdline;
>  	     i < MAX_CMDLINECONSOLES && c->name[0];
>  	     i++, c++) {
> -		if (strcmp(c->name, newcon->name) != 0)
> -			continue;

Andrew,

I just discovered that struct console_cmdline::name[] and
struct console::name[] are not the same size, which is a bug that
should probably go into -stable.

I'll respin a v2 of this series on top of that bug fix, which I'll
send shortly.

Regards,
Peter Hurley

> -		if (newcon->index >= 0 &&
> -		    newcon->index != c->index)
> -			continue;
> -		if (newcon->index < 0)
> -			newcon->index = c->index;
> +		if (!newcon->match ||
> +		    newcon->match(newcon, c->name, c->index, c->options) != 0) {
> +			/* default matching */
> +			if (strcmp(c->name, newcon->name) != 0)
> +				continue;
> +			if (newcon->index >= 0 &&
> +			    newcon->index != c->index)
> +				continue;
> +			if (newcon->index < 0)
> +				newcon->index = c->index;
>  
> -		if (_braille_register_console(newcon, c))
> -			return;
> +			if (_braille_register_console(newcon, c))
> +				return;
> +
> +			if (newcon->setup &&
> +			    newcon->setup(newcon, c->options) != 0)
> +				break;
> +		}
>  
> -		if (newcon->setup &&
> -		    newcon->setup(newcon, console_cmdline[i].options) != 0)
> -			break;
>  		newcon->flags |= CON_ENABLED;
>  		if (i == selected_console) {
>  			newcon->flags |= CON_CONSDEV;
> 
