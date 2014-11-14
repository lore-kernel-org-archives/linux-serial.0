From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
Date: Fri, 14 Nov 2014 22:07:39 +0100
Message-ID: <87ioihtrs4.fsf@free.fr>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
	<3356477.HitZEsNa4H@wuerfel>
	<CAJiQ=7AFr5vR+FEc8B3CAZLb5GYujNxtaz7TU2FU0D3oModZ7w@mail.gmail.com>
	<4606459.kh8mb8TEgZ@wuerfel>
	<CAJiQ=7DoFk7ZSjHygaMWHyBTpxJFbQX4onh2xqixaqORQODsVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:25774 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbaKNVHx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2014 16:07:53 -0500
In-Reply-To: <CAJiQ=7DoFk7ZSjHygaMWHyBTpxJFbQX4onh2xqixaqORQODsVg@mail.gmail.com>
	(Kevin Cernekee's message of "Thu, 13 Nov 2014 11:08:08 -0800")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Kevin Cernekee <cernekee@gmail.com> writes:

> On Thu, Nov 13, 2014 at 1:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> TTY naming is a mess today, and you seem to be caught in the middle
>> of it trying to work around the inherent problems. Extending the PXA
>> driver is an interesting approach since as you say it's a very nice
>> clean subset of the 8250 driver, but that doesn't mean that it's
>> a good long-term strategy, as we will likely have more chips with
>> 8250 variants.
>>
>> Some of the ways forward that I can see are:
>>
>> - (your approach) use and extend the pxa serial driver for new SoCs,
>>   possibly migrate some of the existing users of 8250 to use that
>>   and leave 8250 alone.
>>
>> - fix the problem you see in a different way, and get the 8250 driver
>>   to solve your problem. Possibly integrate the pxa driver back into
>>   8250 in eventually, as we did with the omap driver.
>
> Do you think it might make sense to come up with a set of guidelines
> that ensure that SoCs using a non-serial8250 driver (like pxa) on
> 16550-compatible hardware can be easily moved back to serial8250
> someday?

At least for the pxa part, I'd see it with a very supportive eye to move the pxa
serial driver to a 8250 based one. Most of the code should be in something
common AFAIK, it's not pxa specific. Only the erratas, specific interrupt and
register handling could be left in pxa serial driver.

I had a look at 8250_core driver and 8250.h api. If that could be used for pxa,
or something similar, it would be great.

And same thing goes for probing and registering, most of the things are probably
common.

>> - Do a fresh start for a general-purpose soc-type 8250 driver, using
>>   tty_port instead of uart_port as the abstraction layer.
Ah, that where others input would be good. I wonder if we should ask Russell
too, a lot of the files around have his name in the header ...

>>   Use that for
>>   all new socs instead of extending the 8250 driver more, possibly
>>   migrating some of the existing 8250 users.
>
> One nice thing about a brand new driver is that we can use dynamic
> major/minor numbers unconditionally without breaking existing users.
> If either pxa.c or bcm63xx_uart.c had used dynamic numbers, I could
> drop Tushar's original workaround.
>
> Another advantage is that we can assume all users have DT, simplifying
> the probe function.
In that later case, I won't let pxa fully migrate to it, as platform users won't
be gone in the mid-term. I don't really want to have 2 different drivers (one DT
and the legacy one) for pxa either. I'd rather have an approach where pxa, in
both device-tree and platform devices, will use some common code, would that
code be in a library, an API, ...

> Would it be helpful to split parts of pxa.c and/or serial8250 into a
> "lib8250", similar to libahci, that can be called by many different
> implementations (some of which have special features like DMA
> support)?
That's certainly one solution I would support. What removes code to shift it to
a shared common code is what I wish.

Cheers.

-- 
Robert
