From: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
Date: Mon, 2 Mar 2015 10:57:41 -0800
Message-ID: <CAJiQ=7CDAifvcMkrAsseXHHC_GGMJg-+UiWVY03JAzDqSFzi+g@mail.gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <1416872182-6440-4-git-send-email-cernekee@gmail.com> <54F4624D.6000909@hurleysoftware.com>
 <CAJiQ=7DQ6CRWddii_9HZqH0a_1ixos6FBQRzb+HM+YAh1jmkBA@mail.gmail.com>
 <54F48B03.5040205@hurleysoftware.com> <CAJiQ=7CKE5Nw=maewN_ChkySh1NReoUnddLO_ohOJQfwo_FXAg@mail.gmail.com>
 <54F4A1B6.8030701@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54F4A1B6.8030701-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MIPS Mailing List <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 2, 2015 at 9:45 AM, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org> wrote:
>> This doesn't change the behavior of pre-existing drivers that
>> implement the *-endian properties in a different way.  There are not
>> many of these drivers and they can be documented as special cases.
>
> Yeah, ok, as long as there's no expectation that existing drivers
> meet this criteria when they add big-endian support.

The intention is to make it easy for existing drivers with LE register
accesses (i.e. mostly drivers taken from an x86 + PCI environment) to
work on systems with native to BE register accesses.  8250 and USB are
the first two examples of this.

>>> It's exactly this kind of stuff that prompted Jonathan Corbet's article,
>>> "Device trees as ABI"  http://lwn.net/Articles/561462
>>>
>>> Why not leave the default unspecified?
>>
>> The document aims to provide a consistent way of handling DT
>> endianness properties across (compliant) drivers.  It is confusing if
>> one new driver defaults to little-endian, and another new driver
>> defaults to native-endian.
>
> Ok. How many 4.0 driver + DT submissions that are native-endian are
> declaring this binding?
>
>
>> And since most of the commonly used drivers already implement
>> little-endian MMIO accesses, that is the default.  My personal
>> preference would have been native-endian since that seems more common
>> on the hardware side, but defaulting to little-endian prevents
>> breaking the device tree "ABI" on existing systems.
>
> That was basically my point; there's no way to meet these goals
> for existing, native-endian drivers without breakage (just as there
> would have been no way if native-endian had been the default).

I am not aware of any cases where the new binding needs to be applied
to a driver that is currently native-endian.  Grepping through the
tree for __raw_readl, I see lots of SoC-specific drivers but not a lot
of generic drivers shared by different types of platforms.  Most of
the time we can assume that whoever wrote the driver for their SoC has
figured out the endian situation.  But obviously there could be
exceptions, e.g. new chips using a different endian mode with the same
hardware block.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
