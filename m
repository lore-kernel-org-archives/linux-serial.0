From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Date: Mon, 14 Nov 2016 11:11:11 +0000
Message-ID: <20161114111111.1b753dc3@lxorguk.ukuu.org.uk>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
        <2368890.jTbyGqYR0M@wuerfel>
        <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
        <5900275.i4NZvtxTcC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5900275.i4NZvtxTcC@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "zhichang.yuan" <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, minyard-HInyCGIudOg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, liviu.dudau-5wv7dgnIgG8@public.gmane.org, zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kantyzc-9Onoh4P/yGk@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org
List-Id: linux-serial@vger.kernel.org

> > It's not a safe assumption for x86 at least. There are a few systems with
> > multiple ISA busses particularly older laptops with a docking station.  
> 
> But do they have multiple ISA domains? There is no real harm in supporting
> it, the (small) downsides I can think of are:

I don't believe they x86 class ones have multiple ISA domains. But as
I've said I don't know how the electronics in the older ThinkPad worked
when it used two PIIX4s with some LPC or ISA stuff on each.

It works in DOS and unmodified Linux so I'm pretty sure there are no
additional domains. Likewise the various x86 schemes that route some bits
of ISA bus off into strange places work in DOS and don't have any
overlaps.

yenta_socket handles PCI/PCMCIA bridging and routes a range of that flat
ISA space appropriately to the card.

Alan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
