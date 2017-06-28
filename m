From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Moxa UPort 1150 and =?utf-8?Q?RS-422?= =?utf-8?B?LzQ4NeKApg==?=
 what's the "proper" way to switch modes
Date: Wed, 28 Jun 2017 17:16:20 +0200
Message-ID: <20170628151620.GB17630@localhost>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
 <20170627090449.GG3025@localhost>
 <42601356-656d-57d0-d366-a0933780b8f9@longlandclan.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42601356-656d-57d0-d366-a0933780b8f9-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 27, 2017 at 07:43:28PM +1000, Stuart Longland wrote:
> On 27/06/17 19:04, Johan Hovold wrote:
> >> What's the "proper" way to configure such ports for RS-422 and/or 4-wire
> >> RS-485?  Is there an example driver in the tree that I can use as a
> >> guide to porting Moxa's mode-switch code over to the ti_usb_3410_5052
> >> driver?
> > 
> > I'm afraid not. We have the TIOCSRS485 ioctl, but that doesn't really
> > fit here (currently) as we're not just enabling 2-wire-rs485 style
> > signalling (using RTS to control the tranceiver), but are also
> > configuring the electrical interface (e.g. which pins on the DB9
> > connector are being used for which functions).
> > 
> > This question is raised every now and then; typically when a new
> > driver is being merged (e.g. mxuport or when support for your device was
> > added), but we have yet to decide on the proper interface.
> > 
> > Extending the TIOCSRS485 ioctl has been discussed, and one alternative
> > could be a sysfs-based interface as this would typically be something
> > you'd want to configure at boot and before opening the device (and
> > toggling DTR).
> 
> I did consider sysfs this morning… this would make a lot of sense.
> These things being USB, it is possible that a udev trigger could put it
> in the appropriate mode when they are plugged in.  Sounds a much better
> option than re-purposing other fields.

Unless there are too many attributes to set at least, otherwise a single
ioctl might still be still be more convenient. Note that there is room
for extending the TIOCSRS485 ioctl.

> > Either way, we need do determine the right level of abstraction as some
> > of the related properties are fairly device dependent (master/slave
> > mode, terminating resistors, auto direction, echo, etc).
> > 
> > For the record, note that we do have the mxser driver, and a few more
> > old drivers, implementing custom ioctls for this, but we really should
> > not be adding more of those.
> 
> Yeah, I won't be adding ioctls… it makes the interface too
> hardware-specific.  If anything, the ioctls might be a hint to what
> enumerated properties to expose on sysfs, then the ioctl interface can
> be gradually phased out.
> 
> I'll have a look at mxser.  At this point I'm thinking gathering a
> listing of what devices support what configuration options would be
> worthwhile.  I know the UPort 1150 supports 2-wire RS-485, 4-wire
> RS-485, RS-422 and RS-232… the UPort 1100 drops support for RS-232… I
> don't think either offer termination resistance options.

There are more Moxa devices with rs485-support, including those managed
by the mxuport driver. Some Edgeport devices apparently support some of
those more exotic settings like termination, see

	https://marc.info/?l=linux-usb&m=129798628514104&w=2

The above thread also has some discussion about extending the TIOCSRS485
ioctl.

Other USB serial devices that have some support for rs485 include cp210x
(using a gpio pin to control the tranceiver), and some Fintek devices.

Also note that the vendor driver for UPort 1150 treats rs422 and
rs485-4w the same and really only has three distinct modes (rs232, and
rs485 with receiver enabled or disabled).

> Maybe a good start would be a "standard" option (referring to the
> physical signalling standard, TTL/RS-232/RS-422/RS-485), that lists the
> available standards when read and shows the "selected" standard in
> brackets (like the 'trigger' option of the LEDs sysfs interface)… so for
> this case:
> 
> # cat /sys/class/tty/ttyUSB0/standard
> [rs232] rs422 rs485 rs485fd

Yeah, I once suggested something like this for Moxa, but I think we need
to at least consider the various parameters available first if we are to
come up with a generic interface.

> and to select 4-wire ("full duplex") RS-485, one does:
> # echo rs485fd > /sys/class/tty/ttyUSB0/standard
> 
> A hypothetical dongle that supports pin re-mapping might have
> properties: rxd, txd, rts, cts, dtr, dsr, cd, ri, gnd (for RS-232; maybe
> a, b and gnd for RS-485 or txa, txb, rxa, rxb, gnd for
> RS-422/full-duplex-RS-485) that gives the pin numbers/labels:
> 
> cd: [1] 2 3 4 5 6 7 8 9
> rx: 1 [2] 3 4 5 6 7 8 9
> tx: 1 2 [3] 4 5 6 7 8 9
> … etc …

This I think might be taking it too far at this stage though. :)

> and termination resistance (separate options for RX and TX) might be a
> selection of off, and the available resistances. (e.g. "50", "75",
> "120", "1k" … whatever the device supports.)

A binary setting here might suffice.

> I'm open to ideas here, I'm not sure how many configurable serial
> interfaces there are out there (USB or otherwise), so if people watching
> the list can provide some examples of these devices, this will be a big
> help.

I mention a few above, and there are some old ones like rocket and mxser
that have a custom ioctl for this.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
