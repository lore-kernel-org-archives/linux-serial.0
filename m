From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Moxa UPort 1150 and =?utf-8?Q?RS-422?= =?utf-8?B?LzQ4NeKApg==?=
 what's the "proper" way to switch modes
Date: Tue, 27 Jun 2017 11:04:49 +0200
Message-ID: <20170627090449.GG3025@localhost>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4a469222-d48d-f498-f2db-ca582295adc3-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

[ +CC: Alan and linux-usb ]

On Fri, Jun 23, 2017 at 09:44:31AM +1000, Stuart Longland wrote:
> Hi all,
> 
> A silly question: I have a Moxa UPort 1150 USB serial interface that I
> am trying to coax into either RS-422 or 4-wire RS-485 mode.  Internally,
> this is a TI USB 3410 device, and works with the ti_usb_3410_5052 module.
> 
> Moxa have a (poorly maintained as usual) driver for these devices, and I
> see reference to things like RS-485 in the TI driver.  Moxa's driver did
> a kludge where they used `setserial` to control the mode, and used the
> device "port" number to set that mode.  I do not think it wise to try
> and replicate that same kludge, as I understand that parameter is for
> configuring the I/O port (e.g. 0x3f8 for /dev/ttyS0 on older
> IBM-compatibles).

Agreed, and that's why we have rejected this interface when support for
Moxa devices have been added.

> Now, *some* versions of `stty` allegedly have an "rs485" option: mine
> (in coreutils 8.25) does not.  I suspect this is 2-wire RS-485, which
> won't do here, as my RX and TX are on different RS-485 pairs.

Neither does mine, I think that's some out-of-tree support for the
TIOCSRS485 ioctl mentioned below.

> What's the "proper" way to configure such ports for RS-422 and/or 4-wire
> RS-485?  Is there an example driver in the tree that I can use as a
> guide to porting Moxa's mode-switch code over to the ti_usb_3410_5052
> driver?

I'm afraid not. We have the TIOCSRS485 ioctl, but that doesn't really
fit here (currently) as we're not just enabling 2-wire-rs485 style
signalling (using RTS to control the tranceiver), but are also
configuring the electrical interface (e.g. which pins on the DB9
connector are being used for which functions).

This question is raised every now and then; typically when a new
driver is being merged (e.g. mxuport or when support for your device was
added), but we have yet to decide on the proper interface.

Extending the TIOCSRS485 ioctl has been discussed, and one alternative
could be a sysfs-based interface as this would typically be something
you'd want to configure at boot and before opening the device (and
toggling DTR).

Either way, we need do determine the right level of abstraction as some
of the related properties are fairly device dependent (master/slave
mode, terminating resistors, auto direction, echo, etc).

For the record, note that we do have the mxser driver, and a few more
old drivers, implementing custom ioctls for this, but we really should
not be adding more of those.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
