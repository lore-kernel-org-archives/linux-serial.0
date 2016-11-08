From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Date: Wed, 09 Nov 2016 10:12:59 +1100
Message-ID: <1478646779.7430.66.camel@kernel.crashing.org>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
         <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
         <20161108114953.GB15297@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161108114953.GB15297@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-11-08 at 11:49 +0000, Mark Rutland wrote:
> 
> My understanding of ISA (which may be flawed) is that it's not part of
> the PCI host bridge, but rather on x86 it happens to share the IO space
> with PCI.

Sort-of. On some systems it actually goes through PCI and there's a
PCI->ISA bridge that uses substractive decoding to the legacy devices.

> So, how about this becomes:
> 
>   Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller, which
>   provides access to some legacy ISA devices.
> 
> I believe that we could theoretically have multiple independent LPC/ISA
> busses, as is possible with PCI on !x86 systems. If the current ISA code
> assumes a singleton bus, I think that's something that needs to be fixed
> up more generically.
> 
> I don't see why we should need any architecture-specific code here. Why
> can we not fix up the ISA bus code in drivers/of/address.c such that it
> handles multiple ISA bus instances, and translates all sub-device
> addresses relative to the specific bus instance?

What in that code prevents that today ?

Cheers,
Ben.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
