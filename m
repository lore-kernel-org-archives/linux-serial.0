From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: =?UTF-8?Q?Re:_Moxa_UPort_1150_and_RS-422/485=e2=80=a6_what's_the_?=
 =?UTF-8?Q?=22proper=22_way_to_switch_modes?=
Date: Tue, 27 Jun 2017 19:43:28 +1000
Message-ID: <42601356-656d-57d0-d366-a0933780b8f9@longlandclan.id.au>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
 <20170627090449.GG3025@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mo2jiuLj4hMVimrSShu628r5lWFA2b6JS"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170627090449.GG3025@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mo2jiuLj4hMVimrSShu628r5lWFA2b6JS
Content-Type: multipart/mixed; boundary="o5gF6lJMXXOXFL7H8c9arrLsNcBSeBTfx";
 protected-headers="v1"
From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Message-ID: <42601356-656d-57d0-d366-a0933780b8f9-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: =?UTF-8?Q?Re:_Moxa_UPort_1150_and_RS-422/485=e2=80=a6_what's_the_?=
 =?UTF-8?Q?=22proper=22_way_to_switch_modes?=
References: <4a469222-d48d-f498-f2db-ca582295adc3-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
 <20170627090449.GG3025@localhost>
In-Reply-To: <20170627090449.GG3025@localhost>

--o5gF6lJMXXOXFL7H8c9arrLsNcBSeBTfx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27/06/17 19:04, Johan Hovold wrote:
>> What's the "proper" way to configure such ports for RS-422 and/or 4-wi=
re
>> RS-485?  Is there an example driver in the tree that I can use as a
>> guide to porting Moxa's mode-switch code over to the ti_usb_3410_5052
>> driver?
>=20
> I'm afraid not. We have the TIOCSRS485 ioctl, but that doesn't really
> fit here (currently) as we're not just enabling 2-wire-rs485 style
> signalling (using RTS to control the tranceiver), but are also
> configuring the electrical interface (e.g. which pins on the DB9
> connector are being used for which functions).
>=20
> This question is raised every now and then; typically when a new
> driver is being merged (e.g. mxuport or when support for your device wa=
s
> added), but we have yet to decide on the proper interface.
>=20
> Extending the TIOCSRS485 ioctl has been discussed, and one alternative
> could be a sysfs-based interface as this would typically be something
> you'd want to configure at boot and before opening the device (and
> toggling DTR).

I did consider sysfs this morning=E2=80=A6 this would make a lot of sense=
=2E
These things being USB, it is possible that a udev trigger could put it
in the appropriate mode when they are plugged in.  Sounds a much better
option than re-purposing other fields.

> Either way, we need do determine the right level of abstraction as some=

> of the related properties are fairly device dependent (master/slave
> mode, terminating resistors, auto direction, echo, etc).
>=20
> For the record, note that we do have the mxser driver, and a few more
> old drivers, implementing custom ioctls for this, but we really should
> not be adding more of those.

Yeah, I won't be adding ioctls=E2=80=A6 it makes the interface too
hardware-specific.  If anything, the ioctls might be a hint to what
enumerated properties to expose on sysfs, then the ioctl interface can
be gradually phased out.

I'll have a look at mxser.  At this point I'm thinking gathering a
listing of what devices support what configuration options would be
worthwhile.  I know the UPort 1150 supports 2-wire RS-485, 4-wire
RS-485, RS-422 and RS-232=E2=80=A6 the UPort 1100 drops support for RS-23=
2=E2=80=A6 I
don't think either offer termination resistance options.

Maybe a good start would be a "standard" option (referring to the
physical signalling standard, TTL/RS-232/RS-422/RS-485), that lists the
available standards when read and shows the "selected" standard in
brackets (like the 'trigger' option of the LEDs sysfs interface)=E2=80=A6=
 so for
this case:

# cat /sys/class/tty/ttyUSB0/standard
[rs232] rs422 rs485 rs485fd

and to select 4-wire ("full duplex") RS-485, one does:
# echo rs485fd > /sys/class/tty/ttyUSB0/standard

A hypothetical dongle that supports pin re-mapping might have
properties: rxd, txd, rts, cts, dtr, dsr, cd, ri, gnd (for RS-232; maybe
a, b and gnd for RS-485 or txa, txb, rxa, rxb, gnd for
RS-422/full-duplex-RS-485) that gives the pin numbers/labels:

cd: [1] 2 3 4 5 6 7 8 9
rx: 1 [2] 3 4 5 6 7 8 9
tx: 1 2 [3] 4 5 6 7 8 9
=E2=80=A6 etc =E2=80=A6

and termination resistance (separate options for RX and TX) might be a
selection of off, and the available resistances. (e.g. "50", "75",
"120", "1k" =E2=80=A6 whatever the device supports.)

I'm open to ideas here, I'm not sure how many configurable serial
interfaces there are out there (USB or otherwise), so if people watching
the list can provide some examples of these devices, this will be a big
help.

Regards,
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--o5gF6lJMXXOXFL7H8c9arrLsNcBSeBTfx--

--mo2jiuLj4hMVimrSShu628r5lWFA2b6JS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvKEYefT5O+PbDe5y+VS7u3lI1UYFAllSKMEACgkQ+VS7u3lI
1UZVKA/6Av7apm06gsxXD/3ltOjVJHjhxoKMvEJBoXUeWHhvpgMA8ZKPII/VluTT
zzUajLGI8OKX4Cb28Ib8E0mSzUQtkijNmYDcK9s3VdhyAtrFnvAkV3iXctOqieI3
RsqyhFv+bBjTdEoPZ6JSmx4zqG69w0RPMu3rXHICT6Xxq5K5XIyhiZsq/mR65OQK
Xr98wBZNR0jgEC51UrYhrSoON34aVgNchS1v/atnT83WteQvtZQL71Yznu9ehnZf
a5US7P90J/XUuen4M4HzY6ElVWW1r4/cQfsnCVlif7eJJ+mYzzTgyDlwikc63QGF
5dUWJJZahiQ/GB8pauStO4UXrG9cEy5Iyovt4JlczIO41+IxZD/lE5jt2h50W7f2
w4wHlNIZxDDN+JqVD+XCoki/Sd2n4T1lkyoz3BtKdX0QgnmWg8d3bSF9VzwUkS0/
9+PbQsmVMjSOl0Dbadc+wrINsNI9OEpGjd2/80WOPPKgqDvuD/M/AKHtMGD+Wh8M
OBF89ZsMb4vvOxjl84neB73Z/VbSd9YBUkabsDXs02yp/HkpVKFGoih01T9+qIRU
XCMJwexOCwvlacPLK++vRHDroAztasgm0lCrbOCd97Uwxpkg/RlkQTOHtMGlkhcL
ss9Ml1q33KNg/kFaR3biyKQYHtjZ+X0V4T1/p0sOg7QRF8RsU+Q=
=s/wa
-----END PGP SIGNATURE-----

--mo2jiuLj4hMVimrSShu628r5lWFA2b6JS--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
