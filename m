From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Date: Tue, 30 Apr 2019 18:37:36 +0300
Message-ID: <20190430153736.GL9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430140416.4707-1-esben@geanix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@geanix.com>
Cc: linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 30, 2019 at 04:04:13PM +0200, Esben Haabendal wrote:
> Allow getting memory resource (mapbase or iobase) as well as irq from
> platform_device resources.
> 
> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
> resources are to be used.  When not set, driver behaves as before.
> 
> This allows use of the serial8250 driver together with devices with
> resources added by platform_device_add_resources(), such as mfd child
> devices added with mfd_add_devices().
> 

> Remaining platform_data fields (other than mapbase, iobase, mapsize and
> irq) are used just as before.  Note

Note what?

> +static int serial8250_probe_resources(struct platform_device *pdev,
> +				      unsigned int num,
> +				      struct plat_serial8250_port *p,
> +				      struct uart_8250_port *uart)
> +{
> +	struct resource *r;
> +	int irq;
> +
> +	switch (p->iotype) {
> +	case UPIO_AU:
> +	case UPIO_TSI:
> +	case UPIO_MEM32:
> +	case UPIO_MEM32BE:
> +	case UPIO_MEM16:
> +	case UPIO_MEM:
> +		r = platform_get_resource(pdev, IORESOURCE_MEM, num);
> +		if (!r)
> +			return -ENODEV;
> +		uart->port.mapbase = r->start;
> +		uart->port.mapsize = resource_size(r);
> +		uart->port.flags |= UPF_IOREMAP;
> +		break;
> +	case UPIO_HUB6:
> +	case UPIO_PORT:
> +		r = platform_get_resource(pdev, IORESOURCE_IO, num);
> +		if (!r)
> +			return -ENODEV;
> +		uart->port.iobase = r->start;
> +		uart->port.mapsize = resource_size(r);
> +		break;
> +	}
> +
> +	irq = platform_get_irq(pdev, num);
> +	if (irq == -ENXIO)
> +		uart->port.irq = 0; /* no interrupt -> use polling */
> +	else if (irq < 0)
> +		return irq;
> +	uart->port.irq = irq;
> +
> +	return 0;
> +}

Hmm... Currently it's done inside individual port drivers, like 8250_dw.c.
Each of the drivers can do it differently, for example 8250_lpss.c or
8250_pnp.c.

> +				if (!(port->flags & UPF_DEV_RESOURCES))
> +					release_mem_region(port->mapbase, size);

This is again same issue. The parent should not request resource it doesn't use.

I think I understand what is a confusion here.

For the IO resources we have two operations:
- mapping / re-mapping (may be shared)
- requesting (exclusive)

In the parenthesis I put a level of access to it. While many device drivers can
*share* same resource (mapped or unmapped), the only one can actually request
it.

So, the parent can take an slice resources as it would be appropriated, but not
requesting them.

OTOH, it's possible to have a (weird) MFD case where parent *requested*
resources, and *all* of its children are aware of that.

-- 
With Best Regards,
Andy Shevchenko
