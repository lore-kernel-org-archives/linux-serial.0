From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v4] earlycon: 8250: Fix command line regression
Date: Sun, 05 Apr 2015 09:06:01 -0400
Message-ID: <55213339.7050304@hurleysoftware.com>
References: <1428157650-16418-1-git-send-email-peter@hurleysoftware.com>	<1428167961-26841-1-git-send-email-peter@hurleysoftware.com> <CAE9FiQXhbR-g0SPeZ=CPGXuRGk0KrdpvaPXK_JDgg58OGk0EbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE9FiQXhbR-g0SPeZ=CPGXuRGk0KrdpvaPXK_JDgg58OGk0EbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

On 04/05/2015 03:09 AM, Yinghai Lu wrote:
> On Sat, Apr 4, 2015 at 10:19 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> ...
>>  Documentation/kernel-parameters.txt  | 18 +++++++++++++++---
>>  drivers/tty/serial/8250/8250_core.c  | 37 +++++++++++++++++++++++++++++++++---
>>  drivers/tty/serial/8250/8250_early.c | 19 ------------------
>>  3 files changed, 49 insertions(+), 25 deletions(-)
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index bfcb1a6..1facf0b 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -713,10 +713,18 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>
>>                 uart[8250],io,<addr>[,options]
>>                 uart[8250],mmio,<addr>[,options]
>> +               uart[8250],mmio32,<addr>[,options]
>> +               uart[8250],0x<addr>[,options]
> 
> put this to other patch please.
> 
>>                         Start an early, polled-mode console on the 8250/16550
>>                         UART at the specified I/O port or MMIO address,
>> -                       switching to the matching ttyS device later.  The
>> -                       options are the same as for ttyS, above.
>> +                       switching to the matching ttyS device later.
>> +                       MMIO inter-register address stride is either 8-bit
>> +                       (mmio) or 32-bit (mmio32).
>> +                       If none of [io|mmio|mmio32], <addr> is assumed to be
>> +                       equivalent to 'mmio'. 'options' are specified in the
>> +                       same format described for ttyS above; if unspecified,
>> +                       the h/w is not re-initialized.
>> +
>>                 hvc<n>  Use the hypervisor console device <n>. This is for
>>                         both Xen and PowerPC hypervisors.
>>
>> @@ -944,11 +952,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>                 uart[8250],io,<addr>[,options]
>>                 uart[8250],mmio,<addr>[,options]
>>                 uart[8250],mmio32,<addr>[,options]
>> +               uart[8250],0x<addr>[,options]
> 
> and this to another patch please.
> 
>>                         Start an early, polled-mode console on the 8250/16550
>>                         UART at the specified I/O port or MMIO address.
>>                         MMIO inter-register address stride is either 8-bit
>>                         (mmio) or 32-bit (mmio32).
>> -                       The options are the same as for ttyS, above.
>> +                       If none of [io|mmio|mmio32], <addr> is assumed to be
>> +                       equivalent to 'mmio'. 'options' are specified in the
>> +                       same format described for "console=ttyS<n>"; if
>> +                       unspecified, the h/w is not initialized.
>>
>>                 pl011,<addr>
>>                         Start an early, polled-mode console on a pl011 serial
>> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>> index e0fb5f0..456606f 100644
>> --- a/drivers/tty/serial/8250/8250_core.c
>> +++ b/drivers/tty/serial/8250/8250_core.c
>> @@ -3447,6 +3447,21 @@ static int univ8250_console_setup(struct console *co, char *options)
>>         return serial8250_console_setup(up, options);
>>  }
>>
>> +static unsigned int probe_baud(struct uart_port *port)
>> +{
>> +       unsigned char lcr, dll, dlm;
>> +       unsigned int quot;
>> +
>> +       lcr = serial_port_in(port, UART_LCR);
>> +       serial_port_out(port, UART_LCR, lcr | UART_LCR_DLAB);
>> +       dll = serial_port_in(port, UART_DLL);
>> +       dlm = serial_port_in(port, UART_DLM);
>> +       serial_port_out(port, UART_LCR, lcr);
>> +
>> +       quot = (dlm << 8) | dll;
>> +       return (port->uartclk / 16) / quot;
>> +}
>> +
> 
> You said some "newer" chips do not support probe baud. why do you move
> code to core ?

There's no functional difference, but here it's at least possible
to add support for exar, synopsys, ti omap, intel, etc. based on either
port type or a function vector initialized by the sub-driver.


> I was thinking some embedded guys could comment out 8280_early.c, now you get
> extra work for them to comment out code from 8250_core.c.

Huh? That's just ridiculous.


