From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial/8250: Increase number of serial ports to 32
Date: Wed, 10 Nov 2010 16:52:29 -0800
Message-ID: <20101111005229.GF22463@kroah.com>
References: <4CDAA41F.1060402@visionsystems.de> <20101110160851.GA10708@kroah.com> <AANLkTi=_RNAxSK_uVsVeO87w0HbUZWhKSgsbyHPnt-BN@mail.gmail.com> <20101110192853.GA16140@kroah.com> <AANLkTi=BzM4xYL2Y-OP+sHhWDXu56c7B+MMDrbEwO0Sr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:35036 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757697Ab0KKAyN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Nov 2010 19:54:13 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=BzM4xYL2Y-OP+sHhWDXu56c7B+MMDrbEwO0Sr@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: Yegor Yefremov <yegor_sub1@visionsystems.de>, linux-serial@vger.kernel.org

On Wed, Nov 10, 2010 at 03:28:24PM -0600, Matt Schulte wrote:
> On Wed, Nov 10, 2010 at 1:28 PM, Greg KH <greg@kroah.com> wrote:
> > On Wed, Nov 10, 2010 at 01:10:51PM -0600, Matt Schulte wrote:
> >> On Wed, Nov 10, 2010 at 10:08 AM, Greg KH <greg@kroah.com> wrote:
> >> > On Wed, Nov 10, 2010 at 02:54:39PM +0100, Yegor Yefremov wrote:
> >> >> This will make sure that multiple serial port cards can be
> >> >> used out of the box. Otherwise the user must pass
> >> >> nr_uarts parameter, that will be often forgotten and increases
> >> >> support requests for serial card vendors.
> >> >
> >> > Has this really happened in the past? ?What is the downside of changing
> >> > this option that has been around for many years now? ?Also note that
> >> > multi-port serial cards are more rare these days than they used to be so
> >> > changing this seems a bit pointless now.
> >> >
> >>
> >> Multiport serial cards are not dead, we still sell bunches. ?This is
> >> one of those problems that really frustrates our customers. ?They want
> >> their ports to show up by default and the only way to do it is to
> >> recompile the kernel or modify the boot line. ?A lot of my customers
> >> don't like the 82510.nr_uarts work around in grub and so we have to
> >> hold their hands while they figure out how to recompile the kernel
> >> with support for more ports. ?I think the default number of ports
> >> should definitely be changed from 4 to at least 8, maybe even 16 or
> >> 32.
> >
> > Why not work with the distros to get it changed? ?If we change the
> > default within the kernel, it's still not going to change what they are
> > using at all, so you will still be having the same problem you are
> > today.
> 
> Don't you think changing it here would eventually propagate down the
> chain to all of the distros?  Or do you think they would ignore the
> change up here?

Speaking as someone who has maintained a distro kernel for a long time
now, it would be totally ignored as it would never show up on their
radar.  Only new options get questioned (i.e. ones that show up when
running 'make oldconfig'), old ones are left alone.

sorry,

greg k-h
