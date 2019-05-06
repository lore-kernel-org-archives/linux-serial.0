From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
Date: Mon, 06 May 2019 17:46:56 +0200
Message-ID: <87ef5boaa7.fsf@haabendal.dk>
References: <20190430140416.4707-1-esben@geanix.com>
        <20190430153736.GL9224@smile.fi.intel.com>
        <874l6efxta.fsf@haabendal.dk>
        <20190502104556.GS9224@smile.fi.intel.com>
        <87pnp11112.fsf@haabendal.dk>
        <20190502153124.GA9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502153124.GA9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Thu, 2 May 2019 18:31:24 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

>> > On Wed, May 01, 2019 at 09:17:37AM +0200, Esben Haabendal wrote:
>> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> >
>> >> > Hmm... Currently it's done inside individual port drivers, like 8250_dw.c.
>> >> > Each of the drivers can do it differently, for example 8250_lpss.c or
>> >> > 8250_pnp.c.
>> >> 
>> >> So, you would prefer to create a new "specialized" port driver that uses
>> >> platform resources?  I am not doing anything else different from
>> >> the generic port driver here in 8250_core.c.
>> >
>> > If it's required and using serial8250 directly is not enough.
>> 
>> Sorry, I am not sure what you mean by that.
>
> The serial8250 is the name of (generic) platform driver of 8250 which can be
> used as a child for MFD.

The last part is only true, if you don't let MFD manage the memory
resources, which is the main thing that MFD is doing.

As an example, the sm501.c driver, the only driver in drivers/mfd/ which
uses serial8250 driver, does not use any code from mfd-core.
Incidentally, it is 1 year older than mfd-core.c, and as never been
refactored to use mfd-core functionality.

>> >> > I think I understand what is a confusion here.
>> >> >
>> >> > For the IO resources we have two operations:
>> >> > - mapping / re-mapping (may be shared)
>> >> > - requesting (exclusive)
>> >> >
>> >> > In the parenthesis I put a level of access to it. While many device
>> >> > drivers can *share* same resource (mapped or unmapped), the only one
>> >> > can actually request it.
>> >> 
>> >> Mostly true.  But there is an important twist to the exclusive restriction.
>> >> 
>> >> The exclusive part of the request is limited to the the same root/parent
>> >> resource.
>> >> 
>> >> When you request a memory resource from the root resource
>> >> (iomem_resource), the resource returned can be used as a new parent
>> >> resource.  This new parent can then be used to give exclusive access to
>> >> slices of that resource.  When used like that, I expect that the parent
>> >> resource is not supposed to be used for anything else than honoring
>> >> resource requests.
>> >> 
>> >> And this is exactly what mfd-core uses the mem_base argument
>> >> in mfd_add_devices().
>> >> 
>> >> > So, the parent can take an slice resources as it would be
>> >> > appropriated, but not requesting them.
>> >> 
>> >> The parent is not and should not be doing that by itself.  The request
>> >> is done on by mfd-core when mfd_add_devices() is called.
>> >
>> > No, MFD *does not* (and actually *may not* in order to allow standalone drivers
>> > to be used as children w/o modifications) request resources. It just passes
>> > them to children as parent suggested.
>> 
>> In drivers/mfd/mfd-core.c:mfd_add_device() :
>> 
>>         for (r = 0; r < cell->num_resources; r++) {
>>                 res[r].name = cell->resources[r].name;
>>                 res[r].flags = cell->resources[r].flags;
>> 
>>                 /* Find out base to use */
>>                 if ((cell->resources[r].flags & IORESOURCE_MEM) && mem_base) {
>>                         res[r].parent = mem_base;
>>                         res[r].start = mem_base->start +
>>                                 cell->resources[r].start;
>>                         res[r].end = mem_base->start +
>>                                 cell->resources[r].end;
>>                 } else if (cell->resources[r].flags & IORESOURCE_IRQ) {
>>                         if (domain) {
>>                                 /* Unable to create mappings for IRQ ranges. */
>>                                 WARN_ON(cell->resources[r].start !=
>>                                         cell->resources[r].end);
>>                                 res[r].start = res[r].end = irq_create_mapping(
>>                                         domain, cell->resources[r].start);
>>                         } else {
>>                                 res[r].start = irq_base +
>>                                         cell->resources[r].start;
>>                                 res[r].end   = irq_base +
>>                                         cell->resources[r].end;
>>                         }
>>                 } else {
>>                         res[r].parent = cell->resources[r].parent;
>>                         res[r].start = cell->resources[r].start;
>>                         res[r].end   = cell->resources[r].end;
>>                 }
>> 
>>                 if (!cell->ignore_resource_conflicts) {
>>                         if (has_acpi_companion(&pdev->dev)) {
>>                                 ret = acpi_check_resource_conflict(&res[r]);
>>                                 if (ret)
>>                                         goto fail_alias;
>>                         }
>>                 }
>>         }
>> 
>>         ret = platform_device_add_resources(pdev, res, cell->num_resources);
>> 
>> This creates the child resources.  Whether we call that requesting the
>> resources or not, is a matter of word.  But it is what it is.  When it
>> is done, you cannot use request_mem_region() for those memory resources,
>> they are now locked/exclusive for the mfd parent *and* for the
>> respective mfd child device.
>
> Why not? Again, *slicing* resources is OK and that's what MFD for, *requesting*
> them in the parent is not.

