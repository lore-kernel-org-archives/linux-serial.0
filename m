From: Pavel Machek <pavel@ucw.cz>
Subject: GPS drivers (was Re: [PATCH v2 0/9] Serial slave device bus)
Date: Fri, 20 Jan 2017 15:22:42 +0100
Message-ID: <20170120142242.GC5241@amd>
References: <20170116225436.17505-1-robh@kernel.org>
 <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, NeilBrown <neil@brown.name>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Switched subject: Rob's work is great for GPS and bluetooth, but this
goes beyond it.

> On Mon, Jan 16, 2017 at 11:54 PM, Rob Herring <robh@kernel.org> wrote:
>=20
> > There's still some discussion about what to do with devices that pass t=
hru
> > data to userspace unmodified like GPS and could still use tty device for
> > the data path. IMO, we should treat this as a separate problem following
> > this series. Drivers we want to convert to serdev and already in the
> > kernel don't need this functionality.
>=20
> In my simple opinion GPSes shound live in drivers/iio/gps simply by
> usecase association: streaming out a series of accelerometer readings
> periodically through IIOs chardevs and other data about the physical
> world is not any different from the GPS usecase that give you a stream
> of coordinates on where on this planet you are.

That is... not quite how GPSes work. What interface would you propose?
It would be good to support error estimates in position/velocities and
AGPS data upload.

Now, NMEA knows about some of the complexity (not AGPS), but gets the
details wrong. In particular, it would be good to have error estimates
and velocities from the same moment you get position estimates.=20

> The fact that vendors like to defer GPS processing to userspace because
> it is considered "secret sauce" is not the concern of the kernel communit=
y,
> though problems like that in general is the great tragedy of our time.
>=20
> It would be fun to see a pure, reverse-engineered GPS driver in IIO.

Well, many GPSes simply produce NMEA, and we have drivers for some other.

Here's example driver:

https://gitlab.com/tui/tui/blob/master/ofone/gps3.c

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliCHTIACgkQMOfwapXb+vKB8gCeLoxvhC7OnFqX6DyjzWiufmoh
TpYAn1pJGsd+Wdk04/HbYaoOcIt/Ltqt
=oRgW
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
