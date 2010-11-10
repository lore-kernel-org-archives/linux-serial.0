From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial/8250: Increase number of serial ports to 32
Date: Wed, 10 Nov 2010 09:33:03 -0800
Message-ID: <20101110173303.GA12830@kroah.com>
References: <4CDAA41F.1060402@visionsystems.de> <20101110160851.GA10708@kroah.com> <4CDAD02F.9080109@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:54527 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215Ab0KJReL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Nov 2010 12:34:11 -0500
Content-Disposition: inline
In-Reply-To: <4CDAD02F.9080109@visionsystems.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: linux-serial@vger.kernel.org

On Wed, Nov 10, 2010 at 06:02:39PM +0100, Yegor Yefremov wrote:
> Am 10.11.2010 17:08, schrieb Greg KH:
> > On Wed, Nov 10, 2010 at 02:54:39PM +0100, Yegor Yefremov wrote:
> >> This will make sure that multiple serial port cards can be
> >> used out of the box. Otherwise the user must pass
> >> nr_uarts parameter, that will be often forgotten and increases
> >> support requests for serial card vendors.
> > Has this really happened in the past?
> 
> It is still the case. The most requests that we get are "the card
> doesn't function under Ubuntu...". After examining dmesg one could see
> that 8250 driver is initialized with 4 UARTS.
> 
> There are also lots of questions and bugs concerning this subject.
> Like this one:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/125524. I even
> found some entries from 2010:
> http://www.gnulinux.in/forum/4-port-serial-card-installation-fedora-11

Then get the distro to change the default setting of their kernels.

> > What is the downside of changing
> > this option that has been around for many years now?  Also note that
> > multi-port serial cards are more rare these days than they used to be so
> > changing this seems a bit pointless now.
> 
> I can say that those cards are still selling. They're not dead.
> 
> The downside is that those card are not working out of the box and
> users not experienced in Linux often miss this parameter. Also some
> Live Linuxes like Ubuntu (perhaps I missed something) don't provide
> command line parameter, so you have to reload the driver with proper
> parameter.
> 
> I understand that it is somehow a responsibility of distribution
> maintainers to properly configure the kernel, but I hope that if
> vanilla kernel would increase default value, then they will also
> follow.

I doubt it as they would never notice that the value changed at all
(they run 'make oldconfig').  So please just work with the distros that
you are having problems with to get the value changed.

thanks,

greg k-h
