From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 14 Mar 2007 13:44:11 +0100
Message-ID: <m3slc8c7vo.fsf@maximus.localdomain>
References: <001d01c76629$06da71a0$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:41068 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161224AbXCNMoN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Mar 2007 08:44:13 -0400
In-Reply-To: <001d01c76629$06da71a0$2e01a8c0@acksys.local> (Tosoni's message of "Wed, 14 Mar 2007 12:07:58 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tosoni <jp.tosoni@acksys.fr>
Cc: linux-serial@vger.kernel.org

"Tosoni" <jp.tosoni@acksys.fr> writes:

>> A flag alone is no help for half-duplex devices, they would need
>> a complete handshaking code.
>
> Not true.
> This is also the view of the former maintainer of drivers/serial.

It's just reality. If your IC in question does this in hardware
- fine, but you still have to support it in the driver, adding
a #define XXX doesn't help.

"Code talks".

> But
> obviously neither of you used half duplex devices before.

This is your "not true". I was using them, though they weren't
modems.

> There is no need for handshake, since half duplex is used in master/slave
> situations.

Not necesarily, there are CSMA/CD-style designs as well as token-ring
style.

> And I can insure you, that Windows handles this very well, using
> only the above-mentioned RTS_TOGGLE flag.

That means the DCE does all the buffering and handshaking. I'd say
it's not common, most devices are simpler.
-- 
Krzysztof Halasa
