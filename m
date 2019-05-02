From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Date: Thu, 2 May 2019 13:45:56 +0300
Message-ID: <20190502104556.GS9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874l6efxta.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, May 01, 2019 at 09:17:37AM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> > Hmm... Currently it's done inside individual port drivers, like 8250_dw.c.
> > Each of the drivers can do it differently, for example 8250_lpss.c or
> > 8250_pnp.c.
> 
> So, you would prefer to create a new "specialized" port driver that uses
> platform resources?  I am not doing anything else different from
> the generic port driver here in 8250_core.c.

If it's required and using serial8250 directly is not enough.

> >> +				if (!(port->flags & UPF_DEV_RESOURCES))
> >> +					release_mem_region(port->mapbase, size);
> >
> > This is again same issue. The parent should not request resource it
> > doesn't use.
> 
> Yes, this is same issue.
> 
> But the last part is not true.  A parent mfd driver might "use" a memory
> resource for the sole purpose of splitting it up for it's mfd child
> devices.  This is a core part of mfd framework, and not something I am
> inventing with this patch.  I am just trying to make it possible to use
> 8250 driver in that context.
> 
> > I think I understand what is a confusion here.
> >
> > For the IO resources we have two operations:
> > - mapping / re-mapping (may be shared)
> > - requesting (exclusive)
> >
> > In the parenthesis I put a level of access to it. While many device
> > drivers can *share* same resource (mapped or unmapped), the only one
> > can actually request it.
> 
> Mostly true.  But there is an important twist to the exclusive restriction.
> 
> The exclusive part of the request is limited to the the same root/parent
> resource.
> 
> When you request a memory resource from the root resource
> (iomem_resource), the resource returned can be used as a new parent
> resource.  This new parent can then be used to give exclusive access to
> slices of that resource.  When used like that, I expect that the parent
> resource is not supposed to be used for anything else than honoring
> resource requests.
> 
> And this is exactly what mfd-core uses the mem_base argument
> in mfd_add_devices().
> 
> > So, the parent can take an slice resources as it would be
> > appropriated, but not requesting them.
> 
> The parent is not and should not be doing that by itself.  The request
> is done on by mfd-core when mfd_add_devices() is called.

No, MFD *does not* (and actually *may not* in order to allow standalone drivers
to be used as children w/o modifications) request resources. It just passes
them to children as parent suggested.

> > OTOH, it's possible to have a (weird) MFD case where parent *requested*
> > resources, and *all* of its children are aware of that.
> 
> I am not sure what you mean with this, but mfd drivers should not pass
> along it's intire requested memory resource(s) to child devices.  The
> child devices will get the requested resource slices, as implemented by
> mfd_add_devices().
> 
> I hope you can see that I am not violating any fundamental design
> decissions here, but actually try adhere to them (resource management,
> platform_device resource management, and mfd-core).

-- 
With Best Regards,
Andy Shevchenko
