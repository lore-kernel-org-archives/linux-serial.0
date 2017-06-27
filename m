From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: =?UTF-8?Q?Re:_Moxa_UPort_1150_and_RS-422/485=e2=80=a6_what's_the_?=
 =?UTF-8?Q?=22proper=22_way_to_switch_modes?=
Date: Wed, 28 Jun 2017 08:07:54 +1000
Message-ID: <ae2907c2-cb0f-61e4-c6f2-af3dcec93ace@longlandclan.id.au>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
 <20170627090449.GG3025@localhost>
 <42601356-656d-57d0-d366-a0933780b8f9@longlandclan.id.au>
 <1498565331.30390.5.camel@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ntb1fum86VOrjG96O7mrlA3WGQTqrow7R"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498565331.30390.5.camel-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ntb1fum86VOrjG96O7mrlA3WGQTqrow7R
Content-Type: multipart/mixed; boundary="twGr9ATWCXDCNUcguCCoEd0TU9UMgeRSH";
 protected-headers="v1"
From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <ae2907c2-cb0f-61e4-c6f2-af3dcec93ace-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: =?UTF-8?Q?Re:_Moxa_UPort_1150_and_RS-422/485=e2=80=a6_what's_the_?=
 =?UTF-8?Q?=22proper=22_way_to_switch_modes?=
References: <4a469222-d48d-f498-f2db-ca582295adc3-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
 <20170627090449.GG3025@localhost>
 <42601356-656d-57d0-d366-a0933780b8f9-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
 <1498565331.30390.5.camel-IBi9RG/b67k@public.gmane.org>
In-Reply-To: <1498565331.30390.5.camel-IBi9RG/b67k@public.gmane.org>

--twGr9ATWCXDCNUcguCCoEd0TU9UMgeRSH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27/06/17 22:08, Oliver Neukum wrote:
> Am Dienstag, den 27.06.2017, 19:43 +1000 schrieb Stuart Longland:
>> Maybe a good start would be a "standard" option (referring to the
>> physical signalling standard, TTL/RS-232/RS-422/RS-485), that lists th=
e
>> available standards when read and shows the "selected" standard in
>> brackets (like the 'trigger' option of the LEDs sysfs interface)=E2=80=
=A6 so for
>> this case:
>>
>> # cat /sys/class/tty/ttyUSB0/standard
>> [rs232] rs422 rs485 rs485fd
>>
>> and to select 4-wire ("full duplex") RS-485, one does:
>> # echo rs485fd > /sys/class/tty/ttyUSB0/standard=20
> This looks like something that people will put into udev.
> So the switch will be done via udev, but the user not necessarily
> started via udev. Looks like a race to me.

It is a race, but unless a daemon is watching for the very moment that a
particular serial interface appears, it's one that init scripts are very
likely to win.

Short of having a flag that blocks reads/writes until a given sysfs file
is written to say "I'm ready, go ahead"=E2=80=A6 there aren't that many o=
ptions
I can think of.

> And what do you if the interface is already opened and the sysfs
> interface is used?

We return -EBUSY?  If the interface is open, there isn't a lot we can
do, the user either puts up with unpredictable behaviour or we refuse
the switch.

By unpredictable behaviour: if the device is well behaved, there might
be a small signal level glitch=E2=80=A6 but I'd expect serial devices to =
be
tolerant of that kind of step change in signal.  (Think hot-plugging
serial links.)

This beats the official Moxa solution: their Windows driver wants a
reboot of the entire machine to switch between serial standards.
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--twGr9ATWCXDCNUcguCCoEd0TU9UMgeRSH--

--Ntb1fum86VOrjG96O7mrlA3WGQTqrow7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvKEYefT5O+PbDe5y+VS7u3lI1UYFAllS1zsACgkQ+VS7u3lI
1UYAEA/+OBP9cvUz2XiqTd3WSJY5txKM56689rtHI2w9c8h1bAjc1VT/rJb1hxoU
1a1LMagADjy/Dfl2+r8a9MHayvAQeg4p8FQZc90M20A7ff29aXCPwalRu4BV8xDR
ToXEe5MlPHRStbD53Ht+oY6cWVZ0ky0dBfDCmYwOr9jH2qizYnDWSCQbrn9nOUyX
mej9mYasKSW40nfw8+ZTXz93F2zQR8VZRkJpZ2iYRNoFZTJkadSDOfiwxRMfP/p1
de5vuzuQxEZfdDdRhB6d6qDEj8214X7NTrhFnKRz+BZ/Pyyehwm69o+ofd6bWv5L
7YA6gDg1LR63ZPPBZ7m1KsbEgXf12BExyOWIi8n2Ni6CMG4Iiij+OIAs2XAN2XDB
fQcs0UF+qUWOAu+at2N2KouexP2UKf8RjfV9KVnvJ1wmFyZI6Mrl036rp6Lra4lK
egj9GGe6qKot6qb88jwTEeAVGoADcbSflqRW+ocQ03FdXHOXmD0S6vF0KAikPBtK
1zzJLKc/1VSxxOoyEHzAuK+GnaoB7IbW6woF1NiNIZBqWSNd+yL+6Vzh6j8W6dKL
VeS/H3turYZ09rTDbBWGSnwV2aNOuvMG9Ueae7oRxVkHcWIiypnozQrAgth3pj7K
qPzoVqQ57GwlAL4OiAHcZaiO9HmCs8ZSYUZYrUIrNxQ6mxki0HY=
=eOtN
-----END PGP SIGNATURE-----

--Ntb1fum86VOrjG96O7mrlA3WGQTqrow7R--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
