From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 00:42:49 +0200
Message-ID: <20160822224247.vdh3plda6dxelvzw@earth>
References: <20160818202900.hyvm4hfxedifuefn@earth>
 <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
 <20160819052125.ze5zilppwoe3f2lx@earth>
 <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
 <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de>
 <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com>
 <20160820143405.04303834@lxorguk.ukuu.org.uk>
 <B4DF8974-1C6B-432E-AD1A-1E6067B9C158@goldelico.com>
 <20160822203947.ksxwnvzhc3tpnnx7@earth>
 <EA228ADD-F03A-49C0-9A0B-E768D7A7A466@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ujbmmsf7oj6qiqrs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EA228ADD-F03A-49C0-9A0B-E768D7A7A466@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Oleksij Rempel <linux@rempel-privat.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--ujbmmsf7oj6qiqrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 22, 2016 at 11:23:26PM +0200, H. Nikolaus Schaller wrote:
> > Am 22.08.2016 um 22:39 schrieb Sebastian Reichel <sre@kernel.org>:
> >=20
> > Hi,
> >=20
> > On Sun, Aug 21, 2016 at 09:50:57AM +0200, H. Nikolaus Schaller wrote:
> >>> Am 20.08.2016 um 15:34 schrieb One Thousand Gnomes <gnomes@lxorguk.uk=
uu.org.uk>:
> >>>> What it is not about are UART/RS232 converters connected through USB=
 or virtual
> >>>> serial ports created for WWAN modems (e.g. /dev/ttyACM, /dev/ttyHSO)=
=2E Or BT devices
> >>>> connected through USB (even if they also run HCI protocol).
> >>>=20
> >>> It actually has to be about both because you will find the exact same
> >>> device wired via USB SSIC/HSIC to a USB UART or via a classic UART. N=
ot is
> >>> it just about embedded boards.
> >>=20
> >> Not necessarily.
> >>=20
> >> We often have two interface options for exactly the sam sensor chips. =
They can be connected
> >> either through SPI or I2C. Which means that there is a core driver for=
 the chip and two different
> >> transport glue components (see e.g. iio/accel/bmc150).
> >>=20
> >> This does not require I2C to be able to handle SPI or vice versa or pr=
ovide a common API.
> >=20
> > I don't understand this comparison. I2C and SPI are different
> > protocols,
>=20
> Yes, they are different on protocol level, but on both you transfer block=
s of data from/to a slave device
> which usually can be addressed. And for some chips they are just two slig=
htly alternative serial interfaces.
>=20
> > while native UART and USB-connected UART are both UART.
>=20
> I see what you mean, but kernel divides between directly connected UART a=
nd USB-connected UART.
>=20
> drivers/usb/serial/ vs. drivers/tty/serial/
>=20
> to implement two different groups of UARTs. Although on user space level =
they are harmonized again.
> This is why I compare with i2c and spi. But each such comparison is not p=
erfect.
>=20
> Anyways, to me it looks as if everybody wants to make the solution work f=
or usb-uarts as well
> (although I still would like to see a real world use-case).
>=20
> >=20
> >> And most Bluetooth devices I know have either UART or a direct
> >> USB interface. So in the USB case there is no need to connect
> >> it through some USB-UART bridge and treat it as an UART at all.
> >=20
> > I think having support for USB-UART dongles is useful for
> > driver development and testing on non-embedded HW.
>=20
> Hm. I assume you mean the Bluetooth situation where both, embedded UART
> connected chips and USB dongles are available.

No. I mean I have some serial device, which is connected to the
embedded UART, but I also have a standalone version. For driver
development I can just use my standalone serial device, connect
it to an USB-UART and develop the driver on non embedded HW.
Then I can use the same driver on my embedded platform and it
works, since it uses the same API.

For e.g. I2C this works perfectly fine. I already did this with
the I2C interface exposed on my notebook's VGA port.

> I am not a specialist for such things, but  I think you have three
> options to connect bluetooth:
>=20
> a) SoC-UART <-> BT-Chip-UART-port
> b) USB-UART (FT232, PL2303 etc.) <-> BT-Chip-UART-port
> c) USB <-> BT-Chip-USB-port (not UART involved at all)
>
> Case c) IMHO means you anyways need a special USB driver for the BT-Chip =
connected
> through USB and plugging it into a non-embedded USB port does not automat=
ically
> show it as a tty interface. So you can't use it for testing the UART driv=
ers.
>=20
> BTW: the Wi2Wi W2CBW003 chip comes in two firmware variants: one for UART=
 and
> one for USB. So they are also not exchangeable.

Yes, let's ignore option c). I'm talking about UART only. If the
chip has native USB support, then that's a different driver. Note,
that for more complex drivers it may become possible to use the same
high-level driver via regmap at some point. Not sure if this kind of
HW exists, though.

> Variant b) is IMHO of no practical relevance (but I may be wrong)
> because it would mean to add some costly FT232 or PL2302 chip
> where a different firmware variant works with direct USB
> connection.

Well for some chips there is not native USB support. But my scenario
was about development. Let's say I have a serial-chip and I want to
develop a driver for it. It would be nice if I can develop the
driver with a USB-UART and then use it on my embedded system.

There are usb-serial devices, which could benefit from support
btw. I would find it really useful, if the Dangerous Prototype's
Bus Pirate would expose native /dev/i2c and /dev/spi and it's
based on FT232.

> So to me it looks as if you need to develop different low-level
> drivers anyways.

No. You say, that option b) is irrelevant and assume, that every
serial chip also has native USB support.

-- Sebastian

--ujbmmsf7oj6qiqrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu3/dAAoJENju1/PIO/qamhMP/0/9leORfw1QA9CDbLQYGyW0
g1OOaANGvP8PH49x0kSl9NSXPwU7+KizSK0k3V0ZnAUQ8NHJyeakuDyck15ezyg8
zqeXXcmC+iDO7LDGOg5WwdupHxZiYYPZeBi0C0RxbmNA4yyH/30WZJv01WZGYOTa
V1GjC/F/VU1It1oVLEfrXfsklbUQUpsANx5MNl9PzKZRXYzFuBVmJ4Hd4I5apupO
kpfaCMw+ZXiMgLDsoC5juty0MmN4guVtD8ie/t23ImQd8RE1lqFY9d4TQqjqpmCO
2FOk1frVyEffVTjLO8l9EbbEWaVunmiUIDDjPcYND5l3xL17TpoT7KgHH1Vkm9R4
dteOpY8uLbxugG0VMzd02q+iSHu9Q7i+t97+J5IqsQVOfr21rxdcDzTk4ioVUIZU
i7cJBhvMX6fNzVd96G03A3igDAsyRbSOopmp5NGor4LEUwUpT3M+8QqlWjrzHeUk
SGeYwOPzF/kBMPVfr2au3Dle6h6UJMe15CPTVXS5KaJGvT9L+CgneDlv4eI4uGVF
EG3zsj+Qyff+rOZUrEVYM1pIUUJEFwMb9a/bNBXiHHDUKWUHAvC2iLvPmwKvLaqd
B9dJ/7ZCltcRRQIWqCPr6R6lOU/DtB+8HnXZ3ThIEW/XoPu3ai0OG8NugjUwYxw1
jf9NSZH+0rL5HNxSaTui
=Zbkn
-----END PGP SIGNATURE-----

--ujbmmsf7oj6qiqrs--
