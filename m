From: Johan Hovold <jhovold@gmail.com>
Subject: USB: serial: port lifetimes (was: Re: USB Ooops PL2303 when unplug
 while use (linux v3.7.3))
Date: Fri, 22 Feb 2013 11:03:39 +0100
Message-ID: <20130222100339.GB6640@localhost>
References: <510B2C09.7020700@gtsys.com.hk>
 <20130213142513.GA21078@localhost>
 <1360780808.8499.43.camel@thor.lan>
 <20130214174336.GA2581@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:49057 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab3BVKE3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Feb 2013 05:04:29 -0500
Content-Disposition: inline
In-Reply-To: <20130214174336.GA2581@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Johan Hovold <jhovold@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Feb 14, 2013 at 06:43:36PM +0100, Johan Hovold wrote:
> On Wed, Feb 13, 2013 at 01:40:08PM -0500, Peter Hurley wrote:

[...]

> > Looks to me like a bug the usb serial mini-port interface design.
> > A usb bus disconnect has the pl2303 (and every other) mini-port freeing
> > the private data (before unregistering with tty anyway -- not that
> > putting that first would fix the problem).

[...]

> > The tty layer (and its port implementation) can't protect the pl2303
> > mini-port from this behavior/interface design.
> > 
> > It's the glue layer's responsibility to correctly manage the differing
> > lifetimes of its bus devices with tty devices (and tty_ports, if used).
> > 
> > Meaning, that if the physical device disconnects from the bus, the ports
> > must simply become in-operative; they can't disappear.

[...]

> > BTW, just fixing this one part won't work because the usb serial driver
> > is also abruptly deleting the usb_serial_port device as well:
> > 
> > static void usb_serial_disconnect(struct usb_interface *interface)
> > {
> > 	[...]
> > 
> > 	for (i = 0; i < serial->num_ports; ++i) {
> > 		port = serial->port[i];
> > 		if (port) {
> > 			struct tty_struct *tty = tty_port_tty_get(&port->port);
> > 			if (tty) {
> > 				tty_vhangup(tty);
> > 				tty_kref_put(tty);
> > 			}
> > 			kill_traffic(port);
> > 			cancel_work_sync(&port->work);
> > 			if (device_is_registered(&port->dev))
> > ========>			device_del(&port->dev);
> > 		}
> > 	}
> > 	
> > 	[...]
> > }
> > 
> > Ummm, wasn't that where the port private data pointer was?
> 
> Indeed.

We keep the usb-serial-port structure around until the last tty
reference is dropped, but the port private data is freed as part of
unregistering from the bus in disconnect. [ The subdrivers aren't
supposed to access the ports after port_remove is called as part of
unregistration. ]

This wasn't always the case, but unregistering in serial_cleanup (when
the last tty reference is dropped) had other issues. In particular, we
would end up unregistering the parent device before its child (the
interface and usb device are unregistered when disconnect returns)
resulting in broken uevent devpaths:

KERNEL[794.849051] remove   /devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4.1/1-4.1:1.0 (usb)
KERNEL[794.851649] remove   /devices/pci0000:00/0000:00:1a.7/usb1/1-4/1-4.1 (usb)
KERNEL[795.115623] remove   /1-4.1:1.0/ttyUSB0/tty/ttyUSB0 (tty)
KERNEL[795.117429] remove   /1-4.1:1.0/ttyUSB0 (usb-serial)

This was reported here

	https://bugs.freedesktop.org/show_bug.cgi?id=20703

and fixed by Alan Stern in 2d93148ab6 (USB: serial: fix lifetime and
locking problems) by moving unregistration to disconnect.

So we end up with an unregistered device still possibly referenced by
tty instead, and I suspect we can't do much else than deal with any
post-disconnect callbacks. [ These should be few, especially with my
latest TTY-patches applied. ]

Alan, do you see any way around this? It's not possible (or desirable)
to pin the parent device (interface) until the last reference is
dropped, is it?

Other drivers, such as cdc-acm, do unregister when the last reference is
dropped, but could potentially also generate broken uevents:

KERNEL[3042.388951] remove   /devices/pci0000:00/0000:00:1d.7/usb2/2-1/2-1:3.1 (usb)
KERNEL[3042.390242] remove   /2-1:3.1/tty/ttyACM0 (tty)

[ To trigger this I had to move the tty_kref_put to the end of
  disconnect(). As the tty ref is dropped in a workqueue, the disconnect
  then returns before cleanup is called, but any outstanding reference
  would have the same effect. ]

Johan
