From: Pavel Machek <pavel@ucw.cz>
Subject: Re: GPS drivers (was Re: [PATCH v2 0/9] Serial slave device bus)
Date: Fri, 20 Jan 2017 21:23:59 +0100
Message-ID: <20170120202359.GB14527@amd>
References: <20170116225436.17505-1-robh@kernel.org>
 <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
 <20170120142242.GC5241@amd>
 <CACRpkdYi=OQ2fyvOvmo+8b4nAOsSjW_-EdHXyGnYf2PNZB5C9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYi=OQ2fyvOvmo+8b4nAOsSjW_-EdHXyGnYf2PNZB5C9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, NeilBrown <neil@brown.name>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> In my simple opinion GPSes shound live in drivers/iio/gps simply by
> >> usecase association: streaming out a series of accelerometer readings
> >> periodically through IIOs chardevs and other data about the physical
> >> world is not any different from the GPS usecase that give you a stream
> >> of coordinates on where on this planet you are.
> >
> > That is... not quite how GPSes work. What interface would you propose?
> > It would be good to support error estimates in position/velocities and
> > AGPS data upload.
>=20
> Sorry for my ignorance. I have not had the opportunity to work
> directly with a GPS hardware.

Few people have. It is CDMA corelators at the low level.=20

> > Now, NMEA knows about some of the complexity (not AGPS), but gets the
> > details wrong. In particular, it would be good to have error estimates
> > and velocities from the same moment you get position estimates.
>=20
> NMEA if it is this:
> https://en.wikipedia.org/wiki/NMEA_0183

Yes.

> Seems to be a high-level format such as XML or CSV or any other
> $FAVOURITE_ASCII_TRANSPORT format.
>=20
> What we want to push into the ring buffer is of course the raw data
> that is produced by the GPS hardware, whatever that may be.
> If what we have is this text format we should not reverse-translate
> it back any more than modem AT commands, it doesn't make sense
> I guess.

Umm. Its hairy. Each GPS talks slightly different version of NMEA
:-(. But yes, we have userland driver called 'gpsd' that understands
most of them. Many GPSes have additional, non-NMEA protocol you can
switch them to.

> So NMEA processing would be in userspace. And if the GPS is just
> streaming this text data over to the client, like Marcel says, it is
> more reasonable to just feed that up to userspace (no policy in the
> kernel).

Well -- we normally do hardware abstraction in the kernel :-).

> I am however aware of certain hardware such as the ST
> Microelectronis STA2062 produced for Garmin, which is *not*
> connected to any external chip, and is not talking over serial
> to any RSx port, and does not have an embedded firmware running
> on another SoC in any special GPS chip. And it is unassisted.

I googled STA2062 but it does not make much sense to me.

Yes, not everything talks NMEA. Nokia N900 is an example, and it has
in-tree driver.

> Maybe that is an oddity. In the mobile phone business I guess it
> could be more common to have a separate SoC that by way
> of standards just stream NMEA data.

Sorry, I don't understand. Yes, in mobile phones GPSes that produce
something else than NMEA are pretty common.

> Fusing that with other sensor data (accelerometer, compass, etc)
> is again indeed a userspace task. I hope NMEA includes very good
> timestamps.

Umm. Timestamps are quite hard to do over serial :-(.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliCcd8ACgkQMOfwapXb+vIYkQCglVgeV/jx3JexdznHV/uuBHLo
9dUAoK0cROBcgU3QoYfHogl7kItQ7WKf
=zV+R
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
