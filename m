From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: Moxa UPort 1150 and =?UTF-8?Q?RS-422=2F485=E2=80=A6?= what's
 the "proper" way to switch modes
Date: Tue, 27 Jun 2017 14:08:51 +0200
Message-ID: <1498565331.30390.5.camel@suse.com>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
         <20170627090449.GG3025@localhost>
         <42601356-656d-57d0-d366-a0933780b8f9@longlandclan.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <42601356-656d-57d0-d366-a0933780b8f9-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Am Dienstag, den 27.06.2017, 19:43 +1000 schrieb Stuart Longland:
> Maybe a good start would be a "standard" option (referring to the
> physical signalling standard, TTL/RS-232/RS-422/RS-485), that lists the
> available standards when read and shows the "selected" standard in
> brackets (like the 'trigger' option of the LEDs sysfs interface)… so for
> this case:
> 
> # cat /sys/class/tty/ttyUSB0/standard
> [rs232] rs422 rs485 rs485fd
> 
> and to select 4-wire ("full duplex") RS-485, one does:
> # echo rs485fd > /sys/class/tty/ttyUSB0/standard

This looks like something that people will put into udev.
So the switch will be done via udev, but the user not necessarily
started via udev. Looks like a race to me.
And what do you if the interface is already opened and the sysfs
interface is used?

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
