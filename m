From: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
Date: Wed, 9 Nov 2016 12:10:43 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8F1A7A@lhreml507-mbx>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-4-git-send-email-yuanzhichang@hisilicon.com>
 <1555494.4IFvGxvsfe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1555494.4IFvGxvsfe@wuerfel>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Yuanzhichang <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "minyard-HInyCGIudOg@public.gmane.org" <minyard-HInyCGIudOg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> Sent: 08 November 2016 16:25
> To: Yuanzhichang
> Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Linuxarm; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; minyard-HInyCGIudOg@public.gmane.org;
> benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; liviu.dudau-5wv7dgnIgG8@public.gmane.org; zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> John Garry; Gabriele Paoloni; zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> kantyzc-9Onoh4P/yGk@public.gmane.org; xuwei (O)
> Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Tuesday, November 8, 2016 11:47:09 AM CET zhichang.yuan wrote:
> > +       /*
> > +        * The first PCIBIOS_MIN_IO is reserved specifically for
> indirectIO.
> > +        * It will separate indirectIO range from pci host bridge to
> > +        * avoid the possible PIO conflict.
> > +        * Set the indirectIO range directly here.
> > +        */
> > +       lpcdev->io_ops.start = 0;
> > +       lpcdev->io_ops.end = PCIBIOS_MIN_IO - 1;
> > +       lpcdev->io_ops.devpara = lpcdev;
> > +       lpcdev->io_ops.pfin = hisilpc_comm_in;
> > +       lpcdev->io_ops.pfout = hisilpc_comm_out;
> > +       lpcdev->io_ops.pfins = hisilpc_comm_ins;
> > +       lpcdev->io_ops.pfouts = hisilpc_comm_outs;
> 
> I have to look at patch 2 in more detail again, after missing a few
> review
> rounds. I'm still a bit skeptical about hardcoding a logical I/O port
> range here, and would hope that we can just go through the same
> assignment of logical port ranges that we have for PCI buses,
> decoupling
> the bus addresses from the linux-internal ones.

The point here is that we want to avoid any conflict/overlap between
the LPC I/O space and the PCI I/O space. With the assignment above
we make sure that LPC never interfere with PCI I/O space.

Thanks

Gab

> 
> 	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
