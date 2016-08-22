From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 22:39:48 +0200
Message-ID: <20160822203947.ksxwnvzhc3tpnnx7@earth>
References: <20160818011445.22726-1-robh@kernel.org>
 <20160818202900.hyvm4hfxedifuefn@earth>
 <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
 <20160819052125.ze5zilppwoe3f2lx@earth>
 <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
 <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de>
 <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com>
 <20160820143405.04303834@lxorguk.ukuu.org.uk>
 <B4DF8974-1C6B-432E-AD1A-1E6067B9C158@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l4y4f46z7f6kbxuw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B4DF8974-1C6B-432E-AD1A-1E6067B9C158@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Oleksij Rempel <linux@rempel-privat.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--l4y4f46z7f6kbxuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 21, 2016 at 09:50:57AM +0200, H. Nikolaus Schaller wrote:
> > Am 20.08.2016 um 15:34 schrieb One Thousand Gnomes <gnomes@lxorguk.ukuu=
=2Eorg.uk>:
> >> What it is not about are UART/RS232 converters connected through USB o=
r virtual
> >> serial ports created for WWAN modems (e.g. /dev/ttyACM, /dev/ttyHSO). =
Or BT devices
> >> connected through USB (even if they also run HCI protocol).
> >=20
> > It actually has to be about both because you will find the exact same
> > device wired via USB SSIC/HSIC to a USB UART or via a classic UART. Not=
 is
> > it just about embedded boards.=20
>=20
> Not necessarily.
>=20
> We often have two interface options for exactly the sam sensor chips. The=
y can be connected
> either through SPI or I2C. Which means that there is a core driver for th=
e chip and two different
> transport glue components (see e.g. iio/accel/bmc150).
>=20
> This does not require I2C to be able to handle SPI or vice versa or provi=
de a common API.

I don't understand this comparison. I2C and SPI are different
protocols, while native UART and USB-connected UART are both UART.

> And most Bluetooth devices I know have either UART or a direct
> USB interface. So in the USB case there is no need to connect
> it through some USB-UART bridge and treat it as an UART at all.

I think having support for USB-UART dongles is useful for
driver development and testing on non-embedded HW.

-- Sebastian

--l4y4f46z7f6kbxuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXu2MQAAoJENju1/PIO/qavakQAJlyQ58qfM4NAUPbFv+Z5sTn
n4ZarIrAdManP74WBeEtTLa2yD+k4+xSi9aPS9WGSk4PSt9nLcy+PLxUD58dsbAD
YQers5Ffgxwm2F/CcoyM00XsR4+9qOq7F+gq7iuDmbo5Jb8D6kyP0qVvgUL963bI
TjU/FW041++cFTFVZmwIfhGGBW/6+YblE0G9Pzt5maFghNaY4yu2Kg7FUd8G5YWM
Ap5nVwZvOFkogPpsaJHvBezDb+f0kLT5nAbqQbMD4r5U14GS0c1th6MFZroWcUkP
IQMCVpnIvT5TllbeEc1nzgKFrOG+KjkLcwaheAF7Jg57ZwXigaG73v1rB8or035B
Kgqz/8aUWEXDe7t5rCTmqzwp9atqwdKaov7gYdXiM6lqVy7VZExMFW1kajyFvirJ
D7qBY2ThwRl1O4uWgVEGCNepDo9zLh1Fvh3BESlOp0MUWjKN18Cv8HxE/7BYAeI2
Z+J/2TqHcB/ZP5PPpa7oZmRixPQGirvmjWg2Rx0XUvE2RC3tzLGc9QHVhp7WO1Lh
F+A5k5qdlqatI4EQwSV6zAS9JpvmfkLB/YUHFOyztAzjdsgZ1HZZwPNhiunSE1gO
+gNuIr/aUl/EciHow98RB/KClBu9Pw3aWRmNP0tBiE3ncCrtKP4jSe+ExLL7eqc6
Zhu/OKO128+DkqoOVS4y
=DYam
-----END PGP SIGNATURE-----

--l4y4f46z7f6kbxuw--
