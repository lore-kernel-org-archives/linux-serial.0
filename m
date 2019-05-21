From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH resend] serial: 8250: Add support for using
 platform_device resources
Date: Tue, 21 May 2019 20:03:50 +0300
Message-ID: <20190521170350.GL9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190521113426.16790-1-esben@geanix.com>
 <20190521124202.GE9224@smile.fi.intel.com>
 <87d0kbna0p.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d0kbna0p.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Enrico Weigelt <lkml@metux.net>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 21, 2019 at 04:43:18PM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > On Tue, May 21, 2019 at 01:34:26PM +0200, Esben Haabendal wrote:
> >> Allow getting memory resource (mapbase or iobase) as well as irq from
> >> platform_device resources.
> >> 
> >> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
> >> resources are to be used.  When not set, driver behaves as before.
> >> 
> >> This allows use of the serial8250 driver together with devices with
> >> resources added by platform_device_add_resources(), such as mfd child
> >> devices added with mfd_add_devices().
> >> 
> >> When UPF_DEV_RESOURCES flag is set, the following platform_data fields should
> >> not be used: mapbase, iobase, mapsize, and irq.  They are superseded by the
> >> resources attached to the device.
> >> 
> >
> > Same comment here: Requesting resource is orthogonal to the retrieving or
> > slicing them.
> 
> Yes.  But for MFD devices, I do think it makes sense for the MFD parent
> device to request the entire memory resource, and then split it.

Nope. This is layering violation here: The user of the resources is not
handling them in full.

> And for drivers that actually are aware of the struct resource given,
> both approaches work.  Throwing away the resource.parent information
> and calling out request_mem_region() manually breaks the idea of
> managing IORESOURCE_MEM as a tree structure.

How come? Can you show an example of output without and with your patches?

> Are we not supposed to be using the parent/child part of struct
> resource?

It's about slicing, no-one prevents you to do that. I don't see a problem.
Show the output!

> >> -		if (!request_mem_region(port->mapbase, size, "serial")) {
> >> +		if (!(port->flags & UPF_DEV_RESOURCES) &&
> >> +		    !request_mem_region(port->mapbase, size, "serial")) {
> >
> >> -				release_mem_region(port->mapbase, size);
> >> +				if (!(port->flags & UPF_DEV_RESOURCES))
> >> +					release_mem_region(port->mapbase, size);
> >
> >> -		if (!request_region(port->iobase, size, "serial"))
> >> +		if (!(port->flags & UPF_DEV_RESOURCES) &&
> >> +		    !request_region(port->iobase, size, "serial"))
> >
> >> -		release_mem_region(port->mapbase, size);
> >> +		if (!(port->flags & UPF_DEV_RESOURCES))
> >> +			release_mem_region(port->mapbase, size);
> >
> >> -		release_region(port->iobase, size);
> >> +		if (!(port->flags & UPF_DEV_RESOURCES))
> >> +			release_region(port->iobase, size);
> >
> > All these changes are not related to what you describe in the commit message.
> > is a workaround for the bug in the parent MFD driver of the 8250.
> 
> You are right, this is not adequately described in commit message.
> But unless we are not supposed to allow parent/child memory resource
> management, I don't think it is a workaround, but a fix.
> 
> But I can split it out in a separate patch.  Would be nice if I at least
> can get the other part of the change merged.

Like Lee said, and I agree, nothing prevents us to switch to
platform_get_resource().

The stumbling block here is the *requesting* in parent which I strongly
disagree with (at least in a form of this change, I already told you, that this
has to be "fixed" on generic level, not as a hack in one certain driver).

-- 
With Best Regards,
Andy Shevchenko
