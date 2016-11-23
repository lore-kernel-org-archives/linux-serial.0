From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Wed, 23 Nov 2016 18:07:11 +0100
Message-ID: <2168980.T3HadihU3R@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com> <2359248.XjnRfPbj1B@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1F931E08@lhreml507-mbx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F931E08@lhreml507-mbx>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "liviu.dudau-5wv7dgnIgG8@public.gmane.org" <liviu.dudau-5wv7dgnIgG8@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "xuwei (O)" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "minyard-HInyCGIudOg@public.gmane.org" <minyard-HInyCGIudOg@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, zourongrong@gm
List-Id: linux-serial@vger.kernel.org

On Wednesday, November 23, 2016 3:22:33 PM CET Gabriele Paoloni wrote:
> From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> > On Friday, November 18, 2016 5:03:11 PM CET Gabriele Paoloni wrote:

> > > I think this is effectively what we are doing so far with patch 2/3.
> > > The problem with this patch is that we are carving out a "forbidden"
> > > IO tokens range that goes from 0 to PCIBIOS_MIN_IO.
> > >
> > > I think that the proper solution would be to have the LPC driver to
> > > set the carveout threshold used in pci_register_io_range(),
> > > pci_pio_to_address(), pci_address_to_pio(), but this would impose
> > > a probe dependency on the LPC itself that should be probed before
> > > the PCI controller (or before any other devices calling these
> > > functions...)
> > 
> > Why do you think the order matters? My point was that we should
> > be able to register any region of logical port numbers for any
> > bus here.
> 
> Maybe I have not followed well so let's roll back to your previous
> comment...
> 
> "we need to associate a bus address with a logical Linux port number,
> both in of_address_to_resource and in inb()/outb()"
> 
> Actually of_address_to_resource() returns the port number to used
> in inb/outb(); inb() and outb() add the port number to PCI_IOBASE
> to rd/wr to the right virtual address.

Correct.

> Our LPC cannot operate on the virtual address and it operates on
> a bus address range that for LPC is also equal to the cpu address
> range and goes from 0 to 0x1000.

There is no "cpu address" here, otherwise this is correct.

> Now as I understand it is risky and not appropriate to reserve
> the logical port numbers from 0 to 0x1000 or to whatever other
> upper bound because existing systems may rely on these port numbers
> retrieved by __of_address_to_resource().

Right again.

> In this scenario I think the best thing to do would be
> in the probe function of the LPC driver:
> 1) call pci_register_io_range() passing [0, 0x1000] (that is the
>    range for LPC)

pci_register_io_range() takes a physical address, not a port number,
so that would not be appropriate as you say above. We can however
add a variant that reserves a range of port numbers in io_range_list
for an indirect access method.

> 2) retrieve the logical port numbers associated to the LPC range
>    by calling pci_address_to_pio() for 0 and 0x1000 and assign
>    them to extio_ops_node->start and extio_ops_node->end

Again, calling pci_address_to_pio() doesn't seem right here, because
we don't have a phys_addr_t address

> 3) implement the LPC accessors to operate on the logical ports
>    associated to the LPC range (in practice in the accessors
>    implementation we will call pci_pio_to_address to retrieve
>    the cpu address to operate on)

Please don't proliferate the use of
pci_pio_to_address/pci_address_to_pio here, computing the physical
address from the logical address is trivial, you just need to
subtract the start of the range that you already use when matching
the port number range.

The only thing we need here is to make of_address_to_resource()
return the correct logical port number that was registered for
a given host device when asked to translate an address that
does not have a CPU address associated with it.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
