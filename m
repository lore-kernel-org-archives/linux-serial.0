From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
Date: Thu, 13 Nov 2014 23:34:39 +0100
Message-ID: <3857076.lzkrNkraM9@wuerfel>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <4606459.kh8mb8TEgZ@wuerfel> <CAJiQ=7DoFk7ZSjHygaMWHyBTpxJFbQX4onh2xqixaqORQODsVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53243 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934447AbaKMWep (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Nov 2014 17:34:45 -0500
In-Reply-To: <CAJiQ=7DoFk7ZSjHygaMWHyBTpxJFbQX4onh2xqixaqORQODsVg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thursday 13 November 2014 11:08:08 Kevin Cernekee wrote:
> On Thu, Nov 13, 2014 at 1:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > TTY naming is a mess today, and you seem to be caught in the middle
> > of it trying to work around the inherent problems. Extending the PXA
> > driver is an interesting approach since as you say it's a very nice
> > clean subset of the 8250 driver, but that doesn't mean that it's
> > a good long-term strategy, as we will likely have more chips with
> > 8250 variants.
> >
> > Some of the ways forward that I can see are:
> >
> > - (your approach) use and extend the pxa serial driver for new SoCs,
> >   possibly migrate some of the existing users of 8250 to use that
> >   and leave 8250 alone.
> >
> > - fix the problem you see in a different way, and get the 8250 driver
> >   to solve your problem. Possibly integrate the pxa driver back into
> >   8250 in eventually, as we did with the omap driver.
> 
> Do you think it might make sense to come up with a set of guidelines
> that ensure that SoCs using a non-serial8250 driver (like pxa) on
> 16550-compatible hardware can be easily moved back to serial8250
> someday?
> 
> e.g. maybe I should be adding a reg-shift property to my pxa DT entry.
> It isn't necessary for pxa.c, but if we ever move to serial8250 it
> will be necessary.

I'm not sure how many others exist that are 8250-like with different
drivers. I think it would be a good idea to have the properties in
there, but I'm not sure if I can come up with an exhaustive list
of requirements.

> > - Do a fresh start for a general-purpose soc-type 8250 driver, using
> >   tty_port instead of uart_port as the abstraction layer.
> 
> Hmm, does that mean we can't use the serial_core.c helpers?

Correct. IIRC the consensus among the tty maintainers has been
for some time that serial_core.c and uart_port doesn't actually do
that much good compared to the complexity it adds in other places.
I may misremember the exact argument.

> >   Use that for
> >   all new socs instead of extending the 8250 driver more, possibly
> >   migrating some of the existing 8250 users.
> 
> One nice thing about a brand new driver is that we can use dynamic
> major/minor numbers unconditionally without breaking existing users.
> If either pxa.c or bcm63xx_uart.c had used dynamic numbers, I could
> drop Tushar's original workaround.
> 
> Another advantage is that we can assume all users have DT, simplifying
> the probe function.
> 
> Would it be helpful to split parts of pxa.c and/or serial8250 into a
> "lib8250", similar to libahci, that can be called by many different
> implementations (some of which have special features like DMA
> support)?

That sounds like a very good idea, yes. I had actually worked on something
in this area years ago, but haven't followed up in some time. In particular,
I think it makes sense to split the specific I/O register access method into
a separate library from the code that knows about the 8250 register set,
and from the code that performs the probing.

	Arnd
