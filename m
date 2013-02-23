From: Johan Hovold <jhovold@gmail.com>
Subject: Re: USB: serial: port lifetimes (was: Re: USB Ooops PL2303 when
 unplug while use (linux v3.7.3))
Date: Sat, 23 Feb 2013 19:12:25 +0100
Message-ID: <20130223181225.GE30855@localhost>
References: <20130223162343.GC30855@localhost>
 <Pine.LNX.4.44L0.1302231204100.4433-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:57947 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab3BWSNP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Feb 2013 13:13:15 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1302231204100.4433-100000@netrider.rowland.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johan Hovold <jhovold@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, Feb 23, 2013 at 12:31:47PM -0500, Alan Stern wrote:
> On Sat, 23 Feb 2013, Johan Hovold wrote:
> > I'm not primarily concerned with deallocation, and perhaps my choice of
> > wording was misleading when I use "pinning" in reference to the device
> > hierarchy and unregistration. I was basically asking whether it is
> > possible to defer unregistration of the interface (parent device) until
> > the last tty reference is dropped.
> 
> > > Unregistration should not be deferred.  We mustn't have those broken 
> > > devpaths.
> > 
> > And here is your answer it seems.
> 
> Right.  More precisely, registration mustn't be deferred _and_ we
> mustn't have any broken devpaths.  Currently usb-serial gets one of
> these wrong and cdc-acm gets the other one wrong.

Maybe I misunderstand you, but it seems to me that ubs-serial gets both
right and cdc-acm both wrong, as non-deferred registration guarantees
non-broken uevent devpaths?

The uevent devpaths from cdc-acm are usually correct, but an outstanding
tty ref when disconnect returns would break them (as my test case
showed).

But perhaps you're not referring to the uevent devpaths, but rather the
refcounted parent references, in which case I agree with you.

> > So to repeat, it is not possible to defer unregistration of the parent
> > (usb interface) until the child (usb-serial port) is unregistered so
> > that we could defer the latter to when the last tty ref is dropped.
> 
> No.  The USB stack is designed under the assumption that outstanding
> references pin data structures in memory but they don't pin anything
> else.  In particular, release routines are not supposed to call things
> like device_del() (although there may be some cases where this does
> happen).

As I suspected. Thanks for verifying.

> What _is_ true is this: We do not want to defer unregistration of
> either entity until some final ref is dropped.  After all, userspace
> can continue to hold references indefinitely, whereas registration
> should occur in a timely manner.  For example, aren't the hotplug
> events for device removal triggered by unregistration?

Indeed, this is where we get the broken uevent devpaths.

> > > This is related to the problem of the port's private data being
> > > accessed after it is deallocated.  The only way that can happen is if
> > > the tty layer calls the subdriver after the private data structure is
> > > freed -- and you said above that this does happen.
> > > 
> > > But if change things so that the structure isn't freed until after the
> > > port is unregistered from the tty layer, this would mean that the tty
> > > layer is trying to do stuff to an unregistered port.  That would be a
> > > bug in the tty layer.
> > 
> > Yes, I acknowledged that it is a bug, but it's not the one I'm
> > triggering.
> 
> > This was ambiguous. I meant to acknowledge that port_release should be
> > called after unregistration, but what I'm triggering is the different
> > bug that tty callbacks are made after unregistration (and proceed to
> > discuss whether this is indeed to be considered a bug in tty or
> > usb-serial below).
> 
> > I think the confusion stems from what tty_unregister_device actually
> > implies. You seem to, and I used to, think that this calls works as a
> > barrier so that no further tty callbacks can be made once it returns.
> > However, this is not the case.
> 
> Sounds like a design weakness, if not quite a flaw, in the tty layer.  
> As a general rule, responsibility for tricky things like barriers
> always belongs in the core layer where it can be done once and done
> correctly, rather than being replicated throughout multiple drivers
> which are likely to get it wrong.

Agreed.

> > As long as there are outstanding tty refs, tty will happily call back
> > even after tty_unregister_device returns. Unless we all agree that this
> > a bug in tty, it's a bug in usb-serial which should instead defer
> > unregistration until the last reference is dropped (but that gives us
> > the broken uevents unless it could be worked around).
> 
> No, unregistration cannot be deferred.  However the usb-serial core 
> could try to compensate for the problem by refusing to pass callbacks 
> through to the subdriver after the port has been unregistered.  I don't 
> know if that would work -- it wouldn't if some of the callback routines 
> are located in the subdriver itself as opposed to usb-serial.c.

It should be ok as all tty callbacks are made through usb serial core.

I have a pretty good overview over what callbacks we can be expecting
when, and those that we cannot prevent tty from making, we'll deal with
in usb-serial core.

My fix for the dtr_rts case is in 3.9-rc, and I try to reduce some of
the callbacks with my TTY patches (which would for example make the
dtr_rts fix unnecessary).

> > > I'm not saying such bugs don't exist.  However, if they do exist then 
> > > the tty layer needs to be fixed, not the usb-serial layer.
> > 
> > Fair enough. 
> > 
> > Note also that we have at least two drivers on each side of this
> > argument; ubs-serial unregistering at disconnect, and cdc-acm
> > unregistering when the last tty ref is dropped. One of them must be
> > wrong.
> 
> cdc-acm is wrong.

I'll fix this then.

Thanks,
Johan
