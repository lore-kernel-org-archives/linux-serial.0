From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/1] drivers: introduce ARM SBSA generic UART driver
Date: Tue, 02 Sep 2014 15:48:06 +0200
Message-ID: <3749748.k4a1nSHDdj@wuerfel>
References: <1409328803-1953-1-git-send-email-andre.przywara@arm.com> <540596A6.8000608@arm.com> <CAL_Jsq+Rs5MXC7s7EeWAEAPxxqaShAVGt=cdQxud5Us+-Zp6jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:58927 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbaIBNsP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Sep 2014 09:48:15 -0400
In-Reply-To: <CAL_Jsq+Rs5MXC7s7EeWAEAPxxqaShAVGt=cdQxud5Us+-Zp6jw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robherring2@gmail.com>, Andre Przywara <andre.przywara@arm.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Tuesday 02 September 2014 08:20:53 Rob Herring wrote:
> >>
> >> This alone is not okay. There is no such implementation of hardware.
> >
> > But the SBSA explicitly allows this. I don't know of any vendor who just
> > implements the subset, but I've been told that this has been asked for.
> 
> To use baudrate as an example, that must be configurable somehow
> either with pl011 registers or in a vendor specific way. I suppose you
> could do an actual implementation with all those things hardcoded in
> the design, but that seems unlikely.

Why does the baudrate need to be configurable? I think it's completely
reasonable to specify a console port that has a fixed (as in the
OS must not care) rate, and that can be implemented either as a UART
with a programmable rate or as a set of registers that directly talks
to a remote system management device over whatever hardware protocol
they choose.

> >> The DT must specify the implementation such as pl011.
> >
> > If it is a full featured PL011: sure. Then we don't need this driver at
> > all and just use the SBSA UART spec as a guideline for our earlycon
> > implementation.
> > I will try to learn if there is someone actually implementing only the
> > subset.
> 
> I would have assumed you knew someone is. Otherwise, I don't really
> think anything should be implemented at this point. Perhaps adding
> SBSA uart as an explicit earlycon option would be worthwhile. Also, we
> should consider using ttySx instead of ttyAMAx for SBSA compliant
> systems (including ones with pl011).

What about systems that have both a SBSA debug port and a 8250
compatible UART? That sounds like a very realistic hardware design
choice for someone coming from an older x86/powerpc/mips/... chip
that has 8250 and adds the extra port for SBSA compliance.

	Arnd
