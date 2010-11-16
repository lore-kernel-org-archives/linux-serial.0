From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: [PATCH] Documentation about RS485 serial communications
Date: Tue, 16 Nov 2010 15:52:11 +0000 (UTC)
Message-ID: <ibu9bb$k6c$1@dough.gmane.org>
References: <20101116143016.GB6527@ucw.cz>
 <A00955ACF1104CC28630FA1EAA4DF591@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59596 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab0KPPw1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Nov 2010 10:52:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1PINpa-0001tg-DE
	for linux-serial@vger.kernel.org; Tue, 16 Nov 2010 16:52:26 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2010 16:52:26 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 16 Nov 2010 16:52:26 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2010-11-16, Tosoni <jp.tosoni@acksys.fr> wrote:

>> I have seen hardware (kontron pmc-6l) that was capable of switching
>> between RS232, RS485 and one other standard by software.
>>
>> Is such hw common? If so, should we have standard interface?
>
> I believe it is neither common nor a good thing.

People who need multiple interface types disagree with you as to
whether it's a good thing or not.

> Dynamically switching between electrical levels means that the remote
> device must be capable of handling both electrical levels, else it
> might be damaged (i.e., when the serial card is configured to RS485
> but switches to RS232 when reset).

Nobody said anything about doing it "dynamically", and if you read the
manuals for the cards in question, it specifically says not to do
that. [Though if you look at the electrical specs for any reputable
RS485/422/232 driver/receiver you'll see that they're all spec'ed to
withstand that sort of thing without damage.]

The way it's done is that the card is installed, the ports are
configured, and then the cabling is hooked up.

> Or, different pins must be used for RS232 and RS485 (then software
> switching is not really useful).

That's not usually how it's done.

-- 
Grant Edwards               grant.b.edwards        Yow! Don't hit me!!  I'm in
                                  at               the Twilight Zone!!!
                              gmail.com            

