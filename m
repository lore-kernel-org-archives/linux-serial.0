From: Joshua Colvin <jcolvin@marisys.net>
Subject: Re: What does the 0x0F char from serial port signify??
Date: Fri, 1 Aug 2003 13:59:11 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <DAFF3185-C449-11D7-83CC-000A959AFBBA@marisys.net>
References: <20030801140304.GC24027@think>
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [66.203.135.146] ([66.203.135.146]:22533 "EHLO
	grampus.marisys.net") by vger.kernel.org with ESMTP id S270855AbTHAR7Y
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Aug 2003 13:59:24 -0400
In-Reply-To: <20030801140304.GC24027@think>
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org

Thanks Ted for the great explanation. I am able to confirm that it is 
the device on
the other end, after much hair-pulling. It seems intentionally done, 
perhaps to
persuade people to use their SW, rather than develop their own. Knowing 
it is in
fact coming from their device and it's not a misconfiguration on my end 
let's me
deal with the problem.

Thanks again for the help!
Josh


On Friday, August 1, 2003, at 10:03  AM, Theodore Ts'o wrote:

> On Thu, Jul 31, 2003 at 01:43:12PM -0400, Joshua Colvin wrote:
>>
>> Hello all,
>> I'm trying to setup a socket connection to a serial port under Linux.
>> When talking to the device
>> on the other end of the serial port I get an SI (shift in) character
>> (hex value 0x0f, octal value 017)
>> embedded in the response. So rather than get "RESPONSE" I get
>> "RESP\017ONSE". It happens
>> like clockwork, same place, every time. While it COULD be the device 
>> on
>> the other end (it's 3rd
>> party closed source proprietary), I seriously doubt it. I've been
>> playing with the termios settings
>> when configuring the serial port to no avail.
>
> It's the device on the other end.  The Serial driver doesn't insert
> characters into input stream except under very well defined
> circumstances (specifically PARMRK setting), and 017 isn't one of the
> characters in volved.
>
>> The closest I could find to the meaning of this character is an
>> additional character set code and is
>> controlled by IEXTEN or VDISCARD. However setting or clearing either 
>> of
>> these has no effect. Does
>> anyone have any insight as to what this??
>
> ^O is the default binding to the VDISCARD character, yes.  What this
> means is that if IEXTEN is set, whatever character c_cc[VDISCARD] is
> set to is treated as a "flush command".  The character is not passed
> on to the user mode program, and any characters batched for output to
> the tty are flushed.
>
> If you set the tty device to raw mode, all special characters (^S, ^C,
> ^O, etc.) are ignored, and even if they weren't ignored, if the device
> was sending them, you wouldn't be seeing them since the tty would be
> treating those characters as special commands (to stop the flow out of
> ouput, to send a SIGINT to the foreground process, to flush tty
> output, etc.).
>
> I'm afraid this is part of what your device is doing.  If it's not
> documented, complain to your vendor.  If your vendor refuses to give
> you documentation, refuse to do business with the vendor, and switch
> to someone who will actually give you documentation for the hardware
> that they are trying to sell to you....
>
> 							- Ted

