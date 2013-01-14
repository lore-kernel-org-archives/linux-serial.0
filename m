From: Greg KH <greg@kroah.com>
Subject: Re: Printf hangs when internal buffer of driver is temporarily full
Date: Mon, 14 Jan 2013 08:19:42 -0800
Message-ID: <20130114161942.GD14721@kroah.com>
References: <50F40403.9040000@septentrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:39581 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756464Ab3ANQUC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Jan 2013 11:20:02 -0500
Content-Disposition: inline
In-Reply-To: <50F40403.9040000@septentrio.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Philip Oberstaller <Philip.Oberstaller@septentrio.com>
Cc: linux-serial@vger.kernel.org

On Mon, Jan 14, 2013 at 02:11:31PM +0100, Philip Oberstaller wrote:
> Hi,
> 
> I'm writing a driver for the Exar's XR20M1280 SPI-based serial port
> using kernel version 3.4.17.

We can't take drivers for older kernel versions, why not write it for
3.8 and then backport it when finished?

> If a string, which is considerably longer than the driver's internal buffer
> (512 bytes), is written with printf/fprintf to the dedicated port, then the
> function call hangs after the driver's write_room function returns zero,
> which happens when the driver's internal buffer is temporarily full.
> I would have expected that the TTY layer or the libc implementation of
> printf would requery write_room automatically and thus would notice
> after a while that there is space again, but this doesn't seem to happen.

That's right, the printf call should return a "short" write, but really,
you should use write() and friends for tty ports, not fprintf, if at all
possible to handle this type of error better.

> Eventually the printf function returns after a very long timeout but without
> that the remaining characters have been printed.
> 
> I based my code mainly on the ifx6x60-driver and I looked at other similar
> drivers as well, but I can't see that they are using a different strategy.
> 
> In a dated driver book it was suggested that write_room and write should
> always return at least one. I could use busy waiting in the write function
> until there is space for at least one character, but I hope that there is
> a better solution around?!

I don't think so, sorry.

> This e-mail communication contains information that is confidential
> and may also be privileged.

<snip>

This type of footer really isn't good to have for public mailing list
posts, it directly goes against the fact that you sent this to thousands
of people in a public manner :)

thanks,

greg k-h