>>  /**
>>   *     univ8250_console_match - non-standard console matching
>>   *     @co:      registering console
>> @@ -3455,13 +3470,18 @@ static int univ8250_console_setup(struct console *co, char *options)
>>   *     @options: ptr to option string from console command line
>>   *
>>   *     Only attempts to match console command lines of the form:
>> - *         console=uart<>,io|mmio|mmio32,<addr>,<options>
>> - *         console=uart<>,<addr>,options
>> + *         console=uart[8250],io|mmio|mmio32,<addr>[,<options>]
>> + *         console=uart[8250],0x<addr>[,<options>]
>>   *     This form is used to register an initial earlycon boot console and
>>   *     replace it with the serial8250_console at 8250 driver init.
>>   *
>>   *     Performs console setup for a match (as required by interface)
>>   *
>> + *     ** HACK ALERT **
> 
> That is not HACK original.
>
> but your fix make it to be hack.
> 
>> + *     If no <options> are specified, then assume the h/w is already setup.
>> + *     This was the undocumented behavior of the original implementation so
>> + *     it is cast in stone forever.
>> + *
>>   *     Returns 0 if console matches; otherwise non-zero to use default matching
>>   */
>>  static int univ8250_console_match(struct console *co, char *name, int idx,
>> @@ -3475,12 +3495,16 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
>>         if (strncmp(name, match, 4) != 0)
>>                 return -ENODEV;
>>
>> +       if (idx && idx != 8250)
>> +               return -ENODEV;
>> +
> 
> Your fix is getting ugly now.

This is required anyway. I'm not the one that decided it would be
cute to have "uart" and "uart8250" mean the same thing.


>>         if (uart_parse_earlycon(options, &iotype, &addr, &options))
>>                 return -ENODEV;
>>
>>         /* try to match the port specified on the command line */
>>         for (i = 0; i < nr_uarts; i++) {
>>                 struct uart_port *port = &serial8250_ports[i].port;
>> +               int baud, bits = 8, parity = 'n', flow = 'n';
>>
>>                 if (port->iotype != iotype)
>>                         continue;
>> @@ -3490,8 +3514,15 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
>>                 if (iotype == UPIO_PORT && port->iobase != addr)
>>                         continue;
>>
>> +               /* link port to console */
>>                 co->index = i;
>> -               return univ8250_console_setup(co, options);
>> +               port->cons = co;
>> +
>> +               if (options && *options)
>> +                       uart_parse_options(options, &baud, &parity, &bits, &flow);
>> +               else
>> +                       baud = probe_baud(port);
>> +               return uart_set_options(port, port->cons, baud, parity, bits, flow);
> 
> what a mess.

This was the mess:

> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
>  
> -static int serial8250_console_early_setup(void)
> -{
> -	return serial8250_find_port_for_earlycon();
> -}
>  
> @@ -3347,7 +3392,7 @@ static struct console serial8250_console = {
>  	.write		= serial8250_console_write,
>  	.device		= uart_console_device,
>  	.setup		= serial8250_console_setup,
> -	.early_setup	= serial8250_console_early_setup,
>  	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
>  	.index		= -1,
>  	.data		= &serial8250_reg,
> @@ -3361,19 +3406,6 @@ static int __init serial8250_console_init(void)
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
>
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
>
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
>
> diff --git a/include/linux/console.h b/include/linux/console.h
>
> -extern int update_console_cmdline(char *name, int idx, char *name_new, int idx_new, char *options);
>
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>  
> -extern int serial8250_find_port(struct uart_port *p);
> -extern int serial8250_find_port_for_earlycon(void);
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
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
>  
> @@ -2436,9 +2418,6 @@ void register_console(struct console *newcon)
>  
> -	if (newcon->early_setup)
> -		newcon->early_setup();
> -


> Now sure if it is safe to move down probe_baud, when serial port is still used.
> 
>>         }
>>
>>         return -ENODEV;
>> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
>> index e95ebfe..8e11968 100644
>> --- a/drivers/tty/serial/8250/8250_early.c
>> +++ b/drivers/tty/serial/8250/8250_early.c
>> @@ -105,21 +105,6 @@ static void __init early_serial8250_write(struct console *console,
>>                 serial8250_early_out(port, UART_IER, ier);
>>  }
>>
>> -static unsigned int __init probe_baud(struct uart_port *port)
>> -{
>> -       unsigned char lcr, dll, dlm;
>> -       unsigned int quot;
>> -
>> -       lcr = serial8250_early_in(port, UART_LCR);
>> -       serial8250_early_out(port, UART_LCR, lcr | UART_LCR_DLAB);
>> -       dll = serial8250_early_in(port, UART_DLL);
>> -       dlm = serial8250_early_in(port, UART_DLM);
>> -       serial8250_early_out(port, UART_LCR, lcr);
>> -
>> -       quot = (dlm << 8) | dll;
>> -       return (port->uartclk / 16) / quot;
>> -}
>> -
>>  static void __init init_port(struct earlycon_device *device)
>>  {
>>         struct uart_port *port = &device->port;
>> @@ -151,10 +136,6 @@ static int __init early_serial8250_setup(struct earlycon_device *device,
>>                 struct uart_port *port = &device->port;
>>                 unsigned int ier;
>>
>> -               device->baud = probe_baud(&device->port);
>> -               snprintf(device->options, sizeof(device->options), "%u",
>> -                        device->baud);
>> -
>>                 /* assume the device was initialized, only mask interrupts */
>>                 ier = serial8250_early_in(port, UART_IER);
>>                 serial8250_early_out(port, UART_IER, ier & UART_IER_UUE);
>> --
> 
> Greg, Please consider apply my fix as attached, it is much cleaner.

On what planet is 27 loc across 4 source files cleaner than
6 loc that might be reducible to 2?
