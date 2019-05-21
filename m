From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH resend] serial: 8250: Add support for using platform_device resources
Date: Tue, 21 May 2019 16:43:18 +0200
Message-ID: <87d0kbna0p.fsf@haabendal.dk>
References: <20190430140416.4707-1-esben@geanix.com>
        <20190521113426.16790-1-esben@geanix.com>
        <20190521124202.GE9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521124202.GE9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Tue, 21 May 2019 15:42:02 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Enrico Weigelt <lkml@metux.net>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, May 21, 2019 at 01:34:26PM +0200, Esben Haabendal wrote:
>> Allow getting memory resource (mapbase or iobase) as well as irq from
>> platform_device resources.
>> 
>> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
>> resources are to be used.  When not set, driver behaves as before.
>> 
>> This allows use of the serial8250 driver together with devices with
>> resources added by platform_device_add_resources(), such as mfd child
>> devices added with mfd_add_devices().
>> 
>> When UPF_DEV_RESOURCES flag is set, the following platform_data fields should
>> not be used: mapbase, iobase, mapsize, and irq.  They are superseded by the
>> resources attached to the device.
>> 
>
> Same comment here: Requesting resource is orthogonal to the retrieving or
> slicing them.

Yes.  But for MFD devices, I do think it makes sense for the MFD parent
device to request the entire memory resource, and then split it.

And for drivers that actually are aware of the struct resource given,
both approaches work.  Throwing away the resource.parent information
and calling out request_mem_region() manually breaks the idea of
managing IORESOURCE_MEM as a tree structure.

Are we not supposed to be using the parent/child part of struct
resource?

>> +		if (p->flags & UPF_DEV_RESOURCES) {
>> +			serial8250_probe_resources(dev, i, p, &uart);
>
> This can be easily detected by checking for the resources directly, like
>
> 	res = platform_get_resource(...);
> 	if (res)
> 		new_scheme();
> 	else
> 		old_scheme();
>
> Otherwise looks good.

Sounds fine with me.  I was afraid that it could cause problems with
existing drivers, where platform_get_resource() would work, but return
something else than desired.  That would probably have gone unnoticed by
now.  But can ofcourse be fixed if it occurs.


>> -		if (!request_mem_region(port->mapbase, size, "serial")) {
>> +		if (!(port->flags & UPF_DEV_RESOURCES) &&
>> +		    !request_mem_region(port->mapbase, size, "serial")) {
>
>> -				release_mem_region(port->mapbase, size);
>> +				if (!(port->flags & UPF_DEV_RESOURCES))
>> +					release_mem_region(port->mapbase, size);
>
>> -		if (!request_region(port->iobase, size, "serial"))
>> +		if (!(port->flags & UPF_DEV_RESOURCES) &&
>> +		    !request_region(port->iobase, size, "serial"))
>
>> -		release_mem_region(port->mapbase, size);
>> +		if (!(port->flags & UPF_DEV_RESOURCES))
>> +			release_mem_region(port->mapbase, size);
>
>> -		release_region(port->iobase, size);
>> +		if (!(port->flags & UPF_DEV_RESOURCES))
>> +			release_region(port->iobase, size);
>
> All these changes are not related to what you describe in the commit message.
> is a workaround for the bug in the parent MFD driver of the 8250.

You are right, this is not adequately described in commit message.
But unless we are not supposed to allow parent/child memory resource
management, I don't think it is a workaround, but a fix.

But I can split it out in a separate patch.  Would be nice if I at least
can get the other part of the change merged.

/Esben
