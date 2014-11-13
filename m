From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for
 BCM7xxx set-top platforms
Date: Thu, 13 Nov 2014 11:08:08 -0800
Message-ID: <CAJiQ=7DoFk7ZSjHygaMWHyBTpxJFbQX4onh2xqixaqORQODsVg@mail.gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
 <3356477.HitZEsNa4H@wuerfel> <CAJiQ=7AFr5vR+FEc8B3CAZLb5GYujNxtaz7TU2FU0D3oModZ7w@mail.gmail.com>
 <4606459.kh8mb8TEgZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:38399 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbaKMTIa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Nov 2014 14:08:30 -0500
In-Reply-To: <4606459.kh8mb8TEgZ@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Nov 13, 2014 at 1:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> TTY naming is a mess today, and you seem to be caught in the middle
> of it trying to work around the inherent problems. Extending the PXA
> driver is an interesting approach since as you say it's a very nice
> clean subset of the 8250 driver, but that doesn't mean that it's
> a good long-term strategy, as we will likely have more chips with
> 8250 variants.
>
> Some of the ways forward that I can see are:
>
> - (your approach) use and extend the pxa serial driver for new SoCs,
>   possibly migrate some of the existing users of 8250 to use that
>   and leave 8250 alone.
>
> - fix the problem you see in a different way, and get the 8250 driver
>   to solve your problem. Possibly integrate the pxa driver back into
>   8250 in eventually, as we did with the omap driver.

Do you think it might make sense to come up with a set of guidelines
that ensure that SoCs using a non-serial8250 driver (like pxa) on
16550-compatible hardware can be easily moved back to serial8250
someday?

e.g. maybe I should be adding a reg-shift property to my pxa DT entry.
It isn't necessary for pxa.c, but if we ever move to serial8250 it
will be necessary.

> - Do a fresh start for a general-purpose soc-type 8250 driver, using
>   tty_port instead of uart_port as the abstraction layer.

Hmm, does that mean we can't use the serial_core.c helpers?

>   Use that for
>   all new socs instead of extending the 8250 driver more, possibly
>   migrating some of the existing 8250 users.

One nice thing about a brand new driver is that we can use dynamic
major/minor numbers unconditionally without breaking existing users.
If either pxa.c or bcm63xx_uart.c had used dynamic numbers, I could
drop Tushar's original workaround.

Another advantage is that we can assume all users have DT, simplifying
the probe function.

Would it be helpful to split parts of pxa.c and/or serial8250 into a
"lib8250", similar to libahci, that can be called by many different
implementations (some of which have special features like DMA
support)?
