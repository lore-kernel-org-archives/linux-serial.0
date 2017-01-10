From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/9] Serial slave device bus
Date: Tue, 10 Jan 2017 23:05:28 +0100
Message-ID: <20170110220528.GD2053@amd>
References: <20170106162635.19677-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170106162635.19677-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-01-06 10:26:26, Rob Herring wrote:
> Here goes another attempt at a serial device bus (aka uart slaves, tty
> slaves, etc.).
>=20
> After some discussions with Dmitry at LPC, I decided to move away from
> extending serio and moved back to making a new bus type instead. He didn't
> think using serio was a good fit, and serio has a number of peculiarities
> in regards to sysfs and it's driver model. I don't think we want to inher=
it
> those for serial slave devices.
>=20
> This version sits on top of tty_port rather than uart_port as Alan
> requested. Once I created a struct tty rather than moving everything
> needed to tty_port, it became a lot easier and less invasive to the tty
> core code.
>=20
> I have hacked up versions of the BT ldisc and TI ST drivers moved over to
> use the serdev bus. I have BT working on the HiKey board which has TI BT.
> With the serdev bus support, it eliminates the need for the TI userspace
> UIM daemon.
>=20
> This series and the mentioned drivers can be found here[1].

For what it is worth, series looks good to me.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlh1WqgACgkQMOfwapXb+vKhcgCeI3xb5lw8gVhmCRm3wAfKXa1U
RBkAoIYKHMkjTCYlzSvWjeQaJRgQkPKs
=LQF3
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
