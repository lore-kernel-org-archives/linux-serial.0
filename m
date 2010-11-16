From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: [PATCH] Documentation about RS485 serial communications
Date: Tue, 16 Nov 2010 19:29:12 +0000 (UTC)
Message-ID: <ibum28$oa2$1@dough.gmane.org>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>
 <4CBD8EE4.5040808@evidence.eu.com> <i9ka0s$4ua$1@dough.gmane.org>
 <201010191727.53314.alexander.stein@systec-electronic.com>
 <i9kk4o$svc$1@dough.gmane.org> <4CC418A9.6090602@evidence.eu.com>
 <4CDA630F.4060903@atmel.com> <20101110172842.GC12371@suse.de>
 <4CDBC3EC.6020707@evidence.eu.com> <20101116143016.GB6527@ucw.cz>
 <AANLkTi=grehSnfWzCDtSXXmNb=-NAwbHHJ_P1XPyOuw8@mail.gmail.com>
 <ibubf5$ev$1@dough.gmane.org>
 <AANLkTimio1aBh5w616eSikW+dujV-G8_pu-AT=B5e-7Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58098 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753696Ab0KPT31 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Nov 2010 14:29:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1PIRDY-0008P6-Sl
	for linux-serial@vger.kernel.org; Tue, 16 Nov 2010 20:29:24 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2010 20:29:24 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2010 20:29:24 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 2010-11-16, Matt Schulte <matts@commtech-fastcom.com> wrote:

>>> In my opinion this type of card is not that common. ?Generally
>>> speaking the achievable baud rates for this type of multi-protocol
>>> card are very limited because of limitations of the transceiver
>>> chips.
>>
>> I'm curious which selectable interface cards you're talking about
>> that are slow? ?The ones I'm familiar with generally support baud
>> rates up to either 460K bps or 921K bps
>>
>>> It seems that most of the time people would rather have a faster
>>> serial port than one that does several different voltages.
>>
>> Where did you find a selectable interface serial card that couldn't
>> support high baud rates?
>
> In my world 460kbps for an RS422 card is slow.  RS422 cards generally
> push multi megabit/s rates.

Ah, I see.  That's a completely different market than the markets
served by the multi-interface cards that typically max out at 921K.
I've support multi-interface cards for years and years, and I find it
very rare that anybody uses anything much faster than 19.2K.

-- 
Grant Edwards               grant.b.edwards        Yow! TAILFINS!! ... click
                                  at               ...
                              gmail.com            

