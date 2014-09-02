From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/1] drivers: introduce ARM SBSA generic UART driver
Date: Tue, 02 Sep 2014 21:34:43 +0200
Message-ID: <2856634.LN9gbfSP9v@wuerfel>
References: <1409328803-1953-1-git-send-email-andre.przywara@arm.com> <3749748.k4a1nSHDdj@wuerfel> <CAL_JsqKGbSd5BymnFhT8KBjbBCPO8wsrHhG9Qn20c7mrrxTDDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62457 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbaIBTew (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Sep 2014 15:34:52 -0400
In-Reply-To: <CAL_JsqKGbSd5BymnFhT8KBjbBCPO8wsrHhG9Qn20c7mrrxTDDA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andre Przywara <andre.przywara@arm.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Tuesday 02 September 2014 12:38:23 Rob Herring wrote:
> On Tue, Sep 2, 2014 at 8:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 02 September 2014 08:20:53 Rob Herring wrote:
> >> >>
> >> >> This alone is not okay. There is no such implementation of hardware.
> >> >
> >> > But the SBSA explicitly allows this. I don't know of any vendor who just
> >> > implements the subset, but I've been told that this has been asked for.
> >>
> >> To use baudrate as an example, that must be configurable somehow
> >> either with pl011 registers or in a vendor specific way. I suppose you
> >> could do an actual implementation with all those things hardcoded in
> >> the design, but that seems unlikely.
> >
> > Why does the baudrate need to be configurable? I think it's completely
> > reasonable to specify a console port that has a fixed (as in the
> > OS must not care) rate, and that can be implemented either as a UART
> > with a programmable rate or as a set of registers that directly talks
> > to a remote system management device over whatever hardware protocol
> > they choose.
> 
> Sure. It is also completely reasonable that baudrate is configurable
> and vendors can implement it however they choose since the SBSA does
> not specify it. IIRC, the enabling and disabling bits are not
> specified either.
> 
> Not having configurability is simply one variation on possible
> implementations.

It's not obvious to me though that we are served better by a
pl011 driver that allows any possible subset of the features,
rather than having the existing driver for pl011, and a new driver
for the sbsa subset, which then won't allow any of the optional
features.

Yes, there is some duplication, but a driver for this kind of
dumb console port should be doable in very little code, at
least less than the proposed implementation.

	Arnd
