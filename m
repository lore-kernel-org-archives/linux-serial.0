From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH resend] serial: 8250: Add support for using
 platform_device resources
Date: Tue, 21 May 2019 15:42:02 +0300
Message-ID: <20190521124202.GE9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190521113426.16790-1-esben@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190521113426.16790-1-esben@geanix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@geanix.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Enrico Weigelt <lkml@metux.net>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 01:34:26PM +0200, Esben Haabendal wrote:
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
> When UPF_DEV_RESOURCES flag is set, the following platform_data fields should
> not be used: mapbase, iobase, mapsize, and irq.  They are superseded by the
> resources attached to the device.
> 

Same comment here: Requesting resource is orthogonal to the retrieving or
slicing them.

> +		if (p->flags & UPF_DEV_RESOURCES) {
> +			serial8250_probe_resources(dev, i, p, &uart);

This can be easily detected by checking for the resources directly, like

	res = platform_get_resource(...);
	if (res)
		new_scheme();
	else
		old_scheme();

Otherwise looks good.


> -		if (!request_mem_region(port->mapbase, size, "serial")) {
> +		if (!(port->flags & UPF_DEV_RESOURCES) &&
> +		    !request_mem_region(port->mapbase, size, "serial")) {

> -				release_mem_region(port->mapbase, size);
> +				if (!(port->flags & UPF_DEV_RESOURCES))
> +					release_mem_region(port->mapbase, size);

> -		if (!request_region(port->iobase, size, "serial"))
> +		if (!(port->flags & UPF_DEV_RESOURCES) &&
> +		    !request_region(port->iobase, size, "serial"))

> -		release_mem_region(port->mapbase, size);
> +		if (!(port->flags & UPF_DEV_RESOURCES))
> +			release_mem_region(port->mapbase, size);

> -		release_region(port->iobase, size);
> +		if (!(port->flags & UPF_DEV_RESOURCES))
> +			release_region(port->iobase, size);

All these changes are not related to what you describe in the commit message.
is a workaround for the bug in the parent MFD driver of the 8250.

-- 
With Best Regards,
Andy Shevchenko
