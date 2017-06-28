From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Moxa UPort 1150 and =?utf-8?Q?RS-422?= =?utf-8?B?LzQ4NeKApg==?=
 what's the "proper" way to switch modes
Date: Wed, 28 Jun 2017 17:34:39 +0200
Message-ID: <20170628153439.GC17630@localhost>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
 <20170627090449.GG3025@localhost>
 <42601356-656d-57d0-d366-a0933780b8f9@longlandclan.id.au>
 <1498565331.30390.5.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498565331.30390.5.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 27, 2017 at 02:08:51PM +0200, Oliver Neukum wrote:
> Am Dienstag, den 27.06.2017, 19:43 +1000 schrieb Stuart Longland:
> > Maybe a good start would be a "standard" option (referring to the
> > physical signalling standard, TTL/RS-232/RS-422/RS-485), that lists the
> > available standards when read and shows the "selected" standard in
> > brackets (like the 'trigger' option of the LEDs sysfs interface)… so for
> > this case:
> > 
> > # cat /sys/class/tty/ttyUSB0/standard
> > [rs232] rs422 rs485 rs485fd
> > 
> > and to select 4-wire ("full duplex") RS-485, one does:
> > # echo rs485fd > /sys/class/tty/ttyUSB0/standard
> 
> This looks like something that people will put into udev.
> So the switch will be done via udev, but the user not necessarily
> started via udev. Looks like a race to me.

Sure, but since changing the electrical interface arguably should be a
privileged operation, using an ioctl for this would not solve the race
when the interface is changed from an init-script and a non-privileged
application opens the port.

We also have the easy device-tree case, where such parameters could be
parsed at probe and all would be good. This could be used to handle some
semi-static cases involving USB devices eventually too.

So this is mostly an issue for systems not using OF and for hot-plugging,
where udev could race with the application.

The latter could of course always check that the desired mode has been
set before opening the port, but then I guess we're in some sense back
at encoding the physical setup in the application.

> And what do you if the interface is already opened and the sysfs
> interface is used?

Refuse switching mode and returning -EBUSY?

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
