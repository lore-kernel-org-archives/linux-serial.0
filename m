From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: Comments requested: driver for Quatech PCI serial cards
Date: Thu, 15 Nov 2012 09:40:54 +1030
Message-ID: <20121114231054.GC4505@marvin.atrad.com.au>
References: <20121114060724.GN30156@marvin.atrad.com.au>
 <20121114121222.3e42860f@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from server.atrad.com.au ([150.101.241.2]:37406 "EHLO
	server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945931Ab2KNXLL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Nov 2012 18:11:11 -0500
Content-Disposition: inline
In-Reply-To: <20121114121222.3e42860f@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, jwoithe@just42.net

On Wed, Nov 14, 2012 at 12:12:22PM +0000, Alan Cox wrote:
> >  - the name of the module.  Anything with "qt" in it will confuse people.
> >    I'm thinking along the lines of serial-quatech or quatech-serial:
> >    comments welcome.
> 
> qt is fine in kernel - just be careful of the qt usb module.

Ok.

> I think in the same place I'd start by just adding the needed identifiers
> to the 8250_pci driver along with any needed init helper.

Is this in relation to the proposed signal routing API?

> For the ioctls a lot appear to be just exposing values which as you say
> would fit sysfs. The tty layer now (as of 3.7rc) usefully supports sysfs
> nodes on a tty itself too.

Do I take it from this that the sysfs route is the only way this driver is
likely to get merged?  If that's the case the configuration binaries
supplied by Quatech (which are not opensource unfortunately) will not be
compatible with the new driver, necessitating the writing of new replacement
userspace utilities.

> As far as I can see the issues are
> 
> 1.	Clock multiplier feature
> 
> Supportable by flags in 8250.c and worst case by providing a custom
> set_termios. No API needed.
> 
> 2.	RS485/RS422 options
> 
> Supportable by adding TIOCRS485 handling/callout to 8250.c (needs doing
> anyway)

Based on this, is it fair to say that the driver in its current basic form
(clean-ups notwithstanding) cannot be considered for inclusion in mainline?
While time allows me to do cleanups to the existing code, porting the
functionality to totally different mechanisms (ie: away from ioctl) is
unfortunately not something I would have the time for now (mostly because I
would first have to learn those other interfaces).  My employer would simply
say to find another card, unless there were existing examples of this sort
of usage which I can use as a template.

The DSC-200/300 card (which is what I have) was initially preferred for a
new design because we've used it in other non-Linux systems in the past.  We
don't want to be stuck with maintaining an out-of-tree driver to facilitate
this though, so mainlining it is the only feasible route to us using it in
our upcoming system.  I'm guessing that the difficulties with the driver as
it's currently structured may have been the reason it was never pushed to
mainline by the original author in 2007.

> The RS485 ioctl might need some extending but we've been gradually doing
> this as we hit chips with more features in hardware ...

As far as I know the Quatech cards in question do RS422 but not explicitly
RS485 (that is, their specification doesn't mention RS485).  But I take it
that "RS485 ioctl" is what would be used to control additional RS422
features as well.

Regards
  jonathan
