From: Johan Hovold <jhovold@gmail.com>
Subject: Re: USB: serial: port lifetimes (was: Re: USB Ooops PL2303 when
 unplug while use (linux v3.7.3))
Date: Sat, 23 Feb 2013 17:23:43 +0100
Message-ID: <20130223162343.GC30855@localhost>
References: <20130222171157.GD6640@localhost>
 <Pine.LNX.4.44L0.1302221218270.1365-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:62144 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450Ab3BWQYc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Feb 2013 11:24:32 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1302221218270.1365-100000@iolanthe.rowland.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johan Hovold <jhovold@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Feb 22, 2013 at 12:35:32PM -0500, Alan Stern wrote:
> On Fri, 22 Feb 2013, Johan Hovold wrote:
> > > > So we end up with an unregistered device still possibly referenced by
> > > > tty instead, and I suspect we can't do much else than deal with any
> > > > post-disconnect callbacks. [ These should be few, especially with my
> > > > latest TTY-patches applied. ]
> > > > 
> > > > Alan, do you see any way around this? It's not possible (or desirable)
> > > > to pin the parent device (interface) until the last reference is
> > > > dropped, is it?
> > > 
> > > On the contrary, it is customary to pin data structures until the last 
> > > reference to them is gone.  That's what krefs are for.
> > 
> > I was referring to the usb device in the device hierarchy, which
> > apparently is not pinned despite the outstanding reference we have in
> > struct usb_serial.
> 
> Are you talking about the usb_device or the usb_interface?  The
> usb_serial structure _does_ pin the usb_device structure.  But it
> doesn't pin the usb_interface.  I don't know why things were done this
> way; maybe it's a mistake.
> 
> Anyway, keeping a pointer to a non-pinned data structure after
> unregistration is okay, provided you know you will never dereference
> the pointer.  If you don't know this in the case of the usb_interface,
> pinning is acceptable -- depending on _how_ the usb_interface is
> accessed.  For example, no URBs should be submitted for any of the
> interface's endpoints.
> 
> > There is an unconditional call to device_del in usb_disconnect which
> > unlinks the parent usb device from the device hierarchy resulting in the
> > broken devpaths above if we do not unregister the usb-serial port (and
> > tty device) in disconnect.
> 
> Sure.  But unregistering is different from deallocation.  It's not
> clear what your point is.

I'm not primarily concerned with deallocation, and perhaps my choice of
wording was misleading when I use "pinning" in reference to the device
hierarchy and unregistration. I was basically asking whether it is
possible to defer unregistration of the interface (parent device) until
the last tty reference is dropped.

> > > On the other hand, the port private data was owned entirely by the
> > > serial sub-driver.  Neither the serial core nor the tty layer is able
> > > to use it meaningfully -- they don't even know what type of structure
> > > it is.
> > > 
> > > Therefore freeing the structure when the port is removed should be 
> > > harmless -- unless the subdriver is called after the structure is 
> > > deallocated.
> > 
> > Which could happen (and is happening), unless we defer port unregister
> > until the last tty reference is dropped -- but then we get the broken
> > uevents.
> 
> Unregistration should not be deferred.  We mustn't have those broken 
> devpaths.

And here is your answer it seems.

So to repeat, it is not possible to defer unregistration of the parent
(usb interface) until the child (usb-serial port) is unregistered so
that we could defer the latter to when the last tty ref is dropped.

> > > This means there still is one bug remaining.  In
> > > usb_serial_device_remove(), the call to tty_unregister_device() should
> > > occur _before_ the call to driver->port_remove(), not _after_.  Do you
> > > think changing the order cause any new problems?
> > 
> > Yes, Peter noticed that one too. Changing the order shouldn't cause any
> > new issues as far as I can see. I'll cook up a patch for this one as
> > well, but just to be clear: this is not directly related to the problem
> > discussed above as there may be outstanding tty references long after
> > both functions return (not that anyone has claimed anything else).
> 
> This is related to the problem of the port's private data being
> accessed after it is deallocated.  The only way that can happen is if
> the tty layer calls the subdriver after the private data structure is
> freed -- and you said above that this does happen.
> 
> But if change things so that the structure isn't freed until after the
> port is unregistered from the tty layer, this would mean that the tty
> layer is trying to do stuff to an unregistered port.  That would be a
> bug in the tty layer.

Yes, I acknowledged that it is a bug, but it's not the one I'm
triggering.

I think the confusion stems from what tty_unregister_device actually
implies. You seem to, and I used to, think that this calls works as a
barrier so that no further tty callbacks can be made once it returns.
However, this is not the case.

As long as there are outstanding tty refs, tty will happily call back
even after tty_unregister_device returns. Unless we all agree that this
a bug in tty, it's a bug in usb-serial which should instead defer
unregistration until the last reference is dropped (but that gives us
the broken uevents unless it could be worked around).

> I'm not saying such bugs don't exist.  However, if they do exist then 
> the tty layer needs to be fixed, not the usb-serial layer.

Fair enough. 

Note also that we have at least two drivers on each side of this
argument; ubs-serial unregistering at disconnect, and cdc-acm
unregistering when the last tty ref is dropped. One of them must be
wrong.

Johan
