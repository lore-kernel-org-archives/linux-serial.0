From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: Moxa UPort 1150 and =?UTF-8?Q?RS-422=2F485=E2=80=A6?= what's
 the "proper" way to switch modes
Date: Wed, 28 Jun 2017 11:19:09 +0200
Message-ID: <1498641549.10278.5.camel@suse.com>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
         <20170627090449.GG3025@localhost>
         <42601356-656d-57d0-d366-a0933780b8f9@longlandclan.id.au>
         <1498565331.30390.5.camel@suse.com>
         <ae2907c2-cb0f-61e4-c6f2-af3dcec93ace@longlandclan.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ae2907c2-cb0f-61e4-c6f2-af3dcec93ace-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Am Mittwoch, den 28.06.2017, 08:07 +1000 schrieb Stuart Longland:

Hi,

> >> and to select 4-wire ("full duplex") RS-485, one does:
> >> # echo rs485fd > /sys/class/tty/ttyUSB0/standard 
> > This looks like something that people will put into udev.
> > So the switch will be done via udev, but the user not necessarily
> > started via udev. Looks like a race to me.
> 
> It is a race, but unless a daemon is watching for the very moment that a
> particular serial interface appears, it's one that init scripts are very
> likely to win.

That is precisely what a demon might do.

> Short of having a flag that blocks reads/writes until a given sysfs file
> is written to say "I'm ready, go ahead"… there aren't that many options
> I can think of.

1) module option
2) ioctl

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
