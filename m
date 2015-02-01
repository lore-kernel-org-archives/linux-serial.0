From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit
 option
Date: Sun, 01 Feb 2015 11:27:31 -0500
Message-ID: <54CE53F3.5040709@hurleysoftware.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com> <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421068104-30463-2-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ashwin Chaugule <ashwin.chaugule-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Eddie,

On 01/12/2015 08:08 AM, Eddie Huang wrote:
> Add earlycon support not only baudrate option, but also add noinit option.
> If use noinit option, 8250 earlycon will not init serial hardware and use
> loader setting.

I see this went into Greg's tty-testing branch.

The only point of this is to not program the divisor, right?

I ask because early_serial8250_setup() could already handle this without
extra options by simply not doing divisor programming if no baud option is
present.

And this blows up if the optional console= form is used:
    console=uart,mmio32,<addr>,noinit
because the ttyS console will expect line settings for console match.

Regards,
Peter Hurley

> Signed-off-by: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/tty/serial/8250/8250_early.c |  7 ++++---
>  drivers/tty/serial/earlycon.c        | 17 ++++++++++++-----
>  include/linux/serial_8250.h          |  2 ++
>  include/linux/serial_core.h          |  1 +
>  4 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index 4858b8a..a13d757 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -138,19 +138,20 @@ static void __init init_port(struct earlycon_device *device)
>  	serial8250_early_out(port, UART_LCR, c & ~UART_LCR_DLAB);
>  }
>  
> -static int __init early_serial8250_setup(struct earlycon_device *device,
> +int __init early_serial8250_setup(struct earlycon_device *device,
>  					 const char *options)
>  {
>  	if (!(device->port.membase || device->port.iobase))
>  		return 0;
>  
> -	if (!device->baud) {
> +	if (!device->baud && !device->noinit) {
>  		device->baud = probe_baud(&device->port);
>  		snprintf(device->options, sizeof(device->options), "%u",
>  			 device->baud);
>  	}
>  
> -	init_port(device);
> +	if (!device->noinit)
> +		init_port(device);
>  
>  	early_device = device;
>  	device->con->write = early_serial8250_write;
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 64fe25a..4891251 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -58,7 +58,7 @@ static int __init parse_options(struct earlycon_device *device,
>  				char *options)
>  {
>  	struct uart_port *port = &device->port;
> -	int mmio, mmio32, length;
> +	int noinit, mmio, mmio32, length;
>  	unsigned long addr;
>  
>  	if (!options)
> @@ -92,10 +92,17 @@ static int __init parse_options(struct earlycon_device *device,
>  	options = strchr(options, ',');
>  	if (options) {
>  		options++;
> -		device->baud = simple_strtoul(options, NULL, 0);
> -		length = min(strcspn(options, " ") + 1,
> -			     (size_t)(sizeof(device->options)));
> -		strlcpy(device->options, options, length);
> +		noinit = !strncmp(options, "noinit", 6);
> +		if (noinit) {
> +			device->noinit = noinit;
> +			strlcpy(device->options, options, 6);
> +			device->options[6] = '\0';
> +		} else {
> +			device->baud = simple_strtoul(options, NULL, 0);
> +			length = min(strcspn(options, " ") + 1,
> +					(size_t)(sizeof(device->options)));
> +			strlcpy(device->options, options, length);
> +		}
>  	}
>  
>  	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32)
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index e02acf0..0e26eec 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -119,6 +119,8 @@ extern int serial8250_find_port(struct uart_port *p);
>  extern int serial8250_find_port_for_earlycon(void);
>  extern unsigned int serial8250_early_in(struct uart_port *port, int offset);
>  extern void serial8250_early_out(struct uart_port *port, int offset, int value);
> +extern int early_serial8250_setup(struct earlycon_device *device,
> +					 const char *options);
>  extern int setup_early_serial8250_console(char *cmdline);
>  extern void serial8250_do_set_termios(struct uart_port *port,
>  		struct ktermios *termios, struct ktermios *old);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 057038c..72c6698 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -326,6 +326,7 @@ struct earlycon_device {
>  	struct uart_port port;
>  	char options[16];		/* e.g., 115200n8 */
>  	unsigned int baud;
> +	int noinit;
>  };
>  int setup_earlycon(char *buf, const char *match,
>  		   int (*setup)(struct earlycon_device *, const char *));
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
