From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: GPS drivers (was Re: [PATCH v2 0/9] Serial slave device bus)
Date: Fri, 27 Jan 2017 21:02:22 +0100
Message-ID: <20170127200222.GF20571@amd>
References: <20170116225436.17505-1-robh@kernel.org>
 <CACRpkdaf6uy6C6J5mcVF4dDPG7gwJ2vkR4ECLYSsT5-DRNNfcA@mail.gmail.com>
 <20170120142242.GC5241@amd>
 <CACRpkdYi=OQ2fyvOvmo+8b4nAOsSjW_-EdHXyGnYf2PNZB5C9Q@mail.gmail.com>
 <1484928971.2133.273.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484928971.2133.273.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, "linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-01-20 18:16:11, Andy Shevchenko wrote:
> On Fri, 2017-01-20 at 16:26 +0100, Linus Walleij wrote:
>=20
> > > Now, NMEA knows about some of the complexity (not AGPS), but gets
> > > the
> > > details wrong. In particular, it would be good to have error
> > > estimates
> > > and velocities from the same moment you get position estimates.
> >=20
> > NMEA if it is this:
> > https://en.wikipedia.org/wiki/NMEA_0183
> >=20
> > Seems to be a high-level format such as XML or CSV or any other
> > $FAVOURITE_ASCII_TRANSPORT format.
>=20
> Not exactly. It depends on device settings.
> Old GPS I used to play with have AT command to switch between ASCII and
> binary format. Some of the devices might use non-standard binary
> protocols (however, representable as NMEA), etc.

Apparently NMEA has some serious limitations. gpsd authors have some
good docs about that.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliLp04ACgkQMOfwapXb+vJJ6QCfeLvNm8AIS/6hE+MKowxarVxh
V1sAoK0XVkZDRCEkyG1SG/EcJ9o1gKAp
=4GUX
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
