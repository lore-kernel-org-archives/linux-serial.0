From: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Date: Wed, 9 Nov 2016 14:51:01 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8F229A@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
        <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
        <20161108114953.GB15297@leverpostej>    <2368890.jTbyGqYR0M@wuerfel>
 <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161109135453.2e5402bd-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Yuanzhichang <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "minyard-HInyCGIudOg@public.gmane.org" <minyard-HInyCGIudOg@public.gmane.org>, benh-XVmvHMARGAQRh2imMr4xaA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

> -----Original Message-----
> From: One Thousand Gnomes [mailto:gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org]
> Sent: 09 November 2016 13:55
> To: Arnd Bergmann
> Cc: Mark Rutland; Yuanzhichang; catalin.marinas-5wv7dgnIgG8@public.gmane.org;
> will.deacon-5wv7dgnIgG8@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org;
> olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Linuxarm;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; minyard-HInyCGIudOg@public.gmane.org; benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org;
> liviu.dudau-5wv7dgnIgG8@public.gmane.org; zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; John Garry; Gabriele
> Paoloni; zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; kantyzc-9Onoh4P/yGk@public.gmane.org; xuwei (O);
> marc.zyngier-5wv7dgnIgG8@public.gmane.org
> Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
> special ISA
> 
> > I think it is a relatively safe assumption that there is only one
> > ISA bridge. A lot of old drivers hardcode PIO or memory addresses
> 
> It's not a safe assumption for x86 at least. There are a few systems
> with
> multiple ISA busses particularly older laptops with a docking station.

Mmmm right...now the point is that this kind of special devices appearing
as a special ISA bus will probably never appear on x86 platforms (I guess).

So maybe it is a safe assumption because of this...?

Thanks

Gab

> 
> > when talking to an ISA device, so having multiple instances is
> > already problematic.
> 
> PCMCIA devices handle it themselves so are ok. I'm not clear how the
> dual
> PIIX4 configuration used in the older IBM laptop docks actually worked
> so
> I assume the transaction went out of both bridges and providing one of
> them responded the other kept silent as you simply stuffed the card
> into
> the dock and it worked.
> 
> Alan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
