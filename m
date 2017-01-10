From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/9] dt/bindings: Add a serial/UART attached device
 binding
Date: Tue, 10 Jan 2017 22:41:59 +0100
Message-ID: <20170110214158.GA2053@amd>
References: <20170106162635.19677-1-robh@kernel.org>
 <20170106162635.19677-7-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170106162635.19677-7-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-01-06 10:26:32, Rob Herring wrote:
> Add a common binding for describing serial/UART attached devices. Common
> examples are Bluetooth, WiFi, NFC and GPS devices.
>=20
> Serial attached devices are represented as child nodes of a UART node.
> This may need to be extended for more complex devices with multiple
> interfaces, but for the simple cases a child node is sufficient.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Looks ok to me.

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlh1VSYACgkQMOfwapXb+vKlDQCgsCrb8r3V4Kr3A+Oxnnxhz/Iv
vn8AoIhlQT4VQ+R2jll93vgdjThDgLox
=GfZG
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
