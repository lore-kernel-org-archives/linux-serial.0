From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: USB: serial: port lifetimes (was: Re: USB Ooops PL2303 when
 unplug while use (linux v3.7.3))
Date: Fri, 22 Feb 2013 09:44:44 -0800
Message-ID: <20130222174444.GA18020@kroah.com>
References: <20130222171157.GD6640@localhost>
 <Pine.LNX.4.44L0.1302221218270.1365-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1302221218270.1365-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 22, 2013 at 12:35:32PM -0500, Alan Stern wrote:
> On Fri, 22 Feb 2013, Johan Hovold wrote:
> 
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

Ick, yeah, that was a mistake, probably been there since the very
beginning, sorry about that.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
