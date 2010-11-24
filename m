From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: How to disable the transmit FIFO?
Date: Wed, 24 Nov 2010 14:56:55 +0000 (UTC)
Message-ID: <icj93m$9mh$1@dough.gmane.org>
References: <E1PJ0al-0000hs-Kb@palantir.moria.de>
 <20101118164122.GB2855@kroah.com> <E1PJAfx-0000gW-8e@palantir.moria.de>
 <ic40v4$ghm$1@dough.gmane.org> <20101119012523.GT3290@thunk.org>
 <E1PLEkX-0000u5-SZ@palantir.moria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43383 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088Ab0KXO5I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Nov 2010 09:57:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1PLGmQ-0005Sg-Rv
	for linux-serial@vger.kernel.org; Wed, 24 Nov 2010 15:57:06 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 24 Nov 2010 15:57:06 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Wed, 24 Nov 2010 15:57:06 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2010-11-24, Michael Haardt <michael@moria.de> wrote:
>> Specifically, if you use setserial to configure a serial port so that
>> its UART is a 16450, it will force the transmit FIFO to be unused.
>
> I tried that, but no change.  Sending a line of 21 characters to the port,
> I see only two trailing edges of CTS, which is consistent with receiving
> three characters by the SBC.  The other characters are sent and lost.
>
> The SBC on the other end clears RTS immediatly after receiving a
> character.  Linux may send one character at this moment, but that would
> be stored in the receiver buffer and the SBC only asserts RTS if the
> receiver buffer is empty.  Instead it sends multiple characters, flooding
> the SBC.

But the Linux box does eventually stop sending, but it takes too long
to stop?

It sounds like you need to buy a serial card that does RTS/CTS flow
control in hardware.

-- 
Grant Edwards               grant.b.edwards        Yow! This PORCUPINE knows
                                  at               his ZIPCODE ... And he has
                              gmail.com            "VISA"!!

