From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
Date: Thu, 02 May 2019 14:41:45 +0200
Message-ID: <87pnp11112.fsf@haabendal.dk>
References: <20190430140416.4707-1-esben@geanix.com>
        <20190430153736.GL9224@smile.fi.intel.com>
        <874l6efxta.fsf@haabendal.dk>
        <20190502104556.GS9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502104556.GS9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Thu, 2 May 2019 13:45:56 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Lee

Could you help clarify whether or not this patch is trying to do
something odd/wrong?

I might be misunderstanding Andy (probably is), but the discussion
revolves around the changes I propose where I change the serial8250
driver to use platform_get_resource() in favour of
request_mem_region()/release_mem_region().

In my understanding, use of platform_get_resource() is the right thing
to do in order to integrate properly with with MFD drivers that splits a
common memory resource in mfd_add_device() using the mem_base argument.

Discussion follows:

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Wed, May 01, 2019 at 09:17:37AM +0200, Esben Haabendal wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
>> > Hmm... Currently it's done inside individual port drivers, like 8250_dw.c.
>> > Each of the drivers can do it differently, for example 8250_lpss.c or
>> > 8250_pnp.c.
>> 
>> So, you would prefer to create a new "specialized" port driver that uses
>> platform resources?  I am not doing anything else different from
>> the generic port driver here in 8250_core.c.
>
> If it's required and using serial8250 directly is not enough.

Sorry, I am not sure what you mean by that.

>> >> +				if (!(port->flags & UPF_DEV_RESOURCES))
>> >> +					release_mem_region(port->mapbase, size);
>> >
>> > This is again same issue. The parent should not request resource it
>> > doesn't use.
>> 
>> Yes, this is same issue.
>> 
>> But the last part is not true.  A parent mfd driver might "use" a memory
>> resource for the sole purpose of splitting it up for it's mfd child
>> devices.  This is a core part of mfd framework, and not something I am
>> inventing with this patch.  I am just trying to make it possible to use
>> 8250 driver in that context.
>> 
>> > I think I understand what is a confusion here.
>> >
>> > For the IO resources we have two operations:
>> > - mapping / re-mapping (may be shared)
>> > - requesting (exclusive)
>> >
>> > In the parenthesis I put a level of access to it. While many device
>> > drivers can *share* same resource (mapped or unmapped), the only one
>> > can actually request it.
>> 
>> Mostly true.  But there is an important twist to the exclusive restriction.
>> 
>> The exclusive part of the request is limited to the the same root/parent
>> resource.
>> 
>> When you request a memory resource from the root resource
>> (iomem_resource), the resource returned can be used as a new parent
>> resource.  This new parent can then be used to give exclusive access to
>> slices of that resource.  When used like that, I expect that the parent
>> resource is not supposed to be used for anything else than honoring
>> resource requests.
>> 
>> And this is exactly what mfd-core uses the mem_base argument
>> in mfd_add_devices().
>> 
>> > So, the parent can take an slice resources as it would be
>> > appropriated, but not requesting them.
>> 
>> The parent is not and should not be doing that by itself.  The request
>> is done on by mfd-core when mfd_add_devices() is called.
>
> No, MFD *does not* (and actually *may not* in order to allow standalone drivers
> to be used as children w/o modifications) request resources. It just passes
> them to children as parent suggested.

In drivers/mfd/mfd-core.c:mfd_add_device() :

        for (r = 0; r < cell->num_resources; r++) {
                res[r].name = cell->resources[r].name;
                res[r].flags = cell->resources[r].flags;

                /* Find out base to use */
                if ((cell->resources[r].flags & IORESOURCE_MEM) && mem_base) {
                        res[r].parent = mem_base;
                        res[r].start = mem_base->start +
                                cell->resources[r].start;
                        res[r].end = mem_base->start +
                                cell->resources[r].end;
                } else if (cell->resources[r].flags & IORESOURCE_IRQ) {
                        if (domain) {
                                /* Unable to create mappings for IRQ ranges. */
                                WARN_ON(cell->resources[r].start !=
                                        cell->resources[r].end);
                                res[r].start = res[r].end = irq_create_mapping(
                                        domain, cell->resources[r].start);
                        } else {
                                res[r].start = irq_base +
                                        cell->resources[r].start;
                                res[r].end   = irq_base +
                                        cell->resources[r].end;
                        }
                } else {
                        res[r].parent = cell->resources[r].parent;
                        res[r].start = cell->resources[r].start;
                        res[r].end   = cell->resources[r].end;
                }

                if (!cell->ignore_resource_conflicts) {
                        if (has_acpi_companion(&pdev->dev)) {
                                ret = acpi_check_resource_conflict(&res[r]);
                                if (ret)
                                        goto fail_alias;
                        }
                }
        }

        ret = platform_device_add_resources(pdev, res, cell->num_resources);

This creates the child resources.  Whether we call that requesting the
resources or not, is a matter of word.  But it is what it is.  When it
is done, you cannot use request_mem_region() for those memory resources,
they are now locked/exclusive for the mfd parent *and* for the
respective mfd child device.

In order to use them, child devices simply use platform_get_resource(),
and everything works nicely.  It works fine for normal (non-mfd)
devices, as they get (requests) the resources from the root resource
(iomem_resource), and works fine for mfd devices as well.  So no changes
are needed for drivers to work with mfd.

Whether you call the thing that mfd_add_device() does for "request
resources" or just "pass them to children" is a matter of words.  The
mfd (parent) has a resource which it cuts up into slices for its
children, and these slices are passed to the child devices.  The drivers
for these child devices must then pickup the resource(s) using
platform_get_resource().  At no point is any "request_*" function
called.

Looking at in another way.

The request_mem_region() macro call __request_resource(), which which
simply creates a new 'struct resource' in the iomem_resource resource.

In mfd_add_device(), almost the same happens.  A new 'struct resource'
is created in the mem_base resource.

In both cases, a 'struct resource' is created, representing exclusive
access to the resource.  And like it or not, this is something that MFD
already *do*, and I think it is way out of scope of this patch to change
that.

I just try to make serial8250 driver work nicely in that (mfd) context,
without changing how mfd is working.

>> > OTOH, it's possible to have a (weird) MFD case where parent *requested*
>> > resources, and *all* of its children are aware of that.
>> 
>> I am not sure what you mean with this, but mfd drivers should not pass
>> along it's intire requested memory resource(s) to child devices.  The
>> child devices will get the requested resource slices, as implemented by
>> mfd_add_devices().
>> 
>> I hope you can see that I am not violating any fundamental design
>> decissions here, but actually try adhere to them (resource management,
>> platform_device resource management, and mfd-core).

/Esben
