From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Sat, 24 Sep 2016 23:00:40 +0200
Message-ID: <2866656.cISrGNv8pP@wuerfel>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com> <1849232.KJrfRPHGN6@wuerfel> <05a573de-e963-6590-6ed3-55af97067d7a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <05a573de-e963-6590-6ed3-55af97067d7a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: zhichang <zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "minyard-HInyCGIudOg@public.gmane.org" <minyard-HInyCGIudOg@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yuanzhichang <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "xuwei (O)" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Saturday, September 24, 2016 4:14:15 PM CEST zhichang wrote:
> 
> In V3, the outb is :
> 
> void outb(u8 value, unsigned long addr)
> {
>         if (!arm64_extio_ops || arm64_extio_ops->start > addr ||
>                         arm64_extio_ops->end < addr)
>                 writeb(value, PCI_IOBASE + addr);
>         else
>                 if (arm64_extio_ops->pfout)
>                         arm64_extio_ops->pfout(arm64_extio_ops->devpara,
>                                 addr + arm64_extio_ops->ptoffset, &value,
>                                 sizeof(u8), 1);
> }
> 
> here, arm64_extio_ops->ptoffset is the offset between the real legacy IO address
> and the logical IO address, similar to the offset of primary address and
> secondary address in PCI bridge.

Ok, though we can probably simplify this by making the assumption that
'ptoffset' is the negative of 'start', as the bus we register should
always start at port zero.

> But in V3, LPC driver call pci_address_to_pio to request the logical IO as PCI
> host bridge during its probing.

Right, so this still needs to be fixed.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
