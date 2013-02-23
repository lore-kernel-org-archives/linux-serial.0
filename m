From: Johan Hovold <jhovold@gmail.com>
Subject: Re: USB: serial: port lifetimes (was: Re: USB Ooops PL2303 when
 unplug while use (linux v3.7.3))
Date: Sat, 23 Feb 2013 17:34:05 +0100
Message-ID: <20130223163405.GD30855@localhost>
References: <20130222171157.GD6640@localhost>
 <Pine.LNX.4.44L0.1302221218270.1365-100000@iolanthe.rowland.org>
 <20130223162343.GC30855@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:49942 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758175Ab3BWQez (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Feb 2013 11:34:55 -0500
Content-Disposition: inline
In-Reply-To: <20130223162343.GC30855@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johan Hovold <jhovold@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, Feb 23, 2013 at 05:23:43PM +0100, Johan Hovold wrote:
> On Fri, Feb 22, 2013 at 12:35:32PM -0500, Alan Stern wrote:
> > > Yes, Peter noticed that one too. Changing the order shouldn't cause any
> > > new issues as far as I can see. I'll cook up a patch for this one as
> > > well, but just to be clear: this is not directly related to the problem
> > > discussed above as there may be outstanding tty references long after
> > > both functions return (not that anyone has claimed anything else).
> > 
> > This is related to the problem of the port's private data being
> > accessed after it is deallocated.  The only way that can happen is if
> > the tty layer calls the subdriver after the private data structure is
> > freed -- and you said above that this does happen.
> > 
> > But if change things so that the structure isn't freed until after the
> > port is unregistered from the tty layer, this would mean that the tty
> > layer is trying to do stuff to an unregistered port.  That would be a
> > bug in the tty layer.
> 
> Yes, I acknowledged that it is a bug, but it's not the one I'm
> triggering.

This was ambiguous. I meant to acknowledge that port_release should be
called after unregistration, but what I'm triggering is the different
bug that tty callbacks are made after unregistration (and proceed to
discuss whether this is indeed to be considered a bug in tty or
usb-serial below).

> I think the confusion stems from what tty_unregister_device actually
> implies. You seem to, and I used to, think that this calls works as a
> barrier so that no further tty callbacks can be made once it returns.
> However, this is not the case.
> 
> As long as there are outstanding tty refs, tty will happily call back
> even after tty_unregister_device returns. Unless we all agree that this
> a bug in tty, it's a bug in usb-serial which should instead defer
> unregistration until the last reference is dropped (but that gives us
> the broken uevents unless it could be worked around).
> 
> > I'm not saying such bugs don't exist.  However, if they do exist then 
> > the tty layer needs to be fixed, not the usb-serial layer.
> 
> Fair enough. 
> 
> Note also that we have at least two drivers on each side of this
> argument; ubs-serial unregistering at disconnect, and cdc-acm
> unregistering when the last tty ref is dropped. One of them must be
> wrong.
> 
> Johan
