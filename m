From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 18 Nov 2016 17:34:45 +0100
Message-ID: <2364530.A9QSbaqvfm@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <2271602.GoSoby0zHK@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1F921858@lhreml507-mbx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F921858@lhreml507-mbx>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "liviu.dudau-5wv7dgnIgG8@public.gmane.org" <liviu.dudau-5wv7dgnIgG8@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "xuwei (O)" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "minyard-HInyCGIudOg@public.gmane.org" <minyard-HInyCGIudOg@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, zourongrong@gm
List-Id: linux-serial@vger.kernel.org

On Friday, November 18, 2016 4:18:07 PM CET Gabriele Paoloni wrote:
> From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> > On Friday, November 18, 2016 12:53:08 PM CET Gabriele Paoloni wrote:
> > > From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> > > > On Friday, November 18, 2016 12:07:28 PM CET Gabriele Paoloni
> > > > The easiest change compared to the v5 code would be to walk
> > > > a linked list of 'struct extio_ops' structures rather than
> > > > assuming there is only ever one of them. I think one of the
> > > > earlier versions actually did this.
> > >
> > > Right but if my understanding is correct if we live in a multi-
> > > domain I/O space world when you have an input addr in the I/O
> > > accessors this addr can be duplicated (for example for the standard
> > > PCI IO domain and for our special LPC domain).
> > > So effectively even if you walk a linked list there is a problem
> > > of disambiguation...am I right?
> > 
> > No, unlike the PCI memory space, the PIO addresses are not
> > usually distinct, i.e. every PCI bus has its own 64K I/O
> > addresses starting at zero. We linearize them into the
> > Linux I/O space using the per-domain io_offset value.
> 
> I am going to summarize my understanding here below:
> 
> It seems to me that what is linearized is the virtual address
> space associated to the IO address space. This address space
> goes from PCI_IOBASE to (PCI_IOBASE + IO_SPACE_LIMIT).
> 
> The I/O accessors perform rd/wr operation on this address
> space using a port IO token.
> 
> Each token map into a cpu physical address range
> Each cpu physical address range maps to a bus address range
> if the bus controller specifies a range property.
> 
> Devices under a bus controller specify the bus addresses that
> they operate on in their reg property.
> 
> So each device can use the same bus addresses under two
> separate bus controllers as long as the bus controller
> use the range properties to map the same bus range to different
> cpu address range. 

Sounds all correct to me so far, yes.

> > For the ISA/LPC spaces there are only 4k of addresses, they
> > the bus addresses always overlap, but we can trivially
> > figure out the bus address from Linux I/O port number
> > by subtracting the start of the range.
> 
> Are you saying that our LPC controller should specify a
> range property to map bus addresses into a cpu address range? 

No. There is not CPU address associated with it, because it's
not memory mapped.

Instead, we need to associate a bus address with a logical
Linux port number, both in of_address_to_resource and
in inb()/outb().

> > > > Another option the IA64 approach mentioned in another subthread
> > > > today, looking up the operations based on an index from the
> > > > upper bits of the port number. If we do this, we probably
> > > > want to do that for all PIO access and replace the entire
> > > > virtual address remapping logic with that. I think Bjorn
> > > > in the past argued in favor of such an approach, while I
> > > > advocated the current scheme for simplicity based on how
> > > > every I/O space these days is just memory mapped (which now
> > > > turned out to be false, both on powerpc and arm64).
> > >
> > > This seems really complex...I am a bit worried that possibly
> > > we end up in having the maintainers saying that it is not worth
> > > to re-invent the world just for this special LPC device...
> > 
> > It would clearly be a rather invasive change, but the
> > end-result isn't necessarily more complex than what we
> > have today, as we'd kill off the crazy pci_pio_to_address()
> > and pci_address_to_pio() hacks in address translation.
> 
> I have to look better into this...can you provide me a reference
> to the Bjorn argument in favor of this approach?

The thread seems to have been pci: Introduce pci_register_io_range()
helper function, e.g. in https://lkml.org/lkml/2014/7/8/969

> > > To be honest with you I would keep things simple for this
> > > LPC and introduce more complex reworks later if more devices
> > > need to be introduced.
> > >
> > > What if we stick on a single domain now where we introduce a
> > > reserved threshold for the IO space (say INDIRECT_MAX_IO).
> > 
> > I said having a single domain is fine, but I still don't
> > like the idea of reserving low port numbers for this hack,
> > it would mean that the numbers change for everyone else.
> 
> I don't get this much...I/O tokens that are passed to the I/O
> accessors are not fixed anyway and they vary depending on the order
> of adding ranges to io_range_list...so I don't see a big issue
> with this...

On machines with a legacy devices behind the PCI bridge,
there may still be a reason to have the low I/O port range
reserved for the primary bus, e.g. to get a VGA text console
to work.

On powerpc, this is called the "primary" PCI host, i.e. the
only one that is allowed to have an ISA bridge.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
