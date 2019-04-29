From: Esben Haabendal <esben@haabendal.dk>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
Date: Mon, 29 Apr 2019 11:29:05 +0200
Message-ID: <87ef5lxiqm.fsf@haabendal.dk>
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-2-esben@geanix.com>
        <20190426143946.GX9224@smile.fi.intel.com>
        <871s1og11u.fsf@haabendal.dk>
        <20190426215103.GD9224@smile.fi.intel.com>
        <87tvejakot.fsf@haabendal.dk>
        <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
        <87y33tz5oz.fsf@haabendal.dk>
        <CAHp75Vc6cLnLztXtvTcWisjAqDUTEWBBgv20CA34ZQmBEAvpbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc6cLnLztXtvTcWisjAqDUTEWBBgv20CA34ZQmBEAvpbA@mail.gmail.com>
        (Andy Shevchenko's message of "Mon, 29 Apr 2019 11:33:50 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, He Zhe <zhe.he@windriver.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Mon, Apr 29, 2019 at 9:27 AM Esben Haabendal <esben@haabendal.dk> wrote:
>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>> > On Sat, Apr 27, 2019 at 12:01 PM Esben Haabendal <esben@haabendal.dk> wrote:
>> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> >> > On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
>> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> >> >> The reason for this patch is to be able to do exactly that (set port
>> >> >> type and UPF_FIXED_TYPE) without having UPF_BOOT_AUTOCONF added.
>> >> >>
>> >> >> In the current serial8250_register_8250_port() there is:
>> >> >>
>> >> >>     uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
>> >> >>
>> >> >> So, even though I set UPF_FIXED_TYPE, I get
>> >> >> UPF_FIXED_TYPE|UPF_BOOT_AUTOCONF.
>> >> >
>> >> > Yes.
>> >> >
>> >> >> So I need this patch.
>> >> >
>> >> > Why? I don't see any problems to have these flags set.
>> >>
>> >> The problem with having UPF_BOOT_AUTOCONF is the call to
>> >> serial8250_request_std_resource().  It calls request_mem_region(), which
>> >> fails if the MFD driver already have requested the memory region for the
>> >> MFD device.
>> >
>> > If it's MFD, why it requested the region for its child?
>> > Isn't it a bug in MFD driver?
>>
>> It is a PCI driver, which calls pci_request_regions().  The PCI device
>> carries a lot of different functions, which uses small slices of the PCI
>> memory region(s).  With the resources being a tree structure, I don't
>> think it is a bug when a parent driver requests the entire memory
>> region.
>
> If it's MFD driver, it's not its business to do something
> child-related on child behalf.

The MFD driver is not doing anything on behalf of the child.  Being the
parent (MFD), it is requesting the memory region of the MFD/parent
device, using pci_request_regions(), similar to how it is done in
fx. janz-cmodio.c.

> In any case, Linux device resource model uses exclusive region
> slicing. If you do like above, you call for a problems.

Linux device resource model supports a parent/child/sibling
structure, specifically to allow for doing something like this.
Requesting memory resources are not restricted to use the iomem_resource
root.

For example, drivers/pcmcia/soc_common.c:soc_pcmcia_add_one()

	ret = request_resource(&iomem_resource, &skt->res_skt);
	if (ret)
		goto out_err_1;

	ret = request_resource(&skt->res_skt, &skt->res_io);
	if (ret)
		goto out_err_2;

As an example of a parent/child memory resource request.

The problem is that the 8250 driver only allows for requesting memory
region from the root (iomem_resource), as it uses a single
resource_size_t mapbase value for specifying the memory resource instead
of a full struct resource, which would allow passing in a parent.

So maybe we should go down that direction intead, extending 8250 driver
to replace mapbase with a resource struct instead?

> Btw, we have PCI MFD driver which enumerates 8250 (more precisely
> 8250_dw) w/o any issues.

I am aware of that (sm501.c).  It avoids the problem by not requesting
the parent memory region (sm->io_res), and requesting all child memory
regions directly in root instead of relative to the sm->io_res parent.

But as resoure management is designed for managing a parent/child
resource tree, this looks much more like a workaround than the right
solution.

>> It would be nice if child drivers requesting memory would pass the
>> parent memory resource.  Maybe 8250 driver could be changed to accept a
>> struct resource pointer instead of a simple mapbase value, allowing to
>> setup the resource with parent pointing to the MFD memory resource.
>
> I don't see the problem in certain driver, I guess you are trying to
> workaround existin Linux device resource model.

No, I actually try to do the right thing in relation to Linux device
resource model.  But 8250 is just not behaving very well in that
respect, not having been made really aware of the resource model.

And sm501.c MFD driver ignores the way resource model is designed, and
just make things work.

/Esben
