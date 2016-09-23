From: Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Fri, 23 Sep 2016 10:23:30 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8842B6@lhreml507-mbx>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <9178320.n4yHmfyPA3@wuerfel> <57E40665.8080005@gmail.com>
 <1760643.vMTR5o5E9g@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1760643.vMTR5o5E9g@wuerfel>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "zhichang.yuan" <zhichang.yuan02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "minyard-HInyCGIudOg@public.gmane.org" <minyard-HInyCGIudOg@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yuanzhichang <yuanzhichang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "xuwei (O)" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd-r2nGTMty4D4@public.gmane.org]
> Sent: 23 September 2016 10:52
> To: zhichang.yuan
> Cc: Gabriele Paoloni; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; minyard-HInyCGIudOg@public.gmane.org;
> linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; John Garry;
> will.deacon-5wv7dgnIgG8@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Yuanzhichang;
> Linuxarm; xuwei (O); linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; liviu.dudau-5wv7dgnIgG8@public.gmane.org;
> kantyzc-9Onoh4P/yGk@public.gmane.org
> Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Friday, September 23, 2016 12:27:17 AM CEST zhichang.yuan wrote:
> > For this patch sketch, I have a question.
> > Do we call pci_address_to_pio in arch_of_address_to_pio to get the
> > corresponding logical IO port
> > for LPC??
> 
> 
> No, of course not, that would be silly:
> 
> The argument to pci_address_to_pio() is a phys_addr_t, and we we don't
> have one because there is no address associated with your PIO, that
> is the entire point of your driver!
> 
> Also, we already know the mapping because this is what the inb/outb
> workaround is looking at, so there is absolutely no reason to call it
> either.

Ok assume that we do not call pci_address_to_pio() for the ISA bus...
The LPC driver will register its phys address range in io_range_list,
then the IPMI driver probe will retrieve its physical address calling
of_address_to_resource and will use the indirect io to access this
address.

>From the perspective of the indirect IO function the input parameter
is an unsigned long addr that (now) can be either:
1) an IO token coming from a legacy pci device
2) a phys address that lives on the LPC bus

These are conceptually two separate address spaces (and actually they 
both start from 0).

If the input parameter can live on different address spaces that are
overlapped, even if I save the used LPC range in arm64_extio_ops->start/end
there is no way for the indirect IO to tell if the input parameter is
an I/O token or a phys address that belongs to LPC...  

Am I missing something?

Thanks

Gab

> 
> > If we don't, it seems the LPC specific IO address will conflict with
> PCI
> > host bridges' logical IO.
> >
> > Supposed our LPC populated the IO range from 0x100 to 0x3FF( this is
> > normal for ISA similar
> > devices), after arch_of_address_to_pio(), the r->start will be set as
> > 0x100, r->end will be set as
> > 0x3FF.  And if there is one PCI host bridge who request a IO window
> size
> > over 0x400 at the same
> > time, the  corresponding r->start and r->end will be set as 0x0,
> 0x3FF
> > after of_address_to_resource
> > for this host bridge.  Then the IO conflict happens.
> 
> You would still need to reserve some space in the io_range_list
> to avoid possible conflicts, which is a bit ugly with the current
> definition of pci_register_io_range, but I'm sure can be done.
> 
> One way I can think of would be to change pci_register_io_range()
> to just return the logical port number directly (it already
> knows it!), and pass an invalid physical address (e.g.
> #define ISA_WORKAROUND_IO_PORT_WINDOW -0x10000) into it for
> invalid translations.
> 
> Another alternative that just occurred to me would be to move
> the pci_address_to_pio() call from __of_address_to_resource()
> into of_bus_pci_translate() and then do the special handling
> for the ISA/LPC bus in of_bus_isa_translate().
> 
> 	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
