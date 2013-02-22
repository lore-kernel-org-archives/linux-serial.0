From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB: serial: port lifetimes (was: Re: USB Ooops PL2303 when
 unplug while use (linux v3.7.3))
Date: Fri, 22 Feb 2013 12:35:32 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302221218270.1365-100000@iolanthe.rowland.org>
References: <20130222171157.GD6640@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130222171157.GD6640@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 22 Feb 2013, Johan Hovold wrote:

> > > So we end up with an unregistered device still possibly referenced by
> > > tty instead, and I suspect we can't do much else than deal with any
> > > post-disconnect callbacks. [ These should be few, especially with my
> > > latest TTY-patches applied. ]
> > > 
> > > Alan, do you see any way around this? It's not possible (or desirable)
> > > to pin the parent device (interface) until the last reference is
> > > dropped, is it?
> > 
> > On the contrary, it is customary to pin data structures until the last 
> > reference to them is gone.  That's what krefs are for.
> 
> I was referring to the usb device in the device hierarchy, which
> apparently is not pinned despite the outstanding reference we have in
> struct usb_serial.

Are you talking about the usb_device or the usb_interface?  The
usb_serial structure _does_ pin the usb_device structure.  But it
doesn't pin the usb_interface.  I don't know why things were done this
way; maybe it's a mistake.

Anyway, keeping a pointer to a non-pinned data structure after
unregistration is okay, provided you know you will never dereference
the pointer.  If you don't know this in the case of the usb_interface,
pinning is acceptable -- depending on _how_ the usb_interface is
accessed.  For example, no URBs should be submitted for any of the
interface's endpoints.

> There is an unconditional call to device_del in usb_disconnect which
> unlinks the parent usb device from the device hierarchy resulting in the
> broken devpaths above if we do not unregister the usb-serial port (and
> tty device) in disconnect.

Sure.  But unregistering is different from deallocation.  It's not
clear what your point is.

> > On the other hand, the port private data was owned entirely by the
> > serial sub-driver.  Neither the serial core nor the tty layer is able
> > to use it meaningfully -- they don't even know what type of structure
> > it is.
> > 
> > Therefore freeing the structure when the port is removed should be 
> > harmless -- unless the subdriver is called after the structure is 
> > deallocated.
> 
> Which could happen (and is happening), unless we defer port unregister
> until the last tty reference is dropped -- but then we get the broken
> uevents.

Unregistration should not be deferred.  We mustn't have those broken 
devpaths.

> > This means there still is one bug remaining.  In
> > usb_serial_device_remove(), the call to tty_unregister_device() should
> > occur _before_ the call to driver->port_remove(), not _after_.  Do you
> > think changing the order cause any new problems?
> 
> Yes, Peter noticed that one too. Changing the order shouldn't cause any
> new issues as far as I can see. I'll cook up a patch for this one as
> well, but just to be clear: this is not directly related to the problem
> discussed above as there may be outstanding tty references long after
> both functions return (not that anyone has claimed anything else).

This is related to the problem of the port's private data being
accessed after it is deallocated.  The only way that can happen is if
the tty layer calls the subdriver after the private data structure is
freed -- and you said above that this does happen.

But if change things so that the structure isn't freed until after the
port is unregistered from the tty layer, this would mean that the tty
layer is trying to do stuff to an unregistered port.  That would be a
bug in the tty layer.

I'm not saying such bugs don't exist.  However, if they do exist then 
the tty layer needs to be fixed, not the usb-serial layer.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
