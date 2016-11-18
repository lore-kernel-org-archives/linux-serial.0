From: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 18 Nov 2016 12:53:08 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F921283@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <2281986.miqFuFkAbO@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F921146@lhreml507-mbx>
 <2822893.F0LqNAm9bT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2822893.F0LqNAm9bT@wuerfel>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "liviu.dudau-5wv7dgnIgG8@public.gmane.org" <liviu.dudau-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Yuanzhichang <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "minyard-HInyCGIudOg@public.gmane.org" <minyard-HInyCGIudOg@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuwei (O)" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt@kerne>
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> Sent: 18 November 2016 12:24
> To: Gabriele Paoloni
> Cc: liviu.dudau-5wv7dgnIgG8@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> Yuanzhichang; mark.rutland-5wv7dgnIgG8@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; minyard-HInyCGIudOg@public.gmane.org; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; John Garry; will.deacon-5wv7dgnIgG8@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; xuwei (O); Linuxarm; zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; kantyzc-9Onoh4P/yGk@public.gmane.org; linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> catalin.marinas-5wv7dgnIgG8@public.gmane.org; olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org; bhelgaas@go og le.com;
> zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Jason Gunthorpe; Thomas Petazzoni
> Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Friday, November 18, 2016 12:07:28 PM CET Gabriele Paoloni wrote:
> > > From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> > > On Monday, November 14, 2016 11:26:25 AM CET liviu.dudau-5wv7dgnIgG8@public.gmane.org
> wrote:
> > > > On Mon, Nov 14, 2016 at 08:26:42AM +0000, Gabriele Paoloni wrote:
> > > > > > Nope, that is not what it means. It means that PCI devices
> can
> > > see I/O
> > > > > > addresses
> > > > > > on the bus that start from 0. There never was any usage for
> non-
> > > PCI
> > > > > > controllers
> > > > >
> > > > > So I am a bit confused...
> > > > > From http://www.firmware.org/1275/bindings/isa/isa0_4d.ps
> > > > > It seems that ISA buses operate on cpu I/O address range [0,
> > > 0xFFF].
> > > > > I thought that was the reason why for most architectures we
> have
> > > > > PCIBIOS_MIN_IO equal to 0x1000 (so I thought that ISA
> controllers
> > > > > usually use [0, PCIBIOS_MIN_IO - 1] )
> > > >
> > > > First of all, cpu I/O addresses is an x86-ism. ARM architectures
> and
> > > others
> > > >  have no separate address space for I/O, it is all merged into
> one
> > > unified
> > > > address space. So, on arm/arm64 for example, PCIBIOS_MIN_IO = 0
> could
> > > mean
> > > > that we don't care about ISA I/O because the platform does not
> > > support having
> > > > an ISA bus (e.g.).
> > >
> > > I think to be more specific, PCIBIOS_MIN_IO=0 would indicate that
> you
> > > cannot
> > > have a PCI-to-ISA or PCI-to-LPC bridge in any PCI domain. This is
> > > different
> > > from having an LPC master outside of PCI, as that lives in its own
> > > domain
> > > and has a separately addressable I/O space.
> >
> > Yes correct so if we go for the single domain solution arch that
> > have PCIBIOS_MIN_IO=0 cannot support special devices such as LPC
> > unless we also redefine PCIBIOS_MIN_IO, right?
> 
> This is what I was referring to below as the difference between
> a) and b): Setting PCIBIOS_MIN_IO=0 means you cannot have LPC
> behind PCI, but it shouldn't stop you from having a separate
> LPC bridge.
> 
> > > The PCIBIOS_MIN_DIRECT_IO name still suggests having something
> related
> > > to
> > > PCIBIOS_MIN_IO, but it really isn't. We are talking about multiple
> > > concepts here that are not the same but that are somewhat related:
> > >
> > > a) keeping PCI devices from allocating low I/O ports on the PCI bus
> > >    that would conflict with ISA devices behind a bridge of the
> > >    same bus.
> > >
> > > b) reserving the low 0x0-0xfff range of the Linux-internal I/O
> > >    space abstraction to a particular LPC or PCI domain to make
> > >    legacy device drivers work that hardcode a particular port
> > >    number.
> > >
> > > c) Redirecting inb/outb to call a domain-specific accessor function
> > >    rather than doing the normal MMIO window for an LPC master or
> > >    more generally any arbitrary LPC or PCI domain that has a
> > >    nonstandard I/O space.
> > >    [side note: actually if we generalized this, we could avoid
> > >     assigning an MMIO range for the I/O space on the pci-mvebu
> > >     driver, and that would help free up some other remapping
> > >     windows]
> > >
> > > I think there is no need to change a) here, we have PCIBIOS_MIN_IO
> > > today and even if we don't need it, there is no obvious downside.
> > > I would also argue that we can ignore b) for the discussion of
> > > the HiSilicon LPC driver, we just need to assign some range
> > > of logical addresses to each domain.
> > >
> > > That means solving c) is the important problem here, and it
> > > shouldn't be so hard.  We can do this either with a single
> > > special domain as in the v5 patch series, or by generalizing it
> > > so that any I/O space mapping gets looked up through the device
> > > pointer of the bus master.
> >
> > I am not very on the "generalized" multi-domain solution...
> > Currently the IO accessors prototypes have an unsigned long addr
> > as input parameter. If we live in a multi-domain IO system
> > how can we distinguish inside the accessor which domain addr
> > belongs to?
> 
> The easiest change compared to the v5 code would be to walk
> a linked list of 'struct extio_ops' structures rather than
> assuming there is only ever one of them. I think one of the
> earlier versions actually did this.

Right but if my understanding is correct if we live in a multi-
domain I/O space world when you have an input addr in the I/O
accessors this addr can be duplicated (for example for the standard
PCI IO domain and for our special LPC domain).
So effectively even if you walk a linked list there is a problem
of disambiguation...am I right? 

> 
> Another option the IA64 approach mentioned in another subthread
> today, looking up the operations based on an index from the
> upper bits of the port number. If we do this, we probably
> want to do that for all PIO access and replace the entire
> virtual address remapping logic with that. I think Bjorn
> in the past argued in favor of such an approach, while I
> advocated the current scheme for simplicity based on how
> every I/O space these days is just memory mapped (which now
> turned out to be false, both on powerpc and arm64).

This seems really complex...I am a bit worried that possibly
we end up in having the maintainers saying that it is not worth
to re-invent the world just for this special LPC device...

To be honest with you I would keep things simple for this
LPC and introduce more complex reworks later if more devices
need to be introduced.

What if we stick on a single domain now where we introduce a
reserved threshold for the IO space (say INDIRECT_MAX_IO).

We define INDIRECT_MAX_IO as 0 in "include/linux/extio.h" and
we define INDIRECT_MAX_IO as 0x1000 in "arch/arm64/include/asm/io.h"

So effectively this threshold can change according to the
architecture and so far we only define it for ARM64 as we need
it for ARM64...

Thoughts?

Thanks again

Gab

> 
> 	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
