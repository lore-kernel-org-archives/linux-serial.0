From: folkert <folkert@vanheusden.com>
Subject: Re: 2.6.25 upgraded to 2.6.36: serial app stops working
Date: Tue, 7 Dec 2010 13:08:41 +0100
Message-ID: <20101207120840.GC22801@belle.intranet.vanheusden.com>
References: <20101130162754.GI5654@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from keetweej.vanheusden.com ([83.163.219.98]:43187 "EHLO
	keetweej.vanheusden.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab0LGMIo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Dec 2010 07:08:44 -0500
Received: from belle.intranet.vanheusden.com (belle.intranet.vanheusden.com [192.168.64.100])
	by keetweej.vanheusden.com (Postfix) with ESMTP id C264F8271
	for <linux-serial@vger.kernel.org>; Tue,  7 Dec 2010 13:08:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101130162754.GI5654@belle.intranet.vanheusden.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

> > I upgraded my linux system to 2.6.36. Now suddenly my serial driver
> > for
> > my MSF receiver stopped working. Two things I noticed: I need to open
> > the serial device (/dev/ttyS0, a regular uart, see below) with
> > O_NDELAY
> > for open() to return at all. Then something funny happens: I read
> > bytes
> > from the device (at 50bps) which runs fine for a while but then
> > suddenly
> > I get a burst of '0x00' bytes - precisely at the point at which the
> > MSF
> > radio device sends a timecode! So I think the device fiddles with one
> > of
> > the pins of the serial port confusing the linux serial driver. This
> > worked fine upto and including 2.6.25 (maybe later too) but with
> > 2.6.36
> > this fails.
> > Anyone an idea what might go wrong here? And how to fix it?

> Any chance you could use 'git bisect' on the kernel tree to see what
> caused the change?  Moving from .25 to .36 is a huge jump, many many
> years of development and loads of things have changed so we need some
> help to narrow the problem down.

Am looking for a way to do that: the original system has ext4
filesystems so .25 is a bit tricky. An other system (via Csomething)
crashes with .25.


Folkert van Heusden

-- 
Nagios user? Check out CoffeeSaint - the versatile Nagios status
viewer! http://www.vanheusden.com/java/CoffeeSaint/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
