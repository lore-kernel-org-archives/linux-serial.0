From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: [PATCH] Documentation about RS485 serial communications
Date: Tue, 16 Nov 2010 16:28:21 +0000 (UTC)
Message-ID: <ibubf5$ev$1@dough.gmane.org>
References: <20100408111310.524f7354@lxorguk.ukuu.org.uk>
 <4CBD8EE4.5040808@evidence.eu.com> <i9ka0s$4ua$1@dough.gmane.org>
 <201010191727.53314.alexander.stein@systec-electronic.com>
 <i9kk4o$svc$1@dough.gmane.org> <4CC418A9.6090602@evidence.eu.com>
 <4CDA630F.4060903@atmel.com> <20101110172842.GC12371@suse.de>
 <4CDBC3EC.6020707@evidence.eu.com> <20101116143016.GB6527@ucw.cz>
 <AANLkTi=grehSnfWzCDtSXXmNb=-NAwbHHJ_P1XPyOuw8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58695 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754502Ab0KPQ2h (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Nov 2010 11:28:37 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1PIOOY-0002E3-F4
	for linux-serial@vger.kernel.org; Tue, 16 Nov 2010 17:28:34 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2010 17:28:34 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2010 17:28:34 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 2010-11-16, Matt Schulte <matts@commtech-fastcom.com> wrote:
> On Tue, Nov 16, 2010 at 8:30 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> Hi!
>>
>>> Documentation about RS485 serial communications
>>
>> I have seen hardware (kontron pmc-6l) that was capable of switching
>> between RS232, RS485 and one other standard by software.
>>
>> Is such hw common? If so, should we have standard interface?
>
> In my opinion this type of card is not that common.  Generally
> speaking the achievable baud rates for this type of multi-protocol
> card are very limited because of limitations of the transceiver chips.

I'm curious which selectable interface cards you're talking about that
are slow?  The ones I'm familiar with generally support baud rates up
to either 460K bps or 921K bps

> It seems that most of the time people would rather have a faster
> serial port than one that does several different voltages.

Where did you find a selectable interface serial card that couldn't
support high baud rates?

-- 
Grant Edwards               grant.b.edwards        Yow! Well, O.K.
                                  at               I'll compromise with my
                              gmail.com            principles because of
                                                   EXISTENTIAL DESPAIR!

