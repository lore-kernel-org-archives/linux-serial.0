From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: What does the 0x0F char from serial port signify??
Date: Fri, 1 Aug 2003 10:03:04 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030801140304.GC24027@think>
References: <750102E9-C37E-11D7-BB0C-000A959AFBBA@marisys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from thunk.org ([140.239.227.29]:3761 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S270764AbTHAOD2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Aug 2003 10:03:28 -0400
Content-Disposition: inline
In-Reply-To: <750102E9-C37E-11D7-BB0C-000A959AFBBA@marisys.net>
List-Id: linux-serial@vger.kernel.org
To: Joshua Colvin <jcolvin@marisys.net>
Cc: linux-serial@vger.kernel.org

On Thu, Jul 31, 2003 at 01:43:12PM -0400, Joshua Colvin wrote:
> 
> Hello all,
> I'm trying to setup a socket connection to a serial port under Linux. 
> When talking to the device
> on the other end of the serial port I get an SI (shift in) character 
> (hex value 0x0f, octal value 017)
> embedded in the response. So rather than get "RESPONSE" I get 
> "RESP\017ONSE". It happens
> like clockwork, same place, every time. While it COULD be the device on 
> the other end (it's 3rd
> party closed source proprietary), I seriously doubt it. I've been 
> playing with the termios settings
> when configuring the serial port to no avail.

It's the device on the other end.  The Serial driver doesn't insert
characters into input stream except under very well defined
circumstances (specifically PARMRK setting), and 017 isn't one of the
characters in volved.

> The closest I could find to the meaning of this character is an 
> additional character set code and is
> controlled by IEXTEN or VDISCARD. However setting or clearing either of 
> these has no effect. Does
> anyone have any insight as to what this??

^O is the default binding to the VDISCARD character, yes.  What this
means is that if IEXTEN is set, whatever character c_cc[VDISCARD] is
set to is treated as a "flush command".  The character is not passed
on to the user mode program, and any characters batched for output to
the tty are flushed.  

If you set the tty device to raw mode, all special characters (^S, ^C,
^O, etc.) are ignored, and even if they weren't ignored, if the device
was sending them, you wouldn't be seeing them since the tty would be
treating those characters as special commands (to stop the flow out of
ouput, to send a SIGINT to the foreground process, to flush tty
output, etc.).

I'm afraid this is part of what your device is doing.  If it's not
documented, complain to your vendor.  If your vendor refuses to give
you documentation, refuse to do business with the vendor, and switch
to someone who will actually give you documentation for the hardware
that they are trying to sell to you....

							- Ted
