From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Date: Tue, 8 Nov 2016 17:10:04 +0000
Message-ID: <20161108171004.GF15297@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161108114953.GB15297@leverpostej>
 <2368890.jTbyGqYR0M@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2368890.jTbyGqYR0M@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 08, 2016 at 05:19:54PM +0100, Arnd Bergmann wrote:
> On Tuesday, November 8, 2016 11:49:53 AM CET Mark Rutland wrote:
> > My understanding of ISA (which may be flawed) is that it's not part of
> > the PCI host bridge, but rather on x86 it happens to share the IO space
> > with PCI.
> 
> On normal systems, ISA or LPC are behind a PCI bridge device, which
> passes down both low addresses of I/O space and memory space.

Ok, so the use of those address spaces is an artifact of the ISA
controller being a device under the PCI host bridge.

Given we can have multiple domains, surely that implies we can have
multiple ISA controllers in general?

> > I believe that we could theoretically have multiple independent LPC/ISA
> > busses, as is possible with PCI on !x86 systems. If the current ISA code
> > assumes a singleton bus, I think that's something that needs to be fixed
> > up more generically.
> > 
> > I don't see why we should need any architecture-specific code here. Why
> > can we not fix up the ISA bus code in drivers/of/address.c such that it
> > handles multiple ISA bus instances, and translates all sub-device
> > addresses relative to the specific bus instance?
> 
> I think it is a relatively safe assumption that there is only one
> ISA bridge. A lot of old drivers hardcode PIO or memory addresses
> when talking to an ISA device, so having multiple instances is
> already problematic.

I'm worried that this might not be a safe assumption. Hardware these
days has a habit of pushing the boundaries of our expectations.

If we're going to assume that, I'd certainly want the kernel to verify
that it's true for all instanciated ISA/LPC devices. Otherwise, I can
imagine people relying on (or working around) that assumption in ACPI
tables and DTs, and that will be a nightmare (at best) to untangle in
future.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
