From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Thu, 13 Feb 2014 19:46:35 +0000 (UTC)
Message-ID: <ldj7er$ec0$1@ger.gmane.org>
References: <ldgte5$kp1$1@ger.gmane.org>
 <52FC1A14.5080004@hurleysoftware.com> <ldhaiq$jg$1@ger.gmane.org>
 <52FC427A.8050907@hurleysoftware.com> <ldhlpd$bbr$1@ger.gmane.org>
 <52FCE506.2040801@hurleysoftware.com> <ldj0o5$oq6$1@ger.gmane.org>
 <52FD0CD5.1050807@hurleysoftware.com> <ldj44p$4a0$1@ger.gmane.org>
 <52FD187C.8020604@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56136 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571AbaBMTrA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 14:47:00 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WE2FP-0002yt-A1
	for linux-serial@vger.kernel.org; Thu, 13 Feb 2014 20:46:59 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 20:46:59 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 20:46:59 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-02-13, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 02/13/2014 01:50 PM, Grant Edwards wrote:

>> For example, it turns out almost nobody on the planet uses IXANY. It
>> got left out of both our automated and manual regression testing, and
>> (embarassingly) it took 10+ years for somebody to realize that it
>> didn't work.  And that "somebody" was a customer that still had 2.4
>> kenels running in production machines.
>
> Not unusual. The N_TTY ldisc just had a bug fixed in 3.10 where
> turning off IXON with an already-stopped tty permanently hung the
> tty.

Yea, over the years, Xon/Xoff flow control is probably a larger source
of headaches than any other feature.  In fact, I think our serial core
drivers currently have to disable the UART's hardware Xon/Xoff
handling because the serial core API doesn't notify the driver when
the user makes a termios call to change the Xon/Xoff characters.  [Not
that anybody really uses that feature either...]

> We should extend the serial-core to add rx methods that work with
> your UARTs in their fastest and most native way. The idea behind
> serial-core is only to abstract the busy-work away from the i/o, not
> become an ill-fitting shoe that enforces The One True Way.

The prepare/push flip buffer API was pretty close to ideal.

It eliminates one set of buffer copy operations involved in the
room/insert/push method.  But, given the speed of in-memory buffer
copies, I doubt the difference is noticeable.

-- 
Grant Edwards               grant.b.edwards        Yow! for ARTIFICIAL
                                  at               FLAVORING!!
                              gmail.com            

