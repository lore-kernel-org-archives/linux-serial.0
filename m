From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/3] serial: 8250_early: Add support for regshift
Date: Tue, 12 Jan 2016 08:15:45 -0800
Message-ID: <569526B1.3030000@hurleysoftware.com>
References: <1452594809-17972-1-git-send-email-jonathanh@nvidia.com>
 <1452594809-17972-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452594809-17972-3-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Jon,

On 01/12/2016 02:33 AM, Jon Hunter wrote:
> The 8250 early console assumes a default regshift for each iotype. This
> does not work for all devices. For example, Tegra UARTs use a iotype of
> UPIO_MEM with a regshift of 2 because the registers are 32-bit aligned
> and permit byte access.
> 
> If the regshift is specified (for example, via device-tree), then use the
> value provided and otherwise revert to the defaults assumed for each
> iotype.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Please note that today for Tegra, early console is supported by passing
> the boot parameter "earlycon=uart8250,mmio32,0xXXXXXXXX". While this works
> and we could use UPIO_MEM32 for tegra, this would mean changing all the
> DT source files for Tegra to add the "reg-io-width" property. IMO it seems
> better to make early console for 8250 work in the same way as the normal
> 8250 console and support regshift.
> 
>  drivers/tty/serial/8250/8250_early.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index af62131af21e..758054957788 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -41,15 +41,15 @@ static unsigned int __init serial8250_early_in(struct uart_port *port, int offse
>  {
>  	switch (port->iotype) {
>  	case UPIO_MEM:
> -		return readb(port->membase + offset);
> +		return readb(port->membase + (offset << port->regshift));
>  	case UPIO_MEM16:
> -		return readw(port->membase + (offset << 1));
> +		return readw(port->membase + (offset << port->regshift));
>  	case UPIO_MEM32:
> -		return readl(port->membase + (offset << 2));
> +		return readl(port->membase + (offset << port->regshift));
>  	case UPIO_MEM32BE:
> -		return ioread32be(port->membase + (offset << 2));
> +		return ioread32be(port->membase + (offset << port->regshift));
>  	case UPIO_PORT:
> -		return inb(port->iobase + offset);
> +		return inb(port->iobase + (offset << port->regshift));
>  	default:
>  		return 0;
>  	}
> @@ -59,19 +59,19 @@ static void __init serial8250_early_out(struct uart_port *port, int offset, int
>  {
>  	switch (port->iotype) {
>  	case UPIO_MEM:
> -		writeb(value, port->membase + offset);
> +		writeb(value, port->membase + (offset << port->regshift));
>  		break;
>  	case UPIO_MEM16:
> -		writew(value, port->membase + (offset << 1));
> +		writew(value, port->membase + (offset << port->regshift));
>  		break;
>  	case UPIO_MEM32:
> -		writel(value, port->membase + (offset << 2));
> +		writel(value, port->membase + (offset << port->regshift));
>  		break;
>  	case UPIO_MEM32BE:
> -		iowrite32be(value, port->membase + (offset << 2));
> +		iowrite32be(value, port->membase + (offset << port->regshift));
>  		break;
>  	case UPIO_PORT:
> -		outb(value, port->iobase + offset);
> +		outb(value, port->iobase + (offset << port->regshift));
>  		break;
>  	}
>  }
> @@ -128,6 +128,22 @@ int __init early_serial8250_setup(struct earlycon_device *device,
>  	if (!(device->port.membase || device->port.iobase))
>  		return -ENODEV;
>  
> +	/*
> +	 * If regshift is not specified, then assume the
> +	 * following defaults for the below iotypes.
> +	 */
> +	if (!device->port.regshift) {
> +		switch (device->port.iotype) {
> +		case UPIO_MEM16:
> +			device->port.regshift = 1;
> +			break;
> +		case UPIO_MEM32:
> +		case UPIO_MEM32BE:
> +			device->port.regshift = 2;
> +			break;
> +		}
> +	}

Since the earlycon command line parsing sets port->regshift, the only possible
path requiring defaults would be DT, but 8250 DT should not have default
regshift based on the iotype; the 8250 port driver doesn't.

Regards,
Peter Hurley

> +
>  	if (!device->baud) {
>  		struct uart_port *port = &device->port;
>  		unsigned int ier;
> 
