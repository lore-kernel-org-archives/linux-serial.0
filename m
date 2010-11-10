From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] pl011: added clock management feature
Date: Wed, 10 Nov 2010 09:00:58 -0800
Message-ID: <20101110170058.GB11947@suse.de>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com> <20101109224012.GA21992@kroah.com> <20101110000152.GA8993@n2100.arm.linux.org.uk> <0CBD3CD1188FB94093DB405A20CBCFBE06C5C4D8D2@EXMB01.eu.tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59118 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757046Ab0KJRAm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Nov 2010 12:00:42 -0500
Content-Disposition: inline
In-Reply-To: <0CBD3CD1188FB94093DB405A20CBCFBE06C5C4D8D2@EXMB01.eu.tieto.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grzegorz.Sygieda@tieto.com
Cc: linux@arm.linux.org.uk, greg@kroah.com, linus.walleij@stericsson.com, par-gunnar.p.hjalmdahl@stericsson.com, Lukasz.Rymanowski@tieto.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Nov 10, 2010 at 10:15:53AM +0200, Grzegorz.Sygieda@tieto.com wrote:
> >On Tue, Nov 09, 2010 at 02:40:12PM -0800, Greg KH wrote:
> >> On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
> >> > From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
> >> > 
> >> > This patch allows to control the pl011 clock using set_termios 
> >> > callback. Any positive baudrate passed enables clock, otherwise 
> >> > disables. This saves a lot of power on submicron designs since we 
> >> > can clock off and disable unused UARTs.
> >> 
> >> That's nice, but it seems like an overload of what people 
> >> traditionally think of when it comes to baud rates.  Why not just 
> >> power down ports that are not open instead?
> >
> >We already do.  My question to Linus (in a previous message) is why this isn't sufficient.
> 
> The main goal was to disable/enable clock while port open. This is
> usefull for scenario, where some higher level driver wants to control
> the power consumption (using set_termios). In the same time a
> user-space app (eg. hciattach) is still bounded to the specific
> /dev/tty* device associated with particular uart. From user POV device
> is always open, and app does not have to respawn, and we can save
> power.

That is nice, but again, you are overloading a common interface (one
defined by POSIX I think) to do something else at the same time.  That
might cause problems with some users that expect you to be able to use a
baud rate of 0 :)

I like the idea, but not the overloading, sorry.

thanks,

greg k-h
