From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH v4 1/3] serial: sh-sci: Add OF support
Date: Wed, 6 Mar 2013 11:19:12 +0100
Message-ID: <CABYn4szirgE7jy=49qCR3BuYd9jsWXJ=DrXeCqyuyGP0S2quiQ@mail.gmail.com>
References: <1362414054-23092-1-git-send-email-hechtb+renesas@gmail.com>
	<5345836.ZO7uU35cQD@wuerfel>
	<CABYn4sxYRbmEe27WKE-FbTZ3_SM+APaYqHJ1=Zrk8_a5czxZaQ@mail.gmail.com>
	<201303051926.25655.arnd@arndb.de>
	<20130306005009.GF14275@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:64508 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756557Ab3CFKTO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Mar 2013 05:19:14 -0500
In-Reply-To: <20130306005009.GF14275@linux-sh.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org

Hi all,

2013/3/6 Paul Mundt <lethal@linux-sh.org>:
> On Tue, Mar 05, 2013 at 07:26:25PM +0000, Arnd Bergmann wrote:
>> On Tuesday 05 March 2013, Bastian Hecht wrote:
>> > >> +- renesas,scbrr-algo-id : Algorithm ID for the Bit Rate Register
>> > >> +  1 = SCBRR_ALGO_1 ((clk + 16 * bps) / (16 * bps) - 1)
>> > >> +  2 = SCBRR_ALGO_2 ((clk + 16 * bps) / (32 * bps) - 1)
>> > >> +  3 = SCBRR_ALGO_3 (((clk * 2) + 16 * bps) / (16 * bps) - 1)
>> > >> +  4 = SCBRR_ALGO_4 (((clk * 2) + 16 * bps) / (32 * bps) - 1)
>> > >> +  5 = SCBRR_ALGO_5 (((clk * 1000 / 32) / bps) - 1)
>> > >
>> > > Maybe replace this with a "clock-frequency" property? This may
>> > > be what the registers contain, but it is not very readable.
>> >
>> > Hmm... do you want a frequency in absolute terms? And then calculate
>> > the best SCBRR value for it?
>> > I'm unsure about this, either you must exactly hit it or accept
>> > tolerances? As something in between I renamed the property to
>> > "renesas,clock-algorithm", but I don't know if this is what you want.
>>
>> I meant the absolute frequency in HZ, since that is what we do
>> for the 8250 uart and other devices, but only if that is sufficient
>> for your device.
>>
> No, we still need to figure out how to generate that baud rate, whether
> it needs an internal or external clock for driving the rate, etc. The
> frequency in and of itself doesn't provide this information, and various
> parts use different algorithms for factoring the baud rate generator,
> even varying across otherwise identical ports. It's unfortunately not
> possible to infer anything about the SCBRR algorithm from port type or
> specified baud rate.
>
> The algorithm IDs here are wholly arbitrary anyways, but are the
> variations I came up with from roughly 60-70 different CPUs.

So if we stick with the notion of the algrithm ID everything is settled now.

I will prepare a v6 that I will post as the whole patchset and an
additional incremental patch 1/3 from v3 to v6 for Paul's repo. Then
we can see if the SCBRR thing needs further discussion and if the rest
of the patchset is final.

Thanks to you all,

 Bastian
