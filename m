From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Thu, 13 Feb 2014 18:50:01 +0000 (UTC)
Message-ID: <ldj44p$4a0$1@ger.gmane.org>
References: <ldgte5$kp1$1@ger.gmane.org>
 <52FC1A14.5080004@hurleysoftware.com> <ldhaiq$jg$1@ger.gmane.org>
 <52FC427A.8050907@hurleysoftware.com> <ldhlpd$bbr$1@ger.gmane.org>
 <52FCE506.2040801@hurleysoftware.com> <ldj0o5$oq6$1@ger.gmane.org>
 <52FD0CD5.1050807@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54214 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaBMSua (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 13:50:30 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WE1Mi-0000SS-JY
	for linux-serial@vger.kernel.org; Thu, 13 Feb 2014 19:50:28 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 19:50:28 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 19:50:28 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-02-13, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> I must be missing something.
>>>
>>> tty_buffer_request_room() returns a buffer suitable for data + flags;
>>> you're just misreading the code.
>>
>> Great!
>>
>> That solves my problem.  I can call tty_buffer_request_room(), read
>> the indicated number of chars or char/flag pairs and then depend on
>> being able to call _either_ tty_insert_flip_string() or
>> tty_insert_flip_string_flags() to transfer the data I read.
>
> Yep.

Problem is solved.  Or rather more accurately: Problem was imaginary.

>>> I don't mean to be critical but I can't really see that development
>>> model being sustainable.
>>
>> We've been doing it for 20+ years (though I've only been involved for
>> the last 15).  We can't beat the Chinese on the price of boards, so we
>> had better beat them on support.
>
> Just trying to be helpful.

I realize that and I appreciate it.

> Please don't take my comments as an attack on either your business
> model or your development processes;

Of course not.

> I don't know enough about either to criticize.

Nonsense, this is the internet!

>>> There's no realistic way to single-source a driver across hundreds of
>>> kernel versions.
>>
>> Maybe not hundreds.  Our current drivers only support 2.6.24 and
>> later.  We can still support previous driver versions if required for
>> customers running older 2.6 kernels.  We officially stopped
>> supporting 2.4 several years ago.
>
> By "support", do you mean "add new features" or "workaround hardware
> bugs"?

Both.  "New features" mostly meant support for new models, but there
were also some actual new features and fixes for old ones that didn't
work.  For example, it turns out almost nobody on the planet uses
IXANY. It got left out of both our automated and manual regression
testing, and (embarassingly) it took 10+ years for somebody to realize
that it didn't work.  And that "somebody" was a customer that still
had 2.4 kenels running in production machines.


>>> [ For my own edification, why is the driver not a serial mini-port? ]
>>
>> I don't know what a serial mini-port is.  We recently transitioned
>> two of our drivers from being tty drivers to being serial-core
>> drivers. Is mini-port something different that the serial core?
>
> No, same thing.

Ah, good.

>> For another driver, it's still a tty driver because the serial-core
>> API just didn't fit the device well enough to make it work.  One
>> issue I recall is that our driver for that device needs to be able to
>> cause specific error returns for write() calls that are made when the
>> hardware is unavailable (and I think there are different errors
>> depending on why it's unavailable).
>
> And this is the driver that uses tty_flip_* interface directly?

Well, they all do (under some circumstances). AFAICT, the method
provided by serial core is uart_insert_char().  When we initially
moved from tty driver to serial driver, we did everything in the 
simplest, most obvious way (e.g. uart_insert_char()).  But we moved
away from that for performance reasons.  Our hardware is optimized for
transferring data to/from continuous buffers using 32-bit bus cycles
rather than reading/writing characters one at a time.  At one point in
history our drivers would use inline assembly to execute a single
machine instruction to write an entire block of tx data to the
hardware or read an entire block of data from the hardware.  There
were also some prototypes that did bus-master DMA for rx/tx data, but
that turned out to be more overhead than programmed I/O, and it was
abandoned.  Now that CPU speeds have increased so much faster than bus
speeds, the inline assembly is no longer needed, but making a function
call for every rx byte is still enough to use an alarming amount of
CPU time.

-- 
Grant Edwards               grant.b.edwards        Yow! I'm reporting for duty
                                  at               as a modern person.  I want
                              gmail.com            to do the Latin Hustle now!

