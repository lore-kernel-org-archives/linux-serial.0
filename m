From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] serial: core: Add LED trigger support
Date: Sun, 25 Dec 2016 22:20:38 +0100
Message-ID: <20161225212038.GD26891@amd>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
 <e9fc12b8-d4a7-067d-ef87-03f0aae39bd7@gmail.com>
 <20161124081748.fx3xm5ww64ngn5it@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161124081748.fx3xm5ww64ngn5it@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-serial@vger.kernel.org, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Could we somehow remedy the lack of knowledge from the core as whether
> > the HW sends/receives characters first before adding support for LED
> > triggers? It would be more generic and future proof to require UART
> > drivers to report to the core when they actually TX/RX, and then at the
> > core level, utilize that knowledge to perform the LED trigger.
>=20
> Maybe we could introduce a function to read from the TX FIFO. Having
> open coded this in each and every driver is not nice anyway.

Yes, please.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhgOCYACgkQMOfwapXb+vJWMgCfZz9Sd2cLLrB8yH+76+z42zH3
PvwAniSO0xrs/q1/XwDzzezHTt9byxM2
=l7QB
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