Why we cannot use request_mem_region() for those memory resources again?
It fails because the resources are now already owned the mfd driver, on
behalf of the child.

>> In order to use them, child devices simply use platform_get_resource(),
>> and everything works nicely.  It works fine for normal (non-mfd)
>> devices, as they get (requests) the resources from the root resource
>> (iomem_resource), and works fine for mfd devices as well.  So no changes
>> are needed for drivers to work with mfd.
>> 
>> Whether you call the thing that mfd_add_device() does for "request
>> resources" or just "pass them to children" is a matter of words.
>
> Nope, *requesting* resources as you mentioned lock them to the certain user.

I still think there is some confusion in relation to your use of the
word "requesting".  There is no explicit request/lock action in
kernel/resource.c.

There are basically only two steps involved in resource management in
kernel/resource.c:
1. You create a struct resource.
2. You add it to the child list of another resource.

Requesting a reasource is just another word for 2.  And
request_mem_region() is just a that, hardcoded to the iomem_resource
struct.

And mfd_add_device() implements step 2 for the resources included in the
cell.resources field.  The purpose is a generic resource slicing
implementation, and is also what you call requesting.

>> The mfd (parent) has a resource which it cuts up into slices for its
>> children, and these slices are passed to the child devices.  The
>> drivers for these child devices must then pickup the resource(s)
>> using platform_get_resource().  At no point is any "request_*"
>> function called.
>> 
>> Looking at in another way.
>> 
>> The request_mem_region() macro call __request_resource(), which which
>> simply creates a new 'struct resource' in the iomem_resource resource.
>> 
>> In mfd_add_device(), almost the same happens.  A new 'struct resource'
>> is created in the mem_base resource.
>> 
>> In both cases, a 'struct resource' is created, representing exclusive
>> access to the resource.  And like it or not, this is something that MFD
>> already *do*, and I think it is way out of scope of this patch to change
>> that.
>> 
>> I just try to make serial8250 driver work nicely in that (mfd) context,
>> without changing how mfd is working.
>
> There is nothing to change. It's already working. I don't see a problem here.

No.  It is not working.

Why are you saying that?  There is no existing usage of the serial8250
driver in combination of mfd_add_devices().  And it cannot be done with
the current serial8250 driver, as it will fail in the
request_mem_region() call.

I really think it is a shame if we cannot use mfd-core for mfd drivers
that just happens to need serial8250 driver.

/Esben
