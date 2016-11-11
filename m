From: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 11 Nov 2016 13:39:35 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8F900A@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <17821285.aIcTyCGn5n@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8F5D75@lhreml507-mbx>
 <10334260.ztLXZ2Oynd@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <10334260.ztLXZ2Oynd@wuerfel>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Yuanzhichang <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "minyard-HInyCGIudOg@public.gmane.org" <minyard-HInyCGIudOg@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuwei (O)" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "kantyzc-9Onoh4P/yGk@public.gmane.org" <kantyzc-9Onoh4P/yGk@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> Sent: 10 November 2016 16:07
> To: Gabriele Paoloni
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Yuanzhichang;
> mark.rutland-5wv7dgnIgG8@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; minyard-HInyCGIudOg@public.gmane.org; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; John Garry; will.deacon-5wv7dgnIgG8@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; xuwei (O); Linuxarm; zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; kantyzc-9Onoh4P/yGk@public.gmane.org; linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> catalin.marinas-5wv7dgnIgG8@public.gmane.org; olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org; liviu.dudau-5wv7dgnIgG8@public.gmane.org;
> bhelgaas@googl e.com; zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Thursday, November 10, 2016 3:36:49 PM CET Gabriele Paoloni wrote:
> >
> > Where should we get the range from? For LPC we know that it is going
> > Work on anything that is not used by PCI I/O space, and this is
> > why we use [0, PCIBIOS_MIN_IO]
> 
> It should be allocated the same way we allocate PCI config space
> segments. This is currently done with the io_range list in
> drivers/pci/pci.c, which isn't perfect but could be extended
> if necessary. Based on what others commented here, I'd rather
> make the differences between ISA/LPC and PCI I/O ranges smaller
> than larger.

I am not sure this would make sense...

IMHO all the mechanism around io_range_list is needed to provide the
"mapping" between I/O tokens and physical CPU addresses.

Currently the available tokens range from 0 to IO_SPACE_LIMIT.

As you know the I/O memory accessors operate on whatever
__of_address_to_resource sets into the resource (start, end).

With this special device in place we cannot know if a resource is
assigned with an I/O token or a physical address, unless we forbid
the I/O tokens to be in a specific range.

So this is why we are changing the offsets of all the functions
handling io_range_list (to make sure that a range is forbidden to
the tokens and is available to the physical addresses).

We have chosen this forbidden range to be [0, PCIBIOS_MIN_IO)
because this is the maximum physical I/O range that a non PCI device
can operate on and because we believe this does not impose much
restriction on the available I/O token range; that now is 
[PCIBIOS_MIN_IO, IO_SPACE_LIMIT].
So we believe that the chosen forbidden range can accommodate
any special ISA bus device with no much constraint on the rest
of I/O tokens...

> 
> > > Your current version has
> > >
> > >         if (arm64_extio_ops->pfout)                             \
> > >                 arm64_extio_ops->pfout(arm64_extio_ops->devpara,\
> > >                        addr, value, sizeof(type));             \
> > >
> > > Instead, just subtract the start of the range from the logical
> > > port number to transform it back into a bus-local port number:
> >
> > These accessors do not operate on IO tokens:
> >
> > If (arm64_extio_ops->start > addr || arm64_extio_ops->end < addr)
> > addr is not going to be an I/O token; in fact patch 2/3 imposes that
> > the I/O tokens will start at PCIBIOS_MIN_IO. So from 0 to
> PCIBIOS_MIN_IO
> > we have free physical addresses that the accessors can operate on.
> 
> Ah, I missed that part. I'd rather not use PCIBIOS_MIN_IO to refer to
> the logical I/O tokens, the purpose of that macro is really meant
> for allocating PCI I/O port numbers within the address space of
> one bus.

As I mentioned above, special devices operate on CPU addresses directly,
not I/O tokens. For them there is no way to distinguish....

> 
> Note that it's equally likely that whichever next platform needs
> non-mapped I/O access like this actually needs them for PCI I/O space,
> and that will use it on addresses registered to a PCI host bridge.

Ok so here you are talking about a platform that has got an I/O range
under the PCI host controller, right?
And this I/O range cannot be directly memory mapped but needs special
redirections for the I/O tokens, right?

In this scenario registering the I/O ranges with the forbidden range
implemented by the current patch would still allow to redirect I/O
tokens as long as arm64_extio_ops->start >= PCIBIOS_MIN_IO

So effectively the special PCI host controller
1) knows the physical range that needs special redirection
2) register such range
3) uses pci_pio_to_address() to retrieve the IO tokens for the
   special accessors
4) sets arm64_extio_ops->start/end to the IO tokens retrieved in 3)

So to be honest I think this patch can fit well both with
special PCI controllers that need I/O tokens redirection and with
special non-PCI controllers that need non-PCI I/O physical
address redirection...

Thanks (and sorry for the long reply but I didn't know how
to make the explanation shorter :) )

Gab

> 
> If we separate the two steps:
> 
> a) assign a range of logical I/O port numbers to a bus
> b) register a set of helpers for redirecting logical I/O
>    port to a helper function
> 
> then I think the code will get cleaner and more flexible.
> It should actually then be able to replace the powerpc
> specific implementation.
> 
> 	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
