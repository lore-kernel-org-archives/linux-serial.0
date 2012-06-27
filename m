From: folkert <folkert@vanheusden.com>
Subject: Re: 2.6.25 upgraded to 2.6.36: serial app stops working
Date: Wed, 27 Jun 2012 22:26:54 +0200
Message-ID: <20120627202654.GI24858@belle.intranet.vanheusden.com>
References: <20101130162754.GI5654@belle.intranet.vanheusden.com>
 <20101130164232.GB18017@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from keetweej.vanheusden.com ([80.101.105.103]:38998 "EHLO
	keetweej.vanheusden.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab2F0Ugy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Jun 2012 16:36:54 -0400
Content-Disposition: inline
In-Reply-To: <20101130164232.GB18017@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

> > I upgraded my linux system to 2.6.36. Now suddenly my serial driver for
> > my MSF receiver stopped working. Two things I noticed: I need to open
> > the serial device (/dev/ttyS0, a regular uart, see below) with O_NDELAY
> > for open() to return at all. Then something funny happens: I read bytes
> > from the device (at 50bps) which runs fine for a while but then suddenly
> > I get a burst of '0x00' bytes - precisely at the point at which the MSF
> > radio device sends a timecode! So I think the device fiddles with one of
> > the pins of the serial port confusing the linux serial driver. This
> > worked fine upto and including 2.6.25 (maybe later too) but with 2.6.36
> > this fails.
> > Anyone an idea what might go wrong here? And how to fix it?
> 
> Any chance you could use 'git bisect' on the kernel tree to see what
> caused the change?  Moving from .25 to .36 is a huge jump, many many
> years of development and loads of things have changed so we need some
> help to narrow the problem down.

Hmmm, I might have missed this message :-)
Anyway a few months ago I retried it and had same problem. BUT: the
other receiver I have, has a serial-to-usb converter in it. So it is an
USB device but maybe a special one? Anyway: it has exact the same
problem. It is possible that maybe they're just broken both.
As you may deduct from my replying-delay, it has no great priority for
me.


Folkert van Heusden

-- 
http://www.vanheusden.com/sysopview/ - for the real sysop
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
