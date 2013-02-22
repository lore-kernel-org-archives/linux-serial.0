From: Johan Hovold <jhovold@gmail.com>
Subject: Re: USB: serial: port lifetimes (was: Re: USB Ooops PL2303 when
 unplug while use (linux v3.7.3))
Date: Fri, 22 Feb 2013 18:11:57 +0100
Message-ID: <20130222171157.GD6640@localhost>
References: <20130222100339.GB6640@localhost>
 <Pine.LNX.4.44L0.1302221009370.1606-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:61335 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757752Ab3BVRMq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Feb 2013 12:12:46 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1302221009370.1606-100000@iolanthe.rowland.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johan Hovold <jhovold@gmail.com>, Peter Hurley <peter@hurleysoftware.com>, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Feb 22, 2013 at 10:17:51AM -0500, Alan Stern wrote:
> On Fri, 22 Feb 2013, Johan Hovold wrote:
> 
> > We keep the usb-serial-port structure around until the last tty
> > reference is dropped, but the port private data is freed as part of
> > unregistering from the bus in disconnect. [ The subdrivers aren't
> > supposed to access the ports after port_remove is called as part of
> > unregistration. ]
> > 
> > This wasn't always the case, but unregistering in serial_cleanup (when
> > the last tty reference is dropped) had other issues. In particular, we
> > would end up unregistering the parent device before its child (the
> > interface and usb device are unregistered when disconnect returns)
> > resulting in broken uevent devpaths:
> > 
> > KERNEL[794.849051] remove   /devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4.1/1-4.1:1.0 (usb)
> > KERNEL[794.851649] remove   /devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4.1 (usb)
> > KERNEL[795.115623] remove   /1-4.1:1.0/ttyUSB0/tty/ttyUSB0 (tty)
> > KERNEL[795.117429] remove   /1-4.1:1.0/ttyUSB0 (usb-serial)
> > 
> > This was reported here
> > 
> > 	https://bugs.freedesktop.org/show_bug.cgi?id=20703
> > 
> > and fixed by Alan Stern in 2d93148ab6 (USB: serial: fix lifetime and
> > locking problems) by moving unregistration to disconnect.
> > 
> > So we end up with an unregistered device still possibly referenced by
> > tty instead, and I suspect we can't do much else than deal with any
> > post-disconnect callbacks. [ These should be few, especially with my
> > latest TTY-patches applied. ]
> > 
> > Alan, do you see any way around this? It's not possible (or desirable)
> > to pin the parent device (interface) until the last reference is
> > dropped, is it?
> 
> On the contrary, it is customary to pin data structures until the last 
> reference to them is gone.  That's what krefs are for.

I was referring to the usb device in the device hierarchy, which
apparently is not pinned despite the outstanding reference we have in
struct usb_serial.

There is an unconditional call to device_del in usb_disconnect which
unlinks the parent usb device from the device hierarchy resulting in the
broken devpaths above if we do not unregister the usb-serial port (and
tty device) in disconnect.

> On the other hand, the port private data was owned entirely by the
> serial sub-driver.  Neither the serial core nor the tty layer is able
> to use it meaningfully -- they don't even know what type of structure
> it is.
> 
> Therefore freeing the structure when the port is removed should be 
> harmless -- unless the subdriver is called after the structure is 
> deallocated.

Which could happen (and is happening), unless we defer port unregister
until the last tty reference is dropped -- but then we get the broken
uevents.

> This means there still is one bug remaining.  In
> usb_serial_device_remove(), the call to tty_unregister_device() should
> occur _before_ the call to driver->port_remove(), not _after_.  Do you
> think changing the order cause any new problems?

Yes, Peter noticed that one too. Changing the order shouldn't cause any
new issues as far as I can see. I'll cook up a patch for this one as
well, but just to be clear: this is not directly related to the problem
discussed above as there may be outstanding tty references long after
both functions return (not that anyone has claimed anything else).

Johan
